defmodule NLP.MessageStats do
  defstruct text: "",
            type: :question,
            sentiment: 0,
            longest_tokens: 0,
            most_frequent_tokens: [],
            token_count: 0,
            token_density: [],
            uniq_token_count: [],
            average_chars_per_token: 0.0
end
