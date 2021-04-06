
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
        @list = List.new()
        #load_users
    end

    def app_name_run
        app_name
        puts
        @random.random_run
        #File.write(@file_path, @users.to_json)
    end

    # def primary_app_run
    #     app_name
    # end

    def app_name
        puts 'Cocktail Cache'
    end

    def load_user_data(file_path)
       json_user_data = JSON.parse(File.read(file_path))
        @users = json_user_data.map do |user|
            user.transform_keys(&:to_sym)
        end
    end
end