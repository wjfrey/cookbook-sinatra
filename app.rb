require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'
require_relative 'cookbook'
require_relative 'recipe'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

get '/' do
  csv_file = File.join(__dir__, 'recipes.csv')
  @cookbook = Cookbook.new(csv_file)
  @recipes = @cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

post '/recipes' do
  @name = params['name']
  @description = params['description']
  csv_file = File.join(__dir__, 'recipes.csv')
  @cookbook = Cookbook.new(csv_file)
  @recipe = Recipe.new(@name, @description)
  @cookbook.add_recipe(@recipe)
  redirect '/'
end

get '/destroy' do
  csv_file = File.join(__dir__, 'recipes.csv')
  @cookbook = Cookbook.new(csv_file)
  @index = params['index'].to_i
  @cookbook.remove_recipe(@index)
  redirect '/'
end
