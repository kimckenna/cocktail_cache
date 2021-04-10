require 'json'
require 'tty-prompt'
require 'colorize'
require 'tty-font'
require 'artii'

# Prints Cocktail Card Format
module PrintCocktail
  attr_accessor :cocktails

  def selected_cocktail
    @cocktails[@index]
  end

  def selected_cocktail_name(cocktail_index)
    @cocktails[cocktail_index]['name']
  end

  # def selected_cocktail_name(input)
  #     if @cocktails.include?(input)
  #     cocktail_name = @cocktails[cocktail_index][:name]
  # end

  def cocktail_names
    cocktail_names = []
    @cocktails.each do |cocktail|
      cocktail.map do |key, value|
        if key == 'name'
          cocktail_names << value
        end
      end
    end
    cocktail_names
  end

  def print_cocktail_elements
    # system 'clear'
    selected_cocktail.each do |key, value|
      # don't convert to case/when as breaks formatting
      if key == 'name'
        title(value)
      elsif key == 'ingredients'
        puts "\n\nIngredients:"
        cocktail_ingredients
        #had (cocktail_index)??? - ignore
      elsif key == 'preparation'
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
      @index = @cocktails.index(cocktail) if cocktail['name'] == (input)
    end
    @index
  end

  def cocktail_ingredients
    selected_cocktail['ingredients'].each do |value|
      if value['special']
        puts " \n   #{value['special']}"
      else
        puts " \n   #{value['ingredient']}: #{value['amount']}#{value['unit']}"
      end
    end
  end

  def title(value)
    font_block = TTY::Font.new(:block)
    title = value.split(' ')
    title.each do |word|
      # print font_dotmatrix.asciify(word)
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
    TTY::Font.new(:block)
  end

  def font_dotmatrix
    Artii::Base.new font: 'dotmatrix'
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
    @cocktails = json_cocktail_data
  end
end

# Have only been running file on own have not linked to rest of app
# cocktails = PrintCocktail.new('data/cocktails.json')
include PrintCocktail
PrintCocktail.load_cocktail_data('data/cocktails.json')
# PrintCocktail.cocktail_elements(cocktail_index)
#p PrintCocktail.selected_cocktail_name(1)
p PrintCocktail.cocktail_names