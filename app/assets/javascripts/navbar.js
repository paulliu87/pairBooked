$(document).ready( function(){
  $('#time-zone-update-button').addClass('hidden');
  $("#timezone_time_zone").on('change', function(e){
    var currentTimeZone = "";
    e.preventDefault();
    // debugger
    $( "#timezone_time_zone option:selected" ).each(function() {
      currentTimeZone = $( this ).val();
    });
    var promise = $.ajax({
      url:      '/timezone',
      method:   'POST',
      data:     {time_zone: currentTimeZone}
    })
  });

});
