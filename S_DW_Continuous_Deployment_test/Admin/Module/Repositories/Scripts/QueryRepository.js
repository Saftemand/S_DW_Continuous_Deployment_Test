app.factory('queryRepository', function ($http) {
    return {

        getQuery: function (callback) {
            $http.get("/Admin/Api/repositories/Query/" + repository + "/" + item + "/").success(callback);
        },

        setQuery: function (data, callback) {
            $http.post("/Admin/Api/repositories/Query/" + repository + "/" + item + "/",
            data,
            {
                headers: {
                    'Content-Type': 'application/json'
                }
            }).success(callback).error(function (err) { alert(angular.toJson(err)) });

        },

        getDataSources: function (callback) {
            $http.get("/Admin/Api/repositories/_sys_datasources").success(callback);
        },

        getModel: function (repository, item, callback) {
            $http.post("/Admin/Api/repositories/_sys_model/" + repository + "/" + item + "/",
            null,
            {
                headers: {
                    'Content-Type': 'application/json'
                }
            }).success(callback);

        },

        getSupportedActions: function (callback) {
            $http.get("/Admin/Api/repositories/_sys_supported_actions").success(callback);
        },

        executeQuery: function (data, callback) {
            $http.post("/Admin/Api/repositories/execute/" + repository + "/" + item + "/",
            data,
            {
                headers: {
                    'Content-Type': 'application/json'
                }
            }).success(callback).error(function (err) { alert(angular.toJson(err)) });

        },

    }

});

