Movienight::Application.routes.draw do

  devise_for :users

  match '/users/friends/:friend_id/add', :to => 'users#add_friend',
                                         :as => 'add_friend'

  resources :nights do
    resources :invitations, :only       => [:create, :edit, :update],
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
