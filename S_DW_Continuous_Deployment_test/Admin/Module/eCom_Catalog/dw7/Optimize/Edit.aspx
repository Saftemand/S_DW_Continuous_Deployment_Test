<%@ Page Language="vb" AutoEventWireup="false" ValidateRequest="false" CodeBehind="Edit.aspx.vb" Inherits="Dynamicweb.Admin.Edit3" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <title>
            <dw:TranslateLabel ID="lbOptimize" Text="Optimize" runat="server" />
        </title>
        
        <dw:ControlResources ID="ctrlResources" CombineOutput="true" runat="server"
            IncludePrototype="true" IncludeUIStylesheet="true" IncludeScriptaculous="false">
            <Items>
                <dw:GenericResource Url="/Admin/Module/eCom_Catalog/dw7/css/Optimize.css" />
                <dw:GenericResource Url="/Admin/Module/eCom_Catalog/dw7/js/Optimize.js" />
            </Items>
            <Conditions>
                <dw:ResourceCondition Criteria="Contains" Value="scriptaculous.js" Resolution="Discard" />
            </Conditions>
        </dw:ControlResources>
    </head> 
    <body>
        <span id="spPreloadedImages"></span>
                
        <form id="MainForm" runat="server">
            <input type="hidden" id="TargetPhrase" value="<%=HttpUtility.HtmlAttributeEncode(Phrase)%>" />
            <input type="hidden" id="TargetProductID" value="<%=HttpUtility.HtmlAttributeEncode(ProductID)%>" />
            <input type="hidden" id="TargetProductVariantID" value="<%=HttpUtility.HtmlAttributeEncode(ProductVariantID)%>" />
        
            <dw:Toolbar ID="TopTools" ShowStart="false" ShowEnd="false" runat="server">
                <dw:ToolbarButton ID="cmdSave" Image="Save" Text="Save" OnClientClick="Optimize.OptimizeResults.save();" runat="server" />
                <dw:ToolbarButton ID="cmdCancel" Image="Cancel" Text="Cancel" OnClientClick="Optimize.OptimizeResults.cancel();" runat="server" />
                <dw:ToolbarButton ID="cmdRefresh" Image="Refresh" Text="Reset" OnClientClick="Optimize.OptimizeResults.reset();" Divide="Before" runat="server" />
                <dw:ToolbarButton ID="cmdChangePhrase" ImagePath="/Admin/Images/Ribbon/Icons/Small/replace2.png" Text="Change phrase" OnClientClick="Optimize.OptimizeResults.changePhrase();" runat="server" />
                <dw:ToolbarButton ID="cmdHelp" Image="Help" Text="Help" Divide="Before" OnClientClick="Optimize.PhraseList.help();" runat="server" />
            </dw:Toolbar>
			<h2 class="subtitle">
			    <dw:TranslateLabel ID="lbPhrase" Text="Optimize results for phrase" runat="server" />&nbsp;
			    &laquo;<asp:Literal ID="litPhrase" runat="server" />&raquo;
			</h2>
			
			<div class="optimize-results">
			    <div class="optimize-results-fields">
		                <div id="gbField" class="optimize-edit-box" runat="server">
		                    <dw:GroupBox ID="boxField" Title="Field" runat="server">
		                        <div class="optimize-field-container">
		                            <div class="optimize-input-container">
		                                <input type="text" id="txField" autocomplete="off" onkeyup="Optimize.OptimizeResults.validateField(this.value);" oncontextmenu="return false;" value="" />
		                            </div>
		                            <div class="optimize-image-container">
		                                <img alt="" src="/Admin/Images/Ribbon/Icons/Check.png" id="imgField" border="0" />
		                            </div>
		                        </div>
        			            
	                            <ol id="lstSuggestion">
	                            </ol>
        			            
		                        <div id="divFullyOptimized" class="optimize-optimized">
		                            <dw:TranslateLabel id="lbMessage_FullyOptimized" Text="This field is fully optimized." runat="server" />
		                        </div>
		                    </dw:GroupBox>
		                </div>
		                <div class="optimize-no-fields" id="divNoFields" runat="server">
		                    <dw:TranslateLabel ID="lbNoFields" Text="Nothing to optimize" runat="server" />
		                </div>
			        <div class="optimize-navigation">
			            <button id="cmdPrev"onclick="Optimize.OptimizeResults.previousField(); return false;"><%=Translate.Translate("Back")%></button>&nbsp;
			            <button id="cmdNext" onclick="Optimize.OptimizeResults.nextField(); return false;"><%=Translate.Translate("Next")%></button>
			        </div>
			    </div>
			    
			    <div class="optimize-results-summary">
			        <table border="0" width="100%" cellspacing="0" cellpadding="0">
			            <asp:Repeater ID="repSummary" EnableViewState="false" runat="server">
			                <ItemTemplate>
    			                <tr>
    			                    <td id='<%#Eval("Name")%>_Summary' class="optimize-summary-fieldrow" onclick="Optimize.OptimizeResults.set_activeField('<%#Eval("Name")%>')">
    			                        <table border="0" width="100%" cellspacing="0" cellpadding="0">
    			                            <tr>
    			                                <td>
    			                                    <div class="optimize-summary-fieldtitle">
    			                                        <%#Eval("FriendlyName")%>
    			                                    </div>
                			                        
    			                                    <div id='<%#Eval("Name")%>_ValuePresentation' class="optimize-summary-fieldvalue">
    			                                        Server.HtmlEncode(<%#Eval("Value")%>)
    			                                    </div>
                			                        
    			                                    <input type="hidden" id='<%#Eval("Name")%>_Value' name='<%#Eval("Name")%>_Value' value="<%#HttpUtility.HtmlAttributeEncode(Eval("Value").ToString())%>" />
    			                                </td>
    			                                <td align="right" width="16">
    			                                    <img alt="" id='<%#Eval("Name")%>_ResultMark' src="/Admin/Images/Ribbon/Icons/Small/Check.png" border="0" />
    			                                </td>
    			                            </tr>
    			                        </table>
    			                    </td>
    			                </tr>
			                </ItemTemplate>
			            </asp:Repeater>
			            <tr>
			                <td>
			                    <div id="divProgress" class="optimize-progress">
			                        <div>
			                            <span id="spProgress">56%</span>&nbsp;<dw:TranslateLabel ID="lbComplete" Text="complete" runat="server" />
			                        </div>
			                    </div>
			                </td>
			            </tr>
			        </table>
			    </div>
			</div>
			
			<div class="optimize-messages">
			    <span id="spNoContent">(<dw:TranslateLabel ID="lbNoContent" Text="No content" runat="server" />)</span>
			    <span id="Message_WordsCount_More"><dw:TranslateLabel ID="lbMessage_WordsCount_More" Text="Add %ValueDelta% word(s) to this field. You currently have %Value% word(s) and you need at least %MinimumValue%." runat="server" /></span>
			    <span id="Message_WordsCount_Less"><dw:TranslateLabel ID="lbMessage_WordsCount_Less" Text="Remove %ValueDelta% word(s) from this field. You currently have %Value% word(s) and you need no more than %MaximumValue%." runat="server" /></span>
			    <span id="Message_CharactersCount_More"><dw:TranslateLabel ID="lbMessage_CharactersCount_More" Text="Add %ValueDelta% character(s) to this field. You currently have %Value% character(s) and should have more than %MinimumValue%." runat="server" /></span>
			    <span id="Message_CharactersCount_Less"><dw:TranslateLabel ID="lbMessage_CharactersCount_Less" Text="Remove %ValueDelta% character(s) from this field. You currently have %Value% character(s) and should have no more than %MaximumValue%." runat="server" /></span>
			    <span id="Message_Presence_More"><dw:TranslateLabel ID="lbMessage_Presence_More" Text="The phrase %Phrase% is not part of the %Field%. Add %Phrase% to %Field% text." runat="server" /></span>
			    <span id="Message_Prominence_More"><dw:TranslateLabel ID="lbMessage_Prominence_More" Text="Move the phrase %Phrase% to the begining of the field text." runat="server" /></span>
			    <span id="spCancelConfirm"><dw:TranslateLabel ID="lbCancelConfirm" Text="You have unsaved changes. Are you sure you want to discard them?" runat="server" /></span>
			    <span id="jsHelp"><%= Gui.Help("", "ecom.productman.product.optimize", "en")%></span>
			</div>
        </form>
        
        <script type="text/javascript">
            //<![CDATA[
            Optimize.OptimizeResults.preloadImages('spPreloadedImages');
            //]]>
        </script>
                
        <%Translate.GetEditOnlineScript()%>
    </body>
</html>
