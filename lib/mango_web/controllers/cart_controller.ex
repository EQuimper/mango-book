defmodule MangoWeb.CartController do
  use MangoWeb, :controller

  alias Mango.Sales

  def add(conn, %{"cart" => cart_params}) do
    cart = conn.assigns.cart

    case Sales.add_to_cart(cart, cart_params) do
      {:ok, cart} ->
        render(conn, "add.json", cart: cart, cart_params: cart_params)
      {:error, _} ->
        conn
        |> put_flash(:info, "Error adding product to cart")
        |> redirect(to: page_path(conn, :inded))
    end
  end

  def show(conn, _params) do
    cart = conn.assigns.cart
    cart_changeset = Sales.change_cart(cart)
    render conn, "show.html", cart: cart, cart_changeset: cart_changeset
  end

  def update(conn, %{"order" => cart_params}) do
    cart = conn.assigns.cart
    case Sales.update_cart(cart, cart_params) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Cart updated suscessfully")
        |> redirect(to: cart_path(conn, :show))
      {:error, _} ->
        conn
        |> put_flash(:info, "Error, updating cart")
        |> redirect(to: cart_path(conn, :show))
    end
  end
end
