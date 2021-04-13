require 'json'
require 'tty-prompt'
require 'tty-font'
require 'pastel'

# Prints Cocktail Card Format
module PrintCocktail
  attr_accessor :cocktails

  def selected_cocktail
    @cocktails[@index]
  end

  def selected_cocktail_name(cocktail_index)
    @cocktails[cocktail_index]['name']
  end

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
      print pastel.bold.bright_blue(font_block.write(word))
    end
    puts
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
    @cocktails.length - 1
  end

  def apologies_message
    puts "Hello! \n\nThank you for downloading Cocktail Cache.\n"
    puts "During installation an error may have occured that will impact the core functionality of this app.\n"
    puts "Please try recloning from: https://github.com/kimckenna/cocktail_cache\n"
    puts "Apologies for any inconvience."
  end

  def load_cocktail_data(file_path)
    json_cocktail_data = JSON.parse(File.read(file_path))
    @cocktails = json_cocktail_data
  end
end

# required to initialize 
include PrintCocktail
PrintCocktail.load_cocktail_data('data/cocktails.json')
