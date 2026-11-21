# ConsolePortLK-Enhanced_custom
Personal modifications to ConsolePort and ConsoleXP for CoA64 clients, offered for convenience.

## Requirements and Installation
1. Extract **ConsolePort** and **ConsoleXP** folders to your `[client]/Interface/Addons` directory.
2. WoWPadX (strongly recommended): https://github.com/leoaviana/WoWpadX
    - Open Settings.txt
        1. Set **"memoryAutoCenter": false,**
        2. In the **"gameProcessNames"** array, add your executable name in all lower case without the extension (AFK64.exe would be "afk64").
3. Enable **Pixel Bridge** in both WoWPadX (gear icon, 3-lines menu) and ConsolePort (Settings > General). Ensure you're not running the game in Exclusive Fullscreen.
4. Keep ConsolePort's "**Interact Button**" option *disabled*. It will conflict with the hardcoded changes.
5. (OPTIONAL) Enable `System > Interface > Action Camera`

## Changes from Source
### ConsolePort
- Cursor now automatically snaps to just-above center (matching ConsoleXP's crosshair) both after *and* before MouseLook Mode enables.
    - *Previous Behavior: Only snapped to direct center after MouseLook Mode is disabled.*
- Cursor also snaps to center and MouseLook Mode enables after closing Bags, for cases where using the cursor is preferred over the D-Pad/Stick controls.
    - *Previous Behavior: No cursor relocation or automatic switch to MouseLook Mode after any interface interactions.*
- X-button (XBOX) now hardcoded to emulate ConsolePort's "Interact Button" settings: Assign an attack or spell to X. When *not* targeting an enemy, the First press disables MouseLook Mode, and the Second press activates NPC, Object, or resource Node directly under crosshair/cursor location.
    - Implementation Note: This is due to how the "Interact With Mouseover" functionality works in combination with MouseLook. Essentially, the cursor is entirely removed during MouseLook, so it has to be disabled first. And then the function itself requires a hardware-called button press. If they were automated to activate together, they would activate on the same frame, causing the interact to fail.
    - *Previous Behavior: Entirely dependent on what settings the user had for ConsolePort's Interact Button.*
- FIX: Pixel Bridge now renders properly in top-left corner of screen.
    - *Previous Behavior: Calculations to place Pixel Bridge resulted in it rendering far off-screen, due to using measurements based on the World Render instead of the UI Layer.*
- FIX: Pixel Bridge and Cursor positioning now respect and take into account UI scaling.

### ConsoleXP
- Most settings have been removed, leaving only the crosshair toggles.
    - This is because the other settings previously required the included DLL, which is incompatible with the x64 executable. CoA already includes the ActionCam features. Unfortunately we're missing the smarter targeting functions, but that's something that can't be corrected through an addon alone, as it's an engine function.
- Crosshair has been raised slightly to more align with traditional over-the-shoulder action game line-of-sight.
- FIX: Crosshair positioning now respects and takes into account UI scaling.

## Credits
- ConsolePort: https://github.com/SuttonX/ConsolePortLK-Enhanced
- ConsoleXP: https://github.com/leoaviana/ConsoleXP
- Research assistance from Google Gemini, as while I have some LUA experience, I have very little knowledge of WoW's internal functions