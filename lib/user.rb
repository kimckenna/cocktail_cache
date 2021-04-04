require_relative "app"
require 'json'
require 'tty-prompt'
require 'colorize'

class InvalidUserSelection < StandardError
end

class User

    attr_accessor :users

    def initialize(file_path)
        @file_path = file_path
        load_user_data(file_path)
    end

    def user_run
        welcome
        user_menu
        puts user_selection(menu_selection)
        #puts selected_user_name(menu_selection)
        #user_selection(menu_selection)
        #puts user_index(menu_selection)
        #system 'clear'
        #display_selected_user_name
        File.write(@file_path, @users.to_json)
    end

    def welcome
        puts "Welcome!"
        puts
        puts "To Start:"
    end

    def user_menu
        index = 0
        puts "Create New User:"
        puts "\n  #{index + 1}. New User"
        puts
        unless @users.empty?
            puts "OR"
            puts "\nSelect from Existing Users:"
            @users.each_with_index do |user, index|
                puts "\n  #{index + 2}. #{user[:user]}"
            end
        end      
    end

    def menu_selection
        gets.to_i
    end

    def display_input_user_name
        puts 'Enter your name'
    end

    def user_name
        gets.strip
    end

    def user_selection(menu_selection) 
        raise InvalidUserSelection, 'Value is outside bounds for selection' if menu_selection.negative? || menu_selection - 2 >= @users.length
        if menu_selection == 1
            puts display_input_user_name
            add_user(user_name)
            selected_user_name(menu_selection)
        else
            selected_user_name(menu_selection)
        end
    rescue InvalidUserSelection
        puts "#{menu_selection} is an invalid input"
    #retry
    end

    # Error handling required for incorrect input 
    #currently displaying selected_user_name

    def add_user(user_name) 
        @users << { user: user_name, favourites: {} }
    end

    def total_users
        total_users = @users.length
    end

    def selected_user_name(menu_selection)
        @users[menu_selection - 2][:user]
    end

    def display_selected_user_name
        puts "User: #{selected_user_name}"
    end

    def load_user_data(file_path)
        json_user_data = JSON.parse(File.read(file_path))
        @users = json_user_data.map do |user|
            user.transform_keys(&:to_sym)
        end
    end
end