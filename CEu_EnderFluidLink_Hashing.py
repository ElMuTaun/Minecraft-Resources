
# Ender Fluid Link Encoder
# Intended to help CEu's EFL Cover which require ARGB value as frequency

import hashlib
import pyperclip

def splitConsole():
    print("-" * 48)
    return

splitConsole()
print(" Ender Fluid Link Encoder")
print(" * Hashing given string to 8-digit hex value")
print(" * Results are automatically send to clipboard")
splitConsole()

while True:
    try:
        print("Enter FluidName (Ctrl+C to exit) :")
        name = input("$ ")

        result = hashlib.sha256(name.encode("utf-8")).hexdigest()[0:8].upper()

        print("Value : " + result)
        pyperclip.copy(result)
        splitConsole()

    except KeyboardInterrupt:
        break

# Special Names
# OilAny (Oil for distillation) - C45724F6

# Frequent Values
# CetaneBoostedDiesel - AD970402
# EnderAir - DDABBB55
# HighOctaneGasoline - A8F3FC66
# Lava - 09541DF8
# Nitrobenzene - 3B098F46
# SaltWater - 471615DA
# xpjuice - D83D1BDE
