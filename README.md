# Cocktail Cache

## About Cocktail Cache

Cocktail Cache was built with simplicity in mind.
After you've entered a new username or selected an existing, you're able to start exploring. Here on out all navigation is menu based and no written input is required.

Find a cocktail you'd love to save for later; add it to your favourites. 
Feeling adventurous and want to see what lady luck can offer; generate a random cocktail. 
Have a particular Aunt who loves Brandy; search by ingredient. 
 
Cocktail Cache; a curated app of cocktail classics. 

---
## Features

1. Favourite a Cocktail: *Create and manage your own list of favourite cocktails*
2. Request a Random Cocktail: *Select a cocktail at random; select from Cocktail Cache's full list or your own favourites* 
3. Search for a Cocktail: *Search the extensive list of cocktails by name or ingredient or explore your own favourites*

These are made possible with the use of persistent storage through multiple json files that hold the database of cocktails and usernames with favourites selected by each user.
 
Each feature's objective is to provide an IBA Cocktail to the user; they all perform their function using a web of menus and what separates them is how they achieve this end objective.

---
## Installation 

### Clone Repository:

[GitHub - Cocktail Cache Terminal App](https://github.com/kimckenna/cocktail_cache)<br> 

### To Install: 

```./install.sh```<br>

This will install: <br>
```gem install bundler```<br>
```bundle install```<br>

### To Run: 

```./cocktail_cache.sh```<br>

---
## Dependencies 

This App was built and tested using Ruby 2.7.2
As a result it requires Ruby to run.

For more information on downloading Ruby for your OS visit 
[Ruby: Download](https://www.ruby-lang.org/en/downloads/)

### Gems:

*Installed automatically if using ./install.sh*

- rspec 3.10
- tty-prompt 0.23.0
- json 2.5
- tty-font 0.5.0
- pastel

---
## Additional Help

*Cocktail Cache includes help menu that can be accessed within the terminal.*<br> 
```./cocktail_cache.sh help```<br> 

### Available Arguments:

Run Cocktail Cache at User Selection:<br> 
```'user'``` or ```'u'```<br>   

Run Cocktail Cache at Existing User Selection:<br> 
```'user'``` or ```'u'```<br>

View Random Cocktail:<br> 
```'random'``` or ```'r'```<br>

Search Cocktails:<br>
```'search'``` or ```'s'```<br>
Search a Users Favourites:
```'fav'``` or ```'f'```<br> 

- *note you will be taken to select a user first*
- *if user has no favourites you will need to reuse the 'fav' or 'f' argument*

Full functionality of Cocktail Cache requires username selection.
As a result, unless using ```'user'``` or ```'existing user'``` the app will terminate once a cocktail is populated.

---

### ENJOY!

