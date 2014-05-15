
$(window).bind('page:change', function(){
  console.log("document is ready");
  var old_index;
  var new_index;
  $('.sortable').sortable();
  
  $('.sortable').bind('dragstart',function(event){
    //alert("ciao" + event.target.innerHTML.index());
    if( $(event.target).is('img'))
    {
      old_index = $(event.target).parent().parent().parent().index();
      console.log(" indice figura : " + old_index);
    }
    else
    {
      old_index = $(event.target).index();
    }
  });
  

  $('.sortable').sortable().bind('sortupdate',function(e,ui){

    new_index = ui.item.index();

    course_id= location.toString().split("/")[4];
    lesson_id= location.toString().split("/")[6];
    var data= 'course_id=' + course_id + '&id=' + lesson_id + '&old=' + old_index + '&new=' + new_index;
    if(location.toString().indexOf('?') >=0)
    {
      parent_id=location.toString().split("?")[1].split("=")[1];
      console.log("course id vale " + course_id + " e lesson id vale " + lesson_id+ " e parent_id vale" + parent_id);
      
      data=data+'&parent_id=' + parent_id;
    }
      console.log("course id vale " + course_id + " e lesson id vale " + lesson_id);

    
    //console.log(data);
    $.ajax({
      url: "relocate",
      data: data,
      //context: document.body
    }).done(function(){
	//$( this ).addClass( "done" );
	//alert("DATI INVIATI");
    });
});

    

});