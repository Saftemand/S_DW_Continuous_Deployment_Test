<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Category_List.aspx.vb" Inherits="Dynamicweb.Admin.ForumV2.Category_List" %>
<%@Import namespace="Dynamicweb.Backend"%>
<HTML>
	<HEAD>
		<script src="Navigation.js" language="javascript"></script>
		<LINK href="/Admin/Stylesheet.css" type="text/css" rel="STYLESHEET">
			<style type="text/css">
			.menu {background-color: #ffffff;}
			.menu a {color: #000080;}
			.menu a:hover {text-decoration: underline;}
			.menu a:visited {color: #000080;}			
			</style>
			<script language="javascript">
			<!--
		
				function $(id)
				{
					return document.getElementById(id);
				}
				
				function SelectItem(id)
				{
					var item = $('item_' + id);
					var previousID = $('selectedID');
					var itemPrevious;
						
					if(previousID.value.length > 0)
					{
						itemPrevious = $('item_' + previousID.value);
						if((item && itemPrevious))
						{
							item.style.cssText = "font-weight:bold;";
							if(item.id != itemPrevious.id)
								itemPrevious.style.cssText = "";
						}
					}
					else
						item.style.cssText = "text-decoration:underline;";	
					previousID.value = id;
				}
				
				function SetSelected()
				{
					var previousID = $('selectedID');
					var pageLoaded = parent.frames["ForumV2Main"].location.href;
					var selected;
					
					if(previousID.value.length > 0)
					{
						selected = $('item_' + previousID.value);
						if(selected)
						{
							selected.style.cssText = "font-weight:bold;";
							LoadPage("Thread_List.aspx?CategoryID=" + previousID.value);
						}
					}
					
					RefreshView(); 
				}
				
				function RefreshView()
				{
					<asp:Literal id="AccessProc" runat="server"></asp:Literal>
				}
				
				function DeleteCategory(name, id)
				{
					if(confirm('<%=Translate.Translate("Slet ")%>\"' + name + '\"?'))
						location = "Category_Delete.aspx?CategoryID=" + id;
				}
				
			//-->
			</script>
	</HEAD>
	<body onload="SetSelected();">
		<form id="ListCategories" method="post" runat="server">
			<asp:Repeater ID="lstCategories" Runat="server">
				<HeaderTemplate>
					<table width="100%" cellspacing="0" border="0">
				</HeaderTemplate>
				<ItemTemplate>
					<tr>
						<td align="left" valign="middle" nowrap>&nbsp; <a onmouseover="this.style.cssText='text-decoration:underline;cursor:pointer;'; window.status='ID: <%# DataBinder.Eval(Container.DataItem, "ID") %>'" onmouseout="this.style.cssText='cursor:default;'; window.status='';" onclick='SelectItem("<%# DataBinder.Eval(Container.DataItem, "ID") %>"); LoadPage("Thread_List.aspx?CategoryID=<%# DataBinder.Eval(Container.DataItem, "ID") %>");'>
								<img src='/Admin/Images/ForumV2/Category_List.gif' border="0" align="middle">&nbsp;<span id='item_<%# DataBinder.Eval(Container.DataItem, "ID") %>' style=""><font id='element_<%# DataBinder.Eval(Container.DataItem, "ID") %>' color='#000000'><%# DataBinder.Eval(Container.DataItem, "Name") %></font></span></a>
						</td>
					</tr>
				</ItemTemplate>
				<FooterTemplate>
					</table>
				</FooterTemplate>
			</asp:Repeater>
			<asp:Literal ID="noCategories" Runat="server" text=""></asp:Literal>
			<asp:Literal ID="selectedItem" Runat="server" Text="<input type=hidden id=selectedItemID value="></asp:Literal>
		</form>
		
		<div id="divMenu" style="border: 1px solid; display: none; position: absolute">
			<table class="menu" width="80">
				<tr>
					<td><img src="/Admin/Images/ForumV2/Menu_New.gif" border="0"></td>
					<td nowrap><a id="newCategoryOnItem" onmouseover="window.status='ggg';" onmouseout="window.status='';"><%=Translate.Translate("Ny kategori")%></a></td>
				</tr>
				<tr>
					<td><img src="/Admin/Images/ForumV2/Menu_Edit.gif" border="0"></td>
					<td nowrap><a id="editCategory"><%=Translate.Translate("Rediger kategori")%></a></td>
				</tr>
				<tr>
					<td><img src="/Admin/Images/ForumV2/Menu_Delete.gif" border="0"></td>
					<td nowrap><a id="deleteCategory"><%=Translate.Translate("Slet kategori")%></a></td>
				</tr>
			</table>
		</div>
		
		<div id="divMenuDefault" style="border: 1px solid; display: none; position: absolute">
			<table class="menu" width="80">
				<tr>
					<td><img src="/Admin/Images/ForumV2/Menu_New.gif" border="0"></td>
					<td nowrap><a id="newCategory"><%=Translate.Translate("Ny kategori")%></a></td>
				</tr>
				<tr>
					<td><img src="/Admin/Images/ForumV2/Menu_Refresh.gif" border="0"></td>
					<td nowrap><a id="refreshView"><%=Translate.Translate("Opdater")%></a></td>
				</tr>
			</table>
		</div>
	</body>
	<input type="hidden" id="CategoryAccess" value="<%=CategoryAccess%>">
</HTML>
<script language="javascript">
	<!--
	var _replaceContext = false;
	var _mouseOverContext = false;
	var _contextScroll = false;
	var _divContext = $('divMenu');
	var _divContextDefault = $('divMenuDefault');

	InitContext();

	function InitContext()
	{
		_divContext.onmouseover = function() { _mouseOverContext = true; };
		_divContext.onmouseout = function() { _mouseOverContext = false; };
	
		_divContextDefault.onmouseover = function() { _mouseOverContext = true; };
		_divContextDefault.onmouseout = function() { _mouseOverContext = false; };
	
		document.body.onmouseup = ContextMouseUp;
		document.body.oncontextmenu = ContextShow;
		window.onscroll = ContextScroll;
	}

	function ContextMouseUp(event)
	{
		var target;
		if (_mouseOverContext)
		{
			_divContext.style.display = 'none';
			return;
		}
		
		_divContext.style.display = 'none';
		_divContextDefault.style.display = 'none';
			
		_contextScroll = false;
		if (event == null)
			event = window.event;
		
		target = event.target != null ? event.target : event.srcElement;
		if (event.button == 2)
		{
			if (target.tagName.toLowerCase() == 'a' || target.tagName.toLowerCase() == 'font')
				_divContext = $('divMenu');
			else
				_divContext = $('divMenuDefault');
				
			if (!_mouseOverContext && !_contextScroll)
				_divContext.style.display = 'none';
		}
	}

	function ContextScroll(event)
	{
		_contextScroll = true;
	}

	function ContextShow(event)
	{
		var target, scrollTop, scrollLeft;
		if (_mouseOverContext)
			return;

		if (event == null)
			event = window.event;
		
		target = event.target != null ? event.target : event.srcElement;
		var catName = target.innerText;
		if (catName != null)
		{
			catName = catName.replace(/\\/g, "\\\\");
			catName = catName.replace(/'/g, "\\'");
		}
		$('newCategory').href = "javascript:LoadPage('Category_Edit.aspx');";
		$('newCategoryOnItem').href = "javascript:LoadPage('Category_Edit.aspx');";
		$('editCategory').href = "javascript:LoadPage('Category_Edit.aspx?CategoryID=" + target.id.substring(target.id.indexOf("_") + 1, target.id.length) + "');";
		$('deleteCategory').href = "javascript:DeleteCategory('" + catName + "', " + target.id.substring(target.id.indexOf("_") + 1, target.id.length) + ");";
		$('refreshView').href = "javascript:LoadPageInFrame(parent.frames[\"ForumV2Category\"], \"Category_List.aspx\");";
			
		scrollTop = document.body.scrollTop ? document.body.scrollTop : 
			document.documentElement.scrollTop;
		scrollLeft = document.body.scrollLeft ? document.body.scrollLeft : 
			document.documentElement.scrollLeft;

		_divContext.style.display = 'none';
		_divContext.style.left = event.clientX + scrollLeft + 'px';
		_divContext.style.top = event.clientY + scrollTop + 'px';
		_divContext.style.display = 'block';
			
		_replaceContext = false;
		_contextScroll = false;
	
		return false;
	}
//-->
</script>
<%
	Translate.GetEditOnlineScript()
%>