<%@ Page CodeBehind="News_Module_Edit.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.News_Module_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls.OMC" TagPrefix="omc" %>	
<%

Dim CategoryID As String
Dim NewsID As String
Dim PossibleCategories As String
Dim TemplateSql As String
Dim StrSQLTop As String
Dim NewsActive As String
Dim NewsActiveFrom As String
Dim NewsLinkPopup As Boolean
Dim NewsHeading As String
Dim NewsManchet As String
Dim NewsText As String
Dim NewsLink As String
Dim NewsDate As String
Dim NewsActiveTo As String
Dim NewsTemplateIcon As String
Dim NewsInitials As String
Dim NewsArchive As String
Dim NewsAuthor As String
Dim NewsTemplateID As String
Dim NewsSmallImage As String
Dim NewsImage As String
Dim NewsImageText as string
Dim NewsWorkflowID As Integer
Dim NewsWorkflowState As Integer
Dim NewsVersionComments As String
Dim strCategory As String
Dim LinkToArchive As String
Dim arrPossibleCategories() As String
Dim LinkManager As String
Dim strAuditData As String
Dim TemplateManager As String
Dim StrSQL As String
Dim sqlSelectNewsCat As String
Dim strHeaders As String
Dim dato as New Dates
Dim Sql As String
Dim home as String = "/Admin/"
Dim NewsApprovalState As Integer 
Dim NewsApprovalType As Integer

Dim drNews		As IDataReader

CategoryID = Base.ChkNumber(Request.QueryString.Item("CategoryID"))
If Request.Item("source") = "frontend" Then
	PossibleCategories = Request.QueryString.Item("CategoryID")
	arrPossibleCategories = Split(PossibleCategories & "", ",")
	CategoryID = arrPossibleCategories(0)
End If

NewsID = Request.QueryString.Item("NewsID")
	
If Not NewsID = "" Then
	
	strSql = "SELECT News.*, Template.TemplateID, Template.TemplateIcon FROM Template RIGHT JOIN News ON Template.TemplateID = News.NewsTemplateID WHERE NewsID = " & NewsID
	

	drNews = Database.CreateDataReader(strSql)
	drNews.Read() 
	
	NewsHeading				= drNews("NewsHeading").ToString()
	NewsManchet				= drNews("NewsManchet").ToString()
	NewsText				= drNews("NewsText").ToString()
	NewsDate				= drNews("NewsDate").ToString()
	NewsActiveFrom			= drNews("NewsActiveFrom").ToString()
	NewsActiveTo			= drNews("NewsActiveTo").ToString()
	NewsAuthor				= drNews("NewsAuthor").ToString()
	NewsInitials			= drNews("NewsInitials").ToString()
	NewsImage				= drNews("NewsImage").ToString()
	NewsImageText			= drNews("NewsImageText").ToString()
	NewsSmallImage			= drNews("NewsSmallImage").ToString()
	NewsLink				= drNews("NewsLink").ToString()
	
	If Base.ChkBoolean(drNews("NewsActive").ToString()) Then
		NewsActive				= Base.ChkChecked(-1)
	Else
		NewsActive				= Base.ChkChecked(1)	
	End If
	
	If Base.ChkBoolean(drNews("NewsArchive").ToString()) Then
		NewsArchive				= Base.ChkChecked(-1)
	Else
		NewsArchive				= Base.ChkChecked(0)
	End If
	
	NewsTemplateID			= drNews("TemplateID").ToString()
	NewsTemplateIcon		= drNews("TemplateIcon").ToString()
	'NewsVersionComments		= drNews("NewsVersionComments").ToString()
	NewsLinkPopup			= base.ChkBoolean(drNews("NewsLinkPopup").ToString())
	
	If NewsApprovalType > 0 AND NewsApprovalState = 0 Then
		NewsApprovalState = -1
	End If 
	
	If drNews("NewsArchive") = True Then
		LinkToArchive = "&Archive=yes"
	End If
	drNews.Close()
	
'Todo Brugerstyring	Call CheckOut(CInt(NewsID), "News")
Else
	NewsActive = Base.ChkChecked(True)
	NewsActiveFrom = dato.DWNow().Clone()
	
	NewsActiveTo = System.Date.FromOADate(CDate(Dates.DWNow).ToOADate + 365)
	
End If

Dim mySQL as string = ""
If Not (NewsTemplateID <> "" And NewsTemplateIcon <> "") Then
	
	
	
	If NewsTemplateID <> "" Then
		mySQL = "SELECT * FROM Template WHERE TemplateID=" & NewsTemplateID
	Else
		mySQL = "SELECT Template.TemplateID, Template.TemplateName, Template.TemplateIcon, Template.TemplateIsDefault FROM Template RIGHT JOIN News ON Template.TemplateID = News.NewsTemplateID GROUP BY Template.TemplateID, Template.TemplateName, Template.TemplateIcon, Template.TemplateIsDefault ORDER BY Count(News.NewsTemplateID) DESC "
	End If
	
	drNews = Database.CreateDataReader(mySQL)
	If drNews.Read() Then
		NewsTemplateID = drNews("TemplateID").tostring
		NewsTemplateIcon = drNews("TemplateIcon").tostring
	End If
End If

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<dw:ControlResources ID="ControlResources1" runat="server"></dw:ControlResources>
<SCRIPT language="JavaScript">
	var popupTemplateWindow;
		
	function layout(){
		LayoutWin = window.open("<%=home%>/paragraphs/Template/Template.aspx", "Template", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=600,height=400,screenX=50,screenY=50");
		LayoutWin.focus();
	}

	function show(i) {
		hideEditor();
		if (document.all[i].style.display=='none') {
			document.all[i].style.display='';
		}else{
			document.all[i].style.display='none';
		}
	}

	function DoSave() {
		if(document.NewsForm.NewsHeading.value.length < 1){
			alert("<%=Translate.JsTranslate("Der skal angives en værdi i: %%", "%%", Translate.JsTranslate("Overskrift"))%>");
			document.NewsForm.NewsHeading.focus();
			return false;
		}
		html();
		document.NewsForm.submit();
	}
	
	function OpenNewsVersion() {
		if (confirm("<%=Translate.JsTranslate("Vil du forlade denne version uden at gemme eventuelle Ã¦ndringer?")%>")) {
			location.href = "News_Module_Edit.aspx?CategoryID=<%=Request.QueryString.Item("CategoryID")%>&NewsID=" + document.NewsForm.NewsVersions.value;
		}
	}
       function helpLink()
         {
            <%= Gui.Help("news", "modules.news.general.list.item.edit")%>;
         }

         var NewsEdit = {
            Marketing: null,

            openContentRestrictionDialog: function () {
                this.Marketing.openSettings('ContentRestriction', { data: { ItemType: 'News', ItemID: document.NewsForm.NewsID.value, Type: 'Reorder' } });
            },

            openProfileDynamicsDialog: function () {
                this.Marketing.openSettings('ProfileDynamics', { data: { ItemType: 'News', ItemID: document.NewsForm.NewsID.value } });
            }
        }
</SCRIPT>
<TITLE></TITLE>
<LINK rel="STYLESHEET" type="text/css" href="../../Stylesheet.css">
<STYLE>
	.Settings{
		top:120px;
	}
</STYLE>
<%
strHeaders = Translate.Translate("Nyhed")
%>
<%=Gui.MakeHeaders(Translate.Translate("Rediger %%","%%",Translate.Translate("nyhed")), strHeaders, "all")%>
</head>
<body style="background-color:White">
<form action="News_Module_Save.aspx" method="post" name="NewsForm" id="NewsForm">
  <dw:Toolbar ID="MainToolbar" runat="server" ShowStart="true"  ShowEnd="false">
                                     <dw:ToolbarButton ID="tbSave" runat="server" OnClientClick="DoSave();" Image="SaveAndClose" Text="Save">
                                     </dw:ToolbarButton>
                                     <dw:ToolbarButton ID="tbClose" runat="server" OnClientClick="history.back(1);" Image="Cancel" Text="Close">
                                     </dw:ToolbarButton>
                                     <dw:ToolbarButton ID="tbHelp" runat="server" Image="Help" OnClientClick="helpLink();" Text="Help">
                                     </dw:ToolbarButton>
                    </dw:Toolbar>
<table border="0" cellpadding="0" cellspacing="0" class="TabTable">
	<input type="hidden" name="CategoryID" value="<%=CategoryID%>">
	<input type="hidden" name="NewsID" value="<%=NewsID%>">
	<input type="hidden" name="source" value="<%=Request.QueryString.Item("source")%>">
	<input type="hidden" name="NewsletterSubscription" value="<%=Request.Item("NewsletterSubscription")%>" ID="Audit">
	<input type="hidden" name="Audit" value="<%=Request.Item("Audit")%>" ID="Audit">
	<input type="hidden" name="AuditUserID" value="<%=Request.Item("AuditUserID")%>" ID="AuditUserID">
	<input type="hidden" name="AuditDateTimeFrom" value="<%=Request.Item("AuditDateTimeFrom")%>" ID="AuditDateTimeFrom">
	<input type="hidden" name="AuditDateTimeTo" value="<%=Request.Item("AuditDateTimeTo")%>" ID="AuditDateTimeTo">
	<input type="hidden" name="AuditType" value="<%=Request.Item("AuditType")%>" ID="AuditType">
	<input type="hidden" name="SortOrder" value="<%=Request.Item("SortOrder")%>" ID="SortOrder">
	<input type="hidden" name="SortField" value="<%=Request.Item("SortField")%>" ID="SortField">
	<tr style="background-color:White">
		<td valign="top"><br>
			<DIV id="Tab1" Class="Display:;">
			<table border="0" cellpadding="0" width="100%">
				<%
If IsArray(arrPossibleCategories) Then
	If UBound(arrPossibleCategories) > 0 Then
		%>
				<tr>
					<td colspan=2>
						<%=Gui.GroupBoxStart(Translate.Translate("Kategori"))%>
						<table cellpadding=2 cellspacing=0 width="100%" ID="Table1">
							<tr>
								<td><strong><%=Translate.Translate("VÃ¦lg nyhedskategori")%></strong><input type="hidden" id="UserCategoryDropdown" Name="UserCategoryDropdown" value="true"></td>
							</tr>
							<tr>
								<td colspan=2>
								<%		
		
		strCategory = Request.QueryString.Item("CategoryID")
		If strCategory = "" Then
			strCategory = "0"
		End If
		mySQL = "SELECT * FROM NewsCategory WHERE NewsCategoryID IN(" & strCategory & ")"
		drNews = database.CreateDataReader(mySQL)
		Response.Write("&nbsp;<SELECT class=""std"" name=""SelectCategoryID"" ID=""SelectCategoryID"">")
		
		Do While drNews.Read()
			Response.Write("<OPTION value=""" & drNews("NewsCategoryID") & """>" & drNews("NewsCategoryName") & "</OPTION>")
		Loop 
		Response.Write("</SELECT>")
		
		%><br><br>
								</td>
							</tr>
						</table>
						<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
				<%		
	End If
End If%>
				<tr>
					<td colspan=2>
						<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
						<table cellpadding=2 cellspacing=0 width="100%">
							<tr>
								<td width=170><%=Translate.Translate("Dato")%></td>	
								<td nowrap><%=dato.DateSelect(NewsDate, True, False, False, "NewsDate")%></td>
							</tr>
							<tr>
								<td width=170><%=Translate.Translate("Overskrift")%></td>	
								<td><input type="text" maxlength="255" name="NewsHeading" value="<%=Server.HtmlEncode(NewsHeading)%>" class="std" style="width: 100%;"></td>
							</tr>
							<tr>
								<td width=170 valign="top"><%=Translate.Translate("Teaser tekst")%></td>	
								<td><textarea name="NewsManchet" rows="3" class="std" style="width: 100%;"><%=NewsManchet%></textarea></td>
							</tr>
							<tr>
								<td width=170><%=Translate.Translate("Genvej")%></td>
								<td><%=Gui.LinkManager(NewsLink, "NewsLink", "")%></td>
							</tr>
							<tr>
								<td width=170><%=Translate.Translate("I nyt vindue")%></td>
								<td><%=Gui.CheckBox(NewsLinkPopup, "NewsLinkPopup")%></td>
							</tr>
						</table>
						<%=Gui.GroupBoxEnd%>
						<%=Gui.GroupBoxStart(Translate.Translate("Tekst"))%>
						<table cellpadding=2 cellspacing=0 width="100%">
							<tr>
								<td colspan=2><%=Gui.Editor("NewsText", 0, 0, NewsText)%></td>
							</tr>
						</table>
						<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
				<tr>
					<td colspan=2>
					<%			If Base.HasAccess("Stylesheet", "") Then 'Nyhed: Layout  %>
						<%=Gui.GroupBoxStart(Translate.Translate("Layout"))%>
						<table cellpadding=2 cellspacing=0 border="0" width="100%">
							<tr>
								<td width=170><%=Translate.Translate("Forfatter")%></td>
								<td><input type="text" name="NewsAuthor" maxlength="255" class="std" value="<%=Server.HtmlEncode(NewsAuthor)%>"></td>
								
							</tr>
							<tr>
								<td width=170><%=Translate.Translate("Initialer")%></td>
								<td><input type="text" name="NewsInitials" class="std" value="<%=Server.HtmlEncode(NewsInitials)%>" maxlength="50" style="width:50px;"></td>
								
							</tr>
							<tr>
								<td><%=Translate.Translate("Oversigtsbillede")%></td>
								<td><%= Gui.FileManager(NewsSmallImage, Dynamicweb.Content.Management.Installation.ImagesFolderName, "NewsSmallImage")%>&nbsp;</td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Billede")%></td>
								<td><%= Gui.FileManager(NewsImage, Dynamicweb.Content.Management.Installation.ImagesFolderName, "NewsImage")%>&nbsp;</td>
							</tr>
							<%If Base.HasVersion("18.10.1.0")%>
							<tr>
								<td><%=Translate.Translate("Billedetekst")%></td>	
								<td><input type="text" maxlength="255" name="NewsImageText" value="<%=Server.HtmlEncode(NewsImageText)%>" class="std"></td>
							</tr>
							<%End If%>
							<tr valign="top">
								<td><%=Translate.Translate("Template")%></td>
								<%=Gui.TemplatePreview(NewsTemplateID, "news")%>
							</tr>
						</table>
						<%=Gui.GroupBoxEnd%>
					<%Else%>
						<input type="hidden" value="<%=NewsAuthor%>" name="NewsAuthor" id="NewsAuthor">
						<input type="hidden" value="<%=NewsInitials%>" name="NewsInitials" id="NewsInitials">
						<input type="hidden" value="<%=NewsTemplateID%>" name="NewsTemplateID" id="NewsTemplateID">
						<input type="hidden" value="<%=NewsSmallImage%>" name="NewsSmallImage" id="NewsSmallImage">
						<input type="hidden" value="<%=NewsImage%>" name="NewsImage" id="NewsImage">
					<%End If%>
					</td>
				</tr>
				<tr>
					<td colspan=2>
						<%=Gui.GroupBoxStart(Translate.Translate("Publicering"))%>
						<table cellpadding=2 cellspacing=0>
							<tr>
								<td width=170><%=Translate.Translate("Gyldig fra")%></td>
								<td><%=dato.DateSelect(NewsActiveFrom, True, False, False, "NewsActiveFrom")%></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Gyldig til")%></td>
								<td><%=dato.DateSelect(NewsActiveTo, True, False, True, "NewsActiveTo")%></td>
							</tr>	
							<tr>
								<td><%=Translate.Translate("Aktiv")%></td>
								<td><input type="CheckBox" name="NewsActive" <%=NewsActive%>  class="clean"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Arkiv")%></td>
								<td><input type="CheckBox" name="NewsArchive" <%=NewsArchive%> class="clean"></td>
							</tr>
							<%If Base.HasVersion("18.9.1.0") And Base.HasAccess("ContextSubscription", "") Then%>
							<tr>
								<td><%=Translate.Translate("Indholdsabonnement")%></td>
								<td>
									<%=Gui.CheckBox("", "NewsAddToNewsletterSubscription")%>
									<label for="NewsAddToNewsletterSubscription"><%=Translate.Translate("Medtag i abonnementer")%></label>
								</td>
							</tr>
							<%End If%>
						</table>
						<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
                <%If Dynamicweb.Analytics.SecurityManager.Current.IsModuleAvailable() Then%>
                <tr>
					<td colspan="2">
                        <dw:GroupBox ID="gbMarketing" Title="OMC - Content" runat="server">
                            <table cellpadding="2" cellspacing="0">
                                <tr>
                                    <td width="170">
                                        <dw:TranslateLabel ID="lbMarketingPersonalize" Text="Personalize" runat="server" />
                                    </td>
                                    <td>
                                        <dw:Button ID="cmdMarketingPersonalize" Name="Edit settings" OnClick="NewsEdit.openContentRestrictionDialog();" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <dw:TranslateLabel ID="lbMarketingProfileDynamics" Text="Add profile points" runat="server" />
                                    </td>
                                    <td>
                                        <dw:Button ID="cmdMarketingProfileDynamics" Name="Edit settings" OnClick="NewsEdit.openProfileDynamicsDialog();" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </dw:GroupBox>
                    </td>
                </tr>
                <%End If%>
			</table>
			</DIV>
		</td>
	</tr>
	<tr style="background-color:White">
		<td align="right">

		</td>
	</tr>
<%=Gui.TemplatePreviewScript("news", NewsTemplateID,"NewsForm")%>
	
</table>

        <omc:MarketingConfiguration ID="marketConfig" EnableLegacyRendering="true" runat="server" />
	    <script type="text/javascript">
            NewsEdit.Marketing = <%=marketConfig.ClientInstanceName%>;
        </script>
	</form>


</body>
</html>
<%
drNews.Close()
drNews.Dispose()

Translate.GetEditOnlineScript()
%>

