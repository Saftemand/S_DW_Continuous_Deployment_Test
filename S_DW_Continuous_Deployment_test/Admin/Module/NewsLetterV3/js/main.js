var main = {

    deleteMessage: "Delete?",

    contentFrame: function () {
        return document.getElementById("ContentFrame");
    },

    confirmDelete: function () {
        if (confirm(main.deleteMessage)) {
            return true;
        }
        return false;
    },

    getTree: function () {
        var tree;
        if (typeof (t) == 'undefined') {
            tree = window.parent.t;
        }
        else {
            tree = t;
        }
        return tree;
    },

    _selectedNode: 0,
    categoryNodeOnLoad: function (parentID) {
        if (_selectedNode) main.openCategoryNode(_selectedNode);
    },

    reloadCategories: function (categoryID) {
        var tree = this.getTree();
        var node2 = tree.getNodeByID(2);
        if (categoryID) {
            _selectedNode = categoryID;
            tree.ajax_loadNodes(2, true, main.categoryNodeOnLoad);
        }
        else
            tree.ajax_loadNodes(2, true);

        var node3 = tree.getNodeByID(3);
        if (node3._io) tree.ajax_loadNodes(3, true);
        else tree.ajax_markNode(3, false);
    },

    reloadDeleted: function () {
        var tree = this.getTree();
        tree.ajax_loadNodes(8, true);
    },

    reloadRules: function () {
        var tree = this.getTree();
        tree.ajax_loadNodes(4, true);
    },

    openCategoryNode: function (categoryID, justSelect) {
        var tree = this.getTree();
        if (!justSelect) {
            var node2 = tree.getNodeByID(2);
            if (!node2._io) tree.o(2);
        }

        var nodeId = 50000000 + parseInt(categoryID);
        var index = tree.nodeIndex(nodeId);

        tree.s(index);
        if (!justSelect) tree.ajax_loadNodes(index, false);
    },

    selectCategoryNode: function () {
        var tree = this.getTree();
        tree.s(2);
    },

    selectOutboxNode: function () {
        var tree = this.getTree();
        tree.s(6);
    },

    selectSentNode: function () {
        var tree = this.getTree();
        tree.s(3);
    },

    removeCategoryNode: function (categoryID) {
        this.hideWait();

        var nodeId = 50000000 + categoryID;
        this.removeTreeNode(nodeId);

        nodeId = 30000000 + categoryID;
        this.removeTreeNode(nodeId);

        this.reloadCategories();
    },

    removeRuleNode: function (ruleID) {
        var nodeId = 70000000 + ruleID;
        this.removeTreeNode(nodeId);

        this.reloadRules();
    },

    restoreCategoryNode: function (categoryID) {
        var nodeId = 40000000 + categoryID;
        this.removeTreeNode(nodeId);

        this.reloadDeleted();
        this.reloadCategories();
    },

    removeTreeNode: function (nodeId) {
        var tree = this.getTree();
        var nodeIndex = tree.nodeIndex(nodeId);
        tree.removeNode(nodeIndex);

        tree.selectedNode = null;
    },

    openInContentFrame: function (url) {
        url = this.makeUrlUnique(url);

        var cf = this.contentFrame();
        if (cf) {
            cf.src = url;
        }
        else if (window.opener) {
            window.opener.location.href = url; //open in opener window
        }
        else {
            window.location.href = url; //reload current window
        }
    },

    makeUrlUnique: function (url) {
        var s = "?";
        if (url.indexOf("?") > 0) {
            s = "&";
        }
        return url + s + "zzz=" + Math.random();
    },

    searchClick: function () {
        var folder = ContextMenu.callingItemID;
        this.openSearch(folder);
    },

    openSearch: function (folder, categoryID) {
        if (folder)
            if (categoryID)
                this.openInContentFrame("SearchPage.aspx?folder=" + folder + "&CategoryID=" + categoryID);
            else
                this.openInContentFrame("SearchPage.aspx?folder=" + folder);
        else
            this.openInContentFrame("SearchPage.aspx");
    },

    openCustomFields: function () {
        this.openInContentFrame("/Admin/Module/Common/CustomFields/CustomFields_List.aspx?context=NewsLetterV3_recipient");
    },

    showWait: function () {
        new overlay('PleaseWait').show();
    },

    hideWait: function () {
        parent.document.getElementById('PleaseWait').hide();
    }
}