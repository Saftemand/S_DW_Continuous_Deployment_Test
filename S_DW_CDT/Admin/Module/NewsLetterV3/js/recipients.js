var recipients = {

    listControl: {
        callingItem: function () {
            var item = ContextMenu.callingItemID;
            return eval("(" + item + ")");
        },

        contextMenuView: function (sender, args) {
            var row = recipients.listControl.callingItem();

            if (row.group) {
                ret = 'group';
            }
            else {
                if (row.active) ret = 'active';
                else ret = 'unactive';
            }

            return ret;
        }
    },

    listAll: function () {
        main.openInContentFrame("Recipient_List.aspx?active=2");
    },

    list: function (categoryID, active, openCategory) {
        if (active == undefined) active = 2; //both
        if (openCategory) main.openCategoryNode(categoryID);
        main.openInContentFrame("Recipient_List.aspx?categoryID=" + categoryID + "&active=" + active);
    },

    add: function (categoryID) {
        if (!categoryID) categoryID = 0;

        this.edit(0, categoryID, 1);
    },

    edit: function (recipientID, categoryID, active) {
        if (!recipientID) recipientID = 0;
        if (!categoryID) categoryID = 0;
        if (active == undefined) active = 2; //both

        main.openInContentFrame("Recipient_Edit.aspx?ID=" + recipientID + "&categoryID=" + categoryID + "&active=" + active);
    },

    importExport: function (categoryID) {
        if (!categoryID) categoryID = 0;

        main.openInContentFrame("Recipient_Import.aspx?categoryID=" + categoryID);
    },

    activate: function (recipientID, categoryID, active) {
        main.openInContentFrame("Recipient_List_Delete.aspx?type=state&categoryID=" + categoryID + "&recipientID=" + recipientID + "&Active=" + active);
    },

    editClick: function (categoryID, active) {
        var row = recipients.listControl.callingItem();
        var recipientID = row.id;
        this.edit(recipientID, categoryID, active);
    },

    statClick: function () {
        var row = recipients.listControl.callingItem();
        var recipientID = row.id;
        main.openInContentFrame("Statistics.aspx?ID=" + recipientID);
    },

    activeClick: function (categoryID, active) {
        var row = recipients.listControl.callingItem();
        var recipientID = row.id;
        this.activate(recipientID, categoryID, active);
    },

    deleteClick: function (categoryID, active) {
        var row = recipients.listControl.callingItem();
        var recipientID = row.id;
        if (main.confirmDelete()) {
            main.openInContentFrame("Recipient_List_Delete.aspx?type=delete&categoryID=" + categoryID + "&recipientID=" + recipientID + "&Active=" + active);
        }
    }

}
