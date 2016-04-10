<%@ Page CodeBehind="News_Category_List.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.News_Category_List" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
	
<%
Dim NumberOfArticles As String
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
        <script language="JavaScript">
	     function helpLink()
         {
            <%= Gui.Help("news", "modules.news.general.list")%>;
         }
      	function DeleteCategory(CategoryID,CategoryName){
				if (confirm('<%=Translate.JSTranslate("Slet %%?", "%%", Translate.JSTranslate("kategori"))%>\n(' + CategoryName + ')\n\n<%=Translate.JSTranslate("ADVARSEL!")%>\n<%=Translate.Translate("Alle indlæg i kategorien vil blive slettet!")%>')){
					location = "News_Category_Del.aspx?CategoryID=" + CategoryID;
				}
			}
			<%If Request.QueryString("mode") = "browse" Then%>
			function BrowseSelectCategory(CategoryID) {
				EventHandler	= eval(parent.opener.<%=Request.QueryString("caller")%>);
				NewsID			= <%=Request.QueryString("newsid")%>;

				EventHandler(NewsID, CategoryID);
				self.close();
			}
			<%End If%>
		</script>
		<title><%=Translate.JsTranslate("Kategorier")%></title>
		<link rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
	</head>
	<body style="background-color:White">
		<%=Gui.MakeHeaders(Translate.Translate("Nyheder",9), Translate.Translate("Kategorier"), "all")
%>
		
		<table border="0" cellpadding="0" cellspacing="0" class="TabTable">
			<tr style="background-color:White;">
				<td valign="top">
					           <dw:Toolbar ID="MainToolbar" runat="server" ShowStart="true"  ShowEnd="false">
                                     <dw:ToolbarButton ID="tbNewCategory" runat="server" OnClientClick="window.location.href = 'News_Category_Edit.aspx';" Image="AddDocument" Text="New category">
                                     </dw:ToolbarButton>
                                     <dw:ToolbarButton ID="tbHelp" runat="server" Image="Help" Text="Help" OnClientClick="helpLink();">
                                     </dw:ToolbarButton>
                               </dw:Toolbar>
              	<div ID="Tab1" STYLE="display:;">
					<table border="0" cellpadding="0" >
						<tr>
							<td width="425"><strong><%=Translate.Translate("Kategori")%></strong></td>
							<td width="80" align="center"><strong><%=Translate.Translate("Indlæg",1)%></strong></td>
							<%If Not Request.QueryString("mode") = "browse" Then%>
							<td width="35"><strong><%=Translate.Translate("Slet")%></strong></td>
							<%End If%>
						</tr>
					<%
					
Dim cnNews		As IDbConnection = Database.CreateConnection("Dynamic.mdb")
Dim cmdSelect	As IDbCommand	 = cnNews.CreateCommand
cmdSelect.CommandText = "Select * from NewsCategory order by NewsCategoryName"
Dim drNews		As IDataReader	 = cmdSelect.ExecuteReader()

Dim blnDrNewsHasRows as Boolean = false

Do While drNews.Read()
	If Not blnDrNewsHasRows Then blnDrNewsHasRows = True
	If Base.HasAccess("NewsCategories", drNews("NewsCategoryID")) Then
		'Finder antal nyheder i kategorien
		Dim cnNumberOfArticles	As IDbConnection	= Database.CreateConnection("Dynamic.mdb")
		Dim cmd					As IDbCommand		= cnNumberOfArticles.CreateCommand
		cmd.CommandText = " SELECT	count(News.NewsCategoryID) as NumberOfArticles " & _
						  " FROM	News " & _
						  " WHERE	News.NewsCategoryID = " & drNews("NewsCategoryID") & _
						  "			AND News.NewsArchive=" & Database.SqlBool(0)
		Dim drNumberOfArticles	As IDataReader		= cmd.ExecuteReader()
		
		If drNumberOfArticles.Read() then
			NumberOfArticles = Cint(drNumberOfArticles("NumberOfArticles"))
		Else
			NumberOfArticles = 0
		End if
		
		drNumberOfArticles.Close()
		cmd.Dispose()
		cnNumberOfArticles.Dispose()
		%>
						    <tr>
						      <td colspan="4" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
						    </tr>
							<tr>
								<td>
									<%		If Not Request.QueryString("mode") = "browse" Then%>
										<a href="News_Module_List.aspx?CategoryID=<%=drNews("NewsCategoryID")%>&CategoryName=<%=Server.UrlEncode(drNews("NewsCategoryName"))%>"><%=Server.HtmlEncode(drNews("NewsCategoryName"))%></a>
									<%		Else%>
										<A href="javascript:BrowseSelectCategory(<%=drNews("NewsCategoryID")%>);"><IMG src="../../images/icons/Page_MoveTo.gif" align="absmiddle" hspace="0" vspace="0" border="0"></A> <%=Server.HtmlEncode(drNews("NewsCategoryName"))%>
									<%		End If%>
								</td>
								<td align=center>
									<%=NumberOfArticles%>
								</td>
								<%		If Not Request.QueryString("mode") = "browse" Then%>
								<td>
									<%If Base.HasAccess("NewsDelete", "") Then%>
									<a href="JavaScript:DeleteCategory('<%=drNews("NewsCategoryID")%>','<%=Base.JSEnable(Server.HtmlEncode(drNews("NewsCategoryName")))%>')"><img src="../../images/Delete.gif" alt="<%=Translate.Translate("Slet %%", "%%", Translate.Translate("kategori"))%>" border=0></a>		
									<%			End If%>
								</td>
								<%		End If%>
							</tr>
							<%		
	End If
Loop
%>
					    <tr>
					      <td colspan="4" bgcolor="#C4C4C4"><img src="../../images/nothing.gif" width=1 height=1 alt="" border="0"></td>
					    </tr>
						<%If Not blnDrNewsHasRows Then%>
						<tr>
							<td colspan="4"><br /><%=Translate.Translate("Der er ikke oprettet nogen %c%", "%c%", Translate.Translate("kategorier"))%></td>
						</tr>
						<%End If%>
						<tr>
						  <td colspan="4">&nbsp;</td>
						</tr>	
					</table>	
					</div>
				</td>
			</tr>
			<tr>
				<td align="right" valign="bottom">
				</td>
			</tr>
		</table>
	</body>
</html>
<%
drNews.Dispose()
cmdSelect.Dispose()
cnNews.Dispose()

Translate.GetEditOnlineScript()
%>
