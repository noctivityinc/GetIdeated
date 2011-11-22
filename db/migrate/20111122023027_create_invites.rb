class CreateInvites < ActiveRecord::Migration
  def self.up
    create_table :invites do |t|
      t.string :email
      t.integer :user_id
      t.integer :idea_id
      t.boolean :can_edit, :default => false 
      t.string :token
      t.datetime :expires_at
      t.timestamps
    end
  end

  def self.down
    drop_table :invites
  end
end
