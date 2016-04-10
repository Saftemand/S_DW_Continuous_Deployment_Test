<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Page language="vb"%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta charset="utf-8"/>
		<title>Link Browser</title>
		<script src="/Admin/Editor/ckeditor/ckeditor/ckeditor.js"></script>
<style>
.browser {
white-space: nowrap;
}

input.std {
	width: 90%;
}

a {
text-decoration: none;
}

.buttons {
	margin: 1em 0;
	text-align: right;
}
</style>
	</head>
	<body>
    <%If IsNothing(Base.Request("type")) OrElse Base.Request("type") <> "image" Then%>
        <div class="browser">
            <%= Gui.LinkManager("", "url", "", "0", Base.ChkNumber(HttpContext.Current.Session("DW_Area")), False, True, True, "", True, True) %>        
        </div>

        <div class="buttons">
            <button id="ok">OK</button>
            <button id="cancel">Cancel</button>
        </div>
    <%End If%>
<script>
    <%If Not IsNothing(Base.Request("type")) AndAlso Base.Request("type") = "image" Then%>
    window.onload = function () {
        var url = "/Admin/FileManager/Browser/Default.aspx?Mode=browse&Caller="
        var callerID = opener.CKEDITOR.dialog.getCurrent().getContentElement("info", "txtUrl")._.inputId        
        <%If Not IsNothing(Base.Request("tab")) AndAlso Base.Request("tab") = "Link" Then%>        
        if (opener.CKEDITOR.dialog.getCurrent().getContentElement("Link", "txtUrl") != null) {
            callerID = opener.CKEDITOR.dialog.getCurrent().getContentElement("Link", "txtUrl")._.inputId
        }
        <%End If%>        
        window.location = url + callerID;
    };
    <%End If%>

    (function () {
        var setLink = function (url, data) {            
		if (typeof opener.CKEDITOR.tools.callFunction != 'undefined') {
			opener.CKEDITOR.tools.callFunction('<%= Request("CKEditorFuncNum") %>', url, function() {
				var element,
		  dialog = this.getDialog();				
				if (dialog.getName() == 'link') {
					var tabId, attribute;
					if (data.attributes) {
						for (tabId in data.attributes) {
							for (attribute in data.attributes[tabId]) {
								element = dialog.getContentElement(tabId, attribute);
								if (element) {
									element.setValue(data.attributes[tabId][attribute]);
								}
							}
						}
					}
				}
			});
		}

		closeWindow();
	},

	getCurrentLinkInfo = function () {	    
		// @see http://ckeditor.com/forums/CKEditor-3.x/FileLink-browsers-retrieve-current-value
		var dialog = window.opener.CKEDITOR.dialog.getCurrent(),
	  dialogName = dialog.getName(),
	  tabName = (dialogName === 'image' && (dialog._.currentTabIndex === 1)) ? 'Link' : 'info',
	  fieldName = ((dialogName === 'image') ? 'txtUrl' : ((dialogName === 'flash') ? 'src' : 'url')),
		element;

		element = dialog.getContentElement(tabName, fieldName);
		// alert(fieldName+': '+element.getValue());
	},

	closeWindow = function() {
		if (opener) {
			close();
		}
	}

	addEvent = function(id, type, handler) {
		var el = CKEDITOR.document.getById(id);
		if (el) {
			el.on(type, handler);
		}
	}

	addEvent('ok', 'click', function(event) {
		var url = document.getElementById('url').value,
		type, rel,
		title = document.getElementById('Link_url').value,
		data = { url: url, attributes: {} };

		if (/Default.aspx.*#/i.test(url)) {
			type = 'internal link';
			url = '/' + url;
		} else if (/Default.aspx/i.test(url)) {
			type = 'link';
			url = '/' + url;
		} else if (url) {
		    type = 'file';
		    if (url.indexOf('/') == 0) url = '/Files' + url;
			else url = '/Files/' + url;
		}

		setLink(url, data);
	});

	addEvent('cancel', 'click', closeWindow);	
}())</script>

	</body>
</html>
