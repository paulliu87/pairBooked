$(document).ready( function(){
  // Slack username
  $("#slack-edit-button").on("click", function(e){
    e.preventDefault();
    $("#slack-edit-button").addClass("hidden");
    $("form#update-slack").removeClass("hidden");
  });
  $("form#update-slack").on('submit', function(e) {
    $("#slack-edit-button").removeClass("hidden");
    $("form#update-slack").addClass("hidden");
  });
});
