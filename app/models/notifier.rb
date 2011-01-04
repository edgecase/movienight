class Notifier < ActionMailer::Base

  default :from    => "invites@movienightapp.com",
          :subject => "You have been invited to a movie night!"

  def registered_member_invitation(invitation)
    headers[:content_type] = 'text/html'
    @night = invitation.night
    mail :to => invitation.email
  end

  def nonmember_invitation(invitation)
    headers[:content_type] = 'text/html'
    @invitation, @night = invitation, invitation.night
    mail :to => invitation.email
  end

end
