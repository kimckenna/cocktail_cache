
require_relative 'cocktail_card_module.rb'
require_relative 'cocktail_list'
require_relative 'app'
include PrintCocktail
require 'json'
require 'tty-prompt'
require 'colorize'
require 'artii'

class Favourite
    attr_accessor :users

    def initialize(file_path)
        @file_path = file_path
        #@user = User.new('data/users.json')
        #@app = App.new()
        @list = List.new('data/cocktails.json')
        @favourites = []
        @current_user = ''
    end

    def favourite_run(user)
        user_favourites_selection(user_favourites(user))

    end

    def title
        puts 'Favourites'
    end

    def user_favourites(user)
        prompt = TTY::Prompt.new
        @user = user.users
        @current_user = user.current_user
        user_options = {"#{user.current_user.capitalize}'s Favourites": 1, "Other User Favourites": 2, "Return to Main Menu": 3}
        user_selection = prompt.select("Make a Selection:", user_options)
    end 

    def user_favourites_selection(user_favourites)
        case user_favourites
        when 1
            user_favourites_options(favourites_options_menu)
        when 2
        when 3
            #@app.main_menu_selection(main_menu_options)
        end
    end

    def favourites_options_menu
        prompt = TTY::Prompt.new
        favourite_options = {"Random Favourite": 1, "View All Favourites": 2, "Return to Main Menu": 3}
        user_selection = prompt.select("Make a Selection:", favourite_options)
    end

    def user_favourites_options(menu)
        case menu
        when 1
            
        when 2
            PrintCocktail.selected_cocktail_index(@list.search_cocktails(display_favourites))
            PrintCocktail.print_cocktail_elements
        when 3
            #@app.main_menu_selection(main_menu_options)
        end
    end

    def display_favourites
        favourites_hash = @user.fetch(@current_user)
        favourites_hash = favourites_hash.fetch("favourites")
        favourites_hash.map do |favourite|
            favourite.fetch('cocktail_name')
        end
    end

end

# favourite = Favourite.new('data/users.json')
# favourite.favourite_run(0)