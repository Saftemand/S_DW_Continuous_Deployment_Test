if (typeof (google) != 'undefined') {
    if (typeof (google.load) != 'undefined') {
        google.load('search', '1');
    }
}

var Seo = new Object();

Seo.NotSupportedException = function(message) {
    this.message = message;
}

Seo.NotSupportedException.prototype.toString = function() {
    return this.message;
}

Seo.ArgumentException = function(message) {
    this.message = message;
}

Seo.ArgumentException.prototype.toString = function() {
    return this.message;
}

Seo.OutOfRangeException = function(message) {
    this.message = message;
}

Seo.OutOfRangeException.prototype.toString = function() {
    return this.message;
}

Seo.Keyword = function() {
    this.id = null;
    this.text = '';
    this.competition = 0;
}

Seo.Searcher = function() {
    this._queue = null;
    this._searchObject = null;
}

Seo.Searcher.prototype.fillCompetitions = function(keywords, params) {
    var obj = null;
    var index = 0;

    if (!params) {
        params = {};
    }

    if (!params.onComplete) {
        params.onComplete = function() { }
    }
    
    if (!this.get_isEnabled()) {
        throw new Seo.NotSupportedException('Google Search API is not available');
    } else if (!this.get_supportsQueue()) {
        throw new Seo.NotSupportedException('Requests can not be queued. Use "getCompetition" method instead');
    } else {
        if (keywords == null || keywords.length <= 0) {
            throw new Seo.ArgumentException('Argument not specified: keywords');
        } else {
            this._queue = new RequestQueue();

            this._queue.clear();
            this._queue.capacity = keywords.length;

            obj = this;

            for (var i = 0; i < keywords.length; i++) {
                this._queue.add(this, obj.getCompetition, [keywords[i], { language: params.language, onComplete: function(competition) {
                    keywords[index].competition = null;

                    if (typeof (competition) != 'undefined' && competition > 0) {
                        keywords[index].competition = parseInt(competition);
                    }

                    if (params.onItemComplete != null) {
                        params.onItemComplete(keywords[index]);
                    }

                    if (obj._queue.capacity == 1) {
                        params.onComplete(keywords);
                    } else {
                        obj._queue.next();
                    }

                    index += 1;
                } }]);
                }
            }
        }
    }

Seo.Searcher.prototype.get_searchObject = function() {
    if (this._searchObject == null) {
        if (this.get_isEnabled()) {
            this._searchObject = new google.search.WebSearch();
            this._searchObject.setRestriction(google.search.Search.RESTRICT_EXTENDED_ARGS, null);
            this._searchObject.setResultSetSize(google.search.Search.LARGE_RESULTSET);
        }
    }

    return this._searchObject;
}

Seo.Searcher.prototype.get_isEnabled = function() {
    return (typeof(google) != 'undefined' && typeof(google.search) != 'undefined' &&
        typeof(google.search.WebSearch) != 'undefined');
}

Seo.Searcher.prototype.get_supportsQueue = function() {
    return typeof(RequestQueue) != 'undefined';
}

Seo.Searcher.prototype.getCompetition = function (keyword, params) {
    var obj = this;
    var lr = '';
    var searcher = this.get_searchObject();

    if (!params) {
        params = {};
    }
    
    if (params.language) {
        lr = 'lang_' + params.language.toLowerCase();
    }

    if (!params.onComplete) {
        params.onComplete = function () { }
    }

    if (!this.get_isEnabled()) {
        throw new Seo.NotSupportedException('Google Search API is not available');
    } else {
        if (keyword == null) {
            throw new Seo.ArgumentException('Argument not specified: keyword');
        } else {
            if (lr.length > 0) {
                searcher.setRestriction(google.search.Search.RESTRICT_EXTENDED_ARGS, {
                    'lr': lr
                });
            }
            searcher.setSearchCompleteCallback(obj, function () {
                params.onComplete(searcher.cursor ? searcher.cursor.estimatedResultCount : 0);
            });

            searcher.execute(keyword.text);
        }
    }
}

Seo.Searcher.prototype.getResults = function(query, params) {
    var obj = this;
    var language = '';
    var searcher = this.get_searchObject();
    
    if (!params) {
        params = {};
    }

    if (!params.onComplete) {
        params.onComplete = function() { }
    }

    if (params.language) {
        language = params.language;
    }

    if (!this.get_isEnabled()) {
        document.getElementById("progressContainer").innerHTML = "<img src='/Admin/Images/Ribbon/Icons/Small/message_error.png'/><b>Google Search API is not available</b>"
        throw new Seo.NotSupportedException('Google Search API is not available');
    } else {
        if (query == null) {
            throw new Seo.ArgumentException('Argument not specified: keyword');
        } else {
            searcher.setSearchCompleteCallback(obj, function() {
                params.onComplete(searcher.results, searcher.cursor);
            });

            searcher.setRestriction(google.search.Search.RESTRICT_EXTENDED_ARGS, null);

            if (language && language.length > 0) {
                searcher.setRestriction(google.search.Search.RESTRICT_EXTENDED_ARGS, {
                    'lr': 'lang_' + language.toLowerCase()
                });
            }

            searcher.execute(query);
        }
    }
}

Seo.Progress = function(containerID) {
    this.containerID = containerID;
    this.maximum = 0;

    this._completed = 0;
    this._percentage = 0;
    this._container = null;

    if (this.containerID == null) {
        throw new Seo.ArgumentException('Argument not specified: containerID');
    }
}

Seo.Progress.prototype.get_completed = function() {
    return this._completed;
}

Seo.Progress.prototype.get_percentage = function() {
    return this._percentage;
}

Seo.Progress.prototype.set_completed = function(value) {
    if (value == null) {
        throw new Seo.ArgumentException('Argument not specified: value');
    } else if (isNaN(parseInt(value))) {
        throw new Seo.ArgumentException('Argument type mismatch: value');
    } else {
        this._completed = parseInt(value);

        if (this._completed < 0) {
            this._completed = 0;
            this._percentage = 0;
        } else if (this._completed > this.maximum) {
            this._completed = this.maximum;
            this._percentage = 100;
        } else {
            if (this.maximum != null && !isNaN(this.maximum) && this.maximum > 0) {
                this._percentage = Math.floor(100 * this._completed / this.maximum);
            } else {
                throw new Seo.OutOfRangeException('Property value is incorrect: maximum');
            }
        }
    }
}

Seo.Progress.prototype.set_percentage = function(value) {
    if (value == null) {
        throw new Seo.ArgumentException('Argument not specified: value');
    } else if (isNaN(parseInt(value))) {
        throw new Seo.ArgumentException('Argument type mismatch: value');
    } else {
        this._percentage = parseInt(value);

        if (this._percentage < 0) {
            this._percentage = 0;
            this._completed = 0;
        } else if (this._percentage > 100) {
            this._percentage = 100;
            this._completed = this.maximum;
        } else {
            if (this.maximum != null && !isNaN(this.maximum) && this.maximum > 0) {
                this._completed = Math.floor(this.maximum / 100 * this._percentage);
            } else {
                throw new Seo.OutOfRangeException('Property value is incorrect: maximum');
            }
        }
    }
}

Seo.Progress.prototype.update = function() {
    var percentageContainer = null;
    var container = this.get_container();

    if (container) {
        percentageContainer = container.select('.percentageValue');
        if (percentageContainer != null && percentageContainer.length > 0) {
            percentageContainer[0].innerHTML = this.get_percentage() + '%';
        }
    }
}

Seo.Progress.prototype.reset = function() {
    this._completed = 0;
    this._percentage = 0;
    this.update();
}

Seo.Progress.prototype.show = function() {
    this.setVisibility(true);
}

Seo.Progress.prototype.hide = function() {
    this.setVisibility(false);
}

Seo.Progress.prototype.setVisibility = function(isVisible) {
    var container = this.get_container();

    if (container) {
        if (isVisible) {
            container.show();
        } else {
            container.hide();
        }
    }
}

Seo.Progress.prototype.get_container = function() {
    if (this._container == null) {
        this._container = $(this.containerID);
    }
    
    return this._container;
}

Seo.Progress.prototype.dispose = function() {
    this._container = null;
}

Seo.PhrasesList = function(containerID) {
    this.containerID = containerID;
    this._queue = null;
    this._state = null;
}

Seo.PhrasesList.prototype.get_state = function() {
    return this._state;
}

Seo.PhrasesList.prototype.set_state = function(state) {
    this._state = state;
}

Seo.PhrasesList.prototype.update = function(params) {
    var obj = this;
    var rows = null;
    var c = $(this.containerID);
    var state = this.get_state();

    if (!params) {
        params = {}
    }
    
    if (c) {
        rows = c.select('tr.phraseRow');

        if (rows && rows.length > 0) {
            this._queue = new RequestQueue();

            this._queue.clear();
            this._queue.capacity = rows.length;

            if (state) {
                state.reset();
                state.show();
            }

            for (var i = 0; i < rows.length; i++) {
                this._queue.add(this, obj.updateRow, [{ language: params.language, row: rows[i], onComplete: function() {
                    if (obj._queue.capacity == 1) {
                        if (state) {
                            state.hide();
                        }
                        
                        if (typeof (params.onComplete) != 'undefined') {
                            params.onComplete();
                        }
                    } else {
                        obj._queue.next();
                    }
                } }]);
                }
            }
        }
    }

    Seo.PhrasesList.prototype.updateRow = function(params) {
        var phrase = '';
        var url = null;
        var searcher = null;

        if (!params) {
            params = {}
        }

        if (params.row) {
            phrase = params.row.select('td.phraseText');
            if (phrase && phrase.length > 0) {
                phrase = phrase[0].innerHTML;

                if (phrase && phrase.length > 0) {
                    phrase = '\"' + phrase + '\"';

                    searcher = new Seo.Searcher();
                    Seo.Searcher.prototype.getResults(phrase, {
                        language: params.language, 
                        onComplete: function(results, cursor) {
                            if (cursor) {
                                params.row.select('td.phraseCompetition').each(function(cell) {
                                    cell.innerHTML = cursor.estimatedResultCount;
                                });
                            }

                            if (results && results.length > 0) {
                                url = results[0].url;
                                if (url.length > 40) {
                                    url = url.substr(0, 35) + ' ...';
                                }

                                params.row.select('td.phraseTopResult').each(function(cell) {
                                    cell.innerHTML = url;
                                });
                            }

                            if (typeof (params.onComplete) != 'undefined') {
                                params.onComplete();
                            }
                        } 
                    });
                }
            }
        }
    }

Seo.SearchResultsList = function(containerID) {
    this.containerID = containerID;
    this.searchQuery = '';
    this.itemTemplate = '';
    this.state = null;
}

Seo.SearchResultsList.prototype.set_state = function(state) {
    this.state = state;
}

Seo.SearchResultsList.prototype.get_state = function() {
    return this.state;
}

Seo.SearchResultsList.prototype.set_searchQuery = function(searchQuery) {
    this.searchQuery = searchQuery;
}

Seo.SearchResultsList.prototype.get_searchQuery = function() {
    return this.searchQuery;
}

Seo.SearchResultsList.prototype.set_itemTemplate = function(template) {
    this.itemTemplate = template;
}

Seo.SearchResultsList.prototype.get_itemTemplate = function() {
    return this.itemTemplate;
}

Seo.SearchResultsList.prototype.render = function(params) {
    var obj = this;
    var tmpl = null;
    var searcher = null;
    var c = $(this.containerID);

    if (!params) {
        params = {}
    }

    if (!this.itemTemplate || this.itemTemplate.length == 0) {
        throw new Seo.NotSupportedException('ItemTemplate has not been specified.');
    } else {
        if (typeof (this.itemTemplate) == 'string') {
            tmpl = new Template(this.itemTemplate);
        }

        if (this.state) {
            this.state.reset();
            this.state.show();
        }

        c.update('');

        searcher = new Seo.Searcher();
        searcher.getResults(params.query, {
            language: params.language,
            onComplete: function(results) {
                if (obj.state) {
                    obj.state.hide();
                }

                for (var i = 0; i < results.length; i++) {
                    if (i > 9) break;

                    if (tmpl) {
                        c.update(c.innerHTML + tmpl.evaluate(results[i]));
                    } else {
                        obj.itemTemplate(c, results[i]);
                    }
                }

                if (typeof (params.onComplete) != 'undefined') {
                    params.onComplete();
                }
            }
        });
    }
}

Seo.CompareTable = function(containerID) {
    this.containerID = containerID;
    this.state = null;

    this.phrasesListID = null;
    this.competitorsListID = null;
    this.competitorTableContainerID = null;

    this._phrasesListObj = null;
    this._competitorsListObj = null;
    this._isBusy = false;
}

Seo.CompareTable.prototype.set_phrasesListID = function(phrasesListID) {
    this.phrasesListID = phrasesListID;
    this._phrasesListObj = null;
}

Seo.CompareTable.prototype.get_phrasesListID = function() {
    return this.phrasesListID;
}

Seo.CompareTable.prototype.set_competitorsListID = function(competitorsListID) {
    this.competitorsListID = competitorsListID;
    this._competitorsListObj = null;
}

Seo.CompareTable.prototype.get_competitorsListID = function() {
    return this.competitorsListID;
}

Seo.CompareTable.prototype.set_competitorTableContainerID = function(competitorTableContainerID) {
    this.competitorTableContainerID = competitorTableContainerID;
}

Seo.CompareTable.prototype.get_competitorTableContainerID = function() {
    return this.competitorTableContainerID;
}

Seo.CompareTable.prototype.get_phrasesListObject = function() {
    if (!this._phrasesListObj) {
        this._phrasesListObj = $(this.phrasesListID);
    }

    return this._phrasesListObj;
}

Seo.CompareTable.prototype.get_competitorsListObject = function() {
    if (!this._competitorsListObj) {
        this._competitorsListObj = $(this.competitorsListID);
    }

    return this._competitorsListObj;
}

Seo.CompareTable.prototype.set_state = function(state) {
    this.state = state;
}

Seo.CompareTable.prototype.get_state = function() {
    return this.state;
}

Seo.CompareTable.prototype.renderDropDownList = function(params) {
    var list = null;
    var phrase = this.get_phrasesListObject().getValue();

    if (!params) {
        params = {}
    }

    list = new Seo.SearchResultsList(this.get_competitorsListID());

    list.state = this.state;
    list.itemTemplate = function(container, data) {
        var opt = new Element('option');

        opt.text = data.url;
        opt.value = data.url;
        
        container.options.add(opt);
    }

    list.render({
        query: phrase,
        language: params.language,
        onComplete: function() {
            if (typeof (params.onComplete) != 'undefined') {
                params.onComplete();
            }
        }
    });
}

Seo.CompareTable.prototype.updateTitle = function(url) {
    var urlFriendly = url;
    var container = $$('td.cellChosenUrl');

    if (url && url.length > 0) {
        if (container && container.length > 0) {
            container = container[0];

            container.writeAttribute('title', url);
            container.select('a').each(function(elm) {
                elm.writeAttribute('href', url);

                if (url.length > 23) {
                    urlFriendly = url.substr(0, 23) + ' ...';
                }

                elm.update(urlFriendly);
            });
        }
    }
}

Seo.CompareTable.prototype.filterResultsByElement = function(results, elementName) {
    var ret = results;

    if (results && results.elements && results.elements.length > 0) {
        ret = { elements: [] }

        for (var i = 0; i < results.elements.length; i++) {
            if (results.elements[i].name == elementName) {
                ret.elements[ret.elements.length] = results.elements[i];
                break;
            }
        }
    }

    return ret;
}

Seo.CompareTable.prototype.clear = function() {
    var tab = $(this.get_competitorTableContainerID());
    
    if(tab)
        tab.update('');
        
    $(this.containerID).select('tr[__element]').each(function(elm) {
        $(elm).select('td.competitorData').each(function(dataCell) {
            Element.remove(dataCell);
        });
    });
}

Seo.CompareTable.prototype.set_isBusy = function(isBusy) {
    this._isBusy = isBusy;

    this.get_competitorsListObject().disabled = isBusy;
    this.get_phrasesListObject().disabled = isBusy;
}

Seo.CompareTable.prototype.get_isBusy = function() {
    return this._isBusy;
}

Seo.CompareTable.prototype.fillCompetitorData = function(params) {
    var obj = this;
    var url = this.get_competitorsListObject().getValue();
    var phrase = this.get_phrasesListObject().getValue();

    if (this.state) {
        this.state.reset();
        this.state.show();
    }

    this.clear();
    this.updateTitle(url);
    this.set_isBusy(true);

    this.getCompetitorCharacteristics({
        url: url,
        phrase: phrase,
        onComplete: function(results) {
            $(obj.containerID).select('tr[__element]').each(function(elm) {
                obj.renderCompetitorCharacteristics({
                    data: obj.filterResultsByElement(results, elm.readAttribute('__element')),
                    container: elm,
                    template: '<td class="competitorData" align="right" style="background-color:#e1e1e1">#{value}</td>'
                });
            });

            obj.getCompetitorTable({
                url: url,
                onComplete: function(html) {
                    obj.renderCompetitorTable({ html: html });

                    if (obj.state) {
                        obj.state.hide();
                    }

                    obj.set_isBusy(false);
                }
            });
        }
    });
}

Seo.CompareTable.prototype.getCompetitorCharacteristics = function(params) {
    var url = 'Compare.aspx?action=GetCompetitorCharacteristics';

    if (!params) {
        params = {}
    }

    if (!params.url) {
        throw new Seo.ArgumentException('Competitor\'s URL has not been specified. Parameter name: "url".');
    } else if (!params.phrase) {
        throw new Seo.ArgumentException('Target phrase has not been specified. Parameter name: "phrase".');
    } else {
        url += '&phrase=' + encodeURIComponent(params.phrase) + '&url=' + encodeURIComponent(params.url);
        
        new Ajax.Request(url, {
            method: 'get',
            onComplete: function(response) {
                if (typeof (params.onComplete) != 'undefined') {
                    params.onComplete(response.responseText.evalJSON());
                }
            }
        });
    }
}

Seo.CompareTable.prototype.getCompetitorTable = function(params) {
    var url = 'Compare.aspx?action=GetCompetitorTable';

    if (!params) {
        params = {}
    }

    if (!params.url) {
        throw new Seo.ArgumentException('Competitor\'s URL has not been specified. Parameter name: "url".');
    } else {
        url += '&url=' + encodeURIComponent(params.url);

        new Ajax.Request(url, {
            method: 'get',
            onComplete: function(response) {
                if (typeof (params.onComplete) != 'undefined') {
                    params.onComplete(response.responseText);
                }
            }
        });
    }
}

Seo.CompareTable.prototype.renderCompetitorCharacteristics = function(params) {
    var elm = null;
    var tmpl = null;

    if (!params) {
        params = {}
    }

    if (!params.data) {
        throw new Seo.ArgumentException('Data source has not been specified. Parameter name: "data".');
    } else if (!params.container) {
        throw new Seo.ArgumentException('Container has not been specified. Parameter name: "container".');
    } else if (!params.template) {
        throw new Seo.ArgumentException('Template has not been specified. Parameter name: "template".');
    } else {
        tmpl = new Template(params.template);

        if (params.data.elements && params.data.elements.length > 0) {
            for (var i = 0; i < params.data.elements.length; i++) {
                elm = params.data.elements[i];

                if (elm.characteristics && elm.characteristics.length > 0) {
                    for (var j = 0; j < elm.characteristics.length; j++) {
                        params.container.update(params.container.innerHTML + tmpl.evaluate(elm.characteristics[j]));
                    }
                }
            }
        }
    }
}

Seo.CompareTable.prototype.renderCompetitorTable = function(params) {
    var container = $(this.get_competitorTableContainerID());

    if (!params) {
        params = {}
    }

    if (container) {
        container.update(params.html);
    }
}

Seo.KeywordsList = function(containerID) {
    this.state = null;
    this.containerID = containerID;

    this._container = null; 

    if (this.containerID == null) {
        throw new Seo.ArgumentException('Argument not specified: containerID');
    }
}

Seo.KeywordsList.prototype.get_keywords = function() {
    var ret = [];
    var item = null;
    var checkboxes = null;
    var container = this.get_container();

    if (container) {
        checkboxes = container.select('tr[class~="keywordRow"] input[name="w"]');

        if (!checkboxes || checkboxes.length == 0) {
            checkboxes = container.select('tr[class="keywordRow"] input[name="w"]');
        }

        if (checkboxes && checkboxes.length > 0) {
            for (var i = 0; i < checkboxes.length; i++) {
                item = new Seo.Keyword();
                item.id = ret.length + 1;
                item.text = checkboxes[i].value;
                
                ret[ret.length] = item;
            }
        }
    }

    return ret;
}

Seo.KeywordsList.prototype.fillCompetitions = function(params) {
    var obj = this;
    var newList = [];
    var completeIndex = 0;
    var competitionValues = null;
    var searcher = new Seo.Searcher();
    var keywords = this.get_keywords();
    var container = this.get_container();

    if (!params) {
        params = {};
    }
    
    if (keywords.length > 0) {
        if (container) {
            competitionValues = container.select('td[class="competitionValue"]');
        }

        if (competitionValues != null && competitionValues.length > 0) {
            if (competitionValues.length < keywords.length) {
                for (var i = 0; i < competitionValues.length; i++) {
                    newList[newList.length] = keywords[i];
                }

                keywords = newList;
                newList = null;
            }

            if (this.state) {
                this.state.maximum = keywords.length;
                this.state.reset();
                this.state.show();
            }

            searcher.fillCompetitions(keywords, {
                language: params.language,
                onItemComplete: function(keyword) {
                    if (obj.state) {
                        obj.state.set_completed(obj.state.get_completed() + 1);
                        obj.state.update();
                    }

                    if (keyword.competition != null) {
                        competitionValues[completeIndex].innerHTML = keyword.competition;
                    } else {
                        competitionValues[completeIndex].innerHTML = 'NA';
                    }

                    completeIndex += 1;

                }, onComplete: function(keywords) {
                    if (obj.state) {
                        obj.state.set_percentage(100);
                        obj.state.hide();
                    }

                    if (params.onComplete != null) {
                        params.onComplete();
                    }
                }
            });
        }
    }
}

Seo.KeywordsList.prototype.get_container = function() {
    if (this._container == null) {
        this._container = $(this.containerID);
    }
    
    return this._container;
}

Seo.KeywordsList.prototype.dispose = function() {
    this._container = null;
}

Seo.KeywordsList.prototype.formatNumber = function(integer) {
    var original = (integer + ''), ret = '';
    var numberOfSpaces = 0, groupLength = 3;
    var startIndex, currentLength;

    if (original.length > groupLength) {
        numberOfSpaces = Math.floor(original.length / groupLength);
        if (original.length % groupLength == 0)
            numberOfSpaces--;

        for (var i = 1; i <= (numberOfSpaces + 1); i++) {
            startIndex = original.length - (groupLength * i);
            currentLength = groupLength;

            if (startIndex < 0) {
                currentLength += startIndex;
                startIndex = 0;
            }

            ret = original.substr(startIndex, currentLength) + ret;

            if (i < (numberOfSpaces + 1))
                ret = ',' + ret;
        }
    } else {
        ret = original;
    }

    return ret;
}