<%@ Page Language="vb" AutoEventWireup="false" codebehind="Searchv1_Edit.aspx.vb" ValidateRequest="false" Inherits="Dynamicweb.Admin.Searchv1_Edit"%>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%
'**************************************************************************************************
'	Current version:	1.0
'	Created:			13-12-2004
'	Last modfied:		13-12-2004
'
'	Purpose: Search backend
'
'	Revision history:
'		1.0 - 13-12-2004 - Nicolai Pedersen
'		First version.
'**************************************************************************************************
'Set Translate = New DWtranslate
%>
<link rel="Stylesheet" type="text/css" href="/Admin/Module/eCom_Catalog/images/ObjectSelector.css" />
<script type="text/javascript" language="JavaScript" src="/Admin/Module/eCom_Catalog/dw7/images/functions.js"></script>
<script type="text/javascript" src="/Admin/Module/eCom_Catalog/dw7/images/AjaxAddInParameters.js"></script>

<script>

function initValidators () {
    window["paragraphEvents"].setValidator(function () {
        var ret = true;
        var emptyPages = [];
        var firstSelector = null;
        var checked = $$('#search-in input:checked');

        checked.each(function (c) {
            var m = new RegExp('Searchv1((Search)*)(.+)').exec(c.id);

            if (m != null && m.length > 3) {
                var pageSelectorId = 'Searchv1' + m[3] + 'PageID';
                var pageSelector = $(pageSelectorId);

                if (pageSelector && (!pageSelector.value || !pageSelector.value.length)) {
                    emptyPages.push(c.next('label').innerHTML);

                    if (!firstSelector) {
                        firstSelector = $('Link_' + pageSelectorId);
                    }
                }
            }
        });

        if (emptyPages.length) {
            if (firstSelector) {
                try {
                    firstSelector.focus();
                } catch (ex) { }
            }

            alert('<%=Translate.Translate("Please specify %% for: ", "%%", """Show on page""")%>' + '\n\n' + emptyPages.join('\n'));

            ret = false;
        }

        return ret;
    });
}

function CheckeComSettings() {
    //Custom product fields
	try {
        var cpf = null;
        for( i = 0; i < document.paragraph_edit.Searchv1eComUseAllCustomField.length; i++ ) {
            if( document.paragraph_edit.Searchv1eComUseAllCustomField[i].checked == true ) {
                cpf = document.paragraph_edit.Searchv1eComUseAllCustomField[i].value;
            }
        }
        if (cpf == null) {
            for( i = 0; i < document.paragraph_edit.Searchv1eComUseAllCustomField.length; i++ ) {
                if(document.paragraph_edit.Searchv1eComUseAllCustomField[i].value == "ALL") {
                    document.paragraph_edit.Searchv1eComUseAllCustomField[i].checked = true;
                }
            }
        }
	} catch(e) {
		//Nothing
	}		

    //Custom group fields
	try {
        var cgf = null;
        for( i = 0; i < document.paragraph_edit.Searchv1eComUseAllCustomGroupField.length; i++ ) {
            if( document.paragraph_edit.Searchv1eComUseAllCustomGroupField[i].checked == true ) {
                cgf = document.paragraph_edit.Searchv1eComUseAllCustomGroupField[i].value;
            }
        }
        if (cgf == null) {
            for( i = 0; i < document.paragraph_edit.Searchv1eComUseAllCustomGroupField.length; i++ ) {
                if(document.paragraph_edit.Searchv1eComUseAllCustomGroupField[i].value == "ALL") {
                    document.paragraph_edit.Searchv1eComUseAllCustomGroupField[i].checked = true;
                }
            }
        }
	} catch(e) {
		//Nothing
	}		
}
</script>

<style type="text/css">

    .notice {
        font-size:smaller;
        color:#8c8c8c;
        padding-left:22px;
    }

</style>

<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" />
<input type="hidden" name="Searchv1_Settings" value="Searchv1Method, Searchv1SearchPages, Searchv1SearchNews, Searchv1Area, Searchv1AreaID, Searchv1News, Searchv1NewsPageID, Searchv1NewsParagraphID, Searchv1SearchNewsUseDate, Searchv1NewsCategoryID, Searchv1PageSize, Searchv1ButtonForward, Searchv1ButtonForwardText, Searchv1ButtonForwardPicture, Searchv1ButtonBack, Searchv1ButtonBackText, Searchv1ButtonBackPicture, Searchv1TemplateSearch, Searchv1TemplateNoresult, Searchv1TemplateList, Searchv1TemplateListElement, Searchv1SearchCalender, Searchv1Calender, Searchv1CalenderPageID, Searchv1CalenderParagraphID, Searchv1SearchCalenderUseDate, Searchv1CalenderCategoryID, Searchv1SearchShop, Searchv1Shop, Searchv1ShopPageID, Searchv1ShopParagraphID, Searchv1ShopProductGroupID, Searchv1SearchPageUseDescription, SearchKeywords, WeightTitle, WeightText, WeightDescription, WeightKeywords, Searchv1MediaDBPageID, Searchv1MediaDBParagraphID, Searchv1MediaDB, Searchv1MediaDBGroupID, Searchv1SearchMediaDB, Searchv1PageID, Searchv1SearchFiles, Searchv1FilesCatalog, Searchv1FilesStartIn, Searchv1FilesExtensions, Searchv1FilesSearchSubfolders, Searchv1SearchNewsDontUseM, Searchv1SearchCalenderDontUseM, Searchv1SearchShopDontUseM, Searchv1SearchMediaDBDontUseM, Searchv1FilesAllwaysUseFilenameAsTitle, LegendInclude, LegendIncludeLink, LegendIncludeArea, LegendIncludeAreaFrontpage, Searchv1SearcheCom, Searchv1eComPageID, Searchv1eComParagraphID, Searchv1SearcheComDontUseM, Searchv1eComIncludeExtendedVariants, ProductAndGroupsSelector, IncludeSubgroups, Searchv1eComUseAllCustomField, Searchv1eComUseAllCustomGroupField, Searchv1IntranoteIntegration, SearchParagraphHeader, UseStoredLuceneIndex, UseTitle, Searchv1IncludeGlobalParagraph<%=GetCustomModulesFields()%><%=eComProductFieldData()%>" />

<tr>
	<td>
		<%=Gui.MakeModuleHeader("searchv1", "Søg,_vægtet")%>
	</td>
</tr>
<tr>
	<td>
		<%=Gui.GroupBoxStart(Translate.Translate("Søgemetode")) %>
			<table cellpadding="2" cellspacing="0" border="0" width="100%">
				<colgroup>
					<col width="170px" />
					<col />
				</colgroup>
				<tr>
					<td valign="top"><%=Translate.Translate("Søg efter")%></td>
					<td>
						<%=Gui.RadioButton(prop.value("Searchv1Method"), "Searchv1Method", "1")%><label for="Searchv1Method1"><%=Translate.Translate("Hele ordet - del af ordet hvis hele ordet ikke findes")%></label><br>
						<%=Gui.RadioButton(prop.value("Searchv1Method"), "Searchv1Method", "2")%><label for="Searchv1Method2"><%=Translate.Translate("Hele ordet og del af ordet")%></label><br>
						<%=Gui.RadioButton(prop.value("Searchv1Method"), "Searchv1Method", "3")%><label for="Searchv1Method3"><%=Translate.Translate("Hele ordet")%></label>
					</td>
				</tr>
			</table>
		<%=Gui.GroupBoxEnd() %>

		<%=Gui.GroupBoxStart(Translate.Translate("Søg i")) %>
			<table id="search-in" cellpadding="2" cellspacing="0" border="0" width="100%">
				<colgroup>
					<col width="170px" />
					<col />
				</colgroup>
				<tr>
					<td valign="top"><%=Translate.translate("Søg i")%></td>
					<td><%=Gui.CheckBox(prop.value("Searchv1SearchPages"), "Searchv1SearchPages")%> <label for="Searchv1SearchPages"><%=Translate.Translate("Sider og afsnit")%></label></td>
				</tr>
				<%  If Base.HasAccess("News", "") OrElse Base.HasAccess("NewsV2", "") Then%>
				<tr>
					<td>&nbsp;</td>
					<td><%=Gui.CheckBox(prop.value("Searchv1SearchNews"), "Searchv1SearchNews")%> <label for="Searchv1SearchNews"><%=Translate.Translate("Nyheder", 9)%> </label></td>
				</tr>
				<%	End If%>
				<%	If Base.HasAccess("Calender", "") Or Base.HasAccess("Calendar", "") Then%>
				<tr>
					<td>&nbsp;</td>
					<td><%=Gui.CheckBox(prop.value("Searchv1SearchCalender"), "Searchv1SearchCalender")%> <label for="Searchv1SearchCalender"><%=Translate.Translate("Kalender", 9)%> </label></td>
				</tr>
				<% 	End If%>
				<% 	If Base.HasAccess("Shop", "") Then%>
				<tr>
					<td>&nbsp;</td>
					<td><%=Gui.CheckBox(prop.Value("Searchv1SearchShop"), "Searchv1SearchShop")%> <label for="Searchv1SearchShop"><%=Translate.Translate("Shop",9)%> </label></td>
				</tr>
				<%End If%>
				<%If Dynamicweb.eCommerce.Common.Functions.IsEcom Then%>
				<tr>
					<td>&nbsp;</td>
					<td><%=Gui.CheckBox(prop.value("Searchv1SearcheCom"), "Searchv1SearcheCom")%> <label for="Searchv1SearcheCom"><%=Translate.Translate("eCommerce",9)%> </label></td>
				</tr>
				<%End If%>
				<%If Base.HasAccess("MediaDB", "") Then%>
				<tr>
					<td>&nbsp;</td>
					<td><%=Gui.CheckBox(prop.value("Searchv1SearchMediaDB"), "Searchv1SearchMediaDB")%> <label for="Searchv1SearchMediaDB"><%=Translate.Translate("Medie database",9)%> </label></td>
				</tr>
				<%End If%>
				<%If Base.HasAccess("IntranoteIntegration", "") Then%>
					<tr>
						<td>&nbsp;</td>
						<td><%=Gui.CheckBox(prop.Value("Searchv1IntranoteIntegration"), "Searchv1IntranoteIntegration")%> <label for="Searchv1IntranoteIntegration"><%=Translate.Translate("Intranote Integration")%></label></td>
					</tr>
				<%End If%>
				<%=GetCustomModulesList()%>
				<tr>
					<td>&nbsp;</td>
					<td><%=Gui.CheckBox(prop.value("Searchv1SearchFiles"), "Searchv1SearchFiles")%> <label for="Searchv1SearchFiles"><%=Translate.Translate("Filer")%> </label></td>
				</tr>
			</table>
		<%=Gui.GroupBoxEnd() %>
		
		<%=Gui.GroupBoxStart(Translate.Translate("Vægtning")) %>
			<table cellpadding="2" cellspacing="0" border="0" width="100%">
				<colgroup>
					<col width="170px" />
					<col />
				</colgroup>
				<tr>
					<td><%=Translate.translate("Titel")%></td>
					<td><%=Gui.SpacListExt(prop.value("WeightTitle"), "WeightTitle", 0, 10, 1, "")%></td>
				</tr>
				<tr>
					<td><%=Translate.translate("Tekst")%></td>
					<td><%=Gui.SpacListExt(prop.value("WeightText"), "WeightText", 0, 10, 1, "")%></td>
				</tr>
				<tr>
					<td><%=Translate.translate("Beskrivelse")%></td>
					<td><%=Gui.SpacListExt(prop.value("WeightDescription"), "WeightDescription", 0, 10, 1, "")%></td>
				</tr>
				<tr>
					<td><%=Translate.translate("Nøgleord")%></td>
					<td><%=Gui.SpacListExt(prop.value("WeightKeywords"), "WeightKeywords", 0, 10, 1, "")%></td>
				</tr>
			</table>
		<%=Gui.GroupBoxEnd() %>
		<script language="javascript">
		function LegendSettings(elm){
			if(elm.value != ""){
				document.getElementById("LegendIncludeLinkRow").style.display = "";
				document.getElementById("LegendIncludeAreaRow").style.display = "";
				document.getElementById("LegendIncludeAreaFrontpageRow").style.display = "";
			}
			else{
				document.getElementById("LegendIncludeLinkRow").style.display = "none";
				document.getElementById("LegendIncludeAreaRow").style.display = "none";
				document.getElementById("LegendIncludeAreaFrontpageRow").style.display = "none";
			}
		}
		</script>
		<%=Gui.GroupBoxStart(Translate.Translate("Brødkrummesti")) %>
			<table cellpadding="2" cellspacing="0" border="0" width="100%">
				<colgroup>
					<col width="170px" />
					<col />
				</colgroup>
				<tr>
					<td valign="top"><%=Translate.Translate("Vis")%></td>
					<td><%=Gui.Checkbox(prop.value("LegendInclude"), "LegendInclude", "onchange=""LegendSettings(this);""")%><label for="LegendInclude"><%=Translate.Translate("Brødkrummesti")%></label></td>
				</tr>
				<tr id="LegendIncludeLinkRow">
					<td>&nbsp;</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;<%=Gui.Checkbox(prop.value("LegendIncludeLink"), "LegendIncludeLink")%><label for="LegendIncludeLink"><%=Translate.Translate("Link")%></label></td>
				</tr>
				<%If Base.HasAccess("Area", "") Then%>
				<tr id="LegendIncludeAreaRow">
					<td>&nbsp;</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;<%=Gui.Checkbox(prop.value("LegendIncludeArea"), "LegendIncludeArea")%><label for="LegendIncludeArea"><%=Translate.Translate("Sproglag")%></label></td>
				</tr>
				<%End If%>
				<tr id="LegendIncludeAreaFrontpageRow">
					<td>&nbsp;</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;<%=Gui.Checkbox(prop.value("LegendIncludeAreaFrontpage"), "LegendIncludeAreaFrontpage")%><label for="LegendIncludeAreaFrontpage"><%=Translate.Translate("Første side i sproglag")%></label></td>
				</tr>
			</table>
		<%=Gui.GroupBoxEnd() %>
		
		<%=Gui.GroupBoxStart(Translate.translate("Indstillinger - %%", "%%", Translate.translate("Sideindhold")))%>
			<table cellpadding="2" cellspacing="0" border="0" width="100%">
				<colgroup>
					<col width="170px" />
					<col />
				</colgroup>
				<tr>
					<td>&nbsp;</td>
					<td><%=Gui.CheckBox(prop.value("SearchKeywords"), "SearchKeywords")%> <label for="SearchKeywords"><%=Translate.Translate("Søg i nøgleord")%></label></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><%=Gui.CheckBox(prop.value("Searchv1SearchPageUseDescription"), "Searchv1SearchPageUseDescription")%> <label for="Searchv1SearchPageUseDescription"><%=Translate.Translate("Use page meta description as summary in results")%></label></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><%=Gui.CheckBox(prop.Value("UseTitle"), "UseTitle")%> <label for="UseTitle"><%=Translate.Translate("Use page meta title as title in results")%></label></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><%= Gui.CheckBox(prop.value("SearchParagraphHeader"), "SearchParagraphHeader")%> <label for="SearchParagraphHeader"><%=Translate.Translate("Search in paragraph name")%></label></td>
				</tr>
				<tr <%= Base.IIf(IsLuceneIndex(), "", "style=""display: none""")%>>
					<td>&nbsp;</td>
					<td>
                        <%= Gui.CheckBox(prop.Value("UseStoredLuceneIndex"), "UseStoredLuceneIndex")%> <label for="UseStoredLuceneIndex"><%=Translate.Translate("Use Lucene index to search in Items")%></label>
                        <div class="notice">
                            <%=Translate.Translate("Make sure that the index scheduling runs frequently to ensure up to date search results")%>
                        </div>
					</td>
				</tr>
				<tr>
					<td><%=Translate.Translate("Søg i")%></td>
					<td><%=Gui.RadioButton(prop.value("Searchv1Area"), "Searchv1Area", "Local")%> <label for="Searchv1AreaLocal"><%=Translate.Translate("Aktuelle sproglag") %></label></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><%=Gui.RadioButton(prop.value("Searchv1Area"), "Searchv1Area", "Global")%> <label for="Searchv1AreaGlobal"><%= Translate.Translate("Alle sproglag") %></label></td>
				</tr>
				<%If Base.HasVersion("18.9.1.0") Then%>
				<tr>
					<td>&nbsp;</td>
					<td>
						<table cellpadding="0" cellspacing="0" border="0" width="100%">
							<colgroup>
								<col width="20px" />
								<col />
							</colgroup>
							<tr>
								<td colspan="2">
									<%=Gui.RadioButton(prop.value("Searchv1Area"), "Searchv1Area", "Specified")%> <label for="Searchv1AreaSpecified"><%= Translate.Translate("Følgende sproglag") %></label>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="top">
									<%
									Dim Searchv1AreaIDList as String = "@" & Replace(prop.value("Searchv1AreaID"), ",", "@") & "@"
									Dim sql as String = "SELECT * FROM Area ORDER BY AreaName"
									Dim cn As System.Data.IDbConnection = Database.CreateConnection("Dynamic.mdb")
									Dim cmd As IDbCommand = cn.CreateCommand
									cmd.CommandText = sql
									Dim dr as IDataReader = cmd.ExecuteReader()

									Dim blnHasRows as Boolean = false
									Do While dr.Read()
										If Not blnHasRows Then
											blnHasRows = true
										End If
										If Base.HasAccess("AreaCategories", dr("AreaID").ToString) Then
											Response.Write("<input type=""checkbox"" name=""Searchv1AreaID"" id=""area" & dr("AreaID").ToString & """ value=""" & dr("AreaID").ToString & """")
											If InStr(Searchv1AreaIDList, "@" & dr("AreaID").ToString & "@") Then
												Response.Write(" checked")
											End If
											Response.Write(">")
											Response.Write("<label for=""area" & dr("AreaID").ToString & """><nobr>" & dr("AreaName").ToString & "</nobr></label><br>" & vbcrlf)
										End If
									Loop
									
									dr.Close()
									dr.Dispose()
									cmd.Dispose()
									cn.Dispose()
									%>
								</td>
							</tr>
						</table>						
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<table cellpadding="0" cellspacing="0" border="0" width="100%">
							<colgroup>
								<col width="20px" />
								<col />
							</colgroup>
							<tr>
								<td colspan="2">
									<%=Gui.RadioButton(prop.value("Searchv1Area"), "Searchv1Area", "Page")%> <label for="Searchv1AreaPage"><%= Translate.Translate("Denne side med undersider") %></label>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="top"><%=Gui.LinkManager(prop.value("Searchv1PageID"), "Searchv1PageID", "")%></td>
							</tr>
						</table>									
					</td>
				</tr>
                <%End If%>				
                
				<%If Base.HasVersion("18.13.0.0") Then%>
				<tr>
					<td>&nbsp;</td>
					<td><%=Gui.CheckBox(prop.Value("Searchv1IncludeGlobalParagraph"), "Searchv1IncludeGlobalParagraph")%> <label for="Searchv1IncludeGlobalParagraph"><%=Translate.Translate("Include global paragraph")%></label></td>
				</tr>                
				<%End If%>
			</table>
		<%=Gui.GroupBoxEnd() %>
		<%If Base.HasAccess("News", "") OrElse Base.HasAccess("NewsV2", "") Then%>
		<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger - %%", "%%", Translate.translate("Nyheder")))%>
			<table cellpadding="2" cellspacing="0" border="0" width="100%">
				<colgroup>
					<col width="170px" />
					<col />
				</colgroup>
				<tr>
					<td><%=Translate.Translate("Vis på side")%></td>
					<td><%=Gui.Linkmanager(prop.value("Searchv1NewsPageID"), "Searchv1NewsPageID", "") %></td>
				</tr>
				<tr>
					<td><%=Translate.translate("Afsnits ID")%></td>
					<td><input type="text" name="Searchv1NewsParagraphID" value="<%=prop.value("Searchv1NewsParagraphID")%>" class="std" style="width:50px;"> (<%=Translate.Translate("Indstillinger")%>)</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><%=Gui.CheckBox(prop.value("Searchv1SearchNewsDontUseM"), "Searchv1SearchNewsDontUseM")%> <label for="Searchv1SearchNewsDontUseM"><%=Translate.translate("Bevar opsætning af afsnit på side")%></label></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><%=Gui.CheckBox(prop.value("Searchv1SearchNewsUseDate"), "Searchv1SearchNewsUseDate")%> <label for="Searchv1SearchNewsUseDate"><%=Translate.translate("Medtag dato i titel")%></label></td>
				</tr>
				<tr>
					<td><%=Translate.translate("Søg i")%></td>
					<td><%=Gui.RadioButton(prop.value("Searchv1News"), "Searchv1News", "All")%> <label for="Searchv1NewsAll"><%= Translate.Translate("Alle kategorier") %></label></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<table cellpadding="0" cellspacing="0" border="0" width="100%">
							<colgroup>
								<col width="20px" />
								<col />
							</colgroup>
							<tr>
								<td colspan="2">
									<%=Gui.RadioButton(prop.value("Searchv1News"), "Searchv1News", "Specified")%> <label for="Searchv1NewsSpecified"><%= Translate.Translate("Følgende kategorier") %></label>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="top">
									<%
									Dim Searchv1NewsCategoryIDList as String = "@" & Replace(prop.value("Searchv1NewsCategoryID"), ",", "@") & "@"
									Dim sql as String = "SELECT * FROM NewsCategory ORDER BY NewsCategoryName"
									Dim cn As System.Data.IDbConnection = Database.CreateConnection("Dynamic.mdb")
									Dim cmd As IDbCommand = cn.CreateCommand
									cmd.CommandText = sql
									Dim dr as IDataReader = cmd.ExecuteReader()

									Dim blnHasRows as Boolean = false
									Do While dr.Read()
										If Not blnHasRows Then
											blnHasRows = true
										End If
										If Base.HasAccess("NewsCategories", dr("NewsCategoryID").ToString) Then
											Response.Write("<input type=""checkbox"" name=""Searchv1NewsCategoryID"" id=""news" & dr("NewsCategoryID").ToString & """ value=""" & dr("NewsCategoryID").ToString & """")
											If InStr(Searchv1NewsCategoryIDList, "@" & dr("NewsCategoryID").ToString & "@") Then
												Response.Write(" checked")
											End If
											Response.Write(">")
											Response.Write("<label for=""news" & dr("NewsCategoryID").ToString & """><nobr>" & dr("NewsCategoryName").ToString & "</nobr></label><br>" & vbcrlf)
										End If
									Loop
									
									dr.Close()
									dr.Dispose()
									cmd.Dispose()
									cn.Dispose()
									%>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		<%=Gui.GroupBoxEnd() %>
		<%End If%>
		<%If Base.HasAccess("Calender", "") OrElse Base.HasAccess("Calendar", "") Then%>
		<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger - %%", "%%", Translate.translate("Kalender")))%>
			<table cellpadding="2" cellspacing="0" border="0" width="100%">
				<colgroup>
					<col width="170px" />
					<col />
				</colgroup>
				<tr>
					<td><%=Translate.Translate("Vis på side")%></td>
					<td><%=Gui.Linkmanager(prop.value("Searchv1CalenderPageID"), "Searchv1CalenderPageID", "") %></td>
				</tr>
				<tr>
					<td><%=Translate.translate("Afsnits ID")%></td>
					<td><input type="text" name="Searchv1CalenderParagraphID" value="<%=prop.value("Searchv1CalenderParagraphID")%>" class="std" style="width:50px;"> (<%=Translate.Translate("Indstillinger")%>)</td>
				</tr>
				<tr>
					<td></td>
					<td><%=Gui.CheckBox(prop.value("Searchv1SearchCalenderDontUseM"), "Searchv1SearchCalenderDontUseM")%> <label for="Searchv1SearchCalenderDontUseM"><%=Translate.translate("Bevar opsætning af afsnit på side")%></label></td>
				</tr>
				<tr>
					<td></td>
					<td><%=Gui.CheckBox(prop.value("Searchv1SearchCalenderUseDate"), "Searchv1SearchCalenderUseDate")%> <label for="Searchv1SearchCalenderUseDate"><%=Translate.translate("Medtag dato i titel")%></label></td>
				</tr>
				<tr>
					<td><%=Translate.translate("Søg i")%></td>
					<td><%=Gui.RadioButton(prop.value("Searchv1Calender"), "Searchv1Calender", "All")%> <label for="Searchv1CalenderAll"><%= Translate.Translate("Alle kategorier") %></label></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<table cellpadding="0" cellspacing="0" border="0" width="100%">
							<colgroup>
								<col width="20px" />
								<col />
							</colgroup>
							<tr>
								<td colspan="2">
									<%=Gui.RadioButton(prop.value("Searchv1Calender"), "Searchv1Calender", "Specified")%> <label for="Searchv1CalenderSpecified"><%= Translate.Translate("Følgende kategorier") %></label>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign=top>
									<%
									Dim Searchv1CalenderCategoryIDList as String = "@" & Replace(prop.value("Searchv1CalenderCategoryID"), ",", "@") & "@"
									Dim sql as string = "SELECT * FROM CalenderCategory ORDER BY CalenderCategory"
									Dim cn As System.Data.IDbConnection  = Database.CreateConnection("Dynamic.mdb")
									Dim cmd As IDbCommand = cn.CreateCommand
									cmd.CommandText = sql
									Dim dr as IDataReader = cmd.ExecuteReader()

									Do While dr.Read()
										If Base.HasAccess("CalenderCategories", dr("CalenderCategoryID").ToString) Then
											Response.Write("<input type=""checkbox"" name=""Searchv1CalenderCategoryID"" id=""Calender" & dr("CalenderCategoryID").ToString & """ value=""" & dr("CalenderCategoryID").ToString & """")
											If InStr(Searchv1CalenderCategoryIDList, "@" & dr("CalenderCategoryID").ToString & "@") Then
												Response.Write(" checked")
											End If
											Response.Write(">")
											Response.Write("<label for=""Calender" & dr("CalenderCategoryID").ToString & """><nobr>" & dr("CalenderCategory").ToString & "</nobr></label><br>" & vbcrlf)
										End If
									Loop
									
									dr.Close()
									dr.Dispose()
									cmd.Dispose()
									cn.Dispose()
									%>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		<%=Gui.GroupBoxEnd() %>
		<%End If%>

		<%If Base.HasAccess("Shop", "") Then%>
		<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger - %%", "%%", Translate.translate("Varekatalog")))%>
			<table cellpadding="2" cellspacing="0" border="0" width="100%">
				<tr>
					<td width="170"><%=Translate.Translate("Vis på side")%></td>
					<td><%=Gui.Linkmanager(prop.value("Searchv1ShopPageID"), "Searchv1ShopPageID", "") %></td>
				</tr>
				<tr>
					<td><%=Translate.translate("Afsnits ID")%></td>
					<td><input type="text" name="Searchv1ShopParagraphID" value="<%=prop.value("Searchv1ShopParagraphID")%>" class="std" style="width:50px;"> (<%=Translate.Translate("Indstillinger")%>)</td>
				</tr>
				<tr>
					<td></td>
					<td><%=Gui.CheckBox(prop.value("Searchv1SearchShopDontUseM"), "Searchv1SearchShopDontUseM")%> <label for="Searchv1SearchShopDontUseM"><%=Translate.translate("Bevar opsætning af afsnit på side")%></label></td>
				</tr>
				<tr>
					<td><%=Translate.translate("Søg i")%></td>
					<td><%=Gui.RadioButton(prop.value("Searchv1Shop"), "Searchv1Shop", "All")%> <label for="Searchv1ShopAll"><%= Translate.Translate("Alle kategorier") %></label></td>
				</tr>
				<tr>
					<td></td>
					<td>
						<table cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td colspan="2">
									<%=Gui.RadioButton(prop.value("Searchv1Shop"), "Searchv1Shop", "Specified")%> <label for="Searchv1ShopSpecified"><%=Translate.Translate("Følgende kategorier")%></label>
								</td>
							</tr>
							<tr>
								<td width="20"><img src="/Admin/Images/Nothing.gif" width="20" /></td>
								<td valign=top>
								    <%=GetShopGroupList(("@" & Replace(prop.Value("Searchv1ShopProductGroupID"), ",", "@") & "@"))%>
									<%
									    'Dim Searchv1ShopProductGroupList as String = "@" & Replace(prop.value("Searchv1ShopProductGroupID"), ",", "@") & "@"
									    'Dim sql as String = "SELECT * FROM ShopGroup ORDER BY ShopGroupName"
									    'Dim cn As System.Data.IDbConnection = Database.CreateConnection("DWShop.mdb")
									    'Dim cmd As IDbCommand = cn.CreateCommand
									    'cmd.CommandText = sql
									    'Dim dr as IDataReader = cmd.ExecuteReader()

									    'Do While dr.Read()
									    '	If Base.HasAccess("ShopCategories", dr("ShopGroupID").ToString) Then
									    '		Response.Write("<input type=""checkbox"" name=""Searchv1ShopProductGroupID"" id=""Shop" & dr("ShopGroupID").ToString & """ value=""" & dr("ShopGroupID").ToString & """")
									    '		If InStr(Searchv1ShopProductGroupList, "@" & dr("ShopGroupID").ToString & "@") Then
									    '			Response.Write(" checked")
									    '		End If
									    '		Response.Write(">")
									    '		Response.Write("<label for=""Shop" & dr("ShopGroupID").ToString & """><nobr>" & dr("ShopGroupName").ToString & "</nobr></label><br>" & vbcrlf)
									    '	End If
									    'Loop
									
									    'dr.Close()
									    'dr.Dispose()
									    'cmd.Dispose()
									    'cn.Dispose()
									%>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		<%=Gui.GroupBoxEnd() %>
		<%End If%>

		
		<!--eCom-->
		<%If Dynamicweb.eCommerce.Common.Functions.IsEcom Then%>
			<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger - %%", "%%", Translate.translate("eCom varekatalog")))%>
				<table cellpadding="2" cellspacing="0" border="0" width="100%">
					<colgroup>
						<col width="170px" />
						<col />
					</colgroup>
					<tr>
						<td><%=Translate.Translate("Vis på side")%></td>
						<td><%=Gui.Linkmanager(prop.value("Searchv1eComPageID"), "Searchv1eComPageID", "") %></td>
					</tr>
					<tr>
						<td><%=Translate.translate("Afsnits ID")%></td>
						<td><input type="text" name="Searchv1eComParagraphID" value="<%=prop.value("Searchv1eComParagraphID")%>" class="std" style="width:50px;"> (<%=Translate.Translate("Indstillinger")%>)</td>
					</tr>
					<tr>
						<td></td>
						<td><%=Gui.CheckBox(prop.value("Searchv1SearcheComDontUseM"), "Searchv1SearcheComDontUseM")%> <label for="Searchv1SearcheComDontUseM"><%=Translate.translate("Bevar opsætning af afsnit på side")%></label></td>
					</tr>
					<tr>
						<td></td>
						<td><%=Gui.CheckBox(prop.Value("Searchv1eComIncludeExtendedVariants"), "Searchv1eComIncludeExtendedVariants")%> <label for="Searchv1eComIncludeExtendedVariants"><%=Translate.Translate("Include extended variants")%></label></td>
					</tr>
					<tr id="GroupSelector" style="display:;">
						<td valign="top"><%=Translate.Translate("Varegrupper")%></td>
						<td>
                            <de:ProductsAndGroupsSelector runat="server" OnlyGroups="true" ShowSearches="false" ID="ProductAndGroupsSelector" CallerForm="paragraph_edit" Width="250px" Height="100px" />
                            <%If Base.IsModuleInstalled("eCom_MultiShopAdvanced") Then%>
						    <input type="checkbox" runat="server" id="IncludeSubgroups" name="IncludeSubgroups" value="1" />
						    <label for="IncludeSubgroups">
						         <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Include subgroups" />
						    </label>
                            <%End If%>
						</td>
					</tr>

					
				    <tr>
					    <td><%=Translate.Translate("udv. varefelter")%></td>
					    <td><%=Gui.RadioButton(prop.Value("Searchv1eComUseAllCustomField"), "Searchv1eComUseAllCustomField", "ALL")%> <%=Translate.Translate("Alle")%></td>
				    </tr>
                    <tr>
					    <td>&nbsp;</td>
					    <td>
						    <table cellpadding="0" cellspacing="0" border="0" width="100%">
								<colgroup>
									<col width="20px" />
									<col />
								</colgroup>
								<tr>
									<td colspan="2"><%=Gui.RadioButton(prop.Value("Searchv1eComUseAllCustomField"), "Searchv1eComUseAllCustomField", "SPECIFIED")%> <%= Translate.Translate("Følgende varefelter") %></td>
								</tr>
								<tr>
									<td>&nbsp;</td>
									<td valign="top">			
										<table cellpadding="0" cellspacing="0" border="0" width="100%">		
											<asp:Literal id="CustomProductFieldList" runat="server"></asp:Literal>
										</table>
									</td>
								</tr>
						    </table>
					    </td>
				    </tr>
				    <tr>
						<td><%=Translate.Translate("Brugerdefinerede varegruppefelter")%></td>
						<td><%=Gui.RadioButton(prop.Value("Searchv1eComUseAllCustomGroupField"), "Searchv1eComUseAllCustomGroupField", "ALL")%> <%=Translate.Translate("Alle")%></td>
				    </tr>
				    <tr>
						<td>&nbsp;</td>
						<td><%=Gui.RadioButton(prop.Value("Searchv1eComUseAllCustomGroupField"), "Searchv1eComUseAllCustomGroupField", "SPECIFIED")%> <%=Translate.Translate("Følgende varegruppefelter")%></td>
				    </tr>
				    <tr>
						<td>&nbsp;</td>
						<td>
							<table cellpadding="0" cellspacing="0" border="0" width="100%">
								<colgroup>
									<col width="20px" />
									<col />
								</colgroup>
								<tr>
									<td>&nbsp;</td>
									<td>
										<table cellpadding="0" cellspacing="0" border="0" width="100%">		
											<asp:Literal id="CustomGroupFieldList" runat="server"></asp:Literal>
										</table>									
									</td>
								</tr>
							</table>
						</td>
				    </tr>
				</table>
			<%=Gui.GroupBoxEnd() %>
		<%End If%>		
		
		<!--Media DB-->
		<%If Base.HasAccess("MediaDB", "") Then%>
		<%=Gui.GroupBoxStart(Translate.Translate("Indstillinger - %%", "%%", Translate.translate("Medie database")))%>
			<table cellpadding="2" cellspacing="0" border="0" width="100%">
				<colgroup>
					<col width="170px" />
					<col />
				</colgroup>
				<tr>
					<td><%=Translate.Translate("Vis på side")%></td>
					<td><%=Gui.Linkmanager(prop.value("Searchv1MediaDBPageID"), "Searchv1MediaDBPageID", "") %></td>
				</tr>
				<tr>
					<td><%=Translate.translate("Afsnits ID")%></td>
					<td><input type="text" name="Searchv1MediaDBParagraphID" value="<%=prop.value("Searchv1MediaDBParagraphID")%>" class="std" style="width:50px;"> (<%=Translate.Translate("Indstillinger")%>)</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><%=Gui.CheckBox(prop.value("Searchv1SearchMediaDBDontUseM"), "Searchv1SearchMediaDBDontUseM")%> <label for="Searchv1SearchMediaDBDontUseM"><%=Translate.translate("Bevar opsætning af afsnit på side")%></label></td>
				</tr>
				<tr>
					<td><%=Translate.translate("Søg i")%></td>
					<td><%=Gui.RadioButton(prop.value("Searchv1MediaDB"), "Searchv1MediaDB", "All")%> <label for="Searchv1MediaDBAll"><%= Translate.Translate("Alle kategorier") %></label></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<table cellpadding="0" cellspacing="0" border="0" width="100%">
							<colgroup>
								<col width="20px" />
								<col />
							</colgroup>
							<tr>
								<td colspan="2">
									<%=Gui.RadioButton(prop.value("Searchv1MediaDB"), "Searchv1MediaDB", "Specified")%> <label for="Searchv1MediaDBSpecified"><%=Translate.Translate("Følgende kategorier")%></label>
								</td>
							</tr>
							<tr>
								<td><img src="/Admin/Images/Nothing.gif" width="20" /></td>
								<td valign="top">
									<%
									Dim Searchv1GroupList as String = "@" & Replace(prop.value("Searchv1MediaDBGroupID"), ",", "@") & "@"
									Dim sql as String = "SELECT * FROM MediaDBGroup ORDER BY MediaDBGroupName"
									Dim cn As System.Data.IDbConnection = Database.CreateConnection("DWMedia.mdb")
									Dim cmd As IDbCommand = cn.CreateCommand
									cmd.CommandText = sql
									Dim dr as IDataReader = cmd.ExecuteReader()

									Do While dr.Read()
										If Base.HasAccess("MediaDBCategories", dr("MediaDBGroupID").ToString) Then
											Response.Write("<input type=""checkbox"" name=""Searchv1MediaDBGroupID"" id=""Shop" & dr("MediaDBGroupID").ToString & """ value=""" & dr("MediaDBGroupID").ToString & """")
											If InStr(Searchv1GroupList, "@" & dr("MediaDBGroupID").ToString & "@") Then
												Response.Write(" checked")
											End If
											Response.Write(">")
											Response.Write("<label for=""Shop" & dr("MediaDBGroupID").ToString & """><nobr>" & dr("MediaDBGroupName").ToString & "</nobr></label><br>" & vbcrlf)
										End If
									Loop
									
									dr.Close()
									dr.Dispose()
									cmd.Dispose()
									cn.Dispose()
									%>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		<%=Gui.GroupBoxEnd() %>
		<%End If%>
		<%=GetCustomModulesSettings()%>
		<!--Files-->
		<%=Gui.GroupBoxStart(If(prop.Value("IsWindowsSearchSupported") = "1", Translate.Translate("Windows Search"), Translate.Translate("Index Server")))%>
            <dw:Infobar Visible="false" TranslateMessage="false" Message="" runat="server" Type="Information" Title="" Action="" ID="WindowsSearchServiceStatus"></dw:Infobar>
            <div id="folderOutOfIndexCnt" style="display:<%=If(prop.Value("IsWindowsSearchFolderOutOfIndex") = "1","block","none")%>">
                <dw:Infobar TranslateMessage="true" Message="The current folder out of search index" runat="server" Type="Error" Action="" ID="FolderOutOfIndex"></dw:Infobar>
            </div>
			<table cellpadding="2" cellspacing="0" border="0" width="100%">
				<colgroup>
					<col width="170px" />
					<col />
				</colgroup>
				<tr>
					<td>&nbsp;</td>
					<td><%=Gui.CheckBox(prop.value("Searchv1FilesAllwaysUseFilenameAsTitle"), "Searchv1FilesAllwaysUseFilenameAsTitle")%> <label for="Searchv1FilesAllwaysUseFilenameAsTitle"><%=Translate.translate("Brug filnavn som titel")%></label></td>
				</tr>
                <%If Not prop.Value("IsWindowsSearchSupported") = "1" Then%>
				<tr>
					<td><%=Translate.Translate("Katalog")%></td>
					<td>
                        <input type="text" name="Searchv1FilesCatalog" value="<%=prop.value("Searchv1FilesCatalog")%>" class="std">
					</td>
				</tr>
                <%End If%>
				<tr>
					<td><%=Translate.Translate("Søg i")%></td>
					<td><%=Gui.FolderManager(prop.Value("Searchv1FilesStartIn"), "Searchv1FilesStartIn")%></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><%=Gui.CheckBox(prop.value("Searchv1FilesSearchSubfolders"), "Searchv1FilesSearchSubfolders")%> <label for="Searchv1FilesSearchSubfolders"><%=Translate.translate("Søg ikke i undermapper")%></label></td>
				</tr>
				<tr>
					<td valign="top"><%=Translate.Translate("Begræns til filtyper")%></td>
					<td>
						<input type="checkbox" name="Searchv1FilesExtensions" id="Searchv1FilesExtensionsdoc" value="doc" <%=SearchV1setChecked(prop.value("Searchv1FilesExtensions"), "doc")%>><label for="Searchv1FilesExtensionsdoc"><img src="/Admin/Images/ext/doc.gif" align="absmiddle"> *.doc</label><br>
						<input type="checkbox" name="Searchv1FilesExtensions" id="Searchv1FilesExtensionspdf" value="pdf" <%=SearchV1setChecked(prop.value("Searchv1FilesExtensions"), "pdf")%>><label for="Searchv1FilesExtensionspdf"><img src="/Admin/Images/ext/pdf.gif" align="absmiddle"> *.pdf</label><br>
						<input type="checkbox" name="Searchv1FilesExtensions" id="Searchv1FilesExtensionsxls" value="xls" <%=SearchV1setChecked(prop.value("Searchv1FilesExtensions"), "xls")%>><label for="Searchv1FilesExtensionsxls"><img src="/Admin/Images/ext/xls.gif" align="absmiddle"> *.xls</label><br>
						<input type="checkbox" name="Searchv1FilesExtensions" id="Searchv1FilesExtensionsppt" value="ppt" <%=SearchV1setChecked(prop.value("Searchv1FilesExtensions"), "ppt")%>><label for="Searchv1FilesExtensionsppt"><img src="/Admin/Images/ext/ppt.gif" align="absmiddle"> *.ppt</label><br>
						<input type="checkbox" name="Searchv1FilesExtensions" id="Searchv1FilesExtensionstxt" value="txt" <%=SearchV1setChecked(prop.value("Searchv1FilesExtensions"), "txt")%>><label for="Searchv1FilesExtensionstxt"><img src="/Admin/Images/ext/txt.gif" align="absmiddle"> *.txt</label><br>
						<input type="checkbox" name="Searchv1FilesExtensions" id="Searchv1FilesExtensionsrtf" value="rtf" <%=SearchV1setChecked(prop.value("Searchv1FilesExtensions"), "rtf")%>><label for="Searchv1FilesExtensionsrtf"><img src="/Admin/Images/ext/rtf.gif" align="absmiddle"> *.rtf</label><br>
						<%=Translate.Translate("Yderligere filtyper")%> <input type="text" name="Searchv1FilesExtensions" value="<%=Trim(prop.value("Searchv1FilesExtensions"))%>" class="std">
					</td>
				</tr>				
			</table>
		<%=Gui.GroupBoxEnd() %>
	</td>
</tr>
<tr>
	<td colspan="2">
		<%=Gui.GroupBoxStart(Translate.translate("Sideopdeling")) %>
			<table cellpadding="2" cellspacing="0" border="0" width="100%">
				<colgroup>
					<col width="170px" />
					<col />
				</colgroup>
				<tr>
					<td><%=Translate.Translate("Resultater pr. side") %></td>
					<td><%=Gui.SpacListExt(prop.value("Searchv1PageSize"), "Searchv1PageSize", 1, 100, 1, "")%></td>
				</tr>
				<tr valign="top">
					<td><%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Frem") & "</em>" )%></td>
					<td><%= Gui.ButtonText("Searchv1ButtonForward", prop.Value("Searchv1ButtonForward"), prop.Value("Searchv1ButtonForwardPicture"), prop.Value("Searchv1ButtonForwardText"))%></td>
				</tr>
				<tr valign="top">
					<td><%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Tilbage") & "</em>" )%></td>
					<td><%=Gui.ButtonText("Searchv1ButtonBack", prop.Value("Searchv1ButtonBack"), prop.Value("Searchv1ButtonBackPicture"), prop.Value("Searchv1ButtonBackText"), True)%></td>
				</tr>
			</table>
		<%=Gui.GroupBoxEnd() %>
	</td>
</tr>
<tr>
	<td colspan="2">
		<%=Gui.GroupBoxStart(Translate.Translate("Templates")) %>
			<table cellpadding="2" cellspacing="0" border="0" width="100%">
				<colgroup>
					<col width="170px" />
					<col />
				</colgroup>
				<tr>
					<td><%=Translate.Translate("Søgeboks")%></td>
					<td><%=Gui.FileManager(prop.value("Searchv1TemplateSearch"), "Templates/Searchv1", "Searchv1TemplateSearch")%></td>
				</tr>
				<tr>
					<td><%=Translate.Translate("Intet resultat")%></td>
					<td><%=Gui.FileManager(prop.value("Searchv1TemplateNoresult"), "Templates/Searchv1", "Searchv1TemplateNoresult")%></td>
				</tr>
				<tr>
					<td><%=Translate.Translate("Liste")%></td>
					<td><%=Gui.FileManager(prop.value("Searchv1TemplateList"), "Templates/Searchv1", "Searchv1TemplateList")%></td>
				</tr>
				<tr>
					<td><%=Translate.Translate("Element")%></td>
					<td><%=Gui.FileManager(prop.value("Searchv1TemplateListElement"), "Templates/Searchv1", "Searchv1TemplateListElement")%></td>
				</tr>
			</table>
		<%=Gui.GroupBoxEnd() %>
	</td>
</tr>

<script>
    CheckeComSettings();
    initValidators();
    document.observe("dom:loaded", function () {
        var infoBlockElem = $("folderOutOfIndexCnt");
        $('FLDM_Searchv1FilesStartIn').on("change", function () {
            var path = this.value;
            new Ajax.Request(window.location.toString() + "&CMD=checkwsfilepath&path=" + path, {
                 method: 'get',
                 onComplete: function (transport) {
                     infoBlockElem.style.display = transport.status == 400 ? "block" : "none";
                 }
             });
        });
    });
    
</script>

<%
Translate.GetEditOnlineScript()
%>