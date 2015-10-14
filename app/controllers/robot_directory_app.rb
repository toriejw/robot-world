require_relative '../models/robot_directory'

class RobotDirectoryApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true

  get '/' do
    erb :dashboard
  end

  get '/robots' do
    @robots = RobotDirectory.all
    erb :index
  end

  get '/robots/new' do
    erb :new
  end

  post '/robots' do
    RobotDirectory.add(params[:robot])
    redirect '/robots'
  end

  get '/robots/:id' do |id|
    @robot = RobotDirectory.find(id.to_i)
    erb :view
  end

  get '/robots/:id/edit' do |id|
    @robot = RobotDirectory.find(id.to_i)
    erb :edit
  end

  put '/robots/:id' do |id|
    RobotDirectory.update(id.to_i, params[:robot])
    redirect '/robots'
  end

  delete '/robots/:id' do |id|
    RobotDirectory.delete(id.to_i)
    redirect '/robots'
  end
end
