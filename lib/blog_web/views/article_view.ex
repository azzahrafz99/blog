defmodule BlogWeb.ArticleView do
  use BlogWeb, :view
  use Timex

  def markdown(body) do
    body
    |> Earmark.as_html!
    |> raw
  end

  def format_date(date) do
    Timex.format!(date, "%B %d, %Y", :strftime)
  end

end
