class BlairMailer < ActionMailer::Base

  default :from => "Serina <serina.app@gmail.com>",
          :reply_to => 'serina.app@gmail.com'

  def new_user_invite(user, password)
    @user = user
    @password = password
    mail to: @user.email , subject: "Your Login Details..."
  end
end