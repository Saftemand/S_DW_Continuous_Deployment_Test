var __seoForm_timeout = -1;
var __seoForm_fields = new Array();
var __seoForm_canUpdate = true;

var SeoXML = function(doc) {
	this.Document = doc;
}

SeoXML.prototype.SelectNodes = function(xpath, contextNode) {
	var ret = new Array();
	
	if(this.Document.evaluate) {
		var xPathResult = this.Document.evaluate(xpath, contextNode ? contextNode : this.Document, 
			this.Document.createNSResolver(this.Document.documentElement), XPathResult.ORDERED_NODE_ITERATOR_TYPE, null);
			
		if (xPathResult)
		{
			var node = null;
			while((node = xPathResult.iterateNext()))
				ret.push(node);
		}
	} else {
		if(contextNode)
			ret = contextNode.selectNodes(xpath);
		else
			ret = this.Document.selectNodes(xpath);
	}
		
	return ret;
}

var SeoField = function(id, name) {
    this.ID = id;
    this.Name = name;
}

var SeoForm = function() { }

SeoForm.AddField = function(field) {
    var obj = document.getElementById(field.ID);
    var fck = null;
    
	__seoForm_fields.push(field);
    SeoForm.CreateCleanField(field.ID);
	
    if(obj) {
        fck = obj.getAttribute('__fck');
        if(obj.tagName.toLowerCase() != 'textarea' || (!fck || fck.length == 0))
			SeoForm.AttachEvent('keyup', obj, SeoForm.OnFieldModified);   
        else 
            obj.setAttribute('__seo_onchange', 'SeoForm.OnFieldModified();');
    }
}

SeoForm.AttachEvent = function(eventName, obj, func) {
	if(obj.attachEvent)
		obj.attachEvent('on' + eventName, func);
	else if(obj.addEventListener)
		obj.addEventListener(eventName, func, false);
}

SeoForm.GetFieldPair = function(id) {
	var ret = null;
	var field1, field2;
	
	var doc = SeoForm.GetDocument();
		
	field1 = doc.getElementById(id);
	field2 = doc.getElementById(id + '_clean');
	
	if(field1 && field2) {
		ret = new Array();
		ret[0] = field1;
		ret[1] = field2;
	}
	
	return ret;
}

SeoForm.UpdateCleanField = function(id) {
	var fields = SeoForm.GetFieldPair(id);
	
	if(fields)
		fields[1].value = fields[0].value;
}

SeoForm.CreateCleanField = function(id) {
	var field = null;
	var obj = document.getElementById(id);
	
	if(obj) {
		field = document.createElement('INPUT');
		field.setAttribute('id', id + '_clean');
		field.setAttribute('type', 'hidden');
		field.setAttribute('value', obj.value);
		
		document.body.appendChild(field);
	}
}

SeoForm.IsFieldModified = function(id) {
	var fields = SeoForm.GetFieldPair(id);
	var ret = false;
	
	if(fields)
		ret = fields[0].value != fields[1].value;
		
	return ret;
}

SeoForm.OnFieldModified = function(e) {
	var evt = e ? e : window.event;
	var canProcess = true;
	var id = '';
	var sender = null;
		
	if(__seoForm_canUpdate) {
		if(evt) {
			sender = evt.target ? evt.target : evt.srcElement;
			id = sender.id;
			
			// sender - FCK 'View source' textarea
			if(id.length == 0) {
				var curPID = sender.getAttribute('__seo__paragraphID') + '';
				var doc = SeoForm.GetDocument();
				
				if(curPID && curPID.length > 0) {
					id = 'analyzedData_Paragraph_' + curPID;
					doc.getElementById(id).value = sender.value;
				}
			}
				
			canProcess = SeoForm.IsFieldModified(id, false);
		}
		
		if(canProcess) {
			if(evt)
				SeoForm.UpdateCleanField(id, false);
				
			if(__seoForm_timeout > 0)
			    clearTimeout(__seoForm_timeout);
			__seoForm_timeout = setTimeout(SeoForm.SendUpdate, 2000);
		}
	}
}

SeoForm.GetFormXML = function() {
	var xml = '<?xml version="1.0" encoding="utf-8" ?><Form>';
    var field = '';
	var doc = SeoForm.GetDocument();
	
	if(__seoForm_timeout > 0)
		clearTimeout(__seoForm_timeout);
		
    if(__seoForm_fields) {
        for(var i = 0; i < __seoForm_fields.length; i++) {
			field = 
                '<Field name="' + __seoForm_fields[i].Name + '">' + 
                    '<![CDATA[' + doc.getElementById(__seoForm_fields[i].ID).value + ']]>' + 
                '</Field>';
            xml += field;
        }
    }
    
    xml += '</Form>';
	return xml;
}

SeoForm.SendUpdate = function() {
	SeoForm.SendFormFields(SeoForm.GetFormXML(), 'update');   
}

SeoForm.GetDocument = function() {
	var doc = document;
	
	if(!doc.getElementById('urlsForm'))
		doc = parent.document;
		
	return doc;
}

SeoForm.GetUpdateScript = function(action) {
	var act = action ? action : 'update';
    var url = document.location.href;
    var script = '/Admin/Module/Seo/CheckList.aspx?action=' + act + '&ID=';
    var matches;
    
    if(parent)
        url = parent.document.location.href;
        
    matches = url.match(/ID=[0-9]{1,}/);
	if(matches && matches.length > 0)
			script += matches[0].replace('ID=', '');
			
	return script;
}

SeoForm.ToggleWait = function(enable) {
	var doc = SeoForm.GetDocument();
	var obj = doc.getElementById('imgWait');
	var cmd = doc.getElementById('analyzedData_cmdSave');
	
	__seoForm_canUpdate = !enable;
	if(obj && cmd) {
		obj.style.display = enable ? '' : 'none';
		cmd.disabled = enable;
	}
}

SeoForm.GetHttpRequestObject = function() {
    var xhttp = false;
    
	if (window.ActiveXObject) {  
        try {  
			xhttp = new ActiveXObject("MSXML2.XMLHTTP"); 
        } catch (e) { 
            try { 
                xhttp = new ActiveXObject("Microsoft.XMLHTTP"); 
            } catch (e) { 
                xhttp=false; 
            } 
        } 
	} 
    else if (window.XMLHttpRequest) { 
        try { 
                xhttp = new XMLHttpRequest();
        } catch (e) { 
            xhttp = false;
        } 
    }

	return xhttp;
}

SeoForm.Submit = function() {
	SeoForm.SendFormFields(SeoForm.GetFormXML(), 'submit');
}

SeoForm.EncodeParameter = function(param) {
	param = param.replace(/\</g, '&lt;');
	param = param.replace(/\>/g, '&gt;'); 
	param = param.replace(/\//g, '%2F');
	param = param.replace(/\?/g, '%3F');
	param = param.replace(/=/g, '%3D');
	param = param.replace(/&/g, '%26');
	param = param.replace(/@/g, '%40');
	
	return param;
}

SeoForm.SendFormFields = function(xml, action) {
    var script = SeoForm.GetUpdateScript(action);
    var xhttp = SeoForm.GetHttpRequestObject(SeoForm.OnResponseCame);
    var params = 'Form=' + SeoForm.EncodeParameter(xml);
    
    if(xhttp) {
        xhttp.open('POST', script, true);
        
        xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhttp.setRequestHeader("Content-length", params.length);
        xhttp.setRequestHeader("Connection", "close");
        
        xhttp.onreadystatechange = function() {
			if(xhttp.readyState == 4 && xhttp.status == 200) {
				SeoForm.ToggleWait(false);
				if(xhttp.responseXML)
					SeoForm.AssignResults(xhttp.responseXML);
			}
        };
        
		SeoForm.ToggleWait(true);
        xhttp.send(params);       
    }
}

SeoForm.AssignResults = function(xml) {
	var xmlObj = new SeoXML(xml);
	var doc = SeoForm.GetDocument();
	
	var phrases = xmlObj.SelectNodes('Phrases/Phrase');
	
	if(phrases) {
		for(var i = 0; i < phrases.length; i++) {
			var phraseID = phrases[i].attributes.getNamedItem('id').value;
			var elements = xmlObj.SelectNodes('Element', phrases[i]);
			
			if(elements) {
				for(var j = 0; j < elements.length; j++) {
					var elementName = elements[j].attributes.getNamedItem('name').value;
					var stats = xmlObj.SelectNodes('Statistic', elements[j]);
					
					if(stats) {
						for(var k = 0; k < stats.length; k++) {
							var statName = stats[k].attributes.getNamedItem('name').value;
							var statValue = stats[k].attributes.getNamedItem('value').value;
							var css = stats[k].attributes.getNamedItem('css').value;
							
							var cell = doc.getElementById(phraseID + ':' + elementName + ':' + statName);
							
							if(cell) {
								cell.innerHTML = statValue;
								if(css.length > 0)
									cell.className = css;
							}
						}
					}
				}
			}
		}
	}
}



