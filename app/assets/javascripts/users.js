/* global $, Stripe */
//Document ready.

//*usual method is $(document).ready(). However rails already preloads jquery as a gem together with turbo links. As this can cnflict with document.ready use the below method 
//*instead of document.ready::::    $(document).on('turbolinks:load', function().
$(document).on('turbolinks:load', function(){
//set stripe public key.
  Stripe.setPublishableKey( $('meta[name="stripe-key').attr('content') )
  var theForm = $('#pro_form');
  var submitBtn = $('#form-submit-btn');

  //When user clicks form submit button.
  submitBtn.click(function(event){
    //prevent default submission behaviour.
    event.preventDefault();
    submitBtn.val("Processing").prop('disabled', true);
    
    //Collect the credit card fields.
    var ccNum = ('#card_number').num(), 
      cvcNum = ('#card_code').num(),
      expMonth = ('#card_month').num(),
      expYear = ('#card_year').num();
      
      //use Stripe js library to check for card errors.
      var error = false;
      
      //Validate card number
      if(!Stripe.card.validateCardNumber(ccNum))
      {
        error = true;
        alert("The credit card number appears to be invalid");
      }
      //Validate cvc number
      if(!Stripe.card.validateCVC(cvcNum))
      {
        error = true;
        alert("The CVC number appears to be invalid");
      }
      //Validate expiration date
      if(!Stripe.card.validateExpiry(expMonth, expYear))
      {
        error = true;
        alert("The expiration date appears to be invalid");
      }
      
      if(error)
      {
        //in test mode 4111111111111111 is a valid card number
        //If there are errors, don't send to Stripe.
        //reset the submit button
        submitBtn.val("Sign Up").prop('disabled', false);
      }
      else {
        //Send the card info to Stripe.
          Stripe.createToken({
          number: ccNum,
          cvc: cvcNum,
          exp_month: expMonth,
          exp_year: expYear
        }, stripeResponseHandler);
      }
      return false;
  });
  
  //Stripe will return a card token.
  
  function stripeResponseHandler (status, response){
    //get the token from the response.
    var token = response.id;
    
    //Inject the card token in a hidden field
    theForm.append( ($('<input type="hidden" name="user[stripe_card_token]">').val(token) ) );
    
    //Submit form to our Rails app.
    theForm.get(0).submit();
  };
});