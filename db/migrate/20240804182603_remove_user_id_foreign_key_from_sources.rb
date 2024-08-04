class RemoveUserIdForeignKeyFromSources < ActiveRecord::Migration[7.1]
  def change
      remove_foreign_key :sources, :users
      remove_index :sources, :user_id
  end
end
