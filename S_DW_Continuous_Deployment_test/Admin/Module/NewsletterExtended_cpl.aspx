<%@ Page Language="vb" AutoEventWireup="false"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="DynamicWeb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
    Dim NLSMTPport As String = CStr(Base.GetGs("/Globalsettings/Modules/NewsletterExtended/MailServer/SMTPport"))
    Dim NLCDOPort As String = CStr(Base.GetGs("/Globalsettings/Modules/NewsletterExtended/MailServer/CDOPort"))
    Dim NLTimeout As String = CStr(Base.GetGs("/Globalsettings/Modules/NewsletterExtended/MailServer/Timeout"))
    Dim NLDropbox_Path As String = CStr(Base.GetGs("/Globalsettings/Modules/NewsletterExtended/DropboxAndPickup/DropboxPath"))
    Dim NLRowNumbers As String = CStr(Base.GetGs("/Globalsettings/Modules/NewsletterExtended/Lists/NumberOfRowsInLists"))
    Dim NLShowAllOnList As String = CStr(Base.GetGs("/Globalsettings/Modules/NewsletterExtended/Lists/ShowAllRowsInLists"))
    Dim NLAllwaysSearchInAllCategories As String = CStr(Base.GetGs("/Globalsettings/Modules/NewsletterExtended/Lists/SearchInAllCategories"))
    Dim NLShowAllUsersCategory As String = CStr(Base.GetGs("/Globalsettings/Modules/NewsletterExtended/Lists/ShowAllUsersCategory"))
    Dim NLDefaultEncoding As String = Base.GetGs("/Globalsettings/Modules/NewsletterExtended/Common/NewsletterEncoding")


    If NLSMTPport = "" Then
        NLSMTPport = "25"
    End If

    If NLCDOPort = "" Then
        NLCDOPort = "2"
    End If

    If NLTimeout = "" Then
        NLTimeout = "60"
    End If

    If NLDropbox_Path = "" Then
        NLDropbox_Path = "C:\Inetpub\mailroot\Pickup\"
    End If

    If NLRowNumbers = "" Then
        NLRowNumbers = "20"
    End If
    
    If NLDefaultEncoding = "" Then
        NLDefaultEncoding = Nothing
    End If

%>


<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title><%=Translate.JsTranslate("Udvidet Nyhedsbreve",9)%></title>
    
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <dw:ControlResources ID="ctrlResources" IncludePrototype="false" runat="server" />

    <style type="text/css">
        body
        {
	        border-right:1px solid #ffffff;
        }        
    </style>

    <script type="text/javascript" src="/Admin/Module/Common/Validation.js"></script>

    <script type="text/javascript">

        function help() {
		    <%=Dynamicweb.Gui.help("","administration.controlpanel.newsletterextended") %>
	    }

        function onSave() {

            document.getElementById('hiddenSource').value='ManagementCenterSave';

            save();
	    }

        function onSaveAndClose() {
            save();
	    }

        function save() {

            findCheckboxNames();

		    var smtpPort = document.getElementById("/Globalsettings/Modules/NewsletterExtended/MailServer/SMTPport");
		    var cdoPort = document.getElementById("/Globalsettings/Modules/NewsletterExtended/MailServer/CDOPort");
		    var timeout = document.getElementById("/Globalsettings/Modules/NewsletterExtended/MailServer/Timeout");
		    var numberOfRows = document.getElementById("/Globalsettings/Modules/NewsletterExtended/Lists/NumberOfRowsInLists");
		    var ret = true;
	
		    if(smtpPort.value.length > 0)
			    ret = ret && CheckField(smtpPort, ChkInt(smtpPort.value), 
				    "<%=Translate.JSTranslate("Ugyldige tegn i: %%", "%%", Translate.JsTranslate("SMTP port"))%>");
				
		    if(cdoPort.value.length > 0)
			    ret = ret && CheckField(cdoPort, ChkInt(cdoPort.value), 
				    "<%=Translate.JSTranslate("Ugyldige tegn i: %%", "%%", Translate.JsTranslate("CDO port"))%>");
		
		    if(timeout.value.length > 0)
			    ret = ret && CheckField(timeout, ChkInt(timeout.value), 
				    "<%=Translate.JSTranslate("Ugyldige tegn i: %%", "%%", Translate.JsTranslate("Timeout"))%>");
		
		    if(numberOfRows.value.length > 0)
			    ret = ret && CheckField(numberOfRows, ChkInt(numberOfRows.value), 
				    "<%=Translate.JSTranslate("Ugyldige tegn i: %%", "%%", Translate.JsTranslate("Antal rækker i lister"))%>");	
		
		    if(ret)
			    document.getElementById('frmGlobalSettings').submit();
	    }

	    function CheckField(control, isValid, message)
	    {
		    if(!isValid)
		    {
			    alert(message);
			    control.focus();
		    }
	
		    return isValid;
	    }
		

        function findCheckboxNames() {
            var form = document.getElementById('frmGlobalSettings');
            var _names = "";
            for (var i = 0; i < form.length; i++) {
                if (form[i].name != undefined) {
                    if (form[i].type == "checkbox") {
                        _names = _names + form[i].name + "@"
                    }
                }
            }
            form.CheckboxNames.value = _names;
        }

    </script>

</head>

<body>

    <div id="PageContent" style="min-width:600px;" >

	<form method="post" action="ControlPanel_Save.aspx" name="frmGlobalSettings" id="frmGlobalSettings">

        <input id="hiddenSource" type="hidden" name="_source" value="ManagementCenter" />

        <dw:Toolbar ID="ToolbarButtons" ShowStart="false" ShowEnd="false" runat="server" >
            <dw:ToolbarButton ID="cmdSave" runat="server" Image="Save" Text="Save" OnClientClick="onSave();" />
            <dw:ToolbarButton ID="cmdOk" runat="server" Divide="Before" Image="SaveAndClose" Text="Gem og luk" OnClientClick="onSaveAndClose();" />
            <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="Before"  Image="Cancel" Text="Cancel" OnClientClick="location='ControlPanel.aspx';" />
            <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="help();" />
        </dw:Toolbar>

        <h2 class="subtitle">
            <dw:TranslateLabel ID="lbSetup" Text="Udvidet Nyhedsbreve" runat="server" />
        </h2>

		<input type="hidden" name="CheckboxNames" />

        <table border="0" cellpadding="2" cellspacing="0" class="tabTable">

		    <tr>
			    <td valign="top">

				    <%If Session("DW_Admin_UserType") < 4 Then %>
					    <%=Gui.GroupBoxStart(Translate.Translate("Mailserver")) %>
						    <table border="0" cellpadding="2" cellspacing="0">
							    <tr>
								    <td width="150"><%= Translate.Translate("Udgående SMTP server") %></td>
								    <td><%= Translate.Translate("See Management Center --> System setup")%></td>
							    </tr>
							    <tr>
								    <td width="150"><%= Translate.Translate("SMTP port") %></td>
								    <td><input type="text" name="/Globalsettings/Modules/NewsletterExtended/MailServer/SMTPport" id="/Globalsettings/Modules/NewsletterExtended/MailServer/SMTPport" value="<%=Base.GetGs("/Globalsettings/Modules/NewsletterExtended/MailServer/SMTPport")%>" maxlength="255" class="std" /></td>
							    </tr>
							    <tr>
								    <td width="150"><%= Translate.Translate("CDO Port") %></td>
								    <td><input type="text" name="/Globalsettings/Modules/NewsletterExtended/MailServer/CDOPort" id="/Globalsettings/Modules/NewsletterExtended/MailServer/CDOPort" value="<%=Base.GetGs("/Globalsettings/Modules/NewsletterExtended/MailServer/CDOPort")%>" maxlength="255" class="std" /></td>
							    </tr>
							    <tr>
								    <td width="150"><%= Translate.Translate("Timeout") %></td>
								    <td><input type="text" name="/Globalsettings/Modules/NewsletterExtended/MailServer/Timeout" id="/Globalsettings/Modules/NewsletterExtended/MailServer/Timeout" value="<%=Base.GetGs("/Globalsettings/Modules/NewsletterExtended/MailServer/Timeout")%>" maxlength="255" class="std" /></td>
							    </tr>
						    </table>
					    <%=Gui.GroupBoxEnd%>
					    <%=Gui.GroupBoxStart(Translate.Translate("Dropbox/Pickup")) %>
						    <table border="0" cellpadding="2" cellspacing="0">
							    <tr>
								    <td width="150"><%= Translate.Translate("Sti til folder") %></td>
								    <td><input type="text" name="/Globalsettings/Modules/NewsletterExtended/DropboxAndPickup/DropboxPath" id="/Globalsettings/Modules/NewsletterExtended/DropboxAndPickup/DropboxPath" value="<%=Server.HtmlEncode(Base.GetGs("/Globalsettings/Modules/NewsletterExtended/DropboxAndPickup/DropboxPath"))%>" maxlength="255" class="std" /></td>
							    </tr>
						    </table>
					    <%=Gui.GroupBoxEnd%>
					    <%=Gui.GroupBoxStart(Translate.Translate("Lister")) %>
						    <table border="0" cellpadding="2" cellspacing="0">
							    <tr>
								    <td width="150"><%= Translate.Translate("Antal rækker i lister") %></TD>
								    <td><input type="text" name="/Globalsettings/Modules/NewsletterExtended/Lists/NumberOfRowsInLists" id="/Globalsettings/Modules/NewsletterExtended/Lists/NumberOfRowsInLists" value="<%=Base.GetGs("/Globalsettings/Modules/NewsletterExtended/Lists/NumberOfRowsInLists")%>" maxlength="255" class="std" /></td>
							    </tr>
							    <tr>
								    <td FOR="NLShowAllOnList" width="150"><%= Translate.Translate("Vis alle rækker i lister") %></TD>
								    <td><input type="checkbox" name="/Globalsettings/Modules/NewsletterExtended/Lists/ShowAllRowsInLists" id="/Globalsettings/Modules/NewsletterExtended/Lists/ShowAllRowsInLists" value="1" <% if NLShowAllOnList = "1" Then response.Write("CHECKED")%> /></td>
							    </tr>		
							    <tr>
								    <td FOR="NLAllwaysSearchInAllCategories" width="150"><%= Translate.Translate("Søg i alle lister") %></TD>
								    <td><input type="checkbox" name="/Globalsettings/Modules/NewsletterExtended/Lists/SearchInAllCategories" id="/Globalsettings/Modules/NewsletterExtended/Lists/SearchInAllCategories" value="1" <% if NLAllwaysSearchInAllCategories = "1" Then response.Write("CHECKED")%> /></td>
							    </tr>		
							    <tr>
								    <td FOR="NLShowAllUsersCategory" width="150"><%= Translate.Translate("Vis ´Alle bruger´ listen") %></TD>
								    <td><input type="checkbox" name="/Globalsettings/Modules/NewsletterExtended/Lists/ShowAllUsersCategory" id="/Globalsettings/Modules/NewsletterExtended/Lists/ShowAllUsersCategory" value="1" <% if NLShowAllUsersCategory = "1" Then response.Write ("CHECKED")%> /></td>
							    </tr>		
						    </table>
					    <%=Gui.GroupBoxEnd%>
					    <%=Gui.GroupBoxStart(Translate.Translate("Generelt")) %>
					        <table border="0" cellpadding="0" cellspacing="0">
					            <tr>
					                <td style="width: 150px;"><%=Translate.Translate("Standard %%", "%%", Translate.Translate("Encoding"))%></td>
					                <td><%=Gui.EncodingList(NLDefaultEncoding, "/Globalsettings/Modules/NewsletterExtended/Common/NewsletterEncoding", True)%></td>
					            </tr>
					        </table>
					    <%=Gui.GroupBoxEnd%>
				    <%Else%>		
					    <table border="0" cellpadding="6" cellspacing="6">
						    <tr>
							    <td>
								    <%=Translate.Translate("Du har ikke de nødvendige rettigheder til denne funktion.")%>
							    </td>
						    </tr>
					    </table>
				    <%End If%>
			    </td>	    
		    </tr>

        </table>

    </form>
    </div>

<%=Gui.SelectTab%>    

</body>
</html>

<%
    Translate.GetEditOnlineScript()
%>
