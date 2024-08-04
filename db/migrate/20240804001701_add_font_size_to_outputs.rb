class AddFontSizeToOutputs < ActiveRecord::Migration[7.1]
  def change
    add_column :outputs, :font_size, :integer
  end
end
