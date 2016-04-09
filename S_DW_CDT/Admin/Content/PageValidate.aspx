<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PageValidate.aspx.vb" Inherits="Dynamicweb.Admin.PageValidate" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
    <head runat="server">
        <title></title>
        
        <dw:ControlResources IncludeUIStylesheet="true" runat="server" />
        
        <link rel="Stylesheet" href="/Admin/Content/PageValidate.css" type="text/css" />
        
        <script type="text/javascript" language="javascript">
            function toggleProcessing(show) {
                if(parent.document) {
                    try {
                        parent.toggleValidationInProgress(show);
                    } catch(ex) { }
                }
            }
            
            function toggleExplanation(containerID) {
                var disp = '';
                var container = document.getElementById(containerID);
                
                if(container) {
                    disp = container.style.display + '';
                    container.style.display = disp.length > 0 ? '' : 'none';
                }
            }
            
            function help() {
                eval(document.getElementById('jsHelp').innerHTML);
            }
                        
        </script>
    </head>
    
    <body onload="toggleProcessing(false);" onbeforeunload="toggleProcessing(true);">
        <form id="MainForm" runat="server">
        
            <!-- Information box -->
        
            <div style="padding: 4px;">
                <table width="100%" cellspacing="2" cellpadding="2" border="0" class="box" 
                    style="background-color: #ffffff;">
                    <tr>
                        <td width="150">
                            <strong>
                                <dw:TranslateLabel ID="lbTypeLabel" Text="Type" runat="server" />:
                            </strong>
                        </td>
                        <td>
                            <asp:Label ID="lbDocType" runat="server" Text="[...]" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>
                                <dw:TranslateLabel ID="lbErrorsLabel" Text="Errors:" runat="server" />
                            </strong>
                        </td>
                        <td>
                            <asp:Label ID="lbErrors" runat="server" Text="[...]" />
                        </td>
                    </tr>
                    <tr id="rowWarningsCount" visible="true" runat="server">
                        <td>
                            <strong>
                                <dw:Translatelabel ID="lbWarningsLabel" Text="Warnings:" runat="server" />
                            </strong>
                        </td>
                        <td>
                            <asp:Label ID="lbWarnings" runat="server" Text="[...]" />
                        </td>
                    </tr>
                </table>
            </div>
            
            <!-- End: Information box -->
            
            <!-- Settings box -->
            
            <div style="padding: 4px;">
               <table width="100%" cellspacing="2" cellpadding="2" border="0" class="box" 
                    style="background-color: #ffffff;">
                   <tr>
                        <td width="150">
                            <strong>
                                <label for="chkShowWarnings">
                                    <dw:TranslateLabel ID="lbShowWarning" Text="Show warnings" runat="server" />
                                </label>
                            </strong>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkShowWarnings" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="right">
                            <asp:Button CssClass="submitCmd" ID="cmdSubmitSettings" runat="server" />
                            <asp:Button CssClass="submitCmd" ID="cmdHelp" CausesValidation="false" OnClientClick="help(); return false;" runat="server" />
                        </td>
                    </tr>
                </table>
            </div>
            
            <!-- End: Settings box -->
            
            <!-- "Valid" box -->
            
            <div style="padding: 4px; display: block" id="divPageIsValid" runat="server" visible="true">
                <div class="box" style="background-color: #c2f1d1">
                    <center>
                        <strong>
                            <dw:TranslateLabel ID="lbPageIsValid" Text="Gyldig" runat="server" /> !
                        </strong>
                    </center>
                </div>
            </div>
            
            <!-- End: "Valid" box -->
            
            <!-- "Service unavailable" box -->
            
            <div style="padding: 4px; display: block" id="divServiceUnavailable" runat="server" visible="false">
                <div class="box" style="background-color: #fbd6d6">
                    <center>
                        <strong>
                            <dw:TranslateLabel ID="lbServiceUnavailable" Text="Unable to connect to validation service." runat="server" />
                        </strong><br /><br />
                        <asp:Button CssClass="submitCmd" ID="cmdRetry" runat="server" />
                    </center>
                </div>
            </div>
            
            <!-- End: "Service unavailable" box -->  
                        
            <br />
            
            <!-- Validation messages -->
            
            <table cellspacing="2" cellpadding="2" border="0" style="table-layout: fixed">
                <asp:Repeater ID="repMessages" runat="server">
                    <ItemTemplate>
                        <tr id="rowMessage" runat="server">
                            <td width="100%">
                                <table cellspacing="2" cellpadding="2" border="0" style="table-layout: fixed">
                                    <tr valign="middle">
                                        <td width="16">
                                            <img id="imgIcon" src="" border="0" alt="" runat="server" />&nbsp;
                                        </td>
                                        <td width="100%">
                                            <strong>
                                                <a id="lnkExplanation" runat="server">
                                                    <%#Dynamicweb.Base.ChkString(Eval("Text")).Replace("<", "&lt;").Replace(">", "&gt;")%>
                                                </a>
                                            </strong>
                                        </td>
                                        <td align="right" width="16" valign="middle">
                                            <span id="spHelp" runat="server" visible="false">
                                                <a id="lnkExplanationSmall" href="javascript:void(0);" runat="server">
                                                    <span class="help">?</span>
                                                </a>
                                            </span>    
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                            <div class="box" id="divExplanation" runat="server" style="display:none">
                                            </div>    
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                            <div class="code box">
                                                <%#Eval("Source")%>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr id="rowLocation" runat="server">
                                        <td colspan="3">
                                            <small>
                                                <dw:TranslateLabel ID="lbLine" Text="Line" runat="server" />:&nbsp;
                                                <strong><%#Eval("Line")%></strong>,&nbsp;
                                                <dw:TranslateLabel ID="lbColumn" Text="Kolonne" runat="server" />:&nbsp;
                                                <strong><%#Eval("Column")%></strong>
                                            </small>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        
                    </ItemTemplate>
                </asp:Repeater>
            </table>
            
            <!-- End: Validation messages -->
            
            <span id="jsHelp" style="display: none">
                <%=Dynamicweb.Gui.Help("", "page.validate")%>
            </span>
            
        </form>
        <%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
    </body>
</html>
