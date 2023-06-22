class AddFkIndexPosts < ActiveRecord::Migration[7.0]
  def change
    add_index :posts, :author_id, unique: true, if_not_exists: true
  end
end
