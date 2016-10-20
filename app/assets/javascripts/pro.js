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

  var $marketingHeadline = $('.marketing h1 .bottomline');
  $(function(){
    if($marketingHeadline.length > 0) {
      $marketingHeadline.html('');
      $marketingHeadline.typed({
        strings: ['Newsdesk', 'Trade journal', 'Local paper', 'Financial Times'],
        typeSpeed: 50,
        startDelay: 250,
        backDelay: 2000,
        loop: true,
      });
    }
  });

  var $addToRequestButtons = $('.js-add-to-request-button');
  var $recipients = $('.js-recipients');
  var $recipientList = $('.js-recipients-list');
  var bindRemovalButtons = function bindRemovalButtons() {
    $('.js-recipient-remove').click(function(e) {
      e.preventDefault();
      var recipientName = $(this).data('recipient-name');
      $(this).parent().remove();
      $addToRequestButtons.filter('.disabled[data-recipient-name="' + recipientName + '"]').removeClass('disabled').text('Add to request');
    });
  };

  $(function(){
    bindRemovalButtons();
    $addToRequestButtons.click(function(e){
      e.preventDefault();
      if(!$(this).hasClass('disabled')) {
        var recipientName = $(this).data('recipient-name');
        var $recipient = $('<div class="recipient"></div>');
        $recipient.html(recipientName + ' <a class="recipient-remove js-recipient-remove" data-recipient-name="' + recipientName + '" href="#">x</a>');
        $(this).addClass('disabled').text('Added to request');
        $recipients.slideDown();
        $recipientList.append($recipient);
        bindRemovalButtons();
      }
    });
  });
})(window.jQuery);