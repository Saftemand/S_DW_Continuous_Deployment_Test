(function (ns) {
    // Translation keys list
    (function (nsTkl) {
        Object.extend(nsTkl, {
            initialize: function () {
                var designName = $('hDesignName').value;
                var isGlobal = $('hIsGlobal').value;
                var isItemType = $('hIsItemType').value;

                var list = $$('div.list');

                if (list != null && list.length > 0) {
                    list = $(list[0]);

                    list.observe('click', function (e) {
                        var keyName = '';
                        var elm = Event.element(e);
                        var row = elm.up('tr.listRow');

                        if (row != null) {
                            keyName = row.getAttribute('itemid');
                        }

                        if (keyName != "") {
                            // Screen center
                            var x = screen.width / 2 - 800 / 2;
                            var y = screen.height / 2 - 600 / 2;

                            if (isItemType.toLowerCase() == 'true') {
                                window.open('/Admin/Content/Management/Dictionary/TranslationKey_Edit.aspx?IsItem=true&DisallowNameEdit=true&KeyName=' + keyName, '', 'width=800,height=600,resizable=yes,scrollbars=yes,status=yes,left=' + x + ',top=' + y);
                            } else if (isGlobal.toLowerCase() == 'true') {
                                window.open('/Admin/Content/Management/Dictionary/TranslationKey_Edit.aspx?IsGlobal=true&KeyName=' + keyName, '', 'width=800,height=600,resizable=yes,scrollbars=yes,status=yes,left=' + x + ',top=' + y);
                            } else if (isGlobal.toLowerCase() == 'false' && designName != "") {
                                window.open('/Admin/Content/Management/Dictionary/TranslationKey_Edit.aspx?DesignName=' + designName + '&KeyName=' + keyName, '', 'width=800,height=600,resizable=yes,scrollbars=yes,status=yes,left=' + x + ',top=' + y);
                            }
                        }
                    });
                }
            },

            add: function () {
                var designName = $('hDesignName').value;
                var isGlobal = $('hIsGlobal').value;

                // Screen center
                var x = screen.width / 2 - 800 / 2;
                var y = screen.height / 2 - 600 / 2;

                if (isGlobal.toLowerCase() == 'true') {
                    window.open('/Admin/Content/Management/Dictionary/TranslationKey_Edit.aspx?IsGlobal=true&IsNew=true', '', 'width=800,height=600,resizable=yes,scrollbars=yes,status=yes,left=' + x + ',top=' + y);
                } else if (isGlobal.toLowerCase() == 'false' && designName != "") {
                    window.open('/Admin/Content/Management/Dictionary/TranslationKey_Edit.aspx?DesignName=' + designName + '&IsNew=true', '', 'width=800,height=600,resizable=yes,scrollbars=yes,status=yes,left=' + x + ',top=' + y);
                }
            }
        });
    })(ns.TranslationKey_List = ns.TranslationKey_List || {});

    // Translation keys edit
    (function (nsTke) {
        var setSubAction = function (cmd) {
            document.getElementById("SubAction").value = cmd || "";
        };
        Object.extend(nsTke, {
            initialize: function () {
                var isNew = $('hIsNew').value;
                if (isNew.toLowerCase() === "true") {
                    $('ErrKeyNameDelete').Disabled = "true"
                }
            },

            save: function (close) {
                var keyNameStr = $('KeyNameStr').value;
                var oldNameStr = $('hKeyName').value;
                var errKeyNameStr = $('ErrKeyNameStr');
                var errKeyNameExists = $('ErrKeyNameExists');
                var keyExists = null

                var itt = window.opener.document.getElementById("ItemTypeTranslations");
                var doc = itt ? itt.contentWindow.document : window.opener.document;

                var rowElems = null;
                var cnt = null;
                // search if keys with the entered name exist
                if ((cnt = doc.getElementById("lstKeys_body"))) {
                    rowElems = cnt.getElementsByTagName("tr");
                } else if ((cnt = doc.getElementById("RegionsGrid"))) {
                    rowElems = cnt.getElementsByTagName("span");
                }

                for (var i = 0; i < rowElems.length; i++) {
                    if ((rowElems[i].id === keyNameStr) || (rowElems[i].textContent === keyNameStr)) {
                        keyExists = rowElems[i];
                        break;
                    }
                }
                var fn = function () {
                    setSubAction(close ? "parentreload,close" : "parentreload");
                };

                if (keyExists == null) {
                    if (keyNameStr != "") {
                        fn();
                        document.getElementById('MainForm').SaveButton.click();
                    } else {
                        errKeyNameStr.setStyle('display:inherit');
                    }
                } else if (keyExists != null) {
                    if (keyNameStr != "") {
                        if ((keyNameStr != keyExists.id) && (keyNameStr != keyExists.textContent)) {
                            fn();
                            document.getElementById('MainForm').SaveButton.click();
                        } else if ((keyNameStr == oldNameStr) && ((keyExists.id == oldNameStr) || (keyExists.textContent == oldNameStr))) {
                            fn();
                            document.getElementById('MainForm').SaveButton.click();
                        } else if ((keyNameStr != oldNameStr)) {
                            errKeyNameExists.setStyle('display:inherit');
                        }
                    } else {
                        errKeyNameStr.setStyle('display:inherit');
                    }
                }
            },

            delete: function () {
                var isNew = $('hIsNew').value;
                var errKeyNameDelete = $('ErrKeyNameDelete');

                if (isNew.toLowerCase() != "true") {
                    var confirmed = confirm($('confirmDelete').innerHTML);
                    if (confirmed == true) {
                        setSubAction("parentreload,close");
                        document.getElementById('MainForm').DeleteButton.click();
                    }
                } else {
                    errKeyNameDelete.setStyle('display:inherit');
                }
            },

            cancel: function () {                
                setSubAction("parentreload,close");
                document.getElementById('MainForm').submit();     
            }
        });
    })(ns.TranslationKey_Edit = ns.TranslationKey_Edit || {});

    // Translation keys reference
    (function (nsTkr) {
        Object.extend(nsTkr, {
            saveTranslations: function (close) {
                var o = new overlay('overlay'); o.show();
                document.getElementById('MainForm').SaveButton.value = close ? true : false;
                document.getElementById('MainForm').SaveButton.click();
            },

            add: function () {
                var designName = $('hDesignName').value;
                if (designName != "") {
                    var x = screen.width / 2 - 800 / 2;
                    var y = screen.height / 2 - 600 / 2;
                    window.open('/Admin/Content/Management/Dictionary/TranslationKey_Edit.aspx?DesignName=' + designName + '&IsNew=true', '', 'width=800,height=600,resizable=yes,scrollbars=yes,status=yes,left=' + x + ',top=' + y);
                }
            }
        });
    })(ns.TranslationKey_Reference = ns.TranslationKey_Reference || {});
})(window.Dictionary = window.Dictionary || {});
