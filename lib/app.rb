
#user menu 
require_relative "user"
#app menu outputs
require_relative "cocktail_random"
require_relative "cocktail_list"
require_relative "favourites.rb"
#gems
require 'json'
require 'tty-prompt'
require 'colorize'
require 'artii'

#users = User.new('data/users.json')

class App
    attr_accessor :users


    def initialize(file_path)
        @file_path = file_path
        @user = User.new('data/users.json')
        @random = Random.new()
        @list = List.new('data/cocktails.json')
        @favourite = Favourite.new('data/users.json')
        #load_users
    end

    def primary_app_run
        #loop do
        system "clear"
        title_name(app_name)
        puts
        @user.user_run
        #system "clear"
        title_name(app_name)
        main_menu_selection(main_menu_options)
        
    end

    def font_block
        font_block = TTY::Font.new(:block)
    end

    def title_name(app_name)
        title = app_name.split(' ')
        title.each do |word|
            #print font_dotmatrix.asciify(word)
            print font_block.write(word)
        end
    end
    def app_name
        'Cocktail Cache'
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
            loop do
                random_cocktail_menu_selection(cocktail_view_menu)
                p @user.users[@user.current_user]['favourites']
                p @user.users
            end
        when 2
            @favourite.favourites_run(@user)
        when 3
            @list.list_run
        when 4
            exit
        end
    end

    def load_user_data(file_path)
       json_user_data = JSON.parse(File.read(file_path))
        @user = json_user_data.map do |user|
            user.transform_keys(&:to_sym)
        end
    end

    def cocktail_view_menu
        prompt = TTY::Prompt.new
        cocktail_menu_options = {"Add to Favourites": 1, "Run Again": 2, "Exit to Main Menu": 3}
        user_cocktail_menu_selection = prompt.select("Make a Selection:", cocktail_menu_options)
    end

    def user_favourite_array
        @user.users[@user.current_user]['favourites']
    end

    def random_cocktail_menu_selection(cocktail_view_menu)
        case cocktail_view_menu
        when 1
            #@favourite.favourite_cocktail(user_favourite_array, 1)
            @user.add_favourite(user_favourite_array, )
        when 2
            system 'clear'
            @random.random_run
        when 3
            main_menu_selection(main_menu_options)
        end
    end

end