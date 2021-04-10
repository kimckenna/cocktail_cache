require_relative 'favourites'
require 'json'
require 'tty-prompt'
require 'colorize'

# class InvalidUserSelection < StandardError
# end
# Responsible for management of users.json - users and favourites
class User
  attr_accessor :users, :add_favourite
  attr_reader :current_user, :current_user_favourites, :unfavourite

  def initialize(file_path)
    @file_path = file_path
    load_user_data(file_path)
    @favourite = Favourite.new('data/cocktails.json')
    @current_user = ''
    @add_favourite = {}
    @current_user_favourites = []
    @unfavourite = []
    @font_block = TTY::Font.new(:block)
  end

  def user_run
    system 'clear'
    @current_user = ''
    @current_user_favourites = []
    title_name(app_name)
    puts
    welcome
    user_type_menu
    puts

    File.write(@file_path, @users.to_json)
  end

  def title_name(name)
    title = name.split(' ')
    title.each do |word|
      print @font_block.write(word)
    end
    puts
  end
  
  def app_name
    'Cocktail Cache'
  end

  def welcome
    puts 'Welcome!'
    puts
  end

  def user_type_menu
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
    add_user(@current_user)
  end

  def add_favourite(_user, cocktail_index)
    @add_favourite =  @current_user_favourites << {
      'cocktail_name'=> PrintCocktail.selected_cocktail_name(cocktail_index), 'favourite'=> true
    }
    File.write(@file_path, @users.to_json)
    p @current_user_favourites
  end

  def check_cocktail_name(index)
    PrintCocktail.selected_cocktail_name(index)
  end

  def file_write
    File.write(@file_path, @users.to_json)
  end

  def existing_user_options
    prompt = TTY::Prompt.new
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
  end
end
