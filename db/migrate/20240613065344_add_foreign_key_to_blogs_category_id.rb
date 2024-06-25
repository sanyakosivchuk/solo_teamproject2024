class AddForeignKeyToBlogsCategoryId < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :blogs, :categories
    add_index :blogs, :category_id
  end
end
