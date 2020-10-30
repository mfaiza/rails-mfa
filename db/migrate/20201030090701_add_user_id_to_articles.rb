class AddUserIdToArticles < ActiveRecord::Migration[6.0]
  def change
              #tableName, #fieldName, #dataType
    add_column :articles, :user_id, :int
  end
end
