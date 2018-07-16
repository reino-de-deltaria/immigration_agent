defmodule NLP.MessageAnalysis do
  require Logger
  alias Gibran.Counter
  alias Gibran.Tokeniser

  def sort_text(text) do
    sentiment = text |> Google.Translate.translate |> Veritaserum.analyze
    text = String.downcase(text)
    tokenised = Tokeniser.tokenise(text)

    %NLP.MessageStats{
      text: text,
      type: semantics(text),
      sentiment: sentiment,
      longest_tokens: Counter.longest_tokens(tokenised),
      most_frequent_tokens: Counter.most_frequent_tokens(tokenised),
      token_count: Counter.token_count(tokenised),
      token_density: Counter.token_density(tokenised),
      uniq_token_count: Counter.uniq_token_count(tokenised),
      average_chars_per_token: Counter.average_chars_per_token(tokenised)
    }
  end

  def semantics(text) do
    cond do
      String.match?(text, ~r/.*\!$|.*porque((?!\?).)*$/) -> :interjection
      String.match?(text, ~r/^(?=.*\bpor\b)(?=.*\bque\b).*$|^como.*|^(?=.*\btem\b)(?=.*\bcomo\b).*$|.*\?$/) -> :question
      String.match?(text, ~r/valeu|obrigado|agradecido/) -> :greetings
      true -> :undetermined
    end
  end

  def match_array(text) do
    tenses = [
      "como eu consigo a minha cidadania?",
      "como eu viro cidadão de deltária?",
      "o que é cidadania?",
      "que merda é essa?",
    ]

    Enum.sort(Enum.map(tenses, fn tense -> NLP.MessageMatch.match(sort_text(tense), sort_text(text)) end))
  end
end
