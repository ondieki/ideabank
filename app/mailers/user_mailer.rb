class UserMailer < ActionMailer::Base
  default from: "bavin2009@gmail.com"


  def welcome_email(user)
  	@user = user
	@url = 'localhost:3000/user/login'
	mail(to: @user.email, reply_to: "bavin2009@gmail.com", subject: 'Welcome to Idea Bank')
  end
end


