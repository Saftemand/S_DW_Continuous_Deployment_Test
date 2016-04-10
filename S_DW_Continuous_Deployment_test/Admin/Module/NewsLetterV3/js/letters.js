
var letters = {
    listDrafts: function () {
        main.openInContentFrame("NewsLetter_List.aspx?status=1");
    },

    listOutbox: function () {
        main.openInContentFrame("NewsLetter_List.aspx?status=2");
    },

    listSentItems: function (categoryID) {
        if (categoryID)
            main.openInContentFrame("NewsLetter_List.aspx?status=3&categoryID=" + categoryID);
        else
            main.openInContentFrame("NewsLetter_List.aspx?status=3");
    },

    listDeletedItems: function () {
        main.openInContentFrame("NewsLetter_List.aspx?status=4");
    },

    searchClick: function () {
        var itemID = ContextMenu.callingItemID;
        main.openSearch(3, itemID);
    },

    add: function (categoryID) {
        if (!categoryID) categoryID = 0;
        main.openInContentFrame("EditNewsletter.aspx?categoryID=" + categoryID);
    },

    edit: function (letterID) {
        main.openInContentFrame("EditNewsletter.aspx?NewsletterID=" + letterID);
    },

    editSMS: function (letterID) {
        main.openInContentFrame("EditSMSNewsletter.aspx?NewsletterID=" + letterID);
    },

    view: function (letterID) {
        main.openInContentFrame("ViewNewsletter.aspx?NewsletterID=" + letterID);
    },

    viewSMS: function (letterID) {
        main.openInContentFrame("ViewSMSNewsletter.aspx?NewsletterID=" + letterID);
    },

    addClick: function () {
        var categoryId = ContextMenu.callingItemID.split('_')[1];
        this.add(categoryId);
    },

    editClick: function () {
        var letterID = ContextMenu.callingItemID;
        this.edit(letterID);
    },

    viewClick: function () {
        var letterID = ContextMenu.callingItemID;
        this.view(letterID);
    },


    copyClick: function () {
        var letterID = ContextMenu.callingItemID;
        main.openInContentFrame("NewsLetter_List_Delete.aspx?type=copy&letterID=" + letterID);
    },

    deleteClick: function (categoryID, status) {
        var letterID = ContextMenu.callingItemID;
        if (main.confirmDelete()) {
            main.openInContentFrame("NewsLetter_List_Delete.aspx?type=delete&categoryID=" + categoryID + "&letterID=" + letterID + "&status=" + status);
        }
    }

}
