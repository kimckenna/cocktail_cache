
require_relative "user"
require 'json'
require 'tty-prompt'
require 'colorize'

#users = User.new('data/users.json')

class App
    attr_accessor :users

    def initialize(file_path)
        @file_path = file_path
        load_user_data(file_path)
        
        #load_users
    end

    def app_name_run
        app_name
        puts
        #File.write(@file_path, @users.to_json)
    end

    def primary_app_run
        app_name

    end

    def app_name
        puts 'Cocktail Cache'
    end

    def load_user_data(file_path)
       json_user_data = JSON.parse(File.read(file_path))
        @users = json_user_data.map do |user|
            user.transform_keys(&:to_sym)
        end
    end

    # def load_users
    #     local_dir = File.expand_path(../, __FILE__)
    #     $LOAD_PATH.unshift(local_dir)
    #     require users.rb
    # end 
end