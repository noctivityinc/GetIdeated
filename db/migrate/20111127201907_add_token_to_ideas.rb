class AddTokenToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :token, :string

    Idea.all.each do |x|
      x.update_attribute(:token, SecureRandom.hex(4))
    end
  end
end
