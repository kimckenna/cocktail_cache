require_relative 'app'
require 'json'
require 'tty-prompt'
require 'colorize'

# class InvalidUserSelection < StandardError
# end

class User
  attr_accessor :users, :add_favourite
  attr_reader :current_user, :current_user_favourites

  def initialize(file_path)
    @file_path = file_path
    load_user_data(file_path)
    @current_user = ''
    @add_favourite = {}
    @current_user_favourites = []
  end

  def user_run
    puts
    welcome
    user_type_menu
    puts

    File.write(@file_path, @users.to_json)
  end

  def welcome
    puts 'Welcome!'
    puts
  end

  def user_type_menu
    # p @users.empty?
    if @users.empty?
      create_new_user
    else
      user_type_selection(user_type)
    end
  end

  def user_type
    prompt = TTY::Prompt.new
    user_type = { "New User": 1, "Existing User": 2 }
    prompt.select('Make a Selection:', user_type)
  end

  def user_type_selection(user_type)
    case user_type
    when 1
      create_new_user
    when 2
      existing_user_options
    end
  end

  def create_new_user
    puts display_input_user_name
    @current_user = user_name
    #@current_user_favourites = @users[current_user]['favourites']
    add_user(@current_user)
    # user_index = new_user_name_index
    # puts user_index
  end

  def add_favourite(_user, cocktail_index)
    # @current_user_favourites = @users[current_user]['favourites']
    @add_favourite =  @current_user_favourites << {
      'cocktail_name'=> PrintCocktail.selected_cocktail_name(cocktail_index), 'favourite'=> true
    }
    File.write(@file_path, @users.to_json)
    p @current_user_favourites
  end

#   def add_favourite(_user, cocktail_index)
#     @add_favourite = @users[current_user]['favourites'] << PrintCocktail.selected_cocktail_name(cocktail_index)
#     File.write(@file_path, @users.to_json)
#   end

  def existing_user_options
    prompt = TTY::Prompt.new
    # user_options = @users.map do |user, index|
    #     { name: user[:user], value: index }
    # end
    @current_user = prompt.select('Select from Existing Users:', @users.keys, filter: true)
    @current_user_favourites = @users[current_user]['favourites']
    @current_user
  end

  def existing_user_index(existing_user_options)
    @users[existing_user_options]
  end

  def display_input_user_name
    puts 'Enter your name'
  end

  def user_name
    gets.strip.downcase
  end

  def add_user(user_name)
    @users[user_name] = { 'favourites' => [] }
  end

  def new_user_index
    @users[total_users - 1]
  end

  def total_users
    @users.length
  end

  # Error handling required for incorrect input
  # currently displaying selected_user_name

  def menu_selection
    gets.to_i
  end

  def load_user_data(file_path)
    json_user_data = JSON.parse(File.read(file_path))
    @users = json_user_data
    # @users = json_user_data.map do |user|
    #     user.transform_keys(&:to_sym)
    # end
    # p @users
  end
end
