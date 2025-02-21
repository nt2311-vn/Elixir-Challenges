defmodule Example.Downloader do
  @behaviour Example.Worker

  def init(opts), do: {:ok, opts}

  def perform(url, opts) do
    url
    |> HTTPoison.get!()
    |> Map.fetch(:body)
    |> write_file(opts[:path])
    |> respond(opts)
  end

  defp write_file(:error, _), do: {:eror, :missing_body}

  defp respond(:ok, opts), do: {:ok, opts[:path], opts}
  defp respond({:error, reason}, opts), do: {:error, reason, opts}
end
