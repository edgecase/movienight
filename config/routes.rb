ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'schedules', :action => 'index'

  map.logout   '/logout',   :controller => 'sessions', :action => 'destroy'
  map.login    '/login',    :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users',    :action => 'create'
  map.signup   '/signup',   :controller => 'users',    :action => 'new'
  map.resources :users
  map.resources :session

  map.resources :schedules
  map.resources :nights

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
