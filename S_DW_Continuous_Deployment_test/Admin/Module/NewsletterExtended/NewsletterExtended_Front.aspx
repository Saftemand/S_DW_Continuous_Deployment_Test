<%@ Page CodeBehind="NewsletterExtended_Front.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.NewsletterExtended_Front" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="DynamicWeb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<html>

<head>
    <title><%=Translate.JsTranslate("Nyhedsbreve")%></title>
    <link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
    <dw:ControlResources ID="ctrlResources" IncludePrototype="false" runat="server" />    
    <script type="text/javascript">
        function onWizardClose(sender, args) {
            if (sender != null && sender.get_contentDocument() != null) {
                //If this is the last page of Wizard - after import process with ViewLog and Ok buttons                
                var dataImportForm = sender.get_contentDocument().getElementById("dataImportForm");
                if (dataImportForm != null && dataImportForm._ucProgress_canc != null) {
                    //perform Ok button click before Close Wizard to delete NewsletterExtended tables from db
                    dataImportForm._ucProgress_canc.click();
                    //prevent immediate close, allow the execution of previous click event
                    args.set_cancel(true);
                }
            }            
        }
    </script>
</head>

<body bottommargin=0 leftmargin=0 topmargin=0 rightmargin=0 style="background-color:#ffffff;margin:0px;" height="100%" scroll="no" onload="newWizard_wnd.show();">

<dw:PopUpWindow ID="newWizard" ContentUrl="/Admin/Module/NewsLetterV3/ConversionToNewsletterV3/Newsletterv3WizardInformation.aspx"
        AutoReload="true" Title="Newsletterv3 import wizard" ShowClose="true" ShowOkButton="false" OnClientHide="onWizardClose"
        Width="1100" ShowCancelButton="false" runat="server" HidePadding="true" />

<table id="MenuTable" height="100%" cellSpacing="0" cellPadding="0" width="100%" border="0" style="display:none;">
  <tr bgColor="#ffffff" height="100%" >
    <td width="5"  height="100%" bgColor="#ece9d8">&nbsp;</td>
    <td vAlign="top" height="100%" >
		<table height="100%" cellSpacing="0" cellPadding="0" width="190" border="0">
		  <tr id="TreeStart" bgColor="#ece9d8" height="23">
			<td colspan=2><strong>&nbsp;<%=Translate.Translate("Nyhedsbreve")%></strong></td>
		  </tr>
		  <tr bgColor="#aca899" height="1px">
			<td></td>
		  </tr>
		  <tr Name="IframeTR" ID="IframeTR" bgcolor="red" height="100%">
			<td height="100%" bgcolor="red" valign="top">
				<iframe name="ContentCell" id="ContentCell" width="200px" height="100%" src="NewsletterExtended_Treeview.aspx" marginwidth="0" marginheight="0" border="0" frameBorder="0" TOPMARGIN="0" LEFTMARGIN="10">
				</iframe>
			</td>
		  </tr>
		</table>
    </td>
    <td width="5" bgColor="#ece9d8" rowSpan="2">&nbsp;</td>
    <td vAlign="top">
		<table height="100%" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr bgColor="#ece9d8" height="50">
				<td width="100%">
					<table cellSpacing="0" cellPadding="4" border="0" width="100%">
					  <tr valign="top" width="100%">
						<td align=center width=15></td>
						<td align=center class=preview>
							<a href="NewsletterExtended_recipient_edit.aspx?RecipientType=1" target="ListRight">
								<img alt src="/Admin/Images/Icons/Module_Newsletter_NewUser.gif" border="0" width="32" height="32"><br>
								<%=Translate.Translate("Ny modtager")%>
							</a>
						</td>
						<td align=center width=15></td>
						<td align=center class=preview>
							<a href="NewsletterExtended_letter_edit.aspx" target="ListRight">
								<img alt src="/Admin/Images/Icons/Module_Newsletter_NewLetter.gif" border="0" width="32" height="32"><br>
								<%=Translate.Translate("Nyt nyhedsbrev")%>
							</a>
						</td>
						<td align=center width=15></td>
						<td align=center class=preview>
							<a href="NewsletterExtended_category_edit.aspx" target="ListRight">
								<img alt src="/Admin/Images/Icons/Module_Newsletter_NewList.gif" border="0" width="32" height="32"><br>
								<%=Translate.Translate("Ny liste")%>
							</a>
						</td>
						<td align=center width=15></td>
						<td align=center class=preview>
							<a href="NewsletterExtended_recipient_ImExPort.aspx?PortingType=1" target="ListRight">
								<img alt src="/Admin/Images/Icons/Module_Newsletter_Import.gif" border="0" width="32" height="32"><br>
								<%=Translate.Translate("Importer/Exporter")%>
							</a>	
						</td>
						<td align=center width=15></td>
						<td align=center class=preview>
							<a href="Newsletter_Active_Threads.aspx" target="ListRight">
								<img alt src="/Admin/Images/Icons/Module_NewsletterExtended_SendProgress.gif" border="0" width="32" height="32"><br>
								<%=Translate.Translate("Forsendelser")%>
							</a>	
						</td>
						<td align=center width=15></td>
						<td align=center class=preview>
							<a href="NewsletterExtended_recipient_UserFields.aspx" target="ListRight">
								<img alt src="/Admin/Images/Icons/Module_Newsletter_UserFields.gif" border="0" width="32" height="32"><br>
								<%=Translate.Translate("Bruger Felter")%>
							</a>
						</td>
						<%If Base.HasVersion("18.2.1.0") Then%>
						<td align=center width=15></td>
						<td class=preview valign="top" align="center" width="58">
							<a href="#" onClick="<%=Gui.Help("udvidetnyhedsbrev", "modules.newsletterextended.general")%>;">
							<img src="/Admin/Images/Icons/Help.gif" alt="<%=Translate.Translate("Hjælp")%>" border="0"><br /><%=Translate.Translate("Hjælp")%>
							</a>
						</td>
						<%End If%>

					  </tr>
					</table>
				</td>
			</tr>
			<tr bgColor="#ECE9D8" width="100%" height=2>
				<td colspan="10"></td>
			</tr>
			<tr bgColor="#ECE9D8" width="100%" height=4>
				<td colspan="10" width="100%" background="../../images/SpacerBG.gif">
				</td>
			</tr>
			<tr Height="100%">
				<td colspan="10" width="100%">
					<iframe id="ListRight" name="ListRight" width="100%" height="100%" src="NewsletterExtended_Blank.html" marginwidth="0" marginheight="0" border="0" frameborder="0" scrolling="yes" align="left" >
					</iframe>
				</td>
			</tr>
		</table>
    </td>
  </tr>
  <tr id="TreeEnd" height="50">
    <td width="5"  height="100%" bgColor="#ece9d8">&nbsp;</td>
  	<td >
    	<table cellSpacing="3" cellPadding="0">
      		<tr>
	        	<td width="200">
					<span ID="InfoDiv"></span>
		        </td>
	      </tr>
    	</table>
    </td>
    <td width="100%">	    
    	<table  width="100%" cellSpacing="0" cellPadding="0">
    	  <tr>
        	<td height="40">
	            <iframe border="0" id="StatusFrame" name="StatusFrame" align="left" marginWidth="0" marginHeight="0" src="NewsletterExtended_blank_with_color.html" frameBorder="0" width="100%" scrolling="no" height="45">
    	        </iframe>
        	</td>
	      </tr>
    	</table></td>
    <td width="5px" colspan="4">
    </td>
  </tr>
</table>
</body>

</html>
<SCRIPT LANGUAGE="JavaScript">
<!--

var objInfo
objInfo = document.getElementById("InfoDiv")
function updateinfo(varInnerHTML) {
	objInfo.innerHTML = varInnerHTML;
	objInfo.innerHTML = objInfo.innerHTML;
}

//-->
</SCRIPT>
<%
Translate.GetEditOnlineScript()
%>
