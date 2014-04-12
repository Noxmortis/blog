$(function(){
  var nav = $('nav *');
  nav.hide();

  $('header h1').on('click', function(){
    if(nav.is(':hidden')){
      nav.slideDown('fast');
    }else{
      nav.slideUp('fast');
    }
  });

  $('nav .close').on('click', function(){
    nav.slideUp('fast');
  });
});
