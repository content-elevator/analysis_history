defmodule TCPConnection do

  use Connection

  def start_link(host, port, queue, opts \\ [], timeout \\ 5000) do
    Connection.start_link(__MODULE__, {host, port, queue, opts, timeout})
  end

  def send(conn, data), do: Connection.call(conn, {:send, data})

  def recv(conn, bytes, timeout \\ 3000) do
    Connection.call(conn, {:recv, bytes, timeout})
  end

  def close(conn), do: Connection.call(conn, :close)

  def init({host, port, queue, opts, timeout}) do
    TCPConnection.Worker.start_link(self(), queue)

    state = %{host: host, port: port, opts: opts, timeout: timeout, sock: nil}
    {:connect, :init, state}
  end

  def connect(_, %{sock: nil, host: host, port: port, opts: opts,
    timeout: timeout} = s) do
    case :gen_tcp.connect(host, port, [active: false] ++ opts, timeout) do
      {:ok, sock} ->
        {:ok, %{s | sock: sock}}
      {:error, _} ->
        {:backoff, 1000, s}
    end
  end

  def disconnect(info, %{sock: sock} = s) do
    :ok = :gen_tcp.close(sock)
    case info do
      {:close, from} ->
        Connection.reply(from, :ok)
      {:error, :closed} ->
        :error_logger.format("Connection closed~n", [])
      {:error, reason} ->
        reason = :inet.format_error(reason)
        :error_logger.format("Connection error: ~s~n", [reason])
    end
    {:connect, :reconnect, %{s | sock: nil}}
  end

  def handle_call(_, _, %{sock: nil} = s) do
    {:reply, {:error, :closed}, s}
  end
  def handle_call({:send, data}, _, %{sock: sock} = s) do
    case :gen_tcp.send(sock, data) do
      :ok ->
        {:reply, :ok, s}
      {:error, _} = error ->
        {:disconnect, error, error, s}
    end
  end
  def handle_call({:recv, bytes, timeout}, _, %{sock: sock} = s) do
    case :gen_tcp.recv(sock, bytes, timeout) do
      {:ok, _} = ok ->
        {:reply, ok, s}
      {:error, :timeout} = timeout ->
        {:reply, timeout, s}
      {:error, _} = error ->
        {:disconnect, error, error, s}
    end
  end
  def handle_call(:close, from, s) do
    {:disconnect, {:close, from}, s}
  end
end


defmodule TCPConnection.Worker do
  @moduledoc """
  Worker that reads log messages from a BlockingQueue and writes them to
  Logstash using a TCP connection.
  """

  def start_link(conn, queue) do
    spawn_link(fn -> consume_messages(conn, queue) end)
  end

  defp consume_messages(conn, queue) do
    msg = BlockingQueue.pop(queue)
    TCPConnection.send(conn, msg)
    consume_messages(conn, queue)
  end
end