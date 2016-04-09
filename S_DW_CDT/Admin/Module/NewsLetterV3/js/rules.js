
var rules = {
    list: function () {
        main.openInContentFrame("IntegrationRule_List.aspx");
    },

    back: function () {
        main.openInContentFrame("../IntegrationRule_List.aspx");
    },

    add: function () {
        rules.edit(0);
    },

    edit: function (ruleId) {
        var url = "Integration/EditNewsIntegration.aspx?ID=" + ruleId;
        main.openInContentFrame(url);
    },

    remove: function (ruleId) {
        if (main.confirmDelete()) {
            main.openInContentFrame("IntegrationRule_List_Delete.aspx?ID=" + ruleId);
        }
    },

    editClick: function () {
        var categoryId = ContextMenu.callingItemID;
        rules.edit(categoryId);
    },

    deleteClick: function () {
        var categoryId = ContextMenu.callingItemID;
        rules.remove(categoryId);
    }
}
