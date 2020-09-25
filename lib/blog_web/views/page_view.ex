defmodule BlogWeb.PageView do
  use BlogWeb, :view

  def description(text) do
    "#{String.slice(text, 0..100)}"
  end

  def markdown(body) do
    body
    |> Earmark.as_html!
    |> raw
  end
end
