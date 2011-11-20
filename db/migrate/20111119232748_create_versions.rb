class CreateVersions < ActiveRecord::Migration
  def self.up
    create_table :versions do |t|
      t.integer :section_id
      t.text :content
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :versions
  end
end
