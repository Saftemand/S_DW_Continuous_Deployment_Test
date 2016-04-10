<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Statistics.aspx.vb" Inherits="Dynamicweb.Admin.OMC.Emails.Statistics"  MasterPageFile="~/Admin/Module/OMC/EntryContent.Master" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls.Charts" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="omc" TagName="ValidationList" Src="~/Admin/Module/OMC/Controls/ValidationList.ascx" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <dw:ControlResources ID="ctrlResources" IncludePrototype="true" IncludeUIStylesheet="true" runat="server" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <style type="text/css">
      html { height: 100% }
      body { height: 100%; margin: 0; padding: 0 }
      #map_canvas { height: 100% }
      .recipient-list { margin-top: 10px; }
      .dashboard-middle .list tbody[id] > tr.listRow > td {
         height: 13px;
         border-bottom: none;
      }
</style>
    <script type="text/javascript">
        var markers = null;
        function showUniqueLinks() {
            if (document.getElementById("MsgLinks2").checked) {
                document.getElementById("UniqueLinksDiv").style.display = "none";
                document.getElementById("TotalLinksDiv").style.display = "block";
            } else {
                document.getElementById("UniqueLinksDiv").style.display = "block";
                document.getElementById("TotalLinksDiv").style.display = "none";
            }
        }

        function ShowUserPopup(emailId, userId, title, rcptId)
        {
            parent.OMC.MasterPage.get_current().showDialog(
            "/Admin/Module/OMC/Emails/RecipientDetails.aspx?emailId=" + emailId + "&userId=" + userId + "&rcptId=" + rcptId,
              850,
              500,
              { title: title, hideCancelButton: true });
        }

        function ShowLinkPopup(emailId, linkId)
        {
            parent.OMC.MasterPage.get_current().showDialog(
              '/Admin/Module/OMC/Emails/LinkDetails.aspx?emailId=' + emailId + '&linkId=' + linkId,
                850,
                500,
                { title: '<%=Translate.Translate("Link")%>', hideCancelButton: true });
        }    
        function retryEmail(emailId) {
            parent.OMC.MasterPage.get_current().navigate("/Admin/Module/OMC/Emails/Statistics.aspx?OpType=RetryEmail&newsletterID=" + emailId);
        }

    </script>
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
    <script type="text/javascript" src="http://google-maps-utility-library-v3.googlecode.com/svn/trunk/markerclustererplus/src/markerclusterer.js"></script>
    <script type="text/javascript">
        var markers = null;
        var side_bar_html = "";

        var gmarkers = [];
        var gicons = [];
        var map = null;
        var infowindow = new google.maps.InfoWindow();

        function initializeMap() {

            if (navigator.userAgent.indexOf('MSIE') != -1) {
                $('UserLocationContainer').style.width = "850px"; 
            } else {
                $('UserLocationContainer').style.width = "895px"; 
            }

            var myLatlng = new google.maps.LatLng(55.41, 12.34); 
            var myOptions = {
                zoom: 8,
                center: myLatlng,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            }

            myOptions.center = myLatlng;
            map = new google.maps.Map(document.getElementById("UserLocationContainer"), myOptions);

            for (var i = 0; i < markers.length; i++) {
                if (markers[i]) {
                    var lat = markers[i][0];
                    var lng = markers[i][1];
                    var point = new google.maps.LatLng(lat, lng);
                    var name = markers[i][2];
                    var email = markers[i][3];
                    var html = "";
                    
                    if(name.indexOf("N/A") != -1){
                        html = "<b>" + email + "<\/b><p>";
                    }else{
                        html = "<b>" + name + "<\/b><p>" + email;
                    }

                    if (markers[i][6] && markers[i][7] > 0) {
                        html += "<br><p><a href=\"#\" onclick=\"ShowUserPopup(" + markers[i][6] + "," + markers[i][7] + ',\'' + name + '\');\">Recipient details</a>';
                    }

                    var country = markers[i][4];
                    var category = markers[i][5];
                    var marker = createMarker(point, name, category, country, html);
                }
            }

            google.maps.event.addListener(map, 'click', function () {
                infowindow.close();
            });

            google.maps.event.addListener(map, 'zoom_changed', function () {
                    showMarkersClaster();
            });

            showCategory("opened");
            hideCategory("clicked");
            hideCategory("bought");
            hideCategory("unsubscribed");

            showMarkersClaster();
            makeSidebar();
        }

        function createMarker(latlng, name, category, country, html) {
            var contentString = html;
            var marker = new google.maps.Marker({
                position: latlng,
                map: map,
                title: name
            });

            marker.markerCategory = category;
            marker.markerName = name;
            marker.markerCountry = country;
            gmarkers.push(marker);

            google.maps.event.addListener(marker, 'click', function () {
                infowindow.setContent(contentString);
                infowindow.open(map, marker);
            });
        }

        function showCategory(category) {
            for (var i = 0; i < gmarkers.length; i++) {
                if (gmarkers[i] && gmarkers[i].markerCategory == category) {
                    gmarkers[i].setVisible(true);
                }
            }
            $("ch" + category).checked = true;
        }

        function hideCategory(category) {
            for (var i = 0; i < gmarkers.length; i++) {
                if (gmarkers[i] && gmarkers[i].markerCategory == category) {
                    gmarkers[i].setVisible(false);
                }
            }
            $("ch" + category).checked = false;
            infowindow.close();
        }

        function showMarkers(box, category) {
            if (box.checked) {
                showCategory(category);
            } else {
                hideCategory(category);
            }
            makeSidebar();
            showMarkersClaster();
        }

        function locateToCountry(country) {
            var geocoder = new google.maps.Geocoder();
            geocoder.geocode({ 'address': country }, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    map.setCenter(results[0].geometry.location);
                } else {
                    alert("Geocode was not successful for the following reason: " + status);
                }
            });
        }

        function makeSidebar() {
            var html = "";
            var countries = [];
            var recipientCounter = 0;
            for (var i = 0; i < gmarkers.length; i++) {
                if (gmarkers[i].getVisible()) {
                    recipientCounter = 0;
                    for (var j = 0; j < gmarkers.length; j++) {
                        if (gmarkers[j].getVisible() && (gmarkers[i].markerCountry == gmarkers[j].markerCountry)) {
                            recipientCounter++;
                        }
                    }

                    if (countries.indexOf(gmarkers[i].markerCountry) != -1) {
                        break;
                    }else{
                        countries.push(gmarkers[i].markerCountry);
                    }
                    html += '<a href="javascript:locateToCountry(\'' + gmarkers[i].markerCountry + '\')">' + gmarkers[i].markerCountry + '(' + recipientCounter + ')<\/a><br>';
                }
            }
            $("sideBar").innerHTML = html;
        }

        function showMarkersClaster() {
            var mcOptions = { gridSize: 100, maxZoom: 15 };
            var mcMarkers = [];
            for (var i = 0; i < gmarkers.length; i++) {
                if (gmarkers[i].getVisible()) {
                    mcMarkers.push(gmarkers[i]);
                }
            }
            var markerCluster = new MarkerClusterer(map, mcMarkers, mcOptions);
        }

        function ExportStat(datatype)
        {
            var url = '/Admin/Module/OMC/Emails/Statistics.aspx?emailId=<%=Request("newsletterID")%>&OpType=ExportToCSV&datatype=' + datatype;

            setTimeout(function() {
                form = new Element('form', { method: 'post', action: url });                

                document.body.appendChild(form);
                form.submit();

                document.body.removeChild(form);
            }, 50);
        }

        function ShowProgressWheel() {
            var o = new overlay('reloadPage');
            o.show();
        }
    </script>
    <dw:Overlay ID="reloadPage" runat="server"></dw:Overlay>
    <dw:Infobar runat="server" ID="SentCountInfoBar" Visible="False" />
    <dw:Infobar runat="server" ID="infoStatus" Visible="false" />
    <div class="content-main">
       <div class="dashboard-split">
            <div class="dashboard-left">
                <dw:RoundedFrame id="frmPieChart" Width="240" runat="server">
                    <dw:Chart ID="cPieOpens" Type="Pie" Width="200" Height="150" Legend="none" AutoDraw="true" runat="server" />

                    <div class="dashboard-info" style="height: 55px !important;">
                        <h3 style="margin-top: 8px !important; margin-bottom: 2px !important;"><dw:TranslateLabel ID="TranslateLabel2" Text="Legend" runat="server" /></h3>
                        <ul class="statistics-legend" style="margin-top: 0px !important;">
                            <li style="float: none !important;"><div class="statistics-legend-item" id="legendOpened" runat="server" />&nbsp;<dw:TranslateLabel ID="TranslateLabel5" Text="Opened emails" runat="server" /></li>
                            <li style="float: none !important;"><div class="statistics-legend-item" id="legendNotOpened" runat="server" />&nbsp;<dw:TranslateLabel ID="TranslateLabel4" Text="Unopened emails" runat="server" /></li>
                            <!--li style="float: none !important;"><div class="statistics-legend-item" id="legendBounced" runat="server" />&nbsp;<dw:TranslateLabel ID="TranslateLabel6" Text="Bounced emails" runat="server" /></li-->
                        </ul>
                    </div>
                </dw:RoundedFrame>
            </div>

            <div class="dashboard-middle">
        <dw:RoundedFrame ID="frmHighlights" Width="400" runat="server">
            <asp:Panel ID="pList" runat="server">
                <div class="dashboard-info">
                    <asp:Repeater ID="repGeneral" runat="server">
                        <HeaderTemplate>
                            <table class="dashboard-most-visits" cellspacing="0" cellpadding="2" border="0">
                                <tr>
                                    <th class="dashboard-page-name"><dw:TranslateLabel ID="lbRate" Text="General" runat="server" /></th>
                                    <th style="text-align:center;" class="dashboard-page-name"><dw:TranslateLabel ID="lbTotal" Text="Total" runat="server" /></th>
                                    <th style="text-align:center;" class="dashboard-page-name"><dw:TranslateLabel ID="lbDesktop" Text="Desktop" runat="server" /></th>
                                    <th style="text-align:center;" class="dashboard-page-name"><dw:TranslateLabel ID="lbTablet" Text="Tablet" runat="server" /></th>
                                    <th style="text-align:center;" class="dashboard-page-name"><dw:TranslateLabel ID="lbMobile" Text="Mobile" runat="server" /></th>
                                </tr>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td><%# Eval("IndexName")%></td>
                                <td style="text-align:center;"><b><%# Eval("EngagementValue")%></b></td>
                                <td style="text-align:center;"><%# Eval("EngagementValueDesktop")%></td>
                                <td style="text-align:center;"><%# Eval("EngagementValueTablet")%></td>
                                <td style="text-align:center;"><%# Eval("EngagementValueMobile")%></td>
                            </tr>
                        </ItemTemplate>
                        <AlternatingItemTemplate>
                            <tr class="dashboard-row-alternative">
                                <td><%# Eval("IndexName")%></td>
                                <td style="text-align:center;"><b><%# Eval("EngagementValue")%></b></td>
                                <td style="text-align:center;"><%# Eval("EngagementValueDesktop")%></td>
                                <td style="text-align:center;"><%# Eval("EngagementValueTablet")%></td>
                                <td style="text-align:center;"><%# Eval("EngagementValueMobile")%></td>
                            </tr>
                        </AlternatingItemTemplate>
                        <FooterTemplate>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </asp:Panel>
        </dw:RoundedFrame>
        </div>

            <div class="dashboard-right">
                <dw:RoundedFrame id="frmLinks" Width="350" Height="263" runat="server" >
                    <div class="dashboard-info">
                        <label>
                            <dw:RadioButton ID="rbUniqueLinks" runat="server" FieldName="MsgLinks" FieldValue="1" OnClientClick="showUniqueLinks();" />
                            <dw:TranslateLabel id="TranslateLabel9" Text="Unique clicks" runat="server" />
                        </label>
        
                        <label>
                            <dw:RadioButton ID="rbTotalLinks" runat="server" FieldName="MsgLinks" FieldValue="2" OnClientClick="showUniqueLinks();"/>
                            <dw:TranslateLabel id="TranslateLabel10" Text="Total clicks" runat="server" />
                        </label>
                        <br />

                        <div class="omc-control-panel-grid-container" style="border-style:None;width: 320px;" id="originalLinkDiv" runat="server">
                            <div id="UniqueLinksDiv" style="overflow: hidden;">
                                <dw:List runat="server" ID="uniqueLinksList" ShowHeader="false" ShowPaging="False" ShowTitle="false" PageSize="25">
                                    <Columns>
                                        <dw:ListColumn runat="server" ID="clmUniqueLinkUrl" WidthPercent="90" />
                                        <dw:ListColumn runat="server" ID="clmUniqueLinkClicks" WidthPercent="10" />
                                    </Columns>
                                </dw:List>
                            </div>
                            <div id="TotalLinksDiv" style="overflow: hidden;">
                                <dw:List runat="server" ID="totalLinksList" ShowHeader="false" ShowPaging="False" ShowTitle="false" PageSize="25">
                                    <Columns>
                                        <dw:ListColumn runat="server" ID="clmTotalLinkUrl" WidthPercent="90"/>
                                        <dw:ListColumn runat="server" ID="clmTotalLinkClicks" WidthPercent="10" />
                                    </Columns>
                                </dw:List>
                            </div>
                        </div>
                    </div>
                </dw:RoundedFrame> 
            </div>
        </div> 

        <div class="dashboard-clear"></div>
        <div class="dashboard-separator"></div>

        <div class="dashboard-split">
            <div class="statistics-left">
                <dw:RoundedFrame ID="frmRecipientsList" Width="990" Height="285" runat="server">
                    <div id="recipientListRadioDiv">
                        <asp:RadioButtonList runat="server" ID="rcpListRadioGroup" AutoPostBack="True" RepeatDirection="Horizontal">
                        </asp:RadioButtonList>
                    </div>
                    <div class="dashboard-info" id="RecipientsDiv" runat="server" >
                        <dw:List ID="lstRecipients" runat="server" ShowHeader="True" ShowPaging="True" ShowTitle="False" StretchContent="True" PageSize="250">
                            <Columns>
                                <dw:ListColumn ID="clmRecRecipient" TranslateName="True" Name="Recipient" runat="server" HeaderAlign="Left" ItemAlign="Left" Width="450" EnableSorting="True" />
                                <dw:ListColumn ID="clmRecOpened" TranslateName="True" Name="Opened" runat="server" HeaderAlign="Center" ItemAlign="Center" EnableSorting="True" />
                                <dw:ListColumn ID="clmRecClicked" TranslateName="True" Name="Clicked links" runat="server" HeaderAlign="Center" ItemAlign="Center" EnableSorting="True" />
                                <dw:ListColumn ID="clmRecCart" TranslateName="True" Name="Cart" runat="server" HeaderAlign="Center" ItemAlign="Center" EnableSorting="True" />
                                <dw:ListColumn ID="clmRecOrder" TranslateName="True" Name="Order value" runat="server" HeaderAlign="Center" ItemAlign="Center" EnableSorting="True" />
                                <dw:ListColumn ID="clmRecUnsub" TranslateName="True" Name="Unsubscribed" runat="server" HeaderAlign="Center" ItemAlign="Center" EnableSorting="True" />
                                <dw:ListColumn ID="clmRecIndex" TranslateName="True" Name="Engagement Index" runat="server" HeaderAlign="Center" ItemAlign="Center" EnableSorting="True" />
                            </Columns>
                        </dw:List>
                    </div>
                    <div class="dashboard-info" id="UnsubscribersDiv" runat="server">
                        <dw:List ID="lstUnsubscribers" runat="server" ShowHeader="True" ShowPaging="True" ShowTitle="False" StretchContent="True" PageSize="250">
                            <Columns>
                                <dw:ListColumn ID="clmRecRecipientUnsub" TranslateName="True" Name="Recipient" runat="server" HeaderAlign="Left" ItemAlign="Left" Width="450" EnableSorting="True" />
                                <dw:ListColumn ID="clmRecOpenedUnsub" TranslateName="True" Name="Opened" runat="server" HeaderAlign="Center" ItemAlign="Center" EnableSorting="True" />
                                <dw:ListColumn ID="clmRecClickedUnsub" TranslateName="True" Name="Clicked links" runat="server" HeaderAlign="Center" ItemAlign="Center" EnableSorting="True" />
                                <dw:ListColumn ID="clmRecCartUnsub" TranslateName="True" Name="Cart" runat="server" HeaderAlign="Center" ItemAlign="Center" EnableSorting="True" />
                                <dw:ListColumn ID="clmRecOrderUnsub" TranslateName="True" Name="Order value" runat="server" HeaderAlign="Center" ItemAlign="Center" EnableSorting="True" />
                                <dw:ListColumn ID="clmRecUnsubUnsub" TranslateName="True" Name="Unsubscribed" runat="server" HeaderAlign="Center" ItemAlign="Center" EnableSorting="True" />
                                <dw:ListColumn ID="clmRecIndexUnsub" TranslateName="True" Name="Engagement Index" runat="server" HeaderAlign="Center" ItemAlign="Center" EnableSorting="True" />
                            </Columns>
                        </dw:List>
                    </div>
                </dw:RoundedFrame>
            </div>


        </div>

        <div class="dashboard-clear"></div>
        <div class="dashboard-separator"></div>

        <div class="dashboard-split">
              <div class="dashboard-left" style="width: 550px;">
                <dw:RoundedFrame ID="frmEngagement" Width="550" Height="285" runat="server">
                    <asp:Panel ID="Panel3" runat="server">
                        <div class="dashboard-info">
                            <asp:Repeater ID="repEngagement" runat="server">
                                <HeaderTemplate>
                                    <table class="dashboard-most-visits" cellspacing="0" cellpadding="2" border="0">
                                        <tr>
                                            <th class="dashboard-page-name"><dw:TranslateLabel ID="TranslateLabel8" Text="Parameter" runat="server" /></th>
                                            <th class="dashboard-page-name"><dw:TranslateLabel ID="lbEI" Text="Engagement Index" runat="server" /></th>
                                            <th class="dashboard-page-name"><dw:TranslateLabel ID="TranslateLabel7" Text="Order value" runat="server" /></th>
                                        </tr>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td><%# Eval("IndexName")%></td>
                                        <td><%# Eval("EngagementValue")%></td>
                                        <td><%# Eval("OrderValue")%></td>
                                    </tr>
                                </ItemTemplate>
                                <AlternatingItemTemplate>
                                    <tr class="dashboard-row-alternative">
                                        <td><%# Eval("IndexName")%></td>
                                        <td><%# Eval("EngagementValue")%></td>
                                        <td><%# Eval("OrderValue")%></td>
                                    </tr>
                                </AlternatingItemTemplate>
                                <FooterTemplate>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                    </asp:Panel>
                </dw:RoundedFrame>
             </div>         
        </div>
        <div class="dashboard-clear"></div>
        <div class="dashboard-separator"></div>

        <div class="dashboard-split">
            <div class="dashboard-left" style="width: 220px;">
                <dw:RoundedFrame ID="frmPieOpenBrowsers" Width="220" Height="345" runat="server">
                    <dw:Chart ID="cPieOpenBrowsers" Type="Pie" Width="200" Height="130" Legend="none" AutoDraw="True" runat="server" />
                    <div class="dashboard-info" style="height: 55px !important;">
                        <h3 style="margin-top: 8px !important; margin-bottom: 2px !important;">
                            <dw:TranslateLabel ID="TranslateLabel22" Text="Legend" runat="server" />
                        </h3>
                        <ul class="statistics-legend" style="margin-top: 0px !important;">
                            <li style="float: none !important;">
                                <div class="statistics-legend-item" id="legendIE" runat="server" />
                                &nbsp;<dw:Label ID="TranslateLabel25" Title="Internet Explorer" runat="server" doTranslation="False" />
                            </li>
                            <li style="float: none !important;">
                                <div class="statistics-legend-item" id="legendChrome" runat="server" />
                                &nbsp;<dw:Label ID="TranslateLabel26" Title="Chrome" runat="server" doTranslation="False" />
                            </li>
                            <li style="float: none !important;">
                                <div class="statistics-legend-item" id="legendFF" runat="server" />
                                &nbsp;<dw:Label ID="TranslateLabel27" Title="FireFox" runat="server" doTranslation="False" />
                            </li>
                            <li style="float: none !important;">
                                <div class="statistics-legend-item" id="legendSafari" runat="server" />
                                &nbsp;<dw:Label ID="TranslateLabel28" Title="Safari" runat="server" doTranslation="False" />
                            </li>
                            <li style="float: none !important;">
                                <div class="statistics-legend-item" id="legendNA" runat="server" />
                                &nbsp;<dw:TranslateLabel ID="TranslateLabel29" Text="Other" runat="server" />
                            </li>
                        </ul>
                    </div>
                </dw:RoundedFrame>
            </div>

                <div class="dashboard-split">
                    <div class="dashboard-left" style="width: 220px;">
                        <dw:RoundedFrame ID="frmPieClickBrowsers" Width="220" Height="345" runat="server">
                            <dw:Chart ID="cPieClickBrowsers" Type="Pie" Width="200" Height="130" Legend="none" AutoDraw="True" runat="server" />
                            <div class="dashboard-info" style="height: 55px !important;">
                                <h3 style="margin-top: 8px !important; margin-bottom: 2px !important;">
                                    <dw:TranslateLabel ID="TranslateLabel1" Text="Legend" runat="server" />
                                </h3>
                                <ul class="statistics-legend" style="margin-top: 0px !important;">
                                    <li style="float: none !important;">
                                        <div class="statistics-legend-item" id="legendIE2" runat="server" />
                                        &nbsp;<dw:Label ID="Label1" Title="Internet Explorer" runat="server" doTranslation="False" />
                                    </li>
                                    <li style="float: none !important;">
                                        <div class="statistics-legend-item" id="legendChrome2" runat="server" />
                                        &nbsp;<dw:Label ID="Label2" Title="Chrome" runat="server" doTranslation="False" />
                                    </li>
                                    <li style="float: none !important;">
                                        <div class="statistics-legend-item" id="legendFF2" runat="server" />
                                        &nbsp;<dw:Label ID="Label3" Title="FireFox" runat="server" doTranslation="False" />
                                    </li>
                                    <li style="float: none !important;">
                                        <div class="statistics-legend-item" id="legendSafari2" runat="server" />
                                        &nbsp;<dw:Label ID="Label4" Title="Safari" runat="server" doTranslation="False" />
                                    </li>
                                    <li style="float: none !important;">
                                        <div class="statistics-legend-item" id="legendNA2" runat="server" />
                                        &nbsp;<dw:TranslateLabel ID="TranslateLabel31" Text="Other" runat="server" />
                                    </li>
                                </ul>
                            </div>
                        </dw:RoundedFrame>
                        </div>
                </div>

                    <div class="dashboard-middle" style="width: 220px;">
                        <dw:RoundedFrame ID="frmPieOpenEmailClient" Width="220" Height="345" runat="server">
                            <dw:Chart ID="cPieOpenEmailClient" Type="Pie" Width="200" Height="130" Legend="none" AutoDraw="True" runat="server" />
                            <div class="dashboard-info" style="height: 55px !important;">
                                <h3 style="margin-top: 8px !important; margin-bottom: 2px !important;">
                                    <dw:TranslateLabel ID="TranslateLabel23" Text="Legend" runat="server" />
                                </h3>
                                <dw:List ID="OpenEmailClientLegend" runat="server" ShowTitle="False" StretchContent="False"  PageSize="200" ShowHeader="False" ShowPaging="False" Height="200">
                                   <Columns>
                                        <dw:ListColumn ID="OpenClienrColor" runat="server" Name="Name" Width="10"></dw:ListColumn>
                                        <dw:ListColumn ID="OpenClientName" runat="server"  Name="Updated"
                                            ItemAlign="Center" HeaderAlign="Center" Width="20"></dw:ListColumn>
                                    </Columns>
                                </dw:List>
                            </div>
                        </dw:RoundedFrame>
                    </div>

                    <div class="dashboard-middle" style="width: 220px;">
                        <dw:RoundedFrame ID="frmPieClickEmailClient" Width="220" Height="345" runat="server">                            
                            <dw:Chart ID="cPieClickEmailClient" Type="Pie" Width="200" Height="130" Legend="none" AutoDraw="True" runat="server" />
                            <div class="dashboard-info" style="height: 55px !important;">
                               <h3 style="margin-top: 8px !important; margin-bottom: 2px !important;">
                                    <dw:TranslateLabel ID="TranslateLabel24" Text="Legend" runat="server" />
                               </h3>
                               <dw:List ID="ClickEmailClientLegend" runat="server" ShowTitle="False" StretchContent="False"  PageSize="200" ShowHeader="False" ShowPaging="False" Height="200">
                                   <Columns>
                                       <dw:ListColumn ID="ClickClienrColor" runat="server" Name="Name" Width="10"></dw:ListColumn>
                                       <dw:ListColumn ID="ClickClienrName" runat="server" Name="Updated"
                                           ItemAlign="Center" HeaderAlign="Center" Width="20"></dw:ListColumn>
                                   </Columns>
                               </dw:List>
                             </div>
                        </dw:RoundedFrame>
                    </div>
            
                    <div class="dashboard-right" style="width: 220px;">
                        <dw:RoundedFrame ID="frmPieOpenPlatforms" Width="220" Height="345" runat="server">
                            <dw:Chart ID="cPieOpenPlatforms" Type="Pie" Width="200" Height="130" Legend="none" AutoDraw="True" runat="server" />
                            <div class="dashboard-info" style="height: 55px !important;">
                                <h3 style="margin-top: 8px !important; margin-bottom: 2px !important;">
                                    <dw:TranslateLabel ID="TranslateLabel32" Text="Legend" runat="server" />
                                </h3>
                                <ul class="statistics-legend" style="margin-top: 0px !important;">
                                    <li style="float: none !important;">
                                        <div class="statistics-legend-item" id="legendWin" runat="server" />
                                        &nbsp;<dw:Label ID="TranslateLabel35" Title="Windows" runat="server" doTranslation="False" />
                                    </li>
                                    <li style="float: none !important;">
                                        <div class="statistics-legend-item" id="legendLinux" runat="server" />
                                        &nbsp;<dw:Label ID="TranslateLabel36" Title="Linux" runat="server" doTranslation="False" />
                                    </li>
                                    <li style="float: none !important;">
                                        <div class="statistics-legend-item" id="legendMac" runat="server" />
                                        &nbsp;<dw:Label ID="TranslateLabel37" Title="Mac" runat="server" doTranslation="False" />
                                    </li>
                                    <li style="float: none !important;">
                                        <div class="statistics-legend-item" id="legendOther" runat="server" />
                                        &nbsp;<dw:TranslateLabel ID="TranslateLabel38" Text="Other" runat="server" />
                                    </li>
                                </ul>
                            </div>
                        </dw:RoundedFrame>
                    </div>
                    <div class="dashboard-right" style="width: 220px;">
                        <dw:RoundedFrame ID="frmPieClickPlatforms" Width="220" Height="345" runat="server">
                            <dw:Chart ID="cPieClickPlatforms" Type="Pie" Width="200" Height="130" Legend="none" AutoDraw="True" runat="server" />
                            <div class="dashboard-info" style="height: 55px !important;">
                                <h3 style="margin-top: 8px !important; margin-bottom: 2px !important;">
                                    <dw:TranslateLabel ID="TranslateLabel61" Text="Legend" runat="server" />
                                </h3>
                                <ul class="statistics-legend" style="margin-top: 0px !important;">
                                    <li style="float: none !important;">
                                        <div class="statistics-legend-item" id="legendWin2" runat="server" />
                                        &nbsp;<dw:Label ID="Label5" Title="Windows" runat="server" doTranslation="False" />
                                    </li>
                                    <li style="float: none !important;">
                                        <div class="statistics-legend-item" id="legendLinux2" runat="server" />
                                        &nbsp;<dw:Label ID="Label6" Title="Linux" runat="server" doTranslation="False" />
                                    </li>
                                    <li style="float: none !important;">
                                        <div class="statistics-legend-item" id="legendMac2" runat="server" />
                                        &nbsp;<dw:Label ID="Label7" Title="Mac" runat="server" doTranslation="False" />
                                    </li>
                                    <li style="float: none !important;">
                                        <div class="statistics-legend-item" id="legendOther2" runat="server" />
                                        &nbsp;<dw:TranslateLabel ID="TranslateLabel111" Text="Other" runat="server" />
                                    </li>
                                </ul>
                            </div>
                        </dw:RoundedFrame>
                    </div>
         </div>
              
            
    </div>
        <div class="dashboard-clear"></div>
        <div class="dashboard-separator"></div>
    <dw:Dialog AllowDrag="False" IsModal="True" ShowOkButton="True" OkText="Close" Title="Export" UseTabularLayout="False" runat="server" ID="exportDialog" SnapToScreen="False" Width="500">
        <div class="Toolbar" style="height: 200px;">
            <ul style="background: none; border-bottom: none;">
                <li style="display: block; float: none;"><a class="toolbar-button" href="#" onclick="ExportStat('Highlights');">
                    <span class="toolbar-button-container">
                        <img style="vertical-align: middle;" src="/Admin/Images/Ribbon/Icons/Small/export1.png" alt="" />
                        <%=Backend.Translate.Translate("Highlights")%></span></a></li>
                <li style="display: block; float: none;"><a class="toolbar-button" href="#" onclick="ExportStat('Engagement');">
                    <span class="toolbar-button-container">
                        <img style="vertical-align: middle;" src="/Admin/Images/Ribbon/Icons/Small/export1.png" alt="" />
                        <%=Backend.Translate.Translate("Engagement")%></span></a></li>
                <li style="display: block; float: none;"><a class="toolbar-button" href="#" onclick="ExportStat('Recipents');">
                    <span class="toolbar-button-container">
                        <img style="vertical-align: middle;" src="/Admin/Images/Ribbon/Icons/Small/export1.png" alt="" />
                        <%=Backend.Translate.Translate("Recipents")%></span></a></li>
                <li style="display: block; float: none;"><a class="toolbar-button" href="#" onclick="ExportStat('Links');">
                    <span class="toolbar-button-container">
                        <img style="vertical-align: middle;" src="/Admin/Images/Ribbon/Icons/Small/export1.png" alt="" />
                        <%=Backend.Translate.Translate("Links")%></span></a></li>
                <li style="display: block; float: none;"><a class="toolbar-button" href="#" onclick="ExportStat('Browsers');">
                    <span class="toolbar-button-container">
                        <img style="vertical-align: middle;" src="/Admin/Images/Ribbon/Icons/Small/export1.png" alt="" />
                        <%=Backend.Translate.Translate("Browsers")%></span></a></li>
                <li style="display: block; float: none;"><a class="toolbar-button" href="#" onclick="ExportStat('Platforms');">
                    <span class="toolbar-button-container">
                        <img style="vertical-align: middle;" src="/Admin/Images/Ribbon/Icons/Small/export1.png" alt="" />
                        <%=Backend.Translate.Translate("Platforms")%></span></a></li>
                <li style="display: block; float: none;"><a class="toolbar-button" href="#" onclick="ExportStat('EmailClient');">
                    <span class="toolbar-button-container">
                        <img style="vertical-align: middle;" src="/Admin/Images/Ribbon/Icons/Small/export1.png" alt="" />
                        <%=Backend.Translate.Translate("Email Client")%></span></a></li>
                <li style="display: block; float: none;"><a class="toolbar-button" href="#" onclick="ExportStat('Responses');">
                    <span class="toolbar-button-container">
                        <img style="vertical-align: middle;" src="/Admin/Images/Ribbon/Icons/Small/export1.png" alt="" />
                        <%=Backend.Translate.Translate("Recipients responses")%></span></a></li>
                <li style="display: block; float: none;"><a class="toolbar-button" href="#" onclick="ExportStat('All');">
                    <span class="toolbar-button-container">
                        <img style="vertical-align: middle;" src="/Admin/Images/Ribbon/Icons/Small/export1.png" alt="" />
                        <%=Backend.Translate.Translate("All (zip folder)")%></span></a></li>
            </ul>
        </div>
    </dw:Dialog>

    <script type="text/javascript">
        document.observe("dom:loaded", function () {
            //setTimeout(function () { showUniqueLinks(); }, 200);
            showUniqueLinks();
        });
    </script>
</asp:Content>
