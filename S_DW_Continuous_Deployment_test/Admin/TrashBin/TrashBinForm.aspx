<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TrashBinForm.aspx.vb" Inherits="Dynamicweb.Admin.TrashBinForm" codePage="65001"%>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><%=Translate.JSTranslate("Papirkurv")%></title>
		<link rel="Stylesheet" type="text/css" href="/admin/Stylesheet.css" />
        <dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server" />
        <dw:Overlay ID="wait" runat="server" Message="" ShowWaitAnimation="True" />

		<script type="text/javascript">
		    var _overlayWait = new overlay('wait');
		    
		    if (<%=intPageAffected%> != 0)
		    {
		        parent.left.location = "../menu.aspx?ID=<%=intPageID%>&AreaID=<%=intAreaID%>"
		    }

		    function restore(type, itemID, trashID)
		    {
		        // paragraph
		        if (type === 2) {
		            restoreParagraph(type, itemID, trashID);
		        } else {
		            location = 'TrashBinForm.aspx?restore=true&Type=' + type + '&ItemID=' + itemID + '&trashid=' + trashID;   
		        }
		    }
		   
		    function restoreto(type, pageID) {
		        var callback = function(response) {
		            var jsonRslt = response.responseText.evalJSON();
		            if (jsonRslt.HasPermissions == 'True') {
		                movepageWindow = window.open("/Admin/menu.aspx?ShowTrashBin=no&MoveID=" + pageID + "&Action=RestoreTo", "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=250,height=450,top=155,left=202");
		            } else {
		                alert('<%=strNoPermissions %>');
		            }
		        };

		        request({
		            url: 'TrashBinForm.aspx?restoreto=true',
		            parameters: {
		                Type: type,
		                ItemID: pageID
		            },
		            onSuccess: callback
		        });
		    }
           
		    function restoreParagraph(type, paragraphID) {
		        var options = {}, 
		            onRestore = function(response) {
		                if (response.responseText.isJSON()) {
		                    var result = response.responseText.evalJSON();
		                    if (result.message) {
		                        alert(result.message);
		                    }
		                }
		                
		                location.reload(); 
		            },
		            onPermissionsCheck = function(response) {
		                if (response.responseText.isJSON()) {
		                    var result = response.responseText.evalJSON();
		                    if (result.HasPermissions == 'True') {
		                        options.url = '/Admin/Paragraph/Paragraph_RestoreTo.aspx';
		                        options.parameters = {
		                            Action: 'RestoreParagraph',
		                            ParagraphId: paragraphID
		                        };
		                    
		                        options.onSuccess = onRestore;

		                        request(options);
		                    }
		                    else{
		                        alert('<%=strNoPermissions %>');
		                    }   
		                }
		            };

		        options.url = 'TrashBinForm.aspx?restoreto=true';
		        options.parameters = {
		            Type: type,
		            ItemID: paragraphID
		        };
		        options.onSuccess = onPermissionsCheck;
		        options.keepOverlay = true;
		        request(options);
		    }
	   
		    function restoreParagraphto(type, paragraphID) {
		        var callback = function(response) {
		            var jsonRslt = response.responseText.evalJSON();
		            if (jsonRslt.HasPermissions == 'True') {
		                movepageWindow = window.open("/Admin/menu.aspx?ShowTrashBin=no&MoveID=" + paragraphID + "&Action=RestoreParagraphTo", "_new", "resizable=yes,scrollbars=auto,toolbar=no,location=no,directories=no,status=no,width=250,height=450,top=155,left=202");
		            } else {
		                alert('<%=strNoPermissions %>');
		            }
		        };

		        request({
		            url: 'TrashBinForm.aspx?restoreto=true',
		            parameters: {
		                Type: type,
		                ItemID: paragraphID
		            },
		            onSuccess: callback
		        });
		    }
           
		    function request(options) {
		        var _overlay;
		        if (!options) {
		            return;
		        }

		        if (!options.parameters || !options.parameters.IsAjax) {
		            options.parameters = options.parameters || {};
		            options.parameters.IsAjax = true;
		        }

		        _overlay = new overlay('wait');

		        new Ajax.Request(options.url, {
		            method: options.method || 'GET',
		            parameters: options.parameters || {},
		            onCreate: function() {
		                _overlay.show();
		            },
		            onSuccess: function(response) {
		                if (options.onSuccess) {
		                    options.onSuccess(response);
		                }
		            },
		            onFailure: function(response) {
		                if (options.onFailure) {
		                    options.onFailure(response);
		                }
		            },
		            onComplete: function(response) {
		                if (!options.keepOverlay) {
		                    setTimeout(function() {
		                        _overlay.hide();
		                    }, 250);
		                }
		            }
		        });
		    }

   
		    function EmptyTrashBin()
		    {
		        if (confirm('<%=Translate.JSTranslate("Tøm %%?", "%%", Translate.Translate("papirkurv"))%>\n\n<%=Translate.JSTranslate("ADVARSEL!")%>\n<%=Translate.JSTranslate("Alle %% vil blive slettet permanent!", "%%", Translate.Translate("elementer"))%>')){
		            location = 'TrashBinForm.aspx?empty=true';
		        }
		        return true;
		    }

		    function ShowAlert()
		    {
		        <asp:Literal id="strErrorMessage" runat="server"/>
		        return true;
		    }

		</script>
	</head>
	<body onload="javascript:ShowAlert();">
		<dw:TabHeader id="TabHeader1" runat="server" title="Trashbin" Headers="Contents" />
		<table border="0" cellpadding="0" cellspacing="0" class="tabTable" id="DW_Ecom_tableTab">
			<tr>
				<td valign="top">
					<div id="Tab1">
						<asp:literal id="strTrashBinTable" EnableViewState="False" Runat="server"></asp:literal>
					</div>
				</td>
			</tr>
		</table>    
<%
    Translate.GetEditOnlineScript()
   
%>  
	</body>
</html>
