defmodule Google.Goth do
  def get_token do
    Goth.Token.for_scope("https://www.googleapis.com/auth/cloud-platform")
  end
end
