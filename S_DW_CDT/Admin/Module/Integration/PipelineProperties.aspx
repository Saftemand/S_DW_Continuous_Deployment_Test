<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PipelineProperties.aspx.vb" Inherits="Dynamicweb.Admin.Integration.PipelineProperties" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>

	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">		
	<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
	<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
	<meta name="vs_defaultClientScript" content="JavaScript">
	<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
	<script type="text/javascript" language="JavaScript" src="/Admin/Module/eCom_Catalog/images/ObjectSelector.js"></script>
	<script src="/Admin/FileManager/FileManager_browse2.js" type="text/javascript"></script>

    <style type="text/css">
		body.margin {
			margin-top: 0px;
			margin-left: 0px;
			margin-right: 0px;
			margin-bottom: 0px;
		}
		
		input,select,textarea {font-size: 11px; font-family: verdana,arial;}
    </style>
    
    <script>
    function SaveProperties() {
        document.getElementById("SaveButton").click();
    }
    </script>
   
</head>

<body style="background-color:#ECE9D8;" leftmargin=1 rightmargin=0 topmargin=0>
	
    <form id="form1" runat="server">

	    <asp:Literal id="BoxStart" runat="server"></asp:Literal>

			<dw:TabHeader id="TabHeader1" runat="server" TotalWidth="100%"></dw:TabHeader>
			
			<div class="tabTable100Large" id="DW_Ecom_tableTab">
			
			    <table border="0" cellpadding="0" cellspacing="0" style="height:305px;width:100%">
			    <tr>
			    <td valign="top" style="width:100%">
    			
    			    <div id="Tab1">	
                        <div height="100%" id="propHolder" style="height:300px;width:100%;overflow:auto;overflow-x:hidden">
                            <dw:GroupBoxStart runat="server" title="Properties" id="GroupBoxStart1"></dw:GroupBoxStart>
                                <table border="0" cellpadding="2" cellspacing="0">
                                    <tr>
                                        <td>
                                            <table border="0" cellpadding="2" cellspacing="2" width="100%">
                                                <asp:Literal ID="Properties" runat="server"></asp:Literal>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
	    					<dw:GroupBoxEnd runat="server" id="GroupBoxEnd1"></dw:GroupBoxEnd>
	    				</div>	
	    		    </div>

                </td>
                </tr>
                </table>  
            </div>  		


        <asp:Button ID="SaveButton" runat="server" style="display:none;" />
    
        <asp:Literal id="BoxEnd" runat="server"></asp:Literal>
    </form>

</body>
</html>
<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>