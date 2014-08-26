<table>
  <tr>
    <td>
      <a href=# OnClick=update_alarm('h','up')>
        <img src=images/up.jpg border='0'>
      </a>
    </td>

    <td>
      <a href=# OnClick=update_alarm('m','up')>
        <img src=images/up.jpg border='0'>
      </a>
    </td>

    <td>
      <a href=# OnClick=update_alarm('s','up')>
        <img src=images/up.jpg border='0'>
      </a>
    </td>
  </tr>

  <tr>
    <td>
      <input type=text size=2 id='h1' name='h1' value=00 onBlur=update_alarm('h','none')>
    </td>

    <td>
      <input type=text size=2 id='m1' name='m1' value=00 onBlur=update_alarm('m','none')>
    </td>

    <td>
      <input type=text size=2 id='s1' name='s1' value=00 onBlur=update_alarm('s','none')>
    </td>
  </tr>

  <tr>
    <td>
      <a href=# OnClick=update_alarm('h','down')>
        <img src=images/down.jpg border='0'>
      </a>
    </td>

    <td>
      <a href=# OnClick=update_alarm('m','down')>
        <img src=images/down.jpg border='0'>
      </a>
    </td>

    <td>
      <a href=# OnClick=update_alarm('s','down')>
        <img src=images/down.jpg border='0'>
      </a>
    </td>
  </tr>
</table>









function Timer(target, action, interval, repeat) {
  var t;
  var isRunning = false;

  var fire = function(){
    target[action].call(target);
    if (repeat === true) {
      cycle();
    }
  };

  var cycle = function(){
    if (isRunning) {
      t = window.setTimeout(function(){fire();}, interval);
    }
  };

  this.start = function(){
    isRunning = true;
    fire();
  };

  this.stop = function(){
    isRunning = false;
    window.clearTimeout(t);
  };
};

function SoundEngine() {
  var chimes = {};

  this.loadSounds = function() {
    if (window.HTMLAudioElement) {
      for (var i = 0; i < 4; i++) {
        var url = "";

        chimes[i] = new Audio();

        if (chimes[i].canPlayType("audio/ogg")) {
          url = "media/chime.ogg";
        } else if (chimes[i].canPlayType("audio/mpeg")) {
          url = "media/chime.mp3";
        }

        chimes[i].src = url;
        chimes[i].loop = false;
        chimes[i].autoplay = false;
        chimes[i].load();
      }
    } else {
      chimes[0] = "media/chime.mp3";
    }
  };

  this.playSound = function(i) {
    if (window.HTMLAudioElement) {
      if (typeof chimes[i] !== 'undefined') {
        if (!chimes[i].paused) {
          chimes[i].pause();
          chimes[i].currentTime = 0;
        }
      }

      chimes[i].play();
    } else {
      $("#mtSound").append("<embed type=\"audio/mpeg\" src=\"" + chimes[0] + "\" hidden=\"true\" autostart=\"true\" loop=\"false\" /></embed>");
    }
  };

  this.stopSound = function() {
    if (window.HTMLAudioElement) {
      for (var i = 0; i < 4; i++) {
        if (typeof chimes[i] !== 'undefined') {
          if (!chimes[i].paused) {
            chimes[i].pause();
            chimes[i].currentTime = 0;
          }
        }
      }
    } else {
      $("#mtSound").empty();
    }
  };
}

function MeditationTimer(delegate) {

  var defaults = {
    prepareTime: 10,
    meditationTime: 1200,
    intervalTime: 600
  };

  this.phases = {
    start: 0,
    prepare: 1,
    meditation: 2,
    end: 3
  };

  this.timer = new Timer(this, "fireTimer", 1000, true);
  this.isRunning = false;
  this.currentPhase = this.phases.start;
  this.currentMeditationTime = 0;
  this.currentIntervalTime = 0;
  this.prepareTime = 0;
  this.meditationTime = 0;
  this.intervalTime = 0;
  this.totalIntervals = 0;
  this.currentInterval = 1;

  this.saveTimer = function(){
    var date = new Date();
    date.setTime(date.getTime()+(365*24*60*60*1000));
    var expires = "expires=" + date.toGMTString();
    document.cookie = "prepareTime=" + this.prepareTime + "; " + expires + "; path=/";
    document.cookie = "meditationTime=" + this.meditationTime + "; " + expires + "; path=/";
    document.cookie = "intervalTime=" + this.intervalTime +  "; " + expires + "; path=/";
  };

  this.loadTimer = function(){
    if (document.cookie) {
      var cookieString = document.cookie.replace(' ', '');
      var cookiesArray = cookieString.split(";");
      var prepareArray = cookiesArray[2].split("=");
      var meditationArray = cookiesArray[1].split("=");
      var intervalArray = cookiesArray[0].split("=");
      var prepareValue = 0;
      var meditationValue = 0;
      var intervalValue = 0;

      for (i=1; i<=cookiesArray.length; i++) {
        var settingArray = cookiesArray[(i-1)].split("=");
        if (settingArray[0].match("prepareTime")) {
          prepareValue = settingArray[1];
        }
        if (settingArray[0].match("meditationTime")) {
          meditationValue = settingArray[1];
        }
        if (settingArray[0].match("intervalTime")) {
          intervalValue = settingArray[1];
        }
      }

      this.prepareTime = window.parseInt(prepareValue);
      this.meditationTime = window.parseInt(meditationValue);
      this.intervalTime = window.parseInt(intervalValue);
    }
    else {
      this.prepareTime = defaults.prepareTime;
      this.meditationTime = defaults.meditationTime;
      this.intervalTime = defaults.intervalTime;
    }
  };

  this.start = function(){
    if (this.isRunning) {
      return;
    }
    if (this.currentPhase == this.phases.start) {
      if (this.intervalTime > 0) {
        this.totalIntervals = Math.ceil(this.meditationTime / this.intervalTime);
      }
      this.currentPhase = this.calculateNextPhase(this.currentPhase);
    }
    if (this.currentPhase != this.phases.end) {
      this.isRunning = true;
      this.timer.start();
    }
    else {
      this.endSession();
    }
  };

  this.stop = function(){
    if (this.isRunning) {
      this.isRunning = false;
      this.timer.stop();
    }
  };

  this.reset = function(){
    this.stop();
    this.currentPhase = this.phases.start;
    this.currentMeditationTime = 0;
    this.currentIntervalTime = 0;
    this.totalIntervals = 0;
    this.currentInterval = 1;
  };

  this.endSession = function(){
    this.reset();
    delegate['sessionEnded'].call(this);
  }

  this.calculateNextPhase = function(phase){
    switch (phase) {
      case this.phases.start:
        if (this.prepareTime > 0) {
          this.currentPhase = this.phases.prepare;
        }
        else if (this.meditationTime > 0) {
          this.currentPhase = this.phases.meditation;
        }
        else {
          this.currentPhase = this.phases.end;
        }
        break;
      case this.phases.prepare:
        if (this.meditationTime > 0) {
          this.currentPhase = this.phases.meditation;
        }
        else {
          this.currentPhase = this.phases.end;
        }
        break;
      case this.phases.meditation:
        this.currentPhase = this.phases.end;
        break;
      default:
        break;
    }

    delegate['phaseChanged'].call(this);

    if (this.currentPhase == this.phases.prepare) {
      this.currentMeditationTime = this.prepareTime;
    }

    if (this.currentPhase == this.phases.meditation) {
      this.currentMeditationTime = this.meditationTime;
      if (this.intervalTime > 0) {
        this.currentIntervalTime = this.intervalTime;
      }
    }

    return this.currentPhase;
  };

  this.fireTimer = function(){
    this.currentMeditationTime = (this.currentMeditationTime - 1);

    if (this.currentPhase == this.phases.meditation && this.intervalTime > 0) {
      this.currentIntervalTime = (this.currentIntervalTime - 1);
      if (this.currentIntervalTime == 0 && this.currentMeditationTime != 0) {
        this.currentIntervalTime = this.intervalTime;
        this.currentInterval++;
        delegate['intervalEnded'].call(this);
      }
      delegate['intervalFired'].call(this);
    }

    delegate['timerFired'].call(this);

    if (this.currentMeditationTime == 0) {
      if (this.calculateNextPhase(this.currentPhase) == this.phases.end) {
        delegate['sessionCompleted'].call(this);
        this.endSession();
      }
    }
  };
};

function MeditationTimerViewController() {
  var meditationTimer = new MeditationTimer(this);
  var soundEngine = new SoundEngine();

  var settings = {
    prepare: 0,
    meditation: 1,
    interval: 2
  };

  var activeSetting = settings.meditation;
  var settingTimer;
  var settingTimerIntervals = 300;

  // SOUNDS

  var chime;
  var chimeTimer;
  var numberOfChimes = 0;
  var totalChimes = 0;

  this.loadSounds = function() {
    soundEngine.loadSounds();
  }

  var playChime = function(i) {
    soundEngine.playSound(i);

    i++;
    numberOfChimes--;

    var chimeDuration;

    if (totalChimes == 2 && numberOfChimes == 1) {
      chimeDuration = 6000;
    }

    if (totalChimes == 3 && numberOfChimes == 2) {
      chimeDuration = 4000;
    }

    if (totalChimes == 3 && numberOfChimes == 1) {
      chimeDuration = 10000;
    }

    if (numberOfChimes > 0) {
      chimeTimer = window.setTimeout(function(){ playChime(i); }, chimeDuration);
    }
  };

  var chimeOne = function(){
    numberOfChimes = 1;
    totalChimes = 1;
    window.clearTimeout(chimeTimer);
    playChime(1);
  };

  var chimeTwo = function(){
    numberOfChimes = 2;
    totalChimes = 2;
    playChime(1);
  };

  var chimeThree = function(){
    numberOfChimes = 3;
    totalChimes = 3;
    playChime(1);
  };

  // HELPERS

  var convertToTimeFormat = function(num) {
    var hrs  = Math.floor(num / 3600);
    var mins = Math.floor((num % 3600) / 60);
    var secs = (num % 60);
    return ((hrs > 0) ? hrs + ":" : "") + ((mins < 10) ? "0" : "") + mins + ":" + ((secs < 10) ? "0" : "") + secs;
  };

  var changeSettingValue = function(i){
    if (activeSetting == settings.prepare) {
      meditationTimer.prepareTime += i;
      meditationTimer.prepareTime = Math.min(Math.max(meditationTimer.prepareTime,0),3599);
      $("#mtOverallTime").html(convertToTimeFormat(meditationTimer.prepareTime));
      $("#mtPrepareTimeSetting").html(convertToTimeFormat(meditationTimer.prepareTime));
    }
    else if (activeSetting == settings.meditation) {
      meditationTimer.meditationTime += i;
      meditationTimer.meditationTime = Math.min(Math.max(meditationTimer.meditationTime,0),3599);
      $("#mtOverallTime").html(convertToTimeFormat(meditationTimer.meditationTime));
      $("#mtMeditationTimeSetting").html(convertToTimeFormat(meditationTimer.meditationTime));
    }
    else if (activeSetting == settings.interval) {
      meditationTimer.intervalTime += i;
      meditationTimer.intervalTime = Math.min(Math.max(meditationTimer.intervalTime,0),3599);
      $("#mtOverallTime").html(convertToTimeFormat(meditationTimer.intervalTime));
      $("#mtIntervalTimeSetting").html(convertToTimeFormat(meditationTimer.intervalTime));
    }

    settingTimer = window.setTimeout(function(){changeSettingValue(i);}, settingTimerIntervals)
    settingTimerIntervals = (settingTimerIntervals > 100) ? (settingTimerIntervals - 50) : settingTimerIntervals;
  };

  var invalidateChangeSettingValue = function(){
    window.clearTimeout(settingTimer);
    settingTimerIntervals = 300;
  };

  var showChangeArrows = function(){
    $("#mtSettingTimeMinutesArrowUp").fadeIn("fast");
    $("#mtSettingTimeMinutesArrowDown").fadeIn("fast");
    $("#mtSettingTimeSecondsArrowUp").fadeIn("fast");
    $("#mtSettingTimeSecondsArrowDown").fadeIn("fast");
  };

  var hideChangeArrows = function(){
    $("#mtSettingTimeMinutesArrowUp").fadeOut("fast");
    $("#mtSettingTimeMinutesArrowDown").fadeOut("fast");
    $("#mtSettingTimeSecondsArrowUp").fadeOut("fast");
    $("#mtSettingTimeSecondsArrowDown").fadeOut("fast");
  };

  // DISPLAY

  var displayForSetup = function(setting){
    switch (setting) {
      case settings.prepare:
        activeSetting = settings.prepare;
        $("#mtOverallTime").html(convertToTimeFormat(meditationTimer.prepareTime));
        break;
      case settings.meditation:
        activeSetting = settings.meditation;
        $("#mtOverallTime").html(convertToTimeFormat(meditationTimer.meditationTime));
        break;
      case settings.interval:
        activeSetting = settings.interval;
        $("#mtOverallTime").html(convertToTimeFormat(meditationTimer.intervalTime));
        break;
      default:
        break;
    }

    $("#mtSettings li").removeClass("active");
    $("#mtSettings li:nth-child(" + (setting + 1) + ")").addClass("active");
  };

  var displayForPhase = function(phase){
    switch (phase) {
      case meditationTimer.phases.start:
        showChangeArrows();
        $("#mtOverallTime").html(convertToTimeFormat(meditationTimer.meditationTime));
        $("#mtIntervalTime").html("");
        break;
      case meditationTimer.phases.prepare:
        hideChangeArrows();
        $("#mtOverallTime").html(convertToTimeFormat(meditationTimer.prepareTime));
        $("#mtIntervalTime").html("");
        break;
      case meditationTimer.phases.meditation:
        hideChangeArrows();
        chimeOne();
        $("#mtOverallTime").html(convertToTimeFormat(meditationTimer.meditationTime));
        if (meditationTimer.intervalTime > 0) {
          $("#mtIntervalTime").html(convertToTimeFormat(meditationTimer.intervalTime) + " (" + meditationTimer.currentInterval + "/" + meditationTimer.totalIntervals + ")");
        }
        else {
          $("#mtIntervalTime").html("");
        }
        break;
      default:
        break;
    }
  };

  this.onLoadDisplay = function(){
    meditationTimer.loadTimer();
    displayForSetup(activeSetting);
    $("#mtPrepareTimeSetting").html(convertToTimeFormat(meditationTimer.prepareTime));
    $("#mtMeditationTimeSetting").html(convertToTimeFormat(meditationTimer.meditationTime));
    $("#mtIntervalTimeSetting").html(convertToTimeFormat(meditationTimer.intervalTime));
    $("#mtIntervalTime").hide();
    $("#mtStartButton").text("Meditate");
    $("#mtPauseButton").text("Pause");
    $("#mtStopButton").text("Stop");
    $("#mtPauseButton").hide();
    $("#mtStopButton").hide();
  };

  // DELEGATE

  this.timerFired = function(){
    $("#mtOverallTime").html(convertToTimeFormat(meditationTimer.currentMeditationTime));
  };

  this.intervalFired = function(){
    if (meditationTimer.currentIntervalTime > 0) {
      $("#mtIntervalTime").html(convertToTimeFormat(meditationTimer.currentIntervalTime) + " (" + meditationTimer.currentInterval + "/" + meditationTimer.totalIntervals + ")");
    }
    else {
      $("#mtIntervalTime").html(convertToTimeFormat(meditationTimer.intervalTime) + " (" + meditationTimer.currentInterval + "/" + meditationTimer.totalIntervals + ")");
    }
  };

  this.intervalEnded = function(){
    chimeTwo();
  };

  this.sessionCompleted = function(){
    chimeThree();
  };

  this.phaseChanged = function(){
    displayForPhase(meditationTimer.currentPhase);
  };

  this.sessionEnded = function(){
    displayForPhase(meditationTimer.currentPhase);
    displayForSetup(activeSetting);
    $("#mtIntervalTime").html("");
    $("#mtIntervalTime").hide();
    $("#mtSettings").fadeIn("fast");
    $("#mtStartButton").fadeIn("fast");
    $("#mtPauseButton").hide();
    $("#mtPauseButton").text("Pause");
    $("#mtStopButton").hide();
  };

  // ACTIONS

  this.settingsButtonPushedAction = function(sender){
    if (!meditationTimer.isRunning) {
      displayForSetup($(sender).index());
    }
    return false;
  };

  this.pauseButtonPushedAction = function(sender){
    if (meditationTimer.isRunning) {
      meditationTimer.stop();
      $(sender).text("Resume");
    }
    else {
      meditationTimer.start();
      $(sender).text("Pause");
    }
    return false;
  };

  this.startButtonPushedAction = function(sender){
    if (!meditationTimer.isRunning) {
      meditationTimer.start();
      meditationTimer.saveTimer();
      $("#mtIntervalTime").fadeIn("fast");
      $("#mtSettings").hide();
      $("#mtStartButton").hide();
      $("#mtPauseButton").fadeIn("fast");
      $("#mtStopButton").fadeIn("fast");
      soundEngine.stopSound();
    }
    return false;
  };

  this.stopButtonPushedAction = function(sender){
    meditationTimer.endSession();
    soundEngine.stopSound();
    return false;
  };

  this.plusButtonPushedAction = function(secs){
    changeSettingValue(secs);
    return false;
  };

  this.minusButtonPushedAction = function(secs){
    changeSettingValue(secs);
    return false;
  };

  this.plusButtonReleasedAction = function(){
    invalidateChangeSettingValue();
    return false;
  };

  this.minusButtonReleasedAction = function(){
    invalidateChangeSettingValue();
    return false;
  };

  this.testSound = function(){
    soundEngine.stopSound();
    soundEngine.playSound(0);
    return false;
  };
};

$(document).ready(function(){
  var meditationTimer = new MeditationTimerViewController();

  meditationTimer.onLoadDisplay();
  meditationTimer.loadSounds();

  $("#soundTest").click(function(){
    return meditationTimer.testSound();
  });

  $("#mtSettings li").click(function(){
    return meditationTimer.settingsButtonPushedAction(this);
  });
  $("#mtStartButton").click(function(){
    return meditationTimer.startButtonPushedAction(this);
  });
  $("#mtPauseButton").click(function(){
    return meditationTimer.pauseButtonPushedAction(this);
  });

  $("#mtStopButton").click(function(){
    return meditationTimer.stopButtonPushedAction(this);
  });

  $("#mtSettingTimeMinutesArrowUp").click(function(){
    return false;
  });
  $("#mtSettingTimeMinutesArrowUp").mousedown(function(){
    return meditationTimer.plusButtonPushedAction(60);
  });
  $("#mtSettingTimeMinutesArrowUp").mouseup(function(){
    return meditationTimer.plusButtonReleasedAction();
  });
  $("#mtSettingTimeMinutesArrowUp").mouseout(function(){
    return meditationTimer.plusButtonReleasedAction();
  });

  $("#mtSettingTimeMinutesArrowDown").click(function(){
    return false;
  });
  $("#mtSettingTimeMinutesArrowDown").mousedown(function(){
    return meditationTimer.plusButtonPushedAction(-60);
  });
  $("#mtSettingTimeMinutesArrowDown").mouseup(function(){
    return meditationTimer.plusButtonReleasedAction();
  });
  $("#mtSettingTimeMinutesArrowDown").mouseout(function(){
    return meditationTimer.plusButtonReleasedAction();
  });

  $("#mtSettingTimeSecondsArrowUp").click(function(){
    return false;
  });
  $("#mtSettingTimeSecondsArrowUp").mousedown(function(){
    return meditationTimer.plusButtonPushedAction(1);
  });
  $("#mtSettingTimeSecondsArrowUp").mouseup(function(){
    return meditationTimer.plusButtonReleasedAction();
  });
  $("#mtSettingTimeSecondsArrowUp").mouseout(function(){
    return meditationTimer.plusButtonReleasedAction();
  });

  $("#mtSettingTimeSecondsArrowDown").click(function(){
    return false;
  });
  $("#mtSettingTimeSecondsArrowDown").mousedown(function(){
    return meditationTimer.plusButtonPushedAction(-1);
  });
  $("#mtSettingTimeSecondsArrowDown").mouseup(function(){
    return meditationTimer.plusButtonReleasedAction();
  });
  $("#mtSettingTimeSecondsArrowDown").mouseout(function(){
    return meditationTimer.plusButtonReleasedAction();
  });
});
