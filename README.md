# Puzzle Game Test

The aim of this Godot project is to create a robust prototype for 2D puzzle and RPG games with a top-down camera perspective.

I decided that this project was necessary because I did not see any Godot tutorials or examples of this very specific set of mechanics. By that I mean:

* A 2D top-down camera perspective
* Free, cardinal/intercardinal direction movement for the player
* Grid-based, modular levels whose state can be stored and brought back from memory
* The ability for the player to push objects around on the level's grid

Basically, I wanted to make a prototype that mimics the behaviour of games like Pokemon and Golden Sun.

I forked the project from [GDQuest's puzzle tutorial](https://github.com/GDquest/kickstarter-quest-3/tree/master/01-29-puzzle-game/end), where Guilherme implements the grid-based objects and the pushing mechanic.

The first and largest problem that I tackled was having [separate levels that can be loaded and unloaded](https://godotengine.org/qa/44664/how-can-i-move-the-player-from-one-tilemap-to-another). I solved this using a manual scene switcher script, which is why the repo is named "warptest" -- the player is warped between levels when they enter "portals".

More notes about my journey and resources can be found in the Github Project Board.

I hope to eventually open source this prototype, but a lot of the codebase is messy and bad. All I can guarantee is that it works!

## UPDATE Fall 2019:

I was able to get this prototype to an acceptable state! I used it in a game jam to make a game called "ZERO" ! Play it here:

https://hughbee.itch.io/zero

I hope to use and improve on this prototype in the future to make a full commercial game.
