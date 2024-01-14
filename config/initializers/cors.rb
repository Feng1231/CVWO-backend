# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order
# to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
    # url = Rails.env == 'production' ? 'https://discum-forum.netlify.app' : 'http://localhost:3001'
    url = 'https://discum-forum.netlify.app'
    allowed_methods = %i[get options head]
    allow do
      origins url

      resource '/change_password', headers: :any, methods: %i[patch]
      resource '/sign_up', headers: :any, methods: %i[post]
      resource '/logged_in', headers: :any, methods: %i[get]
      resource '/log_in', headers: :any, methods: %i[post]
      resource '/logout', headers: :any, methods: %i[patch]
      resource '/category', headers: :any, methods: %i[get post]
      resource '/category/*', headers: :any, methods: %i[get patch delete]
      resource '/post', headers: :any, methods: %i[post]
      resource '/post/*', headers: :any, methods: %i[get patch delete]
      resource '/post/pin_post', headers: :any, methods: %i[patch]
      resource '/comment', headers: :any, methods: %i[post]
      resource '/comment/*', headers: :any, methods: %i[get patch delete]
      resource '/retrieve', headers: :any, methods: %i[get]
      resource '/sign_up/:id', headers: :any, methods: %i[delete]

      resource '*', headers: :any, methods: allowed_methods, credentials: false
    end
  end