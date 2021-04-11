require_relative 'cocktail_card_module'

# Class finds random cocktail
class Random
  include PrintCocktail
  attr_accessor :cocktails, :selected_index

  def initialize(file_path)
    @file_path = file_path
    @selected_index = []
  end

  def random_run
    system 'clear'
    random_index_full_list(PrintCocktail.total_cocktails)
    PrintCocktail.selected_cocktail_index(PrintCocktail.selected_cocktail_name(@selected_index[-1]))
    PrintCocktail.print_cocktail_elements
  end

  def random_index_full_list(length)
    index = 0
    loop  do
      index = rand(0..length)
      break unless @selected_index.include?(index)
    end
    @selected_index << index
    @selected_index
  end

  def clear_selected_index
    @selected_index = []
  end
end
