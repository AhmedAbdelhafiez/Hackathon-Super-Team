class UserMailer < ApplicationMailer
    def welcome_email(user)
        @user = user
        mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    end
end


#UserMailer.welcome_email(user).deliver_now