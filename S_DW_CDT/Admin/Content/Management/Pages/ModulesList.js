var sortMarks;


function sort_init() {
    Position.includeScrollOffsets = true;
    Sortable.create("items", {
        onUpdate: function (element) {
            // nothing
        }
    });


}


//<li id="Module_<%# Eval("ModuleID") %>" >
//  <span class="C1" style="padding-top: 2px;padding-left:5px;"><img src='<%# Eval("ImagePath")%>' /></span>
//  <span class="C2"><%# Eval("ModuleName")%></span>
//  <span class="C3" style="cursor:pointer;" ><img src="/Admin/Images/Icons/Delete.png" onclick="removeModule(<%# Eval("ModuleID") %>);" /></span>
//</li>

function addModule(moduleID, imgPath, moduleName) {
    dialog.hide('dlgChooseModule');

    var img1 = new Element('img', { 'src': imgPath });
    var spanC1 = new Element("span", { 'class': 'C1', 'style': 'padding-top: 2px;padding-left:5px;' });
    spanC1.insert(img1);

    var spanC2 = new Element("span", { 'class': 'C2' }).update(moduleName);

    var img2 = new Element('img', { 'src': '/Admin/Images/Icons/Delete.png', 'onclick': 'removeModule(' + moduleID + ');' });
    var spanC3 = new Element("span", { 'class': 'C3', 'style': 'cursor:pointer;' });
    spanC3.insert(img2);

    var li = new Element('li', { 'id': 'Module_' + moduleID });
    li.insert(spanC1);
    li.insert(spanC2);
    li.insert(spanC3);

    $('items').insert(li);
    Sortable.create("items");

}

function removeModule(moduleid) {
    if (confirm(moduleWillBeRemovedMessage))
    {
        var elt = $("Module_" + moduleid);
        elt.remove();
    }
}

function save() {
    new Ajax.Request("/Admin/Content/Management/Pages/ModulesList_cpl.aspx", 
    {
        method: 'post',
        parameters: 
        {
            "Modules": Sortable.sequence('items').join(','),
            "Save": "save"
        },
        onComplete: function (transport) 
        {
            window.location.reload(true);
        }
    });
}

function cancel() {
    window.location = "/Admin/Content/Management/Start.aspx";
}

