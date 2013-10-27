// Generated by CoffeeScript 1.6.3
(function() {
  $(function() {
    var FPS, TYPING_CHARACTERS, nextCode, player, pretty, prevTime, render, renderInfo, socket, start, startTimer, started, textGen, typingText;
    pretty = function(val) {
      var num;
      val = Math.floor(val);
      num = new String(val);
      while (true) {
        if (num === (num = num.replace(/^(-?\d+)(\d{3})/, "$1,$2"))) {
          break;
        }
      }
      return num;
    };
    FPS = 10;
    TYPING_CHARACTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    player = null;
    prevTime = null;
    started = false;
    typingText = null;
    nextCode = null;
    textGen = function() {
      var i, kinds, _i, _results;
      kinds = TYPING_CHARACTERS.length;
      _results = [];
      for (i = _i = 0; _i < 10; i = ++_i) {
        _results.push(typingText += TYPING_CHARACTERS.charAt(Math.floor(Math.random() * kinds)));
      }
      return _results;
    };
    render = (function() {
      var cookieElem, cpsElem, typingElem;
      cookieElem = $('#my-total-cookie');
      cpsElem = $('#my-cps');
      typingElem = $('#typing-text');
      return function() {
        var amount, bakery, cps, _ref, _results;
        cps = Player.calcCPS(player.bakeries, player.equips);
        cookieElem.text(pretty(player.totalCookie));
        cpsElem.text(pretty(cps));
        typingElem.text(typingText);
        _ref = player.bakeries;
        _results = [];
        for (bakery in _ref) {
          amount = _ref[bakery];
          $("#my-" + bakery + " .amount").text(amount);
          if (amount >= 1) {
            _results.push($('#my-' + bakery + ' .bakery-sell').css("visibility", "visible"));
          } else {
            _results.push($('#my-' + bakery + ' .bakery-sell').css("visibility", "hidden"));
          }
        }
        return _results;
      };
    })();
    renderInfo = function(info) {
      var amount, bakeries, bakery, _results;
      bakeries = info.bakeries;
      _results = [];
      for (bakery in bakeries) {
        amount = bakeries[bakery];
        $("#bakery-" + bakery + " .amount").text(amount);
        $('#bakery-' + bakery + ' .bakery-price').text(pretty(Bakery.calcPrice(bakeries, bakery)));
        if (Math.floor(Bakery.calcPrice(bakeries, bakery)) <= player.totalCookie) {
          _results.push($('#bakery-' + bakery + ' .bakery-price').css("color", "#6f6"));
        } else {
          _results.push($('#bakery-' + bakery + ' .bakery-price').css("color", "#f66"));
        }
      }
      return _results;
    };
    startTimer = function() {
      var curTime;
      curTime = new Date().getTime();
      Player.earn(player, (curTime - prevTime) / 1000);
      render();
      prevTime = curTime;
      return setTimeout(startTimer, 1000 / FPS);
    };
    start = function() {
      typingText = '';
      textGen();
      nextCode = typingText.charCodeAt(0);
      prevTime = new Date().getTime();
      startTimer();
      started = true;
      return setInterval(function() {
        return socket.emit('getInfo', {
          player: player
        });
      }, 1000);
    };
    socket = io.connect('http://localhost:5000/');
    socket.on('connect', function() {
      return console.log('connect!');
    });
    socket.on('disconnect', function() {
      return console.log("disconnect from server");
    });
    socket.on('participate', function(obj) {
      return player = obj.player;
    });
    socket.on('getInfo', function(obj) {
      return renderInfo(obj);
    });
    socket.on('start', function() {
      console.log('start!');
      return start();
    });
    socket.on('buy', function(obj) {
      var bakery, bakeryName, price, status;
      status = obj.status;
      if (status === 'ok') {
        bakeryName = obj.bakeryName;
        bakery = obj.bakery;
        price = obj.price;
        player.bakeries[bakery] += 1;
        return player.totalCookie -= price;
      }
    });
    socket.on('sell', function(obj) {
      var bakery, bakeryName, price, status;
      status = obj.status;
      if (status === 'ok') {
        bakeryName = obj.bakeryName;
        bakery = obj.bakery;
        price = obj.price;
        player.bakeries[bakery] -= 1;
        return player.totalCookie += price / 2;
      }
    });
    $(document).keydown(function(e) {
      if (!started) {
        return;
      }
      if (e.keyCode === nextCode) {
        Player.earnByClick(player);
        typingText = typingText.substr(1);
        if (typingText === '') {
          textGen();
        }
        nextCode = typingText.charCodeAt(0);
        return render();
      }
    });
    $('.bakery-item').click(function(e) {
      var bakeryName, id;
      if (!started) {
        return;
      }
      id = e.currentTarget.id;
      id.match(/bakery-(.+)/);
      bakeryName = RegExp.$1;
      return socket.emit('buy', {
        player: player,
        bakery: bakeryName
      });
    });
    $('.my-item').click(function(e) {
      var bakeryName, id;
      if (!started) {
        return;
      }
      id = e.currentTarget.id;
      id.match(/my-(.+)/);
      bakeryName = RegExp.$1;
      return socket.emit('sell', {
        player: player,
        bakery: bakeryName
      });
    });
    return $('#participate-button').click(function(e) {
      socket.emit('participate', {
        'name': $('#player-name').val()
      });
      return $('#cover').remove();
    });
  });

}).call(this);
