<%@ Page Language="vb" ValidateRequest="false" AutoEventWireup="false" Codebehind="EcomOrderLineField_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomOrderLineField_Edit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1" />
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1" />
    <meta name="vs_defaultClientScript" content="JavaScript" />
    <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5" />
	<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css" />

	<dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
		<link rel="STYLESHEET" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />

	<style type="text/css">
	  BODY.margin { MARGIN: 0px }
	  input,select,textarea {font-size: 11px; font-family: verdana,arial;}
	</style>		
	
	<script type="text/javascript">

	    $(document).observe('dom:loaded', function () {
	        window.focus(); // for ie8-ie9 
	        document.getElementById('NameText').focus();
	    }); 

	    function validate() {
	        var success = true;
	        var systemName = document.getElementById("SystemNameText").value;
	        var name = document.getElementById("NameText").value;
	        var length = document.getElementById("LengthText").value;

	        if (systemName.length > 255) {
	            document.getElementById("SystemNameError").innerHTML = '<%=Translate.JsTranslate("The system name must be shorter than 256 characters.") %>';
	            success = false;
	        } else if (!systemName.match(/^[a-zA-Z0-9_]*$/)) {
	            document.getElementById("SystemNameError").innerHTML = '<%=Translate.JsTranslate("The system name can only contain letters, numbers and underscores.") %>';
	            success = false;
	        }

	        if (name.length > 255) {
	            document.getElementById("NameError").innerHTML = '<%=Translate.JsTranslate("The name must be shorter than 256 characters.") %>';
	            success = false;
	        }
	        if (name.length == 0) {
	            document.getElementById("NameError").innerHTML = '<%=Translate.JsTranslate("Please type a name.") %>';
	            success = false;
	        }

	        try {
	            var lengthAsInt = parseInt(length);
	            if (lengthAsInt <= 0) {
	                document.getElementById("LengthError").innerHTML = '<%=Translate.JsTranslate("The length must be positive.") %>';
	                success = false;
	            }
	        } catch (e) {
	            document.getElementById("LengthError").innerHTML = '<%=Translate.JsTranslate("The length must be an integer.") %>';
	            success = false;
	        }
	        return success;
	    }

	    function load() {
	        document.getElementById("SaveButton").onclick = validate;
	    }
	    function saveOrderLineFields(close) {
	        document.getElementById("Close").value = close ? 1 : 0;
	        document.getElementById('Form1').SaveButton.click();
	    }
	</script>
  </head>
  <body onload="load();"  style="background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;">
  
	<asp:Literal id="BoxStart" runat="server" />

	<form id="Form1" method="post" runat="server">
        <input id="Close" type="hidden" name="Close" value="0" />
	<asp:HiddenField runat="server" ID="IsNewOrderLineField" Value="False" />
	<asp:HiddenField runat="server" ID="SaveError" Value="" />
	<dw:TabHeader id="TabHeader1" runat="server" TotalWidth="100%" />

		<table border="0" cellpadding="0" cellspacing="0" class="tabTable100" id="DW_Ecom_tableTab">
		    <tr><td style="vertical-align:top;">

                <div id="Tab1">
                    <br />
                        <table border="0" cellpadding="0" cellspacing="0" style="width:95%;">
                            <tr><td>
		                        <dw:GroupBox runat="server" ID="GroupBox">
		                        
		                            <!-- Name -->
                                    <div style="margin:10px 10px 10px 10px">
                                        <div style="float:left">
                                            <dw:TranslateLabel runat="server" Text="Name" />
                                        </div>
                                        <div style="margin-left:100px">
                                            <div id="NameError" style="color: Red;"></div>
			                                <asp:textbox id="NameText" CssClass="NewUIinput" runat="server" />
			                            </div>
			                        </div>
                			        
		                            <!-- SystemName -->
                                    <div style="margin:10px 10px 10px 10px">
                                        <div style="float:left">
                                            <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="System name" />
                                        </div>
                                        <div style="margin-left:100px">
                                            <div id="SystemNameError" style="color: Red;"></div>
			                                <asp:textbox id="SystemNameText" CssClass="NewUIinput" runat="server" />
			                            </div>
			                        </div>
                        			
			                        <!-- Length of text input field -->
                                    <div style="margin:10px 10px 10px 10px">
                                        <div style="float:left">
                                            <dw:TranslateLabel runat="server" Text="Length of text input field" />
                                        </div>
                                        <div style="margin-left:100px">
                                            <div id="LengthError" style="color: Red;"></div>
			                                <asp:textbox id="LengthText" CssClass="NewUIinput" runat="server" />
			                            </div>
			                        </div>
			                        
                                </dw:GroupBox>
                            </td></tr>
                        </table>                            
                    <br />
                </div>
            </td></tr>
        </table>
                
		<asp:Button id="SaveButton" style="display:none" runat="server" />
		<asp:Button id="DeleteButton" style="display:none" runat="server" />


	</form>
	
	<asp:Literal id="BoxEnd" runat="server" />

	<iframe frameborder="0" name="EcomUpdator" id="EcomUpdator" width="1" height="1" align="right" marginwidth="0" marginheight="0" src="EcomUpdator.aspx"></iframe>
	
	<script type="text/javascript">
	    var errorCode = document.getElementById('SaveError').value;
	    if (errorCode == 'DuplicateSystemName')
	        document.getElementById("SystemNameError").innerHTML = '<%=Translate.JsTranslate("An orderline field with the same systemname exists. Please select another name.") %>';
	</script>
  </body>
</html>

<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>






