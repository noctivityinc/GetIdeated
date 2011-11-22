class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.integer :user_id
      t.integer :idea_id
      t.boolean :can_edit, :default => false 
      t.boolean :notification_version, :default => true 
      t.boolean :notification_comment, :default => true 
      t.boolean :weekly_status, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end
