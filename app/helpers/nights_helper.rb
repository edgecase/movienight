module NightsHelper

  def invitee_name_or_email(invitation)
    if invitation.invitee.try(:name).present?
      invitation.invitee.name
    else
      invitation.invitee.try(:email)
    end
  end

  def show_voteable_movies?(night)
    night.movie.blank? && night.voteable_movies.any?
  end

  def voting_state_class(night)
    unless night.movie
      "undecided"
    end
  end

  def cast_vote_class(voteable_movie)
    night = voteable_movie.night
    if voteable_movie.voters.include? current_user
      'i_choose_you_pikachu'
    elsif night.voters.include? current_user
      'do_not_want'
    end
  end

end
