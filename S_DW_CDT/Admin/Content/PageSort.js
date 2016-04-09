var sortMarks;

function sort_init() {
    Position.includeScrollOffsets = true;
    Sortable.create("items", {
        onUpdate: function(element) {
            // nothing
        }
    });

    sortMarks = $('sort_name_up', 'sort_name_down', 'sort_created_up', 'sort_created_down', 'sort_updated_up', 'sort_updated_down');
}

function save_ajax(completeCallback) {
    new Ajax.Request("/Admin/Content/PageSort.aspx", {
        method: 'post',
        parameters: {
            "ParentPageID": $("ParentPageID").value,
            "AreaID": $("AreaID").value,
            "Pages": Sortable.sequence('items').join(','),
            "Save": "save"
        },
        onComplete: function (transport) {
            parent.left.UpdateMenuEntry($("ParentPageID").value);
            if (typeof (completeCallback) === 'function') {
                completeCallback();
            }
        }
    });
}

function save() {
    saveHandler(false);
}

function saveAndClose() {
    saveHandler(true);
}

function saveHandler(redirect) {

    var Wrapper = function (pageId, parentsId) {
        this.PageId = pageId;
        this.ParentsId = [];

        if (typeof (parentsId) === 'string') {
            if (parentsId !== '') {
                this.ParentsId = parentsId.split(',')
            }
        }

        this.OnComplete = function () { };
    };

    Wrapper.prototype.Handler = function (event) {
        if (this.ParentsId.length === 0) {
            // stop listening
            this.ToggleObserving(false);

            // invoke on complete handler
            this.OnComplete();
        } else {
            //get parent id
            var id = parseInt(this.ParentsId.pop(this.ParentsId.length - 1));

            //open node
            top.left.UpdateMenuEntry(id);
        }
    };

    // redirect to previous page
    Wrapper.prototype.ReturnToPage = function () {
        top.left.NewSelectedPageID = this.PageId;
        top.left.MakeBoldMenuEntry(this.PageId);
        top.left.restoreLastSelectedPage();
    };

    // refresh current page
    Wrapper.prototype.Refresh = function () {
        window.location.reload(true);
    };

    // subscribe / unsubscribe event listener
    Wrapper.prototype.ToggleObserving = function (toggle) {
        if (toggle === true) {
            Event.observe(top.left.document, 'menu:endToggle', this.Handler.bind(this));
        } else {
            Event.stopObserving(top.left.document, 'menu:endToggle');
        }
    };

    var selectedPageId = parseInt($("SelectedPageID").value);
    var selectedPageParentsID = $("SelectedPageParentsID").value;
    var callBack = function () { top.dwtop.myPage(); }; //if previous page was 'My Page'

    // need open tree to the current page
    if (selectedPageId !== 0) {
        //create wrapper
        var instance = new Wrapper(selectedPageId, selectedPageParentsID);

        //need to redirect
        if (redirect) {
            instance.OnComplete = instance.ReturnToPage;
        } else {
            instance.OnComplete = instance.Refresh;
        }

        //start listen event
        instance.ToggleObserving(true);

        // clear callback
        callBack = function () { };
    }

    save_ajax(callBack);
}

function cancel() {
    window.parent.location = "/Admin/default.aspx"
}

var sortOrder = "";

function sort(comparator, field) {
    var desc = sortOrder == field;
    sortOrder = desc ? "" : field;
    var items = $('items');
    var rows = items.childElements().sortBy(comparator);
    if (desc) rows.reverse();

    while (items.hasChildNodes())
        items.removeChild(items.firstChild); // clear
    rows.each(function f(e) { items.appendChild(e) });

    return desc;
}

function sort_name() {
    var dir = sort(function(s) { return s.children[1].innerHTML; }, "name");
    sortMarks.each(Element.hide);
    Element.show(dir ? "sort_name_down" : "sort_name_up");
}

function sort_created() {
    var dir = sort(function(s) { return s.children[2].innerHTML; }, "created");
    sortMarks.each(Element.hide);
    Element.show(dir ? "sort_created_down" : "sort_created_up");
}

function sort_updated() {
    var dir = sort(function(s) { return s.children[3].innerHTML; }, "updated");
    sortMarks.each(Element.hide);
    Element.show(dir ? "sort_updated_down" : "sort_updated_up");
}
