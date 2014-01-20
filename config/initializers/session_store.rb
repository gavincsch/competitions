# Be sure to restart your server when you modify this file.

#Blair::Application.config.session_store :cookie_store, key: '_blair_session'
Blair::Application.config.session_store :active_record_store , key: '_blair_session'
