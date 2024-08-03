class RemoveFileFromSources < ActiveRecord::Migration[6.0]
  def change
    remove_column :sources, :file, :string
  end
end
