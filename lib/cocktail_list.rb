require_relative 'cocktail_card_module'

# Provides all the cocktail search functions pulling the end cocktail format from cocktail_card_module
class List
  include PrintCocktail
  attr_accessor :cocktails
  attr_reader :selected_index_list

  def initialize(file_path)
    @file_path = file_path
    load_cocktail_data(file_path)
    @selected_alcohol = ''
    @cocktails_select_alcohol = []
    @selected_index_list = []
    @font_block = TTY::Font.new(:block)
    @prompt = TTY::Prompt.new(help_color: :cyan)
  end

  def list_run
    search_type_selection(search_type)
  end

  def title_name(name)
    title = name.split(' ')
    title.each do |word|
      print @font_block.write(word)
    end
    puts
  end

  def search_type
    user_type = { "Search Cocktails By Alcohol": 1, "Search all Cocktails": 2 }
    @prompt.select('Make a Selection:', user_type)
  end

  def search_type_selection(search)
    case search
    when 1
      system 'clear'
      title_name(search_alcohol_title)
      puts
      cocktails_including_selected_alcohol(search_alcohol)
      selected_cocktail(PrintCocktail.selected_cocktail_index(search_cocktails(@cocktails_select_alcohol)))
      PrintCocktail.print_cocktail_elements
      @cocktails_select_alcohol = []
    when 2
      system 'clear'
      title_name(search_all_title)
      puts
      selected_cocktail(PrintCocktail.selected_cocktail_index(search_cocktails(PrintCocktail.cocktail_names)))
      PrintCocktail.print_cocktail_elements
    end
  end

  def selected_cocktail(index)
    @selected_index_list << (index)
  end

  def search_all_title
    'Search all Cocktails'
  end

  def search_cocktails(input)
    @selected_cocktail = @prompt.select('Choose a Cocktail: ', input, filter: true)
    @selected_cocktail
  end

  def search_alcohol_title
    'Search By Alcohol'
  end

  def search_alcohol
    @selected_alcohol = @prompt.select('Select an Alcohol: ', alcohol_ingredients, filter: true)
  end

  def cocktails_including_selected_alcohol(_search)
    @cocktails.each do |cocktail|
      cocktail['ingredients'].each do |ingredient|
        @cocktails_select_alcohol << cocktail['name'] if ingredient.value?(@selected_alcohol)
      end
    end
    @cocktails_select_alcohol
  end

  def full_cocktail_list_ingredients
    all_ingredients = []
    PrintCocktail.cocktails.each do |cocktail|
      cocktail['ingredients'].each do |ingredient|
        ingredient.map do |key, value|
          next unless key == 'ingredient'

          all_ingredients << value unless all_ingredients.include?(value) == true
        end
      end
    end
    all_ingredients
  end

  def alcohol_ingredients
    alcohol = full_cocktail_list_ingredients
    alcohol.delete_if { |value| value.include?('juice') }
    alcohol.delete('Syrup')
    alcohol.delete('Ginger Ale')
    alcohol.delete('Egg yolk')
    alcohol.delete('Soda water')
    alcohol.delete('Coconut milk')
    alcohol.delete('Peach puree')
    alcohol.delete('Cream')
    alcohol.delete('Hot coffee')
    alcohol.delete('Ginger beer')
    alcohol.delete('Orange Bitters')
    alcohol.delete('Cola')
    alcohol
  end
end

# CODE FOR SEARCH BY CATEGORIES
#   def categories
#     category = []
#     # puts "Categories:"
#     cocktail_category.each do |value|
#       category << value unless category.include?(value) == true
#     end
#     category
#   end

#   def category_menu
#     i = 0
#     until i >= categories.length - 1
#       puts "\n#{categories[i]}\n\n"
#       @cocktails.each do |cocktail|
#         puts "   #{cocktail['name']}" if cocktail['category'] == categories[i]
#       end
#       i += 1
#     end
#   end

#   def cocktail_category
#     @cocktails.map do |cocktail|
#       cocktail['category']
#     end
#   end
