class AddTitleTextToOutput < ActiveRecord::Migration[7.1]
  def change
    add_column :outputs, :title_text, :string
  end
end
