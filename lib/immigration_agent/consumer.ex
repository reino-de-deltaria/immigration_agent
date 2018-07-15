defmodule ImmigrationAgent.Consumer do
  use Coxir
  require Logger

  def handle_event({:MESSAGE_CREATE, message}, state) do
    Logger.info "Message author: #{message.author.username}, content: #{message.content}"

    case message.content do
      "Como consigo minha essa grande cidadania?" -> Message.reply(message, NLP.MessageAnalysis.sort_text(message.content))
      _ -> :ignore
    end

    {:ok, state}
  end

  def handle_event(_event, state) do
    {:ok, state}
  end
end
