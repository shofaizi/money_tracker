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
    });
  }

  var setDates = function(data){
    var buttonLeft = $('.button-left')[0],
        dateLabelLeft = $('.date-label-left')[0],
        buttonRight = $('.button-right')[0],
        dateLabelRight = $('.date-label-right')[0];

    buttonLeft.dataset.date = data.date_beginning;
    dateLabelLeft.innerHTML = data.date_beginning;
    buttonRight.dataset.date = data.date_end;
    dateLabelRight.innerHTML = data.date_end;
  }

  getInitialData()

  $('.button-left').click(function(){
    var begin_date = this.dataset.date;
    console.log('inside left', this.dataset);
    $.get('http://localhost:3000/overview/ajax?begin=' + begin_date, function(data){
      response_data = data
      setDates(data);
      $("#income").html(data.income);
      $("#expenses").html(data.expenses);
      $("#budget-left").html(data.budget_left);
      $(".date-header").html(data.date_beginning + ' - ' + data.date_end);
    });
  });

  $('.button-right').click(function(){
    if(response_data !== undefined) {
      var end_date = response_data.date_end
    } else {
      var end_date = this.dataset.date
    }

    $.get('http://localhost:3000/overview/ajax?end=' + end_date, function(data){
      response_data = data
      setDates(data);
      $("#income").html(data.income);
      $("#expenses").html(data.expenses);
      $("#budget-left").html(data.budget_left);
      $(".date-header").html(data.date_beginning + ' - ' + data.date_end);
    });
  });
});
