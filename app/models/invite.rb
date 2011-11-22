class Invite < ActiveRecord::Base
  attr_accessible :email, :user_id, :idea_id, :can_edit, :token, :expires_at

  before_create :set_token_and_expires

  validates_presence_of :email, :user_id, :idea_id
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates_uniqueness_of :email, :scope => :idea_id, :message => "has already been invited"
  validate :not_a_member

  belongs_to :user
  belongs_to :idea

  scope :not_expired, :conditions => ['expires_at > ?', Date.today]
  scope :expired, :conditions => ['expires_at <= ?', Date.today]

  private

  def set_token_and_expires
    self.token = SecureRandom.hex(10)
    self.expires_at = 2.weeks.from_now
  end

  def not_a_member
    errors.add(:email, 'is already a member of this idea') if 
    self.idea.members.detect {|x| x.user.email.downcase == self.email.downcase}
  end
end
