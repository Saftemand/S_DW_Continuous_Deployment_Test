<%@ Page Language="vb" AutoEventWireup="false" Codebehind="AttenoIntegration_cpl.aspx.vb" Inherits="Dynamicweb.Admin.AttenoIntegration_cpl" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
<LINK rel="STYLESHEET" type="text/css" href="../Stylesheet.css">
<TITLE><%=Translate.JsTranslate("Atteno integration",9)%></TITLE>
</HEAD>
<BODY>
<SCRIPT>
	function OK_OnClick() {
		document.getElementById('frmGlobalSettings').submit();
	}

	function findCheckboxNames(form) {
		var _names="";
		for(var i=0; i < form.length ; i++) {
			if(form[i].name!=undefined) {
				if(form[i].type=="checkbox") {
					_names = _names + form[i].name + "@"
				}
			}
		}
	form.CheckboxNames.value=_names;
	}
</SCRIPT>

<%=Gui.MakeHeaders(Translate.Translate("Kontrol Panel - %%", "%%", Translate.Translate("Atteno integration",9)),Translate.Translate("Konfiguration"), "all")%>

<TABLE border="0" cellpadding="2" cellspacing="0" class="tabTable">
	<FORM method="post" action="ControlPanel_Save.aspx" name="frmGlobalSettings" id="frmGlobalSettings">
		<INPUT type="hidden" name="CheckboxNames">
		<TR>
			<TD valign="top">
				<%=Gui.MakeModuleHeader("AttenoIntegration", "Atteno integration", False)%>


				<%If Base.HasAccess("AttenoIntegration", "")Then%>
					<%If Base.HasVersion("18.9.1.0") And Base.HasAccess("AttenoIntegration", "") Then%>
					<%=(Gui.GroupBoxStart(Translate.Translate("Atteno1")))%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170">Brugernavn</td>
							<td><input type="text" name="/Globalsettings/Modules/Form/Atteno1/Username" id="/Globalsettings/Modules/Form/Atteno1/Username" value="<%=Base.GetGs("/Globalsettings/Modules/Form/Atteno1/Username")%>" maxlength="25" style="width:200px;" class="std"></td>
						</tr>
						<tr>
							<td width="170">Password</td>
							<td><input type="password" name="/Globalsettings/Modules/Form/Atteno1/Password" id="/Globalsettings/Modules/Form/Atteno1/Password" value="<%=Base.GetGs("/Globalsettings/Modules/Form/Atteno1/Password")%>" maxlength="25" style="width:200px;" class="std"></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd()%>
					<%=(Gui.GroupBoxStart(Translate.Translate("Atteno2")))%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170">Brugernavn</td>
							<td><input type="text" name="/Globalsettings/Modules/Form/Atteno2/Username" id="/Globalsettings/Modules/Form/Atteno2/Username" value="<%=Base.GetGs("/Globalsettings/Modules/Form/Atteno2/Username")%>" maxlength="25" style="width:200px;" class="std"></td>
						</tr>
						<tr>
							<td width="170">Password</td>
							<td><input type="password" name="/Globalsettings/Modules/Form/Atteno2/Password" id="/Globalsettings/Modules/Form/Atteno2/Password" value="<%=Base.GetGs("/Globalsettings/Modules/Form/Atteno2/Password")%>" maxlength="25" style="width:200px;" class="std"></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd()%>
					<%=(Gui.GroupBoxStart(Translate.Translate("Atteno3")))%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170">Brugernavn</td>
							<td><input type="text" name="/Globalsettings/Modules/Form/Atteno3/Username" id="/Globalsettings/Modules/Form/Atteno3/Username" value="<%=Base.GetGs("/Globalsettings/Modules/Form/Atteno3/Username")%>" maxlength="25" style="width:200px;" class="std"></td>
						</tr>
						<tr>
							<td width="170">Password</td>
							<td><input type="password" name="/Globalsettings/Modules/Form/Atteno3/Password" id="/Globalsettings/Modules/Form/Atteno3/Password" value="<%=Base.GetGs("/Globalsettings/Modules/Form/Atteno3/Password")%>" maxlength="25" style="width:200px;" class="std"></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd()%>
					<%=(Gui.GroupBoxStart(Translate.Translate("Atteno4")))%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170">Brugernavn</td>
							<td><input type="text" name="/Globalsettings/Modules/Form/Atteno4/Username" id="/Globalsettings/Modules/Form/Atteno4/Username" value="<%=Base.GetGs("/Globalsettings/Modules/Form/Atteno4/Username")%>" maxlength="25" style="width:200px;" class="std"></td>
						</tr>
						<tr>
							<td width="170">Password</td>
							<td><input type="password" name="/Globalsettings/Modules/Form/Atteno4/Password" id="/Globalsettings/Modules/Form/Atteno4/Password" value="<%=Base.GetGs("/Globalsettings/Modules/Form/Atteno4/Password")%>" maxlength="25" style="width:200px;" class="std"></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd()%>
					<%=(Gui.GroupBoxStart(Translate.Translate("Atteno5")))%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170">Brugernavn</td>
							<td><input type="text" name="/Globalsettings/Modules/Form/Atteno5/Username" id="/Globalsettings/Modules/Form/Atteno5/Username" value="<%=Base.GetGs("/Globalsettings/Modules/Form/Atteno5/Username")%>" maxlength="25" style="width:200px;" class="std"></td>
						</tr>
						<tr>
							<td width="170">Password</td>
							<td><input type="password" name="/Globalsettings/Modules/Form/Atteno5/Password" id="/Globalsettings/Modules/Form/Atteno5/Password" value="<%=Base.GetGs("/Globalsettings/Modules/Form/Atteno5/Password")%>" maxlength="25" style="width:200px;" class="std"></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd()%>
					<%=(Gui.GroupBoxStart(Translate.Translate("Atteno6")))%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170">Brugernavn</td>
							<td><input type="text" name="/Globalsettings/Modules/Form/Atteno6/Username" id="/Globalsettings/Modules/Form/Atteno6/Username" value="<%=Base.GetGs("/Globalsettings/Modules/Form/Atteno6/Username")%>" maxlength="25" style="width:200px;" class="std"></td>
						</tr>
						<tr>
							<td width="170">Password</td>
							<td><input type="password" name="/Globalsettings/Modules/Form/Atteno6/Password" id="/Globalsettings/Modules/Form/Atteno6/Password" value="<%=Base.GetGs("/Globalsettings/Modules/Form/Atteno6/Password")%>" maxlength="25" style="width:200px;" class="std"></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd()%>
					<%=(Gui.GroupBoxStart(Translate.Translate("Atteno7")))%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170">Brugernavn</td>
							<td><input type="text" name="/Globalsettings/Modules/Form/Atteno7/Username" id="/Globalsettings/Modules/Form/Atteno7/Username" value="<%=Base.GetGs("/Globalsettings/Modules/Form/Atteno7/Username")%>" maxlength="25" style="width:200px;" class="std"></td>
						</tr>
						<tr>
							<td width="170">Password</td>
							<td><input type="password" name="/Globalsettings/Modules/Form/Atteno7/Password" id="/Globalsettings/Modules/Form/Atteno7/Password" value="<%=Base.GetGs("/Globalsettings/Modules/Form/Atteno7/Password")%>" maxlength="25" style="width:200px;" class="std"></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd()%>
					<%=(Gui.GroupBoxStart(Translate.Translate("Atteno8")))%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170">Brugernavn</td>
							<td><input type="text" name="/Globalsettings/Modules/Form/Atteno8/Username" id="/Globalsettings/Modules/Form/Atteno8/Username" value="<%=Base.GetGs("/Globalsettings/Modules/Form/Atteno8/Username")%>" maxlength="25" style="width:200px;" class="std"></td>
						</tr>
						<tr>
							<td width="170">Password</td>
							<td><input type="password" name="/Globalsettings/Modules/Form/Atteno8/Password" id="/Globalsettings/Modules/Form/Atteno8/Password" value="<%=Base.GetGs("/Globalsettings/Modules/Form/Atteno8/Password")%>" maxlength="25" style="width:200px;" class="std"></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd()%>
					<%=(Gui.GroupBoxStart(Translate.Translate("Atteno9")))%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170">Brugernavn</td>
							<td><input type="text" name="/Globalsettings/Modules/Form/Atteno9/Username" id="/Globalsettings/Modules/Form/Atteno9/Username" value="<%=Base.GetGs("/Globalsettings/Modules/Form/Atteno9/Username")%>" maxlength="25" style="width:200px;" class="std"></td>
						</tr>
						<tr>
							<td width="170">Password</td>
							<td><input type="password" name="/Globalsettings/Modules/Form/Atteno9/Password" id="/Globalsettings/Modules/Form/Atteno9/Password" value="<%=Base.GetGs("/Globalsettings/Modules/Form/Atteno9/Password")%>" maxlength="25" style="width:200px;" class="std"></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd()%>
					<%=(Gui.GroupBoxStart(Translate.Translate("Atteno10")))%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170">Brugernavn</td>
							<td><input type="text" name="/Globalsettings/Modules/Form/Atteno10/Username" id="/Globalsettings/Modules/Form/Atteno10/Username" value="<%=Base.GetGs("/Globalsettings/Modules/Form/Atteno10/Username")%>" maxlength="25" style="width:200px;" class="std"></td>
						</tr>
						<tr>
							<td width="170">Password</td>
							<td><input type="password" name="/Globalsettings/Modules/Form/Atteno10/Password" id="/Globalsettings/Modules/Form/Atteno10/Password" value="<%=Base.GetGs("/Globalsettings/Modules/Form/Atteno10/Password")%>" maxlength="25" style="width:200px;" class="std"></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd()%>
					<%End If%>
				<%Else%>		
					<TABLE border="0" cellpadding="6" cellspacing="6">
						<TR>
							<TD>
								<%=Translate.Translate("Du har ikke adgangsrettigheder til denne del af kontrolpanelet.")%>
							</TD>
						</TR>
					</TABLE>
				<%End If%>
					
				<TR>
					<TD align="right" valign=bottom>
						<TABLE>
							<TR>
								<TD>
									<%If Session("DW_Admin_UserType") < 4 Then%>
										<%=Gui.Button(Translate.Translate("OK"), "OK_OnClick();", "90")%>
									<%End If%>
								</TD>
								<TD>
									<%=Gui.Button(Translate.Translate("Annuller"), "location='ControlPanel.aspx';", "90")%></TD>
								<%If Base.HasVersion("18.2.1.0") Then%>
									<td><%=Gui.Button(Translate.Translate("Hjælp"), "" & Gui.Help("") & "", 0)%> </td>
								<%End If%>
								<TD width="2"></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TD>
		<TR>
	</FORM>
</TABLE>

<%
Translate.GetEditOnlineScript()
%>
