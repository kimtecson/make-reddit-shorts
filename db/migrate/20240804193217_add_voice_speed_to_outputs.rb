class AddVoiceSpeedToOutputs < ActiveRecord::Migration[7.1]
  def change
    add_column :outputs, :voice_speed, :string
  end
end
