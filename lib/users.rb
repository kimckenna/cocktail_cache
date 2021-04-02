require 'json'
require 'tty-prompt'
require 'colorize'

class User_Screen
    attr_accessor :users

    def initialize(file_path)
        @file_path = file_path
        load_user_data(file_path)
    end

    def run
        app_name
        puts
        welcome
        puts
        user_menu
        user_selection(menu_selection)
        #display_input_user_name

        File.write(@file_path, @users.to_json)
    end

    def app_name
        puts 'Cocktail Cache'
    end

    def welcome
        puts "Welcome!"
        puts
        puts "To Start: \nCREATE NEW USER or SELECT EXISTING USER"
    end

    def user_menu
        index = 0
        puts " #{index + 1}. New User"
        puts
        unless @users.empty?
            puts 'Existing Users:'
            @users.each_with_index do |user, index|
                puts "#{index + 2}. #{user[:user]}"
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

    def add_user(user_name)
        @users << { user: user_name, favourites: {} } #if user_menu[menu_selection] == 1 
    end

    def user_selection(menu_selection)
        case 
        when menu_selection == 1
            puts display_input_user_name
            add_user(user_name)
        end
    end

    def load_user_data(file_path)
        json_user_data = JSON.parse(File.read(file_path))
        @users = json_user_data.map do |user|
            user.transform_keys(&:to_sym)
        end
    end
end