class AddCustomToSections < ActiveRecord::Migration
  def change
    add_column :sections, :custom, :boolean, :default => false 
  end
end
