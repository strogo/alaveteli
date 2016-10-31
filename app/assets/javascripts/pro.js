(function($, deparam){
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

  var $moreMenuLink = $('.js-more-menu-link > a');
  var $moreMenu = $('.js-more-menu');
  $(function(){
    $moreMenuLink.click(function(e){
      e.preventDefault();
      $moreMenu.slideToggle(250);
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
  var $batchRequestMessage = $('.js-batch-request-message');
  var $clearRecipientsButton = $('.js-clear-recipients');
  var $sendRequestButton = $('.js-send-request');

  // Function to set up click handlers for recipient removal buttons
  var bindRemovalButtons = function bindRemovalButtons() {
    $('.js-recipient-remove').click(function(e) {
      e.preventDefault();
      var recipientName = $(this).data('recipient-name');
      $(this).parent().fadeOut(250, function(){
        $(this).remove();
        $addToRequestButtons.filter('.disabled[data-recipient-name="' + recipientName + '"]').removeClass('disabled').text('Add to request');
        showBatchRequestMessage();
        if($recipientList.find('.recipient').length === 0) {
          $recipients.slideUp(250);
        }
      });
    });
  };

  var showBatchRequestMessage = function showBatchRequestMessage() {
    // Show or hide the batch requesting message
    if($recipientList.find('.recipient').length > 1) {
      $batchRequestMessage.show();
    } else {
      $batchRequestMessage.hide();
    }
  };

  var addToRequest = function addToRequest(e) {
    e.preventDefault();

    // You can't click a disabled button, but there's no way to actually
    // ignore it in html, so we just ignore disabled buttons here
    if(!$(this).hasClass('disabled')) {
      // Disable the button that was clicked
      $(this).addClass('disabled').text('Added to request');

      // Build a new item for the recipient list
      var recipientName = $(this).data('recipient-name');
      var $recipient = $('<div class="recipient"></div>');
      $recipient.html(recipientName + ' <a class="recipient-remove js-recipient-remove" data-recipient-name="' + recipientName + '" href="#">x</a>');

      // Show the recipients list (if it's hidden) and add the new item
      $recipients.slideDown(250, function(){
        $recipient.hide().appendTo($recipientList).fadeIn(250, function(){
          // Hide or show the batch request message
          showBatchRequestMessage();
          // Make sure buttons to remove the new recipients work
          bindRemovalButtons();
          // Update the "write your request" url to include the current
          // recipients
          var selectedRecipients = $recipients.find('.js-recipient-remove').map(function() { return $(this).data('recipient-name'); }).get();
          $sendRequestButton.attr('href', '/ap/write_request?' + $.param({recipients: selectedRecipients}));
        });
      });
    }
  };

  var removeAllRecipients = function removeAllRecipients(e) {
    e.preventDefault();
    $recipientList.find('.js-recipient-remove').click();
  };

  var getRecipientsFromQueryString = function getRecipientsFromQueryString() {
    var queryStringParams = deparam(window.location.href.slice(window.location.href.indexOf('?') + 1));
    var recipientList = queryStringParams.recipients;
    if(typeof recipientList !== 'undefined' && recipientList !== '') {
      return recipientList;
    } else {
      return [];
    }
  };

  $(function(){
    // Trigger this initially for anthing already in the list
    bindRemovalButtons();
    $addToRequestButtons.click(addToRequest);
    $clearRecipientsButton.click(removeAllRecipients);

    // Populate any recipients if we've come back from another page
    var recipientList = getRecipientsFromQueryString();
    if(recipientList.length > 0) {
      $.each(recipientList, function(i, recipient) {
        $addToRequestButtons.filter('[data-recipient-name="' + recipient + '"]').click();
      });
    }
  });


  // Write request page
  $(function() {
    if($('#write_form').length > 0) {
      var recipientList = getRecipientsFromQueryString();
      if(recipientList.length > 0) {
        // Populate the recipient list
        $('.js-recipients').text(recipientList.join(', '));
      }
    }
  });

  // Write request page V2 (autocomplete "TO" field)
  $(function(){
    $('.js-recipients-input').selectize({
      valueField: 'id',
      labelField: 'name',
      searchField: 'name',
      options: [],
      create: false,
      maxItems: 1,
      render: {
        option: function(body, escape) {
          var shortDesc = jQuery.trim(escape(body.notes)).substring(0, 150).split(" ").slice(0, -1).join(" ") + "...";
          var html = '<div class="recipient-result">';
          html += '<h4 class="name">' + escape(body.name) + '</h4>';
          html += '<p class="description">' + escape(shortDesc) + '</p>';
          html += '<p class="requests">' + escape(body.info_requests_visible_count) + ' requests made</p>';
          html += '</div>';
          return html;
        }
      },
      load: function(query, callback) {
        $.ajax({
          url: '/ap/bodies_json/' + encodeURIComponent(query),
          type: 'GET',
          error: function() {
            callback();
          },
          success: function(res) {
            console.log(res);
            callback(res);
          }
        });
      }
    });
  });
})(window.jQuery, window.deparam);