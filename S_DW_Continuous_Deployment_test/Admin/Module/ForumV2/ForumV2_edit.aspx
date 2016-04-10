<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" Codebehind="ForumV2_edit.aspx.vb" Inherits="Dynamicweb.Admin.ForumV2.ForumV2_edit" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Admin.ForumV2" %>
<%@ Import namespace="Dynamicweb.ForumV2" %>
<script language="javascript">
	function editShowCategories(id)
	{
		var categories = document.getElementById("ShowCategories");
		var start = 0;
				
		if(categories)
		{
			if((start = categories.value.indexOf(id)) < 0)
			{
				if(categories.value == "none")
					categories.value = "";
				categories.value += id + ",";
			}
			else
			{
				categories.value = categories.value.substr(0, start) + 
					categories.value.substr(start + id.length + 1, categories.value.length);
				if(categories.value == "")
					categories.value = "none";
			}
		}
	}
	
	function ToggleType(elmShow, elmHide)
	{
		if(elmShow && elmHide)
		{
			elmShow.style.display = "";
			elmHide.style.display = "none";
		}
	}
	
	function onAllowFilesChanged(chk) {
		var rowFiles = document.getElementById('rowAllowAnonymousFiles');
		if(rowFiles) rowFiles.style.display = chk.checked ? '' : 'none';
	}
	
	function onAllowAnonymousChanged(chk) {
		var chkAllowAnonymousFiles = document.getElementById('AllowAnonymousFiles');
		if(chkAllowAnonymousFiles) chkAllowAnonymousFiles.disabled = chk.checked ? '' : 'none';
	}
</script>
<dw:moduleheader id="ForumV2Module" ModuleSystemName="ForumV2" ShowButtons="true" runat="server"></dw:moduleheader>
<input runat="server" type="hidden" id="ForumV2_settings" name="ForumV2_settings" value="UseStyles, ShowCategories, AllCategories, SubscribeCategories, SubscribeThreads, SortOrder, NewStatusNewText, NewStatusReadText, HotStatusNewText, HotStatusReadText, PollStatusNewText, PollStatusReadText, StickyStatusText, ClosedStatusText, NewStatusNewImg, NewStatusReadImg, HotStatusNewImg, HotStatusReadImg, PollStatusNewImg, PollStatusReadImg, StickyStatusImg, ClosedStatusImg, NewStatusNewType, NewStatusReadType, HotStatusNewType, HotStatusReadType, PollStatusNewType, PollStatusReadType, StickyStatusType, ClosedStatusType, ForgotPasswordSubject, ForgotPasswordEmail, ForgotPasswordEncoding, ForgotPasswordEmailTemplate, ListThreadTemplate, ListThreadRowTemplate, EditThreadTemplate, LatestThreadReplyTemplate, ListCategoryTemplate, LatestCategoryReplyTemplate, ListPostTemplate, ListVoteTemplate, EditPostTemplate, EditPostRowTemplate, AllowAnonymous, PageCount, PageSize, PageTemplate, PageElementTemplate, PageElementSelectedTemplate, AuthorizedMenuTemplate, UnAuthorizedMenuTemplate, LoginTemplate, ForgotPasswordTemplate, EditProfileTemplate, UserInfoTemplate, ForumV2EditorTemplate, ForumV2EditorSimpleTemplate, PostReplyTemplate, AnonymousUserName, ErrorMessageTemplate, ErrorNoAccess, ErrorThreadClosed, ErrorAnonymousPostsDenied, SubscribeTemplate, UnSubscribeTemplate, ListEditVoteRowTemplate, ListEditNoVotesTemplate, UploadFileTemplate, ListFilesTemplate, ErrorUserBanned, ForumV2EditorExtendedTemplate, AllowFiles, AllowRSS, ThreadRssMaxPosts, AllowAnonymousFiles, CustomHiddenContent, FilterString0, FilterString1, FilterString2, FilterString3, FilterString7, FilterString14, FilterString30, FilterString60, FilterString90, FilterString180, FilterString365, EditorWidth, EditorHeight">
<input type="hidden" id="ShowCategories" name="ShowCategories" value="<%=Base.ChkString(_showCategories) %>">
<input type="hidden" id="AllCategories" name="AllCategories" value="<%=Base.ChkString(_allCategories) %>">
<table cellSpacing="0" cellPadding="2" width="598" border="0">
	<tr>
		<td>
			<table cellSpacing="0" cellPadding="0" width="598" border="0">
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>
						<dw:groupboxstart id="SettingsStart" title="Indstillinger" runat="server"></dw:groupboxstart>
						<table cellspacing="0" cellpadding="2" border="0" width="100%">
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>
									<table cellspacing="0" cellpadding="2" border="0" width="100%">
										<tr>
											<td width="170" valign="top"><%=Translate.Translate("Anonym brugernavn")%></td>
											<td>
												<input type="text" class="std" name="AnonymousUserName" id="AnonymousUserName" value="<%=Base.ChkString(_properties.Value("AnonymousUserName")) %>">
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table cellspacing="0" cellpadding="2" border="0" width="100%">
										<tr>
											<td width="170" valign="top"><%=Translate.Translate("Tillad anonyme indlæg")%></td>
											<td>
												<input type="checkbox" onclick="onAllowAnonymousChanged(this);" id="AllowAnonymous" name="AllowAnonymous" value="on" <%=Base.IIf(Base.ChkString(_properties.Value("AllowAnonymous")).Length > 0, "checked", String.Empty) %>>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table cellspacing="0" cellpadding="2" border="0" width="100%">
										<tr>
											<td width="170" valign="top"><%=Translate.Translate("Allow files")%></td>
											<td>
												<input type="checkbox" id="AllowFiles" onclick="onAllowFilesChanged(this);" name="AllowFiles" value="on" <%=Base.IIf(Base.ChkString(_properties.Value("AllowFiles")).Length > 0, "checked", String.Empty) %>>
											</td>
										</tr>
										<tr id="rowAllowAnonymousFiles" style="display : <%=Base.IIf(Base.ChkString(_properties.Value("AllowFiles")).Length > 0, "", "none")%>">
											<td valign="top"><%=Translate.Translate("Allow files for anonymous")%></td>
											<td>
												<input type="checkbox" id="AllowAnonymousFiles" name="AllowAnonymousFiles" value="on" 
													<%=Base.IIf(Base.ChkString(_properties.Value("AllowAnonymousFiles")).Length > 0, " checked ", String.Empty) %>
													<%=Base.IIf(Base.ChkString(_properties.Value("AllowAnonymous")).Length > 0, "", " disabled ") %>>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table cellspacing="0" cellpadding="2" border="0" width="100%">
										<tr>
											<td width="170" valign="top"><%=Translate.Translate("Allow RSS for threads")%></td>
											<td>
												<input type="checkbox" id="AllowRSS" name="AllowRSS" value="on" <%=Base.IIf(Base.ChkString(_properties.Value("AllowRSS")).Length > 0, "checked", String.Empty) %>>
											</td>
										</tr>
										<tr>
											<td width="170" valign="top"><%=Translate.Translate("Max. posts in RSS")%></td>
											<td>
												<input type="text" class="std" style="width: 30px;" id="ThreadRssMaxPosts" name="ThreadRssMaxPosts" value="<%=Base.ChkInteger(_properties.Value("ThreadRssMaxPosts"))%>">
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table cellspacing="0" cellpadding="2" border="0" width="100%">
										<tr>
											<td width="170"><%=Translate.Translate("Use styles in editor")%></td>
											<td>
							                    <input type="checkbox" id="UseStyles" name="UseStyles" value="on" <%=Base.IIf(Base.ChkString(_properties.Value("UseStyles")).Length > 0, "checked", String.Empty) %>>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table cellspacing="0" cellpadding="2" border="0" width="100%">
										<tr>
											<td width="170"><%=Translate.Translate("Antal sider")%></td>
											<td><input type="text" class="std" style="width: 30px;" name="PageCount" id="PageCount" value="<%=Base.ChkString(_properties.Value("PageCount")) %>"></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Antal indlæg")%></td>
											<td><input type="text" class="std" style="width: 30px;" name="PageSize" id="PageSize" value="<%=Base.ChkString(_properties.Value("PageSize")) %>"></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table cellspacing="0" cellpadding="2" border="0" width="100%">
										<tr>
											<td width="170" valign="top"><%=Translate.Translate("Tillad brugere at abonnere på")%>:</td>
											<td>
												<table cellspacing="0" cellpadding="0" border="0" width="100%">
													<tr>
														<td><input type="checkbox" id="SubscribeCategories" name="SubscribeCategories" value="on" <%=Base.IIf(Base.ChkString(_properties.Value("SubscribeCategories")).Length > 0, "checked", String.Empty) %>>&nbsp;<%=Backend.Translate.Translate("Kategorier")%></td>
													</tr>
													<tr>
														<td><input type="checkbox" id="SubscribeThreads" name="SubscribeThreads" value="on" <%=Base.IIf(Base.ChkString(_properties.Value("SubscribeThreads")).Length > 0, "checked", String.Empty) %>>&nbsp;<%=Backend.Translate.Translate("Tråde")%></td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table cellspacing="0" cellpadding="2" border="0" width="100%">
										<tr>
											<td width="170"><%=Translate.Translate("Sorter tråde efter")%></td>
											<td>
												<table cellspacing="0" cellpadding="0" border="0" width="100%">
													<tr>
														<td><input type="radio" id="SortOrder" name="SortOrder" value="MostActive" <%=Base.IIf(Base.ChkString(_properties.Value("SortOrder")) = Consts.SortOrderMostActive, "checked", "") %>>&nbsp;<%=Translate.Translate("Mest aktive")%></td>
													</tr>
													<tr>
														<td><input type="radio" id="SortOrder" name="SortOrder" value="LatestReply" <%=Base.IIf(Base.ChkString(_properties.Value("SortOrder")) = Consts.SortOrderLatestReply, "checked", "") %>>&nbsp;<%=Translate.Translate("Senest besvaret")%></td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table cellspacing="0" cellpadding="2" border="0" width="100%">
										<tr>
											<td width="170" valign="top"><%=Translate.Translate("Vis kategorier")%></td>
											<td><%=_lstCategories%></asp:Literal></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<table cellspacing="0" cellpadding="2" border="0" width="100%">
										<tr>
											<td width="170" valign="top"><%=Translate.Translate("New status")%></td>
											<td>
												<table cellspacing="0" cellpadding="0" border="0" width="100%">
													<tr>
														<td><input onclick="ToggleType(newNewTxt, newNewImg);" type="radio" id="NewStatusNewType" name="NewStatusNewType" value="txt" <%=Base.IIF(Base.ChkString(_properties.Value("NewStatusNewType")) = Consts.StatusTypeText, "checked", "") %>>&nbsp;<%=Translate.Translate("Tekst")%>&nbsp;&nbsp;
															<input onclick="ToggleType(newNewImg, newNewTxt);" type="radio" id="NewStatusNewType" name="NewStatusNewType" value="img" <%=Base.IIF(Base.ChkString(_properties.Value("NewStatusNewType")) = Consts.StatusTypeImg, "checked", "") %>>&nbsp;<%=Translate.Translate("Billede")%>
														</td>
													</tr>
													<tr>
														<td>
															<div id="newNewTxt" style="display: <%=Base.IIF(Base.ChkString(_properties.Value("NewStatusNewType")) = "txt", "", "none;") %>"><input type="text" id="NewStatusNew" name="NewStatusNewText" class="std" value="<%=Base.ChkString(_properties.Value("NewStatusNewText"))%>"></div>
															<div id="newNewImg" style="display: <%=Base.IIF(Base.ChkString(_properties.Value("NewStatusNewType")) = "img", "", "none;") %>"><dw:filemanager folder="ForumV2/Images" id="fmNewStatusNewImg" name="NewStatusNewImg" runat="server"></dw:filemanager></div>
														</td>
													</tr>
													<tr>
														<td><input onclick="ToggleType(newReadTxt, newReadImg);" type="radio" id="NewStatusReadType" name="NewStatusReadType" value="txt" <%=Base.IIF(Base.ChkString(_properties.Value("NewStatusReadType")) = Consts.StatusTypeText, "checked", "") %>>&nbsp;<%=Translate.Translate("Tekst")%>&nbsp;&nbsp;
															<input onclick="ToggleType(newReadImg, newReadTxt);" type="radio" id="NewStatusReadType" name="NewStatusReadType" value="img" <%=Base.IIF(Base.ChkString(_properties.Value("NewStatusReadType")) = Consts.StatusTypeImg, "checked", "") %>>&nbsp;<%=Translate.Translate("Billede")%>
														</td>
													</tr>
													<tr>
														<td>
															<div id="newReadTxt" style="display: <%=Base.IIF(Base.ChkString(_properties.Value("NewStatusReadType")) = "txt", "", "none;") %>"><input type="text" id="NewStatusRead" name="NewStatusReadText" class="std" value="<%=Base.ChkString(_properties.Value("NewStatusReadText"))%>"></div>
															<div id="newReadImg" style="display: <%=Base.IIF(Base.ChkString(_properties.Value("NewStatusReadType")) = "img", "", "none;") %>"><dw:filemanager folder="ForumV2/Images" id="fmNewStatusReadImg" name="NewStatusReadImg" runat="server"></dw:filemanager></div>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td valign="top"><%=Translate.Translate("Hot status")%></td>
											<td>
												<table cellspacing="0" cellpadding="0" border="0" width="100%">
													<tr>
														<td><input onclick="ToggleType(hotNewTxt, hotNewImg);" type="radio" id="HotStatusNewType" name="HotStatusNewType" value="txt" <%=Base.IIF(Base.ChkString(_properties.Value("HotStatusNewType")) = Consts.StatusTypeText, "checked", "") %>>&nbsp;<%=Translate.Translate("Tekst")%>&nbsp;&nbsp;
															<input onclick="ToggleType(hotNewImg, hotNewTxt);" type="radio" id="HotStatusNewType" name="HotStatusNewType" value="img" <%=Base.IIF(Base.ChkString(_properties.Value("HotStatusNewType")) = Consts.StatusTypeImg, "checked", "") %>>&nbsp;<%=Translate.Translate("Billede")%>
														</td>
													</tr>
													<tr>
														<td>
															<div id="hotNewTxt" style="display: <%=Base.IIF(Base.ChkString(_properties.Value("HotStatusNewType")) = "txt", "", "none;") %>"><input type="text" id="HotStatusNew" name="HotStatusNewText" class="std" value="<%=Base.ChkString(_properties.Value("HotStatusNewText"))%>"></div>
															<div id="hotNewImg" style="display: <%=Base.IIF(Base.ChkString(_properties.Value("HotStatusNewType")) = "img", "", "none;") %>"><dw:filemanager folder="ForumV2/Images" id="fmHotStatusNewImg" name="HotStatusNewImg" runat="server"></dw:filemanager></div>
														</td>
													</tr>
													<tr>
														<td><input onclick="ToggleType(hotReadTxt, hotReadImg);" type="radio" id="HotStatusReadType" name="HotStatusReadType" value="txt" <%=Base.IIF(Base.ChkString(_properties.Value("HotStatusReadType")) = Consts.StatusTypeText, "checked", "") %>>&nbsp;<%=Translate.Translate("Tekst")%>&nbsp;&nbsp;
															<input onclick="ToggleType(hotReadImg, hotReadTxt);" type="radio" id="HotStatusReadType" name="HotStatusReadType" value="img" <%=Base.IIF(Base.ChkString(_properties.Value("HotStatusReadType")) = Consts.StatusTypeImg, "checked", "") %>>&nbsp;<%=Translate.Translate("Billede")%>
														</td>
													</tr>
													<tr>
														<td>
															<div id="hotReadTxt" style="display: <%=Base.IIF(Base.ChkString(_properties.Value("HotStatusReadType")) = "txt", "", "none;") %>"><input type="text" id="HotStatusRead" name="HotStatusReadText" class="std" value="<%=Base.ChkString(_properties.Value("HotStatusReadText"))%>"></div>
															<div id="hotReadImg" style="display: <%=Base.IIF(Base.ChkString(_properties.Value("HotStatusReadType")) = "img", "", "none;") %>"><dw:filemanager folder="ForumV2/Images" id="fmHotStatusReadImg" name="HotStatusReadImg" runat="server"></dw:filemanager></div>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td valign="top"><%=Translate.Translate("Poll status")%></td>
											<td>
												<table cellspacing="0" cellpadding="0" border="0" width="100%">
													<tr>
														<td><input onclick="ToggleType(pollNewTxt, pollNewImg);" type="radio" id="PollStatusNewType" name="PollStatusNewType" value="txt" <%=Base.IIF(Base.ChkString(_properties.Value("PollStatusNewType")) = Consts.StatusTypeText, "checked", "") %>>&nbsp;<%=Translate.Translate("Tekst")%>&nbsp;&nbsp;
															<input onclick="ToggleType(pollNewImg, pollNewTxt);" type="radio" id="PollStatusNewType" name="PollStatusNewType" value="img" <%=Base.IIF(Base.ChkString(_properties.Value("PollStatusNewType")) = Consts.StatusTypeImg, "checked", "") %>>&nbsp;<%=Translate.Translate("Image")%>
														</td>
													</tr>
													<tr>
														<td>
															<div id="pollNewTxt" style="display: <%=Base.IIF(Base.ChkString(_properties.Value("PollStatusNewType")) = "txt", "", "none;") %>"><input type="text" id="PollStatusNew" name="PollStatusNewText" class="std" value="<%=Base.ChkString(_properties.Value("PollStatusNewText"))%>"></div>
															<div id="pollNewImg" style="display: <%=Base.IIF(Base.ChkString(_properties.Value("PollStatusNewType")) = "img", "", "none;") %>"><dw:filemanager folder="ForumV2/Images" id="fmPollStatusNewImg" name="PollStatusNewImg" runat="server"></dw:filemanager></div>
														</td>
													</tr>
													<tr>
														<td><input onclick="ToggleType(pollReadTxt, pollReadImg);" type="radio" id="PollStatusReadType" name="PollStatusReadType" value="txt" <%=Base.IIF(Base.ChkString(_properties.Value("PollStatusReadType")) = Consts.StatusTypeText, "checked", "") %>>&nbsp;<%=Translate.Translate("Tekst")%>&nbsp;&nbsp;
															<input onclick="ToggleType(pollReadImg, pollReadTxt);" type="radio" id="PollStatusReadType" name="PollStatusReadType" value="img" <%=Base.IIF(Base.ChkString(_properties.Value("PollStatusReadType")) = Consts.StatusTypeImg, "checked", "") %>>&nbsp;<%=Translate.Translate("Billede")%>
														</td>
													</tr>
													<tr>
														<td>
															<div id="pollReadTxt" style="display: <%=Base.IIF(Base.ChkString(_properties.Value("PollStatusReadType")) = "txt", "", "none;") %>"><input type="text" id="PollStatusRead" name="PollStatusReadText" class="std" value="<%=Base.ChkString(_properties.Value("PollStatusReadText"))%>"></div>
															<div id="pollReadImg" style="display: <%=Base.IIF(Base.ChkString(_properties.Value("PollStatusReadType")) = "img", "", "none;") %>"><dw:filemanager folder="ForumV2/Images" id="fmPollStatusReadImg" name="PollStatusReadImg" runat="server"></dw:filemanager></div>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td valign="top"><%=Translate.Translate("Sticky status")%></td>
											<td>
												<table cellspacing="0" cellpadding="0" border="0" width="100%">
													<tr>
														<td>
															<input onclick="ToggleType(stickyTxt, stickyImg);" type="radio" id="StickyStatusType" name="StickyStatusType" value="txt" <%=Base.IIF(Base.ChkString(_properties.Value("StickyStatusType")) = Consts.StatusTypeText, "checked", "") %>>&nbsp;<%=Translate.Translate("Tekst")%>&nbsp;&nbsp;
															<input onclick="ToggleType(stickyImg, stickyTxt);" type="radio" id="StickyStatusType" name="StickyStatusType" value="img" <%=Base.IIF(Base.ChkString(_properties.Value("StickyStatusType")) = Consts.StatusTypeImg, "checked", "") %>>&nbsp;<%=Translate.Translate("Billede")%>
														</td>
													</tr>
													<tr>
														<td>
															<div id="stickyTxt" style="display: <%=Base.IIF(Base.ChkString(_properties.Value("StickyStatusType")) = "txt", "", "none;") %>"><input type="text" id="StickyStatus" name="StickyStatusText" class="std" value="<%=Base.ChkString(_properties.Value("StickyStatusText"))%>"></div>
															<div id="stickyImg" style="display: <%=Base.IIF(Base.ChkString(_properties.Value("StickyStatusType")) = "img", "", "none;") %>"><dw:filemanager folder="ForumV2/Images" id="fmStickyStatusImg" name="StickyStatusImg" runat="server"></dw:filemanager></div>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td valign="top"><%=Translate.Translate("Låst status")%></td>
											<td>
												<table cellspacing="0" cellpadding="0" border="0" width="100%">
													<tr>
														<td>
															<input onclick="ToggleType(closedTxt, closedImg);" type="radio" id="ClosedStatusType" name="ClosedStatusType" value="txt" <%=Base.IIF(Base.ChkString(_properties.Value("ClosedStatusType")) = Consts.StatusTypeText, "checked", "") %>>&nbsp;<%=Translate.Translate("Tekst")%>&nbsp;&nbsp;
															<input onclick="ToggleType(closedImg, closedTxt);" type="radio" id="ClosedStatusType" name="ClosedStatusType" value="img" <%=Base.IIF(Base.ChkString(_properties.Value("ClosedStatusType")) = Consts.StatusTypeImg, "checked", "") %>>&nbsp;<%=Translate.Translate("Billede")%>
														</td>
													</tr>
													<tr>
														<td>
															<div id="closedTxt" style="display: <%=Base.IIF(Base.ChkString(_properties.Value("ClosedStatusType")) = "txt", "", "none;") %>"><input type="text" id="ClosedStatus" name="ClosedStatusText" class="std" value="<%=Base.ChkString(_properties.Value("ClosedStatusText"))%>"></div>
															<div id="closedImg" style="display: <%=Base.IIF(Base.ChkString(_properties.Value("ClosedStatusType")) = "img", "", "none;") %>"><dw:filemanager folder="ForumV2/Images" id="fmClosedStatusImg" name="ClosedStatusImg" runat="server"></dw:filemanager></div>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>
									<!-------------- Forgot password  -------------->
									
									<dw:GroupBoxStart id="boxForgotPasswordStart" runat="server" Title="Forgot password" />
									<table cellspacing="0" cellpadding="2" border="0" width="100%">
										<tr>
											 <td width="170"><%=Translate.Translate("E-mail subject")%></td>
											<td><input name="ForgotPasswordSubject" id="ForgotPasswordSubject" class="std" type="text" value="<%=Base.ChkString(_properties.Value("ForgotPasswordSubject"))%>" /></td>
										</tr>
										<tr>
											 <td><%=Translate.Translate("Sender e-mail address")%></td>
											<td><input name="ForgotPasswordEmail" id="ForgotPasswordEmail" class="std" type="text"  value="<%=Base.ChkString(_properties.Value("ForgotPasswordEmail"))%>" /></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Encoding")%></td>
											<td><%=Gui.EncodingList(_properties.Value("ForgotPasswordEncoding"), "ForgotPasswordEncoding", True)%></td>
										</tr>
									</table>
									<dw:GroupBoxEnd id="boxForgotPasswordEnd" runat="server" />
									
									<!-------------- End: Forgot password  -------------->
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>
								<!-------------- Extended editor  -------------->
									
									<dw:GroupBoxStart id="boxEditorStart" runat="server" Title="Editor" />
									<table cellspacing="0" cellpadding="2" border="0" width="100%">
										<tr>
											 <td width="170"><%=Translate.Translate("Bredde")%></td>
											<td><input name="EditorWidth" id="EditorWidth" class="std" type="text" value="<%=Base.ChkString(_properties.Value("EditorWidth"))%>" /></td>
										</tr>
										<tr>
											 <td><%=Translate.Translate("Højde")%></td>
											<td><input name="EditorHeight" id="EditorHeight" class="std" type="text"  value="<%=Base.ChkString(_properties.Value("EditorHeight"))%>" /></td>
										</tr>
									</table>
									<dw:GroupBoxEnd id="boxEditorEnd" runat="server" />
									
									<!-------------- End: Extended editor  -------------->
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>
						<dw:groupboxstart id="TemplatesStart" Title="Template" runat="server"></dw:groupboxstart>
						<table cellspacing="0" cellpadding="2" border="0" width="100%">
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>
									<dw:groupboxstart id="Categories" Title="Kategorier" runat="server"></dw:groupboxstart>
									<table cellspacing="0" cellpadding="2" border="0" width="100%">
										<tr>
											<td width="170"><%=Translate.Translate("Template kategori liste")%></td>
											<td><dw:filemanager id="fmListCategoryTemplate" name="ListCategoryTemplate" folder="Templates/ForumV2/Category"
													FullPath=False runat="server"></dw:filemanager></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Template seneste svar")%></td>
											<td><dw:filemanager id="fmLatestCategoryReplyTemplate" name="LatestCategoryReplyTemplate" folder="Templates/ForumV2/Category"
													runat="server"></dw:filemanager></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<dw:groupboxstart id="Threads" Title="Tråde" runat="server"></dw:groupboxstart>
									<table cellspacing="0" cellpadding="2" border="0" width="100%">
										<tr>
											<td width="170"><%=Translate.Translate("Template tråd liste")%></td>
											<td><dw:filemanager id="fmListThreadTemplate" name="ListThreadTemplate" folder="Templates/ForumV2/Thread"
													runat="server"></dw:filemanager></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Template rediger tråd")%></td>
											<td><dw:filemanager id="fmEditThreadTemplate" name="EditThreadTemplate" folder="Templates/ForumV2/Thread"
													runat="server"></dw:filemanager></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<dw:groupboxstart id="PostsStart" title="Indlæg" runat="server"></dw:groupboxstart>
									<table cellspacing="0" cellpadding="2" border="0" width="100%">
										<tr>
											<td width="170"><%=Translate.Translate("Template indlæg liste")%></td>
											<td><dw:filemanager id="fmListPostTemplate" name="ListPostTemplate" folder="Templates/ForumV2/Post"
													runat="server"></dw:filemanager></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Template rediger indlæg")%></td>
											<td><dw:filemanager id="fmEditPostTemplate" name="EditPostTemplate" folder="Templates/ForumV2/Post"
													runat="server"></dw:filemanager></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Template simpel editor")%></td>
											<td><dw:filemanager id="fmForumV2EditorSimpleTemplate" name="ForumV2EditorSimpleTemplate" folder="Templates/ForumV2/ForumV2Editor"
													runat="server"></dw:filemanager></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Template avanceret editor")%></td>
											<td><dw:filemanager id="fmForumV2EditorTemplate" name="ForumV2EditorTemplate" folder="Templates/ForumV2/ForumV2Editor"
													runat="server"></dw:filemanager></td>
										</tr>
										
										<tr>
											<td>Template extended editor</td>
											<td><dw:filemanager id="fmForumV2EditorExtendedTemplate" name="ForumV2EditorExtendedTemplate" folder="Templates/ForumV2/ForumV2Editor"
													runat="server"></dw:filemanager></td>
										</tr>
										
										<tr>
											<td><%=Translate.Translate("Template send svar")%></td>
											<td><dw:filemanager id="fmPostReplyTemplate" name="PostReplyTemplate" folder="Templates/ForumV2/Post"
													runat="server"></dw:filemanager></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Template afstemning liste")%></td>
											<td><dw:filemanager id="fmListVoteTemplate" name="ListVoteTemplate" folder="Templates/ForumV2/Post"
													runat="server"></dw:filemanager></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<dw:groupboxstart id="PagingStart" title="Sideinddeling" runat="server"></dw:groupboxstart>
									<table cellspacing="0" cellpadding="2" border="0" width="100%">
										<tr>
											<td width="170"><%=Translate.Translate("Template side")%></td>
											<td><dw:filemanager id="fmPageTemplate" name="PageTemplate" Folder="Templates/ForumV2/Paging" runat="server"></dw:filemanager></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Template sideelement")%></td>
											<td><dw:filemanager id="fmPageElementTemplate" name="PageElementTemplate" Folder="Templates/ForumV2/Paging"
													runat="server"></dw:filemanager></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Template valgt side")%></td>
											<td><dw:filemanager id="fmPageElementSelectedTemplate" name="PageElementSelectedTemplate" Folder="Templates/ForumV2/Paging"
													runat="server"></dw:filemanager></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
									<dw:groupboxstart id="OtherStart" title="Øvrige" runat="server"></dw:groupboxstart>
									<table cellspacing="0" cellpadding="2" border="0" width="100%">
										<tr>
											<td width="170"><%=Translate.Translate("Template uautoriseret menu")%></td>
											<td><dw:filemanager id="fmUnAuthorizedMenuTemplate" name="UnAuthorizedMenuTemplate" folder="Templates/ForumV2/Other"
													runat="server"></dw:filemanager></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Template autoriseret menu")%></td>
											<td><dw:filemanager id="fmAuthorizedMenuTemplate" name="AuthorizedMenuTemplate" folder="Templates/ForumV2/Other"
													runat="server"></dw:filemanager></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Template login")%></td>
											<td><dw:filemanager id="fmLoginTemplate" name="LoginTemplate" folder="Templates/ForumV2/Other" runat="server"></dw:filemanager></td>
										</tr>
										<tr>
											 <td><%=Translate.Translate("Template") & " " & Translate.Translate("adgangskode")%></td>
											<td><dw:FileManager Folder="Templates/ForumV2/Other" runat="server" ID="ForgotPasswordTemplate" Name="ForgotPasswordTemplate" /></td>
										</tr>
										<tr>
											 <td><%=Translate.Translate("Template")& " " & Translate.Translate("E-mail")%></td>
											<td><dw:FileManager Folder="Templates/ForumV2/Other" runat="server" ID="ForgotPasswordEmailTemplate" Name="ForgotPasswordEmailTemplate" /></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Template rediger profil")%></td>
											<td><dw:filemanager id="fmEditProfileTemplate" name="EditProfileTemplate" folder="Templates/ForumV2/Other"
													runat="server"></dw:filemanager></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Template brugerinfo")%></td>
											<td><dw:filemanager id="fmUserInfoTemplate" name="UserInfoTemplate" folder="Templates/ForumV2/Other"
													runat="server"></dw:filemanager></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Template fejlmeddelelse")%></td>
											<td><dw:filemanager id="fmErrorMessageTemplate" name="ErrorMessageTemplate" folder="Templates/ForumV2/Other"
													runat="server"></dw:filemanager></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Template abonner")%></td>
											<td><dw:filemanager id="fmSubscribeTemplate" name="SubscribeTemplate" folder="Templates/ForumV2/Other"
													runat="server"></dw:filemanager></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Template afmeld abonnement")%></td>
											<td><dw:filemanager id="fmUnSubscribeTemplate" name="UnSubscribeTemplate" folder="Templates/ForumV2/Other"
													runat="server"></dw:filemanager></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Template file upload")%></td>
											<td><dw:filemanager id="fmUploadFileTemplate" name="UploadFileTemplate" folder="Templates/ForumV2/Other"
													runat="server"></dw:filemanager></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Template files list")%></td>
											<td><dw:filemanager id="fmListFilesTemplate" name="ListFilesTemplate" folder="Templates/ForumV2/Other"
													runat="server"></dw:filemanager></td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>
									<dw:groupboxstart id="CustomTextsStart" Title="Brugerdefinerede_tekster" runat="server"></dw:groupboxstart>
									<table cellspacing="0" cellpadding="2" border="0" width="100%">
										<tr>
											<td width="170"><%=Translate.Translate("Ingen adgang til indhold")%></td>
											<td><input type="text" class="std" name="ErrorNoAccess" id="ErrorNoAccess" value="<%=Base.ChkString(_properties.Value("ErrorNoAccess")) %>"></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Lukket tråd")%></td>
											<td><input type="text" class="std" name="ErrorThreadClosed" id="ErrorThreadClosed" value="<%=Base.ChkString(_properties.Value("ErrorThreadClosed")) %>"></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Anonym posting nægtet")%></td>
											<td><input type="text" class="std" name="ErrorAnonymousPostsDenied" id="ErrorAnonymousPostsDenied" value="<%=Base.ChkString(_properties.Value("ErrorAnonymousPostsDenied")) %>"></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Bruger udelukket")%></td>
											<td><input type="text" class="std" name="ErrorUserBanned" id="ErrorUserBanned" value="<%=Base.ChkString(_properties.Value("ErrorUserBanned")) %>"></td>
										</tr>
										<tr>
											<td><%=Translate.Translate("Hidden") & " " & Translate.Translate("indhold")%></td>
											<td><input type="text" class="std" name="CustomHiddenContent" id="CustomHiddenContent" value="<%=Base.ChkString(_properties.Value("CustomHiddenContent")) %>"></td>
										</tr>
									</table>
								</td>
							</tr>
							<%--<tr>
							    <td>
							    <dw:groupboxstart id="FilterStringsStart" Title="Filter strings" runat="server"></dw:groupboxstart>
							    <table cellspacing="0" cellpadding="2" border="0" width="100%">
							    <tr>
									<td width="170"><%=Translate.Translate("All")%></td>
									<td><input type="text" class="std" name="FilterString0" id="FilterString0" value="<%=Base.ChkString(_properties.Value("FilterString0")) %>"></td>
								</tr>
							    <tr>
									<td width="170"><%=Translate.Translate("Filter by 1 day")%></td>
									<td><input type="text" class="std" name="FilterString1" id="FilterString1" value="<%=Base.ChkString(_properties.Value("FilterString1")) %>"></td>
								</tr>
								<tr>
									<td width="170"><%=Translate.Translate("Filter by 2 days")%></td>
									<td><input type="text" class="std" name="FilterString2" id="FilterString2" value="<%=Base.ChkString(_properties.Value("FilterString2")) %>"></td>
								</tr>
								<tr>
									<td width="170"><%=Translate.Translate("Filter by 3 days")%></td>
									<td><input type="text" class="std" name="FilterString3" id="FilterString3" value="<%=Base.ChkString(_properties.Value("FilterString3")) %>"></td>
								</tr>
								<tr>
									<td width="170"><%=Translate.Translate("Filter by 1 week")%></td>
									<td><input type="text" class="std" name="FilterString7" id="FilterString7" value="<%=Base.ChkString(_properties.Value("FilterString7")) %>"></td>
								</tr>
								<tr>
									<td width="170"><%=Translate.Translate("Filter by 2 weeks")%></td>
									<td><input type="text" class="std" name="FilterString14" id="FilterString14" value="<%=Base.ChkString(_properties.Value("FilterString14")) %>"></td>
								</tr>
								<tr>
									<td width="170"><%=Translate.Translate("Filter by 1 month")%></td>
									<td><input type="text" class="std" name="FilterString30" id="FilterString30" value="<%=Base.ChkString(_properties.Value("FilterString30")) %>"></td>
								</tr>
								<tr>
									<td width="170"><%=Translate.Translate("Filter by 2 months")%></td>
									<td><input type="text" class="std" name="FilterString60" id="FilterString60" value="<%=Base.ChkString(_properties.Value("FilterString60")) %>"></td>
								</tr>
								<tr>
									<td width="170"><%=Translate.Translate("Filter by 3 months")%></td>
									<td><input type="text" class="std" name="FilterString90" id="FilterString90" value="<%=Base.ChkString(_properties.Value("FilterString90")) %>"></td>
								</tr>
								<tr>
									<td width="170"><%=Translate.Translate("Filter by 6 months")%></td>
									<td><input type="text" class="std" name="FilterString180" id="FilterString180" value="<%=Base.ChkString(_properties.Value("FilterString180")) %>"></td>
								</tr>
								<tr>
									<td width="170"><%=Translate.Translate("Filter by 1 year")%></td>
									<td><input type="text" class="std" name="FilterString365" id="FilterString365" value="<%=Base.ChkString(_properties.Value("FilterString365")) %>"></td>
								</tr>
									</table>
								</td>
							</tr>--%>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%
	Translate.GetEditOnlineScript()
%>