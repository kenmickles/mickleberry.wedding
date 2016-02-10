window.initPhotos = ->
  $container = $('.grid').imagesLoaded ->
    $container.masonry({
      itemSelector: '.grid-item'
      columnWidth: '.grid-sizer'
      percentPosition: true
    })

  itemsLoaded = (items) ->
    $items = $(items).css(opacity: 0)
    $items.imagesLoaded ->
      $items.animate(opacity: 1)
      $container.masonry('appended', $items, true)

  $container.infinitescroll({
    navSelector: '.pagination'
    nextSelector: '.pagination .next a'
    itemSelector: '.grid-item'
  }, itemsLoaded)

  # unbind infinite scroll on page change
  $(document).on 'page:before-change', (e) ->
    $(window).unbind('.infscr')