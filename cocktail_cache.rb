if File.exist?('data/cocktails.json') && File.exist?('data/users.json')
  require_relative 'lib/app'
  app = App.new('data/users.json')
  app.primary_app_run
else
  # app.title_name(app.app_name)
  puts "Hello! \n\nThank you for downloading Cocktail Cache.\n"
  puts "During installation an error may have occured that will impact the core function of this app.\n"
  puts "Please try recloning from: https://github.com/kimckenna/cocktail_cache\n"
  puts "Apologies for any inconvience"
end
