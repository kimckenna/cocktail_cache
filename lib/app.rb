# user menu
require_relative 'user'
# app menu outputs
require_relative 'cocktail_random'
require_relative 'cocktail_list'
require_relative 'favourites'
require_relative 'welcome'
# gems
require 'json'
require 'tty-prompt'
require 'colorize'
require 'pastel'
# require 'artii'

# Central class of app - runs other class menus and holds sub menu for favourites, list and random. Passes info from user to other menus
class App
  include Welcome
  attr_accessor :users

  def initialize(file_path)
    @file_path = file_path
    @user = User.new('data/users.json')
    @random = Random.new('data/cocktails.json')
    @list = List.new('data/cocktails.json')
    @favourite = Favourite.new('data/users.json')
    @run_sub_menu = true
    @font_block = TTY::Font.new(:block)
    @already_favourite = false
    @prompt = TTY::Prompt.new(help_color: :cyan)
    @pastel = Pastel.new
  end

  def run
    if ARGV.empty?
      system 'clear'
      primary_app_run
    else
      argv_run
    end
  end

  def pastel_check
    @pastel.cyan('Hello')
  end

  def argv_run
    first, *other = ARGV
    ARGV.clear
    case first
    when 'user', 'u'
      system 'clear'
      @user.user_run
      @user.file_write
      loop do
        system 'clear'
        title_name(app_name)
        favourites_exist_check
      end
    when 'existing user', 'eu'
      system 'clear'
      title_name(app_name)
      @user.existing_user_options
      @user.file_write
      loop do
        system 'clear'
        title_name(app_name)
        favourites_exist_check
      end
    when 'random', 'r'
      system 'clear'
      @random.random_run
    when 'fav', 'f'
      system 'clear'
      title_name(app_name)
      @user.existing_user_options
      unless @user.current_user_favourites.empty?
        system 'clear'
        title_name(fav_title)
        @favourite.favourite_run(@user)
        @user.file_write
      else
        puts "User has no favourites"
      end
    when 'search', 's'
      system 'clear'
      title_name(search_title)
      puts
      @list.list_run
    when 'help', 'h'
      system 'clear'
      argv_help
    else
      puts "Invalid Argument: use 'help' for valid arguments\n\n"
    end
  end

  def argv_help
    title_name(help)
    puts "Valid Arguments\n\n"
    puts "   Run Cocktail Cache at User Selection: 'user' or 'u'\n\n   Run Cocktail Cache at Existing User Selection: 'existing user' or 'eu'\n\n   View Random Cocktail: 'random' or 'r'\n\n   Search Cocktails: 'search' or 's'\n\n   Search a Users Favourites: 'fav' or 'f'\n\n" 
    puts "      * note you will be taken to select a user first.\n     ** if user has no favourites you will need to reuse the 'fav' or 'f' argument.\n\n"
    puts "   Full functionality of Cocktail Cache requires username selection.\n"
    puts "   As a result, unless using 'user'('u') or 'existing user'('eu') the app will terminate once a cocktail is populated.\n\n"
    puts "Set Up:\n\n"
    puts "   To run: ./cocktail_cache.sh\n\n   To install: ./install.sh\n\n"
    puts "      *  Cocktail Cache was built using Ruby version 2.7.2 and will require Ruby installation to run.\n\n"
    puts "Menu Navigation:\n\n"
    puts "   All menus include navigation instructions before any keys are pressed.\n\n   All allow you to scroll with keyboard arrows ↑/↓/←/→ and require you to press enter to confirm your selection.\n\n"
    puts "   If you are using a search funtion e.g. Select from Existing Users or Search all Cocktails:\n   Filter is enabled. Start typing, press enter to confirm your selection or arrow keys ↑/↓ to navigate filtered list.\n\n"
    puts "   Menus with multi selection can select all using Ctrl+Shift+A\n\n   If menu selection is disabled, relevant message will advise why.\n\n"
    puts "Best of Luck and Enjoy!\n\n"
  end 
  def primary_app_run
    system 'clear'
    Welcome.welcome_run
    enter_site(slide_enter)
    loop do
      system 'clear'
      title_name(app_name)
      favourites_exist_check
    end
  end

  def title_name(name)
    title = name.split(' ')
    title.each do |word|
      print @font_block.write(word)
    end
    puts
  end

  def help
    'Help is Here'
  end

  def app_name
    'Cocktail Cache'
  end

  def fav_title
    'Favourites'
  end

  def search_title
    'Cocktail Search'
  end

  def slide_enter
    slider_format = ->(slider, value) { "|#{slider}| #{value.zero? ? '' : 'Enter'}" % value }
    @prompt.slider('Slide on in!', max: 1, step: 1, default: 0, format: slider_format)
  end

  def enter_site(selection)
    case selection
    when 1
      #system 'clear'
      @user.user_run
    end
  end

  def main_menu_options
    main_menu_options = { "Random Cocktail": 1, "Favourites": 2, "Search Cocktails": 3, "Return to User Menu": 4,
                          "Exit": 5 }
    @prompt.select('Make a Selection:', main_menu_options)
  end

  def main_menu_disabled
    main_menu_options = [
      { name: 'Random Cocktail', value: 1 },
      { name: 'Favourites', value: 2, disabled: "   (You don't currently have any favourites)" },
      { name: 'Search Cocktails', value: 3 },
      { name: 'Return to User Menu', value: 4 },
      { name: 'Exit', value: 5 }
    ]
    @prompt.select('Make a Selection:', main_menu_options)
  end

  def favourites_exist_check
    @user.current_user
    @user.current_user_favourites
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
        check_cocktail_already_favourite(@user.check_cocktail_name(@random.selected_index[-1]))
        
        check_cocktail_menu_random('Run Again')
      end
      @run_sub_menu = true
    when 2
      system 'clear'
      title_name(fav_title)
      puts
      @favourite.favourite_run(@user)
      @user.file_write
      while @run_sub_menu
        if @user.current_user_favourites.empty?
          @run_sub_menu = false
        else
          fav_sub_options(fav_sub_menu)
        end
      end
      @run_sub_menu = true
    when 3
      system 'clear'
      title_name(search_title)
      puts
      @list.list_run
      while @run_sub_menu
        check_cocktail_already_favourite(@user.check_cocktail_name(@list.selected_index_list[-1]))
        check_cocktail_menu_list('Search Again')
      end
      @run_sub_menu = true
    when 4
      @user.file_write
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

  def check_cocktail_already_favourite(cocktail)
    puts
    @user.current_user_favourites.each do |hash|
      @already_favourite = true if hash.value?(cocktail) == true
    end
  end

  def check_cocktail_menu_list(input)
    if @already_favourite == true
      list_sub_options(sub_menu_disabled(input))
      @already_favourite = false
    else
      list_sub_options(sub_menu(input))
    end
  end

  def check_cocktail_menu_random(input)
    if @already_favourite == true
      random_sub_options(sub_menu_disabled(input))
      @already_favourite = false
    else
      random_sub_options(sub_menu(input))
    end
  end

  def sub_menu(input)
    puts
    options = { "Add to Favourites": 1, "#{input}": 2, "Exit to Main Menu": 3 }
    @prompt.select('Make a Selection:', options)
  end

  def sub_menu_disabled(input)
    puts
    options = [
      { name: 'Add to Favourites', value: 1, disabled: '   (This cocktail is already favourited)' },
      { name: input.to_s, value: 2 },
      { name: 'Exit to Main Menu', value: 3 }
    ]
    @prompt.select('Make a Selection:', options)
  end

  def user_favourite_array
    @user.users[@user.current_user]['favourites']
  end

  def random_sub_options(selection)
    case selection
    when 1
      @user.add_favourite(user_favourite_array, @random.selected_index[-1])
      @user.file_write
    when 2
      system 'clear'
      @random.random_run
    when 3
      @random.clear_selected_index
      @run_sub_menu = false
    end
  end

  def list_sub_options(selection)
    case selection
    when 1
      @user.add_favourite(user_favourite_array, @list.selected_index_list[-1])
      @user.file_write
    when 2
      system 'clear'
      title_name(search_title)
      puts
      @list.list_run
    when 3
      @run_sub_menu = false
    end
  end

  def fav_sub_menu
    puts
    options = { "Return to Favourites Menu": 1, "Exit to Main Menu": 2 }
    @prompt.select('Make a Selection:', options)
  end

  def fav_sub_options(selection)
    case selection
    when 1
      system 'clear'
      title_name(fav_title)
      @favourite.favourite_run(@user)
      @user.file_write
    when 2
      @run_sub_menu = false
    end
  end
end
