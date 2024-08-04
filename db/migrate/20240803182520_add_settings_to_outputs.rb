class AddSettingsToOutputs < ActiveRecord::Migration[7.1]
  def change
    add_column :outputs, :settings, :json
  end
end
