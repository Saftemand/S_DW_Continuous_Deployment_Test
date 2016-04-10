<%@ Page Language="vb" AutoEventWireup="false" EnableViewState="false" CodeBehind="Upload.aspx.vb" Inherits="Dynamicweb.Admin.Upload" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import namespace="Dynamicweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
       <title>
		    <dw:TranslateLabel ID="lbTitle" runat="server" Text="Upload" />
	    </title>
        <dw:ControlResources runat="server" IncludePrototype="true" IncludeScriptaculous="false" />
        
        <link type="text/css" rel="stylesheet" charset="utf-8" href="Upload.css" />
        <link type="text/css" rel="Stylesheet" charset="utf-8" href="/Admin/Images/Ribbon/UI/List/List.css" />

        <%-- @see http://www.cnblogs.com/rupeng/archive/2012/01/30/2332427.html --%>
        <% If RegularExpressions.Regex.IsMatch(Request.UserAgent, "(firefox|safari)", RegexOptions.IgnoreCase) Then%>
        <script>
            var SWFUploadSettings = {
                post_params: {
                    "UploadToken": '<%= Session.SessionID %>'
                }
            }
        </script>
        <% End If %>
        
        <script type="text/javascript" language="javascript" charset="utf-8" src="js/swfupload/swfupload.js"></script>
        <script type="text/javascript" language="javascript" charset="utf-8" src="js/swfupload/swfupload.queue.js"></script>
        <script type="text/javascript" language="javascript" charset="utf-8" src="js/EventsManager.js"></script>
        <script type="text/javascript" language="javascript" charset="utf-8" src="js/UploadManager.js"></script>
        <script type="text/javascript" language="javascript" charset="utf-8" src="js/Upload.js"></script>
        <style type="text/css">
            #divLocation {
                margin-left: 40px;
            }
        </style>
    </head>
    
    <body>
        <dw:Infobar Message="" runat="server" Type="Information" Title="No write permissions" Action="" ID="noAccessWarning" Visible="False"></dw:Infobar>
        <form id="MainForm" runat="server" enctype="multipart/form-data">
            <dw:Ribbonbar runat="server" ID="Toolbar" HelpKeyword="module.filemanager.upload">
	            <dw:RibbonbarTab ID="tabEditor" Active="true" Name="Upload" runat="server">
	                <dw:RibbonbarGroup ID="groupFile" Name="Upload" runat="server">
	                    <dw:RibbonbarButton ID="cmdUpload" ImagePath="/Admin/Images/Ribbon/Icons/upload.png" Size="Large" Disabled="true" Text="Upload" runat="server" />
	                </dw:RibbonbarGroup>
	                <dw:RibbonbarGroup ID="groupUpload" Name="Files" runat="server">
	                    <dw:RibbonBarButton ID="cmdSelectFile" Hide="true" ImagePath="/Admin/Images/Ribbon/Icons/paperclip_add.png" Size="Large" Text="Vælg fil" runat="server" />
	                    <dw:RibbonBarPanel ID="panelSelect" runat="server">
	                        <div id="ctrlUpload"></div>
	                    </dw:RibbonBarPanel>
                        <dw:RibbonbarButton ID="cmdRemoveSelected" ImagePath="/Admin/Images/Ribbon/Icons/Small/paperclip_delete.png" Disabled="true" Size="Small" Text="Remove selected" runat="server" />
                        <dw:RibbonbarButton ID="cmdRemoveAll" Image="Delete" Size="Small" Text="Remove all" Disabled="true" runat="server" />
                        <dw:RibbonBarCheckbox ID="chkOverwriteFiles" Text="Overwrite" Size="Small" Image="Check" runat="server" />
	                </dw:RibbonbarGroup>
	                <dw:RibbonBarGroup ID="grpImageSettings" Name="Billeder" runat="server">
	                    <dw:RibbonBarPanel ID="pImageSettings" ExcludeMarginImage="true" runat="server">
	                        <div id="groupImageSettings">
	                            <table border="0" cellspacing="0" cellpadding="0" style="height: 50px">
	                                <tr valign="top">
	                                    <td>
	                                        <table border="0" style="height: 50px">
	                                            <tr valign="top">
	                                                <td width="100">
	                                                    <dw:TranslateLabel ID="lbQuality" Text="Quality" runat="server" />
	                                                </td>
	                                                <td>
	                                                    <select id="ddQuality" style="width: 50px">
	                                                        <option value="10">10</option>
	                                                        <option value="20">20</option>
	                                                        <option value="30">30</option>
	                                                        <option value="40">40</option>
	                                                        <option value="50">50</option>
	                                                        <option value="60">60</option>
	                                                        <option value="70">70</option>
	                                                        <option value="80">80</option>
	                                                        <option value="90">90</option>
	                                                        <option value="100" selected="selected">100</option>
	                                                    </select>
	                                                </td>
	                                            </tr>
	                                            <tr valign="top">
	                                                <td>
	                                                    <label for="chkResize">
	                                                        <dw:TranslateLabel ID="lbResize" Text="Resize images" runat="server" />
	                                                    </label>
	                                                </td>
	                                                <td>
	                                                    <input type="checkbox" id="chkResize" onclick="UploadController.getInstance().set_groupIsEnabled('rowDimensions', this.checked);" />
	                                                </td>
	                                            </tr>
	                                        </table>
	                                    </td>
	                                    <td style="width: 25px">
	                                        &nbsp;
	                                    </td>
	                                    <td>
	                                        <table border="0" id="rowDimensions" style="height: 50px">
                                                <tr valign="top">
                                                    <td width="100">
                                                        <dw:TranslateLabel ID="lbWidth" Text="Max width" runat="server" />
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txImageWidth" style="width: 50px" />
                                                    </td>
                                                </tr>
                                                <tr valign="top">
                                                    <td>
                                                        <dw:TranslateLabel ID="lbHeight" Text="Max height" runat="server" />
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txImageHeight" style="width: 50px" />
                                                    </td>
	                                            </tr>
	                                        </table>
	                                    </td>
	                                </tr>
	                            </table>
	                        </div>
	                    </dw:RibbonBarPanel>
	                </dw:RibbonBarGroup>
	                <dw:RibbonBarGroup ID="grpArchiveSettings" Name="File archives" runat="server">
	                    <dw:RibbonBarPanel ID="pArchiveSettings" ExcludeMarginImage="true" runat="server">
	                        <div id="groupArchiveSettings">
                                <table border="0" style="height: 50px">
                                    <tr valign="top">
                                        <td width="100">
                                            <label for="chkExtractArchives">
                                                <dw:TranslateLabel ID="lbUnzipArchives" Text="Extract archives" runat="server" />
                                            </label>
                                        </td>
                                        <td>
                                            <input type="checkbox" id="chkExtractArchives" onclick="UploadController.getInstance().set_groupIsEnabled('rowCreateFolders', this.checked);" />
                                        </td>
                                    </tr>
                                    <tr valign="top" id="rowCreateFolders">
                                        <td style="padding-left: 15px">
                                            <label for="chkCreateFolders">
                                                <dw:TranslateLabel ID="lbCreateFolders" Text="Create folders" runat="server" />
                                            </label>
                                        </td>
                                        <td>
                                            <input type="checkbox" id="chkCreateFolders" />
                                        </td>
                                    </tr>
                                </table>
	                        </div>
	                    </dw:RibbonBarPanel>
	                </dw:RibbonBarGroup>
	            </dw:RibbonbarTab>
            </dw:Ribbonbar>
    	   
    	   <div id="divLocation" runat="server"></div>
    	   
    	   <div class="list">
			    <ul id="listHeader">
				    <li class="header">
					    <span class="C1">
					        <input id="chkAll" disabled="disabled" type="checkbox" runat="server" />
					    </span>
					    <span class="pipe"></span><span class="C2"><dw:TranslateLabel ID="lbFileName" Text="Navn" runat="server" /></span> 
					    <span class="pipe"></span><span class="C3"><dw:TranslateLabel ID="lbFileSize" Text="Size" runat="server" /></span> 
					    <span class="pipe"></span><span class="C4"><dw:TranslateLabel ID="lbModified" Text="Modified" runat="server" /></span> 
					    <span class="pipe"></span><span class="C5"><dw:TranslateLabel ID="lbStatus" Text="Status" runat="server" /></span>
					    <span class="pipe"></span><span class="C6"><dw:TranslateLabel ID="lbDelete" Text="Remove" runat="server" /></span> 
				    </li>
			    </ul>
			    
			    <div id="itemsContainer" class="itemsContainer">
			        <div class="itemsWrapper">
		                <ul id="items">
		                    <li id="templateItem" class="templatedItemMarker" style="display: none">
		                        <span class="C1">
		                            <input type="checkbox" />
		                        </span> 
		                        <span class="C2"></span>
		                        <span class="C3"></span>
		                        <span class="C4"></span>
		                        <span class="C5">
		                            <span class="uploadStatusCustom"></span>
		                            <span class="progressBackground" style="display: none">
		                                <span class="progressFill" style="width: 0px"></span>
		                            </span>
		                            <span class="uploadStatus"></span>
		                        </span>
		                        <span class="C6">
		                            <img src="/Admin/Images/Ribbon/Icons/Small/Delete.png" border="0" alt="" style="cursor: pointer" />
		                        </span>
		                    </li>
		                </ul>
		            </div>
		        </div>
    	    </div>
    	    
	        <div id="files-emptylist" class="noFilesContainer">
	            <dw:TranslateLabel ID="lbNoFiles" Text="Nothing selected" runat="server" />
	        </div>
    	    
            <div id="statusBar">
		       <span class="statusBarItem">
		            <img src="/Admin/Images/Ribbon/Icons/Small/document_notebook.png" alt="" />
		            <span id="uploadstatus-filecount">0</span>
                    <asp:Literal ID="litFiles" runat="server" />
		        </span>
		        <img src="/Admin/Images/Nothing.gif" class="seperator" alt="" />
		        <span class="statusBarItem">
		            <img src="/Admin/Images/Ribbon/Icons/Small/size.png" alt="" />
	                <span id="uploadstatus-label">0&nbsp;kb</span>
	                
                    <input type="hidden" id="uploadstatus-size" value="0" />
		        </span>
		        <img src="/Admin/Images/Nothing.gif" class="seperator" alt="" />
		        <span id="progressGlobal" class="statusBarItem" style="padding-top: 4px">
		            <span class="progressBackground">
                        <span class="progressFill" style="width: 0px"></span>
                    </span>
		        </span>
	        </div>
	        
	        <dw:Dialog ID="dlgImageSettings" Width="350" Title="Billeder" ShowOkButton="true" ShowCancelButton="false" ShowClose="false" runat="server">
	            <table border="0" style="height: 110px">
	                <tr>
	                    <td valign="top">
	                        
	                         
	                    </td>
	                </tr>
	            </table>
	            
	            <br />
	        </dw:Dialog>
	        
	        <dw:Dialog ID="dlgSimpleUpload" Width="400" ShowClose="false" ShowCancelButton="false" 
	            ShowOkButton="true" Title="Upload" runat="server">
	            
	            <table border="0">
	                <tr valign="top">
	                    <td colspan="2">
	                        <dw:TranslateLabel ID="lbNoFlash" runat="server" 
	                            Text="The advanced upload functionality is not available because you do not have the required Flash Player version installed." />
	                        <br />
	                        <br />
	                        <div class="downloadFlashLink">
                                <a href="http://get.adobe.com/flashplayer/" target="_blank">
                                    <dw:TranslateLabel ID="TranslateLabel1" Text="Install Flash Player" runat="server" />
                                </a> 
                            </div>
                            
	                        <br />
	                    </td>
	                </tr>
	                <tr valign="top">
	                    <td width="100">
	                        <dw:TranslateLabel ID="lbFile" Text="File" runat="server" />
	                    </td>
	                    <td align="right">
	                        <input type="file" id="flUpload" name="flUpload" />
	                    </td>
	                </tr>
	            </table>
	            
	            <br />
	        </dw:Dialog>
	        


	        <span id="selectButtonLabel" style="display: none"><dw:TranslateLabel ID="lbSelectButtonLabel" Text="Vælg fil" runat="server" /></span>
	        <span id="alreadyExistsLabel" style="display: none"><dw:TranslateLabel ID="lbAlreadyExists" Text="Filen_findes_i_forvejen" runat="server" /></span>
	        <span id="Message_Error_100" style="display: none"><dw:TranslateLabel id="lbError100" Text="You cannot add more files to the upload queue" runat="server" /></span>
	        <span id="Message_Error_110" style="display: none"><dw:TranslateLabel id="lbError110" Text="The file is too large" runat="server" /></span>
	        <span id="Message_Error_120" style="display: none"><dw:TranslateLabel id="lbError120" Text="The file cannot be added because it has a zero-byte size" runat="server" /></span>
	        <span id="Message_Error_130" style="display: none"><dw:TranslateLabel id="lbError130" Text="The file cannot be added because it is of an invalid type" runat="server" /></span>
            <span id="Message_FileWarning_1" style="display: none"><dw:TranslateLabel id="lbFileWarning1" Text="Warning! The file '%%' containing ',' character. You can't move or rename such files through the file manager. This file will be renamed." runat="server"/></span>
	        <span id="Message_FileWarning_2" style="display: none"><dw:TranslateLabel id="lbFileWarning2" Text="Warning! The file '%%' containing ';' character. You can't move or rename such files through the file manager. This file will be renamed." runat="server"/></span>
            <span id="Message_FileWarning_3" style="display: none"><dw:TranslateLabel id="lbFileWarning3" Text="Warning! The file '%%' containing '+' character. This file will be renamed." runat="server"/></span>
            <span id="Message_FileWarning_4" style="display: none"><dw:TranslateLabel id="lbFileWarning4" Text="Warning! The option {Replace spaces with '-'} set 'on'.The '%%' file will be renamed." runat="server"/></span>
            <span id="Message_FileWarning_5" style="display: none"><dw:TranslateLabel id="lbFileWarning5" Text="Warning! The option {Normalize latin characters} set 'on'.The '%%' file will be renamed." runat="server"/></span>
            <span id="Message_FileWarning_6" style="display: none"><dw:TranslateLabel id="lbFileWarning6" Text="Warning! The file '%%' containing ' character. This file will be renamed." runat="server"/></span>
            <span id="Message_FileWarning_7" style="display: none"><dw:TranslateLabel id="lbFileWarning7" Text="Warning! The file '%%' containing '#' character. This file will be renamed." runat="server"/></span>
            <span id="Message_Validate_1" style="display: none"><dw:TranslateLabel id="lbValidate1" Text="Must specify max width or max height" runat="server"/></span>
	        
	        <input type="hidden" id="statePreviousLocation" value="" />
	        <input type="hidden" id="stateIsAllowedToOverwriteFiles" value="" runat="server" />
	        <input type="hidden" id="stateIsAllowedToChangeLocation" value="" runat="server" />
	        <input type="hidden" id="stateIsUploading" value="false" />
	        <input type="hidden" id="stateTotalUploaded" value="0" />
	        <input type="hidden" id="stateCurrentlyUploaded" value="0" />
	        <input type="hidden" id="stateCurrentlyMaximumToUpload" value="0" />
	        <input type="hidden" id="stateOnLoad" value="" runat="server" />
	        <input type="hidden" id="replaceSpace" value="<%=Base.IIf(Base.GetGs("/Globalsettings/Modules/Filemanager/Upload/ReplaceSpace").ToLower() = "true", "true", String.Empty) %>" />
            <input type="hidden" id="replaceSpecial" value="<%=Base.IIf(Base.GetGs("/Globalsettings/Modules/Filemanager/Upload/LatinNormalize").ToLower() = "true", "true", String.Empty) %>" />
            <input type="hidden" id="fileSizeLimit" value="500" />


        </form>
        <script type="text/javascript" language="javascript">
            var winOpener = opener;
            function reloadFileList() {
                if (typeof (winOpener) != 'undefined' && winOpener) {
                    if ($('chkExtractArchives').checked) {
                        var folder = '<%=Folder %>'.replace(/^(\/Files)/, '');
                        folder = folder.replace(/(\/$)/g, '');
                        winOpener.reloadWindow(folder);
                    }
                    else winOpener.refreshContent();
                }
            }

            var manager = window.UploadManager.getInstance();
            if (manager.get_canUpload()) {
                manager.add_afterUpload(reloadFileList);
            }
            <% If Base.Request("refresh-content") = "1" Then%>
            reloadFileList();
            window.close();
            <% End If %>
        </script>
    </body>
    
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
</html>
