<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EcomIntegration_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.IntegrationEdit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
	<HEAD>
		<title></title>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		
        <script type="text/javascript" src="../Integration/Scripts/prototype.js"></script>
        <script type="text/javascript" src="../Integration/Scripts/rico.js"></script>
        <script type="text/javascript" src="../Integration/Scripts/ajax.js"></script>
        <link href="../Integration/pipeline.css" rel="stylesheet" type="text/css" />
		
			<dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
		<link rel="STYLESHEET" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
		
		<style type="text/css">
		body.margin {
			margin-top: 0px;
			margin-left: 0px;
			margin-right: 0px;
			margin-bottom: 0px;
			
		}
		
		input,select,textarea {font-size: 11px; font-family: verdana,arial;}
		
		.DebugText {
		    text-align:left;
		    font:8pt calibri;
		    position:absolute;
		    left:0px;
		    top:0px;
		    width:350px;
		    height:300px;
		}
		
		html>body .DebugText {
		    left:215px;
		    top:65px;
		    width:350px;
		    height:300px;
        }
		</style>		
		
		<script>
		
		var FileName = "<%=Request("ID")%>";		
		
		function CreatePipe() 
		{
            SavePipeline(FileName, false);
		}
		
		function DeletePipe() 
		{ 
		    var Message = "<%=Dynamicweb.Backend.Translate.JsTranslate("Slet?")%>"
			if (confirm (Message)) {
    		    document.getElementById("DeleteButton").click();
    		}    
		    
		}
		
		function ClonePipe() 
		{
		    SavePipeline(FileName, true);
		}
		
		function RunPipe() 
		{
		   page = "/admin/Module/eCom_Catalog/Integration/PipelineRunner.aspx";
		   wleft = 400;
		   wtop = 300;
		   wwidth = 500;
		   wheight = 400;
		   var returnvalue = window.open(page,"PipelineRunner","displayWindow,left="+wleft+",top="+wtop+",screenX="+wleft+",screenY="+wtop+",width="+wwidth+",height="+wheight+",scrollbars=no");
		}
		
		function EditPipe() 
		{
		   page = "/admin/Module/eCom_Catalog/Integration/PipelineProperties.aspx";
		   wleft = 400;
		   wtop = 300;
		   wwidth = 500;
		   wheight = 400;
		   var returnvalue = window.open(page,"Properties","displayWindow,left="+wleft+",top="+wtop+",screenX="+wleft+",screenY="+wtop+",width="+wwidth+",height="+wheight+",scrollbars=no");
		   
		}
		
		function PageInit() {
		    UpdateToolbox();
		    LoadPipeline();
		}
		</script>
		
	</HEAD>
	<body MS_POSITIONING="GridLayout" style="background-color:#ECE9D8;" onload="PageInit();" onselectstart="return false" onkeydown="return KeyHandler(event);">
	
	
		<form id="Form1" method="post" runat="server">
		
        	<asp:Literal id="BoxStart" runat="server"></asp:Literal>
			<div id="DW_Ecom_tableTab" style="background-color:#ECE9D8;border-left:1px solid #aca899;">

                <table class="designer-table" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="208" valign="top" rowspan="2"></td>
                  <td align="center"><div class="pipeline-designer" id="PipelineDesigner" style="background-color:white"></div></td>
                </tr>
                </table>


				<asp:Button id="SaveButton" style="display:none;" runat="server"></asp:Button>
				<asp:Button id="DeleteButton" style="display:none;" runat="server"></asp:Button>
				<asp:Button id="SaveAsButton" style="display:none;" runat="server"></asp:Button>
				
            </div>
        	<asp:Literal id="BoxEnd" runat="server"></asp:Literal>
            
		</form>
		
        <div class="designer-toolbox" id="DesignerToolbox"></div>
        <div id="activityTipElement" style="display:none;"></div>
        <img id="activityTipElementBaloon" src="/admin/Module/eCom_Catalog/Integration/Images/speechbubble_pointer.gif" style="display:none;">

	</body>
</HTML>

<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>