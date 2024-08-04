class RemoveBatchIdFromOutputs < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :outputs, :batches
    remove_index :outputs, :batch_id
    remove_column :outputs, :batch_id
  end
end
