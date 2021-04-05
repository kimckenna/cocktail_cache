require 'json'
require 'tty-prompt'
require 'colorize'
require 'tty-font'

module PrintCocktail
    attr_accessor :cocktails

    def font_block
        font_block = TTY::Font.new(:block)
    end
    #array with hash for each cocktail
    #each cocktail includes an ingredients array 

    def cocktail_index
        1
    end

    def selected_cocktail(cocktail_index)
        @cocktails[cocktail_index]
    end

    def cocktail_name
        @cocktails.each do |cocktail|
            puts "Cocktail Name: #{cocktail[:name]}"
        end
    end

    def cocktail_elements(cocktail_index)
        selected_cocktail(cocktail_index).each do |key, value|
            if key == :name
                title(value)
            elsif key == :ingredients 
                puts "\n\nIngredients:"
                cocktail_ingredients(cocktail_index)
            elsif key == :preparation
                puts "\n\n#{key.capitalize}:"
                preparation_split(value)
            else
                puts "\n#{key.capitalize}: #{value}"
            end
        end
    end

    def cocktail_ingredients(cocktail_index)
        selected_cocktail(cocktail_index)[:ingredients].each do |value| 
            unless value["special"]
                puts " \n   #{value["ingredient"]}: #{value["amount"]}#{value["unit"]}"
            else 
                puts " \n   #{value["special"]}"
            end
        end
    end

    def title(value)
        title = value.split(' ')
        title.each do |word|
            print font_block.write(word)
        end
    end

    def preparation_split(value)
        preparation_steps = value.split('. ')
        preparation_steps.each do |step|
            puts "\n   #{step}"
        end
        puts
    end 

    # def favourite
    #     if favourite_toggle == "yes"

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

#Have only been running file on own have not linked to rest of app
#cocktails = PrintCocktail.new('data/cocktails.json')
include PrintCocktail
PrintCocktail.load_cocktail_data('data/cocktails.json')
#PrintCocktail.cocktail_elements(cocktail_index)