require 'bundler/setup'
require 'sinatra'
require "sinatra/reloader"
require_relative 'jobs'
require_relative 'models'

get '/' do
  @current_page = :home
  erb :index, layout: :layout
end

get '/submit' do
  @current_page = :submit
  erb :submit, layout: :layout
end

get '/status' do
  @current_page = :status
  @source_codes = SourceCode.order(created_at: :desc).limit(20)
  erb :status, layout: :layout
end

get '/ranklist' do
  @current_page = :ranklist
  @ranklist = SourceCode.select("user_id, sum(points) as total_points").group("user_id").order("total_points DESC").all
  erb :ranklist, layout: :layout
end

post '/do_submit' do
  source_code = SourceCode.create!(user: user, status: SourceCode::WAITING, points: -1)
  Sneakers::Publisher.new.publish(params.merge(source_code_id: source_code.id).to_json, to_queue: :grade_source)
  redirect to('/submit')
end

helpers do
  def navigation_class(page_name)
    @current_page == page_name ? 'active' : ''
  end
end

def user
  User.find_or_create_by(name: params['name'])
end
