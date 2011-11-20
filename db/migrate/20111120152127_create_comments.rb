class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :user_id
      t.references :commentable, :polymorphic => true 

      t.timestamps
    end
    add_index :comments, :commentable_id
  end
end
