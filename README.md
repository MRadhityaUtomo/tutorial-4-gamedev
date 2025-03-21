Muhammad Radhitya Utomo
2206830744
Gamedev Class 2025

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
