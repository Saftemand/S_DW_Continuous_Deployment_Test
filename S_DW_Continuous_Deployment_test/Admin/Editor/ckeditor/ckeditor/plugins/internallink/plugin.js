CKEDITOR.plugins.add('internallink', {
    icons: 'internallink',
    init: function (editor) {
        editor.addCommand('insertInternalLink', {
            allowedContent: 'a[href]',

            exec: function (editor) {
                //set flag to be used for toolbar button click event indication
                if (document != null) {
                    document.isToolbarBtnClick = true;
                }
                var areaID = 1;
                if (top.left && top.left.AreaID) {
                    areaID = top.left.AreaID;
                }

                var win = window.open('/Admin/Menu.aspx?Action=Internal&ShowTrashBin=no&Callback=True&AreaID=' + areaID, '_new', 'resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=250,height=375,top=155,left=202');
                var setWinPropertiesInterval = setInterval(
                    function setWinProperties() {
                        try {
                            win.RunCallbackFunction = function (href, name)
                            {
                                var selectedText = editor.getSelection().getSelectedText();
                                if (selectedText && selectedText != '') {
                                    editor.insertHtml('<a href="' + href + '">' + selectedText + '</a>');
                                } else {
                                    editor.insertHtml('<a href="' + href + '">' + name + '</a>');
                                }
                            };
                        }
                        catch (error) {}
                        if (!win || win.closed) {
                            //release flag used for toolbar button click event indication
                            if (document && document.isToolbarBtnClick)
                                document.isToolbarBtnClick = null;
                            clearInterval(setWinPropertiesInterval);
                        }
                    }, 500);
            }
        });

        editor.ui.addButton('Internallink', {
            label: 'Insert internal link',
            command: 'insertInternalLink',
            toolbar: 'links'
        });
    }
});