Movienight::Application.routes.draw do

  devise_for :users

  resources :nights do
    resources :invitations, :except => [:index, :show, :destroy]
  end

  resources :locations, :except => [:new, :show]
  resource  :schedule,  :only   => :show

  resources :movies, :only => [] do
    collection do
      get :title_search
    end
  end

  root :to => "schedules#show"
end
