<%@ Page Language="vb" AutoEventWireup="false" codePage="65001"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			13-06-2002
'
'	Purpose: Filearchive control panel
'
'	Revision history:
'		1.0 - 13-06-2002 - Rasmus Foged
'		First version.
'**************************************************************************************************

    Dim FieldState As String = String.Empty
Dim SelectedFieldValue As String 
Dim ImageHandlerType As String
%>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>

    <title><%=Translate.JsTranslate("Filarkiv",9)%></title>

    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <dw:ControlResources ID="ctrlResources" IncludePrototype="True" runat="server" />

        <style type="text/css">
        body
        {
	        border-right:1px solid #ffffff;
        }        
        .warning {
            margin-top: 5px;
            color: red;
        }
    </style>

    <script type="text/javascript" src="/Admin/Module/Common/Validation.js"></script>

    <script type="text/javascript">

        function help() {
		    <%=Dynamicweb.Gui.help("","administration.controlpanel.filearchive") %>
	    }

        function onSave() {

            document.getElementById('hiddenSource').value='ManagementCenterSave';

            save();
	    }

        function onSaveAndClose() {
            save();
	    }


	function save() {

        findCheckboxNames();

		var ret = true;
		
		if(ret)
			document.getElementById('frmGlobalSettings').submit();
	}

	
    function findCheckboxNames() {
            var form = document.getElementById('frmGlobalSettings');
            var _names = "";
            for (var i = 0; i < form.length; i++) {
                if (form[i].name != undefined) {
                    if (form[i].type == "checkbox") {
                        _names = _names + form[i].name + "@"
                    }
                }
            }
            form.CheckboxNames.value = _names;
    }
    
    function onMetadataSourceChange(el) {
        var method = el.value === 'all' ? 'show' : 'hide';

        $$('.item-types .warning').invoke(method);
    }

    function editMetafields() {
        var width = 650;
        var height = 492;

        var metadata_window = window.open("/Admin/Filemanager/Metadata/ConfigurationEdit.aspx?folder=/", "", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=yes,minimize=no,width=" + width + ",height=" + height + ",left=100 ,top=100");
        metadata_window.focus();
    }

    </script>

</head>

<body>

    <div id="PageContent" style="min-width:600px;" >

	<form method="post" action="ControlPanel_Save.aspx" name="frmGlobalSettings" id="frmGlobalSettings">

		<input id="hiddenSource" type="hidden" name="_source" value="ManagementCenter" />

        <dw:Toolbar ID="ToolbarButtons" ShowStart="false" ShowEnd="false" runat="server" >
            <dw:ToolbarButton ID="cmdSave" runat="server" Image="Save" Text="Save" OnClientClick="onSave();" />
            <dw:ToolbarButton ID="cmdOk" runat="server" Divide="Before" Image="SaveAndClose" Text="Gem og luk" OnClientClick="onSaveAndClose();" />
            <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="Before"  Image="Cancel" Text="Cancel" OnClientClick="location='ControlPanel.aspx';" />
            <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="help();" />
        </dw:Toolbar>

        <h2 class="subtitle">
            <dw:TranslateLabel ID="lbSetup" Text="Filarkiv" runat="server" />
        </h2>

		<input type="hidden" name="CheckboxNames" />

        <table border="0" cellpadding="2" cellspacing="0" class="tabTable">

		    <tr>
			    <td valign="top">

				    <%=Gui.GroupBoxStart(Translate.Translate("Upload"))%>
					    <table border="0" cellpadding="2" cellspacing="0">
					        <tr>
					            <td width="170">
					            </td>
					            <td valign="top">
					                <input type="checkbox" id="chkReplaceSpace" value="True" name="/Globalsettings/Modules/Filemanager/Upload/ReplaceSpace" 
					                    <%=Base.IIf(Base.GetGs("/Globalsettings/Modules/Filemanager/Upload/ReplaceSpace").ToLower() = "true", "checked", String.Empty) %> />
					                <label for="chkReplaceSpace">
					                    <dw:TranslateLabel ID="TranslateLabel2" Text="Erstat [Space] med [dash]" runat="server" />
					                </label>
					            </td>
					        </tr>
					        <tr>
					            <td width="170">
					            </td>
					            <td valign="top">
					                
					                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/Modules/Filemanager/Upload/LatinNormalize") = "True", "checked", "")%> id="/Globalsettings/Modules/Filemanager/Upload/LatinNormalize" name="/Globalsettings/Modules/Filemanager/Upload/LatinNormalize" />
                                    <label for="/Globalsettings/Modules/Filemanager/Upload/LatinNormalize"><%= Translate.Translate("Normalize latin characters")%> (ø->oe, é->e etc.)</label><br />
								
					            </td>
					        </tr>
					    </table>
				    <%=Gui.GroupBoxEnd%>
				    <%= Gui.GroupBoxStart(Translate.Translate("Thumbnails"))%>
					    <table border="0" cellpadding="2" cellspacing="0">
					        <tr>
					            <td width="170">
					            </td>
					            <td valign="top">
					                <input type="checkbox" id="chkKeepOriginal" value="True" name="/Globalsettings/Modules/Filemanager/Thumbnails/KeepOriginalFormatAsPostfix" 
					                    <%=Base.IIf(Base.GetGs("/Globalsettings/Modules/Filemanager/Thumbnails/KeepOriginalFormatAsPostfix").ToLower() = "true", "checked", String.Empty) %> />
					                <label for="chkKeepOriginal">
					                    <dw:TranslateLabel ID="TranslateLabel4" Text="Keep original format as postfix" runat="server" />
					                </label>
					            </td>
					        </tr>
					    </table>
				    <%=Gui.GroupBoxEnd%>
					<dw:GroupBoxStart ID="gbMiscStart" Title="Diverse" runat="server" />
					        <table border="0" cellpadding="2" cellspacing="0">
					            <tr>
					                <td width="170">
					                
					                </td>
					                <td valign="top">
					                    <input type="checkbox" id="chkHideNonInstalled" value="True" name="/Globalsettings/Modules/Filemanager/Templates/HideNotInstalled" 
					                        <%=Base.IIf(Base.GetGs("/Globalsettings/Modules/Filemanager/Templates/HideNotInstalled").ToLower() = "true", "checked", String.Empty) %> />
					                    <label for="chkHideNonInstalled">
					                        <dw:TranslateLabel ID="lbHideNotInstalled" Text="Hide non-installed module templates" runat="server" />
					                    </label>
					                </td>
					            </tr>
					            <tr>
					                <td width="170">
					                
					                </td>
					                <td valign="top">
					                    <input type="checkbox" id="chkUseSimpleFileEditor" value="True" name="/Globalsettings/Modules/Filemanager/UseSimpleFileEditor" 
					                        <%=Base.IIf(Base.GetGs("/Globalsettings/Modules/Filemanager/UseSimpleFileEditor").ToLower() = "true", "checked", String.Empty) %> />
					                        <label for="chkUseSimpleFileEditor">
					                        <dw:TranslateLabel ID="TranslateLabel1" Text="Use simple file editor" runat="server" />
					                    </label>
					                </td>
					            </tr>
					        </table>
					 <dw:GroupBoxEnd ID="gbMiscEnd" runat="server" />
                    <dw:GroupBoxStart ID="grbPerformance" Title="Performance" runat="server" />
                        <table border="0" cellpadding="2" cellspacing="0">
                            <tr>
                                <td width="170">
                                    <dw:TranslateLabel ID="TranslateLabel3" Text="Allowed folder amount:" runat="server" />
                                </td>
                                <td valign="top">
                                    <input type="text" id="nsAllowedFolders" style="width: 60px" value="<%=Base.IIf(String.IsNullOrEmpty(Base.GetGs("/Globalsettings/Modules/Filemanager/AllowedFolders")), "500", Base.GetGs("/Globalsettings/Modules/Filemanager/AllowedFolders"))%>" name="/Globalsettings/Modules/Filemanager/AllowedFolders"></input>
                                </td>
                            </tr>
                        </table>
                    <dw:GroupBoxEnd ID="GroupBoxEnd1" runat="server" />
                    <%If Base.HasVersion("8.5.0.0") Then%>	
                    <dw:GroupBoxStart Title="System metafields" runat="server" />
                        <table border="0" cellpadding="2" cellspacing="0">
                            <tr>
                                <td width="170">
                                    <input type="button" name="cfGeneral" class="std" onclick="editMetafields();" value="<%=Translate.JsTranslate("Edit system metafields")%>" />
                                </td>
                            </tr>
                        </table>
                    <dw:GroupBoxEnd runat="server" />
                    <%End If%>
                    <dw:GroupBox Title="Item types" runat="server">
                        <table border="0" cellpadding="2" cellspacing="0" class="item-types">
                            <tr>
                                <td width="170">
                                    <dw:TranslateLabel Text="Synchronize" runat="server"/>
                                </td>
                                <td valign="top">
                                    <input type="radio" id="MetadataSourceAll" name="/Globalsettings/ItemTypes/MetadataSource" onchange="onMetadataSourceChange(this);" value="all"  <%=If(String.Compare(Base.GetGs("/Globalsettings/ItemTypes/MetadataSource"), "all", StringComparison.InvariantCultureIgnoreCase) = 0, "checked", String.Empty)%>  required />                                    
                                    <label for="MetadataSourceAll"><dw:TranslateLabel Text="All" runat="server"/></label>
                                </td>
                            </tr>
                            <tr>
                                <td width="170">&nbsp;</td>
                                <td>
                                    <input type="radio" id="MetadataSourceFiles" name="/Globalsettings/ItemTypes/MetadataSource" onchange="onMetadataSourceChange(this);" value="files"  <%=If(String.Compare(Base.GetGs("/Globalsettings/ItemTypes/MetadataSource"), "files", StringComparison.InvariantCultureIgnoreCase) = 0, "checked", String.Empty)%>  required />
                                    <label for="MetadataSourceFiles"><dw:TranslateLabel Text="Files" runat="server"/></label>
                                </td>
                            </tr>
                            <tr>
                                <td width="170"> &nbsp;</td>
                                <td>
                                    <input type="radio" id="MetadataSourceDatabase" name="/Globalsettings/ItemTypes/MetadataSource" onchange="onMetadataSourceChange(this);" value="database"  <%=If(String.Compare(Base.GetGs("/Globalsettings/ItemTypes/MetadataSource"), "database", StringComparison.InvariantCultureIgnoreCase) = 0, "checked", String.Empty)%>  required />
                                    <label for="MetadataSourceDatabase"><dw:TranslateLabel Text="Database" runat="server"/></label>                                   
                                </td>
                            </tr>
                            <tr>
                                <td width="170" style="padding-top: 10px;">&nbsp;</td>
                                <td> 
                                    <div class="warning" <%=If(String.Compare(Base.GetGs("/Globalsettings/ItemTypes/MetadataSource"), "all", StringComparison.InvariantCultureIgnoreCase) = 0, String.Empty, "style=""display: none;""")%>>
                                        <span><dw:TranslateLabel Text="WARNING. Can be perfomance issues." runat="server"/></span>                   
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </dw:GroupBox>
                    <dw:GroupBox Title="Translations" runat="server">
					    <table border="0" cellpadding="2" cellspacing="0">
					        <tr>
					            <td width="170">
					            </td>
					            <td valign="top">
					                <input type="checkbox" id="chkHideOldTranslationButton" value="True" name="/Globalsettings/Settings/Dictionary/HideOldTranslationButton" 
					                    <%=Base.IIf(Base.GetGs("/Globalsettings/Settings/Dictionary/HideOldTranslationButton").ToLower() = "true", "checked", String.Empty)%> />
					                <label for="chkHideOldTranslationButton">
					                    <dw:TranslateLabel ID="TranslateLabel5" Text="Hide translation button in file manager" runat="server" />
					                </label>
					            </td>
					        </tr>
					    </table>
                    </dw:GroupBox>
			    </td>
		    </tr>
        </table>

    </form>
    </div>

</body>
</html>

<%
    Translate.GetEditOnlineScript()
%>
