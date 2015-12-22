ready = ->
  if $('.page-template').length > 0
    page_parts = $('.page-template').data('page-parts')
    show_page_parts(page_parts)

  $('.sortable-grid').sortable().bind 'sortupdate', (e) ->
    position_array = []
    $(e.target).find('li.image').each (index) ->
      position_array.push $(this).data('photo-id')
    $(e.target).parents('td').find('.photo-positions').val(position_array.join(","))

  $('.structure-form-menu ul').sortable().bind 'sortupdate', (e) ->
    $(e.target).find('li').each (index) ->
      id = $(this).data('structure-item-id')
      $(".structure_form_pane_#{id}_position").val(index)

$(document).on 'ready page:load', ready

# Change templates makes page parts appear and disappear
$(document).on 'change', '.page-template select', ->
  page_parts = $(this).find('option:selected').data('page-parts').split(" ")
  show_page_parts(page_parts)

show_page_parts = (page_parts) ->
  $('tr.page-part').hide()
  for page_part in page_parts
    $('tr.page-part[data-name=' + page_part + ']').show()

# Sort pages
$(document).on 'click', '.sort-switch', (event) ->
  $($(this).attr('href') + ' .dd-item-inner').toggleClass('dd-handle')
  if $(this).hasClass('button-success')
    $(this).removeClass('button-success')
    $(this).text($(this).data('change-order'))
    $(this).prepend('<i class="icon icon-random"></i>')
  else
    $(this).addClass('button-success')
    $(this).text($(this).data('done-changing-order'))
    $(this).prepend('<i class="icon icon-check"></i>')
  return false
