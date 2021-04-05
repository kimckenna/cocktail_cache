require_relative 'lib/user'
require_relative 'lib/app'
#require_relative InvalidUserSelection

#users = User_Screen.new('data/users.json')
#users.run

app = App.new('data/users.json')
users = User.new('data/users.json')
#favourite = App.new('data/users.json')
cocktails = PrintCocktail.new('data/cocktails.json')

app.app_name_run
users.user_run
#cocktails = 