<%@  Language="vb" AutoEventWireup="false" CodeBehind="SystemSolutionReport_cpl.aspx.vb" Inherits="Dynamicweb.Admin.SystemSolutionReport" %>

<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Import namespace="System.Data" %>

<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
    <head>
    <title runat="server"></title>
    <dw:ControlResources ID="ControlResources1" runat="server" />
        <script type="text/javascript">
            var url = '/Admin/Content/Management/Pages/SystemSolutionReport_cpl.aspx';
            var productCategoryComfirmMessage = '<%= Translate.Translate("Delete old product category information? This will only delete the old product category data structure, new tables are not touched. This action cannot be undone and will remove the option to downgrade to a version before 8.2.0.0.")%>';
           
            function Purge(param, text, shrinkDB) {

                var confirmMessage;

                if (param == "productcategories") {
                    confirmMessage = productCategoryComfirmMessage;
                } else {
                    confirmMessage = <%= "'" & Translate.Translate("Are you sure you want to purge ") & "'" %> + " " + text;
                    }

                if (confirm(confirmMessage)) {
                    var NewLocation = url + "?cmd=" + param
                    if ('cache' != param && 'productcategories' != param)
                        NewLocation += "&date=" + document.getElementById("purge" + param).children[2].value;

                    var o = new overlay('wait');

                    if (shrinkDB) {
                        setTimeout(function() {
                            document.getElementById("lbShrinkInfo").style.display = "";
                        }, 1000);
                    } else {
                        document.getElementById("lbShrinkInfo").style.display = "none";
                    }

                    new Ajax.Request(NewLocation, {
                        asynchronous: true,
                        onSuccess: function(transport) {

                            document.getElementById("lbShrinkInfo").style.display = "none";

                            if (transport.responseText == param + "_reload")
                                location.href = url;

                            var values = null;
                            if (shrinkDB)
                                values = transport.responseText.split(";");

                            if (values == null || (values != null && values.length == 0)) {
                                values = new Array();
                                values.push(transport.responseText);
                            }

                            document.getElementById("value_" + param).innerHTML = values[0];
                            if (values.length > 1) document.getElementById("lbSizeOfDb").innerHTML = values[1] + "&nbsp;";
                            o.hide();
                        }
                    });

                    o.show();
                }
            }

            function help()
            {
                <%=Gui.help("", "administration.managementcenter.solution.report") %>
            }
        </script>
        <style type="text/css">
            td.column
            {
                width:170px;
            }
            input.purge
            {
                margin-left:10px;
            }
        </style>
    </head>
<body>
	<dw:Overlay ID="wait" runat="server" Message="" ShowWaitAnimation="True">
		<dw:TranslateLabel ID="TranslateLabel7" runat="server" Text="Please wait" />...
        <div id="lbShrinkInfo" class="column" style="display:none; font-size:x-small;">
            <dw:TranslateLabel ID="TranslateLabel26" runat="server" Text="Database is shrinking. It may take a several minutes." /><br/>
        </div>
	</dw:Overlay>
            <div id="divToolbar" style="height:auto;min-width:600px;">
                <dw:Toolbar ID="Buttons" runat="server" ShowEnd="false">
		            <dw:ToolbarButton ID="cmdCancel" runat="server" Divide="None" Image="Cancel" Text="Cancel" OnClientClick="window.location='/Admin/Content/Management/Start.aspx';" ShowWait="True">
		            </dw:ToolbarButton>
		            <dw:ToolbarButton ID="cmdHelp" runat="server" Divide="None" Image="Help" Text="Help" OnClientClick="help();">
		            </dw:ToolbarButton>
	            </dw:Toolbar>
    	        
                <h2 class="subtitle">
                    <dw:TranslateLabel ID="lbSubTitle" Text="Solution report" runat="server" />
                </h2>
            </div>
    <form id="form1" runat="server">
   <div id="PageContent">     
  <dw:GroupBox ID="GroupBox0" runat="server" Title="Information">
	    <table>
            <tr>
                <td class="column" ><dw:TranslateLabel ID="TranslateLabel6" runat="server" Text="Parameter name" /> </td>
                <td class="column" ><dw:TranslateLabel ID="TranslateLabel23" runat="server" Text="Parameter value" /> </td>
            </tr>
              <tr>
                <td class="column" > <dw:TranslateLabel ID="TranslateLabel0" runat="server" Text="Size of /Files folder:" /> </td>
                <td class="column" ><%=GetSizeOfFiles()%> <dw:TranslateLabel ID="TranslateLabel25" runat="server" Text="MB" /></td>
            </tr>
              <tr>
                <td class="column" ><dw:TranslateLabel ID="TranslateLabel1" runat="server" Text="Size of database: " /></td>
                <td class="column"><div id="lbSizeOfDb" style="float:left;"><%=GetSizeOfDatabase()%> &nbsp;</div><dw:TranslateLabel ID="TranslateLabel24" runat="server" Text="MB" /></td>
            </tr>
              <tr>
                <td class="column" ><dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Max number of page views:" /></td>
                <td class="column" ><%=GetMaxNumberOfPageViews()%></td>
            </tr>
              <tr>
                <td class="column" ><dw:TranslateLabel ID="TranslateLabel3" runat="server" Text="Number of pages :" /> </td>
                <td class="column" ><%= GetNumberOfPages()%> </td>
            </tr>
              <tr>
                <td class="column" ><dw:TranslateLabel ID="TranslateLabel4" runat="server" Text="Number of users :" /></td>
                <td class="column" ><%=GetNumberOfUsers()%></td>
            </tr>
              <tr>
                <td class="column" ><dw:TranslateLabel ID="TranslateLabel5" runat="server" Text="Number of visits :" /></td>
                <td class="column" > <%=GetNumberOfVisits()%></td>
            </tr>
        </table>
</dw:GroupBox>
<%--
  <dw:StretchedContainer ID="OuterContainer" Scroll="Hidden" Stretch="Fill" Anchor="document" runat="server">
            <dw:List ID="SurveyList" runat="server" Title="" ShowTitle="false" TranslateTitle="false" StretchContent="true"
                UseCountForPaging="true" HandlePagingManually="true" PageSize="25" >
                <Filters>
                    <dw:ListTextFilter runat="server" ID="TextSurveyFilter" WaterMarkText="Search" Width="175"
                        ShowSubmitButton="True" Divide="None" Priority="1" />
                    <dw:ListDropDownListFilter ID="PageSizeFilter1" Width="150" Label="Surveys per page"
                        AutoPostBack="true" Priority="2" runat="server">
                        <Items>
                            <dw:ListFilterOption Text="25" Value="25" Selected="true" DoTranslate="false" />
                            <dw:ListFilterOption Text="50" Value="50" DoTranslate="false" />
                            <dw:ListFilterOption Text="75" Value="75" DoTranslate="false" />
                            <dw:ListFilterOption Text="100" Value="100" DoTranslate="false" />
                            <dw:ListFilterOption Text="200" Value="200" DoTranslate="false" />
                        </Items>
                    </dw:ListDropDownListFilter>
                </Filters>
                <Columns>
                    <dw:ListColumn ID="sListColumn0" EnableSorting="false" runat="server" Name="" Width="5">
                    </dw:ListColumn>
                    <dw:ListColumn ID="sName" EnableSorting="true" runat="server" Name="Name" Width="400">
                    </dw:ListColumn>
                    <dw:ListColumn ID="sModifiedOn" EnableSorting="true" runat="server" Name="Modified" HeaderAlign="Center" ItemAlign="Center" Width="150">
                    </dw:ListColumn>
                    <dw:ListColumn ID="sIsActive" EnableSorting="true" runat="server" Name="Active" HeaderAlign="Center" ItemAlign="Center" Width="60">
                    </dw:ListColumn>
                </Columns>
            </dw:List>
        </dw:StretchedContainer>
--%>
  <dw:GroupBox ID="GroupBox1" runat="server" Title="Actions :">
 
    <table>
        <tr>
            <td class="column" ><dw:TranslateLabel ID="TranslateLabel8" runat="server" Text="Metric name" /></td>
            <td class="column" ><dw:TranslateLabel ID="TranslateLabel9" runat="server" Text="Metric value" /></td>
            <td ><dw:TranslateLabel ID="TranslateLabel10" runat="server" Text="Purge before" /></td>
            <td ></td>
        </tr>
        <tr>
            <td class="column" ><dw:TranslateLabel ID="TranslateLabel11" runat="server" Text="Statistics Session" /></td>
            <td class="column" ><span id="value_statv2session"><%= GetNORStatV2Session()%></span> <dw:TranslateLabel ID="TranslateLabel12" runat="server" Text="" /> </td>
            <td>  <omc:DateSelector  runat="server" ID="purgestatv2session" />
            </td>
            <td>
                <input class="purge" type="button" value="Purge" onclick="Purge('statv2session','Statistics Session', true);"
             id="Statv2session"
              name="Statv2session" />
            </td>
        </tr>
        <tr>
            <td class="column" ><dw:TranslateLabel ID="TranslateLabel13" runat="server" Text="Statistics Session Bot" /> </td>
            <td class="column" ><span id="value_statv2sessionbot"><%= GetNORStatV2SessionBot()%></span> <dw:TranslateLabel ID="TranslateLabel14" runat="server" Text="" /> </td>
            <td> <omc:DateSelector  runat="server" ID="purgestatv2sessionbot" /></td>
            <td>
                  <input class="purge" type="button" value="Purge" onclick="Purge('statv2sessionbot','Statistics Session Bot',true);"
                id="Statv2sessionbot"
                name="Statv2sessionbot" />
            </td>
           </tr>
        <tr>
            <td class="column" ><dw:TranslateLabel ID="TranslateLabel15" runat="server" Text="General Log" /> </td>
            <td class="column" ><span id="value_generallog"><%= GetNORGeneralLog()%></span> <dw:TranslateLabel ID="TranslateLabel16" runat="server" Text="" /></td>
            <td> <omc:DateSelector  runat="server" ID="purgegenerallog" /></td>
            <td>
                 <input class="purge" type="button" value="Purge" onclick="Purge('generallog','General log',true);"
                    id="GeneralLog"
                     name="GeneralLog" />
            </td>
        </tr>
        <tr>
          
            <td class="column" ><dw:TranslateLabel ID="TranslateLabel19" runat="server" Text="Action Log" /> </td>
            <td class="column" ><span id="value_actionlog"><%= GetNORActionLog()%></span> <dw:TranslateLabel ID="TranslateLabel17" runat="server" Text="" /></td>
            <td> <omc:DateSelector  runat="server" ID="purgeactionlog" /></td>
            <td>
                 <input class="purge" type="button" value="Purge" onclick="Purge('actionlog','Action log',true);"
             id="ActionLog"
              name="ActionLog" />
            </td>
        </tr>
        <tr>
            <td class="column" ><dw:TranslateLabel ID="TranslateLabel20" runat="server" Text="Trashbin" /></td>
            <td class="column" ><span id="value_trashbin"><%=GetNORTrashbin()%></span> <dw:TranslateLabel ID="TranslateLabel18" runat="server" Text="" /></td>
            <td> <omc:DateSelector  runat="server" ID="purgetrashbin"/></td>
            <td>
                <input class="purge" type="button" value="Purge" onclick="Purge('trashbin','Trashbin',true);"
            id="TrashBin"
              name="TrashBin" />
            </td>
        </tr>
          <tr>
            <td class="column" ><dw:TranslateLabel ID="TranslateLabel21" runat="server" Text="Size of cache" /> </td>
            <td class="column" ><span id="value_cache"><%=GetSizeOfCache()%></span> <dw:TranslateLabel ID="TranslateLabel22" runat="server" Text="MB" /></td>
           <td> </td>
           <td>
                <input class="purge" type="button" value="Purge" onclick="Purge('cache','Cache', false);"
             id="Cache"
              name="Cache" />
            </td>
        </tr>
    </table>
    
    </dw:GroupBox>
	
	<dw:GroupBox runat="server" ID="ProductCategories" DoTranslation="true" Title="Product categories" Visible="false">
		<table>
			<tr>
				<td class="column"><dw:TranslateLabel runat="server" Text="Product categories" /></td>
				<td class="column">&nbsp;</td>
                <td style="width: 81px;">&nbsp;</td>
				<td><input type="button" class="purge" value="Purge" onclick="Purge('productcategories', 'productcategories', true);" /></td>
			</tr>
		</table>
	</dw:GroupBox>
    </div>
    </form>
</body>
<%  Translate.GetEditOnlineScript()%>
</html>
