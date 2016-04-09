<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Accordion.ascx.vb" Inherits="Dynamicweb.Admin.Accordion" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%
	Dim isFirefox as boolean = false
    If Request.ServerVariables("HTTP_USER_AGENT").Contains("MSIE 10") OrElse _
        Request.ServerVariables("HTTP_USER_AGENT").Contains("Firefox") OrElse _
        Request.ServerVariables("HTTP_USER_AGENT").Contains("Safari") OrElse _
        Request.ServerVariables("HTTP_USER_AGENT").Contains("Chrome") OrElse _
        Request.ServerVariables("HTTP_USER_AGENT").Contains("Opera") OrElse _
        Request.ServerVariables("HTTP_USER_AGENT").Contains("Trident/7.0") Then 'For IE 11
        isFirefox = True
    End If
 %>
 <link rel="Stylesheet" href="/Admin/Images/Ribbon/UI/Accordion/Accordion.css" />
<script type="text/javascript">
    function hidePageFrame() {
        //	if (top.document.getElementById("MainFrame"))
        top.document.getElementById("MainFrame").cols = "0,*";
        if (document.getElementById("treeContainer")) {
			document.getElementById("treeContainer").style.display = "";
        }
	}
    function showPageFrame() {
	    var isMenu = location.toString().toLowerCase().indexOf("admin/menu.aspx") > 0;
		if (!isMenu) {
		    var cols = top.leftWidth + ",*";
		    //if (top.document.getElementById("MainFrame")) 
		    top.document.getElementById("MainFrame").cols = cols;
			if (document.getElementById("treeContainer")) {
				document.getElementById("treeContainer").style.display = "none";
			}
			if (document.getElementById("accordion1")) {
				document.getElementById("accordion1").style.display = "none";
			}
		}
	}

	function page() {
	    showPageFrame();
	    top.left.restoreLastSelectedPage();

		//top.left.location = "/Admin/Menu.aspx";
		//top.right.location = "/Admin/Content/ParagraphList.aspx"; 
	}

	function pageSplitTest(pageID,areaID) {
	    var cols = top.leftWidth + ",*";
	    top.document.getElementById("MainFrame").cols = cols;
	    top.left.location = "/Admin/Menu.aspx?ID=" + pageID + "&AreaID=" + areaID;
	    top.right.location = "/Admin/Content/ParagraphList.aspx?PageID=" + pageID + "&OMCRedirect=true";
    }

    function openPage(pageID) {
        var cols = top.leftWidth + ",*";
        top.document.getElementById("MainFrame").cols = cols;
        top.right.location = "/Admin/Content/ParagraphList.aspx?PageID=" + pageID;
    }

    function openPageEdit(pageID) {
        var cols = top.leftWidth + ",*";
        top.document.getElementById("MainFrame").cols = cols;
        top.right.location = "/Admin/Content/PageEdit.aspx?ID=" + pageID + "&OMCRedirect=true";
    }


    function openParagraph(pageID, paragraphID) {
        var cols = top.leftWidth + ",*";
        top.document.getElementById("MainFrame").cols = cols;
        top.right.location = "/Admin/Content/ParagraphEdit.aspx?ID=" + paragraphID + "&PageID=" + pageID + "&OMCRedirect=true";
    }

    function openProduct(productID, groupID) {
        hidePageFrame();
        top.right.location = "/Admin/Module/eCom_Catalog/dw7/edit/EcomProduct_Edit.aspx?ID=" + productID + "&GroupID=" + groupID + "&OMCRedirect=true";
    }

    function openNews(newsID, categoryID) {
        var cols = top.leftWidth + ",*";
        top.document.getElementById("MainFrame").cols = cols;
        top.right.location = "/Admin/Module/NewsV2/Default.aspx?ID=" + newsID + "&CategoryID=" + categoryID + "&Open=true";
    }


    function filemanager() {
        top.right.location = "/Admin/FileManager/Browser/Default.aspx";
	}
	function userManagement() {
	    top.right.location = '/Admin/module/UserManagement/Main.aspx';
	}
	function editUser(userId) {
	    top.right.location = '/Admin/Module/Usermanagement/Main.aspx?UserID=' + userId;
	}
	function ecom() {
	    var isNewEcom = false;

	    if (top.dwtop && typeof (top.dwtop.Dynamicweb) != 'undefined') {
	        isNewEcom = top.dwtop.Dynamicweb.Globals.IsNewEcom;
	    }
	    
	    if(isNewEcom) {
		    top.right.location = "/Admin/module/eCom_Catalog/dw7/orderlist.aspx";
		} else {
		    showPageFrame();
		    top.right.location='/Admin/module/eCom_Catalog/EcomFrame.aspx';
		}
	}
	function modules() {
		top.right.location = "/Admin/Content/Moduletree/Default.aspx";
	}
	function mgmtcenter() {
		top.right.location = "/Admin/Content/Management/Default.aspx";
}

    function omc(openTo) {

        var url = '/Admin/Module/OMC/Default.aspx';
        
        if (openTo && openTo.length) {
            url += '?Open=' + encodeURIComponent(openTo);
        }

        top.right.location = url;    
    }             
</script>

<%If isFirefox Then%>
<div class="accordion" id="accordion1" style="width:248px;border-top:solid 1px #A0AFC3;<%If HideAccordion Then%>display:none;<%End If%>">
<%else %>
<div class="accordion" id="accordion1" style="width:249px;border-top:solid 1px #A0AFC3;<%If HideAccordion Then%>display:none;<%End If%>">
<%end if %>

	<ul style="border:solid 0px transparent;">
		<li id="btnPage" runat="server" onclick="page();"><a href="javascript:void(0);" style="border-top:solid 0px red;"><img src="/Admin/Images/Ribbon/Icons/Medium/document.png" /><%= Translate.Translate("Indhold")%></a></li>
		<li id="btnFilemanager" runat="server" onclick="filemanager();"><a href="javascript:void(0);" ><img src="/Admin/Images/Ribbon/Icons/Medium/folder.png" /><%=Translate.Translate("Files")%></a></li>
		
		<%If (Dynamicweb.Modules.UserManagement.License.IsUsingUserManagement() AndAlso (Base.HasAccess("UserManagementFrontend") OrElse Base.HasAccess("UserManagementBackend"))) OrElse (Base.HasAccess("EmailMarketing") AndAlso (Modules.UserManagement.User.GetCurrentUser().IsAdmin OrElse Modules.UserManagement.User.GetCurrentUser().IsBuiltInAdmin OrElse Modules.UserManagement.User.GetCurrentUser().IsAngel OrElse Modules.UserManagement.User.GetCurrentUser().AdministratorInGroups.Count > 0)) Then%>
		<li id="btnUserManagement" runat="server" onclick="userManagement();"><a href="javascript:void(0);"><img src="/Admin/Images/Ribbon/Icons/Medium/users.png" alt=""/><%=Translate.Translate("Users")%></a></li>
		<% End If%>
		
		<%
		If Dynamicweb.eCommerce.Common.Functions.IsEcom() Then
		%>
		<li id="btnEcom" runat="server" onclick="ecom();"><a href="javascript:void(0);" onclick="top.right.location='/Admin/module/eCom_Catalog/EcomFrame.aspx';"><img src="/Admin/Images/Ribbon/Icons/Medium/index.png" /><%=Translate.Translate("eCommerce")%></a></li>
		<%
		End If
		%>

        <% If ShowOMCTab Then%>
        <li id="btnOMC" runat="server" onclick="omc();">
            <a href="javascript:void(0);" onclick="top.right.location = '/Admin/Module/OMC/Default.aspx';">
                <img src="/Admin/Images/Icons/Module_OMC.png" width="24" height="24" alt="" title="" /><%=Translate.Translate("Marketing")%>
            </a>
        </li>
        <% End If%>
		<li id="btnModules" runat="server" onclick="modules();"><a href="javascript:void(0);"><img src="/Admin/Images/Ribbon/Icons/Medium/Module.png" /><%=Translate.Translate("Moduler")%></a></li>
		<% 			If Session("DW_Admin_UserType") < 3 OrElse Not Base.ChkBoolean(Base.GetGs("/Globalsettings/Settings/CustomerAccess/LockMgmtCenter")) Then%>
		<li id="btnmanagementcenter" runat="server" onclick="mgmtcenter();"><a href="javascript:void(0);"><img src="/Admin/Images/Ribbon/Icons/Medium/folder_gear.png" /><%=Translate.Translate("Management Center")%></a></li>
		<%End If%>
	</ul>
</div>
