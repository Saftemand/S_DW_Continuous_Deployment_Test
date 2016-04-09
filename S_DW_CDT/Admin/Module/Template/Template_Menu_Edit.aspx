<%@ Page CodeBehind="Template_Menu_Edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Template_Menu_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			12-02-2002
'	Last modfied:		06-04-2006
'
'	Purpose: Lists template categories
'
'	Revision history:
'		1.0 - 12-02-2002 - Michael Lykke
'		First version
'		2.0 - 06-04-2006 - Thomas F. Christensen				
'		BIG TIME UPGRADE !! :)
'**************************************************************************************************
%>
<html>
	<head>
		<title>...</title>
		<link rel="STYLESHEET" type="text/css" href="../../stylesheet.css"/>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8"/>
		
		<script type="text/javascript">


		    function setMenuState(obj) {
			if(obj.value != "2" && obj.value != "5" && obj.value != "6"){
				document.getElementById('TemplateMenuEdit').TemplateMenuThread.disabled = true;
			} else {
				document.getElementById('TemplateMenuEdit').TemplateMenuThread.disabled = false;
			}

			if(obj.value == "3" || obj.value == "4" || obj.value == "6"){
				document.getElementById('TemplateMenuEdit').ParentType[0].checked = true;
				document.getElementById('TemplateMenuEdit').ParentTypeValue.value = 1;
				document.getElementById('TemplateMenuEdit').ParentType[0].disabled = true;
				document.getElementById('TemplateMenuEdit').ParentType[1].disabled = true;
				document.all.TemplateMenuParentIDRow.style.display = "none";
				document.all.TemplateMenuStartLevelRow.style.display = "none";
				document.all.TemplateMenuStopLevelRow.style.display = "none";
				document.all.TemplateMenuDropDownStartLevelRow.style.display = "";
			} else {
				document.getElementById('TemplateMenuEdit').ParentType[0].disabled = false;
				document.getElementById('TemplateMenuEdit').ParentType[1].disabled = false;
				setParentState(document.getElementById('TemplateMenuEdit').ParentType);
			}

			if (obj.value == "5" || obj.value == "6") {
			    document.getElementById("PreviewXMLOutput").style.display = "";
				document.all.TemplateMenuXSLTTemplateRow.style.display = "";
				try {
					document.all.TemplateMenuThreadXml.style.display = "";
					document.all.TemplateMenuThreadNormal.style.display = "none";
				} catch (e) { 
					//Nothing
				} 			
				disableFoldoutType(false, true);
			} else{
    			document.getElementById("PreviewXMLOutput").style.display = "none";
				document.all.TemplateMenuXSLTTemplateRow.style.display = "none";
				try {
					document.all.TemplateMenuThreadXml.style.display = "none";
					document.all.TemplateMenuThreadNormal.style.display = "";
				} catch (e) { 
					//Nothing
				} 				
				disableFoldoutType(true, false);	
			}

if (obj.value == "6") {
                document.getElementById('TemplateMenuEdit').TemplateMenuThread[0].disabled = true;
                document.getElementById('TemplateMenuEdit').TemplateMenuThread[1].disabled = true;
                document.getElementById('TemplateMenuEdit').TemplateMenuThread[2].disabled = true;
                document.getElementById('TemplateMenuEdit').TemplateMenuThread[3].disabled = true;
                document.getElementById("TemplateMenuEcomSettingSelector").style.display = "";		
				document.getElementById("TemplateMenuEcomSettingShop").style.display = "";				
				document.getElementById("TemplateMenuEcomSettingGroup").style.display = "";		
				document.getElementById("TemplateMenuEcomSettingMaxLevel").style.display = "";		
				document.getElementById("TemplateMenuEcomSettingProductPage").style.display = "";		

				document.getElementById("TemplateMenuDropDownStartLevelRow").style.display = "none";		
				
                document.getElementById("TemplateMenuThreadXml").disabled = true;									
                document.getElementById("TemplateMenuThreadParentTxt").disabled = true;				
									
				setEcomTreeType(document.getElementById('TemplateMenuEdit').EcomTreeTypeValue);
			} else {
				document.getElementById("TemplateMenuEcomSettingSelector").style.display = "none";		
				document.getElementById("TemplateMenuEcomSettingShop").style.display = "none";				
				document.getElementById("TemplateMenuEcomSettingGroup").style.display = "none";		
				document.getElementById("TemplateMenuEcomSettingMaxLevel").style.display = "none";	
				document.getElementById("TemplateMenuEcomSettingProductPage").style.display = "none";	
				
                document.getElementById("TemplateMenuThreadXml").disabled = false;									
                document.getElementById("TemplateMenuThreadParentTxt").disabled = false;							
			}

		}
		
		function disableFoldoutType(xmlBool, otherBool) {
			document.getElementById("TemplateMenuThread0").disabled = xmlBool;		
			document.getElementById("TemplateMenuThread1").disabled = xmlBool;		
			document.getElementById("TemplateMenuThread2").disabled = xmlBool;		
			document.getElementById("TemplateMenuThread3").disabled = xmlBool;		
			document.getElementById("TemplateMenuThreadNormal").disabled = otherBool;		
		}

		function setParentState(obj){
			//alert(obj[1].checked)
			//alert(obj.length);
			if(obj.length == 2){
				if(obj[0].checked){
					obj = obj[0];
				} else {
					obj = obj[1];
				}
			}
			
			if(obj.value != "2"){ //Dynamic
				document.all.TemplateMenuParentIDRow.style.display = "none";
				document.getElementById('TemplateMenuEdit').TemplateMenuParentID.value = "";
				document.getElementById('TemplateMenuEdit').Link_TemplateMenuParentID.value = "";
				document.all.TemplateMenuStartLevelRow.style.display = "";
				document.all.TemplateMenuStopLevelRow.style.display = "";
				document.all.TemplateMenuDropDownStartLevelRow.style.display = "none";
				document.getElementById('TemplateMenuEdit').ParentTypeValue.value = 1;
			} else { //Static
				document.all.TemplateMenuParentIDRow.style.display = "";

				if(ReturnSelectedValue(document.getElementById('TemplateMenuEdit').TemplateMenuType) == 5){
					document.all.TemplateMenuStartLevelRow.style.display = "";
					document.all.TemplateMenuStopLevelRow.style.display = "";
				} else {
					document.all.TemplateMenuStartLevelRow.style.display = "none";
					document.all.TemplateMenuStopLevelRow.style.display = "none";
				}
				
				document.all.TemplateMenuDropDownStartLevelRow.style.display = "none";
				document.getElementById('TemplateMenuEdit').ParentTypeValue.value = 2;
			}
		}

		function setEcomTreeType(obj){
						
			if(obj.length == 2){
				if(obj[0].checked){
					obj = obj[0];
				}
				else{
					obj = obj[1];
				}
			}
			if (obj.value == "0") {
				document.getElementById("TemplateMenuEcomSettingShop").style.display = "";				
				document.getElementById("TemplateMenuEcomSettingGroup").style.display = "none";		
				document.getElementById('TemplateMenuEdit').EcomTreeTypeValue.value = 0;
			} else { //Static
				document.getElementById("TemplateMenuEcomSettingShop").style.display = "none";				
				document.getElementById("TemplateMenuEcomSettingGroup").style.display = "";		
				document.getElementById('TemplateMenuEdit').EcomTreeTypeValue.value = 1;
			}
		}

		function ReturnSelectedObj(obj) {
			for (i=0; i < obj.length; i++) {
				if (obj[i].checked) {
					setMenuState(obj[i]);
				}
			}
		}

		function ReturnSelectedValue(obj) {
			for (i=0; i < obj.length; i++) {
				if (obj[i].checked) {
					return obj[i].value;
				}
			}
		}

		function checkForm() {
			var obj_targetForm = document.getElementById('TemplateMenuEdit');
			
			if(obj_targetForm.TemplateMenuName.value==''){
				alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>');
				obj_targetForm.TemplateMenuName.focus();
				return false;
			}
			
			if(obj_targetForm.ParentType[1].checked && obj_targetForm.TemplateMenuParentID.value == ''){
						alert('<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JSTranslate("Underpunkter til side"))%>');
				obj_targetForm.Link_TemplateMenuParentID.focus();
				return false;
			}
			if (parseInt(obj_targetForm.TemplateMenuStartLevel.value) > parseInt(obj_targetForm.TemplateMenuStopLevel.value)) {
				alert('<%=Translate.JSTranslate("´%f%´ må ikke være større end ´%t%´!", "%f%", Translate.JSTranslate("Første niveau"), "%t%", Translate.JSTranslate("Sidste niveau"))%>');
				return false;
			}
			obj_targetForm.submit();
		}
				
		function AddEcomGroup(fieldID, fieldName) {
            var caller = "opener.document.getElementById('TemplateMenuEdit')."+ fieldID;
			var caller2 = "opener.document.getElementById('TemplateMenuEdit')."+ fieldName;
			var groupTreeWin = window.open("/admin/Module/eCom_Catalog/dw7/edit/EcomGroupTree.aspx?CMD=ShowGroup&AppendType=GetGroupID&caller="+ caller +"&caller2="+ caller2,"","displayWindow,width=460,height=400,scrollbars=no");
		}

		function ClearEcomGroup(fieldID, fieldName) {
			var caller = eval("document.getElementById('TemplateMenuEdit')."+ fieldID);
			var caller2 = eval("document.getElementById('TemplateMenuEdit')."+ fieldName);
			
			caller.value = "";
			caller2.value = "";
		}

		</script>
	</head>
	
	<body onload="ReturnSelectedObj(document.getElementById('TemplateMenuEdit').TemplateMenuType);">
		<%=Gui.MakeHeaders(Translate.Translate("Rediger %%", "%%", Translate.Translate("menu")), Translate.Translate("Menu"), "all")%>
		<table BORDER="0" CELLPADDING="0" CELLSPACING="0" CLASS="TabTable">
			<tr>
				<td VALIGN="TOP">
					<br/>
					<div id="Tab1" STYLE="DISPLAY:">
						<table WIDTH="100%" CELLPADDING="0" cellspacing=0 border=0>
							<form NAME="TemplateMenuEdit" id="TemplateMenuEdit" ACTION="Template_Menu_Save.aspx" METHOD="POST">
								<input TYPE="HIDDEN" NAME="TemplateID" VALUE="<%=TemplateID%>"> <input TYPE="HIDDEN" NAME="TemplateCategoryID" VALUE="<%=TemplateCategoryID%>">
								<input TYPE="HIDDEN" NAME="TemplateMenuID" VALUE="<%=TemplateMenuID%>"> <input TYPE="HIDDEN" NAME="Opener" VALUE="<%=Request.QueryString.Item("Opener")%>">
								<tr>
									<td>
										<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
										<table width="100%">
											<tr>
												<td width="170"><%=Translate.Translate("Navn")%></td>
												<td><input TYPE="TEXT" NAME="TemplateMenuName" VALUE="<%=Server.HtmlEncode(TemplateMenuName)%>" MAXLENGTH="255" CLASS="Std"></td>
											</tr>
											<tr>
												<td valign="top"><%=Translate.Translate("Type")%></td>
												<td><asp:Literal id="MenuTypeList" runat="server"></asp:Literal></td>
											</tr>

											<tr>
												<td valign="top" colspan=2><hr size=1 color=#f0f0f0></td>
											</tr>
											<!-- XML navigation -->
											<tr><td><img src="/x.gif" width="1" height="5"></td></tr>
											<tr id="TemplateMenuThreadXml">
												<td valign="top"><%=Translate.Translate("Fold ud")%></td>
												<td>
												<%=gui.RadioButton(TemplateMenuThread, "TemplateMenuThread", "0")%><label id="TemplateMenuThread0"><%=Translate.Translate("Ingen")%></label><br />
												<%=gui.RadioButton(TemplateMenuThread, "TemplateMenuThread", "1")%><label id="TemplateMenuThread1"><%=Translate.Translate("Standard")%></label><br />
												<%=gui.RadioButton(TemplateMenuThread, "TemplateMenuThread", "2")%><label id="TemplateMenuThread2"><%=Translate.Translate("Udvid alle")%></label><br />
												<%=gui.RadioButton(TemplateMenuThread, "TemplateMenuThread", "3")%><label id="TemplateMenuThread3"><%=Translate.Translate("Udvid aktiv sti")%></label><br />
												</td>
											</tr>
											<!-- Normal navigation -->
											<tr id="TemplateMenuThreadNormal">
												<td><%=Translate.Translate("Fold ud")%></td>
												<td><%=Gui.CheckBox(TemplateMenuThread, "TemplateMenuThread")%></td>
											</tr>
											<tr>
												<td valign="top" id="TemplateMenuThreadParentTxt"><%=Translate.Translate("Overmenu")%></td>
												<td>
													<%
														If TemplateMenuParentID = "0" Or TemplateMenuParentID = "" Or isNothing(TemplateMenuParentID) Then 'Dynamisk
															intParent = 1
															TemplateMenuParentIDStyle = " Style=""display:none;"""
														Else
															'Statisk
															intParent = 2
															TemplateMenuStartLevelStyle = " Style=""display:none;"""
															TemplateMenuStopLevelStyle = " Style=""display:none;"""
															TemplateMenuDropDownStartLevelStyle = " Style=""display:none;"""
														End If
														Dim TemplateMenuXSLTTemplateStyle As String
														If base.ChkNumber(TemplateMenuType) <> 5 Then
															'TemplateMenuXSLTTemplateStyle = " style=""display:none;"""
														End If

														ParentTypes = New Integer(){1, 2}
														ParentTypeNames = New String(){Translate.Translate("Dynamisk"), Translate.Translate("Statisk")}
														For i = 0 To UBound(ParentTypes)
															If i > 4 And Not Base.HasVersion("18.10.1.0") Then
																Exit For
															End If
															sel = ""
															If intParent = ParentTypes(i) Then
																sel = " Checked"
																ParentType = ParentTypes(i)
															End If
															Response.Write("<input type=radio name=""ParentType"" value=""" & ParentTypes(i) & """" & sel & " onClick=""setParentState(this);"" ID=""ParentType" & ParentTypes(i) & """><label for=""ParentType" & ParentTypes(i) & """>" & ParentTypeNames(i) & "</label><br>" & vbCrLf)
														Next i
													%>
													<input TYPE="hidden" NAME="ParentTypeValue" VALUE="<%=ParentType%>">
												</td>
											</tr>
											<tr ID="TemplateMenuDropDownStartLevelRow"<%=TemplateMenuDropDownStartLevelStyle%>>
												<td><%=Translate.Translate("Niveau")%></td>
												<td><%=Gui.SpacListExt(TemplateMenuStartLevel, "TemplateMenuDropDownStartLevel", 1, 15, 1, "")%></td>
											</tr>
											<tr id="TemplateMenuParentIDRow"<%=TemplateMenuParentIDStyle%>>
												<td><%=Translate.Translate("Underpunkter til side")%></td>
												<td><%=Gui.LinkManager(TemplateMenuParentID, "TemplateMenuParentID", "")%></td>
											</tr>
											<tr ID="TemplateMenuStartLevelRow"<%=TemplateMenuStartLevelStyle%>>
												<td><%=Translate.Translate("Første niveau")%></td>
												<td><%=Gui.SpacListExt(TemplateMenuStartLevel, "TemplateMenuStartLevel", 1, 15, 1, "", False, 95, 999, "")%></td>
											</tr>
											<tr ID="TemplateMenuStopLevelRow"<%=TemplateMenuStopLevelStyle%>>
												<td><%=Translate.Translate("Sidste niveau")%></td>
												<td><%=Gui.SpacListExt(TemplateMenuStopLevel, "TemplateMenuStopLevel", 1, 15, 1, "", False, 95, 999, Translate.Translate("Ikke valgt"))%></td>
											</tr>
											<tr id="TemplateMenuXSLTTemplateRow"<%=TemplateMenuXSLTTemplateStyle%>>
												<td><%=Translate.Translate("XSLT")%></td>
												<td><%=Gui.Filemanager(TemplateMenuXSLTTemplate, "Templates/Navigation", "TemplateMenuXSLTTemplate", "xsl,xslt")%></td>
											</tr>
											

											<tr id="TemplateMenuEcomSettingSelector" style="display:none;">
												<%If Dynamicweb.eCommerce.Common.Functions.IsEcom Then%>
												<td valign="top"><%=Translate.Translate("Menu type")%></td>
												<td><asp:Literal id="EcomTreeTypeSelect" runat="server"></asp:Literal></td>
												<%End If%>
											</tr>
											</tr>
											<tr id="TemplateMenuEcomSettingShop" style=display:none;>
												<%If Dynamicweb.eCommerce.Common.Functions.IsEcom Then%>
												<td><%=Translate.Translate("Shop")%></td>
												<td><asp:Literal id="EcomShopBox" runat="server"></asp:Literal></td>
												<%End If%>
											</tr>
											<tr id="TemplateMenuEcomSettingGroup" style=display:none;>
												<%If Dynamicweb.eCommerce.Common.Functions.IsEcom Then%>
												<td><%=Translate.Translate("Gruppe")%></td>
												<td><asp:Literal id="EcomGroupBox" runat="server"></asp:Literal></td>
												<%End If%>
											</tr>
											<tr id="TemplateMenuEcomSettingMaxLevel" style=display:none;>
												<%If Dynamicweb.eCommerce.Common.Functions.IsEcom Then%>
												<td><%=Translate.Translate("Max niveau")%></td>
												<td><%=Gui.SpacListExt(TemplateMenuEcomMaxLevel, "EcomMaxLevel", 1, 5, 1, "", False, 120, 0, Translate.Translate("Alle niveauer"))%></td>
												<%End If%>
											</tr>
											<tr id="TemplateMenuEcomSettingProductPage" style=display:none;>
												<%If Dynamicweb.eCommerce.Common.Functions.IsEcom Then%>
												<td><%=Translate.Translate("Produktside")%></td>
												<td><dw:LinkManager runat="server" id="TemplateMenuEcomProductPage" disableparagraphselector disablefilearchive></dw:LinkManager></td>
												<%End If%>
											</tr>
										</table>
										<%=Gui.GroupBoxEnd()%>
									</td>
								</tr>
							</form>
						</table>
					</div>
				</td>
			</tr>
			<tr>
				<td valign="bottom">
					<table width="100%">
						<tr>
						    <td align="left" width="100%"><div id="PreviewXMLOutput" style="display:none;"><dw:Button ID="PreviewXMLOutputBtn" runat="server" Name="Preview XML output"
						        OnClick="window.open('/Admin/Public/GetNavigationXML.aspx', 'navigationpreview');" /></div>&nbsp;</td>
							<td><%=Gui.Button(Translate.Translate("OK"), "checkForm()", 0)%></td>
							<td><%=Gui.Button(Translate.Translate("Annuller"), "location='Template_Admin_Edit.aspx?TemplateCategoryID=" & TemplateCategoryID & "&TemplateID=" & TemplateID & "'", 0)%></td>
							<%=Gui.HelpButton("templates", "modules.template.general.page.edit.menu")%>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</body>
</html>
<%
Translate.GetEditOnlineScript()
%>
