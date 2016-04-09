<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AdvancedSettings.aspx.vb" Inherits="Dynamicweb.Admin.AdvancedSettings" %>
<%@ Register TagPrefix="dw" Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server">        
        <Items>
            <dw:GenericResource Url="/Admin/Content/Management/SearchEngine/List.css" />
        </Items>
    </dw:ControlResources>
    <style type="text/css">
        html, body
        {
            background-color: #f0f0f0;
            overflow: hidden;
        }
    </style>
    <script type="text/javascript">
        var SearchEngineSettings = new Object();

        SearchEngineSettings.onIndexingBackupChange = function (e) {
            $('cbIndexingBackupSwitch').disabled = !$('cbIndexingBackupUpdate').checked;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>        
        <dw:GroupBox  Title="Advanced" runat="server">
            <table>
                <tr>    
                    <td style="vertical-align: top;">                        
                        <label for="cbIndexingBackupUpdate"><%=Translate.Translate("Indexing backup update")%></label>                        
                    </td>
                    <td>                        
                        <input type="checkbox" id="cbIndexingBackupUpdate" name="cbIndexingBackupUpdate" onchange="SearchEngineSettings.onIndexingBackupChange();" runat="server" />
                    </td>                                    
                </tr>
                <tr>    
                    <td style="vertical-align: top;">                        
                        <label for="cbIndexingBackupSwitch"><%=Translate.Translate("Indexing backup swith")%></label>                        
                    </td>
                    <td>                        
                        <input type="checkbox" id="cbIndexingBackupSwitch" name="cbIndexingBackupSwitch" runat="server" />
                    </td>                                    
                </tr>
                <tr>
                    <td style="vertical-align: top;"><dw:TranslateLabel Text="Indexing retry count" runat="server" /></td>
                    <td><input type="text" id="tbIndexingRetryCount" name="tbIndexingRetryCount" runat="server" maxlength="5" class="NewUIinput" style="width:30px;" /></td>
                </tr>
                <tr>
                    <td style="vertical-align: top;"><dw:TranslateLabel Text="Indexing delay" runat="server" /></td>
                    <td><input type="text" id="tbIndexingDelay" name="tbIndexingDelay" runat="server" maxlength="5" class="NewUIinput" style="width:30px;" /></td>
                </tr>
                <tr>
                    <td style="vertical-align: top;"><dw:TranslateLabel Text="Auto update delay" runat="server" /></td>
                    <td><input type="text" id="tbAutoUpdateDelay" name="tbAutoUpdateDelay" runat="server" maxlength="5" class="NewUIinput" style="width:30px;" /></td>
                </tr>
                <tr>
                    <td style="vertical-align: top;">                    
                        <label for="cbTryRecoverCorruptedIndex"><%=Translate.Translate("Try recover corrupted index")%><br />
                            <%=Translate.Translate("Dynamicweb will monitor the state of the index during each query operation.")%><br />
                            <%=Translate.Translate("If the index is likely to be corrupted, the full update will trigger automatically.")%>
                        </label>                        
                    </td>
                    <td>
                        <input type="checkbox" value="True" id="cbTryRecoverCorruptedIndex" name="cbTryRecoverCorruptedIndex" runat="server" />
                    </td>
                </tr>
                <tr>    
                    <td style="vertical-align: top;">                        
                        <label for="cbUseVariantCombinationCache"><%=Translate.Translate("Use variant combination cache")%><br />
                            <%=Translate.Translate("this will speed up the indexing process but can cause wrong variant display on products in the backend")%></label>                        
                    </td>
                    <td>                        
                        <input type="checkbox" id="cbUseVariantCombinationCache" name="cbUseVariantCombinationCache" runat="server" />
                    </td>                                    
                </tr>  
                <tr>    
                    <td style="vertical-align: top;">                        
                        <label for="cbAdvancedLogging"><%=Translate.Translate("Enable advanced logging(use only for DEBUGGING!)")%></label>                        
                    </td>
                    <td>                        
                        <input type="checkbox" id="cbAdvancedLogging" name="cbAdvancedLogging" runat="server" />
                    </td>                                    
                </tr>
              </table>
        </dw:GroupBox> 
        <div style="float:right;">
           <input type="submit" id="btnSave" value="Save" runat="server" style="margin-right: 5px; font-size: 11px; width:60px;" onclick="form1.submit();"/>
           <input type="button" id="btnCancel"  value="Cancel" runat="server" style="margin-right: 5px; font-size: 11px; width:60px;" onclick="parent.managePopUp_wnd.hide();"/>
        </div>     
    </div>
    </form>
    <%Translate.GetEditOnlineScript()%>
</body>
</html>