ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'schedules', :action => 'show'

  map.logout   '/logout',   :controller => 'sessions', :action => 'destroy'
  map.login    '/login',    :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users',    :action => 'create'
  map.signup   '/signup',   :controller => 'users',    :action => 'new'

  map.resources :locations
  map.resources :users, :has_many => :locations

  map.resources :sessions

  map.resource :schedule
  map.resources :nights, :member => { :add_invitations => :get, :send_invitations => :post, :complete_rsvp => :put },
                         :collection => { :title_search => :get }

  map.nonmember_rsvp_night "/nights/:id/nonmember_rsvp/:access_hash", 
                           :controller => 'nights', 
                           :action => 'nonmember_rsvp', 
                           :conditions => { :method => :get }
end
