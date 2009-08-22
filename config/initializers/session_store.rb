# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_movienight_session',
  :secret      => '8ae23e3ac90a7ebc1e09d44e3a02bb4a4df4174ff616577c7d15cf70da005e6c2ba1250b84b23444e85062ae7f89b4b40c60e4c1ee66232f370552b5c6a45570'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
