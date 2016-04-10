<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CategoryEdit.aspx.vb" Inherits="Dynamicweb.Admin.CategoryEdit" codePage="65001" %>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<HTML>
	<HEAD>
		<META http-equiv="Content-Type" content="text/html; charset=utf-8">
		<%Response.Expires = -100%>
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		<script src="/Admin/Module/Common/Validation.js" type="text/javascript"></script>
        <script type="text/javascript">function html() { return true; }</script>
		<script language="javascript">
			function del(ID, eTitle){
				if(confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("begivenhed"))%>\n(' + eTitle + ')')){
					location = "CategoryEdit.aspx?CalendarCategoryID=<%=Request.QueryString("CalendarCategoryID")%>" + "&CalendarEventID=" + ID + "&Action=Delete";
				}
			}
			
			function ValidateThisForm()
			{
				var form = document.forms[0];
				var controlToValidate = form.elements["Name"];
				ValidateForm(form, controlToValidate,
					"<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Navn"))%>",
					function(){html();});
			}
			
		</script>
		<%If Not (IsBooking() And Request.QueryString("CalendarCategoryID") <> "") Then%>
			<%=Gui.MakeHeaders(Translate.JSTranslate("%m% - Rediger %c%","%m%",Translate.JSTranslate("Aktivitetskalender V2",9),"%c%",Translate.JSTranslate("kategori")), Translate.JSTranslate("Kategori"), "Javascript", false, "")%>
		<%else%>
			<%=Gui.MakeHeaders(Translate.JSTranslate("%m% - Rediger %c%","%m%",Translate.JSTranslate("Aktivitetskalender V2",9),"%c%",Translate.JSTranslate("kategori")), Translate.JSTranslate("Kategori") & "," & Translate.JSTranslate("Reservation") & "," & Translate.JSTranslate("Available Times") & "," & Translate.JSTranslate("Booking"), "Javascript", false, "")%>
		<%end if%>
	</HEAD>
	<body>
		<%If Not (IsBooking() And Request.QueryString("CalendarCategoryID") <> "") Then%>
			<%=Gui.MakeHeaders(Translate.Translate("%m% - Rediger %c%","%m%",Translate.Translate("Aktivitetskalender V2",9),"%c%",Translate.Translate("kategori")), Translate.Translate("Kategori"), "Html", false, "")%>
		<%else%>
			<%=Gui.MakeHeaders(Translate.Translate("%m% - Rediger %c%","%m%",Translate.Translate("Aktivitetskalender V2",9),"%c%",Translate.Translate("kategori")), Translate.Translate("Kategori") & "," & Translate.JSTranslate("Reservation") & "," & Translate.JSTranslate("Available Times") & "," & Translate.JSTranslate("Booking"), "Html", false, "")%>
		<%end if%>
		<div ID="Tab1" STYLE="display:;">
		<table border="0" cellpadding="0" cellspacing="0" class="tabTable" height="100%">
			<form action="CategorySave.aspx" method="post">
				<input type="hidden" name="_ID" id="_ID" runat="server">
				<TBODY>
					<tr>
						<td valign="top">
							<br>
							<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
							<table>
								<tr>
									<td width="170"><%=Translate.Translate("Navn")%></td>
									<td><input type="text" name="Name" id="Name" class="std" maxlength="255" runat="server" /></td>
								</tr>
								<tr>
									<td><%=Translate.Translate("Billede")%></td>
									<td><%= Gui.FileManager(CategoryImage(), Dynamicweb.Content.Management.Installation.ImagesFolderName , "CalendarCategoryImage")%></td>
								</tr>
								<%If False and Base.HasVersion("19.13.1.0")Then%>
								<tr>
									<td width="170"><%=Translate.Translate("Type")%></td>
									<td><asp:literal id="CategoryReservation" runat="server"></asp:literal></td>
								</tr>
								<%End If%>
							</table>
							<%=Gui.GroupBoxEnd%>
							<%=Gui.GroupBoxStart(Translate.Translate("Beskrivelse"))%>
							<table border="0" cellpadding="0" width="100%">
								<tr>
									<td>&nbsp;<%= Gui.Editor("CalendarCategoryDescription", 0, 0, CategoryDescription())%></td>
								</tr>
							</table>
							<%=Gui.GroupBoxEnd%>
						</td>
					</tr>
			<%If Request.QueryString("CalendarCategoryID") <> "" And Not IsBooking() Then%>
			<tr>
				<td valign="top" height="100%">
					<%=Gui.GroupBoxStart(Translate.Translate("Begivenheder"))%>
					<table cellpadding="0" cellspacing="0">
						<tr>
							<td width="210">&nbsp;
							    <a id="sortByTitle" style="FONT-WEIGHT: bold; COLOR: black; TEXT-DECORATION: none" href='CategoryEdit.aspx?CalendarCategoryID=<%=_ID.Value %>&sort=<%=SortByTitle()  %>&direction=<%=GetNextSortDirectionByTitle() %>'>
							        <%=Translate.Translate("Begivenhed")%>
							        <%= GetSortImageByTitle()%>
							    </a>
							</td>
							<td width="60" align="center">
							    <a id="A3" styl e="FONT-WEIGHT: bold; COLOR: black; TEXT-DECORATION: none" href='CategoryEdit.aspx?CalendarCategoryID=<%=_ID.Value %>&sort=<%=SortByActive()  %>&direction=<%=GetNextSortDirectionByActive() %>'>
							        <%=Translate.Translate("Aktiv")%>
							        <%= GetSortImageByActive()%>
							    </a>
							    </td>
							<td width="140">
							    <a id="A1" style="FONT-WEIGHT: bold; COLOR: black; TEXT-DECORATION: none" href='CategoryEdit.aspx?CalendarCategoryID=<%=_ID.Value %>&sort=<%=SortByDate()  %>&direction=<%=GetNextSortDirectionByDate() %>'>
							        <%=Translate.Translate("Dato")%>
							        <%= GetSortImageByDate()%>
							    </a>      
							</td>
							<td width="140">
							    <a id="A2" style="FONT-WEIGHT: bold; COLOR: black; TEXT-DECORATION: none" href='CategoryEdit.aspx?CalendarCategoryID=<%=_ID.Value %>&sort=<%=SortByModified()  %>&direction=<%=GetNextSortDirectionByModified() %>'>
							        <%=Translate.Translate("Sidst ændret")%>
							        <%= GetSortImageByModified()%>
							    </a>  
							</td>
							<td width="30" align="center"><strong><%=Translate.Translate("Slet")%></strong></td>
						</tr>
						<tr>
							<td colspan="5" bgcolor="#c4c4c4"><img src="/Admin/images/nothing.gif" width="1" height="1" alt="" border="0"></td>
						</tr>
						<asp:literal id="litEventList" runat="server" />
					</table>
					<%=Gui.GroupBoxEnd()%>
				</td>
			</tr>
			<%End If%>
			<tr>
				<td align="right" colspan="2">
					<table>
						<tr>
							<%If Request.QueryString("CalendarCategoryID") <> "" Then%>
							<td><%=Gui.Button(Translate.JSTranslate("OK"), "ValidateThisForm();", 0)%></td>
							<%Else%>
							<td><%=Gui.Button(Translate.JSTranslate("Opret"), "ValidateThisForm();", 0)%></td>
							<%End If%>
							<td><%=Gui.Button(Translate.JSTranslate("Luk"), "location = 'Calendar_List.aspx';", 0)%></td>
							<%=Gui.HelpButton("", "modules.calendar.general.list.category.edit")%>
						</tr>
					</table>
				</td>
			</tr>
			</TBODY>
			</form>
		</table>
		</div>
		<%If IsBooking() And Request.QueryString("CalendarCategoryID") <> "" Then%>
		<div ID="Tab2" STYLE="display:none;">
		<table border="0" cellpadding="0" cellspacing="0" class="tabTable" height="100%">
				<TBODY>
					<tr>
						<td valign="top">
		<iframe id="booking" src = "booking/ItemEdit.aspx?ItemID=<%=Request.QueryString("CalendarCategoryID")%>" width="100%" height="550px" style="background-color:#FFFFFF; border:0px solid #FFFFFF" border="0" frameborder="0"></iframe>
						</td>
					</tr>
				</TBODY>
		</table>
		</div>
		<div ID="Tab3" STYLE="display:none;">
		<table border="0" cellpadding="0" cellspacing="0" class="tabTable" height="100%">
				<TBODY>
					<tr>
						<td valign="top">
		<iframe id="booking" src = "booking/ItemAvailable.aspx?ItemID=<%=Request.QueryString("CalendarCategoryID")%>" width="100%" height="550px" style="background-color:#FFFFFF; border:0px solid #FFFFFF" border="0" frameborder="0"></iframe>
						</td>
					</tr>
				</TBODY>
		</table>
		</div>
		<div ID="Tab4" STYLE="display:none;">
		<table border="0" cellpadding="0" cellspacing="0" class="tabTable" height="100%">
				<TBODY>
					<tr>
						<td valign="top">
		<iframe id="booking" src = "booking/ItemExisting.aspx?ItemID=<%=Request.QueryString("CalendarCategoryID")%>" width="100%" height="800px" style="background-color:#FFFFFF; border:0px solid #FFFFFF" border="0" frameborder="0"></iframe>
						</td>
					</tr>
				</TBODY>
		</table>
		</div>
		<%end if%>
		<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
	</body>
</HTML>
