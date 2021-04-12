
# class InvalidUserSelection < StandardError
# end 
if File.exist?('data/cocktails.json') && File.exist?('data/users.json')
  require_relative 'lib/app'
  app = App.new('data/users.json')
  app.run
else
  puts "\nHello! \n\nThank you for downloading Cocktail Cache.\n\n"
  puts "During installation an error may have occured that will impact the core functionality of this app.\n"
  puts "Please try recloning from: https://github.com/kimckenna/cocktail_cache\n\n"
  puts "Apologies for any inconvience.\n\n"
end
