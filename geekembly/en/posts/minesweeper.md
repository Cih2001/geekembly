---
title: The Algorithm Behind Minesweeper's Tile Unveiling
date: 2025-01-11
description: Reinventing minesweeper
toc: false
---



Have you ever been curious about the algorithm that powers the user selection process in Minesweeper? When you click on an empty tile, the game unveils all adjacent empty tiles and other relevant tiles that should be exposed. This process can be executed using either a Depth-First Search (DFS) or a Breadth-First Search (BFS) algorithm.

I've simulated the DFS algorithm below. It begins when you right-click on a tile to start the game.
If the selected tile is empty, the algorithm first examines the tile to the right, then continues moving right until it reaches a terminal tile of that direction.
(terminal tile here means reaching a mine or a number).
From there, it traverses downwards, then left, and finally upward. When a teminal tile is reached, then algorithm reveals it, and then backtracks to the previous tile to continue the process.

Feel free to examine it yourself:

- **RIGHT CLICK**: Start the simulation from any tile.
- **LEFT CLICK**: Modify mine positions.

Enjoy :bomb:!

{{<minesweeper-01>}}

