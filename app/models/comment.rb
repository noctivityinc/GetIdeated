class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true 
  belongs_to :user

  validates_presence_of :content

  default_scope order('created_at DESC')

  after_create :notify_members

  private

  def notify_members
    klass = self.commentable_type.constantize
    commentable = klass.find(self.commentable_id)
    if(klass.name == "Idea") 
        is_idea = true
        idea = commentable
    else
        is_idea = false
        idea = commentable.idea rescue nil    # assume that the commented idea belongs to an idea
    end

    if idea
      idea.members.each do |member|
        CommentMailer.notify(member, self, commentable, is_idea).deliver if member.notification_comment
      end
    end
  end
end
