## Software Engineering
#### Technologies used: 
- Godot / GDScript
#### Team:
- Onur Ucar
	- I was the only member of the team. You can check the previous commits for important development milestones of the game.
#### Development Experience
- We were developing another 2D Action-RPG game with my classmate "Nicolas Manusso", but we decided to start working on our own final projects for CSCI437. It was a little rough transition to switch from a 2D Action-RPG game to a 2D platformer for me, but many gaming mechanics still held true, such as:
- Input mechanics
- Hitboxes / Hurtboxes
- Scene creations
- Sounds
- and many more!

#### What Could Have Been Better? / Bugs
- There are a few bugs I found in my game, but they I couldn't find a solution for them at this point. 
	- The main theme music of the game restarts when you get to the next level. Actually, the reason why this happens is obvious, The 2DAudioPlayer is a child of the Player in my design. So, when you get to a new level, some of the Player attributes resets and unfortunately this includes the main theme. A possible fix to this issue might be creating a 2DAudioPlayer node in the "Singletons",  the sound can keep playing no matter what state the Player is in.
	- When you get hit by a enemy projectile (Bee Sting) more than 3 times and if you are still in Enemy's PlayerDetection zone, every new projectile hit resets the GameOverScreen. I tried many different solutions to this but it only got worse. So at this point, unfortunately I am not sure how to fix this issue but will be working on this once I am done with all my finals.
- I will be adding some extra features to my game including but not limited to:
	- New characters! Since I am using the most common Object-Oriented Programming principles in my game, this will be a huge and easy to implement feature for the game. There is an generic Enemy class in the game and another script for the Bee itself, end since Bee is an Enemy in my design, it inherits all the main methods and variables from the Enemy class. These common attributes and methods include the "waypoint" implementation and other global variables for damage and collision handling. 
	- Maybe something to use our points for. At this stage in my game, we are earning points by killing enemies but at the end of the game we don't have anything to do with those hard-earned points. I might add a top-score functionality (along with a timer) to the game to make it a little bit more competetive. 
	- I might randomly generate many platform in a tower so the Player can only go upwards meanwhile avoiding the enemies and their projectiles and trying not to miss the platforms.
	- It is possible to export our games to IOS and Android platforms. It might be a great example to test my owngame in a device other than a personal computer. 

	![Sprite]("https://github.com/oucar/437-final/blob/master/Assets/Pixel%20Adventure%201/Main%20Characters/Virtual%20Guy/Idle%20(32x32).png")


## Game Design



## State Transition Diagram

## User Instructions