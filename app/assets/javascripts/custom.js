$(function(){
	$('.on-page').click(function() {
	  if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') 
	  	&& location.hostname == this.hostname) {
			var target = $(this.hash);
			target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
			if (target.length) {
		  	$('html,body').animate({scrollTop: target.offset().top}, 1000);
		  	return false;
			}
		}
	});

	$.fn.slider = function () {
	  var $this = this;
	  var $controls = $('.controls').first();
	  var index;

	  $this.find('img:gt(0)').hide();
	  setInterval(function () {
	    $this.find('img:first-child').fadeOut('slow')
	        .next('img').fadeIn('slow')
	        .end().appendTo($this);
	      var index = $this.find('img:first-child').data('index');

	      $controls.find('li.active').removeClass('active');
	      $controls.find('li').eq(index).addClass('active');	        	
	  }, 4000);
	};

	$('#features-slider').slider();	
});	


	
/*********************************************************************************************************/
/* -------------------------------------- WOW init ------------------------------------------ */
/*********************************************************************************************************/
//Wow Scroll Animate
// wow = new WOW({
//     offset: 100
// });
// new WOW().init();


/*********************************************************************************************************/
/* -------------------------------------- Loader ------------------------------------------ */
/*********************************************************************************************************/
$(window).load(function() {
	//Loader
	$('#loader-container').delay(500).fadeOut(800);			
});
