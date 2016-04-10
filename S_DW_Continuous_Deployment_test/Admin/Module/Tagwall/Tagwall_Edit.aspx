<%@ Page CodeBehind="Tagwall_Edit.aspx.vb" Language="vb" ValidateRequest="false" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Tagwall_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>


<script language="VB" runat="Server">
Dim TagwallParagraphCategoryIDList As String
Dim ParagraphID As Integer
Dim sql As String
</script>

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			12-07-2002
'	Last modfied:		12-07-2002
'
'	Purpose: File to edit items
'
'	Revision history:
'		1.0 - 12-07-2002 - Nicolai Pedersen
'		First version.
'**************************************************************************************************


If Request("ID") <> "" Then
	ParagraphID = Base.Chknumber(request("ID"))
Elseif Request("ParagraphID") <> "" Then
	ParagraphID = Base.Chknumber(request("ParagraphID"))
Else
	ParagraphID = 0
End If

Dim prop As new Properties

    If Base.ChkString(Request.QueryString("ParagraphModuleSystemName")) = "" Then 'ParagraphID > 0 Then
        prop = Base.GetParagraphModuleSettings(ParagraphID, True)
        'prop = Base.GetParagraphModuleSettings(CInt(ParagraphID), True)
    Else
        prop.Value("TagwallParagraphCategoryID") = 0
        prop.Value("TagwallParagraphShow") = 100
        prop.Value("TagwallParagraphShowDate") = 1
        prop.Value("TagwallParagraphFramecolor") = "#CCCCCC"
        prop.Value("TagwallType") = "1"
	
        prop.Value("TagwallParagraphTextDate") = Translate.Translate("Dato:")
        prop.Value("TagwallParagraphTextSender") = Translate.Translate("Afsender:")
        prop.Value("TagwallParagraphTextMessage") = Translate.Translate("Besked:")
        prop.Value("TagwallParagraphTextSendMessage") = Translate.Translate("Send indlæg")
	
        prop.Value("TagwallHeadingBackgroundcolor") = "#e1e1e1"
        prop.Value("TagwallHeadingFont") = "Verdana, Helvetica, Arial"
        prop.Value("TagwallHeadingFontSize") = "12px"
        prop.Value("TagwallHeadingFontColor") = "#000000"
        prop.Value("TagwallHeadingFontBold") = "0"
	
        prop.Value("TagwallTextBackgroundcolor") = "#f1f1f1"
        prop.Value("TagwallTextFont") = "Verdana, Helvetica, Arial"
        prop.Value("TagwallTextFontSize") = "12px"
        prop.Value("TagwallTextFontColor") = "#000000"
        prop.Value("TagwallTextFontBold") = "0"
    End If
%>
<input type="Hidden" name="Tagwall_settings" value="TagwallParagraphCategoryID, TagwallParagraphShow, TagwallParagraphShowDate, TagwallParagraphFramecolor, TagwallType, TagwallParagraphTextDate, TagwallParagraphTextSender, TagwallParagraphTextMessage, TagwallParagraphTextSendMessage, TagwallHeadingBackgroundcolor, TagwallHeadingFont, TagwallHeadingFontSize, TagwallHeadingFontColor, TagwallHeadingFontBold, TagwallTextBackgroundcolor, TagwallTextFont, TagwallTextFontSize, TagwallTextFontColor, TagwallTextFontBold">

<TR>
	<TD>
		<%=Gui.MakeModuleHeader("tagwall", "Opslagstavle")%>
	</TD>
</TR>
<tr>
	<td>
		<%=Gui.GroupBoxStart(Translate.Translate("Visning"))%>
		<table cellpadding=2 cellspacing=0 border=0>
			<tr>
				<td width=170><%=Translate.Translate("Vis antal")%></td>
				<td><input type="text" name="TagwallParagraphShow" style="width:35px;" maxlength="255" class="std" value="<%=prop.Value("TagwallParagraphShow")%>"></td>
			</tr>
			<tr>
				<td width=170><%=Translate.Translate("Vis dato")%></td>
				<td><%=Gui.CheckBox(prop.Value("TagwallParagraphShowDate"), "TagwallParagraphShowDate")%></td>
			</tr>
			<tr>
				<td width=170><%=Translate.Translate("Rammefarve")%></td>
				<td><%=Gui.ColorSelect(prop.Value("TagwallParagraphFramecolor"), "TagwallParagraphFramecolor", False)%></td>
			</tr>
			<tr>
				<td valign=top><%=Translate.Translate("Nye indlæg")%></td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td><input type="radio" name="TagwallType" id="TagwallType1" value="1"<%If prop.Value("TagwallType") = "1" Then%> checked<%End If%>></td>
							<td><label for="TagwallType1"><%=Translate.Translate("Formular under liste")%></label></td>
						</tr>
						<tr>
							<td><input type="radio" name="TagwallType" id="TagwallType2" value="2"<%If prop.Value("TagwallType") = "2" Then%> checked<%End If%>></td>
							<td><label for="TagwallType2"><%=Translate.Translate("Formular over liste")%></label></td>
						</tr>
						<tr>
							<td><input type="radio" name="TagwallType" id="TagwallType3" value="3"<%If prop.Value("TagwallType") = "3" Then%> checked<%End If%>></td>
							<td><label for="TagwallType3"><%=Translate.Translate("Ingen formular")%></label></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
	</td>
</tr>
<tr>
	<td colspan=2>
		<%=Gui.GroupBoxStart(Translate.Translate("Brugerdefinerede tekster"))%>
		<table cellpadding=2 cellspacing=0 border=0>
			<tr>
				<td width=170><%=Translate.Translate("Dato")%></td>
				<td><input type="text" name="TagwallParagraphTextDate" maxlength="255" class="std" value="<%=prop.Value("TagwallParagraphTextDate")%>"></td>
			</tr>
			<tr>
				<td width=170><%=Translate.Translate("Afsender")%></td>
				<td><input type="text" name="TagwallParagraphTextSender" maxlength="255" class="std" value="<%=prop.Value("TagwallParagraphTextSender")%>"></td>
			</tr>
			<tr>
				<td width=170><%=Translate.Translate("Besked")%></td>
				<td><input type="text" name="TagwallParagraphTextMessage" maxlength="255" class="std" value="<%=prop.Value("TagwallParagraphTextMessage")%>"></td>
			</tr>
			<tr>
				<td width=170><%=Translate.Translate("Send indlæg")%></td>
				<td><input type="text" name="TagwallParagraphTextSendMessage" maxlength="255" class="std" value="<%=prop.Value("TagwallParagraphTextSendMessage")%>"></td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
	</td>
</tr>
<tr>
	<td colspan=2>
		<%Response.Write(Gui.GroupBoxStart(Translate.Translate("Overskrift")))%>
		<table border="0" cellpadding="2" cellspacing="0">
			<tr>
				<td width=170><%=Translate.Translate("Baggrundsfarve")%></td>
				<td><%=Gui.ColorSelect(prop.Value("TagwallHeadingBackgroundcolor"), "TagwallHeadingBackgroundcolor", True)%>
			</tr>
			<tr>
				<td><%=Translate.Translate("Font")%></td>
				<td><%=Gui.FontFamilyList(prop.Value("TagwallHeadingFont"), "TagwallHeadingFont")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Fontstørrelse")%></td>
				<td><%=Gui.FontSizeList(prop.Value("TagwallHeadingFontSize"), "TagwallHeadingFontSize")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Fontfarve")%></td>
				<td><%=Gui.ColorSelect(prop.Value("TagwallHeadingFontColor"), "TagwallHeadingFontColor", True)%>
			</tr>
			<tr>
				<td><%=Translate.Translate("Fed")%></td>
				<td><%=Gui.CheckBox(prop.Value("TagwallHeadingFontBold"), "TagwallHeadingFontBold")%>
			</tr>
		</table>
		<%Response.Write(Gui.GroupBoxEnd)%>
	</td>
</tr>
<tr>
	<td colspan=2>
		<%Response.Write(Gui.GroupBoxStart(Translate.Translate("Tekst")))%>
		<table border="0" cellpadding="2" cellspacing="0">
			<tr>
				<td width=170><%=Translate.Translate("Baggrundsfarve")%></td>
				<td><%=Gui.ColorSelect(prop.Value("TagwallTextBackgroundcolor"), "TagwallTextBackgroundcolor", True)%>
			</tr>
			<tr>
				<td><%=Translate.Translate("Font")%></td>
				<td><%=Gui.FontFamilyList(prop.Value("TagwallTextFont"), "TagwallTextFont")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Fontstørrelse")%></td>
				<td><%=Gui.FontSizeList(prop.Value("TagwallTextFontSize"), "TagwallTextFontSize")%></td>
			</tr>
			<tr>
				<td><%=Translate.Translate("Fontfarve")%></td>
				<td><%=Gui.ColorSelect(prop.Value("TagwallTextFontColor"), "TagwallTextFontColor", True)%>
			</tr>
			<tr>
				<td><%=Translate.Translate("Fed")%></td>
				<td><%=Gui.CheckBox(prop.Value("TagwallTextFontBold"), "TagwallTextFontBold")%>
			</tr>
		</table>
		<%Response.Write(Gui.GroupBoxEnd)%>
	</td>
</tr>
<tr>
	<td colspan=2>
		<%=Gui.GroupBoxStart(Translate.Translate("Kategorier"))%>
		<table cellpadding=2 cellspacing=0>
			<tr>
				<td valign="top" width="170"><%=Translate.Translate("Medtag følgende kategorier")%></td>
				<td>
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td>
							<%
							TagwallParagraphCategoryIDList = "@" & Replace(prop.Value("TagwallParagraphCategoryID"), ",", "@") & "@"

							Dim drTagwall As IDatareader = Database.CreateDataReader("SELECT * FROM TagwallCategory ORDER BY TagwallCategoryName")
							Do While drTagwall.Read()
								If Base.HasAccess("TagwallCategories", drTagwall("TagwallCategoryID")) Then
									Response.Write("<input type=""checkbox"" name=""TagwallParagraphCategoryID"" id=""Tagwall" & drTagwall("TagwallCategoryID") & """ value=""" & drTagwall("TagwallCategoryID") & """")
									If InStr(TagwallParagraphCategoryIDList, "@" & drTagwall("TagwallCategoryID") & "@") Then
										Response.Write(" checked")
									End If
									'Execute "If STagwallletters" & CStr(Trim(drTagwall("TagwallCategoryID"))) & " = True Then response.Write "" checked"""
									Response.Write(">")
									Response.Write("<label for=""Tagwall" & drTagwall("TagwallCategoryID") & """><nobr>" & drTagwall("TagwallCategoryName") & "</nobr></label><br>" & vbCrLf)
								End If
							Loop 
							drTagwall.Close()
							%>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<%=Gui.GroupBoxEnd%>
	</td>
</tr>

<%
	'Cleanup

	Translate.GetEditOnlineScript()
%>