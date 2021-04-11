# Cocktail Cache

## About

Cocktail Cache was built with simplicity in mind!

After you've entered a new username or selected an existing, you're able to start exploring. Here on out all navigation is menu based and no written input is required.
Find a cocktail you'd love to save for later, add it to your favourites. Feeling adventurous and want to see what lady luck can offer; generate a random cocktail. Have a particular Aunt who loves Brandy, search by ingredient! 
Our selection options may not be vast but our Cocktail Inventory sure is!

## Installation 

1. Clone repo from:

[GitHub - Cocktail Cache Terminal App](https://github.com/kimckenna/cocktail_cache)<br>

2. In the Terminal run: 

To install: 
```./install.sh```

This will install: 
```gem install bundler```
```bundle install```

To run: 
```./cocktail_cache.sh```


## Dependencies 

This App was built and tested using Ruby 2.7.2
As a result it requires Ruby to run.

For more information on downloading Ruby for your OS visit: 
[Ruby: Download](https://www.ruby-lang.org/en/downloads/)

### Gems:

*Installed automatically if using ./install.sh*

- rspec 3.10
- tty-prompt 0.23.0
- colorize 0.8.1
- json 2.5
- tty-font 0.5.0

## Help

Cocktail Cache has command line arguments including help menu that can be accessed within the terminal. 

### Available Arguments:

Run Cocktail Cache at User Selection: ***'user'*** or ***'u'***   
Run Cocktail Cache at Existing User Selection: ***'user'*** or ***'u'***
View Random Cocktail: ***'random'*** or ***'r'***
Search Cocktails: ***'search'*** or ***'s'***
Search a Users Favourites: ***'fav'*** or ***'f'*** 
- *note you will be taken to select a user first*
- *if user has no favourites you will need to reuse the 'fav' or 'f' argument*

Full functionality of Cocktail Cache requires username selection.
As a result, unless using ***'user'*** or ***'existing user'*** the app will terminate once a cocktail is populated.
