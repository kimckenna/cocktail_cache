
#user menu 
require_relative "user"
#app menu outputs
require_relative "cocktail_random"
require_relative "cocktail_list"
#gems
require 'json'
require 'tty-prompt'
require 'colorize'

#users = User.new('data/users.json')

class App
    attr_accessor :users

    def initialize(file_path)
        @file_path = file_path
        @user = load_user_data(file_path)
        @random = Random.new()
        @list = List.new('data/cocktails.json')
        #load_users
    end

    def app_name_run
        app_name
        puts
        # main_menu_options
        main_menu_selection(main_menu_options)
        #File.write(@file_path, @users.to_json)
    end

    # def primary_app_run
    #     app_name
    # end

    def app_name
        puts 'Cocktail Cache'
    end

    def main_menu_options
        prompt = TTY::Prompt.new
        main_menu_options = {"Random Cocktail": 1, "Favourites": 2, "Search Cocktails": 3, "Exit": 4}
        user_main_menu_selection = prompt.select("Make a Selection:", main_menu_options)
        user_main_menu_selection
    end 

    def main_menu_selection(main_menu_options)
        case main_menu_options
        when 1
            @random.random_run
        when 2

        when 3
            @list.list_run
        when 4
            exit
        end
    end

    def load_user_data(file_path)
       json_user_data = JSON.parse(File.read(file_path))
        @users = json_user_data.map do |user|
            user.transform_keys(&:to_sym)
        end
    end
end