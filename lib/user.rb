require_relative 'favourites'
require 'json'
require 'tty-prompt'
require 'colorize'

# Responsible for management of users.json - users and favourites
class User
  attr_accessor :users, :add_favourite_cocktail
  attr_reader :current_user, :current_user_favourites, :unfavourite

  def initialize(file_path)
    @file_path = file_path
    load_user_data(file_path)
    @favourite = Favourite.new('data/cocktails.json')
    @current_user = ''
    @add_favourite_cocktail = {}
    @current_user_favourites = []
    @unfavourite = []
    @font_block = TTY::Font.new(:block)
    @prompt = TTY::Prompt.new(help_color: :cyan)
  end

  def user_run
    system 'clear'
    @current_user = ''
    @current_user_favourites = []
    title_name(app_name)
    puts
    #welcome
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
    user_type = { "New User": 1, "Existing User": 2 }
    @prompt.select('Make a Selection:', user_type)
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
    username_exists(username, rand_number)
  end

  def display_input_user_name
    puts "\nPlease chose a new username: (this will be used to identify your favourites)"
  end

  def username
    gets.strip.downcase
  end

  def add_user(user)
    @users[user] = { 'favourites' => [] }
  end

  def username_exists(input, num)
    if @users.include?(input)
        puts "That username is taken, some possible alternatives are:"
        puts "\n   #{input}#{num},   #{input}_#{rand_letter}\n\n"
        create_new_user
    else
        @current_user = (input)
        add_user(@current_user)
        @current_user_favourites = @users[current_user]['favourites']
    end
  end 

  def rand_number
    rand(10..1000) 
  end

  def rand_letter
    ('a'..'z').to_a.sample
  end

  def add_favourite(_user, cocktail_index)
    @add_favourite_cocktail =  @current_user_favourites << {
      'cocktail_name'=> PrintCocktail.selected_cocktail_name(cocktail_index), 'favourite'=> true
    }
    File.write(@file_path, @users.to_json)
    @current_user_favourites
  end

  def check_cocktail_name(index)
    PrintCocktail.selected_cocktail_name(index)
  end

  def file_write
    File.write(@file_path, @users.to_json)
  end

  def existing_user_options
    @current_user = @prompt.select('Select from Existing Users:', @users.keys, filter: true)
    @current_user_favourites = @users[current_user]['favourites']
    @current_user
  end

  def existing_user_index(existing_user_options)
    @users[existing_user_options]
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
  rescue JSON::ParserError
    File.open(file_path, 'w+')
    File.write(file_path, {})
    retry
  end
end

# user = User.new('data/users.json')

# user.user_run