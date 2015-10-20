jQuery(document).ready(function($) {
  'use strict';
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

  $('.flexslider input').on('focus', function(){
    $('.flexslider').flexslider("stop");
  });
});
