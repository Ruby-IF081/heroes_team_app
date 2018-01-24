$ ->
  # Disable the form while creating a form
  $(".comment-form")
    .on "ajax:beforeSend", (evt, xhr, settings) ->
      $(this).find('textarea')
        .addClass('uneditable-input')
        .attr('disabled', 'disabled');
    .on "ajax:success", (evt, data, status, xhr) ->
      $(this).find('textarea')
        .removeClass('uneditable-input')
        .removeAttr('disabled', 'disabled')
        .val('');
  # Delete a comment
  $(document)
    .on "ajax:beforeSend", ".comment-list", ->
      $(this).fadeTo('fast', 0.5)
    .on "ajax:success", ".comment-list", ->
      $(this).hide('fast')
    .on "ajax:error", ".comment-list", ->
      $(this).fadeTo('fast', 1)