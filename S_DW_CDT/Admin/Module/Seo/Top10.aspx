<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Top10.aspx.vb" inherits="Dynamicweb.Admin.Top10"%>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
	<head>
		<title></title>
		<dw:ControlResources ID="ctrlResources" IncludePrototype="true" runat="server" />
		<script type="text/javascript" src="http://www.google.com/jsapi"></script>
		<script type="text/javascript" src="/Admin/Module/Seo/Seo.js"></script>
		
		<link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css">
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
		
		<meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="expires" content="0">
		
		<style type="text/css">
		    .ddList
		    {
		    	width: 250px;
		    }
		</style>
		
		<script type="text/javascript">
		    var list = null;
		    var lang = '<%=CurrentLanguage %>';
		    var itemTemplate = '<li><a href="#{unescapedUrl}" target="_blank" style="color:#00c">#{title}</a><br />#{content}<br /><span style="color:green">#{visibleUrl}</span></li><br />';

		    function updateResultsList(query) {
		        var divNoResults = $('divNoResults');
		        
		        if (!list) {
		            list = new Seo.SearchResultsList('resultsList');
		            list.set_state(new Seo.Progress('progressContainer'));
		            list.set_itemTemplate(itemTemplate);
		        }

                divNoResults.hide();
                
                if (query && query.length > 0) {
                    list.render({
                        query: query,
                        language: lang,
                        onComplete: function() { divNoResults.show(); }
                    });
                }
		    }
		</script>
	</head>
	<body>
	    <form id="MainForm" runat="server">
		    <dw:tabheader id="TabHeader1" runat="server" title="Top 10 konkurrenter" returnwhat="All" headers="Top 10"></dw:tabheader>
		    <table border="0" cellpadding="0" cellspacing="0" class="tabTable">
			    <tr>
				    <td valign="top">
				        <br>
					    <table border="0" cellpadding="0" width="100%">
					        
					        <tr>
					            <td>
					                <dw:GroupBox Title="Phrase" runat="server">
					                    <asp:DropDownList id="ddPhrases" CssClass="ddList" runat="server">
					                    </asp:DropDownList>
					                </dw:GroupBox>
					                <br />
					                <dw:GroupBox Title="Results" runat="server">
					                    <div id="progressContainer" style="display: none">
                                            <table width="100%">
                                                <tr>
                                                    <td align="center">
                                                        <dw:TranslateLabel ID="lpPleaseWait" Text="Please wait while search results are being retrieved..." runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center">
                                                        <img src="Dynamicweb_wait.gif" alt="" border="0" />
                                                    </td>
                                                </tr>
                                            </table>
		                                </div>
		                                
					                    <ol id="resultsList">
							            </ol>
							            
							            <div id="divNoResults" style="text-align: center; font-style: italic">
							                <dw:TranslateLabel ID="lbNoMoreResults" Text="Sorry, no more results are available" runat="server" />
							            </div>
					                </dw:GroupBox>
					            </td>
					        </tr>
					    </table>
				    </td>
			    </tr>
		    </table>
		</form>
		<%Dynamicweb.Backend.Translate.GetEditOnlineScript()%>
	</body>
</html>