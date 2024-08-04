class AddColorToOutputs < ActiveRecord::Migration[7.1]
  def change
    add_column :outputs, :color, :string
  end
end
