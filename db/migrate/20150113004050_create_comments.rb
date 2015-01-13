class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id, null: false
      t.integer :subject_id, null: false
      t.string :subject_type, null: false
      t.text :body, null: false

      t.timestamps null: false
    end
    add_index :comments, [:subject_id, :subject_type]
    add_index :comments, :user_id
  end
end
