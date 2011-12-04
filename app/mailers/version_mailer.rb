class VersionMailer < ApplicationMailer

  def notify(member, version)  
    @version = version
    @member = member

    mail(:to => member.user.email, :subject => "#{version.user.name} updated the #{version.section.name} for #{version.section.idea.name}", :tag => 'version-notify')  
  end  
end
