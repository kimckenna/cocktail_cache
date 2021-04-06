require 'json'
require 'tty-prompt'
require 'colorize'
require_relative 'cocktail_card_module.rb'
include PrintCocktail

class Random
    attr_accessor :cocktails #:users, :favourites

    def initialize#(file_path)
        #file_path = file_path
        #cocktail = load_cocktail_data(file_path)
        
        #load_users
    end

    def random_run
        system 'clear'
        #puts total_cocktails
        #print_cocktail_name
        #PrintCocktail.cocktail_elements(random_cocktail_index)
    end

    def random_index_full_list
        rand(0..PrintCocktail.total_cocktails)
    end

    def random_cocktail_index
        random_index_full_list
    end 

    #use to check last cocktail correct
    # def selected_cocktail_name
    #     @cocktails[76][:name]
    # end

    # def print_cocktail_name
    #     puts "Cocktail Name: #{selected_cocktail_name}"
    # end

    # def load_cocktail_data(file_path)
    #     json_cocktail_data = JSON.parse(File.read(file_path))
    #     @cocktails = json_cocktail_data.map do |cocktail|
    #         cocktail.transform_keys(&:to_sym)
    #     end
    # end

end

# random = Random.new('data/cocktails.json')
# random.random_run