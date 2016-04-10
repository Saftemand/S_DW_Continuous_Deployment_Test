<%@ Page Language="vb" ValidateRequest="false" AutoEventWireup="false" Codebehind="eCom_Catalog_Edit.aspx.vb" Inherits="Dynamicweb.Admin.eCom_Catalog_Edit" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>

<link rel="Stylesheet" type="text/css" href="/Admin/Module/eCom_Catalog/images/ObjectSelector.css" />
<script type="text/javascript" language="JavaScript" src="/Admin/Module/eCom_Catalog/dw7/images/functions.js"></script>
<script type="text/javascript" src="/Admin/Module/eCom_Catalog/dw7/images/AjaxAddInParameters.js"></script>
<script type="text/javascript" language="JavaScript" src="/Admin/Module/eCom_Catalog/dw7/js/ecomParagraph.js"></script>

<script type="text/javascript">

    var basePath = '/dw7';
    var groupTreeBasePath = '/dw7/Edit';

function ReturnSettings() {
    var obj = document.forms.paragraph_edit.Show;
	for (var i = 0; i < obj.length; i++) {
	    if (obj[i].checked) {
			GetSettings(obj[i]);
		}
	}
}

function GetSettings(obj) {
	switch (obj.value) {
	    case "List":
	        document.getElementById('ProductListBox').style.display = 'block';
	        document.getElementById('ProductBox').style.display = 'none';
	        document.getElementById('ProductIndexBox').style.display = 'none';

	        document.getElementById('GroupSelector').style.display = 'table-row';

	        document.getElementById('TemplateListTR').style.display = 'table-row';
	        document.getElementById('TemplateSearchTR').style.display = 'table-row';
	        document.getElementById('TemplateGrpTR').style.display = 'table-row';
	        document.getElementById('TemplateNoProdTR').style.display = 'table-row';
	        document.getElementById('ProdSorting').style.display = 'block';

	        document.getElementById('FilterSelectorDiv').style.display = 'block';
	        document.getElementById('ProductSearch').style.display = 'block';

	        document.getElementById('OptimizedEnableTR').style.display = 'table-row';
	        document.getElementById('OptimizedCacheEnableTR').style.display = 'table-row';
	        document.getElementById('OptimizedCacheDisplayDurationTR').style.display = 'table-row';

	        break;
	    case "Product":
	        document.getElementById('ProductListBox').style.display = "none";
	        document.getElementById('ProductBox').style.display = 'block';
	        document.getElementById('ProductIndexBox').style.display = 'none';

	        document.getElementById('GroupSelector').style.display = "none";

	        document.getElementById('TemplateListTR').style.display = "none";
	        document.getElementById('TemplateSearchTR').style.display = "none";
	        document.getElementById('TemplateGrpTR').style.display = "none";
	        //document.getElementById('TemplateNoProdTR').style.display = "none";
	        document.getElementById('ProdSorting').style.display = 'none';

	        document.getElementById('FilterSelectorDiv').style.display = 'block';
	        document.getElementById('ProductSearch').style.display = 'block';

	        document.getElementById('OptimizedEnableTR').style.display = 'table-row';
	        document.getElementById('OptimizedCacheEnableTR').style.display = 'table-row';
	        document.getElementById('OptimizedCacheDisplayDurationTR').style.display = 'table-row';

	        break;
	    case "Index":
	        document.getElementById('ProductListBox').style.display = 'none';
	        document.getElementById('ProductBox').style.display = 'none';
	        document.getElementById('ProductIndexBox').style.display = 'block';

	        document.getElementById('GroupSelector').style.display = 'none';

	        document.getElementById('TemplateListTR').style.display = 'table-row';
	        document.getElementById('TemplateSearchTR').style.display = 'table-row';
	        document.getElementById('TemplateGrpTR').style.display = 'table-row';
	        document.getElementById('TemplateNoProdTR').style.display = 'table-row';
	        document.getElementById('ProdSorting').style.display = 'block';

	        document.getElementById('FilterSelectorDiv').style.display = 'none';
	        document.getElementById('ProductSearch').style.display = 'none';

	        document.getElementById('OptimizedEnableTR').style.display = 'none';
	        document.getElementById('OptimizedCacheEnableTR').style.display = 'none';
	        document.getElementById('OptimizedCacheDisplayDurationTR').style.display = 'none';

	        break;
        default:
			//Nothing	
    }    
}


function Toggle_UseAltImage(obj) {
    if (obj.checked) {
        document.getElementById('UseAltImageSection').style.display = 'table';
    } else {
        document.getElementById('UseAltImageSection').style.display = 'none';
    }
}

function Toggle_UseCatalog(obj) {
    if (obj.checked) {
        document.getElementById('PrintPublisherTable').style.display = 'table';
    } else {
        document.getElementById('PrintPublisherTable').style.display = 'none';
    }
}


function ChangeTemplateSearch() {
	var obj = document.getElementById('TemplateSearchBox');

	if (obj.checked) {
	    document.getElementById('TemplateSearchDiv').style.display = "block";
	} else {
	    document.getElementById('TemplateSearchDiv').style.display = "none";
	}
}

function ChangeTemplateGroups() {
	var obj = document.getElementById('ShowGroups');

	if (obj.checked) {
	    document.getElementById('TemplateGroupDiv').style.display = "block";
	} else {
	    document.getElementById('TemplateGroupDiv').style.display = "none";
	}
}


function AddProduct(fieldName) {
	if (fieldName != "") {
		var caller = 'opener.document.forms.paragraph_edit.'+ fieldName;
		window.open("/Admin/Module/eCom_Catalog" + groupTreeBasePath + "/EcomGroupTree.aspx?CMD=ShowProd&AddCaller=1&caller=" + caller, "", "displayWindow,width=460,height=400,scrollbars=no");
	}	
}

function RemoveProduct(fieldName) {
	if (fieldName != "") {
	    document.getElementById("ID_" + fieldName).value = '';
	    document.getElementById("Variant_" + fieldName).value = '';
		document.getElementById('Name_' + fieldName).value = '<%=Translate.JsTranslate("No product selected") %>';
		
	}	
}

function togglePagedQueriesOptionsVisibility(isVisible) {
    var chk = null, row = null;
    
    if (typeof (isVisible) == 'undefined' || isVisible == null) {
        chk = document.getElementById('chkPagedQueries');
        if (chk != null) {
            isVisible = chk.checked;
        }
    }

    row = document.getElementById('rowForcePagedQueries');
    if (row) {
        row.style.display = isVisible ? '' : 'none';
    }
}

function checkDisplayCachingExpiration(checkbox) {
    var expInput = document.getElementById("FrontendCachingExpiration");
    if (checkbox.checked && (expInput.value == "" || expInput.value == "0"))
        expInput.value = "1";
}
</script>

<style type="text/css">

    .infobar .information{
        background: #DDECFF; 
        border: 1px solid #00529B; 
        width: 100%;
    }

</style>

<input type="hidden" id="eCom_Catalog_settings" name="eCom_Catalog_settings" value="DisableProductDetail, IgnoreUrlParameters, UseFrontendCaching, FrontendCachingExpiration, UseOptimizedEcomFrontend, MetaFirstPageAsCanonical, Show, ProductAndGroupsSelector, IncludeSubgroups, PageSize, PageSizeForward, PageSizeForwardPicture, PageSizeForwardText, PageSizeBack, PageSizeBackPicture, PageSizeBackText, SortBy, SortOrder, ProductListTemplate, SearchTemplate, GroupListTemplate, ProductTemplate, ImageFolder, AlternativePictureBox, ID_ProductID, VariantID_ProductID, TemplateSearchBox, ShowGroups, ShortDescLength, NoProductTemplate, RemoveDuplicates, ImagePatternS, ImagePatternM, ImagePatternL, AltImagePatterns, CompareTemplate, ShowOnParagraph, SearchVariants, AlwaysUseLucene, SearchShop, SearchSubGroups, PPFirstPageTemplate, PPLastPageTemplate, PPRegularPageTemplate, PPHeaderTemplate, PPFooterTemplate,PPEmailFormTemplate,PPEmailTemplate, PPUsePrintPublisher, WildcardSearchOnly, RelevanceSorting, EnablePagedQueries, ForcePagedQueries, MaxQuerySuggestions, FreeTextSearchField, HideEmptyOptions, IncludeExtendedVariants, IndexQuery, FacetGroups, ShowFacetOptionsWithNoResults" />

<table width="100%" id="Table1">
	<tr>
		<td>
			<dw:moduleheader id="ModuleHeader1" runat="server" modulesystemname="eCom_Catalog"></dw:moduleheader>
		</td>
	</tr>
	<tr>
		<td>
			<dw:GroupBox runat="server" Title="Indstillinger" DoTranslation="true">
				<table cellpadding="2" cellspacing="0" border="0">
					<tr>
						<td width="170" valign="top"><dw:TranslateLabel runat="server" text="Vis" /></td>
						<td>
							<input type="radio" runat="server" id="ShowProduct" name="Show" value="Product" onclick="GetSettings(this);" />
							<label for="ShowProduct"><dw:TranslateLabel runat="server" text="Produkt" /></label><br />
							
							<input type="radio" runat="server" id="ShowList" name="Show" value="List" onclick="GetSettings(this);" />
							<label for="ShowList"><dw:TranslateLabel runat="server" text="Varegrupper" /></label><br />
							
							<input type="radio" runat="server" id="ShowIndex" name="Show" value="Index" onclick="GetSettings(this);" />
							<label for="ShowIndex"><dw:TranslateLabel runat="server" text="Index" /></label><br />
						</td>
					</tr>
				</table>
			</dw:GroupBox>			

			<div id="ProductListBox">
			<dw:groupboxstart id="Groupboxstart2" runat="server" title="Grupper"></dw:groupboxstart>
			<table cellpadding="2" cellspacing="0" border="0"  width="100%">
				<!--
				<tr valign=top>
					<td><%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Frem") & "</em>" )%></td>
					<td valign="top"><%=Gui.ButtonText("PageSizeForward", properties.Value("PageSizeForward"), properties.Value("PageSizeForwardPicture"), properties.Value("PageSizeForwardText"))%></td>
				</tr>
				<tr valign=top>
					<td><%=Translate.Translate("%% knap", "%%", "<em>" & Translate.Translate("Tilbage") & "</em>" )%></td>
					<td valign="top"><%=Gui.ButtonText("PageSizeBack", properties.Value("PageSizeBack"), properties.Value("PageSizeBackPicture"), properties.Value("PageSizeBackText"))%></td>
				</tr>
                -->
				<tr id="GroupSelector" style="display:table-row;">
					<td valign="top" width="170"><%=Translate.Translate("Varegrupper")%></td>
					<td>
                        <de:ProductsAndGroupsSelector runat="server" OnlyGroups="true" ShowSearches="true" ID="ProductAndGroupsSelector" CallerForm="paragraph_edit" Width="250px" Height="100px" />
						<input type="checkbox" runat="server" id="IncludeSubgroups" name="IncludeSubgroups" value="1" />
						<label for="IncludeSubgroups">
						     <dw:TranslateLabel ID="TranslateLabel2" runat="server" Text="Include subgroups" />
						</label>
					</td>
				</tr>
			</table>
			<dw:groupboxend id="Groupboxend2" runat="server"></dw:groupboxend>
			</div>
			
			<div id="ProductBox" style="display:block;">
				<dw:GroupBox runat="server" Title="Visning" DoTranslation="True">
				<table cellpadding="2" cellspacing="0" border="0">
					<tr>
						<td width="170"><dw:TranslateLabel id="Translatelabel27" runat="server" Text="Produkt" /></td>
						<td>
							<input type="hidden" id="ID_ProductID" runat="server" />
                            <input type="hidden" id="VariantID_ProductID" runat="server" />
							<input type="text" id="Name_ProductID" class="std" runat="server" />&nbsp;
							<img src="/Admin/images/Icons/Page_int.gif" onclick="javascript:AddProduct('DW_REPLACE_ProductID');" align="absMiddle" class="H" alt="<%=Translate.JSTranslate("Produkter")%>" />&nbsp;
							<img src="/Admin/images/Icons/Page_Decline.gif" onclick="javascript:RemoveProduct('ProductID');" align="absMiddle" class="H" alt="<%=Translate.JSTranslate("Slet")%>" />
						</td>
					</tr>
				</table>
				</dw:GroupBox>
			</div>

            <div id="ProductIndexBox">
                <dw:GroupBox runat="server" Title="Index">
                    <table>
                        <tr>
                            <td style="width: 166px;"><dw:TranslateLabel runat="server" Text="Query" /></td>
                            <td>
                                <asp:Literal runat="server" id="QuerySelectLiteral"></asp:Literal>
                               
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 166px; vertical-align: top;"><dw:TranslateLabel runat="server" Text="Facet groups" /></td>
                            <td id="selectionBoxContainer">
                                <dw:SelectionBox runat="server"
                                                 ID="selectFacets" />
                            </td>
                            <input type="hidden" id="facets" name="FacetGroups" value="" />
                        </tr>
                        <tr>
						    <td></td>
						    <td>
						        <input type="checkbox" runat="server" id="ShowFacetOptionsWithNoResults" name="ShowFacetOptionsWithNoResults" value="1" />
						        <label for="ShowFacetOptionsWithNoResults">
						            <dw:TranslateLabel runat="server" Text="Show facet options with no results" />
						        </label>
						    </td>
						</tr>
                    </table>
                </dw:GroupBox>
            </div>
	
			<div id="ProdSorting" style="display:block;">
				<dw:GroupBox runat="server" title="Visning" DoTranslation="true">
					<table cellpadding="2" cellspacing="0" border="0"  width="100%">
						<colgroup>
							<col style="width:170px; " />
							<col />
						</colgroup>
				        <tr>
					        <td><%=Translate.Translate("Varer pr. side")%></td>
					        <td>
                                <input type="text" runat="server" id="PageSize" name="PageSize" value="0" class="std" style="width: 50px;" />
					        </td>
				        </tr>
				        <tr>
					        <td><dw:translatelabel id="Translatelabel5" runat="server" text="Teaser tekst" /></td>
					        <td><%=Translate.Translate("Vis de første %% tegn", "%%", "<input type=text ID=""ShortDescLength"" name=""ShortDescLength"" runat=server class=""stdNoWidth"" size=""6"" value=""" & ParagraphSettings.ShortDescLength.ToString & """>")%></td>
				        </tr>
						<tr>
							<td><dw:TranslateLabel id="Translatelabel19" runat="server" text="Sorter efter" /></td>
							<td>								
    							<asp:Literal id="SortEnum" runat="server"></asp:Literal>
							</td>
						</tr>
						

						<tr>
							<td style="vertical-align:top;">
							    <dw:TranslateLabel runat="server" text="Sorteringsrækkefølge" />
							</td>
							<td>
								<input type="radio" runat="server" id="SortOrderASC" name="SortOrder" value="ASC" />
								<label for="SortOrderASC"><dw:TranslateLabel runat="server" text="Stigende" /></label><br />
								
								<input type="radio" runat="server" id="SortOrderDESC" name="SortOrder" value="DESC" />
								<label for="SortOrderDESC"><dw:TranslateLabel runat="server" text="Faldende" /></label><br />
							</td>
						</tr>
						
						<tr>
						    <td />
						    <td>
						        <input type="checkbox" runat="server" id="RemoveDuplicates" name="RemoveDuplicates" value="1" />
						        <label for="RemoveDuplicates">
						            <dw:TranslateLabel runat="server" Text="Remove duplicate products" />
						        </label>
						    </td>
						</tr>	
						
					</table>
				</dw:GroupBox>
			</div>
			
			
			<%=Gui.GroupboxStart(strUseAltImage)%>&nbsp;
			<input id="ImagePatternInit" name="ImagePatternInit" runat="server" type="hidden" value="" />
			<input id="AltImagePatterns" name="AltImagePatterns" runat="server" type="hidden" value="" />
			
			<table id="UseAltImageSection" cellpadding="2" cellspacing="0" border="0" style="<%=IIF(ParagraphSettings.AlternativePictureBox = 1, "display:table;", "display:none;")%>">
			<tbody>
				<tr id="AlternativePictureA" style="display:table-row;">
					<td width="170"><dw:translatelabel id="Translatelabel1" runat="server" text="Billed mappe" /></td>
					<td><dw:foldermanager id="ImageFolder" name="ImageFolder" runat="server"></dw:foldermanager></td>
				</tr>
				<tr id="AlternativePictureB" style="display:table-row;">
					<td height="5" colspan="2" style="font-weight:bold;"><%=Translate.Translate("Filnavnsmønster")%></td>
				</tr>
				<tr id="AlternativePictureC" style="display:table-row;">
					<td width="170"><dw:translatelabel id="Translatelabel10" runat="server" text="Lille" /></td>
					<td><input type="text" runat="server" name="ImagePatternS" id="ImagePatternS" class="std" value="" /></td>
				</tr>
				<tr id="AlternativePictureD" style="display:table-row;">
					<td><dw:translatelabel id="Translatelabel24" runat="server" text="Medium" /></td>
					<td><input type="text" runat="server" name="ImagePatternM" id="ImagePatternM" class="std" value="" /></td>
				</tr>
				<tr id="AlternativePictureE" style="display:table-row;">
					<td><dw:translatelabel id="Translatelabel25" runat="server" text="Stor" /></td>
					<td><input type="text" runat="server" name="ImagePatternL" id="ImagePatternL" class="std" value="" /></td>
				</tr>

				<tr>
				    <td colspan="2">
					    <table border="0" cellpadding="0" cellspacing="0" width="100%">
					    <thead>
					        <tr id="AlternativePictureHeader" style="display:none;">
					            <td width="170" style="font-weight:bold;"><%=Translate.Translate("User defined patterns")%></td>
					            <td></td>
					            <td width="50" style="font-weight:bold;"><%=Translate.Translate("Width")%></td>
					            <td width="50" style="font-weight:bold;"><%=Translate.Translate("Height")%></td>
					            <td width="20"></td>
					        </tr>
					    </thead>
					    <tbody>
					        <tr id="AlternativePicture" style="display:none;">
					            <td><input name="ImagePatternName" id="ImagePatternName" type="text" class="std" style="width:100px;" value="" /></td>
					            <td style="padding-left:2px; padding-bottom:2px;"><input name="ImagePattern" id="ImagePattern" type="text"  class="std" value="" /></td>
					            <td style="padding-left:2px;"><input name="ImagePatternWidth" id="ImagePatternWidth" type="text"  class="std" style="width:40px;" value="" /></td>
					            <td><input name="ImagePatternHeight" id="ImagePatternHeight" type="text"  class="std" style="width:40px;" value="" /></td>
					            <td><img id="imagePatternDelete" alt='<%=Translate.Translate("Delete image")%>' onclick="if(confirm('<%=Translate.JsTranslate("Delete image pattern?")%>')){ backend.deleteImage(this); };" src="/admin/Images/Ribbon/Icons/Small/Delete.png" style="cursor:pointer;" /></td>
					        </tr>
					        <tr id="imagePatternBottom" style="display:none;">
					            <td colspan="5"></td>
					        </tr>
					    </tbody>
					    </table>
					</td>
				</tr>
				<tr id="addImagePattern">
				    <td>
				        <div onclick="backend.addPattern();" style="cursor:pointer; vertical-align: top;">
				            <img  src="/admin/images/ribbon/icons/small/View_add.png" alt="" />Add pattern
				        </div>
				    </td>
				</tr>
				</tbody>
			</table>
			<%=Gui.GroupboxEnd%>

			<div id="Templates" style="display:block;">
			<dw:groupboxstart id="Groupboxstart5" runat="server" title="Templates"></dw:groupboxstart>
			<table cellpadding="2" cellspacing="0" border="0">
				<tr id="TemplateListTR" style="display:table-row;">
					<td width="170" valign="top"><%=Translate.Translate("Liste")%></td>
					<td><dw:FileManager runat="server" id="ProductListTemplate" Folder="Templates/eCom/Productlist/" FullPath="True"></dw:FileManager></td>
				</tr>
				<tr id="TemplateGrpTR" style="display:table-row;">
					<td valign="top"><%=Translate.Translate("Grupper")%></td>
					<td>
						<input type="checkbox" runat="server" id="ShowGroups" name="ShowGroups" value="True" onclick="ChangeTemplateGroups();" /><br />
						<div id="TemplateGroupDiv" style="display:none;">
						<dw:FileManager runat="server" id="GroupListTemplate" Folder="Templates/eCom/GroupList/" FullPath="True"></dw:FileManager>
						</div>
					</td>
				</tr>
				<tr id="TemplateProdTR" style="display:table-row;">
					<td width="170" valign="top"><%=Translate.Translate("Vare")%></td>
					<td><dw:FileManager runat="server" id="ProductTemplate" Folder="Templates/eCom/Product/" FullPath="True"></dw:FileManager></td>					
				</tr>
				<%If Base.HasAccess("eCom_Search", "") Then%>
				<tr id="TemplateSearchTR" style="display:table-row;">
					<td valign="top"><%=Translate.Translate("Søgning")%></td>
					<td>
					<input type="checkbox" runat="server" id="TemplateSearchBox" name="TemplateSearchBox" value="1" onclick="ChangeTemplateSearch();" /><br />
					<div id="TemplateSearchDiv" style="display:none;">
					<dw:FileManager runat="server" id="SearchTemplate" Folder="Templates/eCom/Search/" FullPath="True"></dw:FileManager>
					</div>
					</td>
				</tr>
				<%End If%>

                <%If Base.HasAccess("eCom_PowerPack", "") Then%>
				<tr id="TemplateCompareTR" style="display:table-row;">
					<td width="170" valign="top"><%= Translate.Translate("Compare")%></td>
					<td><dw:FileManager runat="server" id="CompareTemplate" Folder="Templates/eCom/Productlist/" FullPath="True"></dw:FileManager></td>					
				</tr>
                <%End If%>

				<tr id="TemplateNoProdTR" style="display:table-row;">
					<td valign="top"><%=Translate.Translate("Ingen produkter fundet")%></td>
					<td><dw:FileManager runat="server" id="NoProductTemplate" Folder="Templates/eCom/Productlist/" FullPath="True"></dw:FileManager></td>
				</tr>
			</table>
			<dw:groupboxend id="Groupboxend5" runat="server"></dw:groupboxend>
			</div>

<!-- Settings for "print publishing": dropdowns with templates for header, footer, body (with products), first page, last page, regular page. -->
			<div id="PrintPublisher" style="display:block;">
            <%= Gui.GroupBoxStart(strUseCatalog)%>&nbsp;
			<table cellpadding="2" cellspacing="0" border="0" id="PrintPublisherTable" style="<%=styleDisplay %>" >
				<tr id="FirstPage" style="display:table-row;">
					<td width="170" valign="top"><%= Translate.Translate("First Page")%></td>
					<td><dw:FileManager runat="server" id="PPFirstPageTemplate" Folder="Templates/eCom/CatalogPublishing/" FullPath="True"></dw:FileManager></td>
				</tr>
				<tr id="LastPage" style="display:table-row;">
					<td width="170" valign="top"><%= Translate.Translate("Last Page")%></td>
					<td><dw:FileManager runat="server" id="PPLastPageTemplate" Folder="Templates/eCom/CatalogPublishing/" FullPath="True"></dw:FileManager></td>
				</tr>
				<tr id="RegularPage" style="display:table-row;">
					<td width="170" valign="top"><%= Translate.Translate("Regular Page")%></td>
					<td><dw:FileManager runat="server" id="PPRegularPageTemplate" Folder="Templates/eCom/CatalogPublishing/" FullPath="True"></dw:FileManager></td>
				</tr>
				<tr id="Header" style="display:table-row;">
					<td width="170" valign="top"><%= Translate.Translate("Header")%></td>
					<td><dw:FileManager runat="server" id="PPHeaderTemplate" Folder="Templates/eCom/CatalogPublishing/" FullPath="True"></dw:FileManager></td>
				</tr>
				<tr id="Footer" style="display:table-row;">
					<td width="170" valign="top"><%= Translate.Translate("Footer")%></td>
					<td><dw:FileManager runat="server" id="PPFooterTemplate" Folder="Templates/eCom/CatalogPublishing/" FullPath="True"></dw:FileManager></td>
				</tr>
                <tr id="Tr2" style="display:table-row;">
					<td width="170" valign="top"><%= Translate.Translate("Email Form")%></td>
					<td><dw:FileManager runat="server" id="PPEmailFormTemplate" Folder="Templates/eCom/CatalogPublishing/Email/" FullPath="True"></dw:FileManager></td>
				</tr>
                <tr id="Tr1" style="display:table-row;">
					<td width="170" valign="top"><%= Translate.Translate("Email")%></td>
					<td><dw:FileManager runat="server" id="PPEmailTemplate" Folder="Templates/eCom/CatalogPublishing/Email/" FullPath="True"></dw:FileManager></td>
				</tr>

			</table>
            <%=Gui.GroupboxEnd%>
			</div>
<!-- -->
            <%If Base.HasAccess("eCom_SearchExtended", "") Then%>
            <div id="FilterSelectorDiv">
                <dw:GroupBox ID="GroupBox1" runat="server" Title="Advanced searching" DoTranslation="true">
                    <table cellpadding="2" cellspacing="0" border="0">
					<tr>
						<td width="170" style="vertical-align: top;"><dw:TranslateLabel runat="server" Text="Select filter groups" /></td>
						<td>
                            <dw:Infobar ID="infoAssortments" Type="Information" Message="Assortments are enabled. All filters groups will filter using Assortments" UseInlineStyles="false" Visible="false" runat="server" />
                            <asp:Literal id="FilterProviderList" runat="server"></asp:Literal>
						</td>
					</tr>
					<tr>
						<td width="170"></td>
						<td>
                            <input type="checkbox" id="chkAlwaysUseLucene" name="AlwaysUseLucene" value="True" <%=Base.IIf(Base.ChkBoolean(properties.Value("AlwaysUseLucene")), "checked='checked'", "")%> />
                            <label for="chkAlwaysUseLucene"><dw:TranslateLabel id="lbAlwaysUseLucene" Text="Use Lucene to retrieve products regardless of presence of filters" runat="server" /></label>
						</td>
					</tr>
                    <tr><td>&nbsp;</td></tr>
                    <%If Base.IsModuleInstalled("eCom_MultiShopAdvanced") Then%>
                    <tr>
                        <td><dw:TranslateLabel Text="Limit search to shop" runat="server" /></td>
                        <td>
                            <select id="SearchShop" name="SearchShop" runat="server" size="1" class="std"></select>
                        </td>
                    </tr>
                    <%End If%>
                    <tr>
                        <td><dw:TranslateLabel id="lbGroupContext" Text="When inside a group" runat="server" /></td>
                        <td>
                            <input type="checkbox" id="chkSearchSubGroups" name="SearchSubGroups" value="True" <%=Base.IIf(Base.ChkBoolean(properties.Value("SearchSubGroups")), "checked='checked'", "")%> />
                            <label for="chkSearchSubGroups"><dw:TranslateLabel id="lbSearchSubGroups" Text="Search inside all child groups" runat="server" /></label>
                        </td>
                    </tr>
                    <tr>
                        <td><dw:TranslateLabel id="lbInstantSearch" Text="Free text search" runat="server" /></td>
                        <td>
                            <input type="checkbox" id="chkWildcardSearchOnly" name="WildcardSearchOnly" value="True" <%=Base.IIf(Base.ChkBoolean(properties.Value("WildcardSearchOnly")), "checked='checked'", "")%> />
                            <label for="chkWildcardSearchOnly"><dw:TranslateLabel id="lbWildcardSearchOnly" Text="Always perform wildcard searches" runat="server" /></label>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input type="checkbox" id="chkRelevanceSorting" name="RelevanceSorting" value="True" <%=Base.IIf(Base.ChkBoolean(properties.Value("RelevanceSorting")), "checked='checked'", "")%> />
                            <label for="chkRelevanceSorting"><dw:TranslateLabel id="lbRelevanceSorting" Text="Sort searches by relevance" runat="server" /></label>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top" style="padding-top: 4px;"><dw:TranslateLabel id="lbPagedQueries" Text="Paged queries" runat="server" /></td>
                        <td>
                            <table cellspacing="0" cellpadding="0" border="0">
                                <tr>
                                    <td>
                                        <input type="checkbox" id="chkPagedQueries" name="EnablePagedQueries" value="True" <%=Base.IIf(Base.ChkBoolean(properties.Value("EnablePagedQueries")), "checked='checked'", "")%> onclick="togglePagedQueriesOptionsVisibility();" />
                                        <label for="chkPagedQueries"><dw:TranslateLabel id="lbPagedQueriesEnable" Text="Enable" runat="server" /></label>
                                    </td>
                                    <td>
                                        <img src="/Admin/Images/Ribbon/Icons/Small/warning.png" 
                                            style="border: none; margin-left: 5px; margin-top: 2px; cursor: help"
                                            title="<%=Translate.JsTranslate("Please check the documentation before changing these values.")%>" />
                                    </td>
                                </tr>
                            </table>
                            <table cellspacing="0" cellpadding="0" border="0" id="rowForcePagedQueries" style="display:">
                                <tr>
                                    <td colspan="2">
                                        <input type="checkbox" id="chkForcePagedQueries" name="ForcePagedQueries" value="True" <%=Base.IIf(Base.ChkBoolean(properties.Value("ForcePagedQueries")), "checked='checked'", "")%> />
                                        <label for="chkForcePagedQueries"><dw:TranslateLabel id="lbForcePagedQueries" Text="Force (do not validate the code)" runat="server" /></label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td><dw:TranslateLabel id="lbHideEmptyOptions" Text="Empty options" runat="server" /></td>
                        <td>
                            <input type="checkbox" id="chkHideEmptyOptions" name="HideEmptyOptions" value="True" <%=Base.IIf(Base.ChkBoolean(properties.Value("HideEmptyOptions")), "checked='checked'", "")%> />
                            <label for="chkHideEmptyOptions"><dw:TranslateLabel id="lbHideEmptyOptionsLabel" Text="Do not render" runat="server" /></label>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <td valign="top">
                            <dw:TranslateLabel id="lbSearchVariants" text="Variant visibility" runat="server" />
                        </td>
                        <td>
                            <table cellspacing="0" cellpadding="0" border="0">
                                <tr>
                                    <td valign="middle">
                                        <input type="radio" id="chkSearchVariants0" name="SearchVariants" value="0" <%=Base.IIf(Base.ChkNumber(properties.Value("SearchVariants")) = 0, "checked='checked'", "")%> />
                                        <label for="chkSearchVariants0"><dw:TranslateLabel id="lbSearchVariants0" Text="Show" runat="server" /></label>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="middle">
                                        <input type="radio" id="chkSearchVariants1" name="SearchVariants" value="1" <%=Base.IIf(Base.ChkNumber(properties.Value("SearchVariants")) = 1, "checked='checked'", "")%> />
                                        <label for="chkSearchVariants1"><dw:TranslateLabel id="lbSearchVariants1" Text="Hide" runat="server" /></label>
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="middle">
                                        <input type="radio" id="chkSearchVariants2" name="SearchVariants" value="2" <%=Base.IIf(Base.ChkNumber(properties.Value("SearchVariants")) = 2, "checked='checked'", "")%> />
                                        <label for="chkSearchVariants2"><dw:TranslateLabel id="lbSearchVariants2" Text="Group by main product" runat="server" /></label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr>
                        <td valign="top">
                            <dw:TranslateLabel id="lbMaxQuerySuggestions" text="Max. query suggestions" runat="server" />
                        </td>
                        <td>
                            <input type="text" maxlength="6" name="MaxQuerySuggestions" class="std" style="width: 50px; display: block;" value="<%=properties.Value("MaxQuerySuggestions")%>" />
                        </td>
                      </tr>
                      <tr>
                        <td valign="top">
                            <dw:TranslateLabel id="lbDefaultSearchField" Text="Default search field" runat="server" />
                        </td>
                        <td>
                            <asp:Literal id="litFieldsList" runat="server" />
                        </td>
                      </tr>
                    </table>
                </dw:GroupBox>
            </div>
            <%End If%>

			<div id="ProductSearch">
				<dw:GroupBox runat="server" Title="Ecommerce search" DoTranslation="True">
				<table cellpadding="2" cellspacing="0" border="0">
						<tr>
						    <td style="width:170px;">
                                <dw:TranslateLabel runat="server" text="Show" />
                            </td>
						    <td>
						        <input type="checkbox" runat="server" id="IncludeExtendedVariants" name="IncludeExtendedVariants" value="True" />
						        <label for="IncludeExtendedVariants">
						            <dw:TranslateLabel runat="server" Text="Include extended variants" />
						        </label>
						    </td>
						</tr>	
				</table>
				</dw:GroupBox>
			</div>

            <div id="AdditionalSettings" style="display: block;">
                <dw:GroupBox ID="gbSettings" runat="server" Title="Additional settings">
                    <table cellpadding="2" cellspacing="0" border="0">
						 <tr>
                            <td width="170" valign="top"></td>
                            <td>
                                <input type="checkbox" runat="server" id="IgnoreUrlParameters" name="IgnoreUrlParameters" value="True" />
                                <label for="IgnoreUrlParameters"><dw:TranslateLabel runat="server" text="Ignore URL parameters" /></label><br />
                            </td>
                        </tr>
                         
                        <tr id="OptimizedEnableTR">
                            <td width="170" valign="top"></td>
                            <td>
                                <input type="checkbox" runat="server" id="UseOptimizedEcomFrontend" name="UseOptimizedEcomFrontend" value="True" />
                                <input type="hidden" name="UseOptimizedEcomFrontend" value="dummy" />
                                <label for="UseOptimizedEcomFrontend"><dw:TranslateLabel runat="server" text="Enable optimized product retrieval" /></label><br />
                            </td>
                        </tr>
                        <tr id="OptimizedCacheEnableTR">
                            <td width="170" valign="top"></td>
                            <td>
                                <input type="checkbox" runat="server" id="UseFrontendCaching" name="UseFrontendCaching" value="True" onchange="checkDisplayCachingExpiration(this);" />
                                <label for="UseFrontendCaching"><dw:TranslateLabel runat="server" text="Enable display caching" /></label><br />
                            </td>
                        </tr>
                        <tr id="OptimizedCacheDisplayDurationTR">
                            <td width="170" valign="top"><dw:TranslateLabel runat="server" text="Display caching expiration" /></td>
                            <td>
                                <input type="text" runat="server" id="FrontendCachingExpiration" name="FrontendCachingExpiration" value="0" class="std" style="width: 50px;" />
                            </td>
                        </tr>

					    <tr>
						    <td width="170" valign="top"></td>
						    <td>
							    <input type="checkbox" runat="server" id="MetaFirstPageAsCanonical" name="MetaFirstPageAsCanonical" value="True" />
							    <label for="MetaFirstPageAsCanonical"><dw:TranslateLabel runat="server" text="Use first page in list as canonical URL" /></label><br />
						    </td>
					    </tr>
				        <tr id="ShowOnParagraphTR" style="display:table-row;">
					        <td width="170" valign="top"><%= Translate.Translate("Show on paragraph")%></td>
					        <td><dw:LinkManager runat="server" id="ShowOnParagraph" EnablePageSelector="False" DisableFileArchive="True"></dw:LinkManager></td>					
				        </tr>
                         <tr>
                            <td width="170" valign="top"></td>
                            <td>
                                <input type="checkbox" runat="server" id="DisableProductDetail" name="DisableProductDetail" value="True" />
                                <label for="DisableProductDetail"><dw:TranslateLabel runat="server" text="Do not allow product detail (404)" /></label><br />
                            </td>
                        </tr>
                    </table>
                </dw:GroupBox>
            </div>
		</td>
	</tr>
</table>

<script type="text/javascript">
    function loadFacetSelector() {
        var querySelector = document.getElementById("IndexQuery");
        var query = querySelector[querySelector.selectedIndex];
        var url = "/Admin/Module/eCom_Catalog/eCom_Catalog_Edit.aspx?cmd=GetFacetsForSelectionBox&query=" + encodeURIComponent(query.value);

        new Ajax.Request(url, {
            method: 'get',
            onSuccess: function (response) {
                document.getElementById("selectionBoxContainer").innerHTML = response.responseText;
                SelectionBox.setNoDataLeft("selectFacets");
                SelectionBox.setNoDataRight("selectFacets");
                serializeFacets();
            }
        });
    }

    function serializeFacets() {
        var facets = SelectionBox.getElementsRightAsArray("selectFacets");
        var values = "";

        for (var i = 0; i < facets.length; i++) {
            if (i > 0)
                values += ",";
            values += facets[i];
        }

        document.getElementById("facets").value = values;
    }

    backend.initPatternImages();
    ReturnSettings();
    ChangeTemplateSearch();
    ChangeTemplateGroups();
    togglePagedQueriesOptionsVisibility();

    serializeFacets();
    SelectionBox.setNoDataLeft("selectFacets");
    SelectionBox.setNoDataRight("selectFacets");
</script>