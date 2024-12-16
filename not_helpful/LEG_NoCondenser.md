
# R.I.P Essentia Condenser -2024.04.29
エッセンシアが無限化できなくなったので、UV 64Ampsを出力できる代替ソースを探そう  

Thaumometric Essentia Cellは当然禁止(UIV+)  

---

## 前提条件
全セルがGrandmasterを想定。  
なぜなら計算時にStable Pointを入力し忘れたからなのだ。  
5.5倍もすれば Novice 24 : Grandmaster 1 の構成の値になる  

---

## Ira + Cryotheum (Thermal Focus)
### 要求量
156 Ira/s + 1,558 Cryotheum/s  

### 生産
#### IV Tree Growth Simulator (w/ Saw)
Saw: Produces 29 Fuse Wood/s = 58 Ira/s  
Chainsaw: Produces 116 Fuse Wood/s = 232 Ira/s  

#### Advanced Alchemical Furnace
Can't keep up. Melts 5 Fuse Wood/s  

#### Large Essentia Smeltery
TecTechの通常Energy Hatchを使用可能。  
1tickの壁は並列化で対応 (処理時間n倍、処理数n倍)  
並列化方法: Diffusion Cellのアップグレード(2^n倍)、長さを増大(処理数+1)  

#### Cryotheum Bee
1 comb/sec/apiary (IV Accel, 8 Prod, Blinding)  
250 Cryotheum / comb  

---

## Vitium + Liquid Death (Tainted Focus)
### 要求量
18 Vitium/s + 536 Liquid Death/s  
= 18 Vitium/s + 17 Mortuus/s + 17 Venenum/s + 17 Periditio/s  

### 生産
#### Tainted Bee
Tainted Combの遠心分離、Vitiumエッセンシアの期待値  
```1 * 0.15 * 2 + 2 * 0.15 * 2 + 3 * 0.15 = 1.35 Vitium/comb```  

#### Liquid Death
Belladonaがわりとなんとかしてくれる  

---

## Astrum + Molten Atomic Separation Catalyst (Radiation Focus)
無理。カタリストの消費が激しすぎる(5倍以上)ので、想定通りNaquadah Reactorで発電すべき。  
