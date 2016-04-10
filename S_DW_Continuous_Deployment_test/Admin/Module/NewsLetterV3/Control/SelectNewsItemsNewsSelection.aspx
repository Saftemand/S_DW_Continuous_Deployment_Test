<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SelectNewsItemsNewsSelection.aspx.vb" Inherits="Dynamicweb.Admin.NewsLetterV3.SelectNewsItemsNewsSelection" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="STYLESHEET" type="text/css" href="/Admin/Stylesheet.css" />
    <dw:ControlResources ID="ControlResources1" IncludePrototype="true" runat="server"></dw:ControlResources>
    
</head>
<body style="background-color:#FFFFFF;" onload="AdjustControls();">
    <script type="text/javascript">
        var  borderWidth = 0;
        var  topMargin = 17;
        var  bottomMargin = 12;
        var  heightBeetweenCategoriesAndHeader = 13;
        var  heightBeetweenHeaderAndTables = 0;
        var  heightBeetweenTablesAndButton = 13;
    
        var  allRowPrefix = "AllRow_";
        var  categoryTablePrefix = "Category_";
        
        var  cursorRowBackground = "#F8F8F8";
        var  selectedRowBackground = "#E0E0E0";
        var  selectedAndCursorRowBackgound = "#CCCCCC";
        
        var  cursorRow = null;
        
        var  selectNewsItemsObject = null;
        
        var  S_Categories = null;
        var  T_Header = null;
        var  DIV_NoNewsItemsFound = null;
        
        function  UpdateRowBackground(row)
        {
            row.style.backgroundColor = 
                ((row == cursorRow) ?  
                    (row._selected ? selectedAndCursorRowBackgound : cursorRowBackground) :
                    (row._selected ? selectedRowBackground : ""));
        }
        
        function  MouseEnteredRow(row)
        {
            cursorRow = row;
            UpdateRowBackground(row);
        }
         
        function  MouseLeaveRow(row)
        {
            cursorRow = null;
            UpdateRowBackground(row);
        }

        function SelectDeselectRow(row) {
            var selectedItemId = row.id.split('_')[2];

            var  cell = null;
            var  itemData = null;
            var  pos = null;
        
            if (!row._selected)
            {
                cell = row.cells.item(row.cells.length - 1);
                
                itemData = new Object();
                pos = new Object();

                pos.pos = 0;
                parent.ExtractItemDataFromString(parent.GetInnerText(cell), pos, itemData);

                selectNewsItemsObject.AddSelectedItemToTable(false, itemData, row);
            }
            else
            {
                selectNewsItemsObject.DeleteSelectedNewsItem_(parseInt(selectedItemId));
            }

            var selectedState = row._selected;
            var rows = $$('tr[name=' + allRowPrefix + selectedItemId + ']');
            for (var i = 0; i < rows.length; i++) {
                var selectedRow = $(rows[i].id);
                selectedRow._selected = !selectedState;
                UpdateRowBackground(selectedRow);
            }
            selectNewsItemsObject.RefreshSelectedCodes();
            selectNewsItemsObject.ShowNoneSelectedItemsIfNecessary();
        }

        function DeleteSelectedNewsItem_(selectedItemId) {
            var rows = $$('tr[name=' + allRowPrefix + selectedItemId + ']');
            for (var i = 0; i < rows.length; i++) {
                var selectedRow = $(rows[i].id);
                selectedRow._selected = false;
                UpdateRowBackground(selectedRow);
            }
        }

        function  ShowSelectedCategoryTable()
        {
            var  i;
            var  i1;
            var  s;
            var  table;
            
            var  categoryId = parseInt(selectNewsItemsObject.HI_SelectedCategoryCode.value);
            
            for(i = 0, i1 = selectNewsItemsObject.categories.length; i < i1; i++)
            {
                s = ((selectNewsItemsObject.categories[i].id == categoryId) ? "" : "none");

                table = document.getElementById(categoryTablePrefix + selectNewsItemsObject.categories[i].id);
                if (table != null)
                {
                    table.style.display = s;
                }
                else
                {
                    DIV_NoNewsItemsFound.style.display = s; 
                }
            }
        }
        
        function  CategoryChangeHandler()
        {
            selectNewsItemsObject.HI_SelectedCategoryCode.value = S_Categories.options.item(S_Categories.selectedIndex).value;
            ShowSelectedCategoryTable();
        }
        
        function  CloseNewsItemsSelectionWindowHandler()
        {
            selectNewsItemsObject.ShowHideNewsSelection();
        }

        function  LoadCategories()
        {
            var  i;
            var  i1;
            var  categoryOption;
            var  selectedCategoryCode = parseInt(selectNewsItemsObject.HI_SelectedCategoryCode.value);
            
            for(i = 0, i1 = selectNewsItemsObject.categories.length; i < i1; i++)
            {
                categoryOption = document.createElement("option");
                categoryOption.text = selectNewsItemsObject.categories[i].name;
                categoryOption.value = selectNewsItemsObject.categories[i].id;
                
                S_Categories.options.add(categoryOption);

                if (selectNewsItemsObject.categories[i].id == selectedCategoryCode)
                {
                    S_Categories.selectedIndex = i;
                }
            }
        }

        function  PreprocessCategoryTables()
        {
            var  table;
            var  row;
            var  rowCodeString;

            var  i;
            var  i1;
            var  i2;
            var  i3;
          
            for(i = 0, i1 = selectNewsItemsObject.categories.length; i < i1; i++)
            {
                table = document.getElementById(categoryTablePrefix + selectNewsItemsObject.categories[i].id);

                if (table != null)
                {
                    for(i2 = 0, i3 = table.rows.length; i2 < i3; i2++)
                    {
                        row = table.rows.item(i2);
                        rowCodeString = row.id.split('_')[2];
                        row._selected = (parent.document.getElementById(selectNewsItemsObject.selectedRowPrefix + rowCodeString) != null);
                        if (row._selected)
                        {
                            UpdateRowBackground(row);
                        }
                    }
                }
            }
        }

        function  AdjustControls()
        {
            var  B_Close = document.getElementById("B_Close");
            var  DIV_CategoryTables = document.getElementById("DIV_CategoryTables");
            var  allHeight = selectNewsItemsObject.F_NewsItemsSelectionList.offsetHeight - borderWidth;

            T_Header.style.top = (S_Categories.offsetTop + S_Categories.offsetHeight + heightBeetweenCategoriesAndHeader) + "px";
            DIV_CategoryTables.style.top = (T_Header.offsetTop + T_Header.offsetHeight + heightBeetweenHeaderAndTables) + "px";
            DIV_CategoryTables.style.height = (allHeight - bottomMargin - B_Close.offsetHeight - heightBeetweenTablesAndButton - DIV_CategoryTables.offsetTop) + "px";
            B_Close.style.top = (allHeight - bottomMargin - B_Close.offsetHeight) + "px";
        }
        
    </script>

    <form id="form1" runat="server">
        <div id="DIV_NewsItemsSelectionList" runat="server" style="background-color:#ffffff;">
            <select id="S_Categories" class="std" runat="server" onchange="CategoryChangeHandler();" style="position:absolute;left:17px;top:15px;width:200px;">
            </select>
            <button id="B_Close" type="button" style="position:absolute;left:17px;top:192px;width:60px;height:20px" onclick="CloseNewsItemsSelectionWindowHandler();">
                <dw:TranslateLabel runat="server" Text="Close" />
            </button>
            <table id="T_Header" cellspacing="0" cellpadding="0" style="position:absolute; left:17px; top:44px; width:330px">
                <tr>
                    <td style="padding-bottom:2px; width:80px;">
                        <strong> <dw:TranslateLabel runat="server" Text="Date" /> </strong>
                    </td>
                    <td style="padding-bottom:2px; width:250px;">
                        <strong> <dw:TranslateLabel runat="server" Text="Heading" /> </strong>
                    </td>
                </tr> 
                <tr>
                    <td colspan="2" style="	background-color:#cccccc; height:1px; width:100%;">
                    </td>
                </tr>
            </table>
            <div id="DIV_CategoryTables" runat="server" style="position:absolute; overflow-y:auto; overflow-x:hidden; left:17px; top:64px; width:330px; height:117px;">
                <div id="DIV_NoNewsItemsFound" style="display:none; margin-top:2px; margin-bottom:2px">
                    <dw:TranslateLabel runat="server" Text="No news items found" />
                </div>
            </div>
        </div>
    </form>
    
    <asp:Literal id="LIT_ControlId" runat="server"> </asp:Literal>
    
    <script type="text/javascript">
        selectNewsItemsObject = parent.GetNewsItemsSelectObject(controlId);
        
        S_Categories = document.getElementById("S_Categories");
        T_Header = document.getElementById("T_Header");
        DIV_NoNewsItemsFound = document.getElementById("DIV_NoNewsItemsFound");

        LoadCategories();
        PreprocessCategoryTables();
        ShowSelectedCategoryTable();

        selectNewsItemsObject.FrameLoadCompleted(window);
    </script>
</body>
</html>
<%
Translate.GetEditOnlineScript()
%>
