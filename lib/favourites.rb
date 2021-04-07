
require_relative 'cocktail_card_module.rb'
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
        #@app = App.new()
    end

    def favourites_run(user)
        user_favourites(user)
    end

    def title
        puts 'Favourites'
    end

    def user_favourites(user)
        prompt = TTY::Prompt.new
        user_options = {"#{user.current_user.capitalize}'s Favourites": 1, "Other User Favourites": 2, "Return to Main Menu": 3}
        user_selection = prompt.select("Make a Selection:", user_options)
    end 

    def user_favourites_selection(user_favourites)
        case user_favourites
        when 1
            favourites_options_menu
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

    #if user selects favourite 
    #take name of cocktail and push to current_user favourites array 
    #"yulie":{"favourites":[]}
    # @user {key = current.user, value = {key = favourites, value = []}}
    #  
    # @users[user_name] = {'favourites' => []}
    # user.current_user[favourites] << selected_cocktail_name(cocktail_index)
   
    # def add_favourite_run(user, cocktail_index)
    #     # select_favourite_user(user)
    #     # pp select_favourite_user(user)
    #     push_cocktail_user_favourite(user, cocktail_index)
    # end

    #remove when have favourite input working
    # def select_favourite_user(user) 
    #     user.each_key do |key|
    #         if key == user
    #             user << {'cocktail_name': PrintCocktail.selected_cocktail_name(cocktail_index), 'favourite': true}
    #         end
    #     end
    # end

    # MOved add to favourites to user.rb
    # def favourite_cocktail(user, cocktail_index) 
    #     user << {'cocktail_name': PrintCocktail.selected_cocktail_name(cocktail_index), 'favourite': true}
    # end

    # def push_cocktail_user_favourite(user, cocktail_index)
    #     select_favourite_user(user) << select_favourite_cocktail(cocktail_index)
    # end
end