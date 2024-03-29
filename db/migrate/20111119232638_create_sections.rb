class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|
      t.string :name
      t.integer :idea_id
      t.string :description
      t.boolean :locked
      t.timestamps
    end
  end

  def self.down
    drop_table :sections
  end
end
