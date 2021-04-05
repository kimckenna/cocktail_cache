require 'json'
require 'tty-prompt'
require 'colorize'

class List
    attr_accessor :cocktails

    def initialize(file_path)
        @file_path = file_path
        load_cocktail_data(file_path)
    end

    def list_run
        cocktail_names
        #cocktail_category
        #cocktail_categories
        #categories
        category_menu
        
    end

    # def selected_cocktail_name(index)
    #     @cocktails[index][:name]
    # end

    # def cocktail_names
    #     puts "Cocktail Name: #{selected_cocktail_name}"
    # end

    # def category
    #     category = []
    # end 

    def categories
        category = []
        #puts "Categories:"
        cocktail_category.each do |value| 
            unless category.include?(value) == true
                category << value
            end
        end
        category.map! do |value|
            if value == nil 
                value = 'Something Strong'
            else 
                value = value
            end
        end
        category
    end

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


    def category_menu
        i = 0
        until i >= categories.length - 1 
            puts "\n#{categories[i]}\n\n"
            @cocktails.each do |cocktail|
                if categories[1] && cocktail[:category] == nil
                    puts "   #{cocktail[:name]}"
                else
                    if cocktail[:category] == categories[i] && cocktail[:category] != nil
                        puts "   #{cocktail[:name]}"
                    end 
                end
            end
            i += 1
        end
    end

    #@cocktails.each do |cocktail|

    def view_all

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

    def load_cocktail_data(file_path)
        json_cocktail_data = JSON.parse(File.read(file_path))
        @cocktails = json_cocktail_data.map do |cocktail|
            cocktail.transform_keys(&:to_sym)
        end
    end
end

list = List.new('data/cocktails.json')
list.list_run

# def selected_cocktail_name(index)
    #     @cocktails[index][:name]
# end

# def print_cocktail_name
    #     puts "Cocktail Name: #{selected_cocktail_name}"
# end