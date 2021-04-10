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
      main_menu_selection(main_menu_options)
    end
  end

  # def primary_app_run

  #         system "clear"
  #         title_name(app_name)
  #         puts "Hello! \nThank you for downloading Cocktail Cache. \nUnfortunatley an error may have occured during the installation of this app that will impact it's core function. \nPlease try recloning from: https://github.com/kimckenna/cocktail_cache"
  # else
  #         system "clear"
  #         title_name(app_name)
  #         puts
  #         @user.user_run
  #         loop do
  #         system "clear"
  #         title_name(app_name)
  #         main_menu_selection(main_menu_options)
  #         end
  #     end
  # end

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
    main_menu_options = { "Random Cocktail": 1, "Favourites": 2, "Search Cocktails": 3, "Return to User Menu": 4,
                          "Exit": 5 }
    prompt.select('Make a Selection:', main_menu_options)
  end

  def main_menu_selection(menu)
    case menu
    when 1
      @random.random_run
      while @run_sub_menu
        random_cocktail_menu_selection(random_cocktail_view_menu)
        # p @user.users[@user.current_user]['favourites']
        # p @user.users
      end
    when 2
      @favourite.favourite_run(@user)
      while @run_sub_menu
      end
    when 3
      @list.list_run
      while @run_sub_menu
      end
    when 4
      @user.user_run
    when 5
      system 'clear'
      exit
    end
  end

  def load_user_data(file_path)
    json_user_data = JSON.parse(File.read(file_path))
    @user = json_user_data.map do |user|
      user.transform_keys(&:to_sym)
    end
  end

  def random_cocktail_view_menu
    prompt = TTY::Prompt.new
    cocktail_menu_options = { "Add to Favourites": 1, "Run Again": 2, "Exit to Main Menu": 3 }
    prompt.select('Make a Selection:', cocktail_menu_options)
  end

  def user_favourite_array
    @user.users[@user.current_user]['favourites']
  end

  def random_cocktail_menu_selection(selection)
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

  # def favourites_cocktail_menu_selection(cocktail_view_menu)
  # end
end
