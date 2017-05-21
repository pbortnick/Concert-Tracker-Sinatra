require './config/environment'

class ConcertsController < ApplicationController

  get '/concerts' do
    if logged_in?
      @concerts = Concert.all
      erb :'/concerts/index'
    else
      redirect "/login"
    end
  end

  get '/concerts/new' do
    if logged_in?
      erb :'concerts/new'
    else
      redirect "/login"
    end
  end

  post '/concerts' do
    if params[:band] == "" || params[:venue] == "" || params[:date] == ""
      redirect "/concerts/new"
    else
      @concert = current_user.concerts.create(band: params[:band], venue: params[:venue], date: params[:date])
      @concert.save
      redirect "/concerts/#{@concert.id}"
    end
  end

  get '/concerts/:id' do
    if logged_in?
      @concert = Concert.find(params[:id])
      erb :'concerts/show'
    else
      redirect "/login"
    end
  end

  get '/concerts/:id/edit' do
    if logged_in?
      @concert = Concert.find(params[:id])
      erb :'concerts/edit'
    else
      redirect "/login"
    end
  end

  patch '/concerts/:id' do
    @concert = Concert.find(params[:id])
    if params[:band] == "" || params[:venue] == "" || params[:date] == ""
      redirect "/concerts/#{concert.id}/edit"
    else
      @concert.update(band: params[:band], venue: params[:venue], date: params[:date])
      @concert.user_id = session[:user_id]
      @concert.save
      redirect "/concerts/#{@concert.id}"
    end
  end

  delete '/concerts/:id/delee' do
    @concert = Concert.find(params[:id])
    if @concert.user_id == current_user.id
      @concert.destroy
      redirect "/concerts"
    else
      redirect "/concerts"
    end
  end

end
