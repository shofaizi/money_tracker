$(document).ready(function(){
  var response_data;

  var getInitialData = function() {
    $.get('http://localhost:3000/overview/ajax?begin=' + new Date(), function(data){
      console.log("Data from home:", data);
      response_data = data
      $("#income").html(data.income);
      $("#expenses").html(data.expenses);
      $("#budget-left").html(data.budget_left);
      $(".date-header").html(data.date_beginning + ' - ' + data.date_end);
    });
  }

  var setDates = function(data){
    var buttonLeft = $('.button-left'),
        dateLabelLeft = $('.date-label-left'),
        buttonRight = $('.button-right'),
        dateLabelRight = $('.date-label-right');

    buttonLeft.attr('data-date', data.date_beginning);
    dateLabelLeft.html(data.date_beginning);
    buttonRight.attr('data-date', data.date_end);
    dateLabelRight.html(data.date_end);
  }

  getInitialData()

  $('.button-left, .button-right').click(function(e){
    var begin_date = this.dataset.date;


    console.log('Begin data:', begin_date)

    var direction = /right/.test(this.className) ? 'end' : 'begin'
    var requestUrl = 'http://localhost:3000/overview/ajax?' + direction + '=' + begin_date

    console.log('requestUrl:', requestUrl)
    $.get(requestUrl, function(data){
      console.log(data)
      response_data = data
      setDates(data);
      $("#income").html(data.income);
      $("#expenses").html(data.expenses);
      $("#budget-left").html(data.budget_left);
      $(".date-header").html(data.date_beginning + ' - ' + data.date_end);
    });
  });

  // $('.button-right').click(function(){
  //   if(response_data !== undefined) {
  //     var end_date = response_data.date_end
  //   } else {
  //     var end_date = this.dataset.date
  //   }
  //
  //   $.get('http://localhost:3000/overview/ajax?end=' + end_date, function(data){
  //     response_data = data
  //     setDates(data);
  //     $("#income").html(data.income);
  //     $("#expenses").html(data.expenses);
  //     $("#budget-left").html(data.budget_left);
  //     $(".date-header").html(data.date_beginning + ' - ' + data.date_end);
  //   });
  // });
});
