<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EditNewsletterStep1.ascx.vb" Inherits="Dynamicweb.Admin.NewsLetterV3.EditNewsletterStep1" %>
<%@ Register Assembly="Dynamicweb.Controls" Namespace="Dynamicweb.Controls" TagPrefix="dw" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Import Namespace="Dynamicweb.NewsLetterV3" %>
<%@ Import Namespace="Dynamicweb.NewsLetterV3.Objects" %>
<script type="text/javascript">
    function OnFormatChanged()
    {
        var id = GetNewsletterFormatId();
        var showHtml = document.getElementById(id + "_0").checked;
        var showText = document.getElementById(id + "_1").checked;
        var showBoth = document.getElementById(id + "_2").checked;
        SetVisible(document.getElementById('TextEditorRow'), showText || showBoth);
        SetVisible(document.getElementById('HtmlEditorRow'), showHtml || showBoth);        
        onRightLoaded();
    }   
    
    function onRightLoaded() 
    {
	    var frm = parent.frames['ListRight'];
		if(navigator.userAgent.toLowerCase().indexOf('msie') != -1) 
		{            
			var showScroll = (document.body.clientHeight < frm.document.body.clientHeight + 10);
			frm.document.body.scroll = showScroll ? 'yes' : 'no';
		}
	}
</script>

<tr> 
  <td valign="top">
      <dw:GroupBoxStart runat="server" ID="FormatStart" doTranslation="true" Title="Newsletter format" ToolTip="Newsletter format"/>
        <asp:RadioButtonList ID="Format" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Value="1" Text="HTML" />
            <asp:ListItem Value="2" Text="Text" />
            <asp:ListItem Value="3" Text="Both" />
        </asp:RadioButtonList>
      <dw:GroupBoxEnd runat="server" ID="FormatEnd" />
  </td>
</tr>
<tr id="HtmlEditorRow"> 
  <td valign="top">
      <dw:GroupBoxStart runat="server" ID="HTMLStart" doTranslation="true" Title="HTML" ToolTip="HTML"/>
      <%= Gui.Editor("HtmlEditor", 560, 550, HtmlText, "", NewsletterTag.Tags, StylesheetPath, "", Gui.EditorEdition.SystemDefault)%>
      <dw:GroupBoxEnd runat="server" ID="HTMLEnd" />
  </td>
</tr>
<tr  id="TextEditorRow"> 
  <td valign="top">
      <dw:GroupBoxStart runat="server" ID="TextStart" doTranslation="true" Title="Text-only version" ToolTip="Text-only version"/>
      <asp:TextBox runat="server" ID="TextEditor" CssClass="std" Columns="25" Width="560" Rows="15" TextMode="MultiLine" />
      <dw:GroupBoxEnd runat="server" ID="TextEnd" />
  </td>
</tr>

<script language="javascript">
    
    var editor=document.getElementById("DHTMLSafe");
    if (editor != null && editor != 'undefined') {
        editor.attachEvent("DocumentComplete", SetBaseURL);
    }
    
</script>
