class ConcertsController < ApplicationController

  use Rack::Flash

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
    if params[:band] == ""
      flash[:error] = "Please enter a band."
      redirect "/concerts/new"
    elsif params[:venue] == ""
      flash[:error] = "Please enter a venue."
      redirect "/concerts/new"
    elsif params[:date] == ""
      flash[:error] = "Please enter a date."
      redirect "/concerts/new"
    else
      @concert = current_user.concerts.create(band: params[:band], venue: params[:venue], date: params[:date])
      @concert.save
      redirect "/concerts/#{@concert.id}"
    end
  end

  get '/concerts/:id' do
    if logged_in?
      @concert = Concert.find_by_id(params[:id])
      erb :'concerts/show'
    else
      redirect "/login"
    end
  end

  get '/concerts/:id/edit' do
    if logged_in?
      @concert = Concert.find_by_id(params[:id])
      if @concert.user_id == current_user.id
       erb :'concerts/edit'
      else
        redirect to '/concerts'
      end
    else
      redirect to '/login'
    end
  end

  patch '/concerts/:id' do
    if params[:band] == ""
      flash[:error] = "Please enter a band."
      redirect "/concerts/#{params[:id]}/edit"
    elsif params[:venue] == ""
      flash[:error] = "Please enter a venue."
      redirect "/concerts/#{params[:id]}/edit"
    elsif params[:date] == ""
      flash[:error] = "Please enter a date."
      redirect "/concerts/#{params[:id]}/edit"
    else
      @concert = Concert.find_by_id(params[:id])
      @concert.band = params[:band]
      @concert.venue = params[:venue]
      @concert.date = params[:date]
      @concert.user_id = session[:user_id]
      @concert.save
      redirect "/concerts/#{@concert.id}"
    end
  end

  delete '/concerts/:id/delete' do
    if logged_in?
      @concert = Concert.find_by_id(params[:id])
      if @concert.user_id == current_user.id
        @concert.destroy
        redirect "/concerts"
      else
        redirect "/concerts"
      end
    else
      redirect "/login"
    end
  end

end
