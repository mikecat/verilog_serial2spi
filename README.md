シリアル通信をSPIに変換するやつ(仮)
===================================

### これは何？
シリアル通信(RS232Cっぽいやつ)をAVRの書き込みで利用されるSPIに変換するVerilogプログラムです。

### 使い方
3.6864MHzのクロックを入れると115200bps、(3.6864MHz/12)のクロックを入れると9600bpsで動作するはずです。

1. シリアル通信で1バイト(8ビット、パリティなし)を変換器に送信する
2. 変換器がSPI通信を行う
3. 変換器が受信したバイトをシリアル通信で送信する

### 注意
変換器による、受信結果の送信が完了するまで次のデータを変換器が受信することはできません。  
準備が終わってから(rts=HIGHのとき、cts=HIGH)次のデータを送信してください。

### ライセンス
MITライセンスとします。

This software is released under the MIT License, see LICENSE.txt.
