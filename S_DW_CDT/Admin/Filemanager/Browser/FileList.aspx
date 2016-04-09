<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Admin/Filemanager/Browser/EntryContent.Master"
    CodeBehind="FileList.aspx.vb" Inherits="Dynamicweb.Admin.FileList" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ MasterType TypeName="Dynamicweb.Admin.Browser.EntryContent" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript" src="FileListThumbnailView.js"></script>
    <script type="text/javascript" src="FileList.js"></script>
    <script type="text/javascript">        
        __page.onHelp = function() {
            <%=Gui.Help("filemanager", "modules.filearchive.general")%>
        }
        __page.folder = '<%=Base.JsEncode(Request("Folder"))%>';
        __page.deleteMsg = '<%=Translate.JsTranslate("Delete this file")%>';
        __page.restoreMsg = '<%=Translate.JsTranslate("Restore this file")%>';
        __page.deleteSeveralFilesMsg = '<%=Translate.JSTranslate("WARNING!")%>\n<%=Translate.JSTranslate("References to files will not be updated!")%>\n\n<%=Translate.JsTranslate("Delete selected files")%>';
        __page.restoteSeveralFilesMsg = '<%=Translate.JsTranslate("Restore selected files")%>';
        __page.thumbnailView = new ThumbnailView();  
        __page.isLinkManager = <%=Base.IIF(Base.HasAccess("LinkSearch", ""), "true", "false") %>;         

        <%if _listMode = ListMode.Thumbnails Then %>
            __page.thumbnailView.enabled = true;
        <%End If%>
       
        function onContextMenuView(sender, arg) {              
            if(__page.thumbnailView.enabled){
                var selectedRows = __page.thumbnailView.getSelectedRows();                
                if(__page.thumbnailView.rowIsSelected(arg.callingID) && selectedRows.length > 1) {
                    return "thumbnailMultiselect";
                }
                if (__page.isImage(arg.callingItemID))
                    return "thumbnailImage";
                else if (__page.isEditable(arg.callingItemID))
                    return "thumbnailEditable"
                return "thumbnailSimple";
            }
            else{
                var selectedRows = List.getSelectedRows('Files');
                var row = List.getRowByID('Files', arg.callingID);
                if(List.rowIsSelected(row) && selectedRows.length > 1) {
                    return "multiselect";
                }
                if (__page.isImage(arg.callingItemID))
                    return "image";
                else if (__page.isEditable(arg.callingItemID))
                    return "editable"
                return "simple";
            }
	    }

        function CreateSubfolder()
        {            
            parent.ContextMenu.callingItemID = __page.folder;            
            parent.showNewFolderDialog();
        }

        function RenameFolder()
        {
            parent.ContextMenu.callingItemID = __page.folder;
            parent.showRenameFolderDialog();
        }

        function RenameFile()
        {
            parent.ContextMenu.callingItemID = ContextMenu.callingItemID;
            parent.showRenameFileDialog();
        }

		function refreshContent() 
        {
		    parent.uploadRefresh = true;
            parent.refreshContent();
        }

		function reloadWindow(folderName)  
        {
            parent.reloadWindow(folderName);
        }

        function OpenPermissionsDialog(securityFolder)
        {            
            parent.ContextMenu.callingItemID = __page.folder;
            parent.permissions(securityFolder);            
        }

        function showImageSettings(workmode)
        {            
            var folderName = __page.folder.replace("\\", "/");
            var dialogInstance = parent.imageSettingsPopUp_wnd;            
            if (dialogInstance) {
                var url = '/Admin/Filemanager/Browser/ImageSettings.aspx?Path=' + encodeURIComponent(folderName) + '&workmode=' + workmode;
                var height = "480";
                if(workmode && workmode != "")
                    height = "300";

                dialogInstance.hide();                
                dialogInstance.set_contentUrl(url);
                dialogInstance.set_width("650");                
                dialogInstance.set_height(height);
                dialogInstance.show();
            }
        }

        function showNewFileDialog(ext) {            
            parent.ContextMenu.callingItemID = __page.folder;            
            parent.showNewFileDialog(ext);
        }

        function repeat(str, num)
        {
            return new Array(num + 1).join(str);
        }

        // Functions for select file mode
        var strCaller = "<%= BrowseCaller %>";
<%If BrowseMode = "browselinkcallback" Then%>
			function ChooseFile(strFile){

            	var fullPath = '<%= VirtualFolderInSelectMode %>/' + strFile;
				strFile = fullPath.substring( "/files".length, fullPath.length );

                // RunCallbackFunction should be defined by the caller:
                // var win = window.open('/Admin/Menu.aspx?Action=Internal&Callback=True');
                // win.RunCallbackFunction = function() {...};  
				top.RunCallbackFunction(strFile, strFile);
			    <% If CloseOnSelect %>
			    top.close();
                <% End If %>
			}

<%ElseIf BrowseMode = "browselink" Then%>
			function ChooseFile(strFile){

            	var fullPath = '<%= VirtualFolderInSelectMode %>/' + strFile;
				strFile = fullPath.substring( "/".length, fullPath.length );

				var selObj = top.opener.document.getElementById(strCaller);
				var selObj2 = top.opener.document.getElementById("Link_" + strCaller);
				selObj.value = strFile;
				selObj2.value = strFile;
				<% If CloseOnSelect %>
			    top.close();
                <% End If %>
			}
        <%ElseIf BrowseMode = "browse" AndAlso Request.QueryString("Caller") IsNot Nothing AndAlso (Request.QueryString("Caller") = "txtUrl" _
                                        OrElse Request.QueryString("Caller").EndsWith("_textInput")) Then%>//new editor input field id ends with textInput?
			function ChooseFile(strFile){
			    var strFolder = '<%= BrowseFolder %>';
				var fullPath = '<%= VirtualFolderInSelectMode %>/' + strFile;
                strFile = fullPath.substring('/Files'.length, fullPath.length);
				if ( !strFile.toLowerCase().startsWith(strFolder.toLowerCase())){
					strFile = ".." + strFile
				}

				var selObj = top.opener.document.getElementById(strCaller);
				selObj.value = fullPath;
			    <% If CloseOnSelect %>
			    top.close();
                <% End If %>
			}

<%ElseIf BrowseMode = "browse" Then %>
        function ChooseFile(strFile){
                var strFolder = '<%= BrowseFolder %>';
				var fullPath = '<%= VirtualFolderInSelectMode %>/' + strFile;
                strFile = fullPath.substring('/Files'.length, fullPath.length);
                if ( !strFile.toLowerCase().startsWith(strFolder.toLowerCase())){
                    var count = (strFolder.match(/\//g) || []).length;
                    if(count > 0){
                        strFile = repeat("../", count) + strFile.substring(1, strFile.length);
                    }
                }
                else{
                 // remove foldername + / from file name. folder / is special case, 
			        if (strFolder == "/")
			            strFile = strFile.substring(1, strFile.length);
			        else
				        strFile = strFile.substring(strFolder.length+1, strFile.length);
                }

				var selObj = top.opener.document.getElementById(strCaller);
				selObj.options.length = selObj.options.length + 1;
				selObj.options[selObj.options.length-1].value = strFile;
				selObj.options[selObj.options.length-1].text = strFile;
				selObj.options[selObj.options.length-1].setAttribute('fullPath', fullPath);
				selObj.selectedIndex = selObj.options.length-1;
				selObj.onchange();
				
                <% If CloseOnSelect %>
                top.close();
                <% End If %>
			}
			
<%ElseIf BrowseMode = "browseFullPath" Then %>
			function ChooseFile(strFile){
				
				var fullPath = '<%= VirtualFolderInSelectMode %>/' + strFile;
				strFile = fullPath.substring( "/files/".length, fullPath.length );

				var selObj = top.opener.document.getElementById(strCaller);
				selObj.options.length = selObj.options.length + 1;
				selObj.options[selObj.options.length-1].value = strFile;
				selObj.options[selObj.options.length-1].text = strFile;
				selObj.options[selObj.options.length-1].setAttribute('fullPath', fullPath);
				selObj.selectedIndex = selObj.options.length-1;
				selObj.onchange();
				
				<% If CloseOnSelect %>
			    top.close();
                <% End If %>
			}
<%ElseIf BrowseMode = "browseArchive" Then %>
			function ChooseFile(strFile){

				var fullPath = '<%= VirtualFolderInSelectMode %>/' + strFile;
				strFile = fullPath.substring( "/files".length, fullPath.length );

				var selObj;
				try { 
					selObj = top.opener.document.getElementById(strCaller);
    				selObj.value = strFile;
				} catch (e) { 
    				selObj = window.opener.document.forms[0][strCaller];
					selObj.value = strFile;
    			} 

				if(ContainsAttributeByName(selObj, "onfocus")) {
					try {
				    	selObj.onfocus();
				    }catch (e) {}
			    }
		    	if(ContainsAttributeByName(selObj, "onchange")) {
		    		try {
	    				selObj.onchange();
	    			}catch (e){}
    			}
    					
			    <% If CloseOnSelect %>
			    top.close();
                <% End If %>
			}
				
			function ContainsAttributeByName(element, attr) {
				var contains = false;
				    
				for(var i = 0; i < element.attributes.length; i++) {
				    if(element.attributes[i].nodeName == attr) {
				        contains = true;
				        break;
				    }
				}
				    
				return contains;
			}

<%ElseIf BrowseMode = "browseTemplate" Then %>
			function ChooseFile(strFile){
				var selObj = top.opener.document.getElementById(strCaller);
				selObj.value = strFile;
			    <% If CloseOnSelect %>
			    top.close();
                <% End If %>
		}						
<%End If%>
	

    </script>
    <style type="text/css">
        <%If _listMode = ListMode.Thumbnails Then%>
        .list .container tbody[id] tr.listRow:hover
        {
            background-color: #ffffff;
        }
        
        .list .container tbody[id] tr.selected td
        {
            background-color: #ffffff;
        }
        .header 
        {
            background: url("/Admin/Images/Ribbon/UI/List/Pipe.gif") repeat-x scroll left top transparent;
            cursor: default;
            width: 100%;
        }
        .header .columnCell
        {
            width:100%;   
        }
        small 
        {
            color: #999999;
        }
        .pipe
        {
            padding-left:3px;
            padding-right:3px;
        }
        <%End If%>
        
        .BottomInformation
        {
	        height:53px;
	        width:100%;
	        background-image:url('/Admin/Images/BottomInformationBg.png');
	        background-repeat:repeat-x;
	        position:fixed;
	        bottom:0px;
        }

        .BottomInformation table
        {
	        width:100%;
        }
        
        .BottomInformation tr
        {
	        height:26px;
        }

        .BottomInformation #icon
        {
	        margin:10px;
        }

        .BottomInformation .label
        {
	        color: #5A6779;
	        padding-left:5px;
	        padding-right:5px;
        }
        #ContentFrame
        {        	
        	overflow:hidden
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="min-width: 1000px; overflow: hidden">

    <dw:Toolbar ID="FilesToolbar" runat="server" ShowEnd="false" >
        <dw:ToolbarButton ID="tbDetailsView" Text="Details" ImagePath="/Admin/Filemanager/Icons/Details.gif" 
                         runat="server" OnClientClick="__page.setListMode('Details');" Divide="None"></dw:ToolbarButton>
        <dw:ToolbarButton ID="tbThumbnailsView" Text="Thumbnails" ImagePath="/Admin/Filemanager/Icons/Large.gif"
                        runat="server" OnClientClick="__page.setListMode('Thumbnails');" Divide="None"></dw:ToolbarButton>
        <dw:ToolbarButton ID="tbContentView" Text="Content" ImagePath="/Admin/Filemanager/Icons/Tiles.gif" 
                        runat="server" OnClientClick="__page.setListMode('Content');" Divide="None"></dw:ToolbarButton>
        <dw:ToolbarButton runat="server" Text="Upload" ID="tbUploadView" OnClientClick="__page.upload();" ImagePath="/Admin/Images/Ribbon/Icons/Small/folder_up.png"></dw:ToolbarButton>
    </dw:Toolbar>

        <dw:RibbonBar ID="FilesRibbonBar" runat="server" >
            <dw:RibbonBarTab ID="RibbonGeneralTab" Name="Content" runat="server" Visible="true">
                <dw:RibbonBarGroup ID="RibbonBarGroup1" Name="Tools" runat="server">
                    <dw:RibbonBarButton ID="btnRestore" Text="Restore" Title="Restore" Image="Undo" Size="Large" DoTranslate="true"
                        runat="server" OnClientClick="__page.restoreFile();" Disabled="true" Visible="false" />
                    <dw:RibbonBarButton ID="btnCopy" Text="Copy" Title="Copy" Image="Copy" Size="Small" DoTranslate="true"
                        runat="server" OnClientClick="__page.copy();" Disabled="true" />
                    <dw:RibbonBarButton ID="btnMove" Text="Move" Title="Move" Image="MoveDocument" Size="Small" DoTranslate="true"
                        runat="server" OnClientClick="__page.move();" Disabled="true" />
                    <dw:RibbonBarButton ID="btnDelete" Text="Delete" Title="Delete" Image="DeleteDocument" Size="Small" DoTranslate="true"
                        runat="server" OnClientClick="__page.deleteFile();" Disabled="true" />
                    <dw:RibbonBarButton ID="btnMetatags" Text="Metatags" Title="Metatags" ImagePath="/admin/Images/Icons/Module_Metadata_small.gif" DoTranslate="true"
                        Size="Small" runat="server" OnClientClick="__page.metadata();" Disabled="true" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonBarGroupInsert" Name="Insert" runat="server">
                    <dw:RibbonBarButton ID="btnUpload" Text="Upload" Title="Upload" Image="FolderUpload" DoTranslate="true"
                        Size="Large" runat="server" OnClientClick="__page.upload();" />
                    <dw:RibbonBarButton ID="btnNewFile" Text="New file" Title="New file" DoTranslate="true"
                        Image="TextCode_Add" Size="Small" runat="server" ContextMenuId="ContextMenuNewFile" SplitButton="true" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonBarGroup3" Name="View" runat="server">
                    <dw:RibbonBarRadioButton ID="rbDetailsView" Text="Details" ImagePath="/Admin/Filemanager/Icons/Details.gif"  DoTranslate="true"
                        Size="Small" runat="server" OnClientClick="__page.setListMode('Details');" Group="View">
                    </dw:RibbonBarRadioButton>
                    <dw:RibbonBarRadioButton ID="rbThumbnailsView" Text="Thumbnails" ImagePath="/Admin/Filemanager/Icons/Large.gif" DoTranslate="true"
                        Size="Small" runat="server" OnClientClick="__page.setListMode('Thumbnails');"
                        Group="View">
                    </dw:RibbonBarRadioButton>
                    <dw:RibbonBarRadioButton ID="rbContentView" Text="Content" ImagePath="/Admin/Filemanager/Icons/Tiles.gif"  DoTranslate="true"
                        Size="Small" runat="server" OnClientClick="__page.setListMode('Content');" Group="View">
                    </dw:RibbonBarRadioButton>
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonBarGroup4" Name="Folder" runat="server">
                    <dw:RibbonBarButton ID="btnNewSubfolder" Text="New subfolder" Title="New subfolder" DoTranslate="true"
                        Image="FolderAdd" Size="Small" runat="server" OnClientClick="CreateSubfolder();" />
                    <dw:RibbonBarButton ID="btnRename" Text="Omdøb" Title="Omdøb" OnClientClick="RenameFolder();" DoTranslate="true"
                        Image="FolderEdit" Size="Small" runat="server" />
                    <dw:RibbonBarButton ID="btnPermissions" Text="Permissions" Title="Permissions" ImagePath="/admin/module/ecom_catalog/dw7/images/content/ecom_user_permission_small.gif" DoTranslate="true"
                        Size="Small" runat="server">
                    </dw:RibbonBarButton>
                    <dw:RibbonbarButton ID="btnTranslateTemplate" Visible="False" Image="Convert" Size="Small" Text="Oversættelse" runat="server" OnClientClick="__page.translateTemplate();" />
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonBarGroup5" Name="Settings" runat="server">
                    <dw:RibbonBarButton ID="btnResize" Text="Resize images" Title="Resize images" Size="Small" ImagePath="/Admin/Images/Ribbon/Icons/Small/image_settings.png"
                        DoTranslate="true" runat="server" OnClientClick="showImageSettings('OnlyResize');" >
                    </dw:RibbonBarButton>
                    <dw:RibbonBarButton ID="btnAutogenerate" Text="Generate thumbnails" Title="Generate thumbnails" Size="Small" ImagePath="/Admin/Filemanager/Icons/Large.gif"
                        DoTranslate="true" runat="server" OnClientClick="showImageSettings('OnlyThumbnails');" >
                    </dw:RibbonBarButton>
                    <dw:RibbonBarButton ID="btnMetafields" Text="Metafields" Title="Metafields" Size="Small" ImagePath="/Admin/Images/Icons/Module_Metadata_small.gif"
                        DoTranslate="true" runat="server" OnClientClick="__page.metafields();">
                    </dw:RibbonBarButton>
                </dw:RibbonBarGroup>
                <dw:RibbonBarGroup ID="RibbonBarGroup10" Name="Help" runat="server">
                    <dw:RibbonBarButton ID="Help" Text="Help" Title="Help" Image="Help" Size="Large" DoTranslate="true"
                        runat="server" OnClientClick="__page.help();" />
                </dw:RibbonBarGroup>
            </dw:RibbonBarTab>
        </dw:RibbonBar>
    </div>
        <dw:StretchedContainer ID="OuterContainer" Scroll="Hidden" Stretch="Fill" Anchor="document"
        runat="server">     
            <dw:List runat="server" ID="Files" TranslateTitle="false" AllowMultiSelect="true"
                StretchContent="true" ShowPaging="false" OnClientSelect="rowSelected($('writeAccess').value);" HandlePagingManually="false"
                HandleSortingManually="true">
                <Filters>
                    <dw:ListTextFilter runat="server" ID="TextFilter" WaterMarkText="Search" Width="175"
                        ShowSubmitButton="True" Divide="None" />
                    <dw:ListFlagFilter ID="SearchInSubfoldersFilter" runat="server" Label=" Search in subfolders"
                        IsSet="false" Divide="none" LabelFirst="false" AutoPostBack="true" />
                    <dw:ListDropDownListFilter ID="PageSizeFilter" Width="150" Label="Files per page"
                        AutoPostBack="true" Priority="3" runat="server">
                        <Items>
                            <dw:ListFilterOption Text="30" Value="30" Selected="true" DoTranslate="false" />
                            <dw:ListFilterOption Text="50" Value="50" DoTranslate="false" />
                            <dw:ListFilterOption Text="75" Value="75" DoTranslate="false" />
                            <dw:ListFilterOption Text="100" Value="100" DoTranslate="false" />
                        </Items>
                    </dw:ListDropDownListFilter>
                </Filters>
            </dw:List> 
            
        <input id="FilesCurentPage" type="hidden" value="<% = me.pageNumber%>" />
        <input id="FilesSortBy" type="hidden" value="<% = me.SortBy%>" />
        <input id="FilesSortDir" type="hidden" value="<% =Me.SortDir%>" />
        <input id="writeAccess" type="hidden" value="<% =Me.writeAccess.ToString()%>" />
        <asp:HiddenField ID="SortByState" runat="server" />
        <asp:HiddenField ID="SortDirState" runat="server" />

        <!-- Context menu start -->
        <dw:ContextMenu ID="FilesContext" runat="server" OnClientSelectView="onContextMenuView">
            <dw:ContextMenuButton ID="PreviewButton" runat="server" Views="simple,editable,image,thumbnailSimple,thumbnailEditable,thumbnailImage"
                Image="Preview" OnClientClick="__page.preview('contextmenu');" Text="Preview" />
            <dw:ContextMenuButton ID="EditImageButton" runat="server" Views="image,thumbnailImage"
                Image="EditDocument" Text="Edit" OnClientClick="FileManagerPage.editImage();" />
            <dw:ContextMenuButton ID="EditButton" runat="server" Views="editable,thumbnailEditable"
                Image="EditDocument" Text="Edit" OnClientClick="__page.edit();" />
            <dw:ContextMenuButton runat="server" ID="ContextMenuButton2" Views="simple,editable,image,thumbnailSimple,thumbnailEditable,thumbnailImage"
                DoTranslate="True" Divide="Before" Image="RenameDocument" Text="Omdøb" OnClientClick="RenameFile();" />
            <dw:ContextMenuButton ID="MoveButton" runat="server" Views="simple,editable,image,multiselect,thumbnailSimple,thumbnailEditable,thumbnailImage,thumbnailMultiselect"
                Image="MoveDocument" OnClientClick="__page.move();" Text="Move" />
            <dw:ContextMenuButton ID="CopyButton" runat="server" Views="simple,editable,image,multiselect,thumbnailSimple,thumbnailEditable,thumbnailImage,thumbnailMultiselect"
                Image="Copy" OnClientClick="__page.copy();" Text="Copy" />
            <dw:ContextMenuButton ID="CopyHereButton" runat="server" Views="simple,editable,image,multiselect,thumbnailSimple,thumbnailEditable,thumbnailImage,thumbnailMultiselect"
                Image="Copy" OnClientClick="__page.copyHere();" Text="Copy here" />
            <dw:ContextMenuButton ID="DeleteButton" runat="server" Views="simple,editable,image,multiselect,thumbnailSimple,thumbnailEditable,thumbnailImage,thumbnailMultiselect"
                Image="DeleteDocument" Text="Delete" OnClientClick="__page.deleteFile();" />
            <dw:ContextMenuButton ID="OpenButton" runat="server" Views="simple,editable,image,thumbnailSimple,thumbnailEditable,thumbnailImage"
                Divide="Before" Image="View" OnClientClick="FileManagerPage.open();" Text="Open in browser" />
            <dw:ContextMenuButton ID="DownloadButton" runat="server" Views="simple,editable,image,thumbnailSimple,thumbnailEditable,thumbnailImage"
                Image="Download" OnClientClick="return FileManagerPage.download();" Text="Download" />
            <%If Not SearchInSubfolders Then%>
            <dw:ContextMenuButton ID="MetatagsButton" runat="server" Views="simple,editable,image,multiselect,thumbnailSimple,thumbnailEditable,thumbnailImage,thumbnailMultiselect"
                ImagePath="/Admin/Images/Icons/Module_Metadata_small.gif" OnClientClick="__page.metadata();" Text="Metatags" />
            <%End If%>
            <dw:ContextMenuButton ID="PropertiesButton" runat="server" Views="simple,editable,image,thumbnailSimple,thumbnailEditable,thumbnailImage"
                Divide="Before" ImagePath="/Admin/images/Ribbon/Icons/Small/preferences.png"
                OnClientClick="FileManagerPage.properties();" Text="Properties" />
        </dw:ContextMenu>
        <dw:ContextMenu runat="server" ID="ContextMenuNewFile" Translate="true">
            <dw:ContextMenuButton runat="server" ID="ContextMenuButton8" Views="design" DoTranslate="True" Image="TextCode_Colored" Text="HTML" OnClientClick="showNewFileDialog('.html');" />
            <dw:ContextMenuButton runat="server" ID="ContextMenuButton9" Views="design" DoTranslate="True" Image="Tree" Text="XSLT" OnClientClick="showNewFileDialog('.xslt');" />
            <dw:ContextMenuButton runat="server" ID="ContextMenuButton16" Views="design" DoTranslate="True" Image="TextCode_CSharp" Text="Razor" OnClientClick="showNewFileDialog('.cshtml');" />
        </dw:ContextMenu>

         <dw:ContextMenu runat="server" ID="ContextMenuFileTashBin" Translate="true" OnClientSelectView="onContextMenuView">
          <dw:ContextMenuButton ID="ContextMenuButton3" runat="server" Views="simple,editable,image,multiselect,thumbnailSimple,thumbnailEditable,thumbnailImage,thumbnailMultiselect"
                Image="Redo" Text="Restore" OnClientClick="__page.restoreFile();" />
          <dw:ContextMenuButton ID="ContextMenuButton1" runat="server" Views="simple,editable,image,multiselect,thumbnailSimple,thumbnailEditable,thumbnailImage,thumbnailMultiselect"
                Image="DeleteDocument" Text="Delete" OnClientClick="__page.deleteFile();" />
           <dw:ContextMenuButton ID="PropertiesButton1" runat="server" Views="simple,editable,image,thumbnailSimple,thumbnailEditable,thumbnailImage"
                Divide="Before" ImagePath="/Admin/images/Ribbon/Icons/Small/preferences.png"
                OnClientClick="FileManagerPage.properties();" Text="Properties" />
        </dw:ContextMenu>

        <!-- Context menu end -->
        <dw:PopUpWindow ID="propertiesPopUp" Title="Properties" UseTabularLayout="true" ShowOkButton="false"
            ShowCancelButton="false" AllowDrag="true" ShowClose="true" AllowContentTransparency="true"
            TranslateTitle="true" AutoReload="true" runat="server" Width="650" Height="500" />
        <asp:Literal runat="server" ID="logContent" EnableViewState="false"></asp:Literal>
        </dw:StretchedContainer>
    <div id="BottomInformationBg" class="BottomInformation" runat="server">
        <table border="0" cellpadding="0" cellspacing="0">
            <%If _folder <> "/GlobalSearch" Then%>
            <tr>
                <td rowspan="2" width="50px;">
                    <img src="/Admin/Images/Ribbon/Icons/Folder.png" alt="" onclick="" id="icon" />
                </td>
                <td align="right" width="50px;">
                    <span class="label">
                        <dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Navn" />
                        :</span>
                </td>
                <td width="150px">
                    <b id="_foldername" runat="server"></b>&nbsp;&nbsp;
                </td>
                <td align="right" width="150px">
                    <span class="label">
                        <dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Oprettet" />
                        :</span>
                </td>
                <td width="150px">
                    <span id="_created" runat="server"></span>
                </td>
                <td align="right" width="150px">
                    <span class="label"><dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="Resize settings" />:</span>
                </td>
                <td width="150px">
                    <span id="resizeSettings" runat="server"></span>
                </td>
                <td style="text-align: right; padding-right: 5px;">
                    <%=RenderPaging()%>
                </td>

            </tr>
            <tr>
                <td align="right">
                    <span class="label">
                        <dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Files" />
                        :</span>
                </td>
                <td>
                    <span id="_filescount" runat="server"></span>
                </td>
                <td align="right">
                    <span class="label">
                        <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Redigeret" />
                        :</span>
                </td>
                <td colspan="4">
                    <span id="_edited" runat="server"></span>
                </td>
            </tr>
            <%Else%>
            <tr>
                <td rowspan="2" width="50px;">
                    <img src="/Admin/Images/Ribbon/Icons/Folder.png" alt="" onclick="" id="Img1" />
                </td>
                <td align="right" width="50px;">
                </td>
                <td width="150px">
                </td>
                <td align="right" width="150px">
                </td>
                <td>
                </td>
                <td style="text-align: right; padding-right: 5px;">
                    <%=RenderPaging()%>
                </td>
            </tr>
            <tr>
                <td align="right" width="50px;">
                    <span class="label">
                        <dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Files" />
                        :</span>
                </td>
                <td>
                    <span id="_globalfilescount" runat="server"></span>
                </td>
            </tr>
            <%End If%>
        </table>
    </div>     
    <%If _listMode = ListMode.Thumbnails Then%>
    <script type="text/javascript">
        //Remove empty columns and reset style for header 
        $("ListTable").firstDescendant("tr").down("td.columnCell", 1).remove();
        $("ListTable").firstDescendant("tr").down("td.columnCell", 1).remove();
        $("ListTable").firstDescendant("tr").down("td.columnCell", 1).remove();
        $("ListTable").firstDescendant("tr").down("td.columnCell", 0).setAttribute("style", "width: 995px;");
    </script>
    <%End If%>

    <script type="text/javascript">
        //Uncheck the checkbox
        $("chk_all_Files").checked = false;
        __page.initialize();
    </script>
    <%  Translate.GetEditOnlineScript()
    %>
</asp:Content>
