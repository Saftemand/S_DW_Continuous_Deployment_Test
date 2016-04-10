
var category = {
    list: function () {
        main.openInContentFrame("Category_List.aspx");
    },

    add: function () {
        category.edit(0);
    },

    edit: function (categoryId) {
        var url = "Category_edit.aspx?ID=" + categoryId;
        main.openInContentFrame(url);
        if (categoryId > 0) main.openCategoryNode(categoryId, true);
    },

    remove: function (categoryId) {
        if (main.confirmDelete()) {
            main.showWait();
            main.openInContentFrame("Category_List_Delete.aspx?ID=" + categoryId);
        }
    },

    checkEmails: function () {
        var url = "CategoriesToValidateList.aspx";
        main.openInContentFrame(url);
    },

    searchClick: function () {
        var itemID = ContextMenu.callingItemID.split('_');
        main.openSearch(itemID[0], itemID[1]);
    },

    editClick: function () {
        var categoryId = ContextMenu.callingItemID.split('_')[1];
        this.edit(categoryId);
    },

    editListClick: function () {
        var categoryId = ContextMenu.callingItemID;
        this.edit(categoryId);
    },

    deleteClick: function () {
        var categoryId = ContextMenu.callingItemID.split('_')[1];
        this.remove(categoryId);
    },

    deleteListClick: function () {
        var categoryId = ContextMenu.callingItemID;
        this.remove(categoryId);
    },

    restoreClick: function () {
        var categoryId = ContextMenu.callingItemID.split('_')[1];
        main.openInContentFrame("Category_List_Delete.aspx?action=1&ID=" + categoryId);
    },

    emptyBin: function () {
        if (main.confirmDelete()) {
            main.openInContentFrame("Category_List_Delete.aspx?action=2");
            var tree = main.getTree();
            tree.ajax_setNoChildren(8);
            tree.ajax_loadNodes(8, true);
        }
    }

}
