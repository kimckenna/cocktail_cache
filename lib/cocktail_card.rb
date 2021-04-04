require 'json'
require 'tty-prompt'
require 'colorize'

class cocktail_random
    attr_accessor :users, :favourites

    def initialize(file_path)
        @file_path = file_path
        load_user_data(file_path)
        
        #load_users
    end

end