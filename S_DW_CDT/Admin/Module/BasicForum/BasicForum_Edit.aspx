<%@ Page Language="vb" AutoEventWireup="false" Codebehind="BasicForum_Edit.aspx.vb" ValidateRequest="false" Inherits="Dynamicweb.Admin.BasicForum.BasicForum_Edit" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<!--@Start of file-->
<dw:ModuleHeader ID="ModuleHeader1" runat="server" ModuleSystemName="BasicForum"  />
<dw:ModuleSettings ID="ModuleSettings1" runat="server" ModuleSystemName="BasicForum" Value="CategoriesSelector, ListForumTemplate, OrderForumBy, ListThreadTemplate, ShowThreadTemplate, CreatePostTemplate, OrderBy, ShowAction, CategoryShow, CategoryID, SubjectPrefix, EditorWidth, EditorHeight, EditorConfiguration, EditorSkin, EditorStyles, EditorIncludes, PagingSetting, PostsPagingSetting, NewThreadCategoryID,NewsletterSubscriptionSender,NewsletterSubscriptionSubject,NewsletterSubscriptionIncludeMessageTitle,NewsletterSubscriptionTemplate,CanMarkAsAnswer" />
<%--<script type="text/javascript">
    function LoadScript(url) {
        document.write('<scr' + 'ipt type="text/javascript" src="' + url + '"><\/scr' + 'ipt>');
    }

    // Main editor scripts.
    var sSuffix = (/*@cc_on!@*/false) ? 'ie' : 'gecko';
    LoadScript('/Admin/Editor/editor/js/fckeditorcode_' + sSuffix + '.js');
</script>--%>
<script type="text/javascript" language="javascript" src="/Admin/Editor/editor/_source/internals/fckconfig.js"></script>
<script type="text/javascript" language="javascript" src="/Admin/Editor/fckconfig.js"></script>
<script type="text/javascript">
    function ActionChanged(){
	    if (document.forms.paragraph_edit.ShowAction[1].checked) {
	        document.getElementById("listForumSettings").style.display = "none";
	        document.getElementById("listSelectedCategories").style.display = "none";
	        document.getElementById("listThreadDefaultCategory").style.display = "block";
	    }
	    else{
	        document.getElementById("listForumSettings").style.display = "block";
	        document.getElementById("listSelectedCategories").style.display = "block";
	        document.getElementById("listThreadDefaultCategory").style.display = "none";
	    }
    }
    
    function getFields() {
        SelectionBox.getListItems("/Admin/Module/BasicForum/BasicForum_Edit.aspx?AJAXCMD=FILL_FIELDS", "CategoriesSelector");
    }

    function serializeCategories() {
        var fields = SelectionBox.getElementsRightAsArray("CategoriesSelector");
        var fieldsJSON = JSON.stringify(fields); // fields.toJSON(); 
        $("CategoryID").value = fieldsJSON;
    }

    function changeView() {
        getFields();
    }

    document.observe("dom:loaded", function () {
        var toolbars = FCKConfig.ToolbarSets;
        var toolBarArray = new Array();
        for (var toolbar in toolbars) {
            if (toolbar == '<%=toolbarType%>') {
                toolBarArray.unshift("<option value=\"" + toolbar + "\" selected >" + toolbar + "</option>");
            }
            else {
                toolBarArray.unshift("<option value=\"" + toolbar + "\">" + toolbar + "</option>");
            }
        }
        toolBarArray.sort();
        $("EditorConfiguration").update(toolBarArray.join(" "));
    });

    Event.observe(window, "load", function () {
        if (window.parent.$("myribbon") != null ) {
            var h = window.parent.document.documentElement.clientHeight - window.parent.$("myribbon").getHeight() - window.parent.$("formTable").getHeight() - window.parent.$("breadcrumb").getHeight();
            if (h < 0) h = 0;
            if (h >= 20) h -= 20;
            window.parent.$('ParagraphModule__Frame').setStyle({ height: h + 'px' });
        }
    }); 
</script>

<dw:GroupBox ID="GroupBox1" runat="server" Title="Display" DoTranslation="true">
	<table>
		<tr>
			<td style="width: 170px;">
			</td>
			<td>
				<dw:RadioButton ID="ShowActionListForums" runat="server" FieldName="ShowAction" FieldValue="ListForums" />
				    <dw:TranslateLabel id="lbListCategories" Text="List forum categories" runat="server" /><br />
				<dw:RadioButton ID="ShowActionListThreads" runat="server" FieldName="ShowAction" FieldValue="ListThreads" />
					<dw:TranslateLabel id="lbListThreads" Text="List forum threads" runat="server" /><br />
			</td>
		</tr>
	</table>
</dw:GroupBox>
<div id="listThreadDefaultCategory">
<dw:GroupBox ID="GroupBox7" runat="server" Title="Category" DoTranslation="true">
    <table cellpadding="1" cellspacing="1" border="0">
        <tr id="">
            <td style="width: 170px;">
                <dw:TranslateLabel id="lbCategory" Text="Category" runat="server" />
            </td>
            <td>
                <select ID="NewThreadCategoryID" name="NewThreadCategoryID" runat="server" class="std">
                </select>
            </td>
        </tr>
    </table>
</dw:GroupBox>
</div>
<div id="listSelectedCategories">
<dw:GroupBox ID="GBCategories" runat="server" Title="Categories" DoTranslation="true">
    <table cellpadding="1" cellspacing="1" border="0">
        <tr>
            <td>
                <dw:SelectionBox ID="CategoriesSelector" runat="server" />
                <input type="hidden" name="CategoryID" id="CategoryID" value="" runat="server" />
            </td>
        </tr>
    </table>
</dw:GroupBox>
</div>
<div id="listForumSettings">
	<dw:GroupBox ID="GroupBox4" runat="server" Title="List forum categories" DoTranslation="true">
		<table>
			<tr>
				<td style="width: 170px;">
					<dw:TranslateLabel id="lbTemplate1" Text="Template" runat="server" />
				</td>
				<td>
					<dw:FileManager ID="ListForumTemplate" runat="server" Folder="/Templates/BasicForum/ListForum" />
				</td>
			</tr>
			<tr>
				<td style="width: 170px;" valign="top">
					<dw:TranslateLabel id="lbOrderBy1" Text="Order by" runat="server" />
				</td>
				<td>
					<dw:RadioButton ID="OrderForumByCreatedDate" runat="server" FieldName="OrderForumBy" FieldValue="Created date" />
						<dw:TranslateLabel id="lbCreatedDate" Text="Created date" runat="server" /><br />
					<dw:RadioButton ID="OrderForumByName" runat="server" FieldName="OrderForumBy" FieldValue="Name" />
						<dw:TranslateLabel id="lbName" Text="Name" runat="server" /><br />
					<dw:RadioButton ID="OrderForumByReplies" runat="server" FieldName="OrderForumBy"
						FieldValue="Replies" />
						<dw:TranslateLabel id="lbReplyCount" Text="Reply count" runat="server" /><br />
					<dw:RadioButton ID="OrderForumByThreads" runat="server" FieldName="OrderForumBy"
						FieldValue="Threads" />
						<dw:TranslateLabel id="lbThreadCount" Text="Thread count" runat="server" /><br />
					<dw:RadioButton ID="OrderForumBySelectedCategories" runat="server" FieldName="OrderForumBy"
						FieldValue="Selected Categories" />
						<dw:TranslateLabel id="lbSelectedSortOrder" Text="Selected sort order" runat="server" /><br />
					<br />
				</td>
			</tr>
		</table>
	</dw:GroupBox>
</div>

<script type="text/javascript">
	document.getElementById("ShowActionListForums").onclick = ActionChanged;
	document.getElementById("ShowActionListThreads").onclick = ActionChanged;
ActionChanged();
</script>

<dw:GroupBox ID="GroupBox2" runat="server" Title="List threads" DoTranslation="true">
	<table>
		<tr>
			<td style="width: 170px;">
				<dw:TranslateLabel id="lbTemplate2" Text="Template" runat="server" />
			</td>
			<td>
				<dw:FileManager ID="ListThreadTemplate" runat="server" Folder="/Templates/BasicForum/ListThread" />
			</td>
		</tr>
		<tr>
			<td style="width: 170px;" valign="top">
				<dw:TranslateLabel id="lbOrderBy2" Text="Order by" runat="server" />
			</td>
			<td>
				<dw:RadioButton ID="OrderByCreated" runat="server" FieldName="OrderBy" FieldValue="Created" />
					<dw:TranslateLabel id="lbLastCreated" Text="Last created" runat="server" /><br />
				<dw:RadioButton ID="OrderByAnswered" runat="server" FieldName="OrderBy" FieldValue="Answered" />
					<dw:TranslateLabel id="lbLastAnswered" Text="Last answered" runat="server" /><br />
				<br />
			</td>
		</tr>
	</table>
</dw:GroupBox>
<dw:GroupBox ID="GroupBox5" runat="server" Title="Show thread" DoTranslation="true">
	<table>
		<tr>
			<td style="width: 170px;">
				<dw:TranslateLabel id="lbTemplate3" Text="Template" runat="server" />
			</td>
			<td>
				<dw:FileManager ID="ShowThreadTemplate" runat="server" Folder="/Templates/BasicForum/ShowThread" />
			</td>
		</tr>
	</table>
</dw:GroupBox>
<dw:GroupBox ID="Markasanswer" runat="server" Title="Answers" DoTranslation="true">
	<table>
		<tr>
			<td style="width: 170px;">
				<dw:TranslateLabel id="CanMark" Text="Who can mark post as Answer :" runat="server" />
			</td>
			<td>
                <select ID="CanMarkAsAnswer" name="CanMarkAsAnswer" runat="server" class="std">
                    <option ></option>
                    <option ></option>
                </select>
            </td>
		</tr>
	</table>
</dw:GroupBox>
<dw:GroupBox ID="GroupBox6" runat="server" Title="Create post" DoTranslation="true">
	<table>
		<tr>
			<td style="width: 170px;">
				<dw:TranslateLabel id="lbTemplate4" Text="Template" runat="server" />
			</td>
			<td>
				<dw:FileManager ID="CreatePostTemplate" runat="server" Folder="/Templates/BasicForum/CreatePost" />
			</td>
		</tr>
		<tr>
			<td style="width: 170px;">
				<dw:TranslateLabel id="lbSubjectPrefix" Text="Subject prefix" runat="server" />
			</td>
			<td>
				<input id="SubjectPrefix" name="SubjectPrefix" type="text" class="std" runat="server" />
			</td>
		</tr>
	</table>
</dw:GroupBox>
<dw:GroupBox ID="gbEditor" Title="Editor" runat="server" DoTranslation="true">
    <table>
        <tr>
            <td style="width: 170px">
                <dw:TranslateLabel id="lbWidth" Text="Width" runat="server" />
            </td>
            <td>
                <input type="text" id="EditorWidth" class="std" style="width: 50px" runat="server" />&nbsp;<dw:TranslateLabel id="lbPxWidth" Text="px" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <dw:TranslateLabel id="lbHeight" Text="Height" runat="server" />
            </td>
            <td>
                <input type="text" id="EditorHeight" class="std" style="width: 50px" runat="server" />&nbsp;<dw:TranslateLabel id="lbPxHeight" Text="px" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <dw:TranslateLabel id="lbSkin" Text="Farve_palet" runat="server" />
            </td>
            <td>
                <select id="EditorSkin" class="std" runat="server"></select>
            </td>
        </tr>
        <tr>
            <td>
                <dw:TranslateLabel id="lbEditorStyles" Text="Stylesheet" runat="server" />
            </td>
            <td>
                <dw:FileManager id="EditorStyles" Folder="Templates/BasicForum/CreatePost" Extensions="css" runat="server" />
            </td>
        </tr>
        <tr>
            <td>
                <dw:TranslateLabel id="lbToolbar" Text="Editor Configuration" runat="server" />
            </td>
            <td>
                <select id="EditorConfiguration" class="std" runat="server"></select>
            </td>
        </tr>
        <tr>
            <td>
                <dw:TranslateLabel id="lbInclude" Text="Medtag" runat="server" />
            </td>
            <td>
                <table>
                    <tr>
                        <td>
                            <dw:CheckBox ID="EditorIncludesSyntaxHighlighter" FieldName="EditorIncludes" Value="SyntaxHighlighter" runat="server" />&nbsp;
                            <label for="EditorIncludes">SyntaxHighlighter v3.0.83</label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</dw:GroupBox>

<dw:GroupBox ID="gbNewsletter" Title="Newsletter subscription" runat="server" DoTranslation="true">
   <input type="hidden" id="action" name="action">
            <table border="0" cellpadding="2" cellspacing="0">
                <tr>
                    <td style="width: 170px"><dw:TranslateLabel ID="lbFrom" Text="Afsender" runat="server" /></td>
                    <td>
                        <input type="text" class="std" name="NewsletterSubscriptionSender" 
                            value="<%=_prop("NewsletterSubscriptionSender")%>" />
                    </td>
                </tr> 
                <tr>
                    <td><dw:TranslateLabel ID="lbSubject" Text="Subject" runat="server" /></td>
                    <td>
                        <input type="text" class="std" name="NewsletterSubscriptionSubject" 
                            value="<%=_prop("NewsletterSubscriptionSubject")%>" />
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <div class="heading-row">
                            <input type="checkbox" id="chkIncludeTitle" name="NewsletterSubscriptionIncludeMessageTitle" value="True"
                                <%=Dynamicweb.Base.IIf(Dynamicweb.Base.ChkBoolean(_prop("NewsletterSubscriptionIncludeMessageTitle")), " checked=""checked""", "")%> />
                            <label for="chkIncludeTitle"><dw:TranslateLabel ID="lbIncludeTitle" Text="Include message title" runat="server" /></label>
                        </div>
                    </td>
                </tr>
                <tr><td>&nbsp;</td></tr>
                <tr>
                    <td><dw:TranslateLabel ID="lbTemplate" Text="Template" runat="server" /></td>
                    <td>
                        <dw:FileManager ID="NewsletterSubscriptionTemplate" runat="server" Folder="/Templates/BasicForum/Subscription" />
                    </td>
                </tr>
            </table>
 
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()
    %>
</dw:GroupBox>

<dw:PagingSettings ID="PagingSetting" runat="server" Title="Threads paging" />

<dw:PagingSettings ID="PostsPagingSetting" runat="server" Title="Posts paging" />


<script type="text/javascript">
    SelectionBox.setNoDataLeft("CategoriesSelector");
    SelectionBox.setNoDataRight("CategoriesSelector");
</script>

<!--@End of file-->