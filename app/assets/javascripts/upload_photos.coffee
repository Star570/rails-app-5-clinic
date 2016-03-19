# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
    $(document).on 'click', '#upload_photo_file', ->
        $('#finish_button').attr('class', 'btn btn-lg btn-success fileinput-button pull-right hide');

    $('#upload_photo_file').fileupload
        dataType: 'json'

        # done: (e, data)->
        #     console.log('Enter Done')
        #     $.each data.result.files, (index, file) ->
        #         console.log('Enter Done each')
        #         console.log(file.url)
                #list = $('#preview')
                #list.find('#file_url').attr('href', file.url)
                #list.find('#file_image').attr('src', file.small_url)
                #list.find('#file_name').text(file.name)
                #list.find('#file_delete').attr('data-method', file.delete_type).attr('href', file.delete_url)
                #list.find('#file_delete').attr('data-remote', true)
                #list.removeClass('hide').appendTo('#preview');


        progressall: (e, data)->    
            progress = parseInt(data.loaded / data.total * 100, 10)
            $('.progress .progress-bar').css('width', "#{progress}%")
       

    $(document).bind 'dragover': (e) ->
        dropZone = $('#dropzone'); timeout = window.dropZoneTimeout

        if(!timeout)
            dropZone.addClass('in')
        else
            clearTimeout(timeout)

        found = false; node = e.target;
        loop
            if( node is dropZone[0])
                found = true
                break;
            node = node.parentNode
            break if(node isnt null)
        if(found)
            dropZone.addClass('hover')
        else
            dropZone.removeClass('hover')

        window.dropZoneTimeout =
            setTimeout ->
                window.dropZoneTimeout = null;
                dropZone.removeClass('in hover');
            , 100

    $(document).on 'click', 'a.delete', ->
        $(this).parents('.media').remove()