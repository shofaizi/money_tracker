$(document).ready(function(){
  var response_data;

  var getInitialData = function() {
    $.get('http://localhost:3000/overview/ajax?begin=' + new Date(), function(data){
      console.log(data);
      response_data = data
      $("#income").html(data.income);
      $("#expenses").html(data.expenses);
      $("#budget-left").html(data.budget_left);
      $(".date-header").html(data.date_beginning + ' - ' + data.date_end);
    })
  }

  getInitialData()

  $('.button-left').click(function(){

    // if(response_data !== undefined) {
    //   var begin_date = response_data.date_start
    // } else {
      var begin_date = new Date()
    // }
    console.log(begin_date)
    $.get('http://localhost:3000/overview/ajax?begin=' + begin_date, function(data){
      console.log(data);
      response_data = data
      $("#income").html(data.income);
      $("#expenses").html(data.expenses);
      $("#budget-left").html(data.budget_left);
      $(".date-header").html(data.date_beginning + ' - ' + data.date_end);
    })
  });

  $('.button-right').click(function(){
    if(response_data !== undefined) {
      var end_date = response_data.date_end
      console.log(response_data)
      console.log(end_date);
    } else {
      var end_date = new Date()
    }
    $.get('http://localhost:3000/overview/ajax?end=' + end_date, function(data){
      $("#income").html(data.income);
      $("#expenses").html(data.expenses);
      $("#start").html(data.start);
      $("#end").html(data.end);
      $("#budget-left").html(data.budget_left);
      $(".date-header").html(data.date_beginning + ' - ' + data.date_end);
    })
  });
});
