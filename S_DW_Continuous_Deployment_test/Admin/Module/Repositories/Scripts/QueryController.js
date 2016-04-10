app.controller("queryController", function ($scope, $http, $timeout, queryRepository) {

    $scope.query = null;
    $scope.instanceTypes = null;
    $scope.search = {};
    $scope.search.parameters = {};
    $scope.search.result = {};
    $scope.datasources = [];
    $scope.supportedActions = [];
    $scope.model = {};


    $scope.draftInstance = null;


    $scope.getQuery = function () {
        queryRepository.getQuery(function (results) {
            $scope.query = results;
            $scope.updateDataModel();
        });
    }

    $scope.setQuery = function () {
        queryRepository.setQuery($scope.query, function (results) {
        });
    }

    $scope.setQueryAndExit = function () {
        queryRepository.setQuery($scope.query, function (results) {
            document.location.href = '/Admin/Module/Repositories/ViewRepository.aspx?id=' + repositoryclean
        });
    }


    $scope.getInstanceTypes = function () {
        queryRepository.getInstanceTypes(function (results) {
            $scope.instanceTypes = results;
        }, function (err) { });
    }

    $scope.getDataSources = function () {
        queryRepository.getDataSources(function (results) {
            res = [];
            for (var i = 0; i < results.length; i++) {
                if (results[i].Type == "Index")
                    res.push({
                        Repository: results[i].Repository,
                        Item: results[i].Name,
                        Type: results[i].Provider
                    });
            }
            $scope.datasources = res;
        });
    }

    $scope.updateDataModel = function () {
        queryRepository.getModel($scope.query.Source.Repository, $scope.query.Source.Item, function (results) {
            $scope.model = results;

            if ($scope.model.Fields) {
                $scope.model.Fields.sort(function (a, b) {
                    return a.Name == b.Name ? 0 : a.Name < b.Name ? -1 : 1;
                })
            }
        });
    }

    $scope.getSupportedActions = function () {
        queryRepository.getSupportedActions(function (results) {
            res = [];
            for (var i = 0; i < results.length; i++) {
                var vals = results[i].split(':');
                res.push({
                    original: results[i],
                    namespace: vals[0],
                    name: vals[1]
                });
            }
            $scope.supportedActions = res;
        });
    }

    $scope.addExpression = function (parent) {
        var binaryExpr = { 'class': 'BinaryExpression', Left: { "Field": null, "class": "FieldExpression" } };

        if (parent) {
            parent.Expressions.push(binaryExpr);
        }
        else {
            $scope.query.Expression = binaryExpr;
        }
    }

    $scope.addExpressionGroup = function (parent) {
        var groupExpr = { 'class': 'GroupExpression', Operator: 'And', Expressions: [{ 'class': 'BinaryExpression', Left: { "Field": null, "class": "FieldExpression" } }] };

        if (parent) {
            parent.Expressions.push(groupExpr);
        }
        else {
            $scope.query.Expression = groupExpr;
        }
    }

    $scope.haveExpressions = function () {
        if ($scope.query && $scope.query.Expression)
            return true;

        return false;
    }

    $scope.deleteExpression = function ($scope, index) {
        if (index == 0 && !$scope.$parent.$parent.expr) {
            $scope.query.Expression = null;
        }
        else {
            var arr = $scope.$parent.$parent.expr.Expressions;
            if (arr) {
                arr.splice(index, 1);
            }
        }
    }

    $scope.deleteExpressionGroup = function ($scope, index) {
        $scope.deleteExpression($scope, index);
    }

    $scope.removeProp = function (name) {
        delete $scope.query.Settings[name];
    }

    $scope.insertSetting = function (name, value) {
        $scope.query.Settings[name] = value;
    }


    $scope.openDlgSetting = function (name, val) {
        document.getElementById('dlgSettingName').value = name;
        document.getElementById('dlgSettingValue').value = val;
        dialog.show('dlgSetting');
    }

    $scope.saveDlgSetting = function () {

        if (document.getElementById('dlgSettingName').value.length > 0) {
            alert(document.getElementById('dlgSettingName').value + document.getElementById('dlgSettingValue').value)
            $scope.query.Settings[document.getElementById('dlgSettingName').value] = document.getElementById('dlgSettingValue').value;
            dialog.hide('dlgSetting');
        }

    }


    /* DIALOGS */


    /* Search Dialog */
    $scope.openSearchDialog = function () {
        $scope.search = {};
        $scope.search.parameters = {};
        $scope.search.result = {};

        dialog.show('dlgSearch');
    }

    $scope.executeQuery = function () {
        queryRepository.executeQuery($scope.search.parameters, function (results) {
            $scope.search.result = results;
        });

    }

    $scope.togglePreview = function () {
        $scope.setPreview(!$scope.preview);
    }

    $scope.setPreview = function (pview) {
        $scope.preview = pview;
    }

    $scope.removeQueryParameter = function (index) {
        $scope.query.Parameters.splice(index, 1);
    }

    $scope.openParameterDialog = function (param) {
        if (param) {
            $scope.selectedParam = param;
            $scope.draftParam = angular.copy(param);
        }
        else {
            $scope.selectedParam = null;
            $scope.draftParam = {}; // new parameter
        }
        dialog.show('ParameterDialog');
    }

    $scope.saveParameterDialog = function () {
        if ($scope.selectedParam) {
            $scope.selectedParam.Name = $scope.draftParam.Name;
            $scope.selectedParam.Type = $scope.draftParam.Type;
            $scope.selectedParam.DefaultValue = $scope.draftParam.DefaultValue;
        }
        else {
            if (!$scope.query.Parameters) {
                $scope.query.Parameters = [];
            }
            $scope.query.Parameters.push(angular.copy($scope.draftParam));
        }
        dialog.hide('ParameterDialog');
    }

    $scope.openSortingDialog = function (sort) {
        if (sort) {
            $scope.selectedSort = sort;
            $scope.draftSort = angular.copy(sort);
        }
        else {
            $scope.selectedSort = null;
            $scope.draftSort = {}; // new sorting
        }
        dialog.show('SortOrderDialog');
    }

    $scope.saveSortingDialog = function () {
        if ($scope.selectedSort) {
            $scope.selectedSort.Field = $scope.draftSort.Field;
            $scope.selectedSort.SortDirection = $scope.draftSort.SortDirection;
        }
        else {
            if (!$scope.query.SortOrder) {
                $scope.query.SortOrder = [];
            }
            $scope.query.SortOrder.push(angular.copy($scope.draftSort));
        }
        dialog.hide('SortOrderDialog');
    }

    $scope.removeSortingParameter = function (index) {
        $scope.query.SortOrder.splice(index, 1);
    }

    $scope.editExpression = function (expr) {
        $scope.selectedExpression = expr;

        if (expr.Right) {
            $scope.rightExpressionDraft = angular.copy(expr.Right);
        }
        else {
            $scope.rightExpressionDraft = {}; // new right expression
        }

        dialog.show('EditExpressionDialog');
    }

    $scope.saveEditExpressionDialog = function () {
        if (!$scope.selectedExpression) {
            console.log("expression not set");
            return;
        }

        var expr = $scope.selectedExpression;
        expr.Right = {};
        expr.Right.class = $scope.rightExpressionDraft.class;

        if (expr.Right.class == 'ConstantExpression') {
            expr.Right.Value = $scope.rightExpressionDraft.Value;
            expr.Right.Type = $scope.rightExpressionDraft.Type;
        }
        else if (expr.Right.class == 'ParameterExpression') {
            expr.Right.VariableName = $scope.rightExpressionDraft.VariableName;
        }
        else if (expr.Right.class == 'MacroExpression') {
            expr.Right.LookupString = $scope.rightExpressionDraft.LookupString;
        }

        $scope.rightExpressionDraft = null;
        dialog.hide('EditExpressionDialog');

    }

    $scope.getDataSources();
    $scope.getQuery();
    $scope.getSupportedActions();

});
