<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EditView.aspx.vb" Inherits="Dynamicweb.Admin.EditView" EnableEventValidation="false" ValidateRequest="false" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
	
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="Stylesheet" href="/Admin/Content/StyleSheetNewUI.css" />
	<link rel="Stylesheet" href="/Admin/Module/DataManagement/View/style/EditView.css" />
	
    <dw:ControlResources ID="ControlResources1" runat="server" IncludePrototype="true" />
    
    <script src="EditView.js" type="text/javascript"></script>
    
    <script type="text/javascript">
        var id = <%=ViewID%>;
        var cmd = "<%=CMD%>";
        var myBase = -1;
        var isEdit = <%=isEdit %>;
        var txtConvertToSQL = '<%=Translate.JsTranslate("You are in design mode. Convert view to SQL?") %>';
        var txtViewNameMissing = '<%=Translate.JsTranslate("You need to enter a name for the view!") %>';
        var txtConfirmPreview = '<%=Translate.JsTranslate("This will save the view. Are you sure you want to see the preview?") %>';
        var txtResolutionTooLow = '<%=Translate.JsTranslate("The current screen resolution is too low to use the preview mode.\nClick the view in the tree on the left side of this window to preview.") %>';
        var helpLang = "<%=helpLang %>";
    </script>
    
</head>
<body class="edit" style="border-bottom:1px solid #6593CF;" onload="javascript:doInit(<%=BaseID %>);" id="viewBody">
    <form id="viewForm" runat="server" style="height: 100%;" method="post">
        <dw:Ribbonbar ID="Ribbon" runat="server">
			<dw:RibbonbarTab ID="RibbonbarTab1" runat="server" Active="true" Name="Data list">
			
                <dw:RibbonbarGroup ID="RibbonbarGroup1" runat="server" Name="Funktioner">
					<dw:RibbonbarButton runat="server" Text="Gem" Size="Small" Image="Save" OnClientClick="save();" ID="Save" />
					<dw:RibbonbarButton runat="server" Text="Gem og luk" Size="Small" Image="SaveAndClose" OnClientClick="saveAndClose();" ID="SaveAndClose" />
					<dw:RibbonbarButton runat="server" Text="Annuller" Size="Small" Image="Cancel" OnClientClick="cancel();" ID="Cancel" />
				</dw:RibbonbarGroup>
				
				<dw:RibbonbarGroup ID="RibbonbarGroup3" runat="server" Name="Type">
	                <dw:RibbonbarRadioButton OnClientClick="ChangeBase(0);" ID="Type_0" Group="type" Text="SQL Statement" RenderAs="Default" Value="0" Checked="true" runat="server" Size="Large" Image="Connection_Edit" />
	                <dw:RibbonbarRadioButton OnClientClick="ChangeBase(1);" ID="Type_1" Group="type" Text="Design wizard" RenderAs="Default" Value="1" runat="server" Size="Large" Image="View_Edit" />
				</dw:RibbonbarGroup>
				
				<dw:RibbonbarGroup ID="RibbonbarGroup4" runat="server" Name="Settings">
				    <dw:RibbonbarButton ID="btnSettings" runat="server" Size="Small" Text="Settings" Image="EditGear" OnClientClick="dialog.show('Settings');" />
				    <dw:RibbonbarCheckbox ID="btnShowSelector" runat="server" Size="Small" Text="Select field(s)" Image="Search" OnClientClick="toggleDesignerEnabled();" RenderAs="Default"></dw:RibbonbarCheckbox>
				</dw:RibbonbarGroup>

				<dw:RibbonbarGroup ID="RibbonbarGroup5" runat="server" Name="Preview">
				    <dw:RibbonbarCheckbox ID="btnPreview" runat="server" Size="Large" Text="Preview" Image="Preview" OnClientClick="Preview();" RenderAs="Default" />
				</dw:RibbonbarGroup>
				
				<dw:RibbonbarGroup ID="RibbonbarGroup2" runat="server" Name="Help">
					<dw:RibbonbarButton ID="HelpBut" runat="server" Text="Help" Image="Help" Size="Large" OnClientClick="help();" />
				</dw:RibbonbarGroup>	
				
			</dw:RibbonbarTab>
        </dw:Ribbonbar>
        
    <div id="content" style="position: relative; overflow: auto;">
        <div id="divSQL" style="display: none; z-index: 0;">        
            <dw:GroupBox ID="GroupBox2" runat="server" DoTranslation="true" Title="SQL Statement">
		        <table cellpadding="1" cellspacing="1" width="99%">        
			        <tr>
				        <td width="170" style="vertical-align: top;">
					        <div class="nobr"><dw:TranslateLabel runat="server" Text="Statement" /></div>
				        </td>
				    </tr>
				    <tr>
				        <td>
				            <textarea style="width:100%" rows="20" name="vwStatement" id="vwStatement" runat="server"></textarea>
				        </td>
			        </tr>			    
                </table>			        
            </dw:GroupBox>
        </div>

        <div id="divWiz" style="z-index: 0; float: left;">
            <dw:GroupBox ID="GroupBox3" runat="server" DoTranslation="true" Title="Configure data list">
                <div id="tablesDiv">
		            <table cellpadding="1" cellspacing="1">        
			            <tr id="selTR" style="display: none;">
				            <td width="170" style="vertical-align: top;">
					            <div class="nobr"><dw:TranslateLabel runat="server" Text="Select field(s)" /></div>
				            </td>
				            <td>
				                <div>
				                    <label><input type="radio" value="All" id="useFields_All" name="useFields" onclick="toggleUseAllFields(this);" /><dw:TranslateLabel Text="Use all fields (equivalent to SQL '*')" runat="server" /></label><br />
				                    <label><input type="radio" value="Manual" id="useFields_Manual" name="useFields" onclick="toggleUseAllFields(this);" /><dw:TranslateLabel Text="Select specific fields" runat="server" /></label>
				                </div>
				                <div id="sel">
				                    <dw:SelectionBox ID="SelectionBox1" Height="200" Width="250" runat="server" TranslateNoDataText="true" NoDataTextRight="(All fields selected)"
				                        TranslateHeaders="true" LeftHeader="Deselected field(s)" RightHeader="Selected field(s)" />
				                </div>
				            </td>
			            </tr>
			            <tr style="display: inline;">
				            <td width="170" style="vertical-align: top;">
					            <div class="nobr"><dw:TranslateLabel runat="server" Text="Add condition(s)" /></div>
				            </td>
			                <td style="width: 592px; border: 1px solid #6593CF;">
                                <dw:EditableGrid ID="conds" runat="server" EnableViewState="true" Width="592px">
                                    <Columns>
                                        <asp:TemplateField ControlStyle-Width="20px" >
                                            <ItemTemplate>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ControlStyle-Width="50px" >
                                            <ItemTemplate>
                                                <asp:DropDownList ID="conditionalOperator" runat="server" class="NewUIinput" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ControlStyle-Width="200px" >
                                            <ItemTemplate>
                                                <asp:DropDownList ID="fields" runat="server" class="NewUIinput" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ControlStyle-Width="100px" >
                                            <ItemTemplate>
                                                <asp:DropDownList ID="oper" runat="server" class="NewUIinput" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ControlStyle-Width="185px" >
                                            <ItemTemplate>
                                                <asp:TextBox ID="criteria" runat="server" Text='<%#Eval("value") %>' cssclass="NewUIinput" onkeydown="HandleKeyDown(event, this);"></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField ControlStyle-Width="35px" >
                                            <ItemTemplate>
                                                <div id="buttons" style="visibility: hidden; width: 35px;">
                                                    <img alt="<%=Translate.JsTranslate("Query helper") %>" src="/Admin/Images/Icons/Wizard_small.png" onclick="showHelper(this);" />
                                                    <img alt="<%=Translate.JsTranslate("Slet") %>" src="/Admin/images/Delete_small.gif" onclick="deleteSelectedRow(this);" />
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </dw:EditableGrid>
                                <asp:HiddenField ID="fieldsWithPling" Value="" runat="server" />
                                <asp:HiddenField ID="fields" Value="" runat="server"/>
                            </td>
			            </tr>
			            <tr style="display: inline;">
				            <td width="170" style="vertical-align: top;">
					            <div class="nobr" style="margin-top: 5px;"><dw:TranslateLabel runat="server" Text="Order by" /></div>
				            </td>
				            <td>
				                <div id="orderByDiv" name="orderByDiv" style="margin-top: 5px;"></div>
				            </td>
			            </tr>	
			            <tr style="display: inline;">
				            <td width="170" style="vertical-align: top;">
					            <div class="nobr" style="margin-top: 5px;"><dw:TranslateLabel runat="server" Text="Rows to fetch" /></div>
				            </td>
				            <td>
				                <div style="margin-top: 5px;">
				                    <asp:DropDownList ID="topRows" CssClass="NewUIinput" Width="50" runat="server">
				                        <asp:ListItem Text = "1" Value="1" />
				                        <asp:ListItem Text = "10" Value="10" />
				                        <asp:ListItem Text = "25" Value="25" />
				                        <asp:ListItem Text = "50" Value="50" />
				                        <asp:ListItem Text = "100" Value="100" />
				                        <asp:ListItem Text = "250" Value="250" />
				                        <asp:ListItem Text = "500" Value="500" />
				                        <asp:ListItem Text = "1000" Value="1000" />
				                        <asp:ListItem ID="topRowsAll" Selected="True" Text = "All" Value="-1" />
				                    </asp:DropDownList>
				                </div>
				            </td>
			            </tr>	
                    </table>
                </div>			        
            </dw:GroupBox>
        </div>
        
    </div>


        <div id="PreviewLayer" style="z-index: 500; display:none; position: relative; overflow:auto; height:400px; width:100%; background-color:White; border-top:2px solid #6593CF; border-bottom:1px solid #6593CF;">
            <div id="PreviewContent" style="height: 100%;">
                <iframe id="iPreview" width="100%" height="100%"></iframe>
            </div>
        </div>
        
        <iframe src="about:blank" id="ContentSaveFrame" name="ContentSaveFrame" width="50%" frameborder="0" height="0" style="height: 0px;"></iframe>
        
        
        <dw:Dialog ID="Settings" runat="server" Title="Settings" ShowOkButton="true" ShowClose="false" Width="450">
            <dw:GroupBox ID="GroupBox4" runat="server" DoTranslation="true" Title="Indstillinger">
		        <table cellpadding="1" cellspacing="1">
			        <tr style="display: inline;">
				        <td width="170">
					        <div class="nobr"><dw:TranslateLabel runat="server" Text="Name" /></div>
				        </td>
				        <td>
					        <input type="text" name="vwName" id="vwName" runat="server" maxlength="255" class="NewUIinput" />
				        </td>
			        </tr>
			        <tr style="display: inline;">
				        <td width="170">
					        <div class="nobr"><dw:TranslateLabel runat="server" Text="Connection" /></div>
				        </td>
				        <td>
                            <asp:DropDownList name="vwConnection" id="vwConnection" runat="server" class="NewUIinput">
                            </asp:DropDownList>					    
				        </td>
			        </tr>			    
		            <tr id="tableTR" style="display: inline;">
			            <td width="170">
				            <div class="nobr"><dw:TranslateLabel runat="server" Text="Table" /></div>
			            </td>
			            <td>
			                <div id="tableDropdown" name="tableDropdown">
                            </div>
			            </td>
		            </tr>			    
                </table>			        
            </dw:GroupBox>	
        </dw:Dialog>
        
        <dw:Dialog ID="RequestHelper" runat="server" ShowClose="true" ShowHelpButton="true" HelpKeyword="Modules.DataManagement.View.Edit.RequestHelper" Title="Request Helper" 
            ShowOkButton="true" ShowCancelButton="true" OkAction="okReq();">
            <dw:GroupBox ID="GroupBox1" Title="Request/Session" runat="server" DoTranslation="true">
                <div id="reqBuilder" name="reqBuilder"></div>
            </dw:GroupBox>
            <dw:GroupBox ID="GroupBox5" Title="Info" runat="server" DoTranslation="true">
                <div id="reqInfoPane" name="reqInfoPane"></div>
            </dw:GroupBox>
        </dw:Dialog>
        
        <dw:Dialog ID="QueryHelper" runat="server" ShowClose="true" ShowHelpButton="true" HelpKeyword="Modules.DataManagement.View.Edit.QueryHelper" Title="Query Helper" 
        ShowOkButton="true" ShowCancelButton="true" OkAction="okQuery();">
            <div>
                <dw:GroupBox ID="GroupBox6" Title="Info" runat="server" DoTranslation="true">
                    <table>
                        <tr>
                            <td style="width: 170px;" class="nobr"><%=Translate.Translate("Field")%></td>
                            <td><div id="query_fieldName" /></td>
                        </tr>
                        <tr>
                            <td style="width: 170px;" class="nobr"><%=Translate.Translate("Operator")%></td>
                            <td><div id="query_operator" /></td>
                        </tr>
                        <tr>
                            <td style="width: 170px;" class="nobr"><%=Translate.Translate("Complete expression")%></td>
                            <td><div id="expressionDiv"></div></td>
                        </tr>
                    </table>
                </dw:GroupBox>
            </div>
            
            <div>
                <dw:GroupBox ID="GroupBox7" Title="Vælg værdier" runat="server" DoTranslation="true">
                    <div id="query_builder"></div>
                    <div><%=Translate.Translate("Notice that you can use %% to insert an empty string.", "%%", "&lt;!--empty--&gt;")%></div>
                </dw:GroupBox>    
            </div>
        </dw:Dialog>
        

    </form>
    <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
    <script type="text/javascript" language="javascript">
        hideConditionalOperatorSelector();
        dwGrid_conds.onMouseMoving = hideConditionalOperatorSelector;
    </script>
</body>
</html>

