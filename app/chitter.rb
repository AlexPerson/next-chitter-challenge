require 'sinatra/base'
require_relative 'data_mapper_setup.rb'
require 'sinatra/flash'

class Chitter < Sinatra::Base

	enable :sessions
	register Sinatra::Flash

	helpers do
		def current_user
			@current_user ||= User.get(session[:user_id])
		end
	end

  get '/' do
    'Hello Chitter!'
    erb :index
  end

  get '/users/new' do
  	@user = User.new
  	erb :'users/new'
  end

  post '/users' do
  	@user = User.new(username: params[:username],
  							name: params[:name],
  							email: params[:email],
  							password: params[:password],
  							password_confirmation: params[:password_confirmation])
  	if @user.save
  		session[:user_id] = @user.id
  		redirect to('/')
  	else
  		flash.now[:notice] = 'Password and confirmation password do not match'
  		erb :'users/new'
  	end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
