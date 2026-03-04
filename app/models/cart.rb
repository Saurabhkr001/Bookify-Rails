class Cart < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy

  #increase quantity if book exists
  def add_book(book)
    current_item = line_items.find_by(book_id: book.id)

    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(book_id: book.id, price: book.price, quantity: 1)
    end
    current_item
  end

  def total_price
    line_items.sum { |item| item.price * item.quantity }
  end
end