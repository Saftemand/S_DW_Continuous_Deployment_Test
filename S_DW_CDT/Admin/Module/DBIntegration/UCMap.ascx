<%@ Control Language="vb" AutoEventWireup="false" Codebehind="UCMap.ascx.vb" Inherits="Dynamicweb.Admin.DBIntegration.UCMap" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Import namespace="Dynamicweb" %>
<%@ Import namespace="Dynamicweb.Backend" %>
<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">

<style type="text/css">
    div#links a span {
        display: none;
    }
    div#links a:hover span {
        display: inline;
        position: absolute;
        padding: 5px; margin: 10px; z-index: 100;
        color: #000000; background: #fffff5;
        border: 1px solid gray;
    }
</style>

<%OnDeleteMap()%>
<%OnSetUnique()%>
<%MapTab()%>
<script language="javascript">
<%=GetColumnsJSArray() %>
</script>

<script language="javascript">
    function Map_GetReferenceList()
    {
        return document.getElementById('_refColumnsDrop');
    }

    function Map_OnReferenceClick(elm)
    {
        Map_GetReferenceList().disabled = !elm.checked;
        if(elm.checked)
            Map_OnSelectTargetColumn(document.getElementById('_targetColumnsDrop').value);
    }

    function Map_UpdateReferenceDropDown(excludeTab)
    {
        try
        {
            var list = Map_GetReferenceList();
                        
            if(list && !list.disabled)
            {
                list.options.length = 0;
                while(list.firstChild)
                    list.removeChild(list.firstChild);
                for(tableName in map_columnsList)
                {
                    var tab = tableName.split(':');
                    if(tab[0] != excludeTab)
                    {
                        var grp = document.createElement('optgroup');
                        grp.label = tab[1];
                                                                    
                        for(var i = 0; i < map_columnsList[tableName].length; i++)
                        {
                            var vals = map_columnsList[tableName][i].split(':');
                            var opt = document.createElement('option');
                            
                            opt.innerText = vals[0] + '(' + vals[1] + ')';
                            opt.text = vals[0] + '(' + vals[1] + ')';
                            opt.value=tab[0] + ':' + vals[0] + ':' + vals[1];
                            grp.appendChild(opt);
                        }
                        list.appendChild(grp);
                    }
                }
            }
        }
        catch(ex) { }
    }

    function Map_OnSelectTargetColumn(value)
    {
        var tabID = value.split(':')[0];
        Map_UpdateReferenceDropDown(tabID);
    }

	function OnDeleteMapClick(deleteId)
		{   
			if(confirm('<%=Translate.JSTranslate("Slet")%>?')){
				document.getElementById("DeleteMapID").value = deleteId;			
				Form1.submit();
			}				
			return false;		
		}
		
	function OnSetUniqueClick(sId)
		{   
			document.getElementById("UniqueMapID").value = sId;			
			Form1.submit();
							
			return false;		
		}
</script>
<table width="590" border="0">
	<TBODY>
		<tr>
			<td>
			    <div id="links">
				<table border="0" cellpadding="0" cellspacing="2" width="585">
					<asp:repeater id="MapRepeater" runat="server">
						<HeaderTemplate>
							<tr>
								<td align="left" width="230" colspan="2"><strong><%=Translate.translate("Kilde")%></strong></td>
								<td align="left"></td>
								<td align="left" width="230"><strong><%=Translate.translate("Destination")%></strong></td>
								<td align="center" width="60"><strong><%=Translate.Translate("Unique") %></strong></td>
								<td align="left"><strong><%=Translate.translate("Slet")%></strong></td>
							</tr>
							<tr>
								<td colspan="6" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" alt="" border="0"></td>
							</tr>
						</HeaderTemplate>
						<ItemTemplate>
							<tr>
								<td width="15"><img src='<%# DataBinder.Eval(Container.DataItem, "SourceColumnImg") %>' border="0"></td>
								<td align="left" width="245"><%# DataBinder.Eval(Container.DataItem, "SourceColumnName") %></td>
								<td align="left"><img src="/Admin/Images/Icons/Page_MoveTo.gif" alt="" border="0"><%#DataBinder.Eval(Container.DataItem, "ReferenceImg") %></td>
								<td align="left"><%#GetTargetName(DataBinder.Eval(Container.DataItem, "TargetColumnName"), DataBinder.Eval(Container.DataItem, "Target")) %></td>
								<td align="center">
								    <a href="#" onclick='OnSetUniqueClick(<%# DataBinder.Eval(Container.DataItem, "ID")%>)'>
								        <img src='<%# DataBinder.Eval(Container.DataItem, "UniqueImg")%>' alt="" border="0" /> </a>
								</td>
								<td align="center">
									<a href="#" OnClick='OnDeleteMapClick(<%# DataBinder.Eval(Container.DataItem, "ID")%>)'>
										<img src="/Admin/Images/Delete.gif" alt="" border="0"> </a>
								</td>
							</tr>
						</ItemTemplate>
						<SeparatorTemplate>
							<tr>
								<td colspan="6" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
							</tr>
						</SeparatorTemplate>
					</asp:repeater>
					<tr>
						<td colspan="6"><asp:Label id="_noMaps" runat="server"></asp:Label></td>
					</tr>
					<tr>
						<td colspan="6" bgcolor="#c4c4c4"><img src="/Admin/Images/nothing.gif" width="1" height="1" border="0"></td>
					</tr>
				</table>
				</div>
			</td>
		</tr>
		<tr height="60">
			<td valign="top" nowrap>
			    <%=Gui.GroupBoxStart(Translate.Translate("Add"))%>
				<asp:Panel ID="_panelMap" Runat="server">
				    <table width="100%">
				        <tr>
				            <td colspan="2">
<asp:radiobutton id="_chkDefault" Runat="server" Text="Default" OnCheckedChanged="SourceTypeChanged"
						name="_chkDefault" GroupName="SourceType" Checked="True" AutoPostBack="True"></asp:radiobutton>&nbsp; 
<asp:radiobutton id="_chkText" Runat="server" Text="Text value" OnCheckedChanged="SourceTypeChanged"
						GroupName="SourceType" AutoPostBack="True"></asp:radiobutton><BR>
<asp:TextBox id="_txText" Runat="server" Visible="False" CssClass="std"></asp:TextBox>
                                <asp:DropDownList id="_sourceColumnsDrop" Runat="server" CssClass="std"></asp:DropDownList>&nbsp;<IMG src="/Admin/Images/Icons/Page_MoveTo.gif" border="0">&nbsp;<SPAN id="_targetColumnsDropSpan" runat="server"></SPAN><br />
				            </td>
				        </tr>
				        <tr>
				            <td>
				                <input type="checkbox" id="_chkRef" name="_chkRef" runat="server" onclick="Map_OnReferenceClick(this);" /><label for="_mapList__chkRef"><%=Translate.Translate("References to") %></label><br />
				                <span id="_refColumnsDropSpan" runat="server"></span>
				            </td>
				            <td align="right" valign="bottom">
<asp:Button id="_addMap" Runat="server" Text="Add" CssClass="buttonSubmit" OnCommand="AddMap"></asp:Button>
				            </td>
				        </tr>
				    </table>
		</asp:Panel>
 		        <%=Gui.GroupBoxEnd() %>
				<input id="DeleteMapID" type="hidden" name="DeleteMapID" />
				<input id="UniqueMapID" type="hidden" name="UniqueMapID" />
			</td>
		</tr>
	</TBODY>
</table>
