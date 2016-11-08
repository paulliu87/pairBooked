$(document).ready( function(){
  $('.timeslot').on('click', 'a', function(e){
    e.preventDefault();
    $target = $(e.target);
    if (window.confirm("Are you sure you want to pair at " + $target.text()+"?")) {
      window.location.replace($target.attr("href"));
    };
  });
});
