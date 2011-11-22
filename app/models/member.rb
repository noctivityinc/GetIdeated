class Member < ActiveRecord::Base
  attr_accessible :user_id, :idea_id, :can_edit, :notification_version, :notification_comment, :weekly_status 

  belongs_to :idea
  belongs_to :user

  def is_owner?
    return self.user.own_ideas.find_by_id(self.idea_id)
  end

  def status
    if self.is_owner?
      "Owner"
    elsif self.can_edit
      "Member"
    else
      "Viewer"
    end
  end

end
