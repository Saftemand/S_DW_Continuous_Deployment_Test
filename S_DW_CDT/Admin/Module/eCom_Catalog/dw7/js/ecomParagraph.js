
var backend = {
    patterns: null,
    index: 1,

    initPatternImages: function (json) {
        window["paragraphEvents"].setBeforeSave(backend.beforeParagraphSave);

        var arrStr = $('ImagePatternInit').value;
        if (arrStr != null && arrStr != '') {
            var arr = eval(arrStr);
            backend.patterns = arr;
        }

        if (arr == null || arr.count == 0) {
            return;
        }

        backend.patterns.each(function (item) {
            item.key = backend.index;
            backend.createPattern(item, backend.index);
            backend.index++;
        });
    },

    beforeParagraphSave: function () {
        if (backend.patterns == null) {
            return;
        }

        backend.patterns.each(function (item) {
            var key = item.key;

            item.name = $('ImagePatternName' + key).value;
            item.pattern = $('ImagePattern' + key).value;
            item.width = $('ImagePatternWidth' + key).value;
            item.height = $('ImagePatternHeight' + key).value;
        });

        var altJson = Object.toJSON(backend.patterns);

        var regex = new RegExp("\"", "g");
        altJson = altJson.replace(regex, "&quot;"); //because method in paragraph save replace " to string.Empty :(

        $('AltImagePatterns').value = altJson;
    },

    createPatternAuto: function () {
        if (backend.patterns == null) {
            backend.patterns = new Array();
        }

        var item = {
            'key': backend.index,
            'name': 'Alt_' + backend.index,
            'pattern': '',
            'width': '',
            'height': ''
        };

        backend.patterns.push(item);

        backend.createPattern(item, backend.index);
        backend.index++;
    },

    createPattern: function (item, index) {
        $('AlternativePictureHeader').style.display = '';

        var clone = $('AlternativePicture').clone(true);

        clone.id = clone.id + index;
        clone.style.display = "";

        backend.setInput(clone, "ImagePatternName", item.name, index);
        backend.setInput(clone, "ImagePattern", item.pattern, index);
        backend.setInput(clone, "ImagePatternWidth", item.width, index);
        backend.setInput(clone, "ImagePatternHeight", item.height, index);

        var imgDelete = clone.select('#imagePatternDelete')[0];
        imgDelete.id = imgDelete.id + index;
        imgDelete.writeAttribute({ 'key': index });

        $('imagePatternBottom').insert({ 'before': clone });
    },

    setInput: function (row, id, value, index) {
        var newId = id + index;

        var input = row.select('#' + id)[0];
        input.id = newId;
        input.name = newId;
        input.value = value;
    },

    addPattern: function () {
        backend.createPatternAuto();
    },

    deleteImage: function (img) {
        var index = 0;
        var key;
        var imgkey = img.readAttribute('key');
        backend.patterns.each(function (item) {
            if (item.key == imgkey) {
                key = item.key;
                throw $break;
            }
            index++;
        });

        backend.patterns.splice(index, 1);

        $('AlternativePicture' + key).remove();

        if (backend.patterns.length == 0) {
            $('AlternativePictureHeader').style.display = 'none';
        }
    }
}