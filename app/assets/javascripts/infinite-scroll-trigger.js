$(window).scroll(function () {
  if ($(window).scrollTop() >= $(document).height() - $(window).height() - 10) {
    window.Acts = window.Acts || {};

    if (window.Acts.isEmpty) {
      $(window).off("scroll");
    } else {
      // set loading icon
      $('.scroll-status').html('<i class="fa fa-gear fa-spin"></i>');

      // run script to render new acts
      $.get('/acts.js');
    }
  }
});
