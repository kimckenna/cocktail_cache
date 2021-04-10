# user menu
require_relative 'user'
# app menu outputs
require_relative 'cocktail_random'
require_relative 'cocktail_list'
require_relative 'favourites'
# gems
require 'json'
require 'tty-prompt'
require 'colorize'
require 'artii'

# users = User.new('data/users.json')

class App
  attr_accessor :users

  def initialize(file_path)
    @file_path = file_path
    @user = User.new('data/users.json')
    @random = Random.new('data/cocktails.json')
    @list = List.new('data/cocktails.json')
    @favourite = Favourite.new('data/users.json')
    @run_sub_menu = true
    @font_block = TTY::Font.new(:block)
    # load_users
  end

  def primary_app_run
    system 'clear'
    title_name(app_name)
    puts
    @user.user_run
    loop do
      # system "clear" add back in once able to add secondary menu to search and favourites
      title_name(app_name)
      favourites_exist_check
      # main_menu_selection(main_menu_options)
    end
  end

#   def font_block
#     font_block = TTY::Font.new(:block)
#   end

  def title_name(app_name)
    title = app_name.split(' ')
    title.each do |word|
      # print font_dotmatrix.asciify(word)
      print @font_block.write(word)
    end
  end

  def app_name
    'Cocktail Cache'
  end

  def main_menu_options
    prompt = TTY::Prompt.new
    main_menu_options = { "Random Cocktail": 1, "Favourites": 2, "Search Cocktails": 3, "Return to User Menu": 4, "Exit": 5 }
    prompt.select('Make a Selection:', main_menu_options)
  end

  def main_menu_disabled
    prompt = TTY::Prompt.new
    main_menu_options = [
      {name: "Random Cocktail", value: 1}, 
      {name: "Favourites", value: 2, disabled: "   (You don't currently have any favourites)"}, 
      {name: "Search Cocktails", value: 3}, 
      {name: "Return to User Menu", value: 4}, 
      {name: "Exit", value: 5}
    ]
    prompt.select('Make a Selection:', main_menu_options)
  end


  def favourites_exist_check
    p @user.current_user
    p @user.current_user_favourites
    if @user.current_user_favourites.empty?
      main_menu_selection(main_menu_disabled)
    else 
      main_menu_selection(main_menu_options)
    end
  end

  def main_menu_selection(menu)
    case menu
    when 1
      @random.random_run
      while @run_sub_menu
        random_sub_options(sub_menu('Run Again'))
      end
      @run_sub_menu = true
      p @run_sub_menu
    when 2
        @favourite.favourite_run(@user)
        @user.file_write
      while @run_sub_menu
        fav_sub_options(fav_sub_menu)
      end
      @run_sub_menu = true
    when 3
      @list.list_run
      while @run_sub_menu
        list_sub_options(sub_menu('Return to Search Menu'))
      end
      @run_sub_menu = true
    when 4
      @user.user_run
    when 5
      system 'clear'
      exit
    end
  end

  def load_user_data(file_path)
    json_user_data = JSON.parse(File.read(file_path))
    @user = json_user_data
  end

  def sub_menu(input)
    prompt = TTY::Prompt.new
    options = { "Add to Favourites": 1, "#{input}": 2, "Exit to Main Menu": 3 }
    prompt.select('Make a Selection:', options)
  end

  def user_favourite_array
    @user.users[@user.current_user]['favourites']
  end

  def random_sub_options(selection)
    case selection
    when 1
      # @favourite.favourite_cocktail(user_favourite_array, 1)
      @user.add_favourite(user_favourite_array, @random.selected_index[-1])
    when 2
      system 'clear'
      @random.random_run
    when 3

      @random.clear_selected_index
      # main_menu_selection(main_menu_options)
      p @random.selected_index
      @run_sub_menu = false
    end
  end

  def list_sub_options(selection)
    case selection
    when 1
      # @favourite.favourite_cocktail(user_favourite_array, 1)
      @user.add_favourite(user_favourite_array, @list.selected_index_list[-1])
    when 2
      system 'clear'
      @list.list_run
    when 3
      # main_menu_selection(main_menu_options)
      @run_sub_menu = false
    end
  end

  def fav_sub_menu
    prompt = TTY::Prompt.new
    options = { "Return to Favourites Menu": 1, "Exit to Main Menu": 2 }
    prompt.select('Make a Selection:', options)
  end

  def fav_sub_options(selection)
    case selection
    when 1
      system 'clear'
      title_name(fav_sub_title)
      @favourite.favourite_run(@user)
      @user.file_write
    when 2
      @run_sub_menu = false
    end
  end

  def fav_sub_title
    "Favourites"
  end

end
