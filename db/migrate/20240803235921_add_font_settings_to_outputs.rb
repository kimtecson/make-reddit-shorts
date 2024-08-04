class AddFontSettingsToOutputs < ActiveRecord::Migration[7.1]
  def change
    add_column :outputs, :font_border_color, :string
    add_column :outputs, :font_color, :string
    add_column :outputs, :font_border_width, :integer
  end
end
