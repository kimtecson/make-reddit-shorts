class RemoveUserIdFromSources < ActiveRecord::Migration[7.1]
  def change
    # Remove the foreign key constraint if it exists
    remove_foreign_key :sources, :users if foreign_key_exists?(:sources, :users)

    # Remove the user_id column from sources table
    remove_column :sources, :user_id, :integer
  end
end
