class Book < ApplicationRecord
  belongs_to :user

  has_many :line_items, dependent: :destroy
 
  has_many :carts, through: :line_items
  

  validates :price, numericality: { greater_than_or_equal_to: 0.01 }, presence: true
  validates :description, :author, :title, presence: true
  
  has_one_attached :cover_image
  has_one_attached :book_file

  # def self.ransackable_attributes(auth_object = nil)
  #   ["id", "title", "author", "isbn", "genre", "published_date", "created_at", "updated_at", "price", "description"]
  # end

  def self.ransackable_associations(auth_object = nil)
    super + ["user", "line_items", "carts","cover_image_attachment", "cover_image_blob", "book_file_attachment", "book_file_blob"]
  end


  ransacker :total_purchases do
    # Note: This SQL counts purchases associated with the book.
    # Ensure you have a 'purchases' table with a 'book_id' foreign key.
    Arel.sql("(SELECT COUNT(*) FROM purchases WHERE purchases.book_id = books.id)")
  end

  # Allowlist the new attribute
  def self.ransackable_attributes(auth_object = nil)
    super + ["total_purchases", "user_id"]
  end

  scope :All_books, -> {all}
  scope :Mine, ->(user) { where(user_id: user.id) }
end 