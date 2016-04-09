var DwTagsViewer = new Object();

DwTagsViewer.GetTagStyle = function()
{
	var ret = 'background-color: #c9d8ff; color: #000000; border: 1px solid #c4c4c4';
	
	if (FCKConfig.DwTagsViewerTagStyle != null && FCKConfig.DwTagsViewerTagStyle.length > 0)
		ret = FCKConfig.DwTagsViewerTagStyle;
		
	return ret;
}

DwTagsViewer.OnDoubleClick = function(obj)
{
	var dwtag = obj.getAttribute('_dwtag');
	var url = FCKConfig.DwTagsViewerHelpURL;
	
	if(url && url.length > 0)
	{
		if (obj.tagName == 'SPAN' && dwtag && dwtag.length > 0)
		{
			url = url.replace('{0}', dwtag);
			window.open(url, 'TagHelp');
		}
	}
}

DwTagsViewer.SetupSpan = function(span, name)
{
	span.innerHTML = name;
	span.style.cssText = DwTagsViewer.GetTagStyle();
	span.style.cursor = 'default';
	span.setAttribute('_dwtag', name);
}

DwTagsViewer.GetComment = function(protectedValue)
{
	return FCKConfig.ProtectedSource.Revert('<!--' + protectedValue + '-->');
}

DwTagsViewer.SetupClickListener = function()
{
	DwTagsViewer.ClickListener = function(e)
	{
		var dwtag = e.target.getAttribute('_dwtag');
		if (e.target.tagName == 'SPAN' && dwtag && dwtag.length > 0)
			FCKSelection.SelectNode(e.target);
	}

	FCK.EditorDocument.addEventListener('click', DwTagsViewer.ClickListener, true);
}

DwTagsViewer.ProcessHTML = function()
{
	if (FCK.EditMode == FCK_EDITMODE_WYSIWYG)
	{
		var expr = /\<\!--@(.*?)--\>/g;
		
		if (FCKBrowserInfo.IsIE)
		{
			var source = FCK.GetXHTML(FCKConfig.FormatSource);
			var tags = source.match(expr);
						
			if (tags)
			{
				for (var i = 0; i < tags.length; i++)
				{
					var name = tags[i].replace('<!--@', '').replace('-->', '');
										
					source = source.replace(tags[i], 
						'<span style="' + DwTagsViewer.GetTagStyle() +
						'" onresizestart="return false;" contenteditable="false" _dwtag="' + 
						name + '">' + name + '</span>');
				}
					
				FCK.EditorDocument.body.innerHTML = source;
			}
		}
		else
		{
			var	nodes = new Array() ;
			var iterator = FCK.EditorDocument.createTreeWalker(FCK.EditorDocument.body, NodeFilter.SHOW_COMMENT, 
				DwTagsViewer.AcceptNode, true);
			
			while ((node = iterator.nextNode()))
				nodes.push(node);
			
			for (var i = 0; i < nodes.length; i++)
			{
				var comment = DwTagsViewer.GetComment(nodes[i].nodeValue);
				var name = comment.replace('<!--@', '').replace('-->', '');
				var span = FCK.EditorDocument.createElement('span');
				
				DwTagsViewer.SetupSpan(span, name);
				nodes[i].parentNode.insertBefore(span, nodes[i]);
				nodes[i].parentNode.removeChild(nodes[i]);
			}
			
			DwTagsViewer.SetupClickListener();
		}
	}
}

DwTagsViewer.AcceptNode = function(node)
{
	var ret = NodeFilter.FILTER_SKIP;
	var comment = DwTagsViewer.GetComment(node.nodeValue);
	var expr = /\<\!--@(.*?)--\>/;
	
	if (expr.test(comment))
		ret = NodeFilter.FILTER_ACCEPT;
		
	return ret;
}

FCKXHtml.TagProcessors['span'] = function(node, htmlNode)
{
	var dwtag = htmlNode.getAttribute('_dwtag');
			
	if (dwtag != null && dwtag.length > 0)
		node = FCKXHtml.XML.createComment('@' + dwtag);
	else
		FCKXHtml._AppendChildNodes(node, htmlNode, false);

	return node;
}

FCK.Events.AttachEvent('OnAfterSetHTML', DwTagsViewer.ProcessHTML);
FCK.RegisterDoubleClickHandler(DwTagsViewer.OnDoubleClick, 'SPAN');