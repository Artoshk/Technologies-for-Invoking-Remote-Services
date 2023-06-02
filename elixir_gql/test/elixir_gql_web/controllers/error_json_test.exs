defmodule ElixirGqlWeb.ErrorJSONTest do
  use ElixirGqlWeb.ConnCase, async: true

  test "renders 404" do
    assert ElixirGqlWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert ElixirGqlWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
