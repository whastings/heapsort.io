# Be sure to restart your server when you modify this file.

require File.join(Rails.root,'lib','openshift_secret_generator.rb')

WebDevBookmarks::Application.config.session_store :cookie_store, key: initialize_secret(
  :session_store,
  '_railsapp_session'
)
