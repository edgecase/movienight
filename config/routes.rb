Movienight::Application.routes.draw do
  resources :nights do
    resources :invitations, :only => [:new, :create]
    member do
      put  :complete_rsvp
    end
  end

  devise_for :users

  match '/register' => 'users#create', :as => :register
  match '/signup'   => 'users#new',    :as => :signup

  resources :locations
  resource  :schedule

  resources :movies, :only => [] do
    collection do
      get :title_search
    end
  end

  root :to => "schedules#show"

  match '/nights/:id/nonmember_rsvp/:access_hash' => 'nights#nonmember_rsvp', :as => :nonmember_rsvp_night, :via => :get
end
