class InviteMailer < ApplicationMailer
  default from: "invites@getideated.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invite_mailer.invite.subject
  #
  def invite(invite)
    @invite = invite
    mail(:to => invite.email, :subject => "#{@invite.user.name} has invited you to the \"#{invite.idea.name}\" idea", :tag => 'invite')  
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invite_mailer.accepted.subject
  #
  def accepted(invite, user)
    @invite = invite
    @user = user
    mail(:to => invite.user.email, :subject => "#{@user.name} has accepted your invitation to the \"#{invite.idea.name}\" idea", :tag => 'invite-accepted')  
  end
end
