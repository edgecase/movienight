Movienight::Application.routes.draw do

  devise_for :users

  resources :nights do
    resources :invitations, :only => [:new, :create]
    member do
      put  :complete_rsvp
    end
  end

  match '/nights/:id/nonmember_rsvp/:access_hash' => 'nights#nonmember_rsvp', :as => :nonmember_rsvp_night, :via => :get

  resources :locations, :except => [:new, :show]
  resource  :schedule,  :only => :show

  resources :movies, :only => [] do
    collection do
      get :title_search
    end
  end

  root :to => "schedules#show"
end
