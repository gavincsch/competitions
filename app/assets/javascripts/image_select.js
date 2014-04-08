/**
 * Created with JetBrains RubyMine.
 * User: gavin
 * Date: 2014/01/26
 * Time: 7:08 PM
 * To change this template use File | Settings | File Templates.
 */
$(document).ready(function(){

    $('.imageSelectModal').on('click', function(){
        inputId = $(this).parent().find('input').attr('id');
        preview = $(this).data('preview');

    });

    $('#ImageSelect img').on('click',function(){

        var inputValue      = $(this).data('value');
        var previewValue    = $(this).data('preview');

        $('#' + inputId).val(inputValue);
        $('#' + preview).attr('src' , previewValue);
    });

});
