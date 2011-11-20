class Idea < ActiveRecord::Base
  attr_accessible :name, :user_id, :state_id, :description

  belongs_to :user
  has_many :sections

  after_create :create_sections

  def state
    State.find(self.state_id).name
  end

  private

  def create_sections
    self.sections.create({:name => "Vision", :position => 1})
    self.sections.create({:name => "Mission", :position => 2})
    self.sections.create({:name => "Objectives", :position => 3})
    self.sections.create({:name => "Strategies", :position => 4})
    self.sections.create({:name => "Plans", :position => 5})
  end
end
