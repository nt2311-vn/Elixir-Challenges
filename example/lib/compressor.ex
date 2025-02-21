defmodule Example.Compressor do
  @behaviour Example.Worker

  def init(opts), do: {:ok, opts}

  def perform(payload, opts) do
    payload |> compress |> respond(opts)
  end

  defp compress({name, files}), do: zip.create(name, files)
  defp respond({:ok, path}, opts), do: {:ok, path, opts}
  defp respond({:error, reason}, opts), do: {:error, reason, opts}
end
