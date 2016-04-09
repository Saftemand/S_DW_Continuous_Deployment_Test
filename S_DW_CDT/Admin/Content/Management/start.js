
function over(row) {
    row.className = 'over';
}
function out(row) {
    row.className = '';
}

function doClick(id) {
    var ret = true;
    var node = null;
    var selectedID = id;
    var treeInstance = null;

    if (parent && parent.t) {
        treeInstance = parent.t;

        if (treeInstance.aNodes.length > 1) {
            treeInstance.closeLevel(treeInstance.aNodes[1]);
            selectedID = selectNode(id, parent.t);

            ret = (selectedID == id);
            if (!ret) {
                node = treeInstance.getNodeByID(selectedID);
                if (node)
                    location.href = node.url;
            }
        }
    }

    return ret;
}

function selectNode(id, tree) {
    var ret = -1;
    var children = [];
    var node = tree.getNodeByID(id);

    if (node) {
        if (node.url && node.url.length > 0) {
            ret = id;
            tree.openTo(id, true);
            if (node._hc) {
                node._io = false;
                tree.o(node._ai);
            }
        } else {
            children = tree.getNodesByPID(node.id);
            if (children && children.length > 0) {
                ret = selectNode(children[0].id, tree);
            }
        }
    }

    return ret;
}