<%@ Page CodeBehind="Forum_Edit.aspx.vb" Language="vb" ValidateRequest="false" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Forum_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.Frontend.LegacyModules.Forum" %>


<%

Dim ParagraphID As Integer
Dim ParagraphModuleSettings As String
Dim dtCategories  As DataTable
Dim arForumCategories() As String
Dim cForum As New Forum
Dim i As Integer

If Request("ID") <> "" Then
	ParagraphID = Base.Chknumber(base.request("ID"))
Elseif Request("ParagraphID") <> "" Then
	ParagraphID = Base.Chknumber(base.request("ParagraphID"))
Else
	ParagraphID = 0
End If

Dim prop As new Properties

    If Base.ChkString(Request.QueryString("ParagraphModuleSystemName")) = "" Then 'ParagraphID > 0 Then
        prop = Base.GetParagraphModuleSettings(ParagraphID, True)
    Else
        prop.Value("ForumExpandedImage") = ""
        prop.Value("ForumColapsedImage") = ""
        prop.Value("ForumMessageNotify") = "1"
        prop.Value("ForumShowAsThreads") = "1"
        prop.Value("ForumShowOriginalMessage") = "1"
        prop.Value("ForumBulletPicture") = ""
        prop.Value("ForumBulletPictureExpanded") = ""
        prop.Value("ForumMessagePicture") = ""
        prop.Value("ForumCategories") = ""
        prop.Value("ForumTemplateListCategories") = "ForumListCategories_wSubscription.html"
        prop.Value("ForumTemplateListCategoriesItem") = "ForumListCategoriesItem.html"
        prop.Value("ForumTemplateFrontendFile") = "ForumFrontend.html"
        prop.Value("ForumTemplateListMessages") = "ForumMessageList.html"
        prop.Value("ForumTemplateListThreads") = "ForumMessageThread.html"
        prop.Value("ForumTemplateMessageReply") = "ForumMessageReply.html"
        prop.Value("ForumTemplateMessageNew") = "ForumMessageNew.html"
        prop.Value("ForumTemplateMessageShow") = "ForumMessageShow.html"
        prop.Value("ForumTemplateOriginalMessage") = "ForumOriginalMessage.html"
        prop.Value("ForumReplyText") = Translate.Translate("Besvar")
        prop.Value("ForumNewMessageText") = Translate.Translate("Nyt indlæg")
        prop.Value("ForumBackText") = Translate.Translate("Tilbage")
        prop.Value("ForumDeleteText") = Translate.Translate("Slet")
        prop.Value("ForumEditText") = Translate.Translate("Ret")
        prop.Value("ForumPreviousText") = Translate.Translate("Forrige")
        prop.Value("ForumNextText") = Translate.Translate("Næste")
        prop.Value("ForumEditTextCheck") = "0"
        prop.Value("ForumSubscription") = "0"
    End If
'Cleanup


If prop.Value("ForumCategories") <> "" Then
	arForumCategories = Split(prop.Value("ForumCategories"), ",")
End If

%>
<INPUT type="Hidden" name="Forum_Settings" value="ForumNewMessageText, ForumSubscription, ForumNextText, ForumPreviousText, ForumTemplateOriginalMessage, ForumDeleteText, ForumTemplateMessageShow, ForumEditTextCheck, ForumEditText, ForumBackText, ForumReplyText, ForumTemplateMessageNew, ForumTemplateMessageReply, ForumTemplateListThreads, ForumTemplateListMessages, ForumTemplateFrontendFile, ForumTemplateListCategoriesItem, ForumTemplateListCategories, ForumExpandedImage, ForumColapsedImage, ForumMessageNotify, ForumShowAsThreads, ForumShowOriginalMessage, ForumBulletPicture, ForumBulletPictureExpanded, ForumMessagePicture, ForumCategories">
<TR>
	<TD>
		<%=Gui.MakeModuleHeader("forum", "Forum")%>
	</TD>
</TR>	
<TR>
	<TD>
					<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger"))%>
						<table cellpadding=2 cellspacing=0>
							<tr>
								<TD valign="top" width="170"><%=Translate.Translate("Visning")%></TD>
								<TD valign="top">
									<%=Gui.RadioButton(prop.Value("ForumShowAsThreads"), "ForumShowAsThreads", "2")%>&nbsp;<label for="ForumShowAsThreads2"><%=Translate.Translate("Vis som liste")%></label><br>
									<%=Gui.RadioButton(prop.Value("ForumShowAsThreads"), "ForumShowAsThreads", "0")%>&nbsp;<label for="ForumShowAsThreads0"><%=Translate.Translate("Vis som tråde")%></label><br>
									<%=Gui.RadioButton(prop.Value("ForumShowAsThreads"), "ForumShowAsThreads", "1")%>&nbsp;<label for="ForumShowAsThreads1"><%=Translate.Translate("Vis som tråde")%> (DHTML)</label>
								</td>
							</tr>
							<tr>
								<td valign="top" width="170"></td>
								<td valign="top"><%=Gui.CheckBox(prop.Value("ForumShowOriginalMessage"), "ForumShowOriginalMessage")%><label for="ForumShowOriginalMessage"> <%=Translate.Translate("Vis original indlæg ved besvarelse")%></label></td>
							</tr>
							<tr>
								<td valign="top" width="170"></td>
								<td valign="top"><%=Gui.CheckBox(prop.Value("ForumMessageNotify"), "ForumMessageNotify")%><label for="ForumMessageNotify"> <%=Translate.Translate("Muliggør notificering via e-mail")%></label></td>
							</tr>
							<tr style="display:<%If Not Base.HasAccess("Extranet") AndAlso Not Base.HasAccess("UserManagementFrontend") Then Response.Write("none")%>">
								<td  valign="top"><%=Translate.Translate("Extranet")%></td>
								<td>
									<%=Gui.CheckBox(prop.Value("ForumEditTextCheck"), "ForumEditTextCheck")%> <%=Translate.Translate("Muliggør redigering af egne indlæg")%><br>
								</td>
							</tr>
							<tr style="Display:<%If Not Base.HasAccess("Extranet", "") AndAlso Not Base.HasAccess("UserManagementFrontend") Then Response.Write("None")%>">
								<td  valign="top"></td>
								<td>
									<%=Gui.CheckBox(prop.Value("ForumSubscription"), "ForumSubscription")%> <%=Translate.Translate("Muliggør abonnement på forum")%><br>
								</td>
							</tr>
						</table>
					<%=Gui.GroupBoxEnd%>
				</TD>
			</TR>						
			<TR>
				<TD colspan=2>
					<%=Gui.GroupBoxStart(Translate.Translate("Kategorier"))%>
						<TABLE cellpadding="2" cellspacing="0" border="0">
							<tr>
								<td valign="top" width="170"><%=Translate.Translate("Medtag følgende kategorier")%></td>
								<td valign="top">
								<%
								dtCategories = cForum.GetCategories(True, "")
								If Not IsNothing(dtCategories) Then
									For i = 0 To dtCategories.Rows.Count - 1
										With Response
											if i>0 then .write("<br />")
											.Write("<INPUT " & Base.IIf(Base.IsValueInArray(arForumCategories, dtCategories.Rows(i)("ForumCategoryID").ToString), "checked", "") & " name=""ForumCategories"" id=""ForumCategories_" & dtCategories.Rows(i)("ForumCategoryID") & """ type=""CheckBox"" value=""" & dtCategories.Rows(i)("ForumCategoryID") & """>")
											.Write("<LABEL for=""ForumCategories_" & dtCategories.Rows(i)("ForumCategoryID").ToString & """>" & dtCategories.Rows(i)("ForumCategoryName") & "</LABEL>")
										End With
									Next 
									dtCategories.Dispose()
								End If
								%>
								</td>
							</tr>
						</TABLE>
					<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
				<TR>
					<TD colspan="2">
						<%=Gui.GroupBoxStart(Translate.Translate("Billeder"))%>
							<TABLE cellpadding="2" cellspacing="0">
								<TR>
									<TD valign="top" width="170"><%=Translate.Translate("Fold-ind ikon")%></TD>
									<TD valign="top"><%= Gui.FileManager(prop.Value("ForumBulletPicture"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "ForumBulletPicture")%></TD>
								</TR>						
								<TR>
									<TD valign="top" width="170"><%=Translate.Translate("Fold-ud ikon")%></TD>
									<TD valign="top"><%= Gui.FileManager(prop.Value("ForumBulletPictureExpanded"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "ForumBulletPictureExpanded")%></TD>
								</TR>
								<TR>
									<TD valign="top" width="170"><%=Translate.Translate("Indlæg ikon")%></TD>
									<TD valign="top"><%= Gui.FileManager(prop.Value("ForumMessagePicture"), Dynamicweb.Content.Management.Installation.ImagesFolderName, "ForumMessagePicture")%></TD>
								</TR>
							</TABLE>				
						<%=Gui.GroupBoxEnd%>
					</TD>
				</TR>						
				<%If Base.HasVersion("18.2.4.0") Then%>
				<tr>
					<td>
						<%=Gui.GroupBoxStart(Translate.Translate("Templates"))%>
							<TABLE cellpadding="2" cellspacing="0" border="0">
								<TR>
									<TD valign="top" width="170"><%=Translate.Translate("Liste kategorier")%></TD>
									<TD valign="top"><%=Gui.FileManager(prop.Value("ForumTemplateListCategories"), "Templates/Forum", "ForumTemplateListCategories")%></TD>
								</TR>
								<TR>
									<TD valign="top" width="170"><%=Translate.Translate("Vis kategorier")%></TD>
									<TD valign="top"><%=Gui.FileManager(prop.value("ForumTemplateListCategoriesItem"), "Templates/Forum", "ForumTemplateListCategoriesItem")%></TD>
								</TR>
								<TR>
									<TD valign="top" width="170"><%=Translate.Translate("FrontEnd")%></TD>
									<TD valign="top"><%=Gui.FileManager(prop.Value("ForumTemplateFrontendFile"), "Templates/Forum", "ForumTemplateFrontendFile")%></TD>
								</TR>
								<TR>
									<TD valign="top" width="170"><%=Translate.Translate("Liste indlæg",1)%></TD>
									<TD valign="top"><%=Gui.FileManager(prop.Value("ForumTemplateListMessages"), "Templates/Forum", "ForumTemplateListMessages")%></TD>
								</TR>
								<TR>
									<TD valign="top" width="170"><%=Translate.Translate("Liste tråd")%></TD>
									<TD valign="top"><%=Gui.FileManager(prop.Value("ForumTemplateListThreads"), "Templates/Forum", "ForumTemplateListThreads")%></TD>
								</TR>
								<TR>
									<TD valign="top" width="170"><%=Translate.Translate("Vis %%", "%%", Translate.Translate("indlæg"))%></TD>
									<TD valign="top"><%=Gui.FileManager(prop.Value("ForumTemplateMessageShow"), "Templates/Forum", "ForumTemplateMessageShow")%></TD>
								</TR>
								<TR>
									<TD valign="top" width="170"><%=Translate.Translate("Besvar indlæg")%></TD>
									<TD valign="top"><%=Gui.FileManager(prop.Value("ForumTemplateMessageReply"), "Templates/Forum", "ForumTemplateMessageReply")%></TD>
								</TR>
								<TR>
									<TD valign="top" width="170"><%=Translate.Translate("Oprindelig indlæg")%></TD>
									<TD valign="top"><%=Gui.FileManager(prop.Value("ForumTemplateOriginalMessage"), "Templates/Forum", "ForumTemplateOriginalMessage")%></TD>
								</TR>
								<TR>
									<TD valign="top" width="170"><%=Translate.Translate("Nyt indlæg")%></TD>
									<TD valign="top"><%=Gui.FileManager(prop.Value("ForumTemplateMessageNew"), "Templates/Forum", "ForumTemplateMessageNew")%></TD>
								</TR>
							</TABLE>
						<%=Gui.GroupBoxEnd%>
					</td>
				</tr>
				<tr>
					<td>
						<%=Gui.GroupBoxStart(Translate.Translate("Brugerdefinerede tekster"))%>
							<table border="0" cellpadding="2" cellspacing="0" width="100%">
							<tr>
								<td width="170"><%=Translate.Translate("Nyt indlæg")%></td>
								<td><input type="Text" name="ForumNewMessageText" value="<%=prop.Value("ForumNewMessageText")%>" maxlength="255" class="std"></td>
							</tr>
							<tr>
								<td width="170"><%=Translate.Translate("Tilbage")%></td>
								<td><input type="Text" name="ForumBackText" value="<%=prop.Value("ForumBackText")%>" maxlength="255" class="std"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Besvar")%></td>
								<td><input type="Text" name="ForumReplyText" value="<%=prop.Value("ForumReplyText")%>" maxlength="255" class="std"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Slet")%></td>
								<td><input type="Text" name="ForumDeleteText" value="<%=prop.Value("ForumDeleteText")%>" maxlength="255" class="std"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Ret")%></td>
								<td><input type="Text" name="ForumEditText" value="<%=prop.Value("ForumEditText")%>" maxlength="255" class="std"></td>
							</tr>
							<tr>
								<td><%=Translate.Translate("Næste")%></td>
								<td><input type="Text" name="ForumNextText" value="<%=prop.Value("ForumNextText")%>" maxlength="255" class="std"></td>
							</tr>
							<tr>
								<td width="170"><%=Translate.Translate("Forrige")%></td>
								<td><input type="Text" name="ForumPreviousText" value="<%=prop.Value("ForumPreviousText")%>" maxlength="255" class="std"></td>
							</tr>
							</TABLE>
						<%=Gui.GroupBoxEnd%>
					</TD>
				</TR>
				<%End If%>
									
<%
 Translate.GetEditOnlineScript()
%>