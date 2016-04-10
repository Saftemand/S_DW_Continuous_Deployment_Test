<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EcomCountry_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eComBackend.EcomCountryEdit" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
	<HEAD>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
		<meta content="JavaScript" name="vs_defaultClientScript" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
		<link rel="STYLESHEET" type="text/css" href="/admin/Stylesheet.css" />
			<dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
		<link rel="STYLESHEET" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />
		
    	<style type="text/css">
    	    
		body.margin {
			margin: 0px;
		}

        input, select, textarea
        {
            font-size: 11px;
            font-family: verdana,arial;
        }
        .Tab1Div, .Tab2Div, .Tab3Div {}

        #DWRowHeadLine
        {
            background: #DFE9F5 url(/Admin/Images/Ribbon/UI/EditableGrid/header.gif) repeat-x scroll left bottom;
            height: 20px;
            font-weight: bold;  
        }
        
        .OutlookHeaderStart, .OutlookHeader
        {
            font: 11px Verdana, Helvetica, Arial, Tahoma;
            border-bottom: 1px solid #333333;
            padding-left: 5px;
        }
        .OutlookItem td {
            background-color: white;
            border-bottom: 1px solid #E3EFFF;
            font-size: 11px;
        }
        .dwGrid .header th
        {
            height: 20px;
            font-weight: bold; 
        }        
        .dwGrid tr.row 
        {
            height: 25px;   
        }
        .dwGrid tr.row td
        {
            padding: 0px 2px; 
        }
    </style>
			
        <script type="text/javascript">

        $(document).observe('dom:loaded', function () {
            window.focus(); // for ie8-ie9 
            document.getElementById('Name').focus();

            dwGrid_regionsGrid.onRowAddedCompleted = function (row) {
                var nameBox = row.findControl("colCode");
                nameBox.focus();
            };
        });

        function SaveCountry(close) {
            var oldItem = "<%=countryId%>";
            var newItem = "";
            
            var countrySelect = document.getElementById('Form1').cID;
            if (countrySelect.selectedIndex > -1)
            {
                newItem = countrySelect.options[countrySelect.selectedIndex].value;
            }

            document.getElementById('hiddenClose').value = close ? '1' : '';

            var save = true;
            if (oldItem != "" && oldItem != newItem) {
                save = false;
            }
            
            if (save) {
                document.getElementById('Form1').SaveButton.click();
            } else {
                var msg = '<%=Translate.JsTranslate("Du har ændret den oprindelige Landekode (2)\nDette vil medføre ændringer i relationer til landet!\nVil du fortsætte ?")%>';    
                if (confirm(msg)) {
                    document.getElementById('Form1').SaveButton.click();
                } 
            }

        }

        var deleteMsg = '<%= DeleteMessage %>';
        function DeleteCountry() {
            if (confirm(deleteMsg)) document.getElementById('Form1').DeleteButton.click();
        }

        //  Delete row
        function delRow(link) {
            var row = dwGrid_regionsGrid.findContainingRow(link);
            if (row) {
                if (confirm('<%= Translate.JsTranslate("Do you want to delete this region?") %>')) {
                    dwGrid_regionsGrid.deleteRows([row]);
                }
            }
        }
		</script>

        <script type="text/javascript">
			strHelpTopic = 'ecom.controlpanel.country.edit';
			function TabHelpTopic(tabName) {
				switch(tabName) {
					case 'GENERAL':
						strHelpTopic = 'ecom.controlpanel.country.edit.general';
						break;
					case 'RELATIONS':
						strHelpTopic = 'ecom.controlpanel.country.edit.relations';
						break
		            case 'REGIONS':
		                strHelpTopic = 'ecom.controlpanel.country.edit.regions';
		                break
					default:
						strHelpTopic = 'ecom.controlpanel.country.edit';
				}
			}
		</script>
	    <script type="text/javascript" src="/Admin/FormValidation.js"></script>
	</HEAD>
	<body MS_POSITIONING="GridLayout" style="background: #DFE9F5 url(/Admin/images/Ribbon/UI/Tab/tab_bg.jpg) repeat-x scroll left bottom;">
	
	<asp:Literal id="BoxStart" runat="server"></asp:Literal>
	
		<form id="Form1" method="post" runat="server">
        <input type="hidden" id="hiddenClose" name="Close" value="" />
		<asp:Literal id="errCodeBlock" runat="server"></asp:Literal>
		<asp:Literal id="NoCountryExistsForLanguageBlock" runat="server"></asp:Literal>
		<dw:TabHeader id="TabHeader1" runat="server" TotalWidth="100%"></dw:TabHeader>
		
			<table border="0" cellpadding="0" cellspacing="0" class="tabTable100" id="DW_Ecom_tableTab">
			<tr>
			<td valign="top">
		
			<div id="Tab1">			
				<br>

				<table border=0 cellpadding=0 cellspacing=0 width='95%' style='width:95%;'>
				<tr><td>

				<fieldset style='width: 100%;margin:5px;'><legend class=gbTitle><%=Translate.Translate("Indstillinger")%>&nbsp;</legend>

				<table border=0 cellpadding=2 cellspacing=0 width='100%' style='width:100%;'>
				<tr><td>
					<table border=0 cellpadding=2 cellspacing=2 width="100%">
					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelName" runat="server" Text="Navn" /></td>
					<td>
				        <div id="errName" name="errName" style="color: Red;"></div>
				        <asp:textbox id="Name" CssClass="NewUIinput" runat="server"></asp:textbox>
				    </td>
					</tr>
					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelcID" runat="server" Text="Landekode %%" /></td>
					<td>
				        <div id="errcID" name="errcID" style="color: Red;"></div>
				        <asp:DropDownList id="cID" CssClass="NewUIinput" runat="server"></asp:DropDownList>
				    </td>
					</tr>

					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelCode3" runat="server" Text="Landekode %%" /></td>
					<td>
				        <div id="errCode3" name="errCode3" style="color: Red;"></div>
				        <asp:DropDownList id="Code3" CssClass="NewUIinput" runat="server"></asp:DropDownList>
				    </td>
					</tr>

					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelCurrencyCode" runat="server" Text="Valutakode" /></td>
					<td>
				        <div id="errCurrencyCode" name="errCurrencyCode" style="color: Red;"></div>
				        <asp:DropDownList id="CurrencyCode" CssClass="NewUIinput" runat="server"></asp:DropDownList>
				    </td>
					</tr>

					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelNumber" runat="server" Text="Betalingskode" /></td>
					<td>
				        <div id="errNumber" name="errNumber" style="color: Red;"></div>
				        <asp:DropDownList id="Number" CssClass="NewUIinput" runat="server"></asp:DropDownList>
				    </td>
					</tr>

					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelCultureInfo" runat="server" Text="Landestandard ID" /></td>
					<td><asp:textbox id="CultureInfo" CssClass="NewUIinput" runat="server" width="80"></asp:textbox></td>
					</tr>
					
					<tr>
					<td width="170"><dw:TranslateLabel id="tLabelVat" runat="server" Text="Moms" /></td>
					<td>
				        <div id="errVat" name="errVat" style="color: Red;"></div>
				        <asp:textbox id="Vat" CssClass="NewUIinput" runat="server" width="45"></asp:textbox> %
				    </td>
					</tr>					
					</table>
				</td></tr>
				</table>

				</fieldset><br><br>

				</td></tr>
				</table>

				<br>						

				<asp:Button id="SaveButton" style="display:none;" runat="server" />
				<asp:Button id="DeleteButton" style="display:none;" runat="server" />

			</div>
			
			<div id="Tab2" class="Tab2Div" style="display:none;">
				<asp:Literal id="countryRelDefaultList" runat="server" />
			</div>			
			
            <div id="Tab3" class="Tab3Div" style="display:none">
				<br />

				<table cellpadding="0" cellspacing="0" style="width:95%; border:0">
				<tr><td>

				<fieldset style='width: 100%;margin:5px;'>
                    <legend class="gbTitle"><%= Translate.Translate("Regions \ States")%></legend>
					<div class="OutlookTableBorder" style="width: 100%">
                    <dw:EditableGrid runat="server" ID="regionsGrid" ClientIDMode="AutoID" AllowAddingRows="True">
                        <Columns>
                            <asp:TemplateField HeaderStyle-Width="100" HeaderStyle-CssClass="OutlookHeaderStart">
                                <ItemTemplate>
                                    <input type="hidden" id="colOldCode" />
                                    <asp:TextBox runat="server" ID="colCode" Text="" CssClass="NewUIinput" Width="100" MaxLength="2" style="margin-left: 5px;" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField  HeaderStyle-Width="90%" HeaderStyle-CssClass="OutlookHeader">
                                <ItemTemplate>
                                    <asp:TextBox runat="server" ID="colName" Text="" CssClass="NewUIinput" Width="200" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="20px" HeaderStyle-CssClass="OutlookHeader">
                                <ItemTemplate>
                                    <span class="option-field-offset">
                                        <img id="imgError" runat='server' src="/Admin/Images/Ribbon/Icons/Small/Error.png" style="display: none" alt="" title="" border="0" />
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-Width="20px"  HeaderStyle-CssClass="OutlookHeader">
                                <ItemTemplate>
                                    <span class="option-field-offset">
                                        <a href="javascript:void(0);" onclick="javascript:delRow(this);">
                                            <img src="/Admin/Images/Ribbon/Icons/Small/Delete.png" alt="" title="<%= Translate.Translate("Delete")%>" border="0" />
                                        </a>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </dw:EditableGrid>
                    </div>
				</fieldset><br><br>

				</td></tr>
				</table>
			</div>
			</td>
			</tr>
			</table>

		</form>

	<asp:Literal id="BoxEnd" runat="server" />
	<script>
        addMinLengthRestriction('Name', 1, '<%=Translate.JsTranslate("A name is needed")%>');
        addMinLengthRestriction('cID', 1, '<%=Translate.JsTranslate("A country code (2) has to be selected")%>');
        addMinLengthRestriction('Code3', 1, '<%=Translate.JsTranslate("A country code (3) has to be selected")%>');
        addMinLengthRestriction('CurrencyCode', 1, '<%=Translate.JsTranslate("A currency code has to be selected")%>');
        addMinLengthRestriction('Number', 1, '<%=Translate.JsTranslate("A payment gateway country code has to be selected")%>');
        addPercentRestriction('Vat', 0, 100, '<%=Translate.JsTranslate("Needs to be a valid percentage value between %lower% and %higher%", "%lower%", "0", "%higher%", "100")%>');
        activateValidation('Form1');
    </script>

	</body>
</HTML>

<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>