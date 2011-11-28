jQuery(document).ready(function($) {

    reset();
    setupShareCopy();

    $('body').live('updateNav', function(event, html) {
        $('#left_nav').html(html)
        setupShareCopy();
    });

    $('#flash').click(function(e) {
        e.preventDefault();
        $(this).fadeOut();
    });

    $('.section .cancel').live('click', function(e) {
        e.preventDefault();

        reset($(this).closest('.section'));
        $(this).closest('.section').find('.editor_toolbar').remove().end().find('.section_content').show();

        $('.button:first').focus();

    });

    $('.section form').live('ajax:loading', function() {
        var val = $(this).find('#section[content]').val();
        console.log($(this).find('input[type=submit]'))
        $(this).find('input[type=submit]').attr('disabled','true');
    }).live('ajax:success', function(evt, data, status, xhr) {
        var $section = $(this).closest('.section');
        var res = $.parseJSON(data);

        $('body').trigger('updateNav', res.left_nav);
        $section.html(res.section).find('.saved').show().end().effect("highlight", {}, 1500, function() {
            reset($section);
            $section.find('.saved').fadeOut('slow');
        });
    });

    $('textarea,*[contenteditable=""],*[contenteditable=true]').live('keyup', function() {
        var $section = $(this).closest('.section');
        var $charsLeft = $section.find('.chars_left');
        var charsLeft = 1000 - $(this).text().length;
        $charsLeft.html(charsLeft + ' characters left');

        charsLeft < 10 ? $charsLeft.addClass('danger') : $charsLeft.removeClass('danger');

    });

    function setupShareCopy () {
        $('#left_nav .share').zclip({
            path: '/ZeroClipboard.swf',
            copy: $('#left_nav .share').text(),
            afterCopy:function(){
                var link = $(this).text();
                $(this).text('Copied to clipboard');
                $(this).effect("highlight", {}, 3000, function() {
                    $(this).text(link);
                });
            }
        });
    }

    function reset($section) {
        if($section===undefined) {
            $('.section').each(function(ndx, section) {
                var $section = $(section);
                resetSection($section);
            });    
        } else {
            resetSection($section);    
        }
        
        setHiddenFields();
        createQips();

        $('.section_controls').show();
    }

    function resetSection($section) {
        $section.find('.secondary').hide();

        $section.find('form .editor').each(function() {
            var editor = WysiHat.Editor.init($(this));

            editor.click(function(e) {
                e.preventDefault();
                var self = this;
                var $secondary = $section.find('.secondary');

                if ($secondary.is(':visible')) {
                    console.log('visible');
                    return true
                };

                if(editor.html() == 'Click to edit this section') {
                    editor.next().val('');
                    editor.html('');
                }

                $('.section_controls').hide();

                var toolbar = new WysiHat.Toolbar(editor);
                toolbar.initialize(editor);

                toolbar.addButtonSet({
                    buttons: WysiHat.Toolbar.ButtonSets.Standard
                });

                toolbar.addButton({
                    label: "Ordered List",
                    handler: function(editor) {
                        return editor.toggleOrderedList();
                    }
                });

                WysiHat.Editor.setEndOfContenteditable(editor);

                $secondary.show(100, function() {
                    $(self).prev().focus();
                    createQips();
                    // remove this qtip
                    editor.qtip('destroy');
                });
            });
        });
    }

    function setHiddenFields() {
        $('.body_action').val($('body').attr('data-action'));
    }

    function createQips() {
        $('.nav_stats span').qtip({
            position: {
                my: 'top center',
                at: 'bottom center'
            },
            style: {
                classes: 'ui-tooltip-dark ui-tooltip-shadow ui-tooltip-rounded'
            }
        });

        $('div[title], a[title]').qtip({
            position: {
                my: 'top center',
                at: 'bottom center'
            },
            style: {
                classes: 'ui-tooltip-dark ui-tooltip-shadow ui-tooltip-rounded'
            }
        });

        var $editor = $('.section form .editor');
        $editor.qtip({
            content: 'Click to edit this version',
            position: {
                my: 'center',
                at: 'center'
            },
            style: {
                classes: 'ui-tooltip-dark ui-tooltip-shadow ui-tooltip-rounded'
            }
        });

    }

});