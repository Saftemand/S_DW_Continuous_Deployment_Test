<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SelectNewsItems.ascx.vb" Inherits="Dynamicweb.Admin.NewsLetterV3.SelectNewsItems" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<input type="hidden" id="HI_SelectedItemsData" name="HI_SelectedItemsData" runat="server" />
<input type="hidden" id="HI_SelectedItemsCodes" name="HI_SelectedItemsCodes" runat="server" />
<input type="hidden" id="HI_NewsSelectionVisible" name="HI_NewsSelectionVisible" runat="server" />
<input type="hidden" id="HI_SelectedCategoryCode" name="HI_SelectedCategoryCode" runat="server" />
<input type="hidden" id="HI_Categories" name="HI_Categories" runat="server" />

<script type="text/javascript">

//--------------------------------
//---- miscelaneous functions ----
//--------------------------------

function  GetIntegerFromString(s, pos)
{
    var  result = 0;
    var  s1 = "";
    var  i = pos.pos;
    var  i1 = s.length;

    while (s.charAt(i) != " ")
    {
        s1 += s.charAt(i++);
    }
    i++;
    pos.pos = i;
    
    result = parseInt(s1);
    return  (result);
}

function  GetStringFromString(s, pos)
{
    var  sLen = GetIntegerFromString(s, pos);
    var  startPos = pos.pos;
    pos.pos += sLen;
    return  (s.substring(startPos, startPos + sLen));
}

function  ExtractItemDataFromString(s, pos, itemData)
{
    itemData.id = GetIntegerFromString(s, pos);
    itemData.categoryId = GetIntegerFromString(s, pos);
    itemData.dateS = GetStringFromString(s, pos);
    itemData.heading = GetStringFromString(s, pos);
}

function  GetNewsItemsSelectObject(NewsItemsControlId)
{
    return  (window["NewsItemsControl_" + NewsItemsControlId]);
}

function  CalculateNewsSelectionCoordinates()
{
    var  p = this.DIV_SelectedNewsItems;
    var  left = 0;
    var  top = 0;
    
    while (p != document.body)
    {
        left += p.offsetLeft;
        top += p.offsetTop;
       
        p = p.offsetParent;
    }
    this.DIV_NewsItemsSelectionList.style.left = left + "px"; 
    this.DIV_NewsItemsSelectionList.style.top = Math.max(top - 229 - 3, 0) + "px";
}

function  SetInnerText(node, s)
{
    while (node.childNodes.length > 0)
    {
        node.removeChild(node.childNodes.item(node.childNodes.length - 1));
    }
    
    node.appendChild(document.createTextNode(s));
}

function  SetInnerTextInDiv(node, divWidth, s)
{
    var div = null;

    while (node.childNodes.length > 0)
    {
        node.removeChild(node.childNodes.item(node.childNodes.length - 1));
    }
    
    div = document.createElement("div");
    div.style.width = divWidth;
    div.style.overflowX = "hidden";
    div.style.wordWrap = "break-word";
    div.appendChild(document.createTextNode(s));
    node.appendChild(div);
}

function  GetInnerText(node)
{
    return  (node.childNodes.item(0).nodeValue);
}

//------------------------------------------
//----------- object functions -------------
//------------------------------------------

// object misc functions

function  GetCategoryName(CategoryCode)
{
    var  result = "";
    var  i;
    var  i1;
    
    for(i = 0, i1 = this.categories.length; i < i1; i++)
    {
        if (this.categories[i].id == CategoryCode)
        {
            result = this.categories[i].name;
            break;
        }
    }
    
    return  (result);
}

function  RefreshSelectedCodes()
{
    var  i;
    var  i1;
    var  s1 = "";

    for(i = 3, i1 = this.T_SelectNewsItems.rows.length; i < i1; i++)
    {
        s1 += ((s1 == "") ? "" : ",") +
                  this.T_SelectNewsItems.rows.item(i).selectedItemData.id.toString();
    }
    
    this.HI_SelectedItemsCodes.value = s1;
}

function  ShowNoneSelectedItemsIfNecessary()
{
    this.R_NoneNewsItemsSelected.style.display = ((this.HI_SelectedItemsCodes.value == "") ? "" : "none");
}

// modifying selected items table

function  SearchPositionInsertTo(selectedItemData, selectionRow)
{
    var  table;

    var  i;
    var  i1;
    var  i2;
    var  i3;
    var  searchStarted;
    var  searchStartPosition;
    var  foundRowCode;
    var  positionInsertTo = -1;

    searchStarted = false;
    foundRowCode = -1;
    
    for(i = 0, i1 = this.categories.length; ((i < i1) && (foundRowCode == -1)); i++)
    {
        if (!searchStarted && (this.categories[i].id == selectedItemData.categoryId))
        {
            searchStarted = true;
            searchStartPosition = selectionRow.rowIndex + 1;
        }
        
        if (searchStarted)
        {
            table = this.selectionWindow.document.getElementById(
                        this.selectionWindow.categoryTablePrefix + this.categories[i].id);
            
            if (table != null)
            {
                for(i2 = searchStartPosition, i3 = table.rows.length; i2 < i3; i2++)
                {
                    if (table.rows.item(i2)._selected)
                    {
                        foundRowCode = parseInt(table.rows.item(i2).id.split('_')[2]);
                        break;
                    }
                }
            }
                
            searchStartPosition = 0;
        }
    }

    if (foundRowCode != -1)
    {
        positionInsertTo = document.getElementById(this.selectedRowPrefix + foundRowCode).rowIndex;
    }

    return  (positionInsertTo);
}

function  MakeRowFromSelectedItem(selectedItemData, positionInsertTo)
{
    var  row = null;;
    var  cell = null;
    var  anchor = null;
    var  image = null;

    row = this.T_SelectNewsItems.insertRow(positionInsertTo);
    row.id = this.selectedRowPrefix + selectedItemData.id;
    row.selectedItemData = selectedItemData;

    cell = row.insertCell(-1);
    cell.vAlign = "top";
    cell.width = 178;
    cell.style.paddingTop = "1px";
    SetInnerTextInDiv(cell, "150px", this.GetCategoryName(selectedItemData.categoryId));

    cell = row.insertCell(-1);
    cell.vAlign = "top";
    cell.width = 80;
    cell.style.paddingTop = "1px";
    SetInnerTextInDiv(cell, "80px", selectedItemData.dateS);

    cell = row.insertCell(-1);
    cell.vAlign = "top";
    cell.width = 100;
    cell.style.paddingTop = "1px";
    SetInnerTextInDiv(cell, "250px", selectedItemData.heading);

    cell = row.insertCell(-1);
    cell.vAlign = "top";
    cell.align = "center";    
    cell.width = 32;
    cell.style.paddingTop = "1px";
    image = document.createElement("img");
    image.src = "/Admin/images/Delete.gif";
    image.border = 0;
    image.title = "<%=Translate.JsTranslate("Unselect news item")%>";

    anchor = document.createElement("a");
    anchor.href = "javascript:GetNewsItemsSelectObject('" + this.id + "').DeleteSelectedNewsItem(" + selectedItemData.id + ")";
    anchor.appendChild(image);
    cell.appendChild(anchor);
    
    return  (row);
}

function  AddSelectedItemToTable(toTheEnd, selectedItemData, selectionRow)
{
    var  positionInsertTo = -1;
    
    if (!toTheEnd)
    {
        positionInsertTo = this.SearchPositionInsertTo(selectedItemData, selectionRow);
    }

    this.MakeRowFromSelectedItem(selectedItemData, positionInsertTo);
}

function  DeleteSelectedNewsItem(selectedItemId)
{
    if (!this.frameIsLoading)
    {
        this.DeleteSelectedNewsItem_(selectedItemId);
        
        if (this.frameLoaded)
        {
            this.selectionWindow.DeleteSelectedNewsItem_(selectedItemId);
        }
    
        this.RefreshSelectedCodes();
        this.ShowNoneSelectedItemsIfNecessary();
    }
}

function  DeleteSelectedNewsItem_(selectedItemId)
{
    var  selectedItemRow = document.getElementById(this.selectedRowPrefix + selectedItemId);

    this.T_SelectNewsItems.deleteRow(selectedItemRow.rowIndex);
}

// loading news items selection part

function  StartLoadingNewsSelection()
{
    this.frameIsLoading = true;
    this.updateLoadingLabelTimeOutId = null;

    this.F_NewsItemsSelectionList.src = "Control/SelectNewsItemsNewsSelection.aspx?ControlId=" + this.id;

    SetInnerText(this.TD_Loading, "<%=Translate.JsTranslate("Loading", 0)%>");
    this.loadingCount = 0;
    this.updateLoadingLabelTimeOutId = setTimeout("GetNewsItemsSelectObject('" + this.id + "').UpdateLoadingLabel();", 1000);
}

function  UpdateLoadingLabel()
{
    var  i;
    var  s = "";

    this.loadingCount = ((this.loadingCount == 3) ? 0 : this.loadingCount + 1);
    for(i = 0; i < this.loadingCount; i++)
    {
        s += ".";
    }
    SetInnerText(this.TD_Loading, "<%=Translate.JsTranslate("Loading", 0)%>" + s);

    this.UpdateLoadingLabelTimeOutId = setTimeout("GetNewsItemsSelectObject('" + this.id + "').UpdateLoadingLabel();", 1000);
}

function  FrameLoadCompleted(selectionWindow)
{
    this.frameLoaded = true;
    this.frameIsLoading = false;
    
    this.selectionWindow = selectionWindow;

    if (this.updateLoadingLabelTimeOutId != null)
    {
        clearTimeout(this.updateLoadingLabelTimeOutId);
        this.updateLoadingLabelTimeOutId = null;
    }
    SetInnerText(this.TD_Loading, "");

    this.CalculateNewsSelectionCoordinates();
    this.DIV_NewsItemsSelectionList.style.display = "";
    this.HI_NewsSelectionVisible.value = "true";
}

function  ShowHideNewsSelection()
{
    if (!this.frameIsLoading)
    {
        if (!this.frameLoaded)
        {
            if (this.categories.length == 0)
            {
                alert("<%=Translate.JsTranslate("No news items found")%>");
            }
            else
            {
                this.StartLoadingNewsSelection();
            }
        }
        else
        {
            this.HI_NewsSelectionVisible.value = ((this.HI_NewsSelectionVisible.value == "true") ? "false" : "true");
            this.DIV_NewsItemsSelectionList.style.display = ((this.HI_NewsSelectionVisible.value == "true") ? "" : "none");
        }
    }
}

// starting load functions

function  LoadCategories()
{
    var  pos = new  Object();
    var  categoriesCount;
    var  i;
    var  s = this.HI_Categories.value; 
    this.HI_Categories.value = "";
   
    pos.pos = 0;
    categoriesCount = GetIntegerFromString(s, pos);
    this.categories = new  Array(categoriesCount);

    for(i = 0; i < categoriesCount; i++)
    {
        this.categories[i] = new Object();
        this.categories[i].id = GetIntegerFromString(s, pos);
        this.categories[i].name = GetStringFromString(s, pos);
    }
}

function  LoadSelectedItems()
{
    var  itemData = null; 
    var  pos = new  Object();

    var  s = this.HI_SelectedItemsData.value;
    this.HI_SelectedItemsData.value = "";

    pos.pos = 0;
    while (pos.pos < s.length)
    {
        itemData = new Object();
        ExtractItemDataFromString(s, pos, itemData);
        
        this.AddSelectedItemToTable(true, itemData, null);
    }
    
    this.RefreshSelectedCodes();
    this.ShowNoneSelectedItemsIfNecessary();
}

function  PrepareSelectNewsItemsControl()
{
    this.LoadCategories();
    this.LoadSelectedItems();
    
    if (this.HI_NewsSelectionVisible.value == "true")
    {
        this.StartLoadingNewsSelection();
    }
}

//--------------------------------------
//---- object constructor functions ----
//--------------------------------------

function  SelectNewsItemsObject(controlId)
{
    var  i;
    var  i1;
    var  i2;
    var  iFrames;

    this.id = controlId;
    
    this.selectedRowPrefix = controlId + "_" + "SelectedRow_";

    this.frameLoaded = false;

    this.categories = null;

    this.updateLoadingLabelTimeOutId = null;
    this.loadingCount = 0;
    this.frameIsLoading = false;

    this.GetCategoryName = GetCategoryName;
    this.RefreshSelectedCodes = RefreshSelectedCodes;
    this.CalculateNewsSelectionCoordinates = CalculateNewsSelectionCoordinates;
    this.ShowNoneSelectedItemsIfNecessary = ShowNoneSelectedItemsIfNecessary;

    this.SearchPositionInsertTo = SearchPositionInsertTo;
    this.MakeRowFromSelectedItem = MakeRowFromSelectedItem;
    this.AddSelectedItemToTable = AddSelectedItemToTable;
    this.DeleteSelectedNewsItem = DeleteSelectedNewsItem;
    this.DeleteSelectedNewsItem_ = DeleteSelectedNewsItem_;

    this.StartLoadingNewsSelection = StartLoadingNewsSelection;
    this.UpdateLoadingLabel = UpdateLoadingLabel;
    this.FrameLoadCompleted = FrameLoadCompleted;

    this.ShowHideNewsSelection = ShowHideNewsSelection;

    this.LoadCategories = LoadCategories;
    this.LoadSelectedItems = LoadSelectedItems;
    this.PrepareSelectNewsItemsControl = PrepareSelectNewsItemsControl;

    iFrames = document.getElementsByTagName("iframe");
    for(i = 0, i1 = iFrames.length; i < i1; i++)
    {
        i2 = iFrames[i].id.indexOf(controlId);
        if (i2 != -1)
        {
            this.IdPrefix = iFrames[i].id.substring(0, i2);
            break;
        }
    }
    
    this.HI_SelectedItemsData = document.getElementById(this.IdPrefix + this.id + "_" + "HI_SelectedItemsData");
    this.HI_SelectedItemsCodes = document.getElementById(this.IdPrefix + this.id + "_" + "HI_SelectedItemsCodes");
    this.HI_NewsSelectionVisible = document.getElementById(this.IdPrefix + this.id + "_" + "HI_NewsSelectionVisible");
    this.HI_SelectedCategoryCode = document.getElementById(this.IdPrefix + this.id + "_" + "HI_SelectedCategoryCode");
    this.HI_Categories = document.getElementById(this.IdPrefix + this.id + "_" + "HI_Categories");

    this.DIV_NewsItemsSelectionList = document.getElementById(this.IdPrefix + this.id + "_" + "DIV_NewsItemsSelectionList");
    this.T_SelectNewsItems = document.getElementById(this.IdPrefix + this.id + "_" + "T_SelectNewsItems");
    this.TD_Loading = document.getElementById(this.IdPrefix + this.id + "_" + "TD_Loading");
    this.R_NoneNewsItemsSelected = document.getElementById(this.IdPrefix + this.id + "_" + "R_NoneNewsItemsSelected");
    this.B_ShowNewsSelection = document.getElementById(this.IdPrefix + this.id + "_" + "B_ShowNewsSelection");

    this.DIV_SelectedNewsItems = document.getElementById(this.IdPrefix + this.id + "_" + "DIV_SelectedNewsItems");
    this.F_NewsItemsSelectionList = document.getElementById(this.IdPrefix + this.id + "_" + "F_NewsItemsSelectionList");
    
    this.B_ShowNewsSelection.selectNewsItemsObject = this;
    this.selectionWindow = null;
}
</script>

<div id="DIV_NewsItemsSelectionList" runat="server" style="display:none;position:absolute;border-left: #333333 1px solid;border-top:#333333 1px solid;border-right:#333333 1px solid;border-bottom:#333333 1px solid">
<iframe id="F_NewsItemsSelectionList" frameborder="no" runat="server" style="overflow-x:hidden;overflow-y:hidden;width:364px;height:229px;">
</iframe>
</div>
<div id="DIV_SelectedNewsItems" runat="server">
    <table id="T_SelectNewsItems" runat="server" border="0" cellspacing="0" cellpadding="2" style="table-layout:fixed;margin-top:5px; width: 560px;">
        <tr>
            <td style="padding-bottom:2px; width:178px;">
                <strong> <dw:TranslateLabel runat="server" Text="Category" /> </strong>
            </td>
            <td style="padding-bottom:2px; width:80px;">
                <strong> <dw:TranslateLabel runat="server" Text="Date" /> </strong>
            </td>
            <td style="padding-bottom:2px;width:100px;">
                <strong> <dw:TranslateLabel runat="server" Text="Heading" /> </strong>
            </td>
            <td align="center" style="padding-bottom:2px; width:32px;"><strong> <dw:TranslateLabel ID="TranslateLabelDelete" runat="server" Text="Delete" /></strong>
            </td>
        </tr>
        <tr>
            <td colspan="4" class="dividerRows"> </td>
        </tr>
        <tr id="R_NoneNewsItemsSelected" runat="server" style="display:none;">
            <td colspan="4" style="padding-top:2px; padding-bottom:2px;">
                <dw:TranslateLabel runat="server" Text="None news items selected" />
            </td>
        </tr>
    </table>

    <table cellspacing="0" cellpadding="0" style="margin-top:5px;">
    <tr>
        <td>
            <button id="B_ShowNewsSelection" type="button" onclick="this.selectNewsItemsObject.ShowHideNewsSelection();" runat="server" class="buttonSubmit">
                <dw:TranslateLabel runat="server" Text="Select news items" />
            </button>
        </td>
        <td style="width:10px;">
        </td>
        <td id="TD_Loading" runat="server">
        </td>
    </tr>
    </table>
</div>

<asp:Literal ID="LIT_ControlId" runat="server"> </asp:Literal>

<script type="text/javascript">

var  obj = new  SelectNewsItemsObject(controlId);
window["NewsItemsControl_" + controlId] = obj;
obj.PrepareSelectNewsItemsControl();

</script>