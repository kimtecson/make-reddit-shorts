class AddProgressToOutputs < ActiveRecord::Migration[7.1]
  def change
    add_column :outputs, :progress, :integer
  end
end
