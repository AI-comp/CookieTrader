# Cookie Trader

Welcom to Cookie Trader
http://cookie-trader.herokuapp.com/

## How to start server
    npm start

## How to prepare develop environment
1. Install node.js (http://nodejs.org/)
2. Install dependecies  
```npm install```
3. Install CoffeeScript  
```npm install -g coffee-script```
4. Run ```run.bat``` on Windows / ```npm start``` on non-Windows

## How to run tests on Ubuntu
    sudo apt-get install libfontconfig1
    npm install phantomjs -g
    cd ~
    git clone git://github.com/n1k0/casperjs.git
    cd casperjs
    sudo ln -sf `pwd`/bin/casperjs /usr/local/bin/casperjs
    npm test

## How to run tests on Mac OS X
    brew install phantomjs
    brew install casperjs
    npm test

## How to deploy on Heroku
1. git remote add heroku git@heroku.com:cookie-trader.git
1. git push heroku master

## Requirements

- node.js v.0.10.19

## 仕様

- 部屋とかは無し
- アイテムが1個買われると、次の値段は1.15倍
