<%@ Page CodeBehind="Audit_List.aspx.vb" Language="vb" AutoEventWireup="false" Inherits="Dynamicweb.Admin.Audit_List" %>
<%@ Register TagPrefix="dw" Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="System.Collections" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>

    <head>

        <meta http-equiv="Content-Type"  content="text/html;charset=utf-8" />
        <title></title>
	    <dw:ControlResources ID="ControlResources" runat="server" ></dw:ControlResources>

        <style type="text/css">
	    </style>

        <script type="text/javascript" language="JavaScript">

            function help() {
                <%=Gui.help("", "modules.audit.general.list") %>
            }

            function UpdateElement() {

                var rows = List.getSelectedRows('AuditList');

                var userID = '', itemID = '';
                var pageIDs = '', paragraphIDs = '', newsIDs = '', calendarIDs = '';

                if (rows && rows.length > 0) {
                    for (var i = 0; i < rows.length; i++) {
                        userID = rows[i].id;
                        if (userID != null && userID.length > 0) {
                            if (userID.substr(0, 4) == 'Page') {
                                pageIDs += userID.replace(/Page/gi, '');
                                pageIDs += ',';
                            }
                            if (userID.substr(0, 9) == 'Paragraph') {
                                paragraphIDs += userID.replace(/Paragraph/gi, '')
                                paragraphIDs += ',';
                            }
                            if (userID.substr(0, 4) == 'News') {
                                newsIDs += userID.replace(/News/gi, '');
                                newsIDs += ',';
                            }
                            if (userID.substr(0, 8) == 'Calendar') {
                                calendarIDs += userID.replace(/Calendar/gi, '');
                                calendarIDs += ',';
                            }
                        }
                    }
                }

                if (pageIDs.length > 0) {
                    pageIDs = pageIDs.substring(0, pageIDs.length - 1);
                }
                $('PageIDs').value = pageIDs;

                if (paragraphIDs.length > 0) {
                    paragraphIDs = paragraphIDs.substring(0, paragraphIDs.length - 1);
                }
                $('ParagraphIDs').value = paragraphIDs;

                if (newsIDs.length > 0) {
                    newsIDs = newsIDs.substring(0, newsIDs.length - 1);
                }
                $('NewsIDs').value = newsIDs;

                if (calendarIDs.length > 0) {
                    calendarIDs = calendarIDs.substring(0, calendarIDs.length - 1);
                }
                $('CalendarIDs').value = calendarIDs;

		        $('UpdateElements').value = 'yes';
		        AuditForm.submit();
	        }
        </script>

    </head>

	<body>

        <div id="PageContent" style="overflow: auto;min-width:650px;" >
		    <form method="post" action="Audit_list.aspx" id="AuditForm" name="AuditForm" runat="server">

                <input type="hidden" id="UpdateElements" name="UpdateElements" value="" />
                <input type="hidden" id="PageIDs" name="PageIDs" value="" />
                <input type="hidden" id="ParagraphIDs" name="ParagraphIDs" value="" />
                <input type="hidden" id="NewsIDs" name="NewsIDs" value="" />
                <input type="hidden" id="CalendarIDs" name="CalendarIDs" value="" />

                <dw:Toolbar ID="ToolbarButtons" ShowStart="false" ShowEnd="false" runat="server" >
                    <dw:ToolbarButton ID="cmdAply" Image="Check" Text="Apply" OnClientClick="javascript:List._submitForm('List');" runat="server" />
                    <dw:ToolbarButton ID="cmdUpdate" Image="Update" Divide="Before" Text="Update selected" OnClientClick="UpdateElement();" runat="server" />
                    <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="Before" Image="Cancel" OnClientClick="location='/Admin/Content/Management/Start.aspx';" Text="Cancel" />
	                <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="Before" Image="Help" Text="Help" OnClientClick="help();" />
                </dw:Toolbar>
                <h2 class="subtitle">
	                <dw:TranslateLabel ID="lbAudit" Text="Audit" runat="server" />
	            </h2>


                <dw:List runat="server" ID="AuditList" ShowTitle="false" AllowMultiSelect="true" NoItemsMessage="Der er ikke oprettet nogen kategorier" PageSize="25" >
                    <Columns>
                        <dw:ListColumn ID="coltype" EnableSorting="true" runat="server" Name="Type" HeaderAlign="Center" ItemAlign="Center" />
                        <dw:ListColumn ID="colname" EnableSorting="true" runat="server" Name="Name" HeaderAlign="Left" ItemAlign="Left" />
                        <dw:ListColumn ID="colcreated" EnableSorting="true" runat="server" Name="Created" HeaderAlign="Center" ItemAlign="Center" />
                        <dw:ListColumn ID="colcreator" EnableSorting="true" runat="server" Name="Creator" HeaderAlign="Left" ItemAlign="Left" />
                        <dw:ListColumn ID="coledited" EnableSorting="true" runat="server" Name="Edited" HeaderAlign="Center" ItemAlign="Center" />
                        <dw:ListColumn ID="coleditor" EnableSorting="true" runat="server" Name="Editor" HeaderAlign="Left" ItemAlign="Left" />
                        <dw:ListColumn ID="coldeleted" EnableSorting="true" runat="server" Name="Deleted" HeaderAlign="Center" ItemAlign="Center" />
                        <dw:ListColumn ID="coldeletedby" EnableSorting="true" runat="server" Name="Deleted by" HeaderAlign="Center" ItemAlign="Center" />
                    </Columns>

                    <Filters>

                        <dw:ListDropDownListFilter runat="server" ID="UserDropDownListFilter" Label="Select a user" Width="200"></dw:ListDropDownListFilter>
                    
                        <dw:ListDateFilter runat="server" id="FromDateFilter" Label="Set from" IncludeTime="true" Divide="After" />

                        <dw:ListDropDownListFilter runat="server" ID="TypeDropDownListFilter" Label="Select type" Width="200"></dw:ListDropDownListFilter>
                    
                        <dw:ListDateFilter runat="server" id="ToDateFilter" Label="Set to" IncludeTime="true"  Divide="After" />
                    
                        <dw:ListDropDownListFilter runat="server" ID="AreaDropDownListFilter" Label="Language layer" AutoPostBack="false" Width="200"></dw:ListDropDownListFilter>

                    </Filters>

                </dw:List>
            </form>
        </div>

	</body>
</html>

<%Translate.GetEditOnlineScript()%>
