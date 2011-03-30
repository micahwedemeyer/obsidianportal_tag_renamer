// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  $('.tag-rename-submit').click(function(e) {
    $(this).attr('disabled', true);
    $('.rename-wait-message').show('slow');
  });
});
