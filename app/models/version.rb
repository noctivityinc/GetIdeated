class Version < ActiveRecord::Base
  attr_accessible :section_id, :content, :user_id

  belongs_to :user
  belongs_to :section
end
