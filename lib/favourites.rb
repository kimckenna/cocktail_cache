
require_relative 'cocktail_card_module.rb'
include PrintCocktail
require 'json'
require 'tty-prompt'
require 'colorize'
require 'artii'

class Favourite
    attr_accessor :users

    def initialize(file_path)
        @file_path = file_path
    end

    def favourites_run(users)
        user_favourites(users)
    end

    def title
        puts 'Favourites'
    end



    def user_favourites(user)
        prompt = TTY::Prompt.new
        user_favourites = {"#{user.current_user.capitalize}'s Favourites": 1, "Other User Favourites": 2}
        user_favourites_selection = prompt.select("Make a Selection:", user_favourites)
        # user_favourites_selection
    end 

    def user_favourites_selection(user_favourites)
        case user_favourites
        when 1
        when 2
        end
    end

end