require 'json'
require 'tty-prompt'
require 'colorize'

class PrintCocktail
    attr_accessor :cocktails, :ingredients

    def initialize(file_path)
        @file_path = file_path
        load_cocktail_data(file_path)
        # @name 
        # @glass
        # @category
        # @ingredients
        # @garnish
        # @preparation
    end

    def cocktail_card_run
        #cocktail_name
        #print_cocktail_name
        cocktail_elements
        #puts alcoholic_ingredients

    end
    #array with hash for each cocktail
    #each cocktail includes an ingredients array 

    def selected_cocktail
        index = 4
        @cocktails[index]
    end

    def selected_cocktail_name
        @cocktails[0][:name]
    end

    def print_cocktail_name
        puts "Cocktail Name: #{selected_cocktail_name}"
    end

    def cocktail_name
        @cocktails.each do |cocktail|
            puts "Cocktail Name: #{cocktail[:name]}"
        end
    end

    def cocktail_elements
        selected_cocktail.each do |key, value|
            if key == :name
                puts "\n#{key.capitalize}: #{value}"
            elsif key == :ingredients 
                puts "\nIngredients:"
                cocktail_ingredients
            else key == :ingredients
                puts "\n#{key.capitalize}: #{value}"
            end
        end
    end

    def cocktail_ingredients
        selected_cocktail[:ingredients].each do |value| 
            unless value["special"]
                puts " \n  #{value["ingredient"]}: #{value["amount"]}#{value["unit"]}"
            else 
                puts " \n  #{value["special"]}"
            end
        end
    end

    # def alcoholic_ingredients
    #     selected_cocktail[:ingredients]["ingredient"]
    # end

    # def non_alcoholic_ingredients
    #     selected_cocktail[:ingredients]["special"]
    # end

    def load_cocktail_data(file_path)
        json_cocktail_data = JSON.parse(File.read(file_path))
        @cocktails = json_cocktail_data.map do |cocktail|
            cocktail.transform_keys(&:to_sym)
        end
    
        #@ingredients = json_cocktail_data.map do |ingredient| 
        #    ingredient.transform_keys(&:to_sym)
        #end
    end
    
end

cocktails = PrintCocktail.new('data/cocktails.json')

cocktails.cocktail_card_run