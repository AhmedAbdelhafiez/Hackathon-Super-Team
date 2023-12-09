class UserMailer < ApplicationMailer

    def send_meeting_email(user)
        unless user.nil?
            @user = user
            @summary = user.generate_summary
            @competitors = ""
            mail(to: @user.email, subject: 'Welcome to TrianglZ!')
        end
    end
end


#UserMailer.send_meeting_email(user).deliver_now