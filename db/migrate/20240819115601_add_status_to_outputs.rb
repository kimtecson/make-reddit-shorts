class AddStatusToOutputs < ActiveRecord::Migration[7.1]
  def change
    add_column :outputs, :status, :string, default: 'pending'
  end
end
