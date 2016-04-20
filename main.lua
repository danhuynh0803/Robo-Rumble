require("camera")
require("player")
require("enemy")

enemy_controller = {}
enemy_spawn_init = 500
enemy_spawn_timer = enemy_spawn_init


ground_height = love.graphics.getHeight() - 300

particle_systems = {}
--particle_system.img = love.graphics.newImage("particle.png")

function particle_systems:spawn(x,y)
  local ps = love.graphics.newParticleSystem(particle_systems.img, 32)
  ps:setParticleLifetime(2, 4)
  ps:setEmissionRate(5)
  ps:setSizeVariation(1)
  ps:setLinearAcceleration(-20, -20, 20, 20)
  ps:setColors(100, 255, 100, 0, 255, 0)
end

function love.load() 
  -- Draw bg 
  love.graphics.setBackgroundColor(122, 195, 255)
  p = Player:new()
  e = Enemy:new()
end

function love.update(dt)     
  p:update(dt)
  e:update(dt)
  
  p:bulletUpdate(dt)
  
  if enemy_spawn_timer <= 0 then -- Spawn enemy
    newEnemy = Enemy:new() 
    table.insert(enemy_controller, newEnemy)
  end
  
  mapCollision()
  
  if love.keyboard.isDown("escape") then -- exit game
    love.event.push("quit")
  end
  
  
  -- Move camera to follow player
  if player.x > love.graphics.getWidth() / 2 then 
    camera.x = player.x - love.graphics.getWidth() / 2
  end
  
end

function mapCollision()
  if p.x < 0 then 
    p.x = 0
  end
end

function checkCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return  x1 < x2+w2 and 
          x2 < x1+w1 and
          y1 < y2+h2 and 
          y2 < y1+h1
end

function love.draw()   
  camera:set()  
  p:draw() -- Draw player
  e:draw() 
  for i, enemy in ipairs(enemy_controller) do     
    enemy:draw() -- Draw enemies
  end
  
  camera:unset()
end


  