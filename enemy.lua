Enemy = {} 

patrol_radius = 200
movement = 0
ground_height = love.graphics.getHeight() - 300

function Enemy:new()
  enemy = {
    x = 500,
    y = ground_height,
    w = 20,
    h = 40,
    speed = 40, 
    facingRight = false,
    found_player = false,
    bullets = {},
    
  }
  setmetatable(enemy, { __index = Enemy })
  return enemy
end

function Enemy:update(dt) 
  if found_player == true then -- chase player
    Enemy:chase(dt)
  else -- resume patrol
    Enemy:patrol(dt)
  end
end

function Enemy:chase(dt) 
  
end

function Enemy:patrol(dt) 
  
  if facingRight == true then -- move right 1000 pixels    
    movement = movement + enemy.speed * dt
    enemy.x = enemy.x + enemy.speed * dt
  else 
    movement = movement + enemy.speed * dt
    enemy.x = enemy.x - enemy.speed * dt
  end
  
  if movement >= patrol_radius then -- turn to other side and patrol there
      facingRight = (not facingRight)
      movement = 0
  end 
end


function Enemy:draw() 
  love.graphics.rectangle("fill", enemy.x, enemy.y, enemy.w, enemy.h)
end

