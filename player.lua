Player = {}
q_cd = 500

w_cd_init = 500
w_cd = 0
w_cd_rate = 5

e_cd = 500
r_cd = 2000

ground_height = love.graphics.getHeight() - 300

function Player:new()
  player = {
    x = 50,
    y = ground_height,
    w = 20,
    h = 40,
    y_vel = 0,
    speed = 100, 
    facingRight = true,
    health = 3,
    jump = 600,
    gravity = 2000,
    bullets = {},
    fire_cd = 0,
    fire_cd_rate = 5
  }
  setmetatable(player, { __index = Player })
  return player
end

function Player:update(dt)
  -- Movement
  if love.keyboard.isDown("left") then 
    player.x = player.x - player.speed * dt
    player.facingRight = false
  elseif love.keyboard.isDown("right") then 
    player.x = player.x + player.speed * dt
    player.facingRight = true
  end
  
  -- Jump
  if love.keyboard.isDown("space") then 
    if player.y_vel == 0 then -- player not jumping
      player.y_vel = player.jump
    end
  end
  
  if player.y_vel ~= 0 then 
    player.y = player.y - player.y_vel * dt
    player.y_vel = player.y_vel - player.gravity * dt
  end
  
  if player.y >= ground_height then 
    player.y = ground_height
    player.y_vel = 0
  end
  
  -- Fire 
  player.fire_cd = player.fire_cd - player.fire_cd_rate
  if love.keyboard.isDown("f") and player.fire_cd <= 0 then -- Activate basic attack
    player.fire_cd = 100
    Player:fire()
  end
  
  -- Skills
  if love.keyboard.isDown("q") then -- Activate piercing
    Player:Q(dt) 
  end
  
  w_cd = w_cd - w_cd_rate
  if love.keyboard.isDown("w") and w_cd <= 0 then -- Activate lock-on
    Player:W(dt) 
    w_cd = w_cd_init
  end
  
  if love.keyboard.isDown("e") then -- Activate roll
    Player:E(dt) 
  end
  
  if love.keyboard.isDown("r") then -- Activate ult
    Player:R(dt)
  end
end

function Player:bulletUpdate(dt)
  for i, bullet in ipairs(player.bullets) do 
    if bullet.facingRight == true then -- bullet moves right
      bullet.x = bullet.x + bullet.speed * dt
    else -- bullet moves left
      bullet.x = bullet.x - bullet.speed * dt
    end
  end
end

function Player:draw()   
  -- Draw player
  love.graphics.rectangle("fill", player.x, player.y, player.w, player.h)
  
  -- Draw bullets
  for i, bullet in ipairs(player.bullets) do 
    love.graphics.rectangle("fill", bullet.x, bullet.y, bullet.w, bullet.h)
  end
end


function Player:fire()
  newBullet = {
    x = player.x, 
    y = player.y,
    w = 10, 
    h = 10,
    speed = 400, 
    facingRight = player.facingRight
  }
  table.insert(player.bullets, newBullet)
end

function Player:Q(dt)
  
end

function Player:W(dt)
  if player.facingRight == true then -- roll to the right 
    player.x = player.x + 3000 * dt
  else 
    player.x = player.x - 3000 * dt
  end
end

function Player:E(dt)

end

function Player:R(dt)

end
