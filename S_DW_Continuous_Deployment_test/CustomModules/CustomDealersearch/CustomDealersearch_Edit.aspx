<%@ Page AutoEventWireup="true" Codebehind="CustomDealersearch_Edit.aspx.cs" Inherits="CustomDealersearch_Edit" Language="C#" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<dw:ModuleHeader ID="ModuleHeader1" runat="server" ModuleSystemName="CustomDealersearch" />
<dw:ModuleSettings id="ModuleSettings1" runat="server" ModuleSystemName="CustomDealersearch" Value="SortBy, SortOrder, SearchTemplate, ListTemplate, ElementTemplate, CategoryID" />
<table border="0" cellpadding="0" cellspacing="0" width="598">
	<tr>
		<td>
			<dw:GroupBoxStart ID="GroupBoxStart1" runat="server" Title="Sorting" />
			<table cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td style="width:170px;" valign="top">Sort by</td>
					<td>
						<dw:RadioButton ID="SortByDealerSearchDealerName" runat="server" FieldName="SortBy" FieldValue="DealerSearchDealerName" />&nbsp;<label for="SortByDealerSearchDealerName">Name</label><br />
						<dw:RadioButton ID="SortByDealerSearchDealerAdress" runat="server" FieldName="SortBy" FieldValue="DealerSearchDealerAdress" />&nbsp;<label for="SortByDealerSearchDealerAdress">Address</label><br />
						<dw:RadioButton ID="SortByDealerSearchDealerZip" runat="server" FieldName="SortBy" FieldValue="DealerSearchDealerZip" />&nbsp;<label for="SortByDealerSearchDealerZip">Zip</label><br />
						<dw:RadioButton ID="SortByDealerSearchDealerCity" runat="server" FieldName="SortBy" FieldValue="DealerSearchDealerCity" />&nbsp;<label for="SortByDealerSearchDealerCity">City</label><br />
						<dw:RadioButton ID="SortByDealerSearchDealerCountry" runat="server" FieldName="SortBy" FieldValue="DealerSearchDealerCountry" />&nbsp;<label for="SortByDealerSearchDealerCountry">Country</label>
					</td>
				</tr>
				<tr>
					<td valign="top">Sort order</td>
					<td>
						<dw:RadioButton ID="SortOrderASC" runat="server" FieldName="SortOrder" FieldValue="ASC" />&nbsp;<label for="SortOrderASC">Ascending</label><br />
						<dw:RadioButton ID="SortOrderDESC" runat="server" FieldName="SortOrder" FieldValue="DESC" />&nbsp;<label for="SortOrderDESC">Descending</label>
					</td>
				</tr>
			</table>
			<dw:GroupBoxEnd ID="GroupBoxEnd1" runat="server" />

			<dw:GroupBoxStart ID="GroupBoxStart2" runat="server" Title="Templates" />
			<table cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td style="width:170px">Search</td>
					<td>
						<dw:FileManager ID="SearchTemplate" runat="server" Folder="Templates/CustomDealersearch/Search" Name="SearchTemplate" />
					</td>
				</tr>
				<tr>
					<td>List</td>
					<td>
						<dw:FileManager ID="ListTemplate" runat="server" Folder="Templates/CustomDealersearch/List" Name="ListTemplate" />
					</td>
				</tr>
				<tr>
					<td>Show element</td>
					<td>
						<dw:FileManager ID="ElementTemplate" runat="server" Folder="Templates/CustomDealersearch/Element" Name="ElementTemplate" />
					</td>
				</tr>
			</table>
			<dw:GroupBoxEnd ID="GroupBoxEnd2" runat="server" />
			
			<dw:GroupBoxStart ID="GroupBoxStart3" runat="server" Title="Categories" />
			<table cellpadding="2" cellspacing="0" border="0">
				<tr>
					<td style="width:170px;"></td>
					<td id="CategoryCell" runat="server">
					</td>
				</tr>
			</table>
			<dw:GroupBoxEnd ID="GroupBoxEnd3" runat="server" />

		</td>
	</tr>
</table>