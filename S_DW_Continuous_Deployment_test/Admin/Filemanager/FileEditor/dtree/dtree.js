/*--------------------------------------------------|
| dTree 2.05 | www.destroydrop.com/javascript/tree/ |
|---------------------------------------------------|
| Copyright (c) 2002-2003 Geir Landrö               |
|                                                   |
| This script can be used freely as long as all     |
| copyright messages are intact.                    |
|                                                   |
| Updated: 17.04.2003                               |
|--------------------------------------------------*/

// Node object
function Node(id, pid, name, url, title, target, icon, iconOpen, open) {
	this.id = id;
	this.pid = pid;
	this.name = name;
	this.url = url;
	this.title = title;
	this.target = target;
	this.icon = icon;
	this.iconOpen = iconOpen;
	this._io = open || false;
	this._is = false;
	this._ls = false;
	// pvo: 01-10-2008 - first sibling flag
	this._fs = false;
	this._siblings = 0;
	//end: pvo: 01-10-2008
	this._hc = false;
	this._ai = 0;
	this._p;
};

// Tree object
function dTree(objName) {
	this.config = {
		target: null,
		folderLinks: true,
		useSelection: true,
		useCookies: true,
		useLines: true,
		useIcons: true,
		useStatusText: false,
		closeSameLevel: false,
		inOrder: false,
		showRoot: true
	}
	this.icon = {
		root: 'dtree/img/base.gif',
		folder: 'dtree/img/folder.gif',
		folderOpen: 'dtree/img/folderopen.gif',
		node: 'dtree/img/page.gif',
		empty: 'dtree/img/empty.gif',
		line: 'dtree/img/line.gif',
		join: 'dtree/img/join.gif',
		joinBottom: 'dtree/img/joinbottom.gif',
		joinTop: 'dtree/img/jointop.gif',
		plus: 'dtree/img/plus.gif',
		plusBottom: 'dtree/img/plusbottom.gif',
		plusTop: 'dtree/img/plustop.gif',
		minus: 'dtree/img/minus.gif',
		minusBottom: 'dtree/img/minusbottom.gif',
		minusTop: 'dtree/img/minustop.gif',
		nlPlus: 'dtree/img/nolines_plus.gif',
		nlMinus: 'dtree/img/nolines_minus.gif',
		minusOne: 'dtree/img/minus_one.gif',
		plusOne: 'dtree/img/plus_one.gif'
	};
	
	this.obj = objName;
	this.aNodes = [];
	this.aIndent = [];
	this.root = new Node(-1);
	this.selectedNode = null;
	this.selectedFound = false;
	this.completed = false;
};

// Adds a new node to the node array
dTree.prototype.add = function(id, pid, name, url, title, target, icon, iconOpen, open) {
	this.aNodes[this.aNodes.length] = new Node(id, pid, name, url, title, target, icon, iconOpen, open);
};

// Open/close all nodes
dTree.prototype.openAll = function() {
	this.oAll(true);
};
dTree.prototype.closeAll = function() {
	this.oAll(false);
};

// Outputs the tree to the page
dTree.prototype.toString = function() {
	var str = '<div class="dtree">\n';
	if (document.getElementById) {
		if (this.config.useCookies) this.selectedNode = this.getSelected();
		str += this.addNode(this.root);
	} else str += 'Browser not supported.';
	str += '</div>';
	if (!this.selectedFound) this.selectedNode = null;
	this.completed = true;
	return str;
};

// Creates the tree structure
dTree.prototype.addNode = function(pNode) {
	var str = '';
	var n = 0;
	if (this.config.inOrder) n = pNode._ai;
	for (n; n < this.aNodes.length; n++) {
		if (this.aNodes[n].pid == pNode.id) {
			var cn = this.aNodes[n];
			cn._p = pNode;
			cn._ai = n;
			this.setCS(cn);
			if (!cn.target && this.config.target) cn.target = this.config.target;
			if (cn._hc && !cn._io && this.config.useCookies) cn._io = this.isOpen(cn.id);
			if (!this.config.folderLinks && cn._hc) cn.url = null;
			if (this.config.useSelection && cn.id == this.selectedNode && !this.selectedFound) {
				cn._is = true;
				this.selectedNode = n;
				this.selectedFound = true;
			}
			str += this.node(cn, n);
			if (cn._ls) break;
		}
	}
	return str;
};

// Creates the node icon, url and text
dTree.prototype.node = function(node, nodeId) {
    // pvo: 01-10-2008 - hiding root node
	var str = '<div class="dTreeNode" style="display:' + ((!this.config.showRoot && this.root.id == node.pid) ? 'none' : '') + '">' + this.indent(node, nodeId);
	// end: pvo: 01-10-2008
	
	if (this.config.useIcons) {
		if (!node.icon) node.icon = (this.root.id == node.pid) ? this.icon.root : ((node._hc) ? this.icon.folder : this.icon.node);
		if (!node.iconOpen) node.iconOpen = (node._hc) ? this.icon.folderOpen : this.icon.node;
		if (this.root.id == node.pid) {
			node.icon = this.icon.root;
			node.iconOpen = this.icon.root;
		}
		str += '<img id="i' + this.obj + nodeId + '" src="' + ((node._io) ? node.iconOpen : node.icon) + '" alt="" />';
	}
	if (node.url) {
		str += '<a id="s' + this.obj + nodeId + '" class="' + ((this.config.useSelection) ? ((node._is ? 'nodeSel' : 'node')) : 'node');
		
		// pvo: 01-10-2008 - custom attributes
		
		if(node._hc || typeof(node.url) == 'string')
		    str += '" href="' + node.url + '" ';
		else {
		    str += '" href="#" ';
		    for(var eventName in node.url) {
		        str += eventName + '="' + node.url[eventName] + '" ';
		    }
		}
		// end: pvo: 01-10-2008
		
		//str += 'oncontextmenu="alert(\'' + nodeId + '\');return false;"';
		if (node.title) str += ' title="' + node.title + '"';
		if (node.target) str += ' target="' + node.target + '"';
		if (this.config.useStatusText) str += ' onmouseover="window.status=\'' + node.name + '\';return true;" onmouseout="window.status=\'\';return true;" ';
		if (this.config.useSelection && ((node._hc && this.config.folderLinks) || !node._hc))
			str += ' onclick="javascript: ' + this.obj + '.s(' + nodeId + ');"';
		str += '>';
	}
	else if ((!this.config.folderLinks || !node.url) && node._hc && node.pid != this.root.id)
		str += '<a href="javascript: ' + this.obj + '.o(' + nodeId + ');" class="node">';
	str += node.name;
	if (node.url || ((!this.config.folderLinks || !node.url) && node._hc)) str += '</a>';
	str += '</div>';
	if (node._hc) {
		str += '<div id="d' + this.obj + nodeId + '" class="clip" style="display:' + ((this.root.id == node.pid || node._io) ? 'block' : 'none') + ';">';
		str += this.addNode(node);
		str += '</div>';
	}
	this.aIndent.pop();
	return str;
};

// Adds the empty and line icons
dTree.prototype.indent = function(node, nodeId) {
	var str = '';
	var img = '';
	
	if (this.root.id != node.pid) {
		for (var n = 0; n < this.aIndent.length; n++)
			str += '<img src="' + ((this.aIndent[n] == 1 && this.config.useLines) ? this.icon.line : this.icon.empty) + '" alt="" />';
		(node._ls) ? this.aIndent.push(0) : this.aIndent.push(1);
		if (node._hc) {
			str += '<a href="javascript: ' + this.obj + '.o(' + nodeId + ');"><img id="j' + this.obj + nodeId + '" src="';
			if (!this.config.useLines) str += (node._io) ? this.icon.nlMinus : this.icon.nlPlus;
			
			// pvo: 01-10-2008
			else {
			    if(node._io) {
			        if(node._ls && this.config.useLines) {
			            if(node._siblings == 0)
			                str += this.icon.minusOne;
			            else
			                str += this.icon.minusBottom;
			        }
			        
			        else if(!this.config.showRoot && node._fs && this.config.useLines && this.aNodes[0].id == node.pid)
			            str += this.icon.minusTop;    
    			    else
    			        str += this.icon.minus;   
			    }
			    else {
			        if(node._ls && this.config.useLines) {
			            if(node._siblings == 0)
			                str += this.icon.plusOne;
			            else
    			            str += this.icon.plusBottom;
    			    }
    			    
    			    else if(!this.config.showRoot && node._fs && this.config.useLines && this.aNodes[0].id == node.pid)
    			        str += this.icon.plusTop;
    			    else
    			        str += this.icon.plus;   
			    }
			}
			//else str += ((node._io) ? ((node._ls && this.config.useLines) ? this.icon.minusBottom : this.icon.minus) : ((node._ls && this.config.useLines) ? this.icon.plusBottom : this.icon.plus));
			str += '" alt="" /></a>';
		} else {
		    if(this.config.useLines) {
		        if(node._fs && node.pid == this.aNodes[0].id) {
		                img = this.icon.joinTop;
		                
		                if(node._siblings == 0)
		                    img = this.icon.empty;
		        } else if(node._ls)
		            img = this.icon.joinBottom;
		        else
		            img = this.icon.join;
		    } else {
		        img = this.icon.empty;
		    }
		    
		    str += '<img src="' + img + '" alt="" />';    
		}
		
		//} else str += '<img src="' + ((this.config.useLines) ? ((node._ls) ? this.icon.joinBottom : this.icon.join) : this.icon.empty) + '" alt="" />';

		// end: pvo: 01-10-2008
	}
	return str;
};

// Checks if a node has any children and if it is the last sibling
dTree.prototype.setCS = function(node) {
	var lastId;
	var firstId = -1;
	var siblings = 0;
	
	for (var n = 0; n < this.aNodes.length; n++) {
		if (this.aNodes[n].pid == node.id) node._hc = true;
		if (this.aNodes[n].pid == node.pid) {
		    if(this.aNodes[n].id != node.id)
		        siblings++;
		    // searching for first sibling also
		    if(firstId < 0)
		        firstId = this.aNodes[n].id;
		    lastId = this.aNodes[n].id;
		} 
	}
	
	node._siblings = siblings;
	if (lastId == node.id) node._ls = true;
	if (firstId == node.id) node._fs = true;
};

// Returns the selected node
dTree.prototype.getSelected = function() {
	var sn = this.getCookie('cs' + this.obj);
	return (sn) ? sn : null;
};

// Highlights the selected node
dTree.prototype.s = function(id) {
	if (!this.config.useSelection) return;
	var cn = this.aNodes[id];
	if (cn._hc && !this.config.folderLinks) return;
	if (this.selectedNode != id) {
		if (this.selectedNode || this.selectedNode == 0) {
			eOld = document.getElementById("s" + this.obj + this.selectedNode);
			eOld.className = "node";
		}
		eNew = document.getElementById("s" + this.obj + id);
		eNew.className = "nodeSel";
		this.selectedNode = id;
		if (this.config.useCookies) this.setCookie('cs' + this.obj, cn.id);
	}
};

// Toggle Open or close
dTree.prototype.o = function(id) {
	var cn = this.aNodes[id];
	this.nodeStatus(!cn._io, id, cn._ls, cn._fs);
	cn._io = !cn._io;
	if (this.config.closeSameLevel) this.closeLevel(cn);
	if (this.config.useCookies) this.updateCookie();
};

// Open or close all nodes
dTree.prototype.oAll = function(status) {
	for (var n = 0; n < this.aNodes.length; n++) {
		if (this.aNodes[n]._hc && this.aNodes[n].pid != this.root.id) {
			this.nodeStatus(status, n, this.aNodes[n]._ls, this.aNodes[n]._fs)
			this.aNodes[n]._io = status;
		}
	}
	if (this.config.useCookies) this.updateCookie();
};

// Opens the tree to a specific node
dTree.prototype.openTo = function(nId, bSelect, bFirst) {
	if (!bFirst) {
		for (var n = 0; n < this.aNodes.length; n++) {
			if (this.aNodes[n].id == nId) {
				nId = n;
				break;
			}
		}
	}
	var cn = this.aNodes[nId];
	if (cn.pid == this.root.id || !cn._p) return;
	cn._io = true;
	cn._is = bSelect;
	if (this.completed && cn._hc) this.nodeStatus(true, cn._ai, cn._ls, cn._fs);
	if (this.completed && bSelect) this.s(cn._ai);
	else if (bSelect) this._sn = cn._ai;
	this.openTo(cn._p._ai, false, true);
};

// Closes all nodes on the same level as certain node
dTree.prototype.closeLevel = function(node) {
	for (var n = 0; n < this.aNodes.length; n++) {
		if (this.aNodes[n].pid == node.pid && this.aNodes[n].id != node.id && this.aNodes[n]._hc) {
			this.nodeStatus(false, n, this.aNodes[n]._ls, this.aNodes[n]._fs);
			this.aNodes[n]._io = false;
			this.closeAllChildren(this.aNodes[n]);
		}
	}
}

// Closes all children of a node
dTree.prototype.closeAllChildren = function(node) {
	for (var n = 0; n < this.aNodes.length; n++) {
		if (this.aNodes[n].pid == node.id && this.aNodes[n]._hc) {
			if (this.aNodes[n]._io) this.nodeStatus(false, n, this.aNodes[n]._ls, this.aNodes[n]._fs);
			this.aNodes[n]._io = false;
			this.closeAllChildren(this.aNodes[n]);
		}
	}
}

// Change the status of a node(open or closed)
dTree.prototype.nodeStatus = function(status, id, bottom, top) {
	eDiv = document.getElementById('d' + this.obj + id);
	eJoin = document.getElementById('j' + this.obj + id);
	if (this.config.useIcons) {
		eIcon = document.getElementById('i' + this.obj + id);
		eIcon.src = (status) ? this.aNodes[id].iconOpen : this.aNodes[id].icon;
	}
	
	// pvo: 01-10-2008
	var newImg = '';
	
	if(this.config.useLines) {
	    if(status) {
	        if(!this.config.showRoot && top && this.aNodes[id].pid == this.aNodes[0].id) {
	            newImg = this.icon.minusTop;
	            
	            if(this.aNodes[id]._siblings == 0)
	                newImg = this.icon.minusOne;
	        }
	        else if(bottom)
	            newImg = this.icon.minusBottom;
	        else
	            newImg = this.icon.minus;
	    } else {
	        if(!this.config.showRoot && top && this.aNodes[id].pid == this.aNodes[0].id) {
	            newImg = this.icon.plusTop;
	            
	            if(this.aNodes[id]._siblings == 0)
	                newImg = this.icon.plusOne;
	        }
	        else if(bottom)
	            newImg = this.icon.plusBottom;
	        else
	            newImg = this.icon.plus;
	    }
	} else {
	    if(status)
	        newImg = this.icon.nlMinus;
	    else
	        newImg = this.icon.nlPlus;
	}
	
	eJoin.src = newImg;
	
	// end: pvo: 01-10-2008
	
	/*eJoin.src = (this.config.useLines) ?
	((status) ? ((bottom) ? this.icon.minusBottom : this.icon.minus) : ((bottom) ? this.icon.plusBottom : this.icon.plus)) :
	((status) ? this.icon.nlMinus : this.icon.nlPlus);*/
	eDiv.style.display = (status) ? 'block' : 'none';
};


// [Cookie] Clears a cookie
dTree.prototype.clearCookie = function() {
	var now = new Date();
	var yesterday = new Date(now.getTime() - 1000 * 60 * 60 * 24);
	this.setCookie('co' + this.obj, 'cookieValue', yesterday);
	this.setCookie('cs' + this.obj, 'cookieValue', yesterday);
};

// [Cookie] Sets value in a cookie
dTree.prototype.setCookie = function(cookieName, cookieValue, expires, path, domain, secure) {
	document.cookie =
		escape(cookieName) + '=' + escape(cookieValue)
		+ (expires ? '; expires=' + expires.toGMTString() : '')
		+ (path ? '; path=' + path : '')
		+ (domain ? '; domain=' + domain : '')
		+ (secure ? '; secure' : '');
};

// [Cookie] Gets a value from a cookie
dTree.prototype.getCookie = function(cookieName) {
	var cookieValue = '';
	var posName = document.cookie.indexOf(escape(cookieName) + '=');
	if (posName != -1) {
		var posValue = posName + (escape(cookieName) + '=').length;
		var endPos = document.cookie.indexOf(';', posValue);
		if (endPos != -1) cookieValue = unescape(document.cookie.substring(posValue, endPos));
		else cookieValue = unescape(document.cookie.substring(posValue));
	}
	return (cookieValue);
};

// [Cookie] Returns ids of open nodes as a string
dTree.prototype.updateCookie = function() {
	var str = '';
	for (var n = 0; n < this.aNodes.length; n++) {
		if (this.aNodes[n]._io && this.aNodes[n].pid != this.root.id) {
			if (str) str += '.';
			str += this.aNodes[n].id;
		}
	}
	this.setCookie('co' + this.obj, str);
};

// [Cookie] Checks if a node id is in a cookie
dTree.prototype.isOpen = function(id) {
	var aOpen = this.getCookie('co' + this.obj).split('.');
	for (var n = 0; n < aOpen.length; n++)
		if (aOpen[n] == id) return true;
	return false;
};

// If Push and pop is not implemented by the browser
if (!Array.prototype.push) {
	Array.prototype.push = function array_push() {
		for (var i = 0; i < arguments.length; i++)
			this[this.length] = arguments[i];
		return this.length;
	}
};
if (!Array.prototype.pop) {
	Array.prototype.pop = function array_pop() {
		lastElement = this[this.length - 1];
		this.length = Math.max(this.length - 1, 0);
		return lastElement;
	}
};