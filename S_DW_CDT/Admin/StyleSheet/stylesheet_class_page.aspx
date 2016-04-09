<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<table class="tabTable" style="width: 100%;" id="Table6">
    <tr>
        <td>
            <input type="HIDDEN" name="StylesheetClassSettings" value="ParagraphTemplateID, PageAltStylesheet, PageAltJavascript, PageAltBodyOnload, DWDropdown_Level, PagePrintthis, PagePrintthisPDF, TreePrintthis, TreePrintthisPDF, PageInsertBreaks, PageLegend, PageFavorites, PageAlignment, PageLeftMargin, PageRightMargin, PageMenuWidth, PageColumnWidth, PageColumnSpace, PageTemplate, PageScrollContent, PageDropdownLayout, PageBackgroundImage, PageBackgroundImageFix, PageBackgroundImageRepeatHorisontal, PageBackgroundImageRepeatVertical, PageBackgroundColor, PageLogoImage, PageLogoImageAlignment, PageLogoImageLink, PageLogoImageAlt, PageTopImage, PageTopImageAlignment, PageTopImageLink, PageTopImageAlt, PageMenuLogoImage, PageMenuLogoImageAlignment, PageMenuLogoImageLink, PageMenuLogoImageAlt, PageFooterImage, PageFooterText, PageFooterAlignment, PageFooterImageLink, PageAlternativeStylesheet, PagePDAAlternativeStylesheet, PagePDAAlternativeArea">
            <div id="Tab1" style="display: ">
                <table width="100%" height="280" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <br>
                            <%=Gui.GroupBoxStart(Translate.Translate("Justering"))%>
                            <table>
                                <tr>
                                    <td width="170">
                                        <%=Translate.Translate("Justering")%>
                                    </td>
                                    <td>
                                        <%=Gui.AlignmentList(objProp.Value("PageAlignment"), "PageAlignment")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Menubredde")%>
                                    </td>
                                    <td>
                                        <input type="TEXT" onblur="ValidateInt(this);" onkeyup="calcSize();" name="PageMenuWidth"
                                            value="<%=objProp.Value("PageMenuWidth")%>" class="std" style="width: 30px"
                                            maxlength="3">
                                        px</td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Venstremargin")%>
                                    </td>
                                    <td>
                                        <input type="TEXT" onblur="ValidateInt(this);" onkeyup="calcSize();" name="PageLeftMargin"
                                            value="<%=objProp.Value("PageLeftMargin")%>" class="std" style="width: 30px"
                                            maxlength="3">
                                        px</td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Kolonnebredde")%>
                                    </td>
                                    <td>
                                        <input type="TEXT" onblur="ValidateInt(this);" onkeyup="calcSize();" name="PageColumnWidth"
                                            value="<%=objProp.Value("PageColumnWidth")%>" class="std" style="width: 30px"
                                            maxlength="3">
                                        px</td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Mellemrum mellem kolonner")%>
                                    </td>
                                    <td>
                                        <input type="TEXT" onblur="ValidateInt(this);" onkeyup="calcSize();" name="PageColumnSpace"
                                            value="<%=objProp.Value("PageColumnSpace")%>" class="std" style="width: 30px"
                                            maxlength="3">
                                        px</td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Højremargin")%>
                                    </td>
                                    <td>
                                        <input type="TEXT" onblur="ValidateInt(this);" onkeyup="calcSize();" name="PageRightMargin"
                                            value="<%=objProp.Value("PageRightMargin")%>" class="std" style="width: 30px"
                                            maxlength="3">
                                        px</td>
                                </tr>
                                <%	
					                Dim PageWidth as integer = 0
					                PageWidth += Base.ChkNumber(objProp.Value("PageMenuWidth"))
					                PageWidth += Base.ChkNumber(objProp.Value("PageLeftMargin"))
					                PageWidth += (Base.ChkNumber(objProp.Value("PageColumnWidth")) * 6)
					                PageWidth += (Base.ChkNumber(objProp.Value("PageColumnSpace")) * 5)
					                PageWidth += Base.ChkNumber(objProp.Value("PageRightMargin"))
                                %>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Sidebredde")%>
                                    </td>
                                    <td>
                                        <span id="pagewidth" style="width: 30px">
                                            <%=PageWidth%>
                                        </span>px</td>
                                </tr>
                            </table>
                            <%=Gui.GroupBoxEnd%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%=Gui.GroupBoxStart(Translate.Translate("Baggrund"))%>
                            <table>
                                <tr>
                                    <td width="170">
                                        <%=Translate.Translate("Baggrundsbillede")%>
                                    </td>
                                    <td>
                                        <%=Gui.FileManager(objProp.Value("PageBackgroundImage"), "System", "PageBackgroundImage")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Fix (IE)")%>
                                    </td>
                                    <td>
                                        <%=Gui.CheckBox(objProp.Value("PageBackgroundImageFix"), "PageBackgroundImageFix")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Gentag Horisontalt")%>
                                    </td>
                                    <td>
                                        <%=Gui.CheckBox(objProp.Value("PageBackgroundImageRepeatHorisontal"), "PageBackgroundImageRepeatHorisontal")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Gentag Vertikalt")%>
                                    </td>
                                    <td>
                                        <%=Gui.CheckBox(objProp.Value("PageBackgroundImageRepeatVertical"), "PageBackgroundImageRepeatVertical")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Baggrundsfarve")%>
                                    </td>
                                    <td>
                                        <%=Gui.ColorSelect(objProp.Value("PageBackgroundColor"), "PageBackgroundColor")%>
                                        <%	
					                        'Enable this to get the background color in the css file.
					                       If Base.GetGs("/Globalsettings/Modules/Stylesheet/BackgroundColor") = "True" Then
					                    %>
						                <%=StyleSheet.CSSTag("PageBackgroundColor", "background-color") %>
					                    <% End If%>
                                        
                                    </td>
                                </tr>
                            </table>
                            <%=Gui.GroupBoxEnd%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%=Gui.GroupBoxStart(Translate.Translate("Logo"))%>
                            <table>
                                <tr>
                                    <td width="170">
                                        <%=Translate.Translate("Billede")%>
                                    </td>
                                    <td>
                                        <%=Gui.FileManager(objProp.Value("PageLogoImage"), "System", "PageLogoImage")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Justering")%>
                                    </td>
                                    <td>
                                        <%=Gui.AlignmentList(objProp.Value("PageLogoImageAlignment"), "PageLogoImageAlignment")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Link")%>
                                    </td>
                                    <td>
                                        <%=Gui.LinkManager(objProp.Value("PageLogoImageLink"), "PageLogoImageLink", "")%>
                                    </td>
                                </tr>
                                <%	If Base.HasVersion("18.5.1.0") Then%>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Alt-tekst")%>
                                    </td>
                                    <td>
                                        <input type="TEXT" name="PageLogoImageAlt" value="<%=HtmlEncode(objProp.Value("PageLogoImageAlt"))%>"
                                            maxlength="255" class="std"></td>
                                </tr>
                                <%	End If%>
                            </table>
                            <%=Gui.GroupBoxEnd%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%=Gui.GroupBoxStart(Translate.Translate("Topgrafik"))%>
                            <table>
                                <tr>
                                    <td width="170">
                                        <%=Translate.Translate("Billede")%>
                                    </td>
                                    <td>
                                        <%=Gui.FileManager(objProp.Value("PageTopImage"), "System", "PageTopImage")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Justering")%>
                                    </td>
                                    <td>
                                        <%=Gui.AlignmentList(objProp.Value("PageTopImageAlignment"), "PageTopImageAlignment")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Link")%>
                                    </td>
                                    <td>
                                        <%=Gui.LinkManager(objProp.Value("PageTopImageLink"), "PageTopImageLink", "")%>
                                    </td>
                                </tr>
                                <%	If Base.HasVersion("18.5.1.0") Then%>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Alt-tekst")%>
                                    </td>
                                    <td>
                                        <input type="TEXT" name="PageTopImageAlt" value="<%=HtmlEncode(objProp.Value("PageTopImageAlt"))%>"
                                            maxlength="255" class="std"></td>
                                </tr>
                                <%	End If%>
                            </table>
                            <%=Gui.GroupBoxEnd%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%=Gui.GroupBoxStart(Translate.Translate("Menulogo"))%>
                            <table>
                                <tr>
                                    <td width="170">
                                        <%=Translate.Translate("Billede")%>
                                    </td>
                                    <td>
                                        <%=Gui.FileManager(objProp.Value("PageMenuLogoImage"), "System", "PageMenuLogoImage")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Justering")%>
                                    </td>
                                    <td>
                                        <%=Gui.AlignmentList(objProp.Value("PageMenuLogoImageAlignment"), "PageMenuLogoImageAlignment")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Link")%>
                                    </td>
                                    <td>
                                        <%=Gui.LinkManager(objProp.Value("PageMenuLogoImageLink"), "PageMenuLogoImageLink", "")%>
                                    </td>
                                </tr>
                                <%	If Base.HasVersion("18.5.1.0") Then%>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Alt-tekst")%>
                                    </td>
                                    <td>
                                        <input type="TEXT" name="PageMenuLogoImageAlt" value="<%=HtmlEncode(objProp.Value("PageMenuLogoImageAlt"))%>"
                                            maxlength="255" class="std"></td>
                                </tr>
                                <%	End If%>
                            </table>
                            <%=Gui.GroupBoxEnd%>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="Tab2" style="display: none">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" id="Table1">
                    <tr>
                        <td valign="top">
                            <br>
                            <%=Gui.GroupBoxStart(Translate.Translate("Template"))%>
                            <table>
                                <tr>
                                    <td width="170">
                                        <%=Translate.Translate("Template")%>
                                    </td>
                                    <td>
                                        <%=StyleSheet.PageTemplates(Base.ChkNumber(objProp.Value("PageTemplate")), "PageTemplate", 1)%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Scroll Indhold")%>
                                    </td>
                                    <td>
                                        <%=Gui.CheckBox(objProp.Value("PageScrollContent"), "PageScrollContent")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Dropdown layout")%>
                                    </td>
                                    <td>
                                        <%=StyleSheet.ListDropdownLayout(objProp.Value("PageDropdownLayout"), "PageDropdownLayout")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Dropdown niveau")%>
                                    </td>
                                    <%
				                        Dim DWDropdown_Level as string  'Tody hvad med DWDropdown_Level
				                        If objProp.Value("DWDropdown_Level") <> "" Then
					                        DWDropdown_Level = objProp.Value("DWDropdown_Level")
				                        Else
					                        DWDropdown_Level = 2
				                        End If
				                    %>
                                    <td>
                                        <select id="DWDropdown_Level" name="DWDropdown_Level" class="std">
                                            <option value="1" <%	If DWDropdown_Level = 1 Then Response.Write("SELECTED")%>>1</option>
                                            <option value="2" <%	If DWDropdown_Level = 2 Then Response.Write("SELECTED")%>>2</option>
                                            <option value="3" <%	If DWDropdown_Level = 3 Then Response.Write("SELECTED")%>>3</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                            <%=Gui.GroupBoxEnd%>
                            <%=Gui.GroupBoxStart(Translate.Translate("Medtag"))%>
                            <table>
                                <tr>
                                    <td width="170">
                                        <%=Translate.Translate("Stylesheet")%>
                                    </td>
                                    <td>
                                        <%=Gui.FileManager(objProp.Value("PageAltStylesheet"), "System", "PageAltStylesheet", "css")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("JavaScript")%>
                                    </td>
                                    <td>
                                        <%=Gui.FileManager(objProp.Value("PageAltJavascript"), "System", "PageAltJavascript", "js")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Body onLoad")%>
                                    </td>
                                    <td>
                                        <input type="TEXT" name="PageAltBodyOnload" value="<%=HtmlEncode(objProp.Value("PageAltBodyOnload"))%>"
                                            maxlength="255" class="std"></td>
                                </tr>
                            </table>
                            <%=Gui.GroupBoxEnd%>
                             <%=Gui.GroupBoxStart(Translate.Translate("Default paragraph template"))%>
                            <table>
                                <tr>
                                    <td width="170">
                                        &nbsp;
                                    </td>
                                       <% if not Dynamicweb.Modules.Common.CommonMethods.IsTemplateExists(objProp.Value("ParagraphTemplateID"))%>
                                       <% objProp.Value("ParagraphTemplateID") = 0%>
                                       <% end if%>
                                       <%=Gui.TemplatePreview(objProp.Value("ParagraphTemplateID"), "paragraph")%>
                                </tr>
                            </table>
                            <%=Gui.GroupBoxEnd%>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="Tab3" style="display: none">
                <table width="100%" height="280" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td valign="top">
                            <br>
                            <%=Gui.GroupBoxStart(Translate.Translate("Sidefod"))%>
                            <table>
                                <tr>
                                    <td width="170">
                                        <%=Translate.Translate("Billede")%>
                                    </td>
                                    <td>
                                        <%=Gui.FileManager(objProp.Value("PageFooterImage"), "System", "PageFooterImage")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Link")%>
                                    </td>
                                    <td>
                                        <%=Gui.LinkManager(objProp.Value("PageFooterImageLink"), "PageFooterImageLink", "")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="TOP">
                                        <%=Translate.Translate("Tekst")%>
                                    </td>
                                    <td>
                                        <textarea class="std" style="width: 300px" name="PageFooterText" rows="5" cols="50"><%=objProp.Value("PageFooterText")%></textarea></td>
                                </tr>
                                <tr>
                                    <td>
                                        <%=Translate.Translate("Justering")%>
                                    </td>
                                    <td>
                                        <%=Gui.AlignmentList(objProp.Value("PageFooterAlignment"), "PageFooterAlignment")%>
                                    </td>
                                </tr>
                            </table>
                            <%=Gui.GroupBoxEnd%>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="Tab4" style="display: none">
                <table width="100%" height="280" border="0" cellpadding="0" cellspacing="0" id="Table5">
                    <%	If Base.HasVersion("18.1.1.0") Then%>
                    <tr>
                        <td valign="top">
                            <br>
                            <%=Gui.GroupBoxStart(Translate.Translate("Brødkrummesti"))%>
                            <table id="Breadcrumb">
                                <tr>
                                    <td width="170">
                                        <%=Translate.Translate("Brødkrummesti")%>
                                    </td>
                                    <td>
                                        <%=StyleSheet.ListLegends(objProp.Value("PageLegend"), "PageLegend")%>
                                    </td>
                                </tr>
                            </table>
                            <%=Gui.GroupBoxEnd%>
                        </td>
                    </tr>
                    <%	If Base.HasAccess("Personalize", "") Then%>
                    <tr>
                        <td valign="top">
                            <%=Gui.GroupBoxStart(Translate.Translate("Mine favoritter"))%>
                            <table id="Favorites">
                                <tr>
                                    <td width="170">
                                        <%=Translate.Translate("Mine favoritter")%>
                                    </td>
                                    <td>
                                        <%=StyleSheet.ListFavorites(objProp.Value("PageFavorites"), "PageFavorites")%>
                                    </td>
                                </tr>
                            </table>
                            <%=Gui.GroupBoxEnd%>
                        </td>
                    </tr>
                    <%End If%>
                    <tr>
                        <td valign="top">
                            <%=Gui.GroupBoxStart(Translate.Translate("Printvenlig side"))%>
                            <table id="PrintFriendly">
                                <tr>
                                    <td colspan="2">
                                        <strong>
                                            <%=Translate.Translate("Aktuel side")%>
                                        </strong>
                                    </td>
                                </tr>
                                <%If Base.HasVersion("18.10.1.0") Then%>
                                <tr>
                                    <td width="170">
                                        &nbsp;<%=Translate.Translate("HTML")%></td>
                                    <td>
                                        <%=StyleSheet.ListPrintthis(objProp.Value("PagePrintthis"), "PagePrintthis")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="170">
                                        &nbsp;<%=Translate.Translate("PDF")%></td>
                                    <td>
                                        <%=StyleSheet.ListPrintthis(objProp.Value("PagePrintthisPDF"), "PagePrintthisPDF")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <strong>
                                            <%=Translate.Translate("Aktuel side og undersider")%>
                                        </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="170">
                                        &nbsp;<%=Translate.Translate("HTML")%></td>
                                    <td>
                                        <%=StyleSheet.ListPrintthis(objProp.Value("TreePrintthis"), "TreePrintthis")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="170">
                                        &nbsp;<%=Translate.Translate("PDF")%></td>
                                    <td>
                                        <%=StyleSheet.ListPrintthis(objProp.Value("TreePrintthisPDF"), "TreePrintthisPDF")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="170">
                                        &nbsp;<%=Translate.Translate("Indsæt sideskift")%></td>
                                    <td>
                                        <%=Gui.CheckBox(objProp.Value("PageInsertBreaks"), "PageInsertBreaks")%>
                                    </td>
                                </tr>
                                <%ELSE%>
                                <tr>
                                    <td width="170">
                                        <%=Translate.Translate("Printvenlig side")%>
                                    </td>
                                    <td>
                                        <%=StyleSheet.ListPrintthis(objProp.Value("PagePrintthis"), "PagePrintthis")%>
                                    </td>
                                </tr>
                                <%End If%>
                            </table>
                            <%=Gui.GroupBoxEnd%>
                        </td>
                    </tr>
                    <%	End If%>
                    <%	If Base.HasAccess("Accessibility", "") Then%>
                    <tr>
                        <td valign="top">
                            <%=Gui.GroupBoxStart(Translate.Translate("Tilgængelighed"))%>
                            <table id="Access">
                                <tr>
                                    <td width="170">
                                        <%=Translate.Translate("Alternativ stylesheet")%>
                                    </td>
                                    <td>
                                        <%=Gui.StylesheetList(objProp.Value("PageAlternativeStylesheet"), "PageAlternativeStylesheet")%>
                                    </td>
                                </tr>
                            </table>
                            <%=Gui.GroupBoxEnd%>
                        </td>
                    </tr>
                    <%	End If%>
                    <%	If Base.HasAccess("Corporate", "") Then%>
                    <tr>
                        <td valign="top">
                            <%=Gui.GroupBoxStart(Translate.Translate("PDA/Smartphone StyleSheet"))%>
                            <table id="PDA">
                                <tr>
                                    <td width="170">
                                        <%=Translate.Translate("Alternativ stylesheet")%>
                                    </td>
                                    <td>
                                        <%=Gui.StylesheetList(objProp.Value("PagePDAAlternativeStylesheet"), "PagePDAAlternativeStylesheet")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="170">
                                        <%=Translate.Translate("Alternativ sproglag")%>
                                    </td>
                                    <td>
                                        <%=Gui.SelectArea("PagePDAAlternativeArea", objProp.Value("PagePDAAlternativeArea"))%>
                                    </td>
                                </tr>
                            </table>
                            <%=Gui.GroupBoxEnd%>
                        </td>
                    </tr>
                    <%	End If%>
            </div>
        </td>
    </tr>
</table>
<tr>
    <td>
        <div>
            <!-- #INCLUDE FILE="stylesheet_class_submit.aspx" -->
            
             <%= Gui.TemplatePreviewScript("paragraph", objProp.Value("ParagraphTemplateID"), "StylesheetClassForm") %>
