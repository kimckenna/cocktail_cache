require_relative 'lib/user'
require_relative 'lib/app'
#require_relative InvalidUserSelection

#users = User_Screen.new('data/users.json')
#users.run

app = App.new('data/users.json')
#users = User.new('data/users.json')
#users_cocktails = User.new('data/cocktails.json')
#random = Random.new('data/cocktails.json')
#favourite = App.new('data/users.json')
#cocktails = PrintCocktail.new('data/cocktails.json')


#users.user_run
app.primary_app_run

#cocktails = 