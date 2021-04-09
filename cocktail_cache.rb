
unless File.exist?('data/cocktails.json') && File.exist?('data/users.json')
    #app.title_name(app.app_name)
    puts "Hello! \nThank you for downloading Cocktail Cache. \nUnfortunatley an error may have occured during the installation of this app that will impact it's core function. \nPlease try recloning from: https://github.com/kimckenna/cocktail_cache"
else
    require_relative 'lib/app'
    app = App.new('data/users.json')
    app.primary_app_run
end





# require_relative 'lib/user'
# require_relative 'lib/app'


# app = App.new('data/users.json')

#cocktails = PrintCocktail.new('data/cocktails.json')


#users.user_run
#app.primary_app_run
#require_relative 'lib/user'