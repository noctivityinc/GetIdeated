class Section < ActiveRecord::Base
  # attr_accessor :minor, :name, :idea_id, :description, :locked, :content, :user_id
  attr_accessor :minor

  default_scope order('position ASC')

  belongs_to :idea
  belongs_to :user
  has_many :versions
  has_many :comments, :as => :commentable

  after_save :update_versions

  private

  def update_versions
    if self.minor == '1'
      self.versions.last.update_attributes(:content => self.content)
    else
      version = self.versions.new
      version.content = self.content
      version.user_id = self.user_id
      version.save
    end
  end

end
