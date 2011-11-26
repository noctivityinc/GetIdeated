$(function() {
    $("#slider-small").slides({
        preload: true,
        effect: 'fade',
        fadeSpeed: 550,
        play: 5000

    });

    $('#menu').tabify()

    if (jQuery().slides) {
        jQuery("#slides").hover(function() {
            jQuery('.slides-nav').fadeIn(400);
        }, function() {
            jQuery('.slides-nav').fadeOut(400);
        });

    }

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

    $(".tweet").tweet({
        username: "getideated",
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