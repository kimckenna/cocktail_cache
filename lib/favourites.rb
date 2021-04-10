require_relative 'cocktail_card_module'
require_relative 'cocktail_list'
require_relative 'cocktail_random'
require_relative 'app'

require 'json'
require 'tty-prompt'
require 'colorize'
require 'artii'

# Includes menus for Favourite feature options and utilises random_cocktail & list_cocktail for their functionality
class Favourite
  include PrintCocktail
  attr_accessor :users

  def initialize(file_path)
    @file_path = file_path
    # @user = User.new('data/users.json')
    # @app = App.new()
    @list = List.new('data/cocktails.json')
    @random = Random.new('data/cocktails.json')
    @favourites = []
    @current_user = ''
    @unfavourite = []
    @favourites_hash = {}
  end

  def favourite_run(user)
    #user_favourites_selection(user_favourites(user))
    choice_of_user(user)
  end

  def choice_of_user(user)
    @user = user.users
    @current_user = user.current_user
    if @user.length == 1
        user_favourites_options(favourites_options_menu)
      else
        user_favourites_selection(user_favourites(user))
      end
  end

  def title
    puts 'Favourites'
  end

  def user_favourites(user)
    prompt = TTY::Prompt.new
    @user = user.users
    @current_user = user.current_user
    user_options = { "#{user.current_user.capitalize}'s Favourites": 1, "Other User Favourites": 2,
                     "Return to Main Menu": 3 }
    prompt.select('Make a Selection:', user_options)
  end

  def user_favourites_selection(user_favourites)
    case user_favourites
    when 1
      user_favourites_options(favourites_options_menu)
    when 2
    when 3
      # @app.main_menu_selection(main_menu_options)
    end
  end

#   def user_favourites(user)
#     prompt = TTY::Prompt.new
#     @user = user.users
#     @current_user = user.current_user
#     user_options = { "#{user.current_user.capitalize}'s Favourites": 1, "Other User Favourites": 2,
#                      "Return to Main Menu": 3 }
#     prompt.select('Make a Selection:', user_options)
#   end

#   def user_favourites_selection(user_favourites)
#     case user_favourites
#     when 1
#       user_favourites_options(favourites_options_menu)
#     when 2
#     when 3
#       # @app.main_menu_selection(main_menu_options)
#     end
#   end

  def favourites_options_menu
    prompt = TTY::Prompt.new
    favourite_options = { "Random Favourite": 1, "View All Favourites": 2, "Favourites Management": 3, "Return to Main Menu": 4 }
    prompt.select('Make a Selection:', favourite_options)
  end

  def user_favourites_options(menu)
    case menu
    when 1
      favourites_random_name(@random.random_index_full_list(favourites_length))
      # p @random.random_index_full_list(favourites_length)
      display_favourites
    #   p @random.selected_index[-1]
    #   p user_cocktail_name(@random.selected_index[-1])
      #p @favourites_hash
      PrintCocktail.selected_cocktail_index(user_cocktail_name(@random.selected_index[-1]))
      PrintCocktail.print_cocktail_elements

      # PrintCocktail.selected_cocktail_index(search_cocktails(@cocktails_select_alcohol))
    when 2
      PrintCocktail.selected_cocktail_index(@list.search_cocktails(display_favourites))
      PrintCocktail.print_cocktail_elements
    when 3
        favourites_management
        p @unfavourite
        display_favourites
        p @favourites_hash
        #remove_from_favourites
    when 4
        # @app.main_menu_selection(main_menu_options)
    end
  end

#   def user_cocktail_index(index)
#     #system 'clear'
#     @favourites_hash.each do |name|
#       @index = @cocktails.index(cocktail) if cocktail[:name] == (input)
#     end
#     @index
#   end

  def favourites_management
    prompt = TTY::Prompt.new
    @unfavourite = prompt.multi_select('Select the Cocktail/s you wish to delete from Favourites: ', display_favourites)
  end

  def display_favourites
    favourites_hash = @user.fetch(@current_user)
    @favourites_hash = favourites_hash.fetch('favourites')
    @favourites_hash.map do |favourite|
      favourite.fetch('cocktail_name')
    end
  end

#   def remove_from_favourites
#     @favourites_hash.each do |cocktail|
#         cocktail.each do |key, value|
#             if @unfavourite.include?(key)
#                 cocktail.delete(key)
#             end
#         end
#     end
#   end

  def user_cocktail_name(index)
    display_favourites[index]
  end

  def favourites_length
    display_favourites.length - 1
  end

  def favourites_random_name(_index)
    display_favourites
  end
end

# favourite = Favourite.new('data/users.json')
# favourite.favourite_run(0)
