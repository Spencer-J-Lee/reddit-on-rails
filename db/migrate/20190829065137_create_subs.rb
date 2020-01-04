class CreateSubs < ActiveRecord::Migration[6.0]
  def change
    create_table :subs do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.integer :mod_id, null: false

      t.index :mod_id
      
      t.timestamps
    end
  end
end
