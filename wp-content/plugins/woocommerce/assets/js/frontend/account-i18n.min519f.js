jQuery(function(t){var e=t('[role="alert"]').filter(function(){return t(this).text().trim().length>0});e.length>0&&setTimeout(function(){t(e[0]).attr("tabindex","-1").focus()})});
