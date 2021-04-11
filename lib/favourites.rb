require_relative 'cocktail_card_module'
require_relative 'cocktail_list'
require_relative 'cocktail_random'

# Includes menus for Favourite feature options and utilises random_cocktail & list_cocktail for their functionality
class Favourite
  include PrintCocktail
  attr_accessor :users

  def initialize(file_path)
    @file_path = file_path
    @list = List.new('data/cocktails.json')
    @random = Random.new('data/cocktails.json')
    @favourites = []
    @current_user = ''
  end

  def favourite_run(user)
    # KEEP : change to choice of user when have option to view other users favourites
    # choice_of_user(user)
    user_favourites_options(favourites_options_menu(user))
  end

  def title
    puts 'Favourites'
  end

  def display_favourites
    p @current_user_favourites
    @current_user_favourites.map do |favourite|
      favourite.fetch('cocktail_name')
    end
  end

  def favourites_management
    prompt = TTY::Prompt.new
    @unfavourite = prompt.multi_select('Select the Cocktail/s you wish to delete from Favourites: ', display_favourites)
  end

  def remove_from_favourites
    @unfavourite.each do |cocktail|
      @current_user_favourites.each do |hash|
        hash.each_value do |value|
          if value == cocktail
            @current_user_favourites.delete(hash)
            # @current_user_favourites
          end
        end
      end
    end
  end

  def favourites_options_menu(user)
    @user = user.users
    @current_user = user.current_user
    @current_user_favourites = user.current_user_favourites
    prompt = TTY::Prompt.new
    favourite_options = { "Random Favourite": 1, "View All Favourites": 2, "Favourites Management": 3 }
    prompt.select('Make a Selection:', favourite_options)
  end

  def user_favourites_options(menu)
    case menu
    when 1
      favourites_random_name(@random.random_index_full_list(favourites_length))
      # @display_favourites
      PrintCocktail.selected_cocktail_index(user_cocktail_name(@random.selected_index[-1]))
      PrintCocktail.print_cocktail_elements
    when 2
      PrintCocktail.selected_cocktail_index(@list.search_cocktails(display_favourites))
      PrintCocktail.print_cocktail_elements
    when 3
      favourites_management
      display_favourites
      remove_from_favourites
      @current_user_favourites
    end
  end

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

# FOR USE WHEN ADDING VISIBILITY OF OTHER USER FAVOURITES
# KEEP : Conditional if only one user - use when implement option to view other users faves
#   def choice_of_user(user)
#     @user = user.users
#     @current_user = user.current_user
#     @current_user_favourites = user.current_user_favourites
#     if @user.length == 1
#         user_favourites_options(favourites_options_menu)
#       else
#         user_favourites_selection(user_favourites(user))
#       end
#   end

# KEEP : Menu option when able to implement other users viewing options
#   def user_favourites(user)
#     prompt = TTY::Prompt.new
#     #@user = user.users
#     user_options = { "#{user.current_user.capitalize}'s Favourites": 1, "Other User Favourites": 2, "Return to Main Menu": 3}
#     prompt.select('Make a Selection:', user_options)
#   end

#   def user_favourites_selection(options)
#     case options
#     when 1
#       user_favourites_options(favourites_options_menu)
#     when 2
#     when 3
#     end
#   end
