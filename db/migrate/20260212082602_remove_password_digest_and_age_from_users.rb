class RemovePasswordDigestAndAgeFromUsers < ActiveRecord::Migration[8.1]
  def change
    remove_column :users, :password_digest, :string
    remove_column :users, :age, :integer
  end
end
