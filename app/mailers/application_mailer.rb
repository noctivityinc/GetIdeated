class ApplicationMailer < ActionMailer::Base
  default :from => "status@getideated.com"  
  layout 'layouts/mailer'
  helper :layout

end