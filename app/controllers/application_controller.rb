require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    if logged_in?
      erb :'/concerts/show'
    else
      erb :index
    end
  end

  helpers do
     def logged_in?
       !!session[:user_id]
     end
     
     def current_user
       User.find(session[:user_id])
     end
   end

end
