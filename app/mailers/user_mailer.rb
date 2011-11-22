class UserMailer < ActionMailer::Base
  default :from => "status@getideated.com"  
  
  def welcome(user)  
    @user = user
    mail(:to => user.email, :subject => "Welcome to GetIdeated.com", :tag => 'user-welcome')  
  end  
end
