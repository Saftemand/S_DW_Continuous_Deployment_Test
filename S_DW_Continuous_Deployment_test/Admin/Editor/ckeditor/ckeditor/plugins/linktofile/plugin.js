CKEDITOR.plugins.add('linktofile', {
    icons: 'linktofile',
    init: function (editor) {
        editor.addCommand('insertLinkToFile', {
            allowedContent: 'a[href]',

            exec: function (editor) {
                //set flag to be used for toolbar button click event indication
                if (document != null) {
                    document.isToolbarBtnClick = true;
                }
                var win = window.open("/Admin/FileManager/Browser/Default.aspx?Mode=browselinkcallback", "DW_browse_window", "resizable=no,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,minimize=no,width=1024,height=768,left=200,top=120");
                var setWinPropertiesInterval = setInterval(
                    function setWinProperties() {
                        try {
                            win.RunCallbackFunction = function (href, name) {
                                var selectedText = editor.getSelection().getSelectedText();
                                if (selectedText && selectedText != '') {
                                    editor.insertHtml('<a href="/Files' + href + '">' + selectedText + '</a>');
                                } else {
                                    editor.insertHtml('<a href="/Files' + href + '">' + name + '</a>');
                                }
                            };
                        }
                        catch (error) { }
                        if (!win || win.closed) {
                            //release flag used for toolbar button click event indication
                            if (document && document.isToolbarBtnClick)
                                document.isToolbarBtnClick = null;
                            clearInterval(setWinPropertiesInterval);
                        }
                    }, 500);
            }
        });

        editor.ui.addButton('LinkToFile', {
            label: 'Insert link to file',
            command: 'insertLinkToFile',
            toolbar: 'links'
        });
    }
});