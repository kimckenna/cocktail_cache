require 'json'
require 'tty-prompt'
require 'colorize'
require 'tty-font'
require 'artii'

module PrintCocktail
    attr_accessor :cocktails

    def selected_cocktail
        @cocktails[@index]
    end

    def selected_cocktail_name(cocktail_index)
        cocktail_name = @cocktails[cocktail_index][:name]
    end



    # def selected_cocktail_name(input)
    #     if @cocktails.include?(input)
    #     cocktail_name = @cocktails[cocktail_index][:name]
    # end

    def cocktail_names
        @cocktails.each do |cocktail|
            cocktail[:name]
        end
    end

    # def cocktail_elements(cocktail_index)
    #     system 'clear'
    #     selected_cocktail(cocktail_index).each do |key, value|
    #         if key == :name
    #             title(value)
    #         elsif key == :ingredients 
    #             puts "\n\nIngredients:"
    #             cocktail_ingredients(cocktail_index)
    #         elsif key == :preparation
    #             puts "\n\n#{key.capitalize}:"
    #             preparation_split(value)
    #         else
    #             puts "\n#{key.capitalize}: #{value}"
    #         end
    #     end
    # end

    def print_cocktail_elements
        system 'clear'
        selected_cocktail.each do |key, value|
            if key == :name
                title(value)
            elsif key == :ingredients 
                puts "\n\nIngredients:"
                cocktail_ingredients
            elsif key == :preparation
                puts "\n\n#{key.capitalize}:"
                preparation_split(value)
            else
                puts "\n#{key.capitalize}: #{value}"
            end
        end
    end

    def cocktail_index
        @index = 0
    end

    def selected_cocktail_index(input)
        system 'clear'
        @cocktails.each do |cocktail|
            if cocktail[:name] == (input)
                @index = @cocktails.index(cocktail)
            end
        end
        @index
    end

    def cocktail_ingredients
        selected_cocktail[:ingredients].each do |value| 
            unless value["special"]
                puts " \n   #{value["ingredient"]}: #{value["amount"]}#{value["unit"]}"
            else 
                puts " \n   #{value["special"]}"
            end
        end
    end

    # def cocktail_ingredients(cocktail_index)
    #     selected_cocktail(cocktail_index)[:ingredients].each do |value| 
    #         unless value["special"]
    #             puts " \n   #{value["ingredient"]}: #{value["amount"]}#{value["unit"]}"
    #         else 
    #             puts " \n   #{value["special"]}"
    #         end
    #     end
    # end

    def title(value)
        title = value.split(' ')
        title.each do |word|
            #print font_dotmatrix.asciify(word)
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

    def font_block
        font_block = TTY::Font.new(:block)
    end

    def font_dotmatrix
        a = Artii::Base.new :font => 'dotmatrix'
    end

    def total_cocktails
        p @cocktails.length - 1
    end




    #### EXTRA CODE FOR LISTS
    # def all_cocktail_ingredients
    #     all_ingredients = []
    #     @cocktails.each do |cocktail|
    #         cocktail[:ingredients].each do |ingredient| 
    #             ingredient.map do |key, value|
    #                 if key == "ingredient"
    #                     unless all_ingredients.include?(value) == true
    #                         all_ingredients << value
    #                     end 
    #                 end
    #             end
    #         end
    #     end
    #     all_ingredients
    # end



    def load_cocktail_data(file_path)
        json_cocktail_data = JSON.parse(File.read(file_path))
        @cocktails = json_cocktail_data.map do |cocktail|
            cocktail.transform_keys(&:to_sym)
        end
    end
    
end

#Have only been running file on own have not linked to rest of app
#cocktails = PrintCocktail.new('data/cocktails.json')
include PrintCocktail
PrintCocktail.load_cocktail_data('data/cocktails.json')
#PrintCocktail.cocktail_elements(cocktail_index)
#PrintCocktail.total_cocktails