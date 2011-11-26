class MemberMailer < ActionMailer::Base
 default from: "invites@getideated.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invite_mailer.invite.subject
  #
  def added(member)
    @member = member
    mail(:to => member.user.email, :subject => "You are now a member of the \"#{member.idea.name}\" idea", :tag => 'member-added')  
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.member_mailer.removed.subject
  #
  def removed(member)
    return unless member.idea.owner         # => prevents sending when idea is deleted

    @member = member
    mail(:to => member.user.email, :subject => "You have been removed from the \"#{member.idea.name}\" idea", :tag => 'member-removed')  
  end
end
