$(document).ready(function(){

  $('.button-left').click(function(){
    $.get('http://localhost:3000/overview/ajax?begin=2016-12-08',function(data){
      console.log(data);
      $("#income").html(data.income);
      $("#expenses").html(data.income);
      $("#start").html(data.start);
      $("#end").html(data.end);
      $("#budget-left").html(data.budget_left);

    })
  });

  $('.button-right').click(function(){
    $.get('http://localhost:3000/overview/ajax?end=2016-12-31', function(data){
      console.log(data);
      $("#income").html(data.income);
      $("#expenses").html(data.expenses);
      $("#start").html(data.start);
      $("#end").html(data.end);
      $("#budget-left").html(data.budget_left);
    })
  });
});
