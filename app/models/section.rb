class Section < ActiveRecord::Base
  # attr_accessor :minor, :name, :idea_id, :description, :locked, :content, :user_id
  attr_accessor :minor

  default_scope order('position ASC')

  belongs_to :idea
  belongs_to :user
  has_many :versions, :dependent => :destroy
  has_many :comments, :as => :commentable, :dependent => :destroy

  validates_presence_of :name, :description  

  before_save :check_position
  after_update :update_versions

  private

  def check_position
    unless self.position
      max_position = self.idea.sections.maximum(:position)
      self.position = max_position + 1
    end
  end

  def update_versions
    if self.content_changed? || self.versions.empty?
      if self.minor == '1' && !self.versions.empty?
        self.versions.ordered.first.update_attributes(:content => self.content)
      else
        version = self.versions.new
        version.content = self.content
        version.user_id = self.user_id
        version.save
      end
    end
  end

end
