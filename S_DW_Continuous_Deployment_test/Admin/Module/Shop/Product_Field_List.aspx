<%@ Page Language="vb" AutoEventWireup="false" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<script language="VB" runat="Server">
Dim ID As Integer
Dim i As Byte
Dim sql As String
Dim blnHasRows As Boolean
Dim intRowCount As Integer
Dim DW_SHOP_MAX_CUSTOMFIELDS As Integer
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			23-09-2002
'	Last modfied:		23-09-2002
'
'	Purpose: List fields
'
'	Revision history:
'		1.0 - 23-09-2002 - Nicolai Pedersen
'		First version.
'
'**************************************************************************************************

DW_SHOP_MAX_CUSTOMFIELDS = 100

If Not IsNothing(request.QueryString("ID")) Then
	ID = request.QueryString("ID")
Else
	ID = 0
End If

Dim ShopConn As IDbConnection = Database.CreateConnection("DWShop.mdb")
Dim cmdShop As IDbCommand = ShopConn.CreateCommand
Dim drProductFieldCountReader As IDataReader 

%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html;charset=UTF-8">
<TITLE></TITLE>
<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
</HEAD>
<%If Base.HasVersion("18.5.1.0") Then%>
	<%=Gui.MakeHeaders(Translate.Translate("Brugerdefinerede produkt felter"), Translate.Translate("Generelle") & "," & Translate.Translate("Gruppespecifikke"), "all")%>
<%Else%>
	<%=Gui.MakeHeaders(Translate.Translate("Brugerdefinerede produkt felter"), Translate.Translate("Generelle"), "all")%>
<%End If%>
<table border="0" cellpadding="0" cellspacing="0" class=tabTable>
	<tr>
		<td valign=top>
			<div ID="Tab1" STYLE="display:;width:598;">
			<table border="0" cellpadding="0" width="598">
			<%
			sql = "SELECT ShopProductField.*, ShopProductFieldType.ShopProductFieldTypeName FROM ShopProductFieldType RIGHT JOIN ShopProductField ON ShopProductFieldType.ShopProductFieldTypeID = ShopProductField.ShopProductFieldTypeID  WHERE ShopProductField.ShopProductFieldGroupID = 0 ORDER BY ShopProductField.ShopProductFieldSort, ShopProductField.ShopProductFieldID"
			cmdShop.CommandText = sql

			drProductFieldCountReader = cmdShop.ExecuteReader()
			intRowCount = 0
			Do While drProductFieldCountReader.Read
				intRowCount = intRowCount + 1
			Loop

			drProductFieldCountReader.Dispose



			sql = "SELECT ShopProductField.*, ShopProductFieldType.ShopProductFieldTypeName FROM ShopProductFieldType RIGHT JOIN ShopProductField ON ShopProductFieldType.ShopProductFieldTypeID = ShopProductField.ShopProductFieldTypeID  WHERE ShopProductField.ShopProductFieldGroupID = 0 ORDER BY ShopProductField.ShopProductFieldSort, ShopProductField.ShopProductFieldID"

			cmdShop.CommandText = sql

			Dim drProductReader As IDataReader = cmdShop.ExecuteReader()

			Dim opShopProductFieldLocked As Integer = drProductReader.getordinal("ShopProductFieldLocked")
			Dim opShopProductFieldTemplateName As Integer = drProductReader.getordinal("ShopProductFieldTemplateName")
			Dim opShopProductFieldTypeName As Integer = drProductReader.getordinal("ShopProductFieldTypeName")
			Dim opShopProductFieldName As Integer = drProductReader.getordinal("ShopProductFieldName")
			Dim opShopProductFieldID As Integer = drProductReader.getordinal("ShopProductFieldID")

			i = 0
			blnHasRows = False
			
			Do While drProductReader.Read
				i = i + 1
				If i = 1 Then
					%>
					<tr><br>
						<td><img src="../../../images/Nothing.gif" width="15" height="1" alt="" border="0"> <strong><%=Translate.Translate("Feltnavn")%></strong></td>
						<td width="140"><strong><%=Translate.Translate("Templatetag")%></strong></td>
						<td width="140"><strong><%=Translate.Translate("Felttype")%></strong></td>
						<td width="40"><strong><%=Translate.Translate("Sorter")%></strong></td>
						<td width=30 align="right"><strong><%=Translate.Translate("Slet")%></strong></td>
					</tr>
					<%	
				End If

				If drProductReader(opShopProductFieldLocked) And Session("DW_Admin_UserID") > 2 Then
					%>
					<TR>
						<td><img src="../../images/icons/Module_Form_small.gif" border="0" align=absmiddle>&nbsp;<%=drProductReader(opShopProductFieldName)%></td>
						<td><%=drProductReader(opShopProductFieldTemplateName)%></td>
						<td><%=Translate.Translate(drProductReader(opShopProductFieldTypeName))%></td>
						<%If i = 1 And i = intRowCount Then%>
							<td align="center"></td>
						<%ElseIf i = 1 Then %>
							<td align="center"><img src="/Admin/images/nothing.gif" width="15" border="0"><a href="Product_Field_Sort.aspx?FieldID=<%=drProductReader(opShopProductFieldID)%>&MoveDirection=down"><img src="/Admin/images/pilned.gif" alt="<%=Translate.JsTranslate("Flyt ned")%>" border="0"></a></td>
						<%ElseIf i = intRowCount Then %>
							<td align="center"><a href="Product_Field_Sort.aspx?FieldID=<%=drProductReader(opShopProductFieldID)%>&MoveDirection=up"><img src="/Admin/images/pilop.gif" alt="<%=Translate.JsTranslate("Flyt op")%>" border="0"></a><img src="/Admin/images/nothing.gif" width="15" border="0"></td>
						<%Else%>
							<td align="center"><a href="Product_Field_Sort.aspx?FieldID=<%=drProductReader(opShopProductFieldID)%>&MoveDirection=up"><img src="/Admin/images/pilop.gif" alt="<%=Translate.JsTranslate("Flyt op")%>" border="0"></a><a href="Product_Field_Sort.aspx?FieldID=<%=drProductReader(opShopProductFieldID)%>&MoveDirection=down"><img src="/Admin/images/pilned.gif" alt="<%=Translate.JsTranslate("Flyt ned")%>" border="0"></a></td>
						<%End If%>
						<td align="center"></td>
					</TR>
				<%			
				Else
				%>
					<TR>
						<td><a href="Product_Field_Edit.aspx?ID=<%=drProductReader(opShopProductFieldID)%>"><img src="../../images/icons/Module_Form_small.gif" border="0" align=absmiddle>&nbsp;<%=drProductReader(opShopProductFieldName)%></a></td>
						<td><%=drProductReader(opShopProductFieldTemplateName)%></td>
						<td><%=Translate.Translate(drProductReader(opShopProductFieldTypeName))%></td>
						<%If i = 1 And i = intRowCount Then%>
							<td align="center"></td>
						<%ElseIf i = 1 Then %>
							<td align="center"><img src="/Admin/images/nothing.gif" width="15" border="0"><a href="Product_Field_Sort.aspx?FieldID=<%=drProductReader(opShopProductFieldID)%>&MoveDirection=down"><img src="/Admin/images/pilned.gif" alt="<%=Translate.JsTranslate("Flyt ned")%>" border="0"></a></td>
						<%ElseIf i = intRowCount Then %>
							<td align="center"><a href="Product_Field_Sort.aspx?FieldID=<%=drProductReader(opShopProductFieldID)%>&MoveDirection=up"><img src="/Admin/images/pilop.gif" alt="<%=Translate.JsTranslate("Flyt op")%>" border="0"></a><img src="/Admin/images/nothing.gif" width="15" border="0"></td>
						<%Else%>
							<td align="center"><a href="Product_Field_Sort.aspx?FieldID=<%=drProductReader(opShopProductFieldID)%>&MoveDirection=up"><img src="/Admin/images/pilop.gif" alt="<%=Translate.JsTranslate("Flyt op")%>" border="0"></a><a href="Product_Field_Sort.aspx?FieldID=<%=drProductReader(opShopProductFieldID)%>&MoveDirection=down"><img src="/Admin/images/pilned.gif" alt="<%=Translate.JsTranslate("Flyt ned")%>" border="0"></a></td>
						<%End If%>
						<td align="center"><a href="javascript:if(confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("felt")) & "\n(" & Base.JSEnable(Server.HtmlEncode(drProductReader(opShopProductFieldName))) &")"%>')){location='Product_Field_Delete.aspx?ID=<%=drProductReader(opShopProductFieldID)%>';}"><img src="../../images/Delete.gif" border="0" alt="<%=Translate.JSTranslate("Slet felt")%>"></a></td>
					</TR>
				<%End If%>
					<tr>
						<td colspan="5" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
					</tr>
				<%
				blnHasRows = True
			Loop

			drProductReader.Dispose

			If Not blnHasRows Then 'There are no fields
			%>
				<tr><br>
					<td><br><strong><br>&nbsp;<%=Translate.Translate("Ingen vare felter")%></strong></td>
				</tr>
			<%End If%>					

				<tr align="right"> 
					<td colspan="5" align="right">
						<%If (Not CShort(i) >= DW_SHOP_MAX_CUSTOMFIELDS) Or LCase(Base.GetGs("/Globalsettings/System/Database/Type")) = "ms_sqlserver" Then%>
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td colspan="6"><br></td>
							</tr>
							<tr>
								<td align="right"><%=Gui.Button(Translate.Translate("Nyt felt"), "location='Product_Field_edit.aspx';", 0)%></td>
								<td width="10"></td>
							</tr>
							<tr>
								<td colspan="4" height="5"></td>
							</tr>			
						</table>
						<%End If%>
					</td>
				</tr>
			</TABLE>
			</div>
		</td>
	</tr>
<%If Base.HasVersion("18.5.1.0") Then%>
	<tr valign="top">
		<td valign="top">
		<div ID="Tab2" STYLE="display: None;">
			<table align="top" border="0" cellpadding="0" width="598">
				<%	
				sql = "SELECT ShopProductFieldGroup.ShopProductFieldGroupID, ShopProductFieldGroup.ShopProductFieldGroupName, ShopProductFieldGroup.ShopProductFieldGroupTag, " & "	(SELECT COUNT(ShopProductFieldID) As cntProductField FROM ShopProductField WHERE ShopProductField.ShopProductFieldGroupID = ShopProductFieldGroup.ShopProductFieldGroupID) AS NumberOfFields " & "	FROM ShopProductFieldGroup " & " ORDER BY ShopProductFieldGroup.ShopProductFieldGroupSort"

				cmdShop.CommandText = sql

				drProductFieldCountReader = cmdShop.ExecuteReader()
				intRowCount = 0
				Do While drProductFieldCountReader.Read
					intRowCount = intRowCount + 1
				Loop

				drProductFieldCountReader.Dispose
				



				sql = "SELECT ShopProductFieldGroup.ShopProductFieldGroupID, ShopProductFieldGroup.ShopProductFieldGroupName, ShopProductFieldGroup.ShopProductFieldGroupTag, " & "	(SELECT COUNT(ShopProductFieldID) As cntProductField FROM ShopProductField WHERE ShopProductField.ShopProductFieldGroupID = ShopProductFieldGroup.ShopProductFieldGroupID) AS NumberOfFields " & "	FROM ShopProductFieldGroup " & " ORDER BY ShopProductFieldGroup.ShopProductFieldGroupName"

				cmdShop.CommandText = sql

				Dim drProductFieldReader As IDataReader = cmdShop.ExecuteReader()

				Dim opShopProductFieldGroupID As Integer = drProductFieldReader.getordinal("ShopProductFieldGroupID")
				Dim opShopProductFieldGroupTag As Integer = drProductFieldReader.getordinal("ShopProductFieldGroupTag")
				Dim opNumberOfFields As Integer = drProductFieldReader.getordinal("NumberOfFields")
				Dim opShopProductFieldGroupName As Integer = drProductFieldReader.getordinal("ShopProductFieldGroupName")

				i = 0
				blnHasRows = False
				
				Do While drProductFieldReader.Read   'Then we list the fields
					i = i + 1%>

					<%If i = 1 Then%>
						<tr align="top"><br>
							<td align="top">
								<img src="/Admin/images/Nothing.gif" width="15" height="1" alt="" border="0"> 
								<strong><%=Translate.Translate("Gruppenavn")%></strong>
							</td>
							<td width="140"><strong><%=Translate.Translate("Templatetag")%></strong></td>
							<td width="75"><strong><%=Translate.Translate("Antal felter")%></strong></td>
							<td width="25"></td>
							<td width="30" align="right"><strong><%=Translate.Translate("Slet")%></strong></td>
						</tr>
					<%End If%>

					<TR valign="top">
						<td valign="top" style="Cursor: Pointer;" onclick="location='Product_Field_Group_Edit.aspx?GroupID=<%=drProductFieldReader(opShopProductFieldGroupID)%>'"><img src="../../images/icons/Module_Form_small.gif" border="0" align=absmiddle>&nbsp;<%=drProductFieldReader(opShopProductFieldGroupName)%></td>
						<td style="Cursor: Pointer;" onclick="location='Product_Field_Group_Edit.aspx?GroupID=<%=drProductFieldReader(opShopProductFieldGroupID)%>'"><%=drProductFieldReader(opShopProductFieldGroupTag)%></td>
						<td align="center" style="Cursor: Pointer;" onclick="location='Product_Field_Group_Edit.aspx?GroupID=<%=drProductFieldReader(opShopProductFieldGroupID)%>'"><%=drProductFieldReader(opNumberOfFields)%></td>
						<td align="center"></td>
						<td align="center"><a href="javascript:if(confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("gruppe")) & "\n(" & Base.JSEnable(Server.HtmlEncode(drProductFieldReader(opShopProductFieldGroupName))) &")"%>')){location='Product_Field_Group_Delete.aspx?GroupID=<%=drProductFieldReader(opShopProductFieldGroupID)%>';}"><img src="/Admin/images/Delete.gif" border="0" alt="<%=Translate.JSTranslate("Slet gruppe")%>"></a></td>
					</TR>
					<tr>
						<td colspan="5" bgcolor="#C4C4C4"><img src="/Admin/images/nothing.gif" width=1 height=1 alt="" border="0"></td>
					</tr>
					<%			
					blnHasRows = True
				Loop 

				drProductFieldReader.Dispose
				cmdShop.Dispose
				ShopConn.Dispose

				If Not blnHasRows Then 'There are no fields
					%>
					<tr align="top"><br>
						<td align="top"><strong><br>&nbsp;<%=Translate.Translate("Ingen feltgruppe")%></strong></td>
					</tr>
					<%		
				End If
				%>
				<tr align="right"> 
					<td colspan="5" align="right">
						<%If (Not CShort(i) >= DW_SHOP_MAX_CUSTOMFIELDS) Or LCase(Base.GetGs("/Globalsettings/System/Database/Type")) = "ms_sqlserver" Then%>
							<table cellpadding="0" cellspacing="0">
								<tr>
									<td colspan="6"><br></td>
								</tr>
								<tr>
									<td align="right"><%=Gui.Button(Translate.Translate("Ny gruppe"), "location='Product_Field_Group_edit.aspx';", 0)%></td>
									<td width="10"></td>
								</tr>
								<tr>
									<td colspan="4" height="5"></td>
								</tr>
							</table>
						<%End If%>
					</td>
				</tr>
			</TABLE>
		</div>	
<%End If%>
		</td>
	</tr>
</table>
</HTML>
<%=Gui.SelectTab()%>
<% ' BBR 01/2005
	Translate.GetEditOnlineScript()
%>