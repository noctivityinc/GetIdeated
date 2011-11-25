/***************************************************
  SMALL SLIDER WITH CONTENT 
***************************************************/
/*-----------------------------------------FONT STYLER ENDS--------------------------------*/
jQuery.noConflict()(function($) {
    jQuery("#slider-small").slides({
        preload: true,
        effect: 'fade',
        fadeSpeed: 550,
        play: 5000

    });
});
/***************************************************
  SLIDER  NAV FADE OUT & FADE IN
***************************************************/
jQuery.noConflict()(function($) {
    $(document).ready(function() {
        if (jQuery().slides) {
            jQuery("#slides").hover(function() {
                jQuery('.slides-nav').fadeIn(400);
            }, function() {
                jQuery('.slides-nav').fadeOut(400);
            });

        }
    });
}); /*-----------------SLIDES WITH CAPTION---------------*/
jQuery.noConflict()(function($) {
    $(function() {
        $('#slides').slides({
            effect: 'fade',
            fadeSpeed: 750,
            play: 5000,
            pause: 2500,
            hoverPause: true,
            animationStart: function(current) {
                $('.caption').animate({
                    bottom: 0
                }, 100);
                if (window.console && console.log) {
                    // example return of current slide number
                    console.log('animationStart on slide: ', current);
                };
            },
            animationComplete: function(current) {
                $('.caption').animate({
                    bottom: 0
                }, 200);
                if (window.console && console.log) {
                    // example return of current slide number
                    console.log('animationComplete on slide: ', current);
                };
            },
            slidesLoaded: function() {
                $('.caption').animate({
                    bottom: 0
                }, 200);
            }
        });
    });
});
/***************************************************
          TABIFY 
***************************************************/
jQuery.noConflict()(function($) {
    $(document).ready(function() {
        $(document).ready(function() {
            $('#menu').tabify()

        });
    });
});

/***************************************************
    TWITTER FEEDS
***************************************************/
jQuery.noConflict()(function($) {
    $(document).ready(function() {
        $(".tweet").tweet({
            username: "trendywebstar",
            /*CHANGE trendyWebStar WITH YOUR OWN USERNAME*/
            join_text: null,
            avatar_size: null,
            /*AVATAR*/
            count: 1,
            /*NUMBER OF TWEETS*/
            auto_join_text_default: "we said,",
            auto_join_text_ed: "we",
            auto_join_text_ing: "we were",
            auto_join_text_reply: "we replied to",
            auto_join_text_url: "we were checking out",
            loading_text: "loading tweets..."
        });
    });
});


