class Notifier < ActionMailer::Base

  default :from    => "invites@movienightapp.com",
          :subject => "You have been invited to a movie night!"

  def night_invitation(invitation)
    headers[:content_type] = 'text/html'
    @night, @invitee = invitation.night, invitation.invitee
    mail :to => invitation.email
  end

end
