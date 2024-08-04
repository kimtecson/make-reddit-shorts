class DropBatchesTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :batches
  end

  def down
    create_table :batches do |t|
      t.integer :source_id, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false

      t.index :source_id
    end

    add_foreign_key :batches, :sources
  end
end
