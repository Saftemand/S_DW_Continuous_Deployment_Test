<%@ Page CodeBehind="News_Module_List.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.News_Module_List" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
	

<%
Dim ActiveImage As String
Dim header As String
Dim CategoryName As Object
Dim ArchiveOrActiveLinkText As String
Dim style As Object
Dim ArchiveOrActiveLink As String
Dim CategoryID As String
Dim CheckGetStatus As Object
Dim cnDynamic As Object
Dim DWParagraphMaxLockTime As String
Dim sqlSelectArchived As String
Dim sql As String


CategoryID = request.QueryString.Item("CategoryID")

If request.QueryString.Item("source") = "frontend" Then
%>

<%	
	Response.End()
End If

Dim cnNews		As IDbConnection = Database.CreateConnection("Dynamic.mdb")
Dim cmdSelect	As IDbCommand	 = cnNews.CreateCommand
cmdSelect.CommandText = "SELECT NewsCategoryName FROM NewsCategory WHERE NewsCategoryID=" & CategoryID
Dim drNewsCat		As IDataReader	 = cmdSelect.ExecuteReader()

If drNewsCat.Read() Then
	CategoryName = drNewsCat("NewsCategoryName")
End If

drNewsCat.Close()


If request.QueryString.Item("Archive") = "yes" Then
	header = Translate.Translate("%m% kategori arkiv - %c%", "%m%", Translate.Translate("Nyheder",9))
	sqlSelectArchived = Database.SqlBool(1)
	ArchiveOrActiveLink = "News_Module_List.aspx?CategoryID=" & CategoryID & "&Archive=no"
    ArchiveOrActiveLinkText = Translate.Translate("Luk arkiv")
    tbShowArchive.OnClientClick = "NoArc();"
    tbShowArchive.Text = "Close archive"
Else
    header = Translate.Translate("%m% kategori - %c%", "%m%", Translate.Translate("Nyheder", 9))
    sqlSelectArchived = Database.SqlBool(0)
    ArchiveOrActiveLink = "News_Module_List.aspx?CategoryID=" & CategoryID & "&Archive=yes"
    ArchiveOrActiveLinkText = Translate.Translate("Vis arkiv")
    tbShowArchive.OnClientClick = "Arc();"
    tbShowArchive.Text = "Show archive"
End If



cnNews.close()
'cnNews.dispose()
cnNews = Database.CreateConnection("Dynamic.mdb")

%>
<html>
	<head>
		<title></title>
		<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css"/>
		<script type="text/javascript">
  	    function NewNews()
        {
            var catID = <%=CategoryID %>;
            window.location.href = 'News_Module_Edit.aspx?CategoryID='+catID;
        }
        function Arc()
        {
            var catID = <%=CategoryID %>;
            var arcLnk = "News_Module_List.aspx?CategoryID=" + catID + "&Archive=yes";
            window.location.href = arcLnk;
        }
        function NoArc()
        {
            var catID = <%=CategoryID %>;
            var arcLnk = "News_Module_List.aspx?CategoryID=" + catID + "&Archive=no";
            window.location.href = arcLnk;
        }
        function Edit()
        {
            var editLnk = '<%= "News_Category_Edit.aspx?CategoryName=" & Base.JSEnable(Server.UrlEncode(CategoryName)) & "&CategoryID=" & CategoryID %>';
		    window.location.href = editLnk;
        }
         function helpLink()
         {
            <%= Gui.Help("news", "modules.news.general.list")%>;
         }
        function DeleteNews(NewsID,NewsName,CategoryID){
			if (confirm("<%=Translate.Translate("Slet %%?", "%%", Translate.Translate("nyhed"))%>\n(" + NewsName +")")){
				location = "News_Module_Del.aspx?NewsID=" + NewsID + "&CategoryID=" + CategoryID;
			}
		}

		//
		// MOVE NEWS
		//
		function MoveNews(NewsID) {
			objHwnd = window.open('News_Category_List.aspx?mode=browse&newsid=' + NewsID + '&caller=MoveNews_Exec','MoveNews','width=625,height=300,scrollbars=yes, status=no,location=no');
			objHwnd.focus();
		}

		function MoveNews_Exec(NewsID, DestinationID) {
			location.href = "News_Module_Move.aspx?newsid=" + NewsID + "&destinationid=" + DestinationID;
		}

		//
		// COPY NEWS
		//
		function CopyNews(NewsID) {
			objHwnd = window.open('News_Category_List.aspx?mode=browse&newsid=' + NewsID + '&caller=CopyNews_Exec','CopyNews','width=635,height=300,scrollbars=yes,status=no,location=no');
			objHwnd.focus();
		}

		function CopyNews_Exec(NewsID, DestinationID) {
			location.href = "News_Module_Copy.aspx?newsid=" + NewsID + "&destinationid=" + DestinationID;
		}
		</script>
        <dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
	</head>
	<body style="background-color:White">
<%=Gui.MakeHeaders(Replace(header, "%c%", CategoryName), Translate.Translate("Nyheder"), "all")%>
<table border="0" cellpadding="0" cellspacing="0" class="TabTable">
	<tr style="background-color:White;width:100%;">
		<td valign="top">
			       <dw:Toolbar ID="MainToolbar" runat="server" ShowStart="true"  ShowEnd="false">
                                     <dw:ToolbarButton ID="tbStart" runat="server" OnClientClick="window.location='News_Category_List.aspx';" Image="Home" Text="Start">
                                     
                                     </dw:ToolbarButton>
                                     <dw:ToolbarButton ID="tbNewNews" runat="server" OnClientClick="NewNews();" Image="AddGear" Text="New news">
                                     </dw:ToolbarButton>
                                     <dw:ToolbarButton ID="tbShowArchive" runat="server" OnClientClick="Arc();" Image="FolderInto" Text="Show archive">
                                     </dw:ToolbarButton>
                                     <dw:ToolbarButton ID="tbEditCategory" runat="server" OnClientClick="Edit();" Image="EditDocument" Text="Edit category">
                                     </dw:ToolbarButton>
                                     
                                     <dw:ToolbarButton ID="tbHelp" runat="server" Image="Help" Text="Help" OnClientClick="helpLink();">
                                     </dw:ToolbarButton>
                    </dw:Toolbar>
			<div ID="Tab1" >
				<table border="0" cellpadding="0" width="100%">
					<tr>
						<td width="295"><strong><%=Translate.Translate("Nyhed")%></strong></td>
						<td width="35"><strong><%=Translate.Translate("Aktiv")%></strong></td>
						<td width="73" align="center"><strong><%=Translate.Translate("Dato")%></strong></td>
						<td width="75" align="center"><strong><%=Translate.Translate("Opdateret")%></strong></td>		
						<%If Base.HasVersion("18.2.1.0") Then%>
							<td width="30" align="right"><strong><%=Translate.Translate("Flyt")%></strong></td>
							<td width="30" align="right"><strong><%=Translate.Translate("Kopi")%></strong></td>
						<%End If%>
						<td width="30" align="center"><strong><%=Translate.Translate("Slet")%></strong></td>		
					</tr>
					<tr>
				      	<td colspan="8" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
				    </tr>
					<%

cmdSelect.CommandText	= " SELECT News.* " & _
						  " FROM News " & _
						  " WHERE News.NewsCategoryID =" & CategoryID & " AND  News.NewsArchive=" & sqlSelectArchived & _
						  " ORDER BY News.NewsDate DESC"
'drNews = cmdSelect.ExecuteReader()

Dim blnDrNewsHasRows As Boolean = False

Dim ds As DataSet = New DataSet
Dim da As IDbDataAdapter = Database.CreateAdapter()
da.SelectCommand = cmdSelect
da.Fill(ds)

Dim drNews As DataRow

'Dim drNews	as IDataReader		= cmdSelect.ExecuteReader()
Dim i as integer = 0 
Do While i < ds.Tables(0).Rows.Count
		drNews = ds.Tables(0).Rows(i)

		i = i + 1
	If Not blnDrNewsHasRows Then blnDrNewsHasRows = True
	If drNews("NewsActive") Then
		If Base.HasAccess("NewsEdit", "") Then
			ActiveImage = "<a href=""News_Module_List.aspx?NewsID=" & drNews("NewsID") & "&SetActiveInactive=Active&CategoryID=" & drNews("NewsCategoryID") & "&Archive=" & request.QueryString.Item("Archive") & """><img src=""../../images/Check.gif"" border=0></a>"
		Else
			ActiveImage = "<img src=""../../images/Check.gif"" border=0>"
		End If
	Else
		If Base.HasAccess("NewsEdit", "") Then
			ActiveImage = "<a href=""News_Module_List.aspx?NewsID=" & drNews("NewsID") & "&SetActiveInactive=Inactive&CategoryID=" & drNews("NewsCategoryID") & "&Archive=" & request.QueryString.Item("Archive") & """><img src=""../../images/Minus.gif"" border=0></a>"
		Else
			ActiveImage = "<img src=""../../images/Minus.gif"" border=0>"
		End If
	End If
	%>
					<tr>
						<%If Base.HasAccess("NewsEdit", "") Then
		%>		<td <%'If (LockedByUserName = "" Or Session("DW_Admin_UserID") = LockedByUserID) And (InStr(drNews("NewsHeading"), "</a>") > 1) Then Response.Write("onclick=""Javascript:self.location='News_Module_Edit.aspx?CategoryID=" & CategoryID & "&NewsID=" & drNews("NewsID") & "';""")%> >
						<%'		LockedByUserID = 0
		'LockedByUserName = ""
		'LockedStatus = CheckGetStatus(drNews("NewsID"), "News")
		'If IsArray(LockedStatus) Then
		'	If Trim(DWParagraphMaxLockTime) = "" Or Not IsNumeric(DWParagraphMaxLockTime) Then
		'		DWParagraphMaxLockTime = "30"
		'	End If
		'	LockedByTime = LockedStatus(1)
		'	If Now < DateAdd(Microsoft.VisualBasic.DateInterval.Minute, CInt(DWParagraphMaxLockTime), System.Date.FromOADate(LockedByTime)) Then
		'		LockedByUserID = LockedStatus(0)
		'		If LockedByUserID <> 0 Then
		'			LockedByUserName = AccessGetUserName(LockedByUserID)
		'		Else
		'			LockedByUserName = "Administrator"
		'		End If
		'	End If
	'	End If
	'	If LockedByUserName <> "" Then
	'		If Session("DW_Admin_UserID") = LockedByUserID Then
	
				%>				<%' <img src="../../Images/infoicon.gif" border="0" align="absmiddle" alt="<%'=Translate.Translate("Redigeres af %%","%%",LockedByUserName)">%>
						<%'			Else
				%>				<%'<img src="../../Images/Icons/Stop.gif" border="0" align="absmiddle" alt="<%'=Translate.Translate("Redigeres af %%","%%",LockedByUserName)">%>
						<%'			End If
		End If
	'	If LockedByUserName = "" Or Session("DW_Admin_UserID") = LockedByUserID Then 'Paragraph not locked. 
			%>			<a href="News_Module_Edit.aspx?CategoryID=<%=CategoryID%>&NewsID=<%=drNews("NewsID")%>">
						<%'End If%>				
						<%=drNews("NewsHeading")%>
						<%'		If LockedByUserName = "" Or Session("DW_Admin_UserID") = LockedByUserID Then 'Paragraph not locked.	%>
						</a>
						<%'End If 						</td>	%>
						<%'Else					<td>%>
						<%'=drNews("NewsHeading")%>
							</td>	
						<%'	End If	%>
					
					
						<td align="center"><%=ActiveImage%></td>
						<td align="center"><%=Dates.ShowDate(CDate(drNews("NewsDate")), Dates.Dateformat.Short, False)%></td>
						<td align="center"><%If Not isNothing(drNews("NewsUpdatedDate")) Then
						Response.Write(Dates.ShowDate(CDate(drNews("NewsUpdatedDate")), Dates.Dateformat.Short, False))
						End If%>
						</td> 
						<%If Base.HasVersion("18.2.1.0") Then%>
						<td align="center">&nbsp;<a href="JavaScript:MoveNews(<%=drNews("NewsID")%>)"><img src="../../images/icons/Page_Move.gif" border="0"<%=style%>></a></td>
						<td align="center"><a href="JavaScript:CopyNews(<%=drNews("NewsID")%>)"><img src="../../images/icons/Page_Copy.gif" border="0"<%=style%>></a></td>
						<%	End If%>
						<td align="center">
							<%If Base.HasAccess("NewsDelete", "") Then%>
							<a href="JavaScript:DeleteNews('<%=drNews("NewsID")%>','<%=Base.JSEnable(drNews("NewsHeading"))%>','<%=CategoryID%>')"><img src="../../images/Delete.gif" border="0" alt="<%=Translate.Translate("Slet %%", "%%", Translate.Translate("nyhed"))%>"></a>		
							<%	End If%>
						</td>
					</tr>
				    <tr>
				      	<td colspan="8" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
				    </tr>
					<%	
Loop 

If Not blnDrNewsHasRows Then
	%>
					<tr>
						<td colspan="8">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="8"><strong><%=Translate.Translate("Der er ikke oprettet nogen %c%", "%c%", Translate.Translate("nyheder"))%></strong></td>
					</tr>
					<%End If%>

				</table>
			</div>
		</td>
	</tr>
	<tr>
		<td align="right" valign="bottom">
			<%--<table border="0" cellpadding="0" cellspacing="0">
				<tr>
					<%If Base.HasAccess("NewsCreate", "") Then%>
					<td><%=Gui.Button(Translate.Translate("Ny nyhed"), "location='News_Module_Edit.aspx?CategoryID=" & CategoryID & "'", 0)%></td>
					<td width="5"></td>
					<%End If%>
					<td><%=Gui.Button(ArchiveOrActiveLinkText, "location='" & ArchiveOrActiveLink & "'", 0)%></td>
					<td width="5"></td>
					<%If Base.HasAccess("NewsEdit", "") Then%>
					<td>
             
                    </td>
					<td width="5"></td>
					<%End If%>
					<td><%=Gui.Button(Translate.Translate("Luk"), "location='News_Category_List.aspx'", 0)%></td>
					<%=Gui.HelpButton("news_create", "modules.news.general.list.item",,5)%>
					<td width="10"></td>
				</tr>
				<tr>
					<td colspan="4" height="5"></td>
				</tr>
			</table>--%>
		</td>
	</tr>
</table>
</body>
</html>
<%
	Translate.GetEditOnlineScript()
%>