<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SelectEmailLink.aspx.vb" Inherits="Dynamicweb.Admin.SelectEmailLink" %>

<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title><%= Translate.Translate("Select Email Link") %></title>
    <dw:ControlResources ID="ctrlResources" runat="server"></dw:ControlResources>
    <link rel="stylesheet" type="text/css" href="/Admin/Images/Ribbon/UI/Toolbar/Toolbar.css" />

    <style>
        #ListTable tr[itemid] {
            cursor: pointer;
        }
    </style>
    <script type="text/javascript">
        var addEvent = window.attachEvent ? function (el, event, handler) { el.attachEvent('on' + event, handler); } : function (el, event, handler) { el.addEventListener(event, handler, false); };
        function openEmailSelector(evt) {
            var url = '/Admin/Module/OMC/Default.aspx?fromparametereditor=1&openerid=email';
            win = window.open(url, '_blank', "displayWindow,width=700,height=400,scrollbars=no");

            addEvent(win, 'beforeunload', function (evt) {
                var emailId = parseInt(document.getElementById('email').value);

                if (!isNaN(emailId)) {
                    document.getElementById('form').submit();
                }
            });
        }
    </script>
</head>
<body>
    <form id="form" runat="server" method="post">
        <div id="divToolbar">
            <div class="Toolbar" style="font-family: arial,verdana,Microsoft JhengHei; font-size: 11px;" id="Buttons">
                <ul>
                    <li>
                        <img alt="" style="margin-top: 4px; margin-bottom: 4px; margin-left: 2px;" src="/Admin/Images/Ribbon/UI/Toolbar/Start.gif" /></li>
                    <li id="cmd"><a id="link" class="toolbar-button" title="Close" href="#"><span id="container" onclick="window.close();" class="toolbar-button-container">
                        <img id="" name="" class="icon" alt="Close" src="/Admin/Images/Ribbon/Icons/Small/Cancel.png" />Close</span></a></li>
                </ul>
            </div>
        </div>
        
        <div class="list">
            <table class="main" cellspacing="0">
                <tbody>
                    <tr>
                        <td>
                            <div id="filtersDiv">
                                <div class="filters">                                    
                                    <input type="hidden" id="email" name="emailId" value="<%= If(Email IsNot Nothing, Email.ID.ToString(), "")%>" readonly="" />
                                    <input type="text" id="Title_email" name="emailTitle" value="<%= If(Email IsNot Nothing, Email.Subject, "")%>" disabled="disabled" />
                                    <button type="button" id="btnSelectEmail"><%= Translate.Translate("Select email") %></button>
                                </div>                                    
                            </div>                        
                        </td>
                    </tr>

                </tbody>
            </table>
        </div>
        <dw:StretchedContainer ID="OuterContainer" Scroll="Hidden" Stretch="Fill" Anchor="document" runat="server">
            <dw:List runat="server" ID="LinkList" AllowMultiSelect="false" Title="Select email link" ShowHeader="false"
                StretchContent="true" HandlePagingManually="true" PageSize="1000" NoItemsMessage="No links in selected email">
                <Columns>
                    <dw:ListColumn runat="server" ID="LinkOriginalUrl" Name="Link" TranslateName="true" />
                </Columns>
            </dw:List>
        </dw:StretchedContainer>
    </form>
    <script type="text/javascript">(function () {
    var addEvent = window.attachEvent ? function (el, event, handler) { el.attachEvent('on' + event, handler); } : function (el, event, handler) { el.addEventListener(event, handler, false); };

    addEvent(window, 'load', function () {
        var getCallBack = function () {
            var path = '<%= Request("callback") %>'.split('.'),
				i, step,
			callback = null;
            for (i = 0; step = path[i]; i++) {
                if (callback) {
                    callback = callback[step];
                } else {
                    callback = window[step];
                }
                if (!callback) {
                    break;
                }
            }
            return callback;
        };                

        addEvent(document.getElementById('btnSelectEmail'), 'click', function (evt) {
            openEmailSelector(evt);
        });

        window.selectLink = function (linkId, linkUrl) {
            var emailSubject = document.getElementById('Title_email').value,
            callback = getCallBack();

            if (callback) {
                callback({
                    linkId: linkId,
                    linkUrl: linkUrl,
                    emailSubject: emailSubject
                });
                if (window.opener) {
                    try {
                        window.close();
                    } catch (ex) { }
                }
            }
        };
    });        
}())
</script>
    <% Translate.GetEditOnlineScript()%>
</body>
</html>
