(function (ns) {
    var editor = {
        init: function (opts) {
            var self = this;
            self.options = opts;
            self.matrixPane = $("FeeRulesCnt");
            self.providersPane = $("div_Dynamicweb.eCommerce.Cart.ShippingProvider_parameters").up(".ship-provider-selector");
            self.countrySelectorAllEl = $("country-rel-list-all");
            self.countrySelectorChooseEl = $("country-rel-list-choose");
            self.countrySelectorCnt = $("country-rel-list-container");

            var methodSelectorEl = $("Dynamicweb.eCommerce.Cart.ShippingProvider_AddInTypes");
            var showShippingMatrix = function (show) {
                if (show) {
                    self.matrixPane.removeClassName("hide");
                    self.providersPane.addClassName("hide");
                } else {
                    self.matrixPane.addClassName("hide");
                    self.providersPane.removeClassName("hide");
                }
            };
            $(methodSelectorEl).on("change", function () {
                showShippingMatrix(!$(this).value);
            });
            showShippingMatrix(!methodSelectorEl.value);
            var options = methodSelectorEl.options;
            for (var i = 0; i < options.length; i++) {
                if (!options[i].value) {
                    options[i].text = self.options.titles.methodTypeMatrixRules;
                    break;
                }
            }
            $("NameStr").focus();
            var hasUnchecked = self.countrySelectorCnt.select("input[type=checkbox][name=CR_CountryRel]").any(function (el) { return !el.checked; });
            if (hasUnchecked) {
                self.countrySelectorCnt.show();
                self.countrySelectorChooseEl.checked = true;
            }
            self.countrySelectorAllEl.on("change", function () {
                self.countrySelectorCnt.hide();
            });
            self.countrySelectorChooseEl.on("change", function () {
                self.countrySelectorCnt.show();
            });

        },

        save: function (close) {
            if (this.validate()) {
                if (this.countrySelectorAllEl.checked) {
                    this.countrySelectorCnt.select("input[type=checkbox][name=CR_CountryRel]").each(function (el) {
                        el.checked = true;
                    });
                }
                document.getElementById("Close").value = close ? 1 : 0;
                document.getElementById('Form1').SaveButton.click();
            }
        },

        validate: function () {
            var isValid = true;
            var el = $("NameStr");
            var name = el.value;
            if (name.length == 0) {
                var err = $("errNameStr");
                err.style.display = "";
                el.focus();
                isValid = false;
            }
            return isValid;
        }
    };
    ns.initShippingMethodEditor = function (opts) {
        editor.init(opts);
        return editor;
    };
})(Dynamicweb.Utilities.defineNamespace("Dynamicweb.eCommerce.Shipping"));