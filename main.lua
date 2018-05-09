-----------------------------------------------------------------------------------------
--
-- main.lua
--
-- Created by: Wendi Yu
-- Created on: May 2018
-- 
-- This file animates a charact using a spritesheet
-----------------------------------------------------------------------------------------

display.setStatusBar(display.HiddenStatusBar)
 
centerX = display.contentWidth * .5
centerY = display.contentHeight * .5

local dPad = display.newImageRect( "./assets/sprites/d-pad.png", 300, 300 )
dPad.x = 150
dPad.y = display.contentHeight - 160
dPad.id = "d-pad"
dPad.alpha = 0.5

local leftArrow = display.newImage( "./assets/sprites/leftArrow.png" )
leftArrow.x = 40
leftArrow.y = display.contentHeight - 160
leftArrow.id = "left arrow"
leftArrow.alpha = 1

local rightArrow = display.newImage( "./assets/sprites/rightArrow.png" )
rightArrow.x = 260
rightArrow.y = display.contentHeight - 160
rightArrow.id = "right arrow"
rightArrow.alpha = 1

local sheetOptionsIdle1 =
{
    width = 232,
    height = 439,
    numFrames = 10
}
local sheetIdleNinja = graphics.newImageSheet( "./assets/spritesheets/ninjaBoyIdle.png", sheetOptionsIdle1 )

local sheetOptionsIdle2 =
{
    width = 567,
    height = 556,
    numFrames = 10
}
local sheetIdleRobot = graphics.newImageSheet( "./assets/spritesheets/robotIdle.png", sheetOptionsIdle2 )

local sheetOptionsAttact =
{
    width = 536,
    height = 495,
    numFrames = 10
}
local sheetAttactNinja = graphics.newImageSheet( "./assets/spritesheets/ninjaBoyAttack.png", sheetOptionsAttact )

local sheetOptionsWalk =
{
    width = 567,
    height = 556,
    numFrames = 8
}
local sheetWalkRobot = graphics.newImageSheet( "./assets/spritesheets/robotRun.png", sheetOptionsWalk )

-- sequences table
local sequence_data = {
    -- consecutive frames sequence
    {
        name = "idle",
        start = 1,
        count = 10,
        time = 800,
        loopCount = 0,
        sheet = sheetIdleNinja
    },
    {
        name = "idle",
        start = 1,
        count = 10,
        time = 800,
        loopCount = 0,
        sheet = sheetIdleRobot
    },
    {
        name = "attack",
        start = 1,
        count = 10,
        time = 800,
        loopCount = 0,
        sheet = sheetAttactNinja
    },
    {
        name = "walk",
        start = 1,
        count = 8,
        time = 1000,
        loopCount = 0,
        sheet = sheetWalkRobot
    }       
}

local Ninja = display.newSprite( sheetIdleNinja, sequence_data )
Ninja.x = centerX
Ninja.y = centerY - 200
Ninja:setSequence( "idle" )
Ninja:play()

local Robot = display.newSprite( sheetIdleRobot, sequence_data )
Robot.x = centerX + 600
Robot.y = centerY + 300
Robot:setSequence( "idle" )
Robot:play()

function rightArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( Ninja, { 
            x = 150, 
            y = 0, 
            time = 800 
            } )
        Ninja:setSequence( "attack" )
        Ninja:play()
    end

    return true
end

function leftArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- move the character up
        transition.moveBy( Robot, { 
            x = -150, 
            y = 0, 
            time = 1000 
            } )
        Robot:setSequence( "walk" )
        Robot:play()
    end

    return true
end

local function resetToIdle (event)
    if event.phase == "ended" then
        Ninja:setSequence("idle")
        Ninja:play()
    end
end


rightArrow:addEventListener( "touch", rightArrow )
leftArrow:addEventListener( "touch", leftArrow )
Ninja:addEventListener("sprite", resetToIdle)