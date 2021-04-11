
require 'tty-prompt'
require 'colorize'
require 'artii'
require 'tty-font'

# Class displays Welcome / Start Page
class Welcome

	attr_accessor :font_block

	def initialize()
		@font_block = TTY::Font.new(:block)
	end

	def title_name(name)
    title = name.split(' ')
    title.each do |word|
      print @font_block.write(word)
    end
    puts
  end
  
  def app_name
    'Cocktail Cache'
  end

	def welcome_run
		title_name(app_name)
		about_app
		puts
	end

  def about_app
		puts "Welcome!\n\nAbout Cocktail Cache:\n\n"
		puts "Cocktail Cache provides you with a selection of official IBA cocktails graciously collated by Teijo Lane and collaborators.\n\n"
		puts "Within this app you\'re able to:\n\n   1. Create and manage your own list of favourite cocktails.\n   2. Select a cocktail at random.\n   3. Search the extensive list of cocktails by name or ingredient.\n\n"
		puts "When navigating Cockatil Cache, each menu will explain how to access each option.\n\n"
		puts "Thanks for Downloading!\n\nKim \nCocktail of Choice: Whiskey Sour\n\n"
  end
end

# welcome = Welcome.new
# welcome.welcome_run
