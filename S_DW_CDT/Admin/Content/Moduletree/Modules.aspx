<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Modules.aspx.vb" Inherits="Dynamicweb.Admin.Moduletree.Modules" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
    <link rel="Stylesheet" type="text/css" href="../../Stylesheet.css" />
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server" />
    <script type="text/javascript">

        function validateForm() {
            var ret = false;
            var radioButtons = document.getElementsByName('SolutionSelectcms');

            if (radioButtons && radioButtons.length > 0) {
                for (var i = 0; i < radioButtons.length; i++) {
                    if (radioButtons[i].checked) {
                        ret = true;
                        break;
                    }
                }
            }

            if (!ret) {
                alert('<%=Translate.JsTranslate("Vælg Light, Business eller Portal.")%>');
            }

            return ret;
        }

        function Send() {
            if (validateForm()) {
                if (confirm('<%=Translate.JsTranslate("Do you want to save changes?")%>')) {
                    document.ModuleForm.submit();
                }
            }
        }


        function SaveTabID(tab) {
            document.ModuleForm.GotoTab.value = tab;
        }

        function ChangeSolutionVersion(typeID, solutionID) {

            new Ajax.Request('Modules.aspx?AJAX=ChangeSolution', {
                method: 'get',
                parameters: {
                    typeID: typeID,
                    solutionID: solutionID,
                    zzz: Math.random()
                },
                onSuccess: function (response) {
                    // Get values from response
                    var htmlObj = response.responseText;
                    $("Tab" + typeID).innerHTML = htmlObj;
                },

                onFailure: function () {
                    alert('Something went wrong!');
                },

                onComplete: function () {
                    // Hide the loading div again
                    //alert('Complete!');
                }
            });

            var el = null;
            switch (solutionID) {
                case "cmsProfessional2014":                
                    el = document.getElementById("rdecomProfessional2014");
                    break;
                case "cmsPremium2014":
                    el = document.getElementById("rdecomPremium2014");
                    break;
                case "cmsCorporate2014":
                    el = document.getElementById("rdecomCorporate2014");
                    break;
                case "cmsEnterprise2014":                
                    el = document.getElementById("rdecomEnterprise2014");
                    break;                
            }
            if (el !== null) {
                el.checked = true;
                el.click();
            }

        }

        function SelectAll(typeID) {
            if (confirm('<%=Translate.JsTranslate("Er du sikker på du vil installere alle moduler?")%>')) {
                var inputs = $$("#Tab" + typeID + " input");
                inputs.each(function (input) {
                    if (!input.disabled) input.checked = true;
                });
            }
        }

    </script>

      <script type="text/javascript">
          var SettingsPage = function (pageContentID) {
              this.pageContentID = pageContentID;
          }

          SettingsPage.prototype.initialize = function () {
              this.stretchContent();

              if (window.attachEvent) {
                  window.attachEvent('onresize', function () { __page.stretchContent(); });
              } else if (window.addEventListener) {
                  window.addEventListener('resize', function (e) { __page.stretchContent(); }, false);
              }
          }

          SettingsPage.prototype.stretchContent = function () {
              var statusbarHeight = 0;
              var content = $(this.pageContentID);              
              if (content) {
                  statusbarHeight = 27;
                  content.setStyle({ 'height': (document.body.clientHeight - statusbarHeight) + 'px' });
              }
          }
          var __page = new SettingsPage('ModuleForm');          
    </script>

    <style type="text/css">
        body
        {
            background: <%=Gui.NewUIbgColor()%>;
            overflow: hidden;
        }
        #ModuleForm
        {
            overflow: auto;
        }
    </style>
</head>
<body>
    <%= RenderTabHeaders() %>    
        <form action="Module_Save.aspx" id="ModuleForm" name="ModuleForm" method="post">
        <input name="GotoTab" type="hidden" />
        <table border="0" cellpadding="2" cellspacing="0" class="tabTable" style="cursor: default;
            width: 600px;">
            <tr>
                <td>
                    <br />
                    <%= RenderTabContents()%>
                </td>
            </tr>
            <tr>
                <td align="right" valign="bottom">
                    <table>
                        <tr>
                            <td align="right">
                            </td>
                            <td width="2">
                                <%= RenderOkButton()%>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        </form>    
    <%=Dynamicweb.Gui.SelectTab()%>
    <%If Request.Item("Tab") <> "" Then%>
    <script type="text/javascript">
	document.ModuleForm.GotoTab.value = "<%=Request.Item("Tab")%>";
    </script>
    <%End If%>
</body>
    <script type="text/javascript">
        __page.initialize();
    </script>
<%  Dynamicweb.Backend.Translate.GetEditOnlineScript()
%>
</html>
