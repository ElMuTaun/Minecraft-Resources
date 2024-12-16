
local component = require("component")
local gt_machine = component.gt_machine
local sides = require("sides")

local tp_input
local tp_yield
-- Go find transposer
for k,_ in component.list("transposer", true) do
    local item = component.invoke(k, "getStackInSlot", sides.up, 6)
    if item then
        tp_input = k
    else
        tp_yield = k
    end
end
print("Input Transposer:", tp_input)
print("Yield Transposer:", tp_yield)

-- Safeguard
if not tp_input or not tp_yield then
    error("Cannot detect transposer.")
end
if not gt_machine then
    error("gt_machine Adaptor not found.")
end

local inputSequence = {
    1,2,  3,4,  5,6,  2,3,  4,5,  1,6,  1,3,  2,4,  3,5,  4,6,  1,5,  2,6,  1,4,  2,5,  3,6,
}

local function main()
    local progress
    while true do
        progress = gt_machine.getWorkProgress()
        if progress ~= 0 and progress < 200 then
            -- Clean up some leftover
            -- Requirement: Output Hatch (LV) locked to Baryonic Matter
            component.invoke(tp_yield, "transferFluid", sides.down, sides.up, 16000)
            print("Start iteration...")
            local itr = 0
            -- Check Baryonic response
            while component.invoke(tp_yield, "getFluidInTank", sides.down, 1).amount == 0 do
                itr = itr + 1
                print("Next inputSequence:", inputSequence[itr*2-1], inputSequence[itr*2])
                component.invoke(tp_input, "transferItem", sides.up, sides.down, 1, inputSequence[itr*2-1])
                component.invoke(tp_input, "transferItem", sides.up, sides.down, 1, inputSequence[itr*2])
                os.sleep(1.5)
            end
            print("Completed in", itr, "tries")
            os.sleep(15)
        end
        os.sleep(2)
    end
end

main()
