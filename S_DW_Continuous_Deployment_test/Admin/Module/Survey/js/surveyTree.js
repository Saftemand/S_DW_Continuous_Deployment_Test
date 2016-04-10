
var surveyTree = {

    refreshTreeNode: function (nodeId) {
        var tree = window.parent.t;
        var serveyId = tree.getNodeByID(parseInt(nodeId));
        tree.ajax_loadNodes(serveyId._ai, true);
    },

    refreshTreeNodeName: function (nodeId, nodeName) {
        var tree = window.parent.t;
        var serveyId = tree.getNodeByID(parseInt(nodeId));
        serveyId.name = nodeName;
        tree.ajax_loadNodes(serveyId._ai, true);
    },


    refreshTree: function () {
        window.parent.t.ajax_loadNodes(0, false);
    }
}

