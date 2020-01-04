class CreatePostSubs < ActiveRecord::Migration[6.0]
  def change
    create_table :post_subs do |t|
      t.integer :post_id, null: false
      t.integer :sub_id, null: false

      t.index [:sub_id, :post_id], unique: true

      t.timestamps
    end
  end
end
