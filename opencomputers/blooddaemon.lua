
--[[
  TODO:
  not working for Inscription Tools
  DB Upgrade (NBT sensitive)
  LP Check (WoS running cost)
]]



-- Variables
local SLOT_INGREDIENT = 1
local SLOT_BLOOD_ORB = 2

local ingredient_item = nil
local blood_orb_item = nil
-- Rendering blood orb while crafting is fancy, right?
local blood_orb_altared = false

local DEBUG = false



-- Components
local component = require("component")
local computer = require("computer")
local os = require("os")
local sides = require("sides")

local robot = require("robot")
if not robot then
  print("Blood Daemon is a robot program!!\n(Requires Inventory Upgrade, Inventory Controller Upgrade)")
  return
end

local inv = component.inventory_controller
if not inv then
  print("Inventory Controller Upgrade is missing!!")
  return
end

-- Optional DB Upgrade (Can be NBT sensitive)
-- WIP
local db = false
if component.isAvailable("data") and component.isAvailable("database") then
  db = component.database
end

local util = {
  compareItemTable = function(item1, item2)
    -- Returns false if either stack is nil
    if not item1 or not item2 then
      return false
    end
    return item1.label == item2.label
  end,
  forceMove = function(robotMoveFunc)
    -- Retry moving after interupted
    local counter = 0
    while not robotMoveFunc() do
      counter = counter + 1
      if DEBUG and counter > 100 then
        error("Robot movement constantly failed...")
      else
        counter = 0
      end
    end
    return true
  end,
}



-- Logic implementation
-- Initialization
local function init()
  -- Validates inventory
  for i = 1, 16, 1 do
    if robot.count(i) ~= 0 then
      error("Items are detected in inventory; only blood orbs are allowed in equipment slot")
    end
  end
  robot.select(SLOT_BLOOD_ORB)
  inv.equip()
  blood_orb_item = inv.getStackInInternalSlot(SLOT_BLOOD_ORB)
  if blood_orb_item and not blood_orb_item.hasTag then
    print("NBT Tags are missing... are you sure this is \"bound\" blood orb?")
  end
  inv.equip()
  robot.select(SLOT_INGREDIENT)

  -- Examine containers
  util.forceMove(robot.forward)
  if not inv.getInventorySize(sides.bottom) then
    error("Input chest not found")
  end
  util.forceMove(robot.forward)
  if not inv.getInventorySize(sides.bottom) then
    error("Output chest not found")
  end
  util.forceMove(robot.back)
  robot.turnRight()
  util.forceMove(robot.forward)
  local altar = inv.getInventorySize(sides.front)
  if not altar or altar ~= 1 then
    error("Blood Altar not found")
  end
  util.forceMove(robot.back)
  -- now on input buffer!!
end

local function getEnergyPercent()
  return computer.energy() / computer.maxEnergy() * 100
end

-- Trip to recharge
local function recharge()
    robot.turnRight()
    util.forceMove(robot.forward)
    robot.turnAround()
    while getEnergyPercent() < 98 do
      os.sleep(0.5)
    end
    util.forceMove(robot.forward)
    robot.turnRight()
end

local function gatherFromBuffer()
  -- expects on input buffer
  local size = inv.getInventorySize(sides.down)
  for i = 1, size, 1 do
    local t = inv.getStackInSlot(sides.down, i)
    if t then
      ingredient_item = t
      robot.select(SLOT_INGREDIENT)
      inv.suckFromSlot(sides.down, i, ingredient_item.maxSize)
      break
    end
  end
  return ingredient_item
end

local function suckBlodOrbFromAltar()
  -- expects facing blood altar
  -- expects blood orb on altar
  if blood_orb_altared or inv.getStackInSlot(sides.front, 1) then
    robot.select(SLOT_BLOOD_ORB)
    inv.suckFromSlot(sides.front, 1)
    blood_orb_item = inv.getStackInInternalSlot(SLOT_BLOOD_ORB)
    inv.equip()
    robot.select(SLOT_INGREDIENT)
  end
end

local function dropBloodOrbIntoAltar()
  -- expects on input buffer
  robot.select(SLOT_BLOOD_ORB)
  inv.equip()
  if inv.getStackInInternalSlot(SLOT_BLOOD_ORB) then
    inv.equip()
    util.forceMove(robot.forward)
    if not inv.getStackInSlot(sides.front, 1) then
      inv.equip()
      blood_orb_item = inv.getStackInInternalSlot(SLOT_BLOOD_ORB)
      inv.dropIntoSlot(sides.front, 1)
    end
    util.forceMove(robot.back)
  end
  robot.select(SLOT_INGREDIENT)
end

local function doCraft()
  -- expects facing blood altar
  -- expects empty altar
  robot.select(SLOT_INGREDIENT)
  ingredient_item = inv.getStackInInternalSlot(SLOT_INGREDIENT)
  if DEBUG then
    print("ingredient_item: "..ingredient_item.label)
  end
  if not ingredient_item then
    error("Ingredient is disappear before crafting. somehow.")
  end
  inv.dropIntoSlot(sides.front, 1)
  local result = ingredient_item
  while util.compareItemTable(ingredient_item, result) do
    result = inv.getStackInSlot(sides.front, 1)
    os.sleep(0.25)
  end
  if DEBUG then
    print("Altar: "..result.label)
  end
  ingredient_item = nil
  if not result then
    if DEBUG then
      print("Altar is emptied by extra mean; Abort crafting.")
    end
    return false
  end
  inv.suckFromSlot(sides.front, 1)
  return true
end

local function dropProductsIntoOutput()
  -- expects on input buffer
  robot.turnLeft()
  util.forceMove(robot.forward)
  local function empty()
    local size = inv.getInventorySize(sides.bottom)
    if not size then
      print("Output chest not found; is container removed? Waiting to fix.")
      while not size do
        os.sleep(2.5)
        size = inv.getInventorySize(sides.bottom)
      end
    end
    robot.select(SLOT_INGREDIENT)
    for i = 1, size, 1 do
      inv.dropIntoSlot(sides.bottom, i)
      if not inv.getStackInInternalSlot(SLOT_INGREDIENT) then
        return true
      end
    end
    return false
  end
  if not empty() then
    print("Failed to export products. Probably output is full.")
    while empty() do
      os.sleep(4)
    end
  end
  util.forceMove(robot.back)
  robot.turnRight()
end



-- Main
local function main()
  init()
  while true do
    -- currently at home position (on input buffer)
    os.sleep(2.5)
    if getEnergyPercent() < 70 then
      recharge()
    end
    if gatherFromBuffer() then
      repeat
        util.forceMove(robot.forward)
        suckBlodOrbFromAltar()
        local products_returned = doCraft()
        -- IMPORTANT: DO NOT PUT BACK BLOOD ORB IMMEDIATELY.
        -- It could void items, a precious Armok orb.
        -- https://github.com/GTNewHorizons/GT-New-Horizons-Modpack/issues/14401
        util.forceMove(robot.back)
        if products_returned then
          dropProductsIntoOutput()
        end
        if getEnergyPercent() < 25 then
          recharge()
        end
      until not gatherFromBuffer()
    end
    dropBloodOrbIntoAltar()
  end
end

main()