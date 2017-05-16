require './config/environment'

class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/concerts'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    if params[:username] != "" || params[:email] != "" || params[:password] != ""
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/concerts'
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/concerts'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/concerts'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if !logged_in?
      erb :logout
    else
      session.destroy
      redirect to '/login'
    end
  end

end
