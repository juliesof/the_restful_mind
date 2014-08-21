$(document).ready(function() {

  $('#end-button').hide();
  $('#final-step').hide();

  SittingSpace.initialize();
});

var SittingSpace = {
  initialize: function(){
    $('#start-button').click(this.clickStartButton);
    $('#end-button').click(this.clickEndButton);
  },

  clickStartButton: function(event) {
    event.preventDefault();
    var startTime = new Date();
    alert(startTime);
    $('#end-button').show();
    $('#start-button').hide();
    $.ajax({
      url: '/sittings',
      type: 'POST',
      dataType: 'json',
      data: {sitting: {start_time: startTime}},
    })
    .done(function() {
      console.log("success");
    })
    .fail(function() {
      alert('did not work');
    });
  },

  clickEndButton: function(event) {
    event.preventDefault();
    var endTime = new Date();
    $('#end-button').val(endTime);
    alert(endTime);
    $('#end-button').hide();
    $('#final-step').show();
  },


};
