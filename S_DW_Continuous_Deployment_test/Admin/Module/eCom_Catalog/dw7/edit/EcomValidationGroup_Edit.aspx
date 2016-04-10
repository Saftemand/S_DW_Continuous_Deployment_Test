<%@ Page Language="vb" ValidateRequest="false" AutoEventWireup="false" Codebehind="EcomValidationGroup_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomValidationGroup_Edit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
    <meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
    <meta name="vs_defaultClientScript" content="JavaScript">
    <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">

	<dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
    
    <link rel="STYLESHEET" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
	<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css" />
	
	<style type="text/css">
	  BODY.margin { MARGIN: 0px }
	  input,select,textarea {font-size: 11px; font-family: verdana,arial;}
	</style>		

	<script type="text/javascript">

	    $(document).observe('dom:loaded', function () {
	        $("SaveButton").onclick = validate;

            window.focus(); // for ie8-ie9 
            document.getElementById('NameStr').focus();
	    }); 

	    function validate() {
	        var success = true;
	        var groupName = document.getElementById("NameStr").value;

	        if (groupName.length > 255) {
	            document.getElementById("errNameStr").innerHTML = '<%=Translate.JsTranslate("The group name must be shorter than 256 characters.") %>';
	            success = false;
	        }
	        if (groupName.length == 0) {
	            document.getElementById("errNameStr").innerHTML = '<%=Translate.JsTranslate("Please type a name.") %>';
	            success = false;
	        }

	        success = validateParameters() && success;
	        return success;
	    }

	    function save(close) {
	        document.getElementById("Close").value = close ? 1 : 0;
	        document.getElementById('Form1').SaveButton.click();
	    }
	</script>

	</head>
  <body style="background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;">
  
<asp:Literal id="BoxStart" runat="server" />
<form id="Form1" method="post" runat="server">
    <input id="Close" type="hidden" name="Close" value="0" />
    <asp:Literal id="TableIsBlocked" runat="server"></asp:Literal>
    <dw:TabHeader id="TabHeader1" runat="server" TotalWidth="100%" />
    <table border="0" cellpadding="0" cellspacing="0" class="tabTable100" id="DW_Ecom_tableTab" style="clear:left;">
        <tr><td style="vertical-align:top;">
            <div id="Tab1">
                <br />
                    <table border="0" cellpadding="0" cellspacing="0" style="width:95%;">
                        <tr><td>

			                <!-- Group -->
        		            <dw:GroupBox runat="server" ID="GroupGroupBox">
    		        
		                        <!-- Group Name -->
                                <div style="margin:10px 10px 10px 10px">
                                    <div style="float:left">
                                        <dw:TranslateLabel runat="server" Text="Name" />
                                    </div>
                                    <div style="margin-left:100px">
                                        <div id="errNameStr" style="color: Red;"></div>
			                            <asp:textbox id="NameStr" CssClass="NewUIinput" runat="server"  />
			                        </div>
			                    </div>
                                
                            </dw:GroupBox>
                            
                            
	                        <!-- Fields -->
		                    <dw:GroupBox runat="server" ID="FieldGroupBox">
		                        <div style="margin:10px 10px 10px 10px">
		                            <de:ValidationConfigurator runat="server" ID="ValidationConfigurator" />
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
</body>
</html>

<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>