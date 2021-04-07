require_relative "app"
require 'json'
require 'tty-prompt'
require 'colorize'

class InvalidUserSelection < StandardError
end

class User

    attr_accessor :users, :added_favourite
    attr_reader :current_user


    def initialize(file_path)
        @file_path = file_path
        load_user_data(file_path)
        @current_user = ''
        @add_favourite = {}
    end

    def user_run
        puts
        welcome
        user_type_menu
        puts


        File.write(@file_path, @users.to_json)
    end

    def welcome
        puts "Welcome!"
        puts
    end

    def user_type_menu
        #p @users.empty?
        unless @users.empty?
            user_type_selection(user_type)
        else
            create_new_user
        end
    end

    def user_type
        prompt = TTY::Prompt.new
        user_type = {"New User": 1, "Existing User": 2}
        user_type_selection = prompt.select("Make a Selection:", user_type)
        user_type_selection
    end 

    def user_type_selection(user_type)
        case user_type
        when 1
            create_new_user
        when 2
            existing_user_options
        end
    end

    def create_new_user
        puts display_input_user_name
        @current_user = user_name
        add_user(@current_user)
        # user_index = new_user_name_index
        # puts user_index
    end

    def add_favourite(user, cocktail_index) 
        @add_favourite = @users[current_user]['favourites'] << {'cocktail_name': PrintCocktail.selected_cocktail_name(cocktail_index), 'favourite': true}
        File.write(@file_path, @users.to_json)
    end 

    def existing_user_options
        prompt = TTY::Prompt.new
        # user_options = @users.map do |user, index|
        #     { name: user[:user], value: index }
        # end
        @current_user = prompt.select('Select from Existing Users:', @users.keys, filter: true)
        p @current_user
    end 

    def existing_user_index(existing_user_options)
        @users[existing_user_options]
    end 

    def display_input_user_name
        puts 'Enter your name'
    end

    def user_name
        gets.strip.downcase
    end

    def add_user(user_name) 
        @users[user_name] = {'favourites' => []}
    end

    def new_user_index
        @users[total_users - 1]
    end

    def total_users
        total_users = @users.length
    end

    # def user_menu
    #     index = 0
    #     puts "Create New User:"
    #     puts "\n  #{index + 1}. New User"
    #     puts
    #     unless @users.empty?
    #         puts "OR"
    #         puts "\nSelect from Existing Users:"
    #         @users.each_with_index do |user, index|
    #             puts "\n  #{index + 2}. #{user[:user]}"
    #         end
    #     end      
    # end

    # def user_menu
    #     index = 0
    #     puts "Create New User:"
    #     puts "\n  #{index + 1}. New User"
    
    #     unless @users.empty?
    #         existing_user_options
    #     end      
    # end

    #old user menu 
    # def user_selection(menu_selection) 
    #     raise InvalidUserSelection, 'Value is outside bounds for selection' if menu_selection.negative? || menu_selection - 1 >= @users.length
    #     if menu_selection == 1
    #         puts display_input_user_name
    #         add_user(user_name)
    #         selected_user_name(menu_selection)
    #     else
    #         selected_user_name(menu_selection)
    #     end
    # rescue InvalidUserSelection
    #     puts "#{menu_selection} is an invalid input"
    # #retry
    # end

    # Error handling required for incorrect input 
    #currently displaying selected_user_name

    # code potentially not required
    # def selected_user_name(menu_selection)
    #     @users[menu_selection - 2][:user]
    # end

    def menu_selection
        gets.to_i
    end

    def total_users
        total_users = @users.length
    end

    def load_user_data(file_path)
        json_user_data = JSON.parse(File.read(file_path))
        @users = json_user_data
        # @users = json_user_data.map do |user|
        #     user.transform_keys(&:to_sym)
        # end
        #p @users
    end
end