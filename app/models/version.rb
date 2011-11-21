class Version < ActiveRecord::Base
  attr_accessible :section_id, :content, :user_id

  belongs_to :user
  belongs_to :section

  default_scope order('updated_at DESC')

  scope :ordered, order("updated_at DESC")
end
