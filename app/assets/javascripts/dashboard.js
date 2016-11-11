$(document).ready( function(){
  $("#slack-edit-button").on("click",function(e){
    e.preventDefault();
    $("#slack-edit-button").addClass("hidden");
    $("form#update-slack").removeClass("hidden");
    $("form#update-slack").children().last().prop("disabled",false);
  });

  $("form#update-slack").on('submit', function(e) {
    e.preventDefault();
    var slackName  = $('#slack_name_slack_name').val();
    var promise = $.ajax({
      url:      '/slack_name',
      method:   'POST',
      data:     {slack_name: slackName},
    });
    promise.done(function(){
    $("#slack-edit-button").removeClass("hidden");
    $("form#update-slack").addClass("hidden");
    $("#slack-edit-button").prop("disabled",false);
    $('#slack_name').text(slackName);
    })
  });
});
