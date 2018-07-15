defmodule NLP.MessageAnalysis do
  require Logger

  def sort_text(text) do
    sentiment = text |> Google.Translate.translate |> Veritaserum.analyze

    Logger.info IO.inspect(%NLP.MessageStats{type: :question, sentiment: sentiment,match_percentage: 10.0})

    "Foi"
  end
end
