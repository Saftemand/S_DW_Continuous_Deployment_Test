app.controller("facetsController", function ($scope, $http, $timeout, facetsRepository) {

    $scope.facets = null;
    $scope.instanceTypes = null;

    $scope.draftInstance = null;
    $scope.Preview = true;

    $scope.draftField = null;
    $scope.selectedField = null;
    $scope.datasources = [];
    $scope.model = {};
    $scope.parameters = [];


    $scope.getFacets = function () {
        facetsRepository.getFacets(function (results) {
            $scope.facets = results;
            $scope.updateDataModel();
            $scope.updateDataParameters();
        });
    }

    $scope.setFacets = function () {
        facetsRepository.setFacets($scope.facets, function (results) { });
    }

    $scope.getDataSources = function () {
        facetsRepository.getDataSources(function (results) {
            res = [];
            for (var i = 0; i < results.length; i++) {
                if (results[i].Type == "Query")
                    res.push({
                        Repository: results[i].Repository,
                        Item: results[i].Name
                    });
            }
            $scope.datasources = res;
        });
    }

    $scope.updateDataModel = function () {
        facetsRepository.getModel($scope.facets.Source.Repository, $scope.facets.Source.Item, function (results) {
            $scope.model = results;

            if ($scope.model.Fields) {
                $scope.model.Fields.sort(function (a, b) {
                    return a.Name == b.Name ? 0 : a.Name < b.Name ? -1 : 1;
                })
            }
        });
    }

    $scope.updateDataParameters = function () {
        facetsRepository.getParameters($scope.facets.Source.Repository, $scope.facets.Source.Item, function (results) {
            $scope.parameters = results;
        });
    }

    $scope.isNoLongerAvailable = function (facet) {
        var res = true;

        angular.forEach($scope.parameters, function (param, key) {
            if (param.Name == facet.QueryParameter) {
                res = false;
            }
        });

        return res;
    }

    $scope.onFacetsSourceChanged = function () {
        $scope.updateDataModel();
        $scope.updateDataParameters();
    }

    $scope.setFacetsAndExit = function () {
        facetsRepository.setFacets($scope.facets, function (results) {
            document.location.href = '/Admin/Module/Repositories/ViewRepository.aspx?id=' + repositoryclean
        });
    }

    $scope.togglePreview = function () {
        $scope.setPreview(!$scope.preview);
    }

    $scope.setPreview = function (pview) {
        $scope.preview = pview;
    }

    /* Field Dialog */
    $scope.newFacetDialog = function (facet) {
        $scope.selectedFacet = null;
        $scope.draftFacet = facet || { Type: 'Field' };
        dialog.show('FacetDialog');
    }

    $scope.openFacetDialog = function (facet) {
        $scope.selectedFacet = facet;
        $scope.draftFacet = angular.copy(facet);
        dialog.show('FacetDialog');
    }

    $scope.saveFacetDialog = function () {
        if ($scope.selectedFacet) {
            $scope.selectedFacet.Name = $scope.draftFacet.Name;
            $scope.selectedFacet.Type = $scope.draftFacet.Type;
            $scope.selectedFacet.QueryParameter = $scope.draftFacet.QueryParameter;
            $scope.selectedFacet.Field = $scope.draftFacet.Field;
            $scope.selectedFacet.Options = $scope.draftFacet.Options;
        }
        else {
            $scope.facets.Items.push($scope.draftFacet);
        }
        dialog.hide('FacetDialog');
    }

    $scope.removeFacet = function (index) {
        $scope.facets.Items.splice(index, 1);
    }

    $scope.removeFacetOption = function (index) {
        $scope.draftFacet.Options.splice(index, 1);
    }

    $scope.getDataSources();
    $scope.getFacets();

});
