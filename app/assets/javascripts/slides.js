
$(document).ready(function(){
    $('.sortable').sortable();
  

    $('.sortable').sortable().bind('sortupdate',function(){

  alert("index" + $(this).data("sortable"));
 });
});

    
    //$('.sortable').sortable({ forcePlaceholderSize: true});
