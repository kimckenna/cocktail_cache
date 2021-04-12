#require 'colorize'
require 'tty-font'
require 'pastel'

# Module printing Welcome / Start Page content
module Welcome
  attr_accessor :font_block, :pastel

  def title_name(name)
    font_block = TTY::Font.new(:block)
    title = name.split(' ')
    title.each do |word|
      print pastel.bold.bright_blue(font_block.write(word))
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

	def pastel
		Pastel.new
	end

	def cyan_text
		pastel.cyan("cyan")
	end

  def about_app
    puts "Welcome!\n\nAbout Cocktail Cache:\n\n"
    puts "Cocktail Cache provides you with a selection of official IBA cocktails graciously collated by Teijo Lane and collaborators.\n\n"
    puts "Within this app you\'re able to:\n\n   1. Create and manage your own list of favourite cocktails.\n   2. Select a cocktail at random.\n   3. Search the extensive list of cocktails by name or ingredient.\n\n"
    puts "When navigating Cockatil Cache, each menu explains the required keys to navigate in #{cyan_text}.\n\n" 
    puts "Thanks for Downloading!\n\nKim \nCocktail of Choice: Whiskey Sour\n\n"
  end
end

# required to initialize 
include Welcome
Welcome.welcome_run