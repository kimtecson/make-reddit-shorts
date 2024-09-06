class AddJobIdToOutputs < ActiveRecord::Migration[7.1]
  def change
    add_column :outputs, :job_id, :string
  end
end
