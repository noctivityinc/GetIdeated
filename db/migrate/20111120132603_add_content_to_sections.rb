class AddContentToSections < ActiveRecord::Migration
  def change
    add_column :sections, :content, :text
    add_column :sections, :user_id, :integer
  end
end
