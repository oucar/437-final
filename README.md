
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


## Game Design
#### Credits:
- [Pixel Adventure 1 by @pixelfrog ](https://pixelfrog-assets.itch.io/pixel-adventure-1) 
- [Pixel Adventure 2 by @pixelfrog  ](https://pixelfrog-assets.itch.io/pixel-adventure-2) 
- [Lunar Harvest by @FoxSynergy]()https://opengameart.org/content/lunar-harvest
- [8 bit gun sound effect by @Luke.RUSTLTD](https://opengameart.org/content/gunloop-8bit)
### Player
- Idle
	![Player Idle](https://raw.githubusercontent.com/oucar/437-final/master/Assets/Pixel%20Adventure%201/Main%20Characters/Virtual%20Guy/Idle%20(32x32).png?token=ANZTQTEUIV6PFUB6DHBWZDDBWRLI2)
- Run
![Player Run](https://raw.githubusercontent.com/oucar/437-final/master/Assets/Pixel%20Adventure%201/Main%20Characters/Virtual%20Guy/Run%20(32x32).png?token=ANZTQTEJ5ODG3XQL3LJMM7TBWRLVW)
- Hit
![Player Hit](https://raw.githubusercontent.com/oucar/437-final/master/Assets/Pixel%20Adventure%201/Main%20Characters/Virtual%20Guy/Hit%20(32x32).png?token=ANZTQTGRPMV6GD2UPZWCEW3BWRLZ6)
- Fall
![Player Fall](https://raw.githubusercontent.com/oucar/437-final/master/Assets/Pixel%20Adventure%201/Main%20Characters/Virtual%20Guy/Fall%20(32x32).png?token=ANZTQTCD2X7ZPW33UGRBFVDBWRL5S)
- Jump
![Player Jump](https://raw.githubusercontent.com/oucar/437-final/master/Assets/Pixel%20Adventure%201/Main%20Characters/Virtual%20Guy/Jump%20(32x32).png?token=ANZTQTHH3CF5YEP6C5XSY3LBWRL3M)
- Wall Jump
![Player Wall Jump](https://raw.githubusercontent.com/oucar/437-final/master/Assets/Pixel%20Adventure%201/Main%20Characters/Virtual%20Guy/Wall%20Jump%20(32x32).png?token=ANZTQTET77SGNBZR2JPFH6LBWRL4W)
- Double Jump
![Player Dobule Jump](https://raw.githubusercontent.com/oucar/437-final/master/Assets/Pixel%20Adventure%201/Main%20Characters/Virtual%20Guy/Double%20Jump%20(32x32).png?token=ANZTQTBENYCUWYYOVEURHBLBWRL4E)



### Enemy
- Idle
	![Enemy Idle](https://raw.githubusercontent.com/oucar/437-final/master/Assets/Pixel%20Adventure%202/Enemies/Bee/Idle%20(36x34).png?token=ANZTQTHVAX7VXVZWW7P7W7DBWRMZM)
- Attack
	![Enemy Attack](https://raw.githubusercontent.com/oucar/437-final/master/Assets/Pixel%20Adventure%202/Enemies/Bee/Attack%20(36x34).png?token=ANZTQTHEW2SUULZDXH74KFDBWRNCO)
- Hit
	![Enemy Hit](https://raw.githubusercontent.com/oucar/437-final/master/Assets/Pixel%20Adventure%202/Enemies/Bee/Hit%20(36x34).png?token=ANZTQTFKNCAZQFJLAWS4YATBWRM7M)
- Projectile
	![Enemy Idle](https://raw.githubusercontent.com/oucar/437-final/master/Assets/Pixel%20Adventure%202/Enemies/Bee/Bullet.png?token=ANZTQTB2O5B44N5IBLQGKJ3BWRNAO)

### Tileset
Tilesets were super easy to implement, thanks to Godot.

![Tileset](https://raw.githubusercontent.com/oucar/437-final/master/Assets/Pixel%20Adventure%201/Terrain/Terrain%20(16x16).png?token=ANZTQTDIW7WCBINOER3QTHDBWRNE2)

### Scenes / Level
Scene changes when Player body enters the collision shape of the below flag.
![Flag](https://raw.githubusercontent.com/oucar/437-final/master/Assets/Pixel%20Adventure%201/Items/Checkpoints/Checkpoint/Checkpoint%20(Flag%20Idle)(64x64).png?token=ANZTQTDJP4LNEMXPCLGASPTBWRQ64)

There are currently 3 different levels in the game.
#### Level 1
Even though this is the first level in the game, it is the most challenging one. It was actually harder than it is right now, but I made some of the platforms bigger and removed 3 bees from the scene to make it a little bit more possible to get to the flag.
![Level 1](https://raw.githubusercontent.com/oucar/437-final/master/Assets/Github/Level1.png?token=ANZTQTFCZJR7NESPNKKWL7DBWRRPS)
#### Level 2
Another level design, it is as difficult as the first one.  Try to get to the flag.
![Level 2](https://raw.githubusercontent.com/oucar/437-final/master/Assets/Github/Level2.png?token=ANZTQTCAGPPSHRFLUZSH3VLBWRRQE)
#### Level 3
There is nothing special in this level. You have to jump of off the cliff the end the game and see how many enemies (bees) you killed during the game.
![Level 3](https://raw.githubusercontent.com/oucar/437-final/master/Assets/Github/Level3.png?token=ANZTQTHKWWAUR4VMUQZQPRDBWRRR6)



## State Transition Diagram

## User Instructions