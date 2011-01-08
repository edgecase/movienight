Movienight::Application.routes.draw do

  devise_for :users

  resources :nights do
    resources :invitations, :except     => [:index, :show, :destroy],
                            :path_names => { :edit => 'confirm' }
  end

  resources :voteable_movies, :only => [] do
    resources :votes, :only => :create
  end

  resources :locations, :except => [:new, :show]

  resources :movies, :only => [] do
    collection do
      get :title_search
    end
  end

  root :to => "nights#index"
end
