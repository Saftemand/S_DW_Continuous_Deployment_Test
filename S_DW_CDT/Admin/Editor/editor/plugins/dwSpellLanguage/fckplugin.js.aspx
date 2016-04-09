<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="fckplugin.js.aspx.vb" Inherits="Dynamicweb.Admin.fckplugin_js" %>
var dwSpellLanguage = function(name) {
    this.Name = name;
};

dwSpellLanguage.prototype.Execute = function(itemText, itemLabel) {
    var url = '/Admin/Editor/editor/plugins/dwSpellLanguage/fckplugin.js.aspx';
    FCK.selectedLanguage = itemText;
    var request = FCKTools.CreateXmlObject('XmlHttp');
    if ( !request ) {
        return ;
    }

    request.open( "GET", url + "?lang=" + itemText + "&dt=" + new Date().toUTCString(), false ) ;
    request.send( null ) ;
};

dwSpellLanguage.prototype.GetState = function() {
    return FCK_TRISTATE_OFF;
};

var dwSpellLanguageButton = function(tooltip, style) {
    this.CommandName = "dwSpellLanguage";
    this.Label = this.GetLabel();
    this.Tooltip = tooltip ? tooltip : this.Label;
    this.Style = style;
    this.SelectedLanguage = "en-US";
};

dwSpellLanguageButton.prototype = new FCKToolbarSpecialCombo ;

dwSpellLanguageButton.prototype.GetLabel = function() {
    return '';
};

dwSpellLanguageButton.prototype.CreateItems = function(target) {
    var l = Array();
    var ln = Array();
    FCK.selectedLanguage = "";
<%  For Each lang As ListItem In languages%>
    l.push("<%=lang.Value%>");
    ln.push("<%=Dynamicweb.Base.JSEnable(lang.Text)%>");
    <%=Dynamicweb.Base.IIf(lang.Selected, String.Format("FCK.selectedLanguage = ""{0}"";", lang.Value), "")%>
<%  Next%>
    
    for (var i = 0; i < l.length; i++) {
        var item = this._Combo.AddItem(l[i], ln[i]);
        if (FCK.selectedLanguage == l[i]) {
            this._Combo.SelectItem(item);
        }
    }
    
    target.OnBeforeClick = this.languagesCombo_OnBeforeClick; 
};

dwSpellLanguageButton.prototype.RefreshActiveItems = FCKToolbarStyleCombo.prototype.RefreshActiveItems ;

dwSpellLanguageButton.prototype.languagesCombo_OnBeforeClick = function(targetSpecialCombo) {
	// Clear the current selection.
	targetSpecialCombo.DeselectAll() ;
    targetSpecialCombo.SelectItemByLabel(FCK.selectedLanguage);
}


FCKCommands.RegisterCommand("dwSpellLanguage", new dwSpellLanguage("Spelling language"));
FCKToolbarItems.RegisterItem("dwSpellLanguage", new dwSpellLanguageButton("Spelling language", FCK_TOOLBARITEM_ONLYTEXT)); //FCK_TOOLBARITEM_ICONTEXT
