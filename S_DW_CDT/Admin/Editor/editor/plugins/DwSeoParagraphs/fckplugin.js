LoadScript('/Admin/Module/Seo/AnalyzedData.js');

var __currentParagraphID = -1;

var DwSeoParagraphs = function(tooltip, style) {
	if (tooltip === false)
		return;

	this.CommandName	= 'DwSeoParagraphs';
	this.Label			= this.GetLabel();
	this.Tooltip		= tooltip ? tooltip : this.Label;
	this.Style			= style ? style : FCK_TOOLBARITEM_ONLYTEXT;
	this.DefaultLabel	= '';
	this.Paragraphs 	= null;
	this.DwSeoPluginID = 'DwSeoParagraphs';
}

DwSeoParagraphs.prototype = new FCKToolbarSpecialCombo;

DwSeoParagraphs.prototype.GetLabel = function() {
	var ret = FCKLang.DwSeoParagraphsDropdown;
	
	if(!ret || ret.length == 0)
		ret = 'Paragraph';
		
	return ret;
}

DwSeoParagraphs.prototype.GetUrl = function() {
	var ret = '/Admin/Module/Seo/CheckList.aspx?action=loadxml&ID=';
	var matches = null;
	
	if(parent) {
		matches = parent.location.href.match(/ID=[0-9]{1,}/);
		if(matches && matches.length > 0)
			ret += matches[0].replace('ID=', '');
	}

	return ret;
}

DwSeoParagraphs.prototype.GetParagraphs = function() {
	var loader = new FCKXml();
	
	loader.LoadUrl(this.GetUrl());
	return loader;
}

DwSeoParagraphs.prototype.CreateItems = function(targetSpecialCombo) {
	var paragraphs = null;
	
	this.Paragraphs = this.GetParagraphs();
	paragraphs = this.Paragraphs.SelectNodes('Paragraphs/Paragraph');
	
	if(!paragraphs || paragraphs.length == 0)
		this.Disable();
	
	if(paragraphs && paragraphs.length > 0) {
		for(var i = 0; i < paragraphs.length; i++) {
			var id = paragraphs[i].attributes.getNamedItem('id').value;
			var header = paragraphs[i].attributes.getNamedItem('header').value;
			var obj = parent.document.getElementById('analyzedData_Paragraph_' + id);
			
			targetSpecialCombo.AddItem(id, header, header);
			if(obj)
				obj.value = paragraphs[i].firstChild.nodeValue;
			
		}
	}
}

DwSeoParagraphs.Initialize = function() {
	var obj = null;
	
	if(DwSeoParagraphs.PluginExistsOnToolbar()) {
		DwSeoParagraphs.InitializeGlobals();
				
		if(FCK.EditorDocument) {
			obj = FCKToolbarItems.LoadedItems['DwSeoParagraphs'];
			
			if(obj) {
				var node = null;
				var hiddenField = null;
				
				if(__currentParagraphID > 0) {
					hiddenField = parent.document.getElementById('analyzedData_Paragraph_' + __currentParagraphID);
					node = obj.Paragraphs.SelectSingleNode('Paragraphs/Paragraph[@id=' + __currentParagraphID + ']');
												
					if(hiddenField)
						hiddenField.value = FCK.GetData();
						
				} else {
					if(obj.Paragraphs) {
						var nodes = obj.Paragraphs.SelectNodes('Paragraphs/Paragraph');
						if(nodes && nodes.length > 0) {
							var curID = 0;
							
							node = nodes[0];
							curID = parseInt(node.attributes.getNamedItem('id').value);
							__currentParagraphID = curID;
							
							hiddenField = parent.document.getElementById('analyzedData_Paragraph_' + 
								curID);
							
							if(hiddenField)
								FCK.EditorDocument.body.innerHTML = hiddenField.value;
						}
					}
				}
				
				if(node)
					obj._Combo.SetLabel(node.attributes.getNamedItem('header').value);
			}
					
			FCKTools.AddEventListener(FCK.EditorDocument, 'keyup', DwSeoParagraphs.UpdateHiddenField);
		}
		
		if(FCK.EditingArea && FCK.EditingArea.Textarea)
			DwSeoParagraphs.InitializeEditorTextarea();
	}
}

DwSeoParagraphs.PluginExistsOnToolbar = function() {
	var items = FCK.ToolbarSet.Items;
	var ret = false;
	
	if(items) {
		for(var i = 0; i < items.length; i++)
			if(items[i].DwSeoPluginID) {
				ret = true;
				break;
			}
	}
	
	return ret;
}

DwSeoParagraphs.InitializeEditorTextarea = function() {
	var area = FCK.EditingArea.Textarea;
	if(area) {
		area.setAttribute('__seo__paragraphID', __currentParagraphID);
		SeoForm.AttachEvent('keyup', FCK.EditingArea.Textarea, SeoForm.OnFieldModified);
	}
}

DwSeoParagraphs.InitializeGlobals = function() {
	__seoForm_timeout = parent.__seoForm_timeout;
	__seoForm_fields = parent.__seoForm_fields;
	__seoForm_canUpdate = parent.__seoForm_canUpdate;
}

DwSeoParagraphs.UpdateHiddenField = function() {
	var obj = null;
	var callback = null;
	var id = '';
	
	if(__currentParagraphID > 0) {
		id = 'analyzedData_Paragraph_' + __currentParagraphID;
		obj = parent.document.getElementById(id);
		if(obj) {
			obj.value = FCK.GetData();
			if(SeoForm.IsFieldModified(id)) {
				SeoForm.UpdateCleanField(id);
				callback = obj.getAttribute('__seo_onchange');
				if(callback && callback.length > 0) {
					eval(callback);
				}
			}
		}
	}
}

var DwSeoParagraphsCommand = function(paragraphs) {
	this.Paragraphs = paragraphs;
}

DwSeoParagraphsCommand.prototype.Execute = function(itemText, itemLabel) {
	var obj = parent.document.getElementById('analyzedData_Paragraph_' + itemText)
	
	if(obj) {
		__currentParagraphID = parseInt(itemText);
		FCK.SetData(obj.value, true);
	}
}

DwSeoParagraphsCommand.prototype.GetState = function() {
	return;
}

var para = new DwSeoParagraphs('DwSeoParagraphs', FCK_TOOLBARITEM_ICONTEXT);

FCKCommands.RegisterCommand('DwSeoParagraphs', new DwSeoParagraphsCommand(para.Paragraphs));
FCKToolbarItems.RegisterItem('DwSeoParagraphs', para);

FCK.Events.AttachEvent('OnAfterSetHTML', DwSeoParagraphs.Initialize);