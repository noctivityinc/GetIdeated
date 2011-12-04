class Version < ActiveRecord::Base
  attr_accessible :section_id, :content, :user_id

  belongs_to :user
  belongs_to :section

  default_scope order('updated_at DESC')

  scope :ordered, order("updated_at DESC")

  after_create :notify_members

  private

  def notify_members
    self.section.idea.members.each do |member|
      VersionMailer.notify(member, self).deliver if member.notification_version
    end
  end
end
