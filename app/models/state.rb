class State < ActiveRecord::Base
  attr_accessible :name, :internal

  scope :not_internal, :conditions => ['internal = ? OR internal is NULL', false]
end
