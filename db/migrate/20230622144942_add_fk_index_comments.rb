class AddFkIndexComments < ActiveRecord::Migration[7.0]
  def change
    add_index :comments, :author_id, unique: true, if_not_exists: true
    add_index :comments, :post_id, unique: true, if_not_exists: true
  end
end
