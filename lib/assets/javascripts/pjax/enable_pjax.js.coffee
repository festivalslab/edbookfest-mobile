$ ->
    pjaxLinks = $('a:not([data-remote]):not([data-behavior]):not([data-skip-pjax]):not([data-anchor]):not([href^="http"])')
    pjaxLinks.pjax('[data-pjax-container]')