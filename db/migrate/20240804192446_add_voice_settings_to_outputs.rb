class AddVoiceSettingsToOutputs < ActiveRecord::Migration[7.1]
  def change
    add_column :outputs, :voice_preset, :string
  end
end
