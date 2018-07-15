defmodule Google.Translate do
  alias GoogleApi.Translate.V2.Api.Translations
  alias GoogleApi.Translate.V2.Connection

  def connection do
    {:ok, token} = Google.Goth.get_token
    Connection.new(token.token)
  end

  def translate(text) do
    {:ok, response} = Translations.language_translations_list(connection, text, "en")
    translation = response.translations |> List.first

    translation.translatedText
  end
end
