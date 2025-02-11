defmodule ToyApp.PostsTest do
  use ToyApp.DataCase

  alias ToyApp.Posts

  describe "microposts" do
    alias ToyApp.Posts.Micropost

    import ToyApp.PostsFixtures

    @invalid_attrs %{content: nil, user_id: nil}

    test "list_microposts/0 returns all microposts" do
      micropost = micropost_fixture()
      assert Posts.list_microposts() == [micropost]
    end

    test "get_micropost!/1 returns the micropost with given id" do
      micropost = micropost_fixture()
      assert Posts.get_micropost!(micropost.id) == micropost
    end

    test "create_micropost/1 with valid data creates a micropost" do
      valid_attrs = %{content: "some content", user_id: 42}

      assert {:ok, %Micropost{} = micropost} = Posts.create_micropost(valid_attrs)
      assert micropost.content == "some content"
      assert micropost.user_id == 42
    end

    test "create_micropost/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_micropost(@invalid_attrs)
    end

    test "update_micropost/2 with valid data updates the micropost" do
      micropost = micropost_fixture()
      update_attrs = %{content: "some updated content", user_id: 43}

      assert {:ok, %Micropost{} = micropost} = Posts.update_micropost(micropost, update_attrs)
      assert micropost.content == "some updated content"
      assert micropost.user_id == 43
    end

    test "update_micropost/2 with invalid data returns error changeset" do
      micropost = micropost_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_micropost(micropost, @invalid_attrs)
      assert micropost == Posts.get_micropost!(micropost.id)
    end

    test "delete_micropost/1 deletes the micropost" do
      micropost = micropost_fixture()
      assert {:ok, %Micropost{}} = Posts.delete_micropost(micropost)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_micropost!(micropost.id) end
    end

    test "change_micropost/1 returns a micropost changeset" do
      micropost = micropost_fixture()
      assert %Ecto.Changeset{} = Posts.change_micropost(micropost)
    end
  end
end
