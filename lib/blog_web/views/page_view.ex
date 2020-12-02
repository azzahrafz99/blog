defmodule BlogWeb.PageView do
  use BlogWeb, :view

  def description(text) do
    text = String.split(text, "\n")
    text = Enum.map(text, fn(t) ->
      String.strip(t)
      |> String.replace(~r/<img[\ \']([^\ \']+)/, "")
      |> String.replace(~r/alt=[\"\']([^\\']+)/, "")
      |> String.strip()
    end)
    text = URI.decode(Enum.join(text, ""))

    "#{String.slice(text, 0..100)}"
  end

  def has_image?(text) do
    text =~ "<img"
  end

  def thumbnail(text) do
    img = Regex.scan(~r/src=[\"\']([^\"\']+)/, text)
    Enum.at(Enum.at(img, 0), 1)
  end

  def markdown(body) do
    body
    |> Earmark.as_html!
    |> raw
  end
end
