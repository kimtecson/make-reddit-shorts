class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.references :output, null: false, foreign_key: true
      t.datetime :publish_time
      t.string :platform

      t.timestamps
    end
  end
end
