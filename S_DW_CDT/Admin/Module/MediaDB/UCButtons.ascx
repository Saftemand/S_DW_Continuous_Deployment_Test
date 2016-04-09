<%@ Control Language="vb" AutoEventWireup="false" Codebehind="UCButtons.ascx.vb" Inherits="Dynamicweb.Admin.MediaDB.UCButtons" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>


<script type="text/javascript" src="UCButtons.js"></script>
    <dw:Toolbar ID="Toolbar1" runat="server" ShowStart="true" ShowEnd="false">
	    <dw:ToolbarButton ID="ToolbarButton1" runat="server" ImagePath="/Admin/Images/Icons/CategoryAdd_small.gif" Text="Ny gruppe" ShowText="true" OnClientClick="NewGroup();">
	    </dw:ToolbarButton>
	    <dw:ToolbarButton ID="ToolbarButton5" runat="server" ImagePath="/Admin/Images/Icons/Module_Search_small.gif" Text="Søg" ShowText="true" OnClientClick="Search();">
	    </dw:ToolbarButton>
	    <dw:ToolbarButton ID="ToolbarButton4" runat="server" ImagePath="/Admin/Images/Icons/Module_Filepublish_small.png" Text="Indbakke" ShowText="true" OnClientClick="Inbox();">
	    </dw:ToolbarButton>
	    <dw:ToolbarButton ID="ToolbarButton2" runat="server" ImagePath="/Admin/Images/Icons/Module_PictureDB_Small.gif" Text="Thumbnails" ShowText="true" OnClientClick="Thumbnails();">
	    </dw:ToolbarButton>
	    <dw:ToolbarButton ID="ToolbarButton3" runat="server" ImagePath="/Admin/Images/Icons/Module_Form_small.gif" Text="Felter" ShowText="true" OnClientClick="Fields();">
	    </dw:ToolbarButton>
	    <dw:ToolbarButton ID="ToolbarButton6" runat="server" ImagePath="/Admin/Images/Icons/Media_Orientation_small.gif" Text="Orientering" ShowText="true" OnClientClick="Orientation();">
	    </dw:ToolbarButton>
        <dw:ToolbarButton ID="ToolbarButton7" runat="server" ImagePath="/Admin/Images/Icons/Media_Types_small.gif" Text="Medietyper" ShowText="true" OnClientClick="Mediatypes();">
	    </dw:ToolbarButton>
    </dw:Toolbar>

<%Translate.GetEditOnlineScript()%>