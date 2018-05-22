/*!
 * froala_editor v2.8.1 (https://www.froala.com/wysiwyg-editor)
 * License https://froala.com/wysiwyg-editor/terms/
 * Copyright 2014-2018 Froala Labs
 */


!function(n){"function"==typeof define&&define.amd?define(["jquery"],n):"object"==typeof module&&module.exports?module.exports=function(e,t){return t===undefined&&(t="undefined"!=typeof window?require("jquery"):require("jquery")(e)),n(t)}:n(window.jQuery)}(function(d){d.extend(d.FE.DEFAULTS,{quickInsertButtons:["image","video","embedly","table","ul","ol","hr"],quickInsertTags:["p","div","h1","h2","h3","h4","h5","h6","pre","blockquote"]}),d.FE.QUICK_INSERT_BUTTONS={},d.FE.DefineIcon("quickInsert",{PATH:'<path d="M22,16.75 L16.75,16.75 L16.75,22 L15.25,22.000 L15.25,16.75 L10,16.75 L10,15.25 L15.25,15.25 L15.25,10 L16.75,10 L16.75,15.25 L22,15.25 L22,16.75 Z"/>',template:"svg"}),d.FE.RegisterQuickInsertButton=function(e,t){d.FE.QUICK_INSERT_BUTTONS[e]=d.extend({undo:!0},t)},d.FE.RegisterQuickInsertButton("image",{icon:"insertImage",requiredPlugin:"image",title:"Insert Image",undo:!1,callback:function(){var e=this;e.shared.$qi_image_input||(e.shared.$qi_image_input=d('<input accept="image/*" name="quickInsertImage'+this.id+'" style="display: none;" type="file">'),d("body:first").append(e.shared.$qi_image_input),e.events.$on(e.shared.$qi_image_input,"change",function(){var e=d(this).data("inst");this.files&&(e.quickInsert.hide(),e.image.upload(this.files)),d(this).val("")},!0)),e.$qi_image_input=e.shared.$qi_image_input,e.helpers.isMobile()&&e.selection.save(),e.events.disableBlur(),e.$qi_image_input.data("inst",e).trigger("click")}}),d.FE.RegisterQuickInsertButton("video",{icon:"insertVideo",requiredPlugin:"video",title:"Insert Video",undo:!1,callback:function(){var e=prompt(this.language.translate("Paste the URL of the video you want to insert."));e&&this.video.insertByURL(e)}}),d.FE.RegisterQuickInsertButton("embedly",{icon:"embedly",requiredPlugin:"embedly",title:"Embed URL",undo:!1,callback:function(){var e=prompt(this.language.translate("Paste the URL of any web content you want to insert."));e&&this.embedly.add(e)}}),d.FE.RegisterQuickInsertButton("table",{icon:"insertTable",requiredPlugin:"table",title:"Insert Table",callback:function(){this.table.insert(2,2)}}),d.FE.RegisterQuickInsertButton("ol",{icon:"formatOL",requiredPlugin:"lists",title:"Ordered List",callback:function(){this.lists.format("OL")}}),d.FE.RegisterQuickInsertButton("ul",{icon:"formatUL",requiredPlugin:"lists",title:"Unordered List",callback:function(){this.lists.format("UL")}}),d.FE.RegisterQuickInsertButton("hr",{icon:"insertHR",title:"Insert Horizontal Line",callback:function(){this.commands.insertHR()}}),d.FE.PLUGINS.quickInsert=function(r){var a,l;function t(e){var t,n,i;t=e.offset().top-r.$box.offset().top,n=0-a.outerWidth(),r.opts.enter!=d.FE.ENTER_BR?i=(a.outerHeight()-e.outerHeight())/2:(d("<span>"+d.FE.INVISIBLE_SPACE+"</span>").insertAfter(e),i=(a.outerHeight()-e.next().outerHeight())/2,e.next().remove()),r.opts.iframe&&(t+=r.$iframe.offset().top-r.helpers.scrollTop()),a.hasClass("fr-on")&&0<=t&&l.css("top",t-i),0<=t&&t-i<=r.$box.outerHeight()-e.outerHeight()?(a.hasClass("fr-hidden")&&(a.hasClass("fr-on")&&o(),a.removeClass("fr-hidden")),a.css("top",t-i)):a.hasClass("fr-visible")&&(a.addClass("fr-hidden"),u()),a.css("left",n)}function n(e){a||function(){r.shared.$quick_insert||(r.shared.$quick_insert=d('<div class="fr-quick-insert"><a class="fr-floating-btn" role="button" tabIndex="-1" title="'+r.language.translate("Quick Insert")+'">'+r.icon.create("quickInsert")+"</a></div>"));a=r.shared.$quick_insert,r.tooltip.bind(r.$box,".fr-quick-insert > a.fr-floating-btn"),r.events.on("destroy",function(){a.removeClass("fr-on").appendTo(d("body:first")).css("left",-9999).css("top",-9999),l&&(u(),l.appendTo(d("body:first")))},!0),r.events.on("shared.destroy",function(){a.html("").removeData().remove(),a=null,l&&(l.html("").removeData().remove(),l=null)},!0),r.events.on("commands.before",s),r.events.on("commands.after",function(){r.popups.areVisible()||i()}),r.events.bindClick(r.$box,".fr-quick-insert > a",o),r.events.bindClick(r.$box,".fr-qi-helper > a.fr-btn",function(e){var t=d(e.currentTarget).data("cmd");if(!1===r.events.trigger("quickInsert.commands.before",[t]))return!1;d.FE.QUICK_INSERT_BUTTONS[t].callback.apply(r,[e.currentTarget]),d.FE.QUICK_INSERT_BUTTONS[t].undo&&r.undo.saveStep(),r.events.trigger("quickInsert.commands.after",[t]),r.quickInsert.hide()}),r.events.$on(r.$wp,"scroll",function(){a.hasClass("fr-visible")&&t(a.data("tag"))})}(),a.hasClass("fr-on")&&u(),r.$box.append(a),t(e),a.data("tag",e),a.addClass("fr-visible")}function i(){if(r.core.hasFocus()){var e=r.selection.element();if(r.opts.enter==d.FE.ENTER_BR||r.node.isBlock(e)||(e=r.node.blockParent(e)),r.opts.enter==d.FE.ENTER_BR&&!r.node.isBlock(e)){var t=r.node.deepestParent(e);t&&(e=t)}e&&(r.opts.enter!=d.FE.ENTER_BR&&r.node.isEmpty(e)&&r.node.isElement(e.parentNode)&&0<=r.opts.quickInsertTags.indexOf(e.tagName.toLowerCase())||r.opts.enter==d.FE.ENTER_BR&&("BR"==e.tagName&&(!e.previousSibling||"BR"==e.previousSibling.tagName||r.node.isBlock(e.previousSibling))||r.node.isEmpty(e)&&(!e.previousSibling||"BR"==e.previousSibling.tagName||r.node.isBlock(e.previousSibling))&&(!e.nextSibling||"BR"==e.nextSibling.tagName||r.node.isBlock(e.nextSibling))))?a&&a.data("tag").is(d(e))&&a.hasClass("fr-on")?u():r.selection.isCollapsed()&&n(d(e)):s()}}function s(){a&&(a.hasClass("fr-on")&&u(),a.removeClass("fr-visible fr-on"),a.css("left",-9999).css("top",-9999))}function o(e){if(e&&e.preventDefault(),a.hasClass("fr-on")&&!a.hasClass("fr-hidden"))u();else{if(!r.shared.$qi_helper){for(var t=r.opts.quickInsertButtons,n='<div class="fr-qi-helper">',i=0,s=0;s<t.length;s++){var o=d.FE.QUICK_INSERT_BUTTONS[t[s]];o&&(!o.requiredPlugin||d.FE.PLUGINS[o.requiredPlugin]&&0<=r.opts.pluginsEnabled.indexOf(o.requiredPlugin))&&(n+='<a class="fr-btn fr-floating-btn" role="button" title="'+r.language.translate(o.title)+'" tabIndex="-1" data-cmd="'+t[s]+'" style="transition-delay: '+.025*i+++'s;">'+r.icon.create(o.icon)+"</a>")}n+="</div>",r.shared.$qi_helper=d(n),r.tooltip.bind(r.shared.$qi_helper,"> a.fr-btn"),r.events.$on(r.shared.$qi_helper,"mousedown",function(e){e.preventDefault()},!0)}(l=r.shared.$qi_helper).appendTo(r.$box),setTimeout(function(){l.css("top",parseFloat(a.css("top"))),l.css("left",parseFloat(a.css("left"))+a.outerWidth()),l.find("a").addClass("fr-size-1"),a.addClass("fr-on")},10)}}function u(){var e=r.$box.find(".fr-qi-helper");e.length&&(e.find("a").removeClass("fr-size-1"),e.css("left",-9999),a.hasClass("fr-hidden")||a.removeClass("fr-on"))}return{_init:function(){if(!r.$wp)return!1;r.opts.iframe&&r.$el.parent("html").find("head").append('<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css">'),r.popups.onShow("image.edit",s),r.events.on("mouseup",i),r.helpers.isMobile()&&r.events.$on(d(r.o_doc),"selectionchange",i),r.events.on("blur",s),r.events.on("keyup",i),r.events.on("keydown",function(){setTimeout(function(){i()},0)})},hide:s}}});
