defmodule ToyApp.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ToyApp.Posts` context.
  """

  @doc """
  Generate a micropost.
  """
  def micropost_fixture(attrs \\ %{}) do
    {:ok, micropost} =
      attrs
      |> Enum.into(%{
        content: "some content",
        user_id: 42
      })
      |> ToyApp.Posts.create_micropost()

    micropost
  end
end
