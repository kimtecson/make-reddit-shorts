class AddFileToSources < ActiveRecord::Migration[7.1]
  def change
    add_column :sources, :file, :string
  end
end
