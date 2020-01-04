class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url
      t.string :content
      t.integer :author_id, null: false

      t.index :author_id

      t.timestamps
    end
  end
end
