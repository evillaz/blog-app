class AddFkIndexLikes < ActiveRecord::Migration[7.0]
  def change
    add_index :likes, :author_id, unique: true, if_not_exists: true
    add_index :likes, :post_id, unique: false, if_not_exists: true
  end
end
