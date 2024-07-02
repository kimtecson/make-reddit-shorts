class CreateBatches < ActiveRecord::Migration[7.1]
  def change
    create_table :batches do |t|
      t.references :source, null: false, foreign_key: true

      t.timestamps
    end
  end
end
