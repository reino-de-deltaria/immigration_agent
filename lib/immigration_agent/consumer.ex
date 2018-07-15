defmodule Consumer do
  use Coxir
  require Logger

  def handle_event({:MESSAGE_CREATE, message}, state) do
    Logger.info "Message author: #{message.author.username}, content: #{message.content}"
    case message.content do
      "ping!" -> Message.reply(message, "Ola #{message.author.username}")
      _ -> :ignore
    end

    {:ok, state}
  end

  def handle_event(_event, state) do
    {:ok, state}
  end
end
