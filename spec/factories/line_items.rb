FactoryBot.define do
  factory :line_item do
    cart { nil }
    book { nil }
    quantity { 1 }
    price { "9.99" }
  end
end
