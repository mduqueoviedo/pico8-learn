pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
-- button codes
-- 0 left
-- 1 right
-- 2 up
-- 3 down
-- 4 o/z/c
-- 5 x/v/m

function _init()
	-- game settings
	game = {}
	game.floor_y = 70
	
	-- player values
	player = {}
	player.x = 5
	player.y = game.floor_y
	player.sprite = 1
	player.speed = 2
	player.jump_height = 15
	player.moving = false
end

function _update()
	player.moving = false
	move_listener()
end

function _draw()
	cls() -- clear screen
	spr(player.sprite, player.x, player.y)
	print(player.y)
end

function move_listener()
	if btn(0) then
		player.moving = true
		player.x -= player.speed
		update_spr()
	end

	if btn(1) then
		player.moving = true
		player.x += player.speed
		update_spr()
	end

	-- if btn(3) then -- ducking
	-- 	player.moving = true
	-- 	player.y += player.speed
	-- 	move()
	-- end

	if btn(2) then -- jump
		if player_in_floor() then
			player.goes_up = true 
		end

		if (player.goes_up and player.y > player_jump_height()) then
			player.y -= player.speed
		end

		if (player.y <= player_jump_height()) then
			player.goes_up = false
		end
	end

	if not btn(2) and player.goes_up then
		player.goes_up = false
	end

	if not player.goes_up and not player_in_floor() then
		player.y += player.speed
	end
end

function update_spr()
	player.moving = true
	player.sprite += 1

	if player.sprite > 3 then
	  player.sprite = 1
	end
end

function player_in_floor()
	return player.y == game.floor_y
end

function player_jump_height()
	return game.floor_y - player.jump_height
end


__gfx__
00000000000088880000888800008888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000080808880808088808080888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700800888888008888880088888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000808888008088880080888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000888880008888800088888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700888888808888888088888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000888880808888800088888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000080080008008000008080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
