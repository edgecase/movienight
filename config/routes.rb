Movienight::Application.routes.draw do

  devise_for :users

  resources :nights do
    resources :invitations, :except => [:index, :show, :destroy], :path_names => { :edit => 'confirm' }
  end

  resources :locations, :except => [:new, :show]

  resources :movies, :only => [] do
    collection do
      get :title_search
    end
  end

  root :to => "nights#index"
end
