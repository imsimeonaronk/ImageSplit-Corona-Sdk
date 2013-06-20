display.setStatusBar(display.HiddenStatusBar)
--display.setDefault("background",255,255,255)

-- Mask size 100 * 100  ( 96 pixel White area ,4 pixel Outline Black )
-- Image Size Should be in Multiple of Hundred 


local maskWidth = 100
local borderline = 4
local grp = display.newGroup()
local tileGroup = display.newGroup()
-- Image 
local face = display.newImage( grp, "face2.jpg" ) -- Create and add to group
-- Mask
local mask = graphics.newMask("mask.png")
-- Mask Image
grp:setReferencePoint( display.CenterReferencePoint )
grp.x = display.contentCenterX ; grp.y = display.contentCenterY
grp:setMask(mask) ;


-- Adjust Mask and Capture Tile
local i , j
local xpos , ypos = maskWidth/2 , maskWidth/2
for i=1,5,1 do
    for j=1,5,1 do
        grp.maskX = xpos  ; grp.maskY = ypos
        -- Capture current Masked Position
        local combined = display.capture( grp )
        combined.x, combined.y , combined.alpha = maskWidth, maskWidth , 0
        tileGroup:insert(combined)
        xpos =  grp.maskX + maskWidth
    end
    xpos = maskWidth/2 ; ypos = grp.maskY + maskWidth
end
i , j = nil , nil


-- remove the previous load image and group
face:removeSelf() ; face = nil
mask = nil ; grp:removeSelf() ; grp = nil


-- rotate tile image
local function rotateimage(event)
    event.target.rotation = event.target.rotation + 15
 return true
end


-- Place Tile Images
local k
local xpos1 , ypos1 = maskWidth, maskWidth
for k=1,tileGroup.numChildren,1 do
    tileGroup[k].x , tileGroup[k].y , tileGroup[k].alpha =  xpos1 , ypos1 , 1
    xpos1 = xpos1 + maskWidth - borderline 
    if k%5 == 0 then 
        ypos1 = ypos1 + maskWidth - borderline ; xpos1 = maskWidth
    end
    tileGroup[k]:addEventListener("tap",rotateimage)
end
tileGroup:setReferencePoint( display.CenterReferencePoint )
tileGroup.x , tileGroup.y = display.contentCenterX ,  display.contentCenterY
