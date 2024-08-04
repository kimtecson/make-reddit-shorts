class AddSubtitlePresetsToOutputs < ActiveRecord::Migration[7.1]
  def change
    add_column :outputs, :subtitle_preset, :string
  end
end
