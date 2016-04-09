<%@ Page MasterPageFile="/Admin/Content/Management/EntryContent.Master" Language="vb" AutoEventWireup="false" CodeBehind="CustomizedURLs_cpl.aspx.vb" Inherits="Dynamicweb.Admin.CustomizedURLs_cpl" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<asp:Content ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        var page = SettingsPage.getInstance();

        page.onSave = function() {
            page.submit();
        }

        page.onHelp = function() {
            <%=Gui.help("", "managementcenter.web.searchfriendlyurls") %>
        }        

        function UrlPathChange(elm){
			document.getElementById("/Globalsettings/System/Url/UseAreaNameInPath").checked = false;
			document.getElementById("/Globalsettings/System/Url/UseAreaRegionalInPath").checked = false;
			document.getElementById("/Globalsettings/System/Url/NoAreaName").checked = false;
			elm.checked = true;
        }

		function showHidePathParameters(){
			if(document.getElementById("/Globalsettings/System/Url/TypePath").checked) {
                if (document.getElementById("convertModuleUrlsRow")) {
                    document.getElementById("convertModuleUrlsRow").style.display = "";
                }

				document.getElementById("UrlProvidersRow").style.display = "";
				document.getElementById("PathSettings").style.display = "";
				
			}else{
                if (document.getElementById("convertModuleUrlsRow")) {
                    document.getElementById("convertModuleUrlsRow").style.display = "none";
                }
				
				document.getElementById("UrlProvidersRow").style.display = "none";
				document.getElementById("PathSettings").style.display = "none";
			}
		}

		function showHideProviders(){
            if (document.getElementById("/Globalsettings/System/Url/ParseContentURLWithParams")) {
			    if (document.getElementById("/Globalsettings/System/Url/ParseContentURLWithParams").checked){
				    document.getElementById("UrlProvidersRow").style.display = "none";
				    document.getElementById("FolderedQueryStringSettings").style.display = "";
			    } else {
				    document.getElementById("UrlProvidersRow").style.display = "";
				    document.getElementById("FolderedQueryStringSettings").style.display = "none";
			    }
            }
		}
    </script>
</asp:Content>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <div id="PageContent">
        <table border="0" cellpadding="2" cellspacing="0" class="tabTable">
		
			<tr>
				<td valign="top">

					<%=(Gui.GroupBoxStart(Translate.Translate("Url")))%>
					<%
						Dim UrlType As String = Base.GetGs("/Globalsettings/System/Url/Type")
						If UrlType = "" Then
							UrlType = "None"
						End If
					%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170">
								<%=Translate.Translate("URL type")%></td>
							<td>
								<%=Gui.RadioButton(UrlType, "/Globalsettings/System/Url/Type", "None")%><label for="/Globalsettings/System/Url/TypeNone"><%=Translate.Translate("Kun standard")%>&nbsp;<code><%=Replace("(Default.aspx?ID=%i%)","%i%", "<i>" & Translate.Translate("Side-ID") & "</i>")%></code></label></td>
						</tr>
						<tr>
							<td></td>
							<td>
								<%=Gui.RadioButton(UrlType, "/Globalsettings/System/Url/Type", "PageID")%><label for="/Globalsettings/System/Url/TypePageID"><%=Translate.Translate("Tekst med side ID")%>&nbsp;<code><%=Replace(Replace("(/%t%-%i%.aspx)","%i%", "<i>" & Translate.Translate("Side-ID") & "</i>"),"%t%", "<i>" & Translate.Translate("Tekst") & "</i>")%></code></label><br />
								<img src="/Admin/Images/Nothing.gif" width="20" /><%=Translate.Translate("Tekst")%>:&nbsp;<input type="text" name="/Globalsettings/System/Url/TypePageID/Prefix" id="/Globalsettings/System/Url/TypePageID/Prefix" value="<%=Server.HtmlEncode(Base.GetGs("/Globalsettings/System/Url/TypePageID/Prefix"))%>" maxlength="25" style="width: 200px;" class="std"><br>
							</td>
						</tr>
						<tr>
							<td></td>
							<td>
								<%=Gui.RadioButton(UrlType, "/Globalsettings/System/Url/Type", "PagenameID")%><label for="/Globalsettings/System/Url/TypePagenameID"><%=Translate.Translate("Sidenavn og side ID")%>&nbsp;<code><%=Replace(Replace("(/%s%-%i%.aspx)","%i%", "<i>" & Translate.Translate("Side-ID") & "</i>"),"%s%", "<i>" & Translate.Translate("Sidenavn") & "</i>")%></code></label><br>
							</td>
						</tr>
						<tr>
							<td></td>
							<td>
								<%=Gui.RadioButton(UrlType, "/Globalsettings/System/Url/Type", "PagenameQS")%><label for="/Globalsettings/System/Url/TypePagenameQS" onmouseup="showHidePathParameters()"><%=Translate.Translate("Sidenavn med ID")%>&nbsp;<code><%=Replace(Replace("(/%s%.aspx?ID=%i%)","%i%", "<i>" & Translate.Translate("Side-ID") & "</i>"),"%s%", "<i>" & Translate.Translate("Sidenavn") & "</i>")%></code></label><br>
							</td>
						</tr>
						<tr>
							<td></td>
							<td>
								<%= Gui.RadioButton(UrlType, "/Globalsettings/System/Url/Type", "Path")%><label for="/Globalsettings/System/Url/TypePath" onmouseup="showHidePathParameters()"><%=Translate.Translate("Placering og sidenavn")%>&nbsp;<code><%=Replace(Replace("(/%p%/.../%s%.aspx)","%p%", "<i>" & Translate.Translate("Sti") & "</i>"),"%s%", "<i>" & Translate.Translate("Sidenavn") & "</i>")%></code></label><br>
								<div id="PathSettings">
									
									<img src="/Admin/Images/Nothing.gif" width="20" /><input type="checkbox" value="True"
										<%=IIf(Base.GetGs("/Globalsettings/System/Url/ExtensionLess") = "True", "checked=""checked""", "")%>
										id="/Globalsettings/System/Url/ExtensionLess" name="/Globalsettings/System/Url/ExtensionLess"
										<%=IIf(HttpRuntime.UsingIntegratedPipeline, "", "disabled=""disabled""")%> /><label
											for="/Globalsettings/System/Url/ExtensionLess" <%=IIf(HttpRuntime.UsingIntegratedPipeline, "", "disabled=""disabled""")%>><%=Translate.Translate("Use extension less URL's (Do not include .aspx)")%></label>
									<%=IIf(HttpRuntime.UsingIntegratedPipeline, "", "<br><img src=""/Admin/Images/Nothing.gif"" width=""20"" /><small>Requires that the application pool runs in integrated pipeline mode</small>")%>
									
										<br />
									
									<img src="/Admin/Images/Nothing.gif" width="20" /><input type="checkbox" value="True"
										<%=IIf(Base.GetGs("/Globalsettings/System/Url/PlaceAllPagesInRoot") = "True", "checked=""checked""", "")%>
										id="/Globalsettings/System/Url/PlaceAllPagesInRoot" name="/Globalsettings/System/Url/PlaceAllPagesInRoot" /><label for="/Globalsettings/System/Url/PlaceAllPagesInRoot"><%=Translate.Translate("Place all pages in root.")%></label>
									<br />
								<img src="/Admin/Images/Nothing.gif" width="20" /><b><%=Translate.Translate("Sproglag")%></b><br />
								
								<%
									Dim UrlInlcudeAreaType As String = Base.GetGs("/Globalsettings/System/Url/UrlInlcudeAreaType")
									If Base.GetGs("/Globalsettings/System/Url/UseAreaNameInPath") = "True" And Base.GetGs("/Globalsettings/System/Url/UseAreaRegionalInPath") <> "True" Then
										UrlInlcudeAreaType = "UseAreaNameInPath"
									End If
									If Base.GetGs("/Globalsettings/System/Url/UseAreaRegionalInPath") = "True" Then
										UrlInlcudeAreaType = "UseAreaRegionalInPath"
									End If
									If UrlInlcudeAreaType = "" Then
										UrlInlcudeAreaType = "NoAreaName"
									End If
								%>
								<img src="/Admin/Images/Nothing.gif" width="20" /><span onclick="UrlPathChange(document.getElementById('/Globalsettings/System/Url/NoAreaName'));"><%=Gui.RadioButton(UrlInlcudeAreaType, "/Globalsettings/System/Url/UrlInlcudeAreaType", "NoAreaName")%><label for="/Globalsettings/System/Url/UrlInlcudeAreaTypeNoAreaName"><%=Translate.Translate("Vis ikke")%></label></span><br>
								<img src="/Admin/Images/Nothing.gif" width="20" /><span onclick="UrlPathChange(document.getElementById('/Globalsettings/System/Url/UseAreaNameInPath'));"><%=Gui.RadioButton(UrlInlcudeAreaType, "/Globalsettings/System/Url/UrlInlcudeAreaType", "UseAreaNameInPath")%><label for="/Globalsettings/System/Url/UrlInlcudeAreaTypeUseAreaNameInPath"><%=Translate.Translate("Start med sproglagets navn")%></label></span><br>
								<img src="/Admin/Images/Nothing.gif" width="20" /><span onclick="UrlPathChange(document.getElementById('/Globalsettings/System/Url/UseAreaRegionalInPath'));"><%=Gui.RadioButton(UrlInlcudeAreaType, "/Globalsettings/System/Url/UrlInlcudeAreaType", "UseAreaRegionalInPath")%><label for="/Globalsettings/System/Url/UrlInlcudeAreaTypeUseAreaRegionalInPath"><%=Translate.Translate("Use ISO code from regional settings (i.e. en-GB)")%></label></span><br>
								
								<span style="display:none;">
								<img src="/Admin/Images/Nothing.gif" width="20" /><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/NoAreaName") = "True", "checked=""checked""", "")%> id="/Globalsettings/System/Url/NoAreaName" name="/Globalsettings/System/Url/NoAreaName" onclick="UrlPathChange(this);" /><label for="/Globalsettings/System/Url/NoAreaName"><%=Translate.Translate("Vis ikke")%></label><br />
								<img src="/Admin/Images/Nothing.gif" width="20" /><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/UseAreaNameInPath") = "True" And Base.GetGs("/Globalsettings/System/Url/UseAreaRegionalInPath") <> "True" And Base.GetGs("/Globalsettings/System/Url/NoAreaName") <> "True", "checked=""checked""", "")%> id="/Globalsettings/System/Url/UseAreaNameInPath" name="/Globalsettings/System/Url/UseAreaNameInPath" onclick="UrlPathChange(this);" /><label for="/Globalsettings/System/Url/UseAreaNameInPath"><%=Translate.Translate("Start med sproglagets navn")%></label><br />
								<img src="/Admin/Images/Nothing.gif" width="20" /><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/UseAreaRegionalInPath") = "True" And Base.GetGs("/Globalsettings/System/Url/NoAreaName") <> "True", "checked=""checked""", "")%> id="/Globalsettings/System/Url/UseAreaRegionalInPath" name="/Globalsettings/System/Url/UseAreaRegionalInPath" onclick="UrlPathChange(this);" /><label for="/Globalsettings/System/Url/UseAreaRegionalInPath"><%=Translate.Translate("Use ISO code from regional settings (i.e. en-GB)")%></label><br />
								</span>
								<img src="/Admin/Images/Nothing.gif" width="20" /><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/UniqueForEachLanguage") = "True", "checked=""checked""", "")%> id="/Globalsettings/System/Url/UniqueForEachLanguage" name="/Globalsettings/System/Url/UniqueForEachLanguage" />
									<label for="/Globalsettings/System/Url/UniqueForEachLanguage"><%=Translate.Translate("Ensure unique paths for each area (Requires unique domain for each area) (WARNING: This can break links on your website.)").Replace("(", "<br><small style=""margin-left:40px;"">(").Replace(")", "</small>")%>
									</label><br />
									<img src="/Admin/Images/Nothing.gif" width="40" height="20" /><input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/UniqueForEachMasterWebsite") = "True", "checked=""checked""", "")%> id="/Globalsettings/System/Url/UniqueForEachMasterWebsite" name="/Globalsettings/System/Url/UniqueForEachMasterWebsite" />
									<label for="/Globalsettings/System/Url/UniqueForEachMasterWebsite"><%=Translate.Translate("Group by master website")%></label>
								</div>
							</td>
						</tr>
						<tr>
						<td>&nbsp;</td>
						</tr>
						
					</table>
					<%=Gui.GroupBoxEnd()%>

                    <dw:GroupBox ID="GroupBox3" runat="server" Title="Add ins" DoTranslation="true">
                        <table border="0" cellpadding="2" cellspacing="0">
                            <tr id="UrlProvidersRow">
							<td width="170" valign="top"><%=Translate.Translate("Add ins")%></td>
							<td id="UrlProviders" runat="server">
								
							</td>
						</tr>
                            </table>
                        </dw:GroupBox>

					<dw:GroupBox ID="GroupBox1" runat="server" Title="Indstillinger" DoTranslation="true">
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170"><%=Translate.Translate("Interne links")%></td>
							<td>
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/ParseContentURL") = "True", "checked", "")%> id="/Globalsettings/System/Url/ParseContentURL" name="/Globalsettings/System/Url/ParseContentURL"><label for="/Globalsettings/System/Url/ParseContentURL"><%=Translate.Translate("Brug brugerdefinerede URLer")%></label></td>
						</tr>
						
						<%	If Base.GetGs("/Globalsettings/System/Url/ParseContentURLWithParams") = "True" Then%>
						<tr id="convertModuleUrlsRow">
							<td width="170"></td>
							<td>
							<%
								If String.IsNullOrEmpty(Base.GetGs("/Globalsettings/System/Url/ParseContentURLWithParamsMethod")) Then
									Base.SetGs("/Globalsettings/System/Url/ParseContentURLWithParamsMethod", "Slashes")
								End If
								%>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/ParseContentURLWithParams") = "True", "checked", "")%> id="/Globalsettings/System/Url/ParseContentURLWithParams" name="/Globalsettings/System/Url/ParseContentURLWithParams" onclick="showHideProviders();" /><label for="/Globalsettings/System/Url/ParseContentURLWithParams"><%=Translate.Translate("Convert module URL's")%></label><br />
								<div id="FolderedQueryStringSettings">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b><%=Translate.Translate("Formatering")%></b><br />
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=Gui.RadioButton(Base.GetGs("/Globalsettings/System/Url/ParseContentURLWithParamsMethod"), "/Globalsettings/System/Url/ParseContentURLWithParamsMethod", "Slashes")%><label for="/Globalsettings/System/Url/ParseContentURLWithParamsMethodSlashes"><%=Translate.Translate("Foldered querystring")%></label><br />
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=Gui.RadioButton(Base.GetGs("/Globalsettings/System/Url/ParseContentURLWithParamsMethod"), "/Globalsettings/System/Url/ParseContentURLWithParamsMethod", "Encryption")%><label for="/Globalsettings/System/Url/ParseContentURLWithParamsMethodEncryption"><%=Translate.Translate("Encryption")%></label>
								<br />
								</div>
								<br />
								</td>
						</tr>
						<%End If %>
						
						<tr>
							<td valign="top">
								<%=Translate.Translate("Formatering")%></td>
							<td>
                                   <input type="checkbox" value="True" id="/Globalsettings/System/Url/CaseInsensitive" <%=IIf(Base.GetGs("/Globalsettings/System/Url/CaseInsensitive") = "True", "checked", "")%>="" name="/Globalsettings/System/Url/CaseInsensitive"> <label for="/Globalsettings/System/Url/CaseInsensitive"><%=Translate.Translate("Case insensitive URLs")%></label> (<%=Translate.Translate("Lower case")%>)<br />
								<%
									'Changed by NP 27/4-2006
									Dim TrimSpaces As String = Base.GetGs("/Globalsettings/System/Url/TrimSpaces")
									If TrimSpaces = "" Or TrimSpaces = "False" Then
										TrimSpaces = "KeepSpaces"
									End If
									If TrimSpaces = "True" Then
										TrimSpaces = "Underscore"
									End If
									
									If TrimSpaces <> "KeepSpaces" And TrimSpaces <> "Underscore" And TrimSpaces <> "Hyphen" Then
										TrimSpaces = "KeepSpaces"
									End If
								%>
								<%=Gui.RadioButton(TrimSpaces, "/Globalsettings/System/Url/TrimSpaces", "KeepSpaces")%><label for="/Globalsettings/System/Url/TrimSpacesKeepSpaces"><%=Translate.Translate("Ingen")%></label><br />
								<%=Gui.RadioButton(TrimSpaces, "/Globalsettings/System/Url/TrimSpaces", "Hyphen")%><label for="/Globalsettings/System/Url/TrimSpacesHyphen"><%=Translate.Translate("Erstat [Space] med [dash]")%></label><br />
								<%=Gui.RadioButton(TrimSpaces, "/Globalsettings/System/Url/TrimSpaces", "Underscore")%><label for="/Globalsettings/System/Url/TrimSpacesUnderscore"><%=Translate.Translate("Erstat [Space] med [underscore]")%></label><br />
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/ReplaceSlash") = "True", "checked", "")%> id="/Globalsettings/System/Url/ReplaceSlash" name="/Globalsettings/System/Url/ReplaceSlash" /><label for="/Globalsettings/System/Url/ReplaceSlash"><%= Translate.Translate("Replace [slash] with [dash] ")%>(/ -> -)</label><br />
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/LatinNormalize") = "True", "checked", "")%> id="/Globalsettings/System/Url/LatinNormalize" name="/Globalsettings/System/Url/LatinNormalize" /><label for="/Globalsettings/System/Url/LatinNormalize"><%= Translate.Translate("Normalize latin characters")%> (ø->oe, é->e etc.)</label><br />
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/AmpEncode") = "True", "checked", "")%> id="/Globalsettings/System/Url/AmpEncode" name="/Globalsettings/System/Url/AmpEncode" /><label for="/Globalsettings/System/Url/AmpEncode"><%=Translate.Translate("Encode ampersand(&) in all links")%></label><br />
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/QueryStringToUnicode") = "True", "checked", "")%> id="/Globalsettings/System/Url/QueryStringToUnicode" name="/Globalsettings/System/Url/QueryStringToUnicode" /><label for="/Globalsettings/System/Url/QueryStringToUnicode"><%=Translate.Translate("Convert QueryString parameters to Unicode")%></label><br />
							</td>
						</tr>
						<tr>
							<td width="170"><%=Translate.Translate("Ensure unique path")%></td>
							<td>
								<input id="/Globalsettings/System/Url/EnsureUniquePath" <%=IIf(Base.GetGs("/Globalsettings/System/Url/EnsureUniquePath") = "True", "checked", "")%>="" name="/Globalsettings/System/Url/EnsureUniquePath" type="checkbox" value="True"><label for="/Globalsettings/System/Url/EnsureUniquePath"><%=Translate.Translate("Vidersend til link (301 Moved Permanently)")%></label></td>
						</tr>
						<tr>
							<td width="170"><%=Translate.Translate("Rebuild")%></td>
							<td>
								<input id="/Globalsettings/System/Url/BuildUrlsOnApplicationStart" <%=IIf(Base.GetGs("/Globalsettings/System/Url/BuildUrlsOnApplicationStart") = "True", "checked", "")%>="" name="/Globalsettings/System/Url/BuildUrlsOnApplicationStart" type="checkbox" value="True"><label for="/Globalsettings/System/Url/BuildUrlsOnApplicationStart"><%=Translate.Translate("Rebuild URLs on application start only")%></label></td>
						</tr>
					</table>
					</dw:GroupBox>
                    
                    <dw:GroupBox ID="GroupBox2" runat="server" Title="eCommerce" DoTranslation="true">
                        <table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170"></td>
							<td>
								<input type="checkbox" style="float:left" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/UseStrictURLRecognition") = "True", "checked", "")%> id="/Globalsettings/System/Url/UseStrictURLRecognition" name="/Globalsettings/System/Url/UseStrictURLRecognition">
                                    <div style="float:left">
                                        <label for="/Globalsettings/System/Url/UseStrictURLRecognition"><%=Translate.Translate("Use strict URL recognition")%></label>
                                        <br />
                                        <small><%=Translate.Translate("Always return 404 if path is not correct")%></small>
                                    </div>
                                <div style="float:left;">
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/UseCanonicalInEcommerce") = "True", "checked", "")%> id="/Globalsettings/System/Url/UseCanonicalInEcommerce" name="/Globalsettings/System/Url/UseCanonicalInEcommerce" /><label for="/Globalsettings/System/Url/UseCanonicalInEcommerce"><%= Translate.Translate("Canoncial link in meta")%></label><br />
                                <input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/Page404ForProductsNotInWebsiteShop") = "True", "checked", "")%> id="/Globalsettings/System/Url/Page404ForProductsNotInWebsiteShop" name="/Globalsettings/System/Url/Page404ForProductsNotInWebsiteShop" /><label for="/Globalsettings/System/Url/Page404ForProductsNotInWebsiteShop"><%= Translate.Translate("404 for products not in website shop")%></label><br />
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/Page404ForProductsNotInWebsiteLang") = "True", "checked", "")%> id="/Globalsettings/System/Url/Page404ForProductsNotInWebsiteLang" name="/Globalsettings/System/Url/Page404ForProductsNotInWebsiteLang" /><label for="/Globalsettings/System/Url/Page404ForProductsNotInWebsiteLang"><%=Translate.Translate("404 for products not in website language")%></label><br />
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/IncludeProductIdInUrlNames") = "True", "checked", "")%> id="/Globalsettings/System/Url/IncludeProductIdInUrlNames" name="/Globalsettings/System/Url/IncludeProductIdInUrlNames" /><label for="/Globalsettings/System/Url/IncludeProductIdInUrlNames"><%=Translate.Translate("Include product id in product url")%></label><br />
                                </div>
                                </td>
						</tr>

                        </table>
                    </dw:GroupBox>

					<%=(Gui.GroupBoxStart(Translate.Translate("Meta")))%>
					<table border="0" cellpadding="2" cellspacing="0">
						<tr>
							<td width="170"></td>
							<td>
								<input type="checkbox" value="True" <%=IIf(Base.GetGs("/Globalsettings/System/Url/DisableRobotsOnDwUrl") = "True", "checked", "")%> id="/Globalsettings/System/Url/DisableRobotsOnDwUrl" name="/Globalsettings/System/Url/DisableRobotsOnDwUrl"><label for="/Globalsettings/System/Url/DisableRobotsOnDwUrl"><%=Translate.Translate("Brug noindex,nofollow ved *.dynamicweb.* url'er")%></label></td>
						</tr>
						
						<tr>
							<td width="170"></td>
							<td>
								<input id="/Globalsettings/System/Url/UseCanoncial" <%=IIf(Base.GetGs("/Globalsettings/System/Url/UseCanoncial") = "True", "checked", "")%>="" name="/Globalsettings/System/Url/UseCanoncial" type="checkbox" value="True"><label for="/Globalsettings/System/Url/UseCanoncial"><%=Translate.Translate("Canoncial link in meta")%></label></td>
						</tr>
					</table>
					<%=Gui.GroupBoxEnd()%>
				</td>
				<tr>
		</form>
	</table>

	<script type="text/javascript">
	    var objForm = document.getElementById('MainForm');
	    var objFormElement = objForm.elements["/Globalsettings/System/Url/TypePageID/Prefix"]
	    if (objFormElement) {
	        if (objFormElement.value == "") {
	            objFormElement.value = "Page";
	        }
	          }
	          showHideProviders();
	          showHidePathParameters();

	          document.getElementById("/Globalsettings/System/Url/TypeNone").onclick = function () { showHidePathParameters() };
	          document.getElementById("/Globalsettings/System/Url/TypePageID").onclick = function () { showHidePathParameters() };
	          document.getElementById("/Globalsettings/System/Url/TypePagenameID").onclick = function () { showHidePathParameters() };
	          document.getElementById("/Globalsettings/System/Url/TypePagenameQS").onclick = function () { showHidePathParameters() };
	          document.getElementById("/Globalsettings/System/Url/TypePath").onclick = function () { showHidePathParameters() };
	          
	</script>
	
	<%
		Translate.GetEditOnlineScript()
	%>
	
    </div>
</asp:Content>
