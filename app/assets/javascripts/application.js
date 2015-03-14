// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .




var availableTags = gon.ingredients;

(function($, undefined) {
    if (typeof $.uix !== "object") { $.uix = {}; }
    var ac = $.ui.autocomplete.prototype;
    var _super = {
        _create: ac._create,
        _destroy: ac._destroy,
        _resizeMenu: ac._resizeMenu,
        _suggest: ac._suggest,
        search: ac.search,
        open: ac.open,
        close: ac.close
    };
    ac = $.extend({}, ac, {
        options: $.extend({}, ac.options, {
            multiselect: false,
            triggerChar: false
        }),
        _create: function(){
            var self = this,
                o = self.options;
            _super._create.apply(self);
            
            if (o.multiselect) {
                self.selectedItems = {};           
                self.multiselect = $("<div></div>")
                    .addClass("ui-autocomplete-multiselect ui-state-default ui-widget")
                    .css("width", self.element.width())
                    .insertBefore(self.element)
                    .append(self.element)
                    .bind("click.autocomplete", function(){
                        self.element.focus();
                    });
                
                var fontSize = parseInt(self.element.css("fontSize"), 10);
                function autoSize(e){
                    // Hackish autosizing
                    var $this = $(this);
                    $this.width(1).width(this.scrollWidth+fontSize-1);
                };

                var kc = $.ui.keyCode;
                self.element.bind({
                    "keydown.autocomplete": function(e){
                        if ((this.value === "") && (e.keyCode == kc.BACKSPACE)) {
                            var prev = self.element.prev();
                            delete self.selectedItems[prev.text()];
                            prev.remove();
                        }
                    },
                    // TODO: Implement outline of container
                    "focus.autocomplete blur.autocomplete": function(){
                        self.multiselect.toggleClass("ui-state-active");
                    },
                    "keypress.autocomplete change.autocomplete focus.autocomplete blur.autocomplete": autoSize
                }).trigger("change");

                // TODO: There's a better way?
                o.select = o.select || function(e, ui) {
                    $("<div></div>")
                        .addClass("ui-autocomplete-multiselect-item")
                        .text(ui.item.label)
                        .append(
                            $("<span></span>")
                                .addClass("ui-icon ui-icon-close")
                                .click(function(){
                                    var item = $(this).parent();
                                    delete self.selectedItems[item.text()];
                                    item.remove();
                                })
                        )
                        .insertBefore(self.element);
                    
                    self.selectedItems[ui.item.label] = ui.item;
                    self._value("");
                    return false;
                }

                /*self.options.open = function(e, ui) {
                    var pos = self.multiselect.position();
                    pos.top += self.multiselect.height();
                    self.menu.element.position(pos);
                }*/
            }
            return this;
        },
        _resizeMenu: function(){
            if (this.options.multiselect) {
                var ul = this.menu.element;
                ul.outerWidth( Math.max(
                    ul.width( "" ).outerWidth(),
                    this.multiselect.outerWidth()
                ) );
            } else {
                _super._resizeMenu.apply(this);
            }
        },
        _suggest: function( items ) {
            var elm = this.element;
            // Override this.element with our multiselect for proper positioning
            this.element = this.options.multiselect ? this.multiselect : this.element;
            _super._suggest.apply(this, [items]);   
            this.element = elm;
        },
        search: function( value, event ) {
            value = value != null ? value : this._value();
            if (this.options.triggerChar) {
                if (value.substring(0,1) != this.options.triggerChar) {
                    return;
                } else {
                    value = value.substring(1);
                }
            }
            return _super.search.apply(this, [value, event]);
        },
        // Borrowed from 1.9
        _value: function( value ) {
            return this.valueMethod.apply( this.element, arguments );
        },
        // Borrowed from 1.9
        valueMethod: function() {
            var result = this[this.is( "input" ) ? "val" : "text"].apply(this, arguments);
            this.trigger("change");
            return result;
        }
    });
    
    $.uix.autocomplete = ac;
    $.widget("uix.autocomplete", $.uix.autocomplete);
})(jQuery);

var idx = 0;
$("input:text")
    .eq(idx++).autocomplete({
        source: availableTags,
        multiselect: false
    }).end()
    .eq(idx++).autocomplete({
        source: availableTags,
        multiselect: true
    }).end()
    .eq(idx++).autocomplete({
        source: availableTags,
        multiselect: true,
        triggerChar: "@"
    });