# rtlのドキュメント
参考：ktl, Rubyで作る奇妙なプログラミング言語(hq9+のコンパイラ)
## print

```
print "Hello"
print Hello
```

上の例では，Hello, Worldという文字を表示します．
四つは全て同じ結果を表示します．
改行は\nで入れることができます．
数値は""を使用しても使用を推奨します．
なぜなら，もしHelloという変数があると，変数と認識されてしまうからです．
つまり，"Hello"というようにダブルクォーテーションを変数名に含めてしまうと，変数と認識してしまいます．
また，エスケープシーケンスを表示したい場合は以下のようにします．
括弧内はWindwosの場合を示します．
スペースはいくらでも入れることができます．

```
print "警告音を鳴らすには\a（¥a）とします"
print "円マークを表示するには\¥(¥¥)とします"
print "バックスラッシュを表示するには\\(¥\)とします，\n"
print "ダブルクォーテーションを表示するには\"(¥")とします．\n"
print "シングルクォーテーションを表示するには\'(¥')とします．\n"
```

変数を表示するには以下のようにします．
変数については"変数"を参照してください．
また，そのような変数が定義されていない場合はクォーテーションを省略できます．

```
a = 1
b = 2
c = 3
print "a:"
print a
print "\nb:"
print b
print "\nc:"
print c
print "\n"

print a:
print a
print \nb:
print b
print \nc:
print c
print \n
```

## 変数
変数は代入・埋め込みができます．
文字列・数値どちらでもOkです．
変数を定義する場合は以下のようにします．
スペースは1個だけ入れることができません．

```
a=1
b = 2
f="Hello, World"
g = "Hello, World"
```

```
a=1
b=2
c=3
print "a : "
d = a
print d
print "b :  "
d = b
print d
print "c : "
d = c
print c
print "\n"
```

```
togarashi = "karai"
umeboshi = "suppai"
miso = "nihonnoaji"
print "i like togarashi."
print "becose togarashi is "
print togarashi
print "\ni like umeboshi."
print "becose umeboshi is "
print umeboshi
print "\n"
print "i don't like miso."
print "becose miso is "
print miso
print "\n"
```

埋め込みは以下のようにします．

```
a=1
print a
print "がaの値です．"
b="Hello, World"
print b
print "がbの値です．"
```

## 1行コメント

```
// コメントをするにはスラッシュを二個重ねます
print "ここはもうコメントではありません．" // これはprint文です
```

//を先頭に入力することで//より後ろはコメントになります．
コメントは次の行には影響しません．
## 複数行コメント

```
/*
ここはコメントです．
ここも
コメント
で〜す！
*/
print "もうここはコメントではありません．" /* ここはコメントで〜す！*/
print "ここもコメントではありません" /* ここもコメントで〜す
ここまでコメントになります！
ここも
コメント
で〜す！
 */
````

/*をはじめに*/を終わりにつけることで/*か*/の間はコメントになります．
これによって複数行に渡ってコメントすることができます．

## random 乱数生成
random関数では一定の範囲の乱数を生成します．
random関数は直接print関数で表示したり，変数に格納することができます．
random(MIN,MAX)の場合はMINからMAXの間で表示します．
random(MIN)の場合はMINから33554432の範囲で表示します．
random()の場合は-22554432から33554432の範囲で表示します．
また，randomだけだとエラーが出ます．
```
print random(0,10) // => 0~10の範囲
print random(-10,10) // => -10から10の範囲
print random(10) // => 10から33554432の範囲
print random() // => -33554432から33554432の範囲
```

# エラー

~~iとnとpとtがとrが表示されない状況~~解決しました．

~~Print文で何も表示されない状況~~
