class UserMailer < ApplicationMailer
    def send_meeting_email(user)
        @user = user
        @summary = user.generate_summary
        @competitors = ""
        mail(to: @user.email, subject: 'Welcome to My Awesome Site')
    end
end


#UserMailer.send_meeting_email(user).deliver_now