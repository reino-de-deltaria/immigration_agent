defmodule NLP.MessageAnalysis do
  require Logger
  alias Gibran.Counter
  alias Gibran.Tokeniser

  def sort_text(text) do
    sentiment = text |> Google.Translate.translate |> Veritaserum.analyze
    tokenised = Tokeniser.tokenise(text)

    IO.inspect %NLP.MessageStats{
      type: semantics(text),
      sentiment: sentiment,
      match_percentage: 0,
      longest_tokens: Counter.longest_tokens(tokenised),
      most_frequent_tokens: Counter.most_frequent_tokens(tokenised),
      token_count: Counter.token_count(tokenised),
      token_density: Counter.token_density(tokenised),
      uniq_token_count: Counter.uniq_token_count(tokenised),
      average_chars_per_token: Counter.average_chars_per_token(tokenised)
    }

    "Ola"
  end

  def semantics(text) do
    text = String.downcase(text)

    cond do
      String.match?(text, ~r/.*\!$|.*porque((?!\?).)*$/) -> :interjection
      String.match?(text, ~r/^(?=.*\bpor\b)(?=.*\bque\b).*$|^como.*|^(?=.*\btem\b)(?=.*\bcomo\b).*$|.*\?$/) -> :question
      String.match?(text, ~r/valeu|obrigado|agradecido/) -> :greetings
      true -> :undetermined
    end
  end
end
