function SwitchImageView(name, enabled)
{
	var panel = parent.frames["ForumV2Panel"];
	var img;

	if(panel)
	{
		img = panel.document.getElementById(name);
		
		if (typeof img != "undefined" && img != null)
		{
			if(enabled)
				img.style.cssText = "";
			else
				img.style.cssText = "filter:progid:DXImageTransform.Microsoft.Alpha(opacity=70)progid:DXImageTransform.Microsoft.BasicImage(grayscale=1);"
		}
	}
}

function SwitchAnchorCursor(anchor, img)
{
	if(img.style.cssText == "")
		if(anchor.style.cursor == "default" || anchor.style.cursor == "")
			anchor.style.cursor = "hand";
		else
			anchor.style.cursor = "default";
	else
		anchor.style.cursor = "default";
	
}

function LoadPage(page)
{
	parent.frames["ForumV2Main"].location.href = page;
}

function LoadPageInFrame(frame, page)
{
	frame.location.href = page;
}

function LoadCategory(id)
{
	parent.frames["ForumV2Category"].location.href = "Category_List.aspx?CategoryID=" + id;
}

function ReloadFrame(frame)
{
	frame.location.reload();
}

function SelectListElement(element)
{
	element.style.cssText = "text-decoration: underline;";
}