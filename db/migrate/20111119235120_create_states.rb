class CreateStates < ActiveRecord::Migration
  def self.up
    create_table :states do |t|
      t.string :name
      t.boolean :internal
      t.timestamps
    end

    State.create({:name => "Ideation"})
    State.create({:name => "Planning"})
    State.create({:name => "Development"})
    State.create({:name => "Launched"})
    State.create({:name => "Pending"})
    State.create({:name => "Archived", :internal => true})
    State.create({:name => "Deleted", :internal => true})
  end

  def self.down
    drop_table :states
  end
end
