defmodule ToyAppWeb.MicropostController do
  use ToyAppWeb, :controller

  alias ToyApp.Posts
  alias ToyApp.Posts.Micropost

  def index(conn, _params) do
    microposts = Posts.list_microposts()
    render(conn, :index, microposts: microposts)
  end

  def new(conn, _params) do
    changeset = Posts.change_micropost(%Micropost{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"micropost" => micropost_params}) do
    case Posts.create_micropost(micropost_params) do
      {:ok, micropost} ->
        conn
        |> put_flash(:info, "Micropost created successfully.")
        |> redirect(to: ~p"/microposts/#{micropost}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    micropost = Posts.get_micropost!(id)
    render(conn, :show, micropost: micropost)
  end

  def edit(conn, %{"id" => id}) do
    micropost = Posts.get_micropost!(id)
    changeset = Posts.change_micropost(micropost)
    render(conn, :edit, micropost: micropost, changeset: changeset)
  end

  def update(conn, %{"id" => id, "micropost" => micropost_params}) do
    micropost = Posts.get_micropost!(id)

    case Posts.update_micropost(micropost, micropost_params) do
      {:ok, micropost} ->
        conn
        |> put_flash(:info, "Micropost updated successfully.")
        |> redirect(to: ~p"/microposts/#{micropost}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, micropost: micropost, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    micropost = Posts.get_micropost!(id)
    {:ok, _micropost} = Posts.delete_micropost(micropost)

    conn
    |> put_flash(:info, "Micropost deleted successfully.")
    |> redirect(to: ~p"/microposts")
  end
end
