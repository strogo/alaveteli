(function($){
  var $embargoCheckbox = $('.js-embargo-checkbox');
  var $embargoDuration = $('.js-embargo-duration');
  $(function(){
    $embargoCheckbox.change(function(){
      if($(this).is(':checked')) {
        $embargoDuration.slideDown(250);
      } else {
        $embargoDuration.slideUp(250);
      }
    });
  });

  var $accountLink = $('.js-account-link');
  var $accountMenu = $('.js-account-menu');
  $(function(){
    $accountLink.click(function(e){
      e.preventDefault();
      $accountMenu.slideToggle(250);
      return false;
    });
  });
})(window.jQuery);