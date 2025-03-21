Muhammad Radhitya Utomo
2206830744
Gamedev Class 2025

## TUTORIAL 4

CONTROLS
- WASD to move, SPACE to jump and double jump.

Changes and change flow
- Modified signal of winarea level 1 to transfer player into level 2
      - Menggunakan areawin yang diberi signal untuk mengubah ke scene level 2 ketika disentuh.
- Added Level2 scene
- Level 2 uses the grey tilemap from the preset, is more focused on vertical parkour.
- Added saw blades raining down from level2 spawner. Spawner code is similar to what is given in the tutorial, albeit faster spawn rate.
- Added static spining saws as obstacles.
- Added flag as the final winarea.

I used editable child for objects needing similar signals, although not optimal, I kind of already did it anyways so a good food for thought in the future.
The work process of the second level is similar to the level 1 creation with a spawner, tilemap painting, and lose/win areas as collision areas tied to the obstacles/flag.



## TUTORIAL 6

1. Added the tutorial prerequisites (main menu raw, health count GUI, Game Over screen)
2. Added Working Pause feature by pressing ESC while in a level.
    - Setting the process tag in the pause scene to always so that it is still interactable even if get_tree.paused = true. Link buttons added for Resume, Restart, Level Select, and Main Menu. 
3. Added working level select screen from the main menu button.
    - Used link buttons and script similar to the new game button.
4. Added working back to menu button after getting a game over.
5. Minor design addons unto main menu.
