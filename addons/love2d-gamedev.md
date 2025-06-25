# Love2D Game Development Addon

## Purpose
This addon provides comprehensive guidelines for Cursor OS to create professional, well-structured Love2D game projects. It covers project organization, best practices, different game genres, and complete development workflows from concept to distribution.

## Core Love2D Philosophy

### 1. Game Development Best Practices
- **Clean code architecture** with proper separation of concerns
- **Component-based design** for reusable game entities
- **State management** for different game screens (menu, gameplay, pause)
- **Asset organization** with logical folder structure
- **Performance optimization** for smooth 60 FPS gameplay
- **Cross-platform compatibility** (Windows, macOS, Linux, Android, iOS)

### 2. Project Structure Standards
Every Love2D project should follow a consistent, scalable structure that supports growth from prototype to full game.

## Project Structure Template

```
game-project/
├── README.md                     # Project overview and setup instructions
├── conf.lua                     # Love2D configuration file
├── main.lua                     # Entry point and game loop
├── .gitignore                   # Git ignore patterns
├── .luacheckrc                  # Lua linting configuration
├── build/                       # Build scripts and distributables
│   ├── build.sh                 # Build script for multiple platforms
│   ├── love-release.lua         # Love2D release script
│   └── distributables/          # Generated game builds
├── 
├── src/                         # Source code
│   ├── states/                  # Game state management
│   │   ├── gamestate.lua        # Base gamestate class
│   │   ├── menu.lua             # Main menu state
│   │   ├── game.lua             # Main gameplay state
│   │   ├── pause.lua            # Pause state
│   │   ├── gameover.lua         # Game over state
│   │   └── settings.lua         # Settings state
│   │
│   ├── entities/                # Game entities and components
│   │   ├── entity.lua           # Base entity class
│   │   ├── player.lua           # Player entity
│   │   ├── enemy.lua            # Enemy entities
│   │   ├── projectile.lua       # Projectiles/bullets
│   │   └── powerup.lua          # Power-ups and collectibles
│   │
│   ├── systems/                 # Game systems
│   │   ├── input.lua            # Input handling system
│   │   ├── physics.lua          # Physics and collision system
│   │   ├── animation.lua        # Animation system
│   │   ├── particle.lua         # Particle effects system
│   │   ├── audio.lua            # Audio management system
│   │   └── camera.lua           # Camera system
│   │
│   ├── utils/                   # Utility functions and helpers
│   │   ├── math.lua             # Math utilities
│   │   ├── table.lua            # Table manipulation utilities
│   │   ├── string.lua           # String utilities
│   │   ├── timer.lua            # Timer and tween utilities
│   │   └── debug.lua            # Debug helpers
│   │
│   ├── ui/                      # User interface components
│   │   ├── button.lua           # Button component
│   │   ├── slider.lua           # Slider component
│   │   ├── textbox.lua          # Text input component
│   │   ├── hud.lua              # HUD elements
│   │   └── menu.lua             # Menu components
│   │
│   └── config/                  # Configuration and constants
│       ├── settings.lua         # Game settings
│       ├── constants.lua        # Game constants
│       └── controls.lua         # Control mappings
│
├── assets/                      # Game assets
│   ├── graphics/                # Images and sprites
│   │   ├── sprites/             # Character and object sprites
│   │   ├── backgrounds/         # Background images
│   │   ├── ui/                  # UI graphics
│   │   └── effects/             # Visual effects
│   │
│   ├── audio/                   # Sound and music
│   │   ├── music/               # Background music
│   │   ├── sfx/                 # Sound effects
│   │   └── voice/               # Voice acting (if applicable)
│   │
│   ├── fonts/                   # Font files
│   ├── shaders/                 # GLSL shader files
│   └── data/                    # Game data files
│       ├── levels/              # Level definitions
│       ├── animations/          # Animation data
│       └── localization/        # Translation files
│
├── tests/                       # Test files
│   ├── unit/                    # Unit tests
│   ├── integration/             # Integration tests
│   └── test_runner.lua          # Test execution script
│
├── docs/                        # Documentation
│   ├── design.md                # Game design document
│   ├── technical.md             # Technical documentation
│   ├── art_style.md             # Art style guide
│   └── audio_design.md          # Audio design document
│
└── libs/                        # Third-party libraries
    ├── gamestate.lua            # Gamestate management library
    ├── camera.lua               # Camera library
    ├── timer.lua                # Timer/tween library
    ├── bump.lua                 # Collision detection library
    └── lume.lua                 # Lua utilities library
```

## Game Type Templates

### 1. Platformer Game

**Core Components:**
```lua
-- src/entities/player.lua
local Player = {}
Player.__index = Player

function Player:new(x, y)
    local player = {
        x = x,
        y = y,
        width = 32,
        height = 32,
        velocityX = 0,
        velocityY = 0,
        speed = 200,
        jumpPower = 400,
        onGround = false,
        sprite = love.graphics.newImage("assets/graphics/sprites/player.png"),
        animation = require("src.systems.animation"):new()
    }
    return setmetatable(player, Player)
end

function Player:update(dt)
    -- Handle input
    self:handleInput(dt)
    
    -- Apply physics
    self:applyPhysics(dt)
    
    -- Update animation
    self.animation:update(dt)
    
    -- Collision detection
    self:checkCollisions()
end

function Player:handleInput(dt)
    if love.keyboard.isDown("left", "a") then
        self.velocityX = -self.speed
    elseif love.keyboard.isDown("right", "d") then
        self.velocityX = self.speed
    else
        self.velocityX = 0
    end
    
    if (love.keyboard.isDown("space", "up", "w")) and self.onGround then
        self.velocityY = -self.jumpPower
        self.onGround = false
    end
end

function Player:applyPhysics(dt)
    -- Gravity
    if not self.onGround then
        self.velocityY = self.velocityY + 800 * dt
    end
    
    -- Update position
    self.x = self.x + self.velocityX * dt
    self.y = self.y + self.velocityY * dt
end

function Player:draw()
    love.graphics.draw(self.sprite, self.x, self.y)
end

return Player
```

### 2. Top-Down Shooter

**Core Components:**
```lua
-- src/entities/player.lua
local Player = {}
Player.__index = Player

function Player:new(x, y)
    local player = {
        x = x,
        y = y,
        width = 32,
        height = 32,
        speed = 150,
        health = 100,
        maxHealth = 100,
        angle = 0,
        sprite = love.graphics.newImage("assets/graphics/sprites/player.png"),
        weapon = require("src.entities.weapon"):new("pistol")
    }
    return setmetatable(player, Player)
end

function Player:update(dt)
    self:handleMovement(dt)
    self:handleAiming()
    self:handleShooting(dt)
    self.weapon:update(dt)
end

function Player:handleMovement(dt)
    local dx, dy = 0, 0
    
    if love.keyboard.isDown("w", "up") then dy = dy - 1 end
    if love.keyboard.isDown("s", "down") then dy = dy + 1 end
    if love.keyboard.isDown("a", "left") then dx = dx - 1 end
    if love.keyboard.isDown("d", "right") then dx = dx + 1 end
    
    -- Normalize diagonal movement
    if dx ~= 0 and dy ~= 0 then
        dx = dx * 0.707
        dy = dy * 0.707
    end
    
    self.x = self.x + dx * self.speed * dt
    self.y = self.y + dy * self.speed * dt
end

function Player:handleAiming()
    local mouseX, mouseY = love.mouse.getPosition()
    self.angle = math.atan2(mouseY - self.y, mouseX - self.x)
end

function Player:handleShooting(dt)
    if love.mouse.isDown(1) then
        self.weapon:shoot(self.x, self.y, self.angle)
    end
end

return Player
```

### 3. Puzzle Game

**Core Components:**
```lua
-- src/systems/grid.lua
local Grid = {}
Grid.__index = Grid

function Grid:new(width, height, cellSize)
    local grid = {
        width = width,
        height = height,
        cellSize = cellSize,
        cells = {},
        selectedX = nil,
        selectedY = nil
    }
    
    -- Initialize grid
    for x = 1, width do
        grid.cells[x] = {}
        for y = 1, height do
            grid.cells[x][y] = {
                type = "empty",
                color = {1, 1, 1},
                animating = false
            }
        end
    end
    
    return setmetatable(grid, Grid)
end

function Grid:update(dt)
    -- Update animations
    for x = 1, self.width do
        for y = 1, self.height do
            if self.cells[x][y].animating then
                -- Handle cell animations
            end
        end
    end
    
    -- Check for matches
    self:checkMatches()
end

function Grid:handleClick(mouseX, mouseY)
    local gridX = math.floor(mouseX / self.cellSize) + 1
    local gridY = math.floor(mouseY / self.cellSize) + 1
    
    if self:isValidPosition(gridX, gridY) then
        self:selectCell(gridX, gridY)
    end
end

function Grid:checkMatches()
    -- Implement match-3 logic
    local matches = {}
    
    -- Check horizontal matches
    for y = 1, self.height do
        local count = 1
        for x = 2, self.width do
            if self.cells[x][y].type == self.cells[x-1][y].type and 
               self.cells[x][y].type ~= "empty" then
                count = count + 1
            else
                if count >= 3 then
                    -- Add match to list
                end
                count = 1
            end
        end
    end
    
    return matches
end

return Grid
```

## Essential Love2D Libraries

### Required Libraries List
```lua
-- libs/gamestate.lua - State management
-- libs/camera.lua - Camera system
-- libs/timer.lua - Timer and tweening
-- libs/bump.lua - Collision detection
-- libs/lume.lua - Lua utilities
-- libs/anim8.lua - Animation framework
-- libs/moonshine.lua - Shader effects
-- libs/push.lua - Resolution handling
```

### Library Integration Example
```lua
-- main.lua
local Gamestate = require("libs.gamestate")
local Timer = require("libs.timer")
local Camera = require("libs.camera")

-- Game states
local Menu = require("src.states.menu")
local Game = require("src.states.game")

function love.load()
    -- Initialize game
    love.graphics.setDefaultFilter("nearest", "nearest")
    
    -- Register states
    Gamestate.registerEvents()
    Gamestate.switch(Menu)
end

function love.update(dt)
    Timer.update(dt)
end

function love.draw()
    -- Game state handles drawing
end
```

## Configuration and Settings

### conf.lua Template
```lua
function love.conf(t)
    t.identity = "your-game-name"
    t.version = "11.4"
    t.console = false
    t.accelerometerjoystick = true
    t.gammacorrect = false
    
    t.window.title = "Your Game Title"
    t.window.icon = nil
    t.window.width = 1280
    t.window.height = 720
    t.window.borderless = false
    t.window.resizable = true
    t.window.minwidth = 800
    t.window.minheight = 600
    t.window.fullscreen = false
    t.window.fullscreentype = "desktop"
    t.window.vsync = 1
    t.window.msaa = 0
    t.window.display = 1
    t.window.highdpi = false
    t.window.x = nil
    t.window.y = nil
    
    t.modules.audio = true
    t.modules.event = true
    t.modules.graphics = true
    t.modules.image = true
    t.modules.joystick = true
    t.modules.keyboard = true
    t.modules.math = true
    t.modules.mouse = true
    t.modules.physics = true
    t.modules.sound = true
    t.modules.system = true
    t.modules.thread = true
    t.modules.timer = true
    t.modules.touch = true
    t.modules.video = true
    t.modules.window = true
end
```

## Performance Optimization

### 1. Graphics Optimization
```lua
-- Batch drawing for sprites
local spriteBatch = love.graphics.newSpriteBatch(texture, 1000)

function love.draw()
    spriteBatch:clear()
    
    for _, sprite in ipairs(sprites) do
        spriteBatch:add(sprite.x, sprite.y)
    end
    
    love.graphics.draw(spriteBatch)
end

-- Use canvases for static elements
local backgroundCanvas = love.graphics.newCanvas()
love.graphics.setCanvas(backgroundCanvas)
-- Draw background once
love.graphics.setCanvas()
```

### 2. Memory Management
```lua
-- Object pooling for projectiles
local ProjectilePool = {}

function ProjectilePool:new(size)
    local pool = {
        objects = {},
        active = {},
        inactive = {}
    }
    
    for i = 1, size do
        local obj = Projectile:new(0, 0)
        obj.active = false
        table.insert(pool.inactive, obj)
    end
    
    return setmetatable(pool, {__index = self})
end

function ProjectilePool:get()
    if #self.inactive > 0 then
        local obj = table.remove(self.inactive)
        obj.active = true
        table.insert(self.active, obj)
        return obj
    end
    return nil
end
```

## Audio System

### Audio Manager Template
```lua
-- src/systems/audio.lua
local Audio = {}

Audio.music = {}
Audio.sfx = {}
Audio.currentMusic = nil
Audio.musicVolume = 1.0
Audio.sfxVolume = 1.0

function Audio:loadMusic(name, path)
    self.music[name] = {
        source = love.audio.newSource(path, "stream"),
        volume = 1.0
    }
    self.music[name].source:setLooping(true)
end

function Audio:loadSFX(name, path)
    self.sfx[name] = {
        source = love.audio.newSource(path, "static"),
        volume = 1.0
    }
end

function Audio:playMusic(name, fadeTime)
    if self.currentMusic then
        self:stopMusic(fadeTime)
    end
    
    if self.music[name] then
        local source = self.music[name].source
        source:setVolume(self.musicVolume * self.music[name].volume)
        love.audio.play(source)
        self.currentMusic = name
    end
end

function Audio:playSFX(name, pitch, volume)
    if self.sfx[name] then
        local source = self.sfx[name].source:clone()
        source:setPitch(pitch or 1.0)
        source:setVolume((volume or 1.0) * self.sfxVolume * self.sfx[name].volume)
        love.audio.play(source)
    end
end

return Audio
```

## Input System

### Input Manager Template
```lua
-- src/systems/input.lua
local Input = {}

Input.bindings = {}
Input.pressed = {}
Input.released = {}

function Input:bind(key, action)
    if not self.bindings[action] then
        self.bindings[action] = {}
    end
    table.insert(self.bindings[action], key)
end

function Input:update()
    -- Clear previous frame data
    self.pressed = {}
    self.released = {}
end

function Input:keypressed(key)
    for action, keys in pairs(self.bindings) do
        for _, bindKey in ipairs(keys) do
            if key == bindKey then
                self.pressed[action] = true
            end
        end
    end
end

function Input:keyreleased(key)
    for action, keys in pairs(self.bindings) do
        for _, bindKey in ipairs(keys) do
            if key == bindKey then
                self.released[action] = true
            end
        end
    end
end

function Input:isDown(action)
    if self.bindings[action] then
        for _, key in ipairs(self.bindings[action]) do
            if love.keyboard.isDown(key) then
                return true
            end
        end
    end
    return false
end

function Input:wasPressed(action)
    return self.pressed[action] or false
end

function Input:wasReleased(action)
    return self.released[action] or false
end

return Input
```

## Testing Framework

### Unit Testing Template
```lua
-- tests/test_runner.lua
local tests = {}
local passed = 0
local failed = 0

function test(name, func)
    table.insert(tests, {name = name, func = func})
end

function assert_equal(expected, actual, message)
    if expected ~= actual then
        error(message or string.format("Expected %s, got %s", tostring(expected), tostring(actual)))
    end
end

function run_tests()
    print("Running tests...")
    
    for _, testCase in ipairs(tests) do
        local success, err = pcall(testCase.func)
        
        if success then
            print("✓ " .. testCase.name)
            passed = passed + 1
        else
            print("✗ " .. testCase.name .. ": " .. err)
            failed = failed + 1
        end
    end
    
    print(string.format("\nResults: %d passed, %d failed", passed, failed))
end

-- Example tests
test("Player movement", function()
    local Player = require("src.entities.player")
    local player = Player:new(100, 100)
    
    player.x = player.x + 10
    assert_equal(110, player.x, "Player X position should increase")
end)

test("Collision detection", function()
    local rect1 = {x = 0, y = 0, width = 10, height = 10}
    local rect2 = {x = 5, y = 5, width = 10, height = 10}
    
    local collision = checkCollision(rect1, rect2)
    assert_equal(true, collision, "Rectangles should collide")
end)

return {run_tests = run_tests}
```

## Build and Distribution

### Build Script Template
```bash
#!/bin/bash
# build/build.sh

GAME_NAME="YourGameName"
VERSION="1.0.0"

echo "Building $GAME_NAME v$VERSION..."

# Create build directory
mkdir -p build/distributables

# Windows build
echo "Building for Windows..."
love-release -M $GAME_NAME -W $VERSION -u "YourName" -a "Your Game" \
    --uti com.yourname.yourgame \
    --output build/distributables \
    --love-version 11.4

# macOS build  
echo "Building for macOS..."
love-release -M $GAME_NAME -m $VERSION -u "YourName" -a "Your Game" \
    --uti com.yourname.yourgame \
    --output build/distributables \
    --love-version 11.4

# Linux build
echo "Building for Linux..."
love-release -M $GAME_NAME -l $VERSION -u "YourName" -a "Your Game" \
    --uti com.yourname.yourgame \
    --output build/distributables \
    --love-version 11.4

echo "Build complete! Check build/distributables/"
```

## Documentation Templates

### Game Design Document Template
```markdown
# Game Design Document: [Game Name]

## Overview
- **Genre**: [e.g., Platformer, Puzzle, Shooter]
- **Platform**: PC, Mobile, Console
- **Target Audience**: [Age range and demographics]
- **Development Time**: [Estimated timeline]

## Core Gameplay
### Main Mechanics
1. **Primary Mechanic**: [Core player action]
2. **Secondary Mechanics**: [Supporting gameplay elements]
3. **Progression System**: [How player advances]

### Game Flow
1. **Tutorial**: [How players learn the game]
2. **Early Game**: [First 10 minutes experience]
3. **Mid Game**: [Core gameplay loop]
4. **End Game**: [How game concludes]

## Art Style
- **Visual Style**: [2D pixel art, hand-drawn, etc.]
- **Color Palette**: [Primary colors and mood]
- **Animation Style**: [Frame-by-frame, tweened, etc.]

## Audio Design
- **Music Style**: [Orchestral, chiptune, ambient, etc.]
- **Sound Effects**: [Realistic, stylized, minimal]
- **Audio Cues**: [How audio supports gameplay]

## Technical Requirements
- **Resolution**: [Target screen size]
- **Frame Rate**: [Target FPS]
- **Platform Requirements**: [Minimum specs]
```

## Quality Assurance

### Code Quality Checklist
- [ ] **Consistent coding style** throughout project
- [ ] **Proper error handling** for file loading and user input
- [ ] **Frame rate optimization** maintaining 60 FPS
- [ ] **Memory management** preventing leaks
- [ ] **Input responsiveness** no delayed controls
- [ ] **Cross-platform compatibility** tested on target platforms
- [ ] **Save system functionality** (if applicable)
- [ ] **Audio mixing** balanced volumes
- [ ] **Visual polish** consistent art style
- [ ] **User interface clarity** intuitive controls

### Testing Protocol
1. **Functional Testing**:
   - All game mechanics work as intended
   - UI elements respond correctly
   - Save/load system functions properly

2. **Performance Testing**:
   - Frame rate remains stable
   - Memory usage within acceptable limits
   - Loading times are reasonable

3. **Usability Testing**:
   - Controls are intuitive
   - Tutorial is clear and helpful
   - Game difficulty curve is appropriate

## Implementation Commands for Cursor OS

**When user requests a Love2D game:**

1. **Determine game type** from user description:
   - Platformer, shooter, puzzle, RPG, etc.
   - Extract key mechanics and features
   - Identify target complexity level

2. **Create project structure**:
   ```bash
   # Create complete folder structure in documents/projects/
   # Set up all necessary directories and files
   # Copy appropriate templates based on game type
   ```

3. **Generate core files**:
   - `main.lua` with proper game loop
   - `conf.lua` with optimized settings
   - State management system
   - Entity/component templates
   - Input and audio systems

4. **Add game-specific components**:
   - Player character with appropriate controls
   - Game mechanics specific to genre
   - UI elements and menus
   - Sample assets and placeholders

5. **Include development tools**:
   - Debug console and helpers
   - Performance monitoring
   - Hot-reloading setup
   - Build scripts

6. **Create documentation**:
   - README with setup instructions
   - Game design document template
   - Code architecture explanation
   - Asset requirements list

7. **Set up testing framework**:
   - Unit test structure
   - Integration test examples
   - Performance benchmarks

Remember: **Every Love2D project should be a complete, playable prototype that demonstrates best practices and can be extended into a full game.** 