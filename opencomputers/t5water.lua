
local component = require("component")
local gt_machine = component.gt_machine
local sides = require("sides")

local tp_plasma
local tp_coolant
-- Go find transposer
for k,_ in component.list("transposer", true) do
    local fluid = component.invoke(k, "getFluidInTank", sides.down, 1).name
    if fluid == "plasma.helium" then
        tp_plasma = k
    elseif fluid == "supercoolant" then
        tp_coolant = k
    else
        error("Unconfigured Interface/Transposer detected.")
    end
end
print("Plasma Transposer:", tp_plasma)
print("Coolant Transposer:", tp_coolant)

-- Safeguard
if not tp_plasma or not tp_coolant then
    error("Cannot detect transposer.")
end
if not gt_machine then
    error("gt_machine Adaptor not found.")
end

---@return number fluidLevel
local function checkInputHatch(tp_address)
    return component.invoke(tp_address, "getFluidInTank", sides.up, 1).amount
end

---@return boolean
---@return number
local function transfer(tp_address, amount)
    return component.invoke(tp_address, "transferFluid", sides.down, sides.up, amount)
end

local function main()
    local progress
    while true do
        progress = gt_machine.getWorkProgress()
        if progress ~= 0 and progress < 200 then
            print("Start iteration...")
            for i = 1, 3 do
                while checkInputHatch(tp_coolant) ~= 0 do
                    os.sleep(0.5)
                end
                transfer(tp_plasma, 100)
                print("Helium Plasma transfered")
                os.sleep(10)
                while checkInputHatch(tp_plasma) ~= 0 do
                    os.sleep(0.5)
                end
                transfer(tp_coolant, 2000)
                print("Super Coolant transfered")
                os.sleep(20)
            end
        end
        os.sleep(1)
    end
end

main()
