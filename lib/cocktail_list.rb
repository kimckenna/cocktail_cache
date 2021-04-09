require 'json'
require 'tty-prompt'
require 'colorize'
require_relative 'cocktail_card_module.rb'
include PrintCocktail

class List
    attr_accessor :cocktails

    def initialize(file_path)
        @file_path = file_path
        load_cocktail_data(file_path)
    end

    def list_run
        #cocktail_names
        #category_menu
        system "clear"
        title_name(search_page_title)
        search_type_selection(search_type)
    end

    def title_name(page_name)
        title = page_name.split(' ')
        title.each do |word|
            #print font_dotmatrix.asciify(word)
            print font_block.write(word)
        end
    end

    def search_page_title
        'Cocktail Search'
    end

    def search_all_title
        'Search All Cocktails'
    end

    def search_alcohol_title
        'Search By Alcohol'
    end

    def search_type
        prompt = TTY::Prompt.new
        user_type = {"Search Cocktails By Alcohol": 1, "Search All Cocktails": 2}
        user_type_selection = prompt.select("Make a Selection:", user_type)
        user_type_selection
    end 

    def search_type_selection(search)
        case search
        when 1
            title_name(search_alcohol_title) 
        when 2
            title_name(search_all_title)
            PrintCocktail.cocktail_elements(search_all_cocktails)
        end
    end

    def search_all_cocktails
        prompt = TTY::Prompt.new
        menu_options = @cocktails.map.with_index do |cocktail, index|
            { name: cocktail[:name], value: index }
        end
        user_selection = prompt.select('Choose a cocktail: ', menu_options, filter: true)
        user_selection
    end

    ##### END OF CURRENT USEFUL CODE

    def categories
        category = []
        #puts "Categories:"
        cocktail_category.each do |value| 
            unless category.include?(value) == true
                category << value
            end
        end
        # category.map! do |value|
        #     if value == nil 
        #         value = 'Something Strong'
        #     else 
        #         value = value
        #     end
        # end
        category
    end

    def category_menu
        i = 0
        until i >= categories.length - 1 
            puts "\n#{categories[i]}\n\n"
            @cocktails.each do |cocktail|
                if cocktail[:category] == categories[i] 
                    puts "   #{cocktail[:name]}"
                end 
            end
            i += 1
        end
    end

    def cocktail_category
        @cocktails.map do |cocktail|
            cocktail[:category]
            # if cocktail[:category] == nil
            #     @cocktails{} << "category" => "Something Stronger"
            # end
        end
    end 

    def cocktail_names
        @cocktails.each do |cocktail|
            puts "   #{cocktail[:name]}"
        end
    end

    def testing_run
        system "clear"
        title_name(search_page_title)
        # p full_cocktail_list_ingredients
        # p alcohol_ingredients
        search_alcohol
        #p full_cocktail_list_ingredients
        #p PrintCocktail.unsorted_cocktail_ingredients
        #cocktail_ingredients_list
        #PrintCocktail.cocktail_elements(full_cocktail_list_selection)
    end

    def search_alcohol
        prompt = TTY::Prompt.new
        @alcohol_selection = prompt.select('Select an Alcohol: ', alcohol_ingredients, filter: true)
        alcohol_selection
    end

    def full_cocktail_list_ingredients
        all_ingredients = []
        PrintCocktail.cocktails.each do |cocktail|
            cocktail[:ingredients].each do |ingredient| 
                ingredient.map do |key, value|
                    if key == "ingredient"
                        unless all_ingredients.include?(value) == true
                            all_ingredients << value
                        end 
                    end
                end
            end
        end
        all_ingredients
    end

    def alcohol_ingredients
        alcohol = full_cocktail_list_ingredients
        alcohol.delete_if {|value| value.include?("juice")}    
        alcohol.delete ("Syrup")
        alcohol.delete ("Ginger Ale")
        alcohol.delete ("Egg yolk")
        alcohol.delete ("Soda water")
        alcohol.delete ("Coconut milk")
        alcohol.delete ("Peach puree")
        alcohol.delete ("Cream")
        alcohol.delete ("Hot coffee")
        alcohol.delete ("Ginger beer")
        alcohol.delete ("Orange Bitters")
        alcohol.delete ("Cola")
        alcohol
    end
end

list = List.new('data/cocktails.json')
list.testing_run


    # def load_cocktail_data(file_path)
    #     json_cocktail_data = JSON.parse(File.read(file_path))
    #     @cocktails = json_cocktail_data.map do |cocktail|
    #         cocktail.transform_keys(&:to_sym)
    #     end
    # end

    # def selected_cocktail_name(index)
    #     @cocktails[index][:name]
    # end

    # def cocktail_names
    #     puts "Cocktail Name: #{selected_cocktail_name}"
    # end

    # def category
    #     category = []
    # end 

    # def complete_categories
    #     categories.map! do |value|
    #         if value == nil 
    #             value = 'Something Strong'
    #         else 
    #             value = value
    #         end
    #     end
    #     #categories
    # end 


    # def category_menu
    #     cocktail_order_category = []
    #     i = 0
    #     until i >= categories.length - 1 
    #         puts "\n#{categories[i]}\n\n"
    #         @cocktails.each do |cocktail|
    #             if cocktail[:category] == categories[i] 
    #                 cocktail_order_category << cocktail
    #                 puts "   #{cocktail[:name]}"
    #             end 
    #         end
    #         i += 1
    #     end
    #     pp cocktail_order_category
    # end

    # def category_menu
    #     i = 0
    #     until i >= categories.length - 1 
    #         puts "\n#{categories[i]}\n\n"
    #         @cocktails.each do |cocktail|
    #             if categories[1] && cocktail[:category] == nil
    #                 puts "   #{cocktail[:name]}"
    #             else
    #                 if cocktail[:category] == categories[i] && cocktail[:category] != nil
    #                     puts "   #{cocktail[:name]}"
    #                 end 
    #             end
    #         end
    #         i += 1
    #     end
    # end
    #@cocktails.each do |cocktail|