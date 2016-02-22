// Create subscription
jQuery(function ($) {
  var show_error, stripeResponseHandler;
  $("#upgrade-silver-billing").submit(function (event) {
    if ($("[data-stripe=number]").length ) {
      var $form;
      $form = $(this);
      $form.find("input[type=submit]").prop("disabled", true);
      Stripe.card.createToken($form, stripeResponseHandler);
      return false;
    }
  });

  stripeResponseHandler = function (status, response) {
    var $form, token;
    $form = $("#upgrade-silver-billing");
    if (response.error) {
      show_error(response.error.message);
      $form.find("input[type=submit]").prop("disabled", false);
    } else {
      token = response.id;
      $form.append($("<input type=\"hidden\" name=\"user[card_token]\" />").val(token));
      $("[data-stripe=number]").prop("disabled", true);
      $("[data-stripe=cvc]").prop("disabled", true);
      $("[data-stripe=exp-year]").prop("disabled", true);
      $("[data-stripe=exp-month]").prop("disabled", true);
      $form.trigger('submit.rails');
    }
    return false;
  };

  show_error = function (message) {
    if ($('#upgrade-silver-billing .alert').length > 0) {
      $('#upgrade-silver-billing .alert').slideUp("normal", function() { $(this).remove(); } );
    }
    $('#upgrade-silver-billing .form-group:first').prepend('<div class="alert alert-danger"><span>' + message + '</span></div>')
    return false;
  };

  $('body').on('ajax:success', '#upgrade-silver-billing', function(e, data, status, xhr) {
    $("#upgrade-billing").modal('hide');
    if (location.pathname.indexOf('profile') !== -1) {
      return $.getScript('subscription', function(data, textStatus, jqxhr) {
        return $.notify('Your plan has been upgraded.');
      });
    } else {
      return $.notify('Your plan has been upgraded.');
    }
  }).on("ajax:error", "#upgrade-silver-billing", function(e, xhr, status, error) {

    var $form = $("#upgrade-silver-billing");

    $("[name='user[card_token]']").remove();

    $("[data-stripe=number]").prop("disabled", false);
    $("[data-stripe=cvc]").prop("disabled", false);
    $("[data-stripe=exp-year]").prop("disabled", false);
    $("[data-stripe=exp-month]").prop("disabled", false);
    $form.find("input[type=submit]").prop("disabled", false);

    show_error(xhr.responseText);

  });
});

// Downgrade subscription
jQuery(function ($) {
  $("#downgrade-plan").submit(function (event) {
    var $form = $(this);
    $form.find("input[type=submit]").prop("disabled", true);
    $form.trigger('submit.rails')
    return false;
  });

  show_error = function (message) {
    if ($('#downgrade-plan .alert').length > 0) {
      $('#downgrade-plan .alert').slideUp("normal", function() { $(this).remove(); } );
    }
    $('#downgrade-plan .checkbox').prepend('<div class="alert alert-danger"><span>' + message + '</span></div>')
    return false;
  };

  $('body').on('ajax:success', '#downgrade-plan', function(e, data, status, xhr) {
    $("#downgrade-plan-modal").modal('hide');
    if (location.pathname.indexOf('profile') !== -1) {
      return $.getScript('subscription', function(data, textStatus, jqxhr) {
        return $.notify('Your plan has been downgraded.');
      });
    } else {
      return $.notify('Your plan has been downgraded.');
    }
  }).on("ajax:error", "#downgrade-plan", function(e, xhr, status, error) {
    show_error('Something went wrong. Please try again.');
    $("#downgrade-plan input[type=submit]").prop("disabled", false);
  });
});

// Upgrade subscription
jQuery(function ($) {
  $("#upgrade-plan").submit(function (event) {
    var $form = $(this);
    $form.find("input[type=submit]").prop("disabled", true);
    $form.trigger('submit.rails')
    return false;
  });

  show_error = function (message) {
    if ($('#upgrade-plan .alert').length > 0) {
      $('#upgrade-plan .alert').slideUp("normal", function() { $(this).remove(); } );
    }
    $('#upgrade-plan .checkbox').prepend('<div class="alert alert-danger"><span>' + message + '</span></div>')
    return false;
  };

  $('body').on('ajax:success', '#upgrade-plan', function(e, data, status, xhr) {
    $("#upgrade-plan-modal").modal('hide');
    if (location.pathname.indexOf('profile') !== -1) {
      return $.getScript('subscription', function(data, textStatus, jqxhr) {
        return $.notify('Your plan has been upgraded.');
      });
    } else {
      return $.notify('Your plan has been upgraded.');
    }
  }).on("ajax:error", "#upgrade-plan", function(e, xhr, status, error) {
    show_error('Something went wrong. Please try again.');
    $("#upgrade-plan input[type=submit]").prop("disabled", false);
  });
});
