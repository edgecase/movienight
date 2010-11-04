module NightsHelper

  def invitee_name_or_email(invitation)
    if invitation.invitee.try(:name).present?
      invitation.invitee.name
    else
      invitation.invitee.try(:email)
    end
  end

end
