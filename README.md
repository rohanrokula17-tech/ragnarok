# RAGNAROK

An original, offline, stylized 3D arena-survival prototype made for **Godot 4**. It uses only primitive meshes and generated materials—no Fortnite assets, branding, network services, or external downloads.

## Included gameplay
- Third-person movement, mouse camera, jumping and hitscan shooting
- Eight hostile arena bots that pursue and attack the player
- Health, ammunition, reloads, eliminations and win/lose states
- A simple build mechanic: press **Q** to place a solid energy barricade
- Procedurally assembled arena, crates, rocks, lighting and HUD
- Windows-friendly Godot project; no plugins or imported assets required

## Requirements
- Godot Engine 4.2 or newer (standard desktop build)
- Windows 10/11 64-bit

## Run it
1. Extract the ZIP to a normal folder (not inside the ZIP).
2. Install/open Godot 4.
3. In the Project Manager choose **Import**, then select `project.godot` from this folder.
4. Open the project and press **F6** or **F5**. The main scene is `scenes/main.tscn`.
5. If prompted to import, allow the editor to finish, then run again.

## Controls
| Input | Action |
|---|---|
| WASD | Move |
| Mouse | Aim / look |
| Left mouse | Fire |
| Space | Jump |
| R | Reload |
| Q | Place energy cover |
| Esc | Release mouse; click the game to recapture |
t upgrades: animated character models, sound effects, weapon pickups, multiple maps, bot navigation with NavigationRegion3D, settings/pause menu, and a proper shrinking safe zone.
