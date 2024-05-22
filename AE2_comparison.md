
# AE2 Unofficial(1.7.10)/UEL(1.12.2) 完全比較

---

## About
AE2の仕様、バージョン間で違いすぎるぅ。  
ミスを未然に防ぐために、バージョン間の違いをここに記しておきます。加筆・修正は常時募集中。  

対象とするAE2のバージョンは [Unofficial/1.7.10用](https://github.com/GTNewHorizons/Applied-Energistics-2-Unofficial) と [UEL/1.12.2用](https://github.com/AE2-UEL/Applied-Energistics-2) のふたつ。  
また、以下のアドオンの導入を前提として話を進めます。AE2を遊ぶなら入れておきたい必須Mod達です。  

1.7.10 (GTNH):
- [AE2 Stuff](https://github.com/GTNewHorizons/ae2stuff)
- [AE2 Fluid Crafting Rework](https://github.com/GTNewHorizons/AE2FluidCraft-Rework)
- [Better P2P](https://github.com/GTNewHorizons/BetterP2P)
- [Not Enough Energistics](https://github.com/GTNewHorizons/NotEnoughEnergistics)
- [Thaumic Energistics](https://github.com/GTNewHorizons/ThaumicEnergistics)

1.12.2:
- [AE2 Stuff Unofficial](https://www.curseforge.com/minecraft/mc-mods/ae2-stuff-unofficial)
- [AE2 Fluid Crafting Rework](https://github.com/AE2-UEL/AE2FluidCraft-Rework)
- [Betterer P2P](https://github.com/AE2-UEL/BetterP2P)
- [Lazy AE2](https://www.curseforge.com/minecraft/mc-mods/lazy-ae2)
- [Lazy AE2 Patch](https://www.curseforge.com/minecraft/mc-mods/lazy-ae2-patch)
- [Neeve's AE2: Extended Life Additions](https://github.com/AE2-UEL/NAE2)
- [Not Enough Energistics](https://www.curseforge.com/minecraft/mc-mods/not-enough-energistics)
- [PackagedAuto](https://www.curseforge.com/minecraft/mc-mods/packagedauto)
- [Thaumic Energistics Extended Life Fork](https://www.curseforge.com/minecraft/mc-mods/thaumic-energistics-extended-life-fork)

---

## Blocking Modeについて
Blocking Modeは、搬出先のインベントリにアイテムが存在する場合、次のアイテムの搬出を待機する機能。  
Mixer等の"他の材料が混ざると何が起こるか分からない"機械への搬出において役に立つ、のだが...。  
この機能、特にAE2FCの液体クラフト周りでの仕様が**非常に厄介**。バージョン間での差異が最も顕著に表れる。  

### 対ME倉庫への搬出時のBlocking Mode
インターフェースの搬出先がME倉庫のバッファのパターン。NewHorizonsではよくあった(現在はCrafting InputなBusが主流?)。  
#### 1.7.10
ブロッキングはインターフェースの中身のみを参照する。  
ME倉庫の中身に応じてブロッキングしたい場合、別途Advanced Blocking Cardを受領側インターフェースに挿入する。  
#### 1.12.2
ブロッキングはME倉庫の中身を参照する。特別な設定は不要。  

### 液体クラフト時のBlocking Mode
#### 1.7.10
ブロッキングはアイテムコンテナのみを参照する。液体コンテナに材料が存在しても、ブロッキングは考慮しない。  
また、**液体の搬入が拒否されても、アイテムは先行して搬入される**。アイテムだけが先に搬入されて、残存していた液体と反応...なんて事故もあり得るかもしれない。  
#### 1.12.2
液体コンテナの中身を参照してブロックは働くし、アイテムとの非同期も発生しない。期待通りに機能する。  

---

## AE2FCでの液体搬出
#### 1.7.10
通常インターフェースでは液体パケット(デコーダーで液体に戻せる)、デュアルインターフェースでは液体をそのまま搬出する。  
#### 1.12.2
通常/デュアルに差異はなく、液体搬出/パケット搬出を選択できる。  
ただし、対ME倉庫への搬出は例外。**設定に関わらず、液体パケットを搬出する**。  

---

## Fluid Discretizerの機能
### 共通
倉庫が保持する液体を、Fluid Dropとしても表示する。また、搬入されたFluid Drop(アイテム)を、液体に変換する。  
### 1.7.10
共通で記述の通り。  
### 1.12.2
上記の他、液体パケットまでもを解釈して液体に変換する。  
[ME倉庫への搬出時の仕様](#液体クラフト時のblocking-mode)が特殊だが、Discretizerを配置すればDecoder要らずで完結する。  
