class CommentMailer < ApplicationMailer
  
  def notify(member, comment, commentable, is_idea)  
    @comment = comment
    @member = member
    @commentable = commentable
    @is_idea = is_idea

    mail(:to => member.user.email, :subject => "#{@comment.user.name} just posted a comment about #{member.idea.name}", :tag => 'comment-notify')  
  end  
end
