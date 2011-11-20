class Section < ActiveRecord::Base
  attr_accessible :name, :idea_id, :description, :locked

  default_scope order('position ASC')

  belongs_to :idea
  has_many :versions
end
