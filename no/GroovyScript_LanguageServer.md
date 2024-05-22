
# GroovyScriptの開発環境を試してみよう (GroovyScript 1.0.0)

---

## About
GroovyScript 1.0.0にて、[**VSCodeの拡張機能**とLanguageServerが追加された](https://github.com/CleanroomMC/GroovyScript/pull/139)。(???)  

---

## 導入
詳細: [Cleanroom MC](https://cleanroommc.com/groovy-script/getting_started)
1. VSCodeの拡張機能 [](https://marketplace.visualstudio.com/items?itemName=CleanroomMC.groovyscript)をインストールする
2. GroovyScript 1.0.0+ の導入されたMinecraftを立ち上げる
3. ```/grs runLS``` を実行する (またはJVM引数に```-Dgroovyscript.run_ls=true```を追加)
4. GroovyScript: Ready

---

## サンプル
画像でも貼っとけ  

---

## 所感
IntelliSenseが微妙に壊れている。要修正。  
(補完後に後続の補完が続かない。バックスペースで自動入力されたピリオドを削除し、手動でピリオドを再入力すれば補完される。)  

```item()```ブラケット等でアイテム名の入力補完はできない。  
既出の表現については、VSCode本体の機能か何かで補完してくれるので、困りまではしないが...  

各関数の引数の型が閲覧できるのは便利。  
まあ結局Wikiを読みにいくんですけどね。GroovyScriptのDocが優秀すぎる。  

結論、使い込めていないが、あって損はない機能と思われる。
Minecraftを立ち上げて、JEIを参照しながら作業するには最適なソリューションです。GrSでModpackを編集中の人は知っておくべき。  
