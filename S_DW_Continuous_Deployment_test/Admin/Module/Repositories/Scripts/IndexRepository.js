app.factory('indexRepository', function ($http) {
    return {

        getIndex: function (callback) {
            var url = "/Admin/Api/repositories/Index/" + repository + "/" + item + "/";
            $http.get(url).success(callback);
        },

        setIndex: function (data, callback) {
            var url = "/Admin/Api/repositories/Index/" + repository + "/" + item + "/";
            $http.post(url, data, {
                headers: {
                    'Content-Type': 'application/json'
                }
            }).success(callback).error(function (err) { alert(angular.toJson(err)); });
        },

        buildIndex: function (instance, build, incallback) {
            var url = "/Admin/Api/repositories/build/" + repository + "/" + item + "-index/" + instance + "/" + build + "/";
            $http.post(url, null, {
                headers: {
                    'Content-Type': 'application/json'
                }
            }).success(incallback);
        },

        resumeIndex: function (instance, meta, incallback) {
            var url = "/Admin/Api/repositories/resume/" + repository + "/" + item + "-index/" + instance + "/";
            $http.post(url, meta, {
                headers: {
                    'Content-Type': 'application/json'
                }
            }).success(incallback);
        },

        getStatus: function (callback, errorCallback) {
            var url = "/Admin/Api/repositories/_sys_status/" + repository + "/" + item + "/";
            $http.post(url).success(callback).error(errorCallback);
        },

        getInstanceTypes: function (callback, errorCallback) {
            var url = "/Admin/Api/repositories/_sys_instance_types/" + repository + "/" + item + "/";
            $http.post(url).success(callback).error(errorCallback);
        },

        getBuildTypes: function (callback, errorCallback) {
            var url = "/Admin/Api/repositories/_sys_build_types/" + repository + "/" + item + "/";
            $http.post(url).success(callback).error(errorCallback);
        },

        getBuildActions: function (callback, errorCallback) {
            var url = "/Admin/Api/repositories/_sys_build_actions/" + repository + "/" + item + "/";
            $http.post(url).success(callback).error(errorCallback);
        },

        getFieldTypes: function (callback, errorCallback) {
            //var url = "/Admin/Api/" + repository + "/" + item + "/_sys_field_types";
            //$http.post(url).success(callback).error(errorCallback);
            var fieldTypes = [];
            fieldTypes[0] = {
                Source: null,
                Type: 'FieldDefinition'
            };
            fieldTypes[1] = {
                Sources: [],
                Type: 'CopyFieldDefinition'
            };
            fieldTypes[2] = {
                Type: 'ExtensionFieldDefinition'
            };

            if (callback && typeof(callback) == 'function')
                callback(fieldTypes);
        },

        getFieldSources: function(builderType, callback, errorcallback) {
            var url = "/Admin/Api/repositories/_sys_field_sources/" + encodeURIComponent(builderType) + "/";
            $http.post(url).success(callback).error(errorcallback);
        },

        getExtensionTypes: function(callback, errorCallback) {
            var url = "/Admin/Api/repositories/_sys_extension_types/" + repository + "/" + item + "/";
            $http.post(url).success(callback).error(errorCallback);
        }
    }

});

