// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
     $('#competition_birthday').on('click',function(e){
        if($(this).is(':checked')){
           $('#previewDOB').show();
        } else {
            $('#previewDOB').hide();
        }
     });
})  ;