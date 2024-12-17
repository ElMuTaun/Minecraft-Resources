
// extracted from [en_US.lang](https://github.com/GTNewHorizons/GT5-Unofficial/blob/e3355aa60352e6d43306c046b5fa02f291a1a8ef/src/main/resources/assets/tectech/lang/en_US.lang#L1116-L1127)  

**Confused? Click here for some general info**  
(and migraine, this hurts me as non-native english speaker)  

## Introduction

There's a lot going on in the Forge of the Gods, which can be quite confusing at first.  
This menu aims to explain everything that is happening and all the capabilities/mechanics of the forge.  

## Table of Contents:

- [Fuel](#fuel)
- [Modules](#modules)
- [Upgrades](#upgrades)
- [Milestones](#milestones)

## Fuel

Once the structure of the Forge is built and the multiblock is formed, just simply turning it on is not sufficient to make it functional.  
The Forge must be supplied with a certain amount of Star Fuel (the item) to actually boot up.  
The amount of Star Fuel needed depends on the current fuel consumption factor, which can be set in the fuel configuration menu.  
By default the maximum is 5, but it can be increased later on with upgrades.  
Star Fuel scaling is as follows: factor*25*1.2^factor.  
Star Fuel can be supplied via an input bus, it gets consumed periodically and stored internally.  
Once there is enough Star Fuel stored in the multi, it turns on for real (allowing modules to connect) and converts the consumed Star Fuel into stored Stellar Fuel.  
From this point onwards, the Forge must be fueled via one of the liquid fuels (type can be selected in the fuel config menu).  
If there isn't enough of the selected fuel present in the input hatch, the stored fuel amount will decrease and if it reaches 0, the Forge enters the previous 'off' state where modules disconnect and it has to be supplied with Star Fuel again.  
The amount of internally stored Stellar Fuel (liquid) can be increased by turning on battery charging, this will cause the fuel usage to double, but half of it will be stored in the internal battery.  

## Modules

There are 4 types of modules that can be used in the Forge, the Helioflare Power Forge, Helioflux Melting Core, Heliothermal Plasma Fabricator and Heliofusion Exoticizer.  
These modules are separate multiblocks that have to be built into the Godforge structure at their designated spots.  
Once built, these modules have to connect to the Godforge, which happens automatically if all requirements for the respective module are met.  
Alternatively, there is a button to refresh their status without waiting for the timer.  
Each of these modules has its specialized functionality & requirements and is affected differently by certain upgrades.  
The first unlocked module is the §BHelioflare Power Forge§6, which simply put is a blast furnace even more powerful than the mega version.  
Additionally, this module has a furnace mode, turning it into a hyper powerful multi smelter.  
This module is unlocked by default and has 1024 base parallel.  
The second unlock is the §BHelioflux Melting Core§6, which also processes blast furnace recipes, but with a twist, the outputs are ejected in their molten form instead of hot/regular ingots.  
If an output does not have a molten form, it will output its regular form.  
This module has to be unlocked by an upgrade to function and has 512 base parallel.  
The third module is the §BHeliothermal Plasma Fabricator§6, which possesses a unique recipemap featuring direct material to plasma conversion recipes.  
These recipes are grouped by two properties, fusion tier and steps required, limiting which recipes can be processed before their respective upgrades are unlocked.  
Unlike regular fusion, these recipes produce the plasma of the input material.  
This module has 384 base parallel.  
The fourth and last module is the §BHeliofusion Exoticizer§6, a module capable of producing quark gluon plasma and later on magmatter.  
This module has unique automation challenges for both materials, so it is recommended to have two of these, as they have to be locked to either one of the materials.  
The common rule for both modes' automation challenges is as follows: the module outputs materials at the start of a recipe cycle and waits for the correct inputs to arrive before starting the actual processing of the output material.  
If producing quark-gluon plasma, the module outputs up to 7 different fluids/tiny piles with amounts between 1 and 64, and their corresponding plasmas and amounts have to be returned in order for the recipe to process.  
For each L of fluid, a bucket of plasma and for each tiny pile an ingot's worth of plasma must be returned for the recipe to work.  
The tiny piles are always ejected in multiples of 9.  
If magmatter mode is active, the automation challenge changes.  
Now the module outputs 1-50L of tachyon rich temporal fluid, 51-100L of spatially enlarged fluid and one tiny pile of a high tier material.  
The challenge is to return both the tachyon rich and spatially enlarged fluids, plus as much plasma of the tiny pile's material (in ingots) as the difference between the amounts of spatially enlarged and tachyon rich fluid.  
Once all of these have been returned in the correct amounts, the recipe will start to process and output magmatter.  
This module has 64 base parallel.  

## Upgrades

Upgrades are the heart and soul of the Godforge, they unlock most of its functionality and processing power.  
The upgrade tree can be accessed via its button on the main gui and each upgrade node can be clicked for more information on its effects and unlock requirements.  
In general, each upgrade can only be unlocked if the prior one is unlocked and there are enough available graviton shards.  
One exception to this is the first upgrade, as that one has no prior upgrade.  
Some upgrades can also have extra material costs, which are denoted next to the unlock button if applicable.  
If an upgrade has more than 1 connected prior upgrade, then there are two options, either the upgrade requires ALL connected prior upgrades or AT LEAST ONE (indicated by the connection's color, red means ALL, blue means AT LEAST ONE).  
Upgrades can be refunded by simply pressing the unlock button again, but this only works if ALL connected later upgrades are not active/unlocked.  
The block of upgrades following the unlock of the Heliufusion Exoticizer module are special, as they are what is considered §Bthe Split§6.  
As the name suggests, only one path out of the three may be chosen at first, and the others will be locked.  
Each path has specialized buffs that are primarily targeted towards a specific module, and thus affect other module types with reduced effect (unless stated otherwise).  
The amount of unlockable paths depends on the amount of rings the Godforge has, which in turn are limited by later upgrades.  

## Milestones

Milestones are essential for upgrading the Godforge, as they are the source of graviton shards, the main currency needed for unlocking upgrades.  
In essence, milestones are just what their name suggests, thresholds that when reached, grant graviton shards.  
There are four types of milestones, Charge, Conversion, Catalyst and Composition, each referring to a stat of the Godforge.  
Each milestone has 7 tiers, each being harder to reach than the last, but also granting more graviton shards.  
The first tier grants 1 graviton shard, the second 2, etc.  
The §BCharge§6 milestone scales off total power consumption of all modules combined, the first tier being unlocked at 1e15 EU consumed, and each subsequent milestone scaling by 9x.  
The §BConversion§6 milestone scales off total recipes processed across all modules (excluding the Helioflare Power Forge's furnace mode) and its first tier is unlocked at 10M processed recipes.  
Following tiers scale by 6x.  
The §BCatalyst§6 milestone is based on the Forge's fuel consumption, counted in Stellar Fuel units (the number entered in the fuel config menu).  
Reaching the first tier requires 10,000 fuel units to be consumed, and each tier above scales by 3x.  
Last but not least, the §BComposition§6 milestone works a bit differently, as it scales off the Forge's structure.  
Milestone levels are granted for each unique type of module present in the structure (Heliofusion Exoticizer modules on quark-gluon and magmatter mode count as unique) and for each additional ring built.  
Your research suggests that something strange might happen if all milestones reach their final tier...  
Make sure to check back!  
