
local component = require("component")
local gt_machine = component.gt_machine
local redstone = component.redstone
local computer = require("computer")
local sides = require("sides")

local cfg = {
    decay_startcrafting = 100, -- (0,100] Set to 20 if you want maximum parallel
    decay_halting = 5,
    spacetime_expense_max = 256, -- L/s, won't start crafting above threshold
    side_tp_bus_src = sides.south,
    side_tp_bus_dst = sides.down,
    side_tp_hatch_src = sides.down,
    side_tp_hatch_dst = sides.north,
    side_rs_machine = sides.down,
    side_rs_item_detector = sides.east,
}

local tp_bus
local tp_hatch
-- Go find transposer
for k,_ in pairs(component.list("transposer", true)) do
    if component.invoke(k, "getStackInSlot", cfg.side_tp_bus_src, 2) then
        tp_bus = k
    elseif component.invoke(k, "getFluidInTank", cfg.side_tp_hatch_src, 1) then
        tp_hatch = k
    else
        error("Unidentified transposer detected.")
    end
end
print("Item Transposer:", tp_bus)
print("Fluid Transposer:", tp_hatch)

-- Safeguard
if not tp_bus or not tp_hatch then
    error("Cannot detect transposer.")
end
if not gt_machine then
    error("gt_machine Adaptor not found.")
end
if not redstone then
    error("Redstone I/O not found.")
end

---@return boolean
local function checkBlackHoleManip()
    local seed = component.invoke(tp_bus, "getStackInSlot", cfg.side_tp_bus_src, 1)
    local collapser = component.invoke(tp_bus, "getStackInSlot", cfg.side_tp_bus_src, 2)
    if not seed or not collapser then
        return false
    end
    local b_seed = seed.name == "gregtech:gt.metaitem.01" and seed.damage == 32418
    local b_collapser = collapser.name == "gregtech:gt.metaitem.01" and collapser.damage == 32419
    return b_seed and b_collapser
end

---@return boolean
local function openBlackHole()
    return component.invoke(tp_bus, "transferItem", cfg.side_tp_bus_src, cfg.side_tp_bus_dst, 1, 1)
end

---@return boolean
local function closeBlackHole()
    -- Note: Just throw
    return component.invoke(tp_bus, "transferItem", cfg.side_tp_bus_src, cfg.side_tp_bus_dst, 1, 2)
end

---@return boolean
local function transferSpaceTime(amount)
    local b, l = component.invoke(tp_hatch, "transferFluid", cfg.side_tp_hatch_src, cfg.side_tp_hatch_dst, amount)
    return b and l == amount
end

local function main()
    local starttime
    redstone.setOutput(cfg.side_rs_machine, 0)
    while true do
        if redstone.getInput(cfg.side_rs_item_detector) ~= 0 then
            if not checkBlackHoleManip() then
                print("Black Hole Seed/Collapser not found.")
                os.sleep(60)
            else
                openBlackHole()
                print("Black hole opened!")
                local collapser = false -- Whether Collapser is thrown (thus it's eol mode)
                starttime = computer.uptime()
                while computer.uptime() - starttime > cfg.decay_startcrafting do
                    os.sleep(1)
                end
                -- Start crafting
                redstone.setOutput(sides.down, 15)
                while computer.uptime() - starttime < 100 - cfg.decay_halting do
                    os.sleep(1)
                end
                if gt_machine.isMachineActive() then
                    print("Black hole halting activated.")
                    local spacetime_consumption = 1
                    while gt_machine.isMachineActive() do
                        if not collapser then
                            if not transferSpaceTime(spacetime_consumption*30) then
                                closeBlackHole()
                                collapser = true
                                -- THrow error to shutdown (manual restart required)
                                error("Not enough SpaceTime!")
                            end
                            spacetime_consumption = spacetime_consumption * 2
                            if
                                not collapser and
                                cfg.spacetime_expense_max > 0 and
                                spacetime_consumption > cfg.spacetime_expense_max
                            then
                                print("SpaceTime consumption is too high. Stopped accepting new craft.")
                                closeBlackHole()
                                collapser = true
                            end
                            os.sleep(29.5)
                        else
                            os.sleep(1)
                        end
                    end
                end
                if not collapser then
                    closeBlackHole()
                end
                -- ensure black hole is collapsed
                redstone.setOutput(cfg.side_rs_machine, 0)
                os.sleep(0.05)
                redstone.setOutput(cfg.side_rs_machine, 15)
                os.sleep(0.05)
                redstone.setOutput(cfg.side_rs_machine, 0)
                print("Black hole closed.")
            end
        else
            os.sleep(5)
        end
    end
end

main()
