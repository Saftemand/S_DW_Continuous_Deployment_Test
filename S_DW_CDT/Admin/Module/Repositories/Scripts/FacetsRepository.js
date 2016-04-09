app.factory('facetsRepository', function ($http) {
    return {

        getFacets: function (callback) {
            $http.get("/Admin/Api/repositories/Facets/" + repository + "/" + item + "/").success(callback);
        },

        setFacets: function (data, callback) {
            $http.post("/Admin/Api/repositories/Facets/" + repository + "/" + item + "/",
            data,
            {
                headers: {
                    'Content-Type': 'application/json'
                }
            }).success(callback).error(function (err) { alert(angular.toJson(err))});

        },

        getDataSources: function (callback) {
            $http.get("/Admin/Api/repositories/_sys_datasources").success(callback);
        },

        getModel: function (repository, item, callback) {
            $http.post("/Admin/Api/Repositories/_sys_model/" + repository + "/" + item + "/",
            null,
            {
                headers: {
                    'Content-Type': 'application/json'
                }
            }).success(callback);

        },

        getParameters: function (repository, item, callback) {
            $http.post("/Admin/Api/repositories/_sys_params/" + repository + "/" + item + "/",
            null,
            {
                headers: {
                    'Content-Type': 'application/json'
                }
            }).success(callback);

        },

    }

});

