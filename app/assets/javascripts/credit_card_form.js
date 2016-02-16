// Signup page
jQuery(function ($) {
  var show_error, stripeResponseHandler;
  $("#new_user").submit(function (event) {
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
    $form = $("#new_user");
    if (response.error) {
      show_error(response.error.message);
      $form.find("input[type=submit]").prop("disabled", false);
    } else {
      token = response.id;
      $form.append($("<input type=\"hidden\" name=\"user[card_token]\" />").val(token));
      $("[data-stripe=number]").remove();
      $("[data-stripe=cvc]").remove();
      $("[data-stripe=exp-year]").remove();
      $("[data-stripe=exp-month]").remove();
      $form.get(0).submit();
    }
    return false;
  };

  show_error = function (message) {
    $.notify({message: message}, {type: 'danger'});
    return false;
  };
});

// Select silver plan page
jQuery(function ($) {
  var show_error, stripeResponseHandler;
  $("#select-silver-billing").submit(function (event) {
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
    $form = $("#select-silver-billing");
    if (response.error) {
      show_error(response.error.message);
      $form.find("input[type=submit]").prop("disabled", false);
    } else {
      token = response.id;
      $form.append($("<input type=\"hidden\" name=\"user[card_token]\" />").val(token));
      $("[data-stripe=number]").remove();
      $("[data-stripe=cvc]").remove();
      $("[data-stripe=exp-year]").remove();
      $("[data-stripe=exp-month]").remove();
      $form.get(0).submit();
    }
    return false;
  };

  show_error = function (message) {
    $.notify({message: message}, {type: 'danger'});
    return false;
  };
});