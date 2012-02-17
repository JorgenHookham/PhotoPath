-- Load external Lua libraries (from project directory)
local ui = require( "ui" )

-- Add the fake map image
map = display.newImage( "map.png", -600, -300, true )

-- Contain all photos in an array so we can manipulate them as a group when the user drags.
-- This is necessary because Corona doesn't have support for custom map markers, or event listeners on marker.
photos = {}

photos[1] = display.newImage( "photos/photo-1.jpg", 150, 100 )
photos[2] = display.newImage( "photos/photo-2.jpg", 250, 300 )
photos[3] = display.newImage( "photos/photo-3.jpg", 650, 222 )
photos[4] = display.newImage( "photos/photo-4.jpg", 750, 677 )
photos[5] = display.newImage( "photos/photo-5.jpg", 700, 700 )
photos[6] = display.newImage( "photos/photo-6.jpg", 350, 365 )
photos[7] = display.newImage( "photos/photo-7.jpg", 200, 545 )

for key, photo in ipairs( photos ) do
	photo:scale(0.1, 0.1)
	photo:rotate(90)
end

local offsetX = 0
local offsetY = 0

function drag ( event )
	if event.phase == "moved" then

		local differenceX = (event.x - offsetX)
		local differenceY = (event.y - offsetY)
		
		for key, photo in ipairs( photos ) do 
			photo.x = photo.x + differenceX
			photo.y = photo.y + differenceY
		end

		map.x = map.x + differenceX
		map.y = map.y + differenceY

	end
	
	offsetX = event.x
	offsetY = event.y

	return true
end

function photoTouch ( event )
	if event.phase == "ended" then
		local t = event.target
		transition.to( t, {time=500, xScale = t.xScale * 10, yScale = t.yScale * 10, transition = easing.outExpo})
	end
end

Runtime:addEventListener( 'touch' , drag )

for key, photo in ipairs( photos ) do
	photo:addEventListener( 'touch' , photoTouch )
end