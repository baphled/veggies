# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_stories_session',
  :secret      => 'f84f669006349f239a9f90e5e196e3eaddefce1824aaaf661bb21004bbfe9bed4a84e06fa922f868bdde8d7f2570171bcfcc493dbfbfb8fd4bd61a242dd3f62c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
