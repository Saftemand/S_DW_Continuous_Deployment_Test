<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="DatabaseSetup_cpl.aspx.vb" Inherits="Dynamicweb.Admin.DatabaseSetup_cpl" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        var page = SettingsPage.getInstance();

        page.onSave = function() {
            page.submit();
        }

        function SSPI(Checked) {
            if (Checked) {
                //document.frmGlobalSettings.DWsqlserver.disabled = true;
                //document.frmGlobalSettings.DWsqldb.disabled = true;
                document.frmGlobalSettings.DWsqluserid.disabled = true;
                document.frmGlobalSettings.DWsqlpwd.disabled = true;

                //document.frmGlobalSettings.DWWebIP.disabled = true;
                //document.frmGlobalSettings.DWsqlserver2.disabled = true;
                //document.frmGlobalSettings.DWsqldb2.disabled = true;
                document.frmGlobalSettings.DWsqluserid2.disabled = true;
                document.frmGlobalSettings.DWsqlpwd2.disabled = true;
            }
            else {
                document.frmGlobalSettings.DWsqlserver.disabled = false;
                document.frmGlobalSettings.DWsqldb.disabled = false;
                document.frmGlobalSettings.DWsqluserid.disabled = false;
                document.frmGlobalSettings.DWsqlpwd.disabled = false;

                document.frmGlobalSettings.DWWebIP.disabled = false;
                document.frmGlobalSettings.DWsqlserver2.disabled = false;
                document.frmGlobalSettings.DWsqldb2.disabled = false;
                document.frmGlobalSettings.DWsqluserid2.disabled = false;
                document.frmGlobalSettings.DWsqlpwd2.disabled = false;
            }
           }
           function sqlAccessChange() {
           	$$('.showOnSql').each(function(s) {
           		if ($("DWsqlmode").value == "ms_sqlserver") {
           			s.style.display = "inherit";
           		} else {
           		s.style.display = "none";
           		}
           	}
           		); 
           }
    </script>
    <style type="text/css">
    	.showOnSql{
			display:<%=IIf(Base.GetGs("/Globalsettings/System/Database/Type") = "ms_sqlserver", "", "none")%>;"
    	}
    </style>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <div id="PageContent">
        <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
			<tr>
				<td valign="top">
					<dw:GroupBox ID="GroupBox2" runat="server" Title="Database" DoTranslation="true">
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170">
								<%=Translate.Translate("Type")%></td>
							<td>
								<select class="std" name="/Globalsettings/System/Database/Type" id="DWsqlmode" onchange="sqlAccessChange();">
									<option value="ms_access" <%=IIf(Base.GetGs("/Globalsettings/System/Database/Type") = "ms_access", "selected", "")%>>Microsoft Access</option>
									<option value="ms_sqlserver" <%=IIf(Base.GetGs("/Globalsettings/System/Database/Type") = "ms_sqlserver", "selected", "")%>>Microsoft SQL Server</option>
								</select>
							</td>
						</tr>
					</table>
					</dw:GroupBox>
					<div class="showOnSql">
					<dw:GroupBox ID="GroupBoxSettings" runat="server" Title="Indstillinger" DoTranslation="true">
					<table border="0" cellpadding="2" cellspacing="0" width="540">
						<tr class="showOnSql">
							<td width="170">
								</td>
							<td>
								<input type="checkbox" onclick="SSPI(this.checked)" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Database/IntegratedSecurity") = "True", "checked", "")%> id="/Globalsettings/System/Database/IntegratedSecurity" name="/Globalsettings/System/Database/IntegratedSecurity" />
								<label for="/Globalsettings/System/Database/IntegratedSecurity">
									<%=Translate.Translate("Brug pålidelig forbindelse")%></label>
								</td>
						</tr>
						<tr>
							<td width="170">
								<%=Translate.Translate("Force SQL Server date format")%></td>
							<td>
								<select class="std" name="/Globalsettings/System/Database/DateFormat" id="DateFormat" onchange="">
									<option value="" <%=IIf(Base.GetGs("/Globalsettings/System/Database/DateFormat") = "", "selected", "")%>><dw:TranslateLabel Text="Intet valgt" runat="server" /></option>
									<option value="mdy" <%=IIf(Base.GetGs("/Globalsettings/System/Database/DateFormat") = "mdy", "selected", "")%>>mdy</option>
									<option value="ymd" <%=IIf(Base.GetGs("/Globalsettings/System/Database/DateFormat") = "ymd", "selected", "")%>>ymd</option>
									<option value="dmy" <%=IIf(Base.GetGs("/Globalsettings/System/Database/DateFormat") = "dmy", "selected", "")%>>dmy</option>
								</select>
							</td>
						</tr>
						<tr class="showOnSql">
							<td width="170">
								<%=Translate.Translate("Server")%></td>
							<td>
								<input type="text" maxlength="255" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/SQLServer")%>" name="/Globalsettings/System/Database/SQLServer" id="DWsqlserver"></td>
						</tr>
						<tr class="showOnSql">
							<td width="170">
								<%=Translate.Translate("Database")%></td>
							<td>
								<input type="text" maxlength="255" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/Database")%>" name="/Globalsettings/System/Database/Database" id="DWsqldb"></td>
						</tr>
						<tr class="showOnSql">
							<td width="170">
								<%=Translate.Translate("Brugernavn")%></td>
							<td>
								<input type="text" maxlength="255" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/UserName")%>" name="/Globalsettings/System/Database/UserName" id="DWsqluserid"></td>
						</tr>
						<tr class="showOnSql">
							<td width="170">
								<%=Translate.Translate("Adgangskode")%></td>
							<td>
								<input type="password" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/Password")%>" name="/Globalsettings/System/Database/Password" id="DWsqlpwd"></td>
						</tr>
						<tr class="showOnSql">
							<td width="170">
								<%=Translate.Translate("Connection string")%></td>
							<td>
								<input type="text" maxlength="255" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/ConnectionString")%>" name="/Globalsettings/System/Database/ConnectionString" id="ConnectionString"></td>
						</tr>
					</table>
					</dw:GroupBox>
                    
                    <dw:GroupBox ID="GroupBox3" runat="server" Title="Alternativ" DoTranslation="true">
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170">
								<%=Translate.Translate("Check IP")%></td>
							<td>
								<input type="text" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/DWWebIP")%>" name="/Globalsettings/System/Database/DWWebIP" id="DWWebIP"></td>
						</tr>
						<tr>
							<td width="170">
								<%=Translate.Translate("Server 2")%></td>
							<td>
								<input type="text" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/SQLServer2")%>" name="/Globalsettings/System/Database/SQLServer2" id="DWsqlserver2"></td>
						</tr>
						<tr>
							<td width="170">
								<%=Translate.Translate("Database 2")%></td>
							<td>
								<input type="text" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/Database2")%>" name="/Globalsettings/System/Database/Database2" id="DWsqldb2"></td>
						</tr>
						<tr>
							<td width="170">
								<%=Translate.Translate("Brugernavn 2")%></td>
							<td>
								<input type="text" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/UserName2")%>" name="/Globalsettings/System/Database/UserName2" id="DWsqluserid2"></td>
						</tr>
						<tr>
							<td width="170">
								<%=Translate.Translate("Adgangskode 2")%></td>
							<td>
								<input type="password" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/Password2")%>" name="/Globalsettings/System/Database/Password2" id="DWsqlpwd2"></td>
						</tr>
						<tr>
							<td width="170">
								<%=Translate.Translate("Connection string 2")%></td>
							<td>
								<input type="text" maxlength="255" class="std" value="<%=Base.GetGs("/Globalsettings/System/Database/ConnectionString2")%>" name="/Globalsettings/System/Database/ConnectionString2" id="ConnectionString2"></td>
						</tr>
						</table>
					</dw:GroupBox>
					</div>
                </div>
                
                	<%
		Translate.GetEditOnlineScript()
	%>
</asp:Content>
