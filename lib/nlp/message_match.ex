defmodule NLP.MessageMatch do
  @correction 16.666666666666668

  defstruct text: "",
            expecting: "",
            type: 0.0,
            distance: 0,
            sentiment: 0.0,
            longest_tokens: 0.0,
            most_frequent_tokens: 0.0,
            token_count: 0.0,
            token_density: 0.0,
            uniq_token_count: 0.0,
            average_chars_per_token: 0.0

  def match(expecting, text) do
    c = compare(expecting, text)

    match = (
      c.average_chars_per_token +
      c.sentiment +
      c.token_count +
      c.token_density +
      c.type +
      c.uniq_token_count)/6

    distance = c.distance + c.longest_tokens + c.most_frequent_tokens

    {(distance + match)/2 - @correction, %{
      expecting: c.expecting,
      text: c.text
    }}
  end

  def compare(expecting, text) do
    %NLP.MessageMatch{
      text: text.text,
      expecting: expecting.text,
      type: compare_similarity(expecting.type, text.type),
      sentiment: compare_diference(expecting.sentiment, text.sentiment),
      distance: Gibran.Levenshtein.distance(expecting.text, text.text),
      longest_tokens: compare_distance(expecting.longest_tokens, text.longest_tokens),
      most_frequent_tokens: compare_some(expecting.most_frequent_tokens, text.most_frequent_tokens),
      token_count: compare_diference(expecting.token_count, text.token_count),
      token_density: compare_some(expecting.token_density, text.token_density),
      uniq_token_count: compare_diference(expecting.uniq_token_count, text.uniq_token_count),
      average_chars_per_token: compare_diference(expecting.average_chars_per_token, text.average_chars_per_token)
    }
  end

  def compare_similarity(expecting, text) do
    cond do
      expecting == text -> 100.0
      true -> 0.0
    end
  end

  def compare_diference(expecting, text) do
    cond do
      expecting == 0 -> abs ((text - 1)/1)*100.0
      true -> abs ((text - expecting)/expecting)*100.0
    end
  end

  def compare_distance(expecting, text) do
    expecting_str = expecting |> List.first
    text_str = text |> List.first

    Gibran.Levenshtein.distance(elem(expecting_str, 0), elem(text_str, 0))
  end

  def compare_some(expecting, text) do
    expecting_list = Enum.map(expecting, fn {k, v} -> v end)
    text_list = Enum.map(text, fn {k, v} -> v end)

    compare_diference(List.first(expecting_list), List.first(text_list))
  end
end
