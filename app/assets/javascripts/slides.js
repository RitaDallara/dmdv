
$(document).ready(function(){
  console.log("document is ready");
  var old_index;
  var new_index;
  $('.sortable').sortable();
  
  $('.sortable').bind('dragstart',function(event){
    //alert("ciao" + event.target.innerHTML.index());

    old_index = $(event.target).index();
  });
  

  $('.sortable').sortable().bind('sortupdate',function(e,ui){

    new_index = ui.item.index();

    course_id= location.toString().split("/")[4];
    lesson_id= location.toString().split("/")[6];
    //console.log("course id vale " + course_id + " e lesson id vale " + lesson_id);
    var data= 'course_id=' + course_id + '&id=' + lesson_id + '&old=' + old_index + '&new=' + new_index;
    //console.log(data);
    $.ajax({
      url: "relocate",
      data: data,
      //context: document.body
    }).done(function(){
	//$( this ).addClass( "done" );
	alert("DATI INVIATI");
    });
});

    

});