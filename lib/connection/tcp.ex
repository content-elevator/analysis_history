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

  def start_link(host, port, queue, opts \\ [], timeout \\ 5000) do
    Connection.start_link(__MODULE__, {host, port, queue, opts, timeout})
  end

  def init({host, port, queue, opts, timeout}) do
    TCPConnection.Worker.start_link(self(), queue)

    state = %{host: host, port: port, opts: opts, timeout: timeout, sock: nil}
    {:connect, :init, state}
  end
end