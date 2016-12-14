$(document).ready(function(){
  $('.trash').click(function(){
    var trashId = $(this).attr('data-id');
    $('[data-id='+trashId+']').fadeOut(1000);
  });
});
