class User < ApplicationRecord
  has_many :books, dependent: :destroy
  has_one :cart, dependent: :destroy


  has_many :sent_messages, class_name: 'Message', foreign_key: 'user_id'
  has_many :received_messages, class_name: 'Message', foreign_key: 'recipient_id'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "email", "name", "created_at", "updated_at" ]
  end

  def admin?
    self.admin == true
  end

  def inspect
    super
  end
end
