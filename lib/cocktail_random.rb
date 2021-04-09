require 'json'
require 'tty-prompt'
require 'colorize'
require_relative 'cocktail_card_module.rb'
include PrintCocktail

class Random
    attr_accessor :cocktails, :selected_index #:users, :favourites

    def initialize(file_path)
        file_path = file_path
        load_cocktail_data(file_path)
        #load_users
        @selected_index = []
    end

    def random_run
        system 'clear'
        #puts total_cocktails
        #print_cocktail_name
        random_index_full_list
        #p random_index_name
        #p @cocktails[0]
        # p @cocktails[0][:name]
        #PrintCocktail.cocktail_elements(@selected_index[-1])
        PrintCocktail.selected_cocktail_index(PrintCocktail.selected_cocktail_name(@selected_index[-1]))
        PrintCocktail.print_cocktail_elements
    end

    def random_index_full_list
        index = 0
        loop  do
            index = rand(0..PrintCocktail.total_cocktails) 
            break unless @selected_index.include?(index)
        end
        @selected_index << index
        p @selected_index

        #PrintCocktail.total_cocktails
    end

    def clear_selected_index
        @selected_index = []
    end

    # IMPORTANT
    # def random_index_name
    #     name = @cocktails[@selected_index[-1]][:name]
    # end

    # def random_cocktail
    #     name = ''
    #     loop  do
    #         name = @cocktails[:name].value.sample 
    #         break unless @selected_index.include?(name)
    #     end
    #     @selected_names << name
    #     p @selected_names
    # end

    #does not work - worked when sitting in app.rb 
    #also unsure if want to clear - could use to exclude array numbers from random index selection

    # selected_index.map do |index|
    #     selected_index.pop
    # end

    # def random_cocktail
    #     PrintCocktail.cocktail_name.sample   
    # end

    # def selected_cocktail_index
    #     selected_index = []
    # end 

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