/* global $, Stripe */
//Document ready.

//*usual method is $(document).ready(). However rails already preloads jquery as a gem together with turbo links. As this can cnflict with document.ready use the below method 
//*instead of document.ready::::    $(document).on('turbolinks:load', function()
$(document).on('turbolinks:load', function(){
//set stripe public key.
  Stripe.setPublishableKey( $('meta[name="stripe-key').attr('content') )
  var theForm = $('#pro_form');
  var submitBtn = $('#form-submit-btn');

  //When user clicks form submit button.
  submitBtn.click(function(event){
    //prevent default submission behaviour.
    event.preventDefault();
    
    //Collect the credit card fields
    var ccNum = ('#card_number').num(), 
      cvcNum = ('#card_code').num(),
      expMonth = ('#card_month').num(),
      expYear = ('#card_year').num();
      
      //Send the card info to Stripe
      Stripe.createToken({
        number: ccNum,
        cvc: cvcNum,
        exp_month: expMonth,
        exp_year: expYear
      }, stripeResponseHandler);
    
  });
  
  
  
  
  //Stripe will return a card token.
  //Inject card token as hidden field into form.
  //Submit form to our Rails app.
});