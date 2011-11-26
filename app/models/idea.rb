class Idea < ActiveRecord::Base
  attr_accessible :name, :user_id, :state_id, :description

  belongs_to :user
  has_many :sections, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy 
  has_many :members, :dependent => :destroy 
  has_many :invites, :dependent => :destroy 

  after_create :create_sections, :add_as_member

  def state
    State.find(self.state_id).name
  end

  def owner
    self.members.detect {|x| x.is_owner?}.user
  end

  private

  def create_sections
    self.sections.create({:name => "Vision", :position => 1, :description => "The WHAT. The vision is a short, easy to understand statement that should describe your idealized perception of what your business will look to others."})
    self.sections.create({:name => "Mission", :position => 2, :description => "The HOW.  The mission defines the purpose of the venture.  What your business will do, it's market niche, growth plans, unique value prop"})
    self.sections.create({:name => "Objectives", :position => 3, :description => "The GOALS.  What are you trying to accomplish.  Goals are typically a bulleted list of measurable items (e.g. Earn revenues of $X by Y)."})
    self.sections.create({:name => "Strategies", :position => 4, :description => "This is typically a bulletted list of high level strategies you will engage in to reach your objectives."})
    self.sections.create({:name => "Plans", :position => 5, :description => "What specific plans will need to be performed to accomplish your strategies and reach your goals? (e.g. Hire 10 people, Close 5 accounts by Q3, Build a prototype by Aug, etc)."})
  end

  def add_as_member
    self.members.create({:user_id => self.user_id, :can_edit => true})
  end
end
