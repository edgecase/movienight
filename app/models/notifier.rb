class Notifier < ActionMailer::Base

  default :from "invites@movienightapp.com"

  def registered_member_invitation(user, night)
    header[:content_type] = 'text/html'
    @night = night
    mail :to => user.email, :subject => "You have been invited to a movie night!"
  end

  def nonmember_invitation(invitee, night)
    header[:content_type] = 'text/html'
    @night = night
    mail :to => invitee.email, :subject => "You have been invited to a movie night!"
  end

end
