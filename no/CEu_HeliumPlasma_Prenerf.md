
# Helium Plasma

**OUTDATED (after Tin/Americium Plasma Update)**

## Production

Time Unit: tick, No Overclock

7.8125 Deuterium + 7.8125 Tritium -> 7.8125 Helium Plasma (640,000EU/t Equivalent)


### Water Electrolysis

80 Water -> 160 Hydrogen (120 LV Electrolyzer, 30EU/t) => 960 LV / MkIII Fusion

156.25 Hydrogen -> 39.0625 Deuterium (160 LV Centrifuge, 20EU/t) => 1,280 LV

31.25 Deuterium -> 7.8125 Tritium (32 MV Centrifuge, 80EU/t) => 256 MV

Consumption: 9360 EU/t


### Ender Air Distillation

-> 5 Ender Air (20 Gas Collector, 256EU/t)

50 Ender Air -> 50 Liquid Ender Air (2 Vacuum Freezer, 7680EU/t)

100 Liquid Ender Air -> 25 Deuterium + 5 Tritium (1 Distillation Tower, 7680EU/t)

16 Deuterium -> 4 Tritium (16 MV Centrifuge, 80EU/t)

Consumption: 29440EU/t

---


## Consumption

UV Rotor Holder, Helium Plasma

HSS-E: 367001 EU/t, 98L per 40 ticks
Neutronium: 524288 EU/t, 78L per 40 ticks

---


## Setup

Per 1 MkIII Fusion Reactor:

Recipes:
    Fusion: MkIII, 8x overclock
        62.5 Deuterium + 62.5 Tritium -> 62.5 Helium Plasma (5,120,000 EU/t Equivalent Fuel)
        32,768 EU/t
    Centrifuge: UHV, 256x Parallel
        Target: 256 MV Centrifuge
    Centrifuge: UHV, 256x Parallel
    Electrolyser: UHV, 256x Parallel
        Target: 1280 LV Electrolyzer


Turbines:
    HSS-E:
    Neutronium:
