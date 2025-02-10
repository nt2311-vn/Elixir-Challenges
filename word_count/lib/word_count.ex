defmodule WordCount do
  def start do
    word_count =
      File.stream!("book-war-and-peace.txt")
      |> Stream.flat_map(&split_words/1)
      |> Enum.count()

    IO.puts("There are total of #{word_count} words in war an peace masterpiece\n")
  end

  def split_words(line) do
    line |> String.split(~r/\W+/, trim: true)
  end
end
