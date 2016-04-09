<%@ Control Language="vb" AutoEventWireup="false" Codebehind="MultiSelect.ascx.vb" Inherits="Dynamicweb.Admin.Employee.MultiSelect" className="MultiSelect" %>
<%@ Import namespace="Dynamicweb.backend" %>
<SCRIPT language="JavaScript">		
function MultiSelectMove(fbox, tbox, bAll) {									
	var arrFbox = new Array();									
	var arrTbox = new Array();									
	var arrLookup = new Array();								
	var i;														
	for (i = 0; i < tbox.options.length; i++) {					
		arrLookup[tbox.options[i].text] = tbox.options[i].value;
		arrTbox[i] = tbox.options[i].text;						
	}															
	var fLength = 0;											
	var tLength = arrTbox.length;								
	for(i = 0; i < fbox.options.length; i++) {					
		arrLookup[fbox.options[i].text] = fbox.options[i].value;
		if (bAll || (fbox.options[i].selected && fbox.options[i].value != '')) {
			arrTbox[tLength] = fbox.options[i].text;			
			tLength++;											
		}else{													
			arrFbox[fLength] = fbox.options[i].text;			
			fLength++;											
		}														
	}															
	arrFbox.sort();												
	arrTbox.sort();												
	fbox.length = 0;											
	tbox.length = 0;											
	var c;														
	for(c = 0; c < arrFbox.length; c++) {						
		var no = new Option();									
		no.value = arrLookup[arrFbox[c]];						
		no.text = arrFbox[c];									
		fbox[c] = no;											
	}															
	for(c = 0; c < arrTbox.length; c++) {						
		var no = new Option();									
		no.value = arrLookup[arrTbox[c]];						
		no.text = arrTbox[c];									
		tbox[c] = no;											
	}
	MultiSelectUpdateIds(fbox, tbox);
}																

function MultiSelectUpdateIds(fbox, tbox)
{
    var box = fbox;
    if (box.id.indexOf("listSelected") < 0)
        box = tbox;
    var ids = "";
	for(i = 0; i < box.options.length; i++) 
	{
	    if (ids.length > 0)
	        ids += ",";
	    ids += box.options[i].value;
	}
	document.all.MultiSelectIDs.value = ids;
}

function MultiSelectGetAllControl(me)
{
    return MultiSelectGetControl(me, "listAll");
}

function MultiSelectGetSelectedControl(me)
{
    return MultiSelectGetControl(me, "listSelected");
}

function MultiSelectGetControl(me, id)
{
    var prefix = "";
    if (me)
    {
        var index = me.id.lastIndexOf("_");
        if (index > 0)
            prefix = me.id.substr(0, index + 1);
    }
    return document.all[prefix + id];
}

function IsSelected(source, arguments)
{
    arguments.IsValid = document.all.MultiSelectIDs.value.length > 0;
}
</SCRIPT>
<table cellSpacing="0" cellPadding="2">
	<TBODY>
		<tr>
			<td><asp:label id="lblSelected" runat="server"><%=Translate.translate("Valgte")%></asp:label></td>
			<td>&nbsp;</td>
			<td><asp:label id="lblAll" runat="server"><%=Translate.translate("Alle")%></asp:label></td>
		</tr>
		<tr>
			<td rowSpan="2"><asp:listbox id="listSelected" ondblclick="MultiSelectMove(MultiSelectGetSelectedControl(this),MultiSelectGetAllControl(this))"
					runat="server" CssClass="std" Height="150px" Width="200px"></asp:listbox></td>
			<td vAlign="bottom" width="30">
				<asp:image id="imgLeft" style="CURSOR: pointer" onclick="MultiSelectMove(MultiSelectGetAllControl(this), MultiSelectGetSelectedControl(this))"
					runat="server" ImageUrl="/Admin/images/Page_Previous.gif"></asp:image>
				<asp:image id="imgLeftAll" style="CURSOR: pointer" onclick="MultiSelectMove(MultiSelectGetAllControl(this),MultiSelectGetSelectedControl(this), true)"
					runat="server" ImageUrl="/Admin/images/MoveAllLeft.gif"></asp:image></td>
			<td rowSpan="2"><asp:listbox id="listAll" ondblclick="MultiSelectMove(MultiSelectGetAllControl(this), MultiSelectGetSelectedControl(this))"
					runat="server" CssClass="std" Height="150px" Width="200px"></asp:listbox></td>
		</tr>
		<tr>
			<td vAlign="top" width="30"><asp:image id="imgRightAll" style="CURSOR: pointer" onclick="MultiSelectMove(MultiSelectGetSelectedControl(this),MultiSelectGetAllControl(this), true)"
					runat="server" src="/Admin/images/MoveAllRight.gif" ImageUrl="/Admin/images/MoveAllRight.gif"></asp:image>
				<asp:image id="imgRight" style="CURSOR: pointer" onclick="MultiSelectMove(MultiSelectGetSelectedControl(this),MultiSelectGetAllControl(this))"
					runat="server" ImageUrl="/Admin/images/Page_Next.gif"></asp:image>
			</td>
		</tr>
		<tr>
			<td colspan="3"><asp:CustomValidator id="deptsValidator" runat="server" ErrorMessage="You should select at least one department"
					Display="Dynamic" ClientValidationFunction="IsSelected"></asp:CustomValidator>
			</td>
		</tr>
	</TBODY>
</table>
<input type="hidden" id="MultiSelectIDs" name="MultiSelectIDs" value="<%=ServerText()%>">
<%Translate.GetEditOnlineScript()%>
