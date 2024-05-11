
# Nickel Plasma

## Production

Time Unit: tick, Mk III Fusion

1 Potassium + 7.8125 Fluorine -> 9 Nickel Plasma (3,538,944EU/t Equivalent)

---


## Consumption

UV Rotor Holder, Helium Plasma

HSS-E: 367001 EU/t, 98L per 40 ticks
Neutronium: 524288 EU/t, 78L per 40 ticks

---


## Setup

Per 1 MkIII Fusion Reactor:

Recipes:
    Fusion: MkIII
        1 Potassium + 7.8125 Fluorine -> 9 Nickel Plasma (3,538,944EU/t Equivalent)
        30,720 EU/t
    Centrifuge: UHV, 256x Parallel
        Target: 256 MV Centrifuge
    Centrifuge: UHV, 256x Parallel
    Electrolyser: UHV, 256x Parallel
        Target: 1280 LV Electrolyzer


Turbines:
    HSS-E:
    Neutronium:
