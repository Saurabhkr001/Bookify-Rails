class LineItem < ApplicationRecord
  belongs_to :cart
  belongs_to :book

  #calculate price for this specific line
  def total_price
    price * quantity
  end

    # Allowlist the new attribute
  def self.ransackable_attributes(auth_object = nil)
    ["book_id", "cart_id", "created_at", "id", "id_value", "updated_at", "price", "quantity"]
  end
end
