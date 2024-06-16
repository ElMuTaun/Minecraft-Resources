
# Apiary Drainer Explained

## About
NewHorizons 2.6.0にて、<s>Essentia Condenserの修正の代わりに</s> Essentia蜂とApiary Drainerが追加された。  
同名の蜂が二匹存在するが、光っている方の蜂が対象。生産物がなく、Drake蜂への派生が存在しない。  

Apiary Drainerのエッセンシア生産は通常の養蜂と計算が異なるため、本項では生産レートに重点を置いて記述していく。  

---

## Basics: How to Use
養蜂箱の下にDrainerを設置し、任意のエッセンシアコンテナをRMBで生成するエッセンシアを指定(Essentia Input Hatchと同一の操作)。  
Essentia蜂の活動中、定期的にエッセンシアを生産する。  
搬出はゴーレム等の他、自動搬出機能を有するため、隣にWarded Jarを設置するだけでもよい。  
ThEが利用可能な場合、Essentia Provider直付けでも回収できます。便利。  

---

## Basic Information
Apiary Drainerの稼働周期は200tick(10秒)。  
Essentia蜂が活動している場合、Production Modiferに応じたエッセンシアを内部コンテナに生成する。容量は512。  
World Acceleratorは使用不可。巣箱/Drainer共に加速しても、効果がないかフレームを無駄にするだけ。  


## Common
```
// Source (TileEntityApiaryDrainerCommon.java)
protected int getProductionMultiplier(IBeeModifier modifier, IBee queen, TileEntity te) {
    IBeeGenome queenGenome = queen.getGenome();
    float productionMultiplier = modifier.getProductionModifier(queenGenome, 1.0F);
    float minimum = Math.max(productionMultiplier, 1.0F);
    return (int) Math.ceil(minimum);
}
```
IBeeModifierのmodifierを参照しているが、こちらは"巣箱のModifer"が渡されている。  
覗いていくと、**蜂の生産能力とは無関係**に、巣枠等のProduction Modiferが反映される様子。  
基本はフレームのProductionの合計値と同等。巣箱ごとのTier値も適用されない。  
エッセンシア生産の最低保証は 1 、端数は切り上げとなる。  
通常の養蜂生産の計算式とは異なり、^0.52などの調整は入らないので注意。  


## Industrial Apiary
```
// Source (TileEntityApimancersDrainerGT.java)
protected int getProductionMultiplier(IBeeModifier modifier, IBee queen, TileEntity te) {
    BaseMetaTileEntity GTMetaTileEntity = getGTTileEntity(te);
    GT_MetaTileEntity_IndustrialApiary industrialApiary = getGTIndustrialApiary(GTMetaTileEntity);
    int housingProductionMultiplier = super.getProductionMultiplier(modifier, queen, te);
    return industrialApiary != null
            ? housingProductionMultiplier * (int) Math.ceil(Math.sqrt(industrialApiary.mSpeed))
            : housingProductionMultiplier;
}
```
ここからが本題(大問題)。Industrial Apiaryの場合、Accelerationに応じて補正が適用される。  
計算式としては、上述したProduction Modiferをベースに、Accelerationのスピードの平方根を、切り上げて乗算するだけ...  

問題は```industrailApiary.mSpeed```、sqrtを取るような値ではありません。  
デフォルト値は0、加速時はAccelerationのTierが該当します。LVなら1、UVなら8といった具合。  
つまり、電力消費が4倍になっても、生産増加は悲惨なことに...  

Accelerationに応じた生産倍率は:  
**無加速の場合 - 0倍。エッセンシアは全く生産されません。**  
LV Accelの場合 - 1倍。  
MV-EV Accelの場合 - 2倍。HV・EVでは生産が伸びません。  
IV-UV Accelの場合 - 3倍。LuV以降はIVと変わりありません。  

話は少々変わるが、Industrial ApiaryはProduction Upgradeが強力。  
Production 8枚を搭載すると、CommonでのModifier計算時に18エッセンシアが得られます。  
デフォルトのp=2と比較すると9倍。加速の前に、まずはProduction Modifierで生産を伸ばしたいところ。  

---

## TL;DR
最低要件: Industrial ApiaryにLV Accelerationを搭載する。  
MV、IVのAccelerationでそれぞれ生産が2倍、3倍と増加。他のアップグレードは電力の無駄。  
**Accelerationを搭載しないと、0倍となりエッセンシアが生産できない。**  

Production Modifierの補正が全て。  
巣箱や蜂のステータスは関係なく、フレームで決定される。Industrial Apiary**以外**の養蜂箱の場合、最低保証は 1エッセンシア / 10sec。  
生産レートを重視しない場合、Industrial Apiaryならデフォルトでも2点貰える。ただし前述の通り、Accelerationは必須。  

生産レートを少しでも要求する場合、Production Upgradeは1枚でも搭載したい。エッセンシア生産が2.5倍になる。  
Productionを8枚搭載すれば、未搭載と比較して9倍にもなる。ただし電力消費は跳ね上がるので要相談。  
もっともAccelerationの恩恵が非常に弱いので、低TierのWAを採用できる。Production Upgradeを積んでも電力は捻出できるだろう。  

```
参考値: MV Accel / 8 Production
Essentia = ceil(max(4.f * pow(1.2d, 8), 1.0f)) * ceil(sqrt(2)) = 18 * 2 = 36 (essentia/10sec)
Essentia_per_sec = 3.6
EUt = sirane kakuninnmenndoi
```

---

## Links
- [MagicBees/ApiaryDrainer](https://github.com/GTNewHorizons/MagicBees/blob/master/src/main/java/magicbees/tileentity/TileEntityApimancersDrainerCommon.java)  
- [MagicBees/ApiaryDrainer for IndustrialApiary](https://github.com/GTNewHorizons/MagicBees/blob/master/src/main/java/magicbees/tileentity/TileEntityApimancersDrainerGT.java)  
- [GregTech/IndustrialApiary](https://github.com/GTNewHorizons/GT5-Unofficial/blob/master/src/main/java/gregtech/common/tileentities/machines/basic/GT_MetaTileEntity_IndustrialApiary.java)  
- [GregTech/ApiaryUpgrade](https://github.com/GTNewHorizons/GT5-Unofficial/blob/master/src/main/java/gregtech/api/util/GT_ApiaryUpgrade.java)  
