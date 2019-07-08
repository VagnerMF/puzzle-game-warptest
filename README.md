# Puzzle Game Test

The aim of this Godot project is to create a robust prototype for 2D puzzle and RPG games with a top-down camera perspective.

I decided that this project was necessary because I did not see any Godot tutorials or examples of this very specific set of mechanics. By that I mean:

* A 2D topdown camera perspective
* Free, cardinal player movement
* Grid-based, modular levels whose state can be stored and brought back from memory
* The ability for the player to push objects around the level

Basically, I wanted to make a prototype that mimics the world behaviour of games like Pokemon and Golden Sun.

I forked the project from [GDQuest's puzzle tutorial](https://github.com/GDquest/kickstarter-quest-3/tree/master/01-29-puzzle-game/end), where Guilherme implements the grid-based objects and the pushing mechanic.

The first and largest problem that I tackled was having [separate levels that can be loaded and unloaded](https://godotengine.org/qa/44664/how-can-i-move-the-player-from-one-tilemap-to-another). I solved this using a manual scene switcher script, which is why the repo is named "warptest" -- the player is warped between levels when they enter "portals".

More notes about my journey and resources can be found in the corresponding Github Project board.

I hope to eventually open source this prototype, but a lot of the codebase isn't perfect. I might just move to making a full game when I decide the prototype has enough polish. All I can guarantee is that it works!
