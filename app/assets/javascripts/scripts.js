function initializePluguins() {
  // initialize bootstrap tooltip
  $('[data-toggle="tooltip"]').tooltip();
  // initialize bootstrap popover
  $('[data-toggle="popover"]').popover();
  // fix tabindex for all buttons in editor toolbar
  $('trix-toolbar button').each(function() {
    return $(this).attr('tabindex', '-1');
  });
}

jQuery(document).ready(function($) {
  'use strict';

  initializePluguins();

  $('.flexslider').flexslider({
    animation: "slide",
    slideshow: true,
    slideshowSpeed: 10000,
    animationSpeed: 500,
    smoothHeight: true,
    keyboard: false,
    start: function(slider){
      $('body').removeClass('loading');
      $('.body-overlay').fadeToggle();
    }
  });

  // stop slider when input in focus
  $('.flexslider input').on('focus', function(){
    $('.flexslider').flexslider("stop");
  });

  // set default settings to bootstrap-notify
  $.notifyDefaults({
    type: 'success',
    placement: {
      from: 'top',
      align: 'center'
    },
    offset: 62,
    delay: 6000
  });
});

$(document).ajaxComplete(function() {
  initializePluguins();
});
