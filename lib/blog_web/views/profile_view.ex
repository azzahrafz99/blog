defmodule BlogWeb.ProfileView do
  use BlogWeb, :view

  def join_date(date) do
    Timex.format!(date, "%B %Y", :strftime)
  end

  def description(text) do
    "#{String.slice(text, 0..300)}"
  end

  def markdown(body) do
    body
    |> Earmark.as_html!
    |> raw
  end
end
