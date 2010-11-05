class Notifier < ActionMailer::Base

  default :from    => "invites@movienightapp.com",
          :subject => "You have been invited to a movie night!"

  def registered_member_invitation(user, night)
    headers[:content_type] = 'text/html'
    @user, @night = user, night
    mail :to => user.email
  end

  def nonmember_invitation(invitee, night)
    headers[:content_type] = 'text/html'
    @invitee, @night = invitee, night
    mail :to => invitee.email
  end

end
