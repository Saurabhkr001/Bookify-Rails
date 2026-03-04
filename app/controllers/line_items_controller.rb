class LineItemsController < ApplicationController
  def create
    # Find the book
    book = Book.find(params[:book_id])

    # Find or create the cart for the logged-in user
    @cart = current_user.cart || current_user.create_cart

    # Use the model logic to add the book
    line_item = @cart.add_book(book)

    if line_item.save
      redirect_to cart_path, notice: "Added #{book.title} to cart."
    else
      redirect_to books_path, alert: "Could not add book."
    end
  end

  def destroy
    # Find the line item and remove it
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    redirect_to cart_path, notice: "Item removed from cart."
  end
  
    def update
    @line_item = LineItem.find(params[:id])

    # Check which button was clicked via the URL parameter
    if params[:quantity] == 'increase'
      @line_item.quantity += 1
      
    elsif params[:quantity] == 'decrease'
      if @line_item.quantity > 1
        @line_item.quantity -= 1
      else
        # If quantity is 1 and user clicks '-', remove the item entirely
        @line_item.destroy
        redirect_to cart_path, notice: "Item removed from cart."
        return # Stop execution here so we don't try to save a deleted item
      end
    end

    if @line_item.save
      redirect_to cart_path, notice: "Cart updated."
    else
      redirect_to cart_path, alert: "Failed to update cart."
    end
  end
end