# Casa-de-Java

## BTD -- An APCS2 Final Project

**Contributors:**

Kevin Wang

Larry Wong

Alvin Ye

## The Game:
This project gives the user a part of the whole Balloons Tower Defense experience. Users will be able to create their own maps and these maps will be tested by the program to see if they are viable for the game. By creating their own map, the user has to balance out the time it takes for the enemies to reach their goal verses the space available for tower placement. Once the user creates a map, the enemies will spawn and follow the shortest path within the user-generated map. While the game is running, users will have to strategically place their towers to fend off the incoming wave of enemies. However, the user is limited by the amount of money they possess and the space available to place their towers. As the game progresses, the enemies will become stronger and the user will have the ability to upgrade their towers to better fend off the enemies. 

## Functionality:
Once the user runs the program, a message will appear on the screen with the general greetings and credits. 

Once that is over, the user will be given a screen with directions on how to create a map. Then, a grid will appear (1200x500) with 25x25 square cells. The cells are white by default, however, once the user clicks on the cells, it turns red and creating a traversable cell for the enemy. The yellowish-brown square on the top left will reset all the cells to the default white. Once the user is done, the user has to click the cyan cell on the bottom right and the program proceeds to save the map. The grid is a array of objects and these objects are transcribed into a .txt file in the form of characters (# - wall, * - path, & - goal). The program proceeds to check if the maze is traversable from the beginning to the end by a backtracking algorithm called Depth First Search. This algorithm checks all possible routes to ensure that there is a path to the exits. If this path does not exist, the user will be prompted to fix the maze. Once the maze is checked and it is a functioning maze, another algorithm (Breath First Search) searches for a short path from the beginning to the end. This algorithm traverses each available cell from the current cell to check if it is the exit, if not, it goes to the next available cell (keeping track of the parent cell) and repeats the process until the end. Once the path is found, the grid disappears and the maze is printed into the pixels in the background. This is where the game begins.

## Tasks

- [ ] create enemy bloons and algo for movement of bloons following a path
- [ ] allow for validation of weapons location
- [ ] allow for upgrading of attacks and defenses
- [ ] allow for different difficulties
- [ ] create different shapes to use in game
- [ ] create maps
- [ ] allow for reading of `.txt` files
- [ ] create algo for path finding based on backtracking

## Installing and Running

To download:
- You may clone the repository by running `git clone git@github.com:LarWong/Casa-de-Java.git` in a terminal session. You must have git installed to do so. Git downloads may be found [here](https://git-scm.com/downloads).
- You may download the files as a ZIP directly from this website.

In order to run the game, you must have Processing installed. It is recommended that you have Processing 3. You may find the download files [here](https://processing.org/download/). Open up `shooter.pde` in Processing and run it.

Once everything is installed, run Processing and open BTD. The game will immediately begin from there.

## How to Play

Run the program and click your mouse to begin.

## Features

## Bugs
