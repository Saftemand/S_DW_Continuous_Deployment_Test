<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" Codebehind="Weblog_edit.aspx.vb"
    Inherits="Dynamicweb.Admin.Weblog.Weblog_edit" %>

<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb" %>

<script language="javascript">
    function SwitchViewType(isDefault)
    {
        document.getElementById('ptPosts').style.display = isDefault ? 'none' : '';
    }
    function IsAllowCreateBlogs(check)
    {
        document.getElementById('MaxNumberBlogsDIV').style.display = check.checked ? '' : 'none';
    }
</script>

<dw:ModuleHeader ID="Weblog" ModuleSystemName="Weblog" ShowButtons="true" runat="server">
</dw:ModuleHeader>
<input type="hidden" value="LastArticlesTemplate, MaxBlogs, BlogsLogPage, BlogsList, BlogsToInclude, BlogsToLog, BlogsViewType, BlogsLogSize, CommentsAmount, AllowCommentsRestriction, PageCount, PageSize, PageTemplate, PageElementTemplate, PageElementSelectedTemplate, LoginTemplate, EditProfileTemplate, MainMenuTemplate, AddLinkTemplate, ListBlogTemplate, ListCategoryTemplate, ListArticleTemplate, ListArchiveTemplate, ShowArticleTemplate, ListCommentTemplate, EditCommentTemplate, SearchTemplate, SearchResultsTemplate, EditRowTemplate, EditBlogTemplate, EditArticleTemplate, ShowArticleEditTemplate, CommentingDeniedTemplate, UserInfoTemplate, PermissionDeniedTemplate, ForgotPasswordTemplate, PasswordSentTemplate, EmailedPasswordTemplate, EditCategoryTemplate, AddSubscriberTemplate, SubscriberAddedTemplate, ListTeamTemplate, EditTeamTemplate, StylesFile, EmailActivation, NotifyTemplate, AllowCreateBlogs, ImageFolder"
    name="Weblog_settings">

<table id="Table1" cellspacing="0" cellpadding="2" width="598" border="0">
    <tr>
        <td>
            <table id="Table2" cellspacing="0" cellpadding="0" width="598" border="0">
                <tr>
                    <td>
                        <dw:GroupBoxStart ID="SettingsStart" Title="Indstillinger" runat="server"></dw:GroupBoxStart>
                        <table id="Table3" cellspacing="0" cellpadding="2" border="0" width="100%">
                            <tr>
                                <td>
                                    <dw:GroupBoxStart ID="ViewStart" Title="View type" runat="server" />
                                    <table id="Table4" cellspacing="0" cellpadding="2" border="0" width="100%">
                                        <tr align="left">
                                            <td width="200">
                                                <dw:TranslateLabel ID="ViewTypeLabel" Text="View type" runat="server" />
                                            </td>
                                            <td align="left">
                                                <input onclick="SwitchViewType(true);" type="radio" name="BlogsViewType" id="vtDefault"
                                                    value="Default" <%=base.iif(blogsviewtype.tolower() = "default", "checked", "")%> /><label
                                                        for="vtDefault"><dw:TranslateLabel ID="vtDefaultLabel" Text="Default" runat="server" />
                                                    </label>
                                                &nbsp;
                                                <input onclick="SwitchViewType(false);" type="radio" name="BlogsViewType" id="vtPosts"
                                                    value="Posts" <%=base.iif(blogsviewtype.tolower() = "posts", "checked", "")%> /><label
                                                        for="vtPosts"><dw:TranslateLabel ID="vtPostsLabel" Text="Latest posts" runat="server" />
                                                    </label>
                                            </td>
                                        </tr>
                                    </table>
                                    <table cellspacing="0" cellpading="0" width="100%" runat="server" id="ptPosts" name="ptPosts">
                                        <tr>
                                            <td width="200">
                                                <dw:TranslateLabel ID="MaxListSizeLabel" Text="Max list size" runat="server" />
                                            </td>
                                            <td>
                                                <input type="text" class="std" id="BlogsLogSize" name="BlogsLogSize" value="<%=BlogsLogSize %>" /></td>
                                        </tr>
                                        <tr>
                                            <td width="200">
                                                <dw:TranslateLabel ID="LogPageLabel" Text="Link page" runat="server" />
                                            </td>
                                            <td>
                                                <%=Gui.LinkManager(BlogsLogPage, "BlogsLogPage", "")%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="200" valign="top">
                                                <dw:TranslateLabel ID="BlogsToLogLabel" Text="Include posts from blogs" runat="server" />
                                            </td>
                                            <td>
                                                <asp:repeater id="rptBlogsToLog" runat="server">
						                            <ItemTemplate>
						                                <input type="checkbox" id="BlogsToLog" name="BlogsToLog" value='<%#DataBinder.Eval(Container.DataItem,"ID")%>' <%#CheckedBlogLog(DataBinder.Eval(Container.DataItem,"ID"))%> />
											                <%#DataBinder.Eval(Container.DataItem,"Name")%>
											            <br/>    
						                            </ItemTemplate>
						                        </asp:repeater>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr runat="server" id="pPaging" name="pPaging">
                                <td>
                                    <dw:GroupBoxStart ID="PagingStart" Title="Sideinddeling" runat="server"></dw:GroupBoxStart>
                                    <table id="Table5" cellspacing="0" cellpadding="2" border="0" width="100%">
                                        <tr>
                                            <td width="200">
                                                <dw:TranslateLabel ID="PageCountLabel" Text="Sider" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;&nbsp;<input type="text" class="std" name="PageCount" id="PageCount" value="<%=PageCount%>"></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="PageSizeLabel" Text="Antal" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;&nbsp;<input type="text" class="std" name="PageSize" id="PageSize" value="<%=PageSize%>"></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dw:GroupBoxStart ID="FeaturesStart" Title="Funktioner" runat="server"></dw:GroupBoxStart>
                                    <table cellspacing="0" cellpading="2" border="0" width="100%">
                                        <tr>
                                            <td width="200">
                                                <dw:TranslateLabel ID="AllowCommentsRestrictionLabel" Text="Kommentarer" runat="server">
                                                </dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;&nbsp;<input type="checkbox" name="AllowCommentsRestriction" id="AllowCommentsRestriction"
                                                    value="checked" <%=allowcommentsrestriction%> onclick="javascript:document.getElementById('CommentsAmount').disabled = !document.getElementById('CommentsAmount').disabled"></td>
                                        </tr>
                                        <tr>
                                            <td width="200">
                                                <dw:TranslateLabel ID="CommentsAmountLabel" Text="Antal kommentarer" runat="server">
                                                </dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;&nbsp;<input type="text" <%=commentsamountdisabled%> class="std" name="CommentsAmount"
                                                    id="CommentsAmount" value="<%=CommentsAmount%>"></td>
                                        </tr>
                                        <tr>
                                            <td width="200">
                                                <dw:TranslateLabel ID="EmailActivationLabel" Text="Email activation" runat="server">
                                                </dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;&nbsp;<input type="checkbox" name="EmailActivation" id="EmailActivation" value="on"
                                                    <%=base.iif(emailactivation.length > 0, "checked", string.empty) %>></td>
                                        </tr>
                                        <tr>
                                            <td width="200">
                                                <dw:TranslateLabel ID="ImageFolderLabel" Text="Image folder" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FolderManager ID="fmImageFolder" Name="ImageFolder" runat="server"></dw:FolderManager>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="200">
                                                <dw:TranslateLabel ID="EditorStylesFileLabel" Text="Custom editor styles file" runat="server">
                                                </dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmStylesFile" Name="StylesFile" Folder="Templates/Weblog"
                                                    Extensions="xml" runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="pBlogs" name="pBlogs" runat="server">
                                <td>
                                    <dw:GroupBoxStart ID="BlogsStart" Title="Blogs" runat="server"></dw:GroupBoxStart>
                                    <table id="Table5" cellspacing="0" cellpadding="2" border="0" width="100%">
                                        <tr>
                                            <td width="200" valign="top">
                                                <dw:TranslateLabel runat="server" Text="Allow create blogs" />
                                            </td>
                                            <td>
                                                <input type="checkbox" onclick="IsAllowCreateBlogs(this);" name="AllowCreateBlogs"
                                                    id="AllowCreateBlogs" value="on" <%=base.iif(AllowCreateBlogs.length > 0, "checked", string.empty) %>>
                                                    <br />
                                                <div id="MaxNumberBlogsDIV" style="display:<%=base.iif(AllowCreateBlogs.length > 0, "", "none") %>">
                                                    <dw:TranslateLabel ID="DraftLabel" runat="server" Text="Max number" />
                                                    &nbsp;<input type="text" class="std" id="MaxBlogs" name="MaxBlogs" maxlength="4" style="width:50px;" value="<%=MaxBlogs%>">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top">
                                                <dw:TranslateLabel ID="Translatelabel2" runat="server" Text="Blogs to include" />
                                            </td>
                                            <td>
                                                <asp:repeater id="rptBlogsToInclude" runat="server">
													<ItemTemplate>
														<input type="checkbox" <%#CheckedBlog(DataBinder.Eval(Container.DataItem,"ID"))%> id="BlogToInclude" name="BlogsToInclude" value='<%#DataBinder.Eval(Container.DataItem,"ID")%>'>
														<%#DataBinder.Eval(Container.DataItem,"Name")%>
														<br/>
													</ItemTemplate>
												</asp:repeater>
                                                <asp:repeater id="rptBlogsList" runat="server">
													<ItemTemplate>
														<input type="hidden" name="BlogsList" value='<%#DataBinder.Eval(Container.DataItem,"ID")%>'>
													</ItemTemplate>
												</asp:repeater>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <dw:GroupBoxStart ID="TemplateStart" Title="Templates" runat="server"></dw:GroupBoxStart>
                        <table id="Table3" cellspacing="0" cellpadding="2" border="0" width="100%">
                            <tr id="tsBlogs" name="tsBlogs" runat="server">
                                <td>
                                    <dw:GroupBoxStart ID="BlogsTemplates" Title="Blogs" runat="server"></dw:GroupBoxStart>
                                    <table id="Table5" cellspacing="0" cellpadding="2" border="0" width="100%">
                                        <tr>
                                            <td width="200">
                                                <dw:TranslateLabel ID="ListBlogTemplateLabel" Text="Liste" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmListBlogTemplate" Name="ListBlogTemplate" Folder="Templates/Weblog/Blogs"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="EditBlogTemplateLabel" Text="Rediger" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmEditBlogTemplate" Name="EditBlogTemplate" Folder="Templates/Weblog/Blogs"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="tsCategories" name="tsCategories" runat="server">
                                <td>
                                    <dw:GroupBoxStart ID="CategoryTemplates" Title="Kategorier" runat="server"></dw:GroupBoxStart>
                                    <table id="Table6" cellspacing="0" cellpadding="2" border="0" width="100%">
                                        <tr>
                                            <td width="200">
                                                <dw:TranslateLabel ID="ListCategoryTemplateLabel" Text="Liste" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmListCategoryTemplate" Name="ListCategoryTemplate" Folder="Templates/Weblog/Categories"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="EditCategoryTemplateLabel" Text="Rediger" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmEditCategoryTemplate" Name="EditCategoryTemplate" Folder="Templates/Weblog/Categories"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dw:GroupBoxStart ID="ArticleTemplates" Title="Artikler" runat="server"></dw:GroupBoxStart>
                                    <table id="Table7" cellspacing="0" cellpadding="2" border="0" width="100%">
                                        <tr id="tLastArticles" name="tLastArticles" runat="server">
                                            <td width="200">
                                                <dw:TranslateLabel ID="Translatelabel1" Text="Latest posts" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmLastArticlesTemplate" Name="LastArticlesTemplate" Folder="Templates/Weblog/Articles"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                        <tr id="tListArticles" name="tListArticles" runat="server">
                                            <td width="200">
                                                <dw:TranslateLabel ID="ListArticleTemplateLabel" Text="Liste" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmListArticleTemplate" Name="ListArticleTemplate" Folder="Templates/Weblog/Articles"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="ShowArticleTemplateLabel" Text="Vis" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmShowArticleTemplate" Name="ShowArticleTemplate" Folder="Templates/Weblog/Articles"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="EditArticleTemplateLabel" Text="Rediger" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmEditArticleTemplate" Name="EditArticleTemplate" Folder="Templates/Weblog/Articles"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                        <tr id="tListArchive" name="tListArchive" runat="server">
                                            <td>
                                                <dw:TranslateLabel ID="ListArchiveTemplateLabel" Text="Arkiv" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmListArchiveTemplate" Name="ListArchiveTemplate" Folder="Templates/Weblog/Articles"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dw:GroupBoxStart ID="CommentTemplates" Title="Kommentarer" runat="server"></dw:GroupBoxStart>
                                    <table id="Table9" cellspacing="0" cellpadding="2" border="0" width="100%">
                                        <tr>
                                            <td width="200">
                                                <dw:TranslateLabel ID="ListCommentTemplateLabel" Text="Liste" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmListCommentTemplate" Name="ListCommentTemplate" Folder="Templates/Weblog/Comments"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="EditCommentTemplateLabel" Text="Rediger" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmEditCommentTemplate" Name="EditCommentTemplate" Folder="Templates/Weblog/Comments"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="CommentingDeniedTemplateLabel" Text="Ingen adgang" runat="server">
                                                </dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmCommentingDeniedTemplate" Name="CommentingDeniedTemplate"
                                                    Folder="Templates/Weblog/Comments" runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dw:GroupBoxStart ID="SearchTemplates" Title="Søg" runat="server"></dw:GroupBoxStart>
                                    <table id="Table10" cellspacing="0" cellpadding="2" border="0" width="100%">
                                        <tr>
                                            <td width="200">
                                                <dw:TranslateLabel ID="SearchTemplateLabel" Text="Søg" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmSearchTemplate" Name="SearchTemplate" Folder="Templates/Weblog/Search"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="SearchResultsTemplateLabel" Text="Søgeresultat" runat="server">
                                                </dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmSearchResultsTemplate" Name="SearchResultsTemplate" Folder="Templates/Weblog/Search"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="tsShared" name="tsshared" runat="server">
                                <td>
                                    <dw:GroupBoxStart ID="SharedTemplates" Title="Delt blog" runat="server"></dw:GroupBoxStart>
                                    <table id="Table21" cellspacing="0" cellpadding="2" border="0" width="100%">
                                        <tr>
                                            <td width="200">
                                                <dw:TranslateLabel ID="ListTeamTemplateLabel" Text="Liste" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmListTeamTemplate" Name="ListTeamTemplate" Folder="Templates/Weblog/Shared"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="EditTeamTemplateLabel" Text="Rediger" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmEditTeamTemplate" Name="EditTeamTemplate" Folder="Templates/Weblog/Shared"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dw:GroupBoxStart ID="AuthorizedTemplates" Title="Autoriseret" runat="server"></dw:GroupBoxStart>
                                    <table id="Table11" cellspacing="0" cellpadding="2" border="0" width="100%">
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="LoginTemplateLabel" Text="Login" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmLoginTemplate" Name="LoginTemplate" Folder="Templates/Weblog/Authorized"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="EditProfileTemplateLabel" Text="Rediger profil" runat="server">
                                                </dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmEditProfileTemplate" Name="EditProfileTemplate" Folder="Templates/Weblog/Authorized"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="200">
                                                <dw:TranslateLabel ID="ForgotPasswordTemplateLabel" Text="Glemt kodeord" runat="server">
                                                </dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmForgotPasswordTemplate" Name="ForgotPasswordTemplate"
                                                    Folder="Templates/Weblog/Authorized" runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="PasswordSentTemplateLabel" Text="Kodeord sendt" runat="server">
                                                </dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmPasswordSentTemplate" Name="PasswordSentTemplate" Folder="Templates/Weblog/Authorized"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="EmailedPasswordTemplateLabel" Text="Glemt kodeord e-mail"
                                                    runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmEmailedPasswordTemplate" Name="EmailedPasswordTemplate"
                                                    Folder="Templates/Weblog/Authorized" runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="UserInfoTemplateLabel" Text="Brugerprofil" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmUserInfoTemplate" Name="UserInfoTemplate" Folder="Templates/Weblog/Authorized"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="PermissionDeniedTemplateLabel" Text="Ingen adgang" runat="server">
                                                </dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmPermissionDeniedTemplate" Name="PermissionDeniedTemplate"
                                                    Folder="Templates/Weblog/Authorized" runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="NotifyTemplateLabel" Text="Notify" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmNotifyTemplate" Name="NotifyTemplate" Folder="Templates/Weblog/Authorized"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dw:GroupBoxStart ID="SubscribtionTemplates" Title="Abonnement" runat="server"></dw:GroupBoxStart>
                                    <table id="Table16" cellspacing="0" cellpadding="2" border="0" width="100%">
                                        <tr>
                                            <td width="200">
                                                <dw:TranslateLabel ID="AddSubscriberTemplateLabel" Text="Tilføj abonnent" runat="server">
                                                </dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmAddSubscriberTemplate" Name="AddSubscriberTemplate" Folder="Templates/Weblog/Subscription"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="200">
                                                <dw:TranslateLabel ID="SubscriberAddedTemplateLabel" Text="Abonnent tilføjet" runat="server">
                                                </dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmSubscriberAddedTemplate" Name="SubscriberAddedTemplate"
                                                    Folder="Templates/Weblog/Subscription" runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr id="tsPaging" name="tsPaging" runat="server">
                                <td>
                                    <dw:GroupBoxStart ID="PagingTemplates" Title="Sideinddeling" runat="server"></dw:GroupBoxStart>
                                    <table id="Table16" cellspacing="0" cellpadding="2" border="0" width="100%">
                                        <tr>
                                            <td width="200">
                                                <dw:TranslateLabel ID="PageTemplateLabel" Text="Side" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmPageTemplate" Name="PageTemplate" Folder="Templates/Weblog/Paging"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="PageElementTemplateLabel" Text="Element" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmPageElementTemplate" Name="PageElementTemplate" Folder="Templates/Weblog/Paging"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dw:TranslateLabel ID="PageElementSelectedTemplateLabel" Text="Valgt element" runat="server">
                                                </dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmPageElementSelectedTemplate" Name="PageElementSelectedTemplate"
                                                    Folder="Templates/Weblog/Paging" runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dw:GroupBoxStart ID="OtherTemplates" Title="Øvrigt" runat="server"></dw:GroupBoxStart>
                                    <table id="Table12" cellspacing="0" cellpadding="2" border="0" width="100%">
                                        <tr>
                                            <td width="200">
                                                <dw:TranslateLabel ID="AddLinkTemplateLabel" Text="Tilføj link" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmAddLinkTemplate" Name="AddLinkTemplate" Folder="Templates/Weblog/Other"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="200">
                                                <dw:TranslateLabel ID="EditRowTemplateLabel" Text="Rediger" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmEditRowTemplate" Name="EditRowTemplate" Folder="Templates/Weblog/Other"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="200">
                                                <dw:TranslateLabel ID="MainMenuTemplateLabel" Text="Hovedmenu" runat="server"></dw:TranslateLabel>
                                            </td>
                                            <td>
                                                &nbsp;<dw:FileManager ID="fmMainMenuTemplate" Name="MainMenuTemplate" Folder="Templates/Weblog/Other"
                                                    runat="server"></dw:FileManager>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
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
