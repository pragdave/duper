defmodule Duper.PageView do
  use Duper.Views

  def image_link_to(path) do
    if is_image?(path) do
      {:safe, ~s"""
        <figure class="dup" data-path="#{path}"> 
        <img src="root#{path}"/>
        <button class="info">i</button>
        <button class="zoom">+</button>
        <figcaption>#{path}</figcaption>
        </figure>
        """
      } # "
    else
      path
    end
  end

  defp is_image?(path) do
    _is_image?(path |> String.downcase |> String.reverse)
  end

  defp _is_image?("gnp."  <> _), do: true
  defp _is_image?("gpj."  <> _), do: true
  defp _is_image?("gepj." <> _), do: true
  defp _is_image?("fig."  <> _), do: true
  defp _is_image?("2wr."  <> _), do: true
  defp _is_image?(_),            do: false
end
