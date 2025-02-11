defmodule ToyAppWeb.MicropostControllerTest do
  use ToyAppWeb.ConnCase

  import ToyApp.PostsFixtures

  @create_attrs %{content: "some content", user_id: 42}
  @update_attrs %{content: "some updated content", user_id: 43}
  @invalid_attrs %{content: nil, user_id: nil}

  describe "index" do
    test "lists all microposts", %{conn: conn} do
      conn = get(conn, ~p"/microposts")
      assert html_response(conn, 200) =~ "Listing Microposts"
    end
  end

  describe "new micropost" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/microposts/new")
      assert html_response(conn, 200) =~ "New Micropost"
    end
  end

  describe "create micropost" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/microposts", micropost: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/microposts/#{id}"

      conn = get(conn, ~p"/microposts/#{id}")
      assert html_response(conn, 200) =~ "Micropost #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/microposts", micropost: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Micropost"
    end
  end

  describe "edit micropost" do
    setup [:create_micropost]

    test "renders form for editing chosen micropost", %{conn: conn, micropost: micropost} do
      conn = get(conn, ~p"/microposts/#{micropost}/edit")
      assert html_response(conn, 200) =~ "Edit Micropost"
    end
  end

  describe "update micropost" do
    setup [:create_micropost]

    test "redirects when data is valid", %{conn: conn, micropost: micropost} do
      conn = put(conn, ~p"/microposts/#{micropost}", micropost: @update_attrs)
      assert redirected_to(conn) == ~p"/microposts/#{micropost}"

      conn = get(conn, ~p"/microposts/#{micropost}")
      assert html_response(conn, 200) =~ "some updated content"
    end

    test "renders errors when data is invalid", %{conn: conn, micropost: micropost} do
      conn = put(conn, ~p"/microposts/#{micropost}", micropost: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Micropost"
    end
  end

  describe "delete micropost" do
    setup [:create_micropost]

    test "deletes chosen micropost", %{conn: conn, micropost: micropost} do
      conn = delete(conn, ~p"/microposts/#{micropost}")
      assert redirected_to(conn) == ~p"/microposts"

      assert_error_sent 404, fn ->
        get(conn, ~p"/microposts/#{micropost}")
      end
    end
  end

  defp create_micropost(_) do
    micropost = micropost_fixture()
    %{micropost: micropost}
  end
end
