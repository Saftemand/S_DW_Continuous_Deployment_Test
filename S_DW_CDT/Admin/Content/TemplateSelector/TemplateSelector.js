/* Represents a template selector control */
var TemplateSelector = function(controlID) {
    this.controlID = controlID;
    this._components = {}
    this.onTemplateSelected = null;
}

/* Creates new instance (or returns a reference to already created one) of the control */
TemplateSelector.createInstance = function(controlID) {
    var obj = null;

    try {
        obj = eval('tmplSelector_' + controlID);
    } catch (ex) { }

    if (obj == null) {
        obj = new TemplateSelector(controlID);
    }

    return obj;
}

/* Handles "SelectedIndexChanged" drop-down list event */
TemplateSelector.prototype.onSelectedIndexChanged = function(sender, args) {
    var row = sender.get_selectedItem();
    var templateID = 0;

    /* retrieving the ID of the selected template */
    if (row) {
        templateID = parseInt($(row).select('input.hiddenTemplateID')[0].value);
    }

    /* Storing currently selected template's ID in a hidden field */
    $(this.controlID).select('input.selectedTemplateID')[0].value = templateID;
    
    /* Firing a callback to nitofy client code that selection has been changed */
    if (typeof (this.onTemplateSelected) == 'function') {
        this.onTemplateSelected(this, { selectedTemplateID: templateID });
    }
}

/* Handles "DataExchange" drop-down list event */
TemplateSelector.prototype.onDataExchange = function(sender, args) {
    var icon = args.dataDestination.select('img.iconImage')[0];
    var heading = args.dataDestination.select('span.detailsHeadingBig')[0];

    icon.src = args.dataSource.select('img.iconImage')[0].src;
    heading.innerHTML = args.dataSource.select('span.templateDetails span.detailsClean strong')[0].innerHTML;
}
