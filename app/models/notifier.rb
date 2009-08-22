class Notifier < ActionMailer::Base
  
  def registered_member_invitiation(user, night)
    subject "You have been invited to a movie night!"
    recipients user.email
    from "bill_gates@microsoft.com"
    content_type 'text/html'
    body :night => night
  end

  def nonmember_invitation(invitee, night)
    subject "You have been invited to a movie night!"
    recipients invitee.email
    from "bill_gates@microsoft.com"
    content_type 'text/html'
    body :invitee => invitee, :night => night
  end

end
