# laplace-equation
このプログラムはいわゆるラプラス方程式を有限差分法にて解く.ラプラス方程式は偏微分方程式の一種であり,また楕円型に分類される.
楕円型の偏微分方程式を有限差分法で解く際にはいくらか手法があるが,今回はSOR法を採用した.
以下,手法の解説を行う.
まずはラプラス方程式を以下に示す.

<img src="https://latex.codecogs.com/gif.latex?\frac{\partial^2&space;u}{\partial&space;x^2}&space;&plus;&space;\frac{\partial^2&space;u}{\partial&space;y^2}&space;=&space;0"/>

これを2次精度中心差分法にて離散化する.

<img src="https://latex.codecogs.com/gif.latex?\frac{\partial^2&space;u}{\partial&space;x^2}&space;=&space;\frac{u_{i&plus;1,j}&space;-&space;2u_{i,&space;j}&space;&plus;&space;u_{i-1,&space;j}}{\Delta&space;x^2}" />
<img src="https://latex.codecogs.com/gif.latex?\frac{\partial^2&space;u}{\partial&space;y^2}&space;=&space;\frac{u_{i,j&plus;1}&space;-&space;2u_{i,&space;j}&space;&plus;&space;u_{i,&space;j-1}}{\Delta&space;y^2}" />

これらを元の式に代入して整理すると

<img src="https://latex.codecogs.com/gif.latex?u_{i,&space;j}&space;=&space;\frac{(0&space;-&space;\frac{1}{\Delta&space;x^2}u_{i&plus;1,&space;j}&space;-&space;\frac{1}{\Delta&space;x^2}u_{i-1,&space;j}&space;-&space;\frac{1}{\Delta&space;y^2}u_{i,&space;j&plus;1}&space;-&space;\frac{1}{\Delta&space;y^2}u_{i,&space;j-1})}{-2(\frac{1}{\Delta&space;x^2}&space;&plus;&space;\frac{1}{\Delta&space;y^2})}" />

となる.これが基本となる部分である.
SOR法ではある値<img src="https://latex.codecogs.com/gif.latex?\omega"/>を規定することにより,次の手順で計算を行う.

1. 

<img src="https://latex.codecogs.com/gif.latex?\tilde{u}_{i,&space;j}&space;=&space;\frac{(0&space;-&space;\frac{1}{\Delta&space;x^2}u_{i&plus;1,&space;j}&space;-&space;\frac{1}{\Delta&space;x^2}u_{i-1,&space;j}&space;-&space;\frac{1}{\Delta&space;y^2}u_{i,&space;j&plus;1}&space;-&space;\frac{1}{\Delta&space;y^2}u_{i,&space;j-1})}{-2(\frac{1}{\Delta&space;x^2}&space;&plus;&space;\frac{1}{\Delta&space;y^2})}"/>

2.

<img src="https://latex.codecogs.com/gif.latex?{u}_{i,&space;j}&space;=&space;u_{i,&space;j}&space;&plus;&space;(\tilde{u}_{i,j}-u_{i,j})\omega"/>

これをある程度値が収束するまで繰り返す.このプログラムは理論解が分かっていることを前提としているので,判定法としては以下の基準を設ける.

<img src="https://latex.codecogs.com/gif.latex?\left(&space;\frac{1}{nx&space;\times&space;ny}\sum_{i=0}^{nx-1}\sum_{j=0}^{ny-1}(u_{i,j}-u_{theory})^2&space;\right)^{1/2}&space;<&space;\epsilon"/>

プログラムでは<img src="https://latex.codecogs.com/gif.latex?\epsilon&space;=&space;2&space;\times&space;10^{-4}"/>として判定している.

SOR法を行う上で最も注意するべきことは<img src="https://latex.codecogs.com/gif.latex?\omega"/>を上手く選ぶことである.SOR法は特殊な事例を除いて,<img src="https://latex.codecogs.com/gif.latex?\omega"/>の値を計算することは困難であるが,幸いなことに今回はその特殊な事例に当てはまる.

<img src="https://latex.codecogs.com/gif.latex?\omega"/>の値は次のように決定するとよい.

<img src="https://latex.codecogs.com/gif.latex?\omega"/>
但し,<img src="https://latex.codecogs.com/gif.latex?\mu&space;=&space;\cos{\frac{\pi}{\mathrm{nx}}}&space;&plus;&space;\cos{\frac{\pi}{\mathrm{ny}}}"/>とする.
