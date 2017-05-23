class UsersController < ApplicationController

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/user_concerts'
  end

  get '/signup' do
    if !logged_in?
      erb :'users/new', locals: {message: "You cannot log in without first signing up"}
    else
      redirect "/concerts"
    end
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect "/concerts"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect "/concerts"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/concerts"
    else
      redirect "/signup"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end

end
