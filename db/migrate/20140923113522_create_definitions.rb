class CreateDefinitions < ActiveRecord::Migration
  def change
    create_table :definitions do |t|
      t.string :content
      t.integer :word_id

      t.timestamps
    end
    add_index :definitions, [:word_id, :created_at]
  end
end
