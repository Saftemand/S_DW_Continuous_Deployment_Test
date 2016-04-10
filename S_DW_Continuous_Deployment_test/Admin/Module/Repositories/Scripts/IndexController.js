app.controller("indexController", function ($scope, $http, $timeout, indexRepository) {

    $scope.index = null;
    $scope.status = null;
    $scope.instanceTypes = null;
    $scope.buildTypes = null;
    $scope.buildActions = null;
    $scope.fieldTypes = null;
    $scope.extensionTypes = null;
    $scope.preview = false;
    $scope.expandFields = false;

    $scope.fieldSources = null;
    $scope.draftField = null;
    $scope.selectedField = null;

    $scope.draftInstance = null;
    $scope.draftBuild = null;

    $scope.hasUserDefinedFieldTypes = false;

    $scope.types = [
        { groupName: 'System types', name: 'System.String' },
        { groupName: 'System types', name: 'System.Boolean' },
        { groupName: 'System types', name: 'System.Decimal' },
        { groupName: 'System types', name: 'System.Single' },
        { groupName: 'System types', name: 'System.Double' },
        { groupName: 'System types', name: 'System.Int16' },
        { groupName: 'System types', name: 'System.Int32' },
        { groupName: 'System types', name: 'System.Int64' },
        { groupName: 'System types', name: 'System.DateTime' },
        { groupName: 'System types', name: 'System.String[]' },
        { groupName: 'System types', name: 'System.Boolean[]' },
        { groupName: 'System types', name: 'System.Decimal[]' },
        { groupName: 'System types', name: 'System.Single[]' },
        { groupName: 'System types', name: 'System.Double[]' },
        { groupName: 'System types', name: 'System.Int16[]' },
        { groupName: 'System types', name: 'System.Int32[]' },
        { groupName: 'System types', name: 'System.Int64[]' },
        { groupName: 'System types', name: 'System.DateTime[]' }
    ];

    $scope.getIndex = function () {
        indexRepository.getIndex(function (results) {
            $scope.index = results;

            $scope.bindUserDefinedFieldTypes();
            $scope.bindFieldSources();
        });
    }

    $scope.setIndex = function () {

        $scope.MainForm.$setPristine();

        indexRepository.setIndex($scope.index, function (results) {
            $scope.getIndex();
        });
    }

    $scope.setIndexAndExit = function () {

        $scope.MainForm.$setPristine();

        indexRepository.setIndex($scope.index, function (results) {
            document.location.href = '/Admin/Module/Repositories/ViewRepository.aspx?id=' + repositoryclean;
        });
    }

    $scope.getStatus = function () {
        indexRepository.getStatus(function (results) {
            $scope.status = results;
            $timeout(function () { $scope.getStatus(); }, 3000);
        }, function (err) { $timeout(function () { $scope.getStatus(); }, 10000); });
    }

    $scope.getInstanceTypes = function () {
        indexRepository.getInstanceTypes(function (results) {
            $scope.instanceTypes = results;
        }, function (err) { });
    }

    $scope.getBuildTypes = function () {
        indexRepository.getBuildTypes(function (results) {
            $scope.buildTypes = results;
        }, function (err) { });
    }

    $scope.getBuildActions = function () {
        indexRepository.getBuildActions(function (results) {
            $scope.buildActions = results;
        }, function (err) { });
    }

    $scope.getFieldTypes = function () {
        indexRepository.getFieldTypes(function (results) {
            $scope.fieldTypes = results;
        }, function (err) { });
    }

    $scope.getExtensionTypes = function () {
        indexRepository.getExtensionTypes(function (results) {
            $scope.extensionTypes = results;
        }, function (err) { });
    }

    $scope.buildIndex = function (instance, build) {

        if ($scope.MainForm.$dirty) {
            alert(_messages.saveIndexBeforeBuild);
        }
        else {
            // do build
            $scope.status[instance].IsActive = true;
            indexRepository.buildIndex(instance, build, function (results) {
            });
        }
    }

    $scope.resumeIndex = function (instance, meta) {
        $scope.status[instance].IsActive = true;
        indexRepository.resumeIndex(instance, meta, function (results) {
        });
    }

    $scope.getLuceneIndexRootFolder = function () {
        return '/Files/System/Indexes/' + repositoryclean;
    };

    $scope.bindUserDefinedFieldTypes = function () {
        var groupName = 'Field types';
        var index = -1;

        for (var i = 0; i < $scope.types.length; i++) {
            if ($scope.types[i].groupName === groupName) {
                index = i;
                break;
            }
        }

        if (index > 0) {
            $scope.types.splice(index, $scope.types.length - index);
        }

        $scope.hasUserDefinedFieldTypes = false;

        // add user-defined field types
        if ($scope.index.Schema.FieldTypes) {
            for (var i = 0; i < $scope.index.Schema.FieldTypes.length; i++) {
                $scope.types.push({ groupName: groupName, name: $scope.index.Schema.FieldTypes[i].Name });
                $scope.hasUserDefinedFieldTypes = true;
            }
        }
    }

    $scope.bindFieldSources = function() {
        if ($scope.getNumberOfBuilds() > 0)
            $scope.getFieldSources($scope.index.Builds[Object.keys($scope.index.Builds)[0]].Type);
    }

    $scope.removeProp = function (name) {
        delete $scope.index.Settings[name];
    }

    $scope.insertSetting = function (name, value) {
        $scope.index.Settings[name] = value;
    }

    $scope.toggleFields = function () {
        $scope.expandFields = !$scope.expandFields;
    };

    $scope.openDlgSetting = function (name, val) {
        dialog.show('dlgSettings');
    }


    $scope.togglePreview = function () {
        $scope.setPreview(!$scope.preview);
    }

    $scope.setPreview = function (pview) {
        $scope.preview = pview;
    }

    $scope.removeField = function (index) {
        $scope.index.Schema.FieldsFromIndexDefinition.splice(index, 1);
        $scope.MainForm.$dirty = true;
    };

    $scope.hasExtensionFieldDefinition = function () {
        for (var i = 0; i < $scope.index.Schema.FieldsFromIndexDefinition.length; i++) {
            if ($scope.index.Schema.FieldsFromIndexDefinition[i].class == 'ExtensionFieldDefinition') {
                return true;
            }
        }
        return false;
    };

    $scope.getFieldSources = function (builderType) {
        indexRepository.getFieldSources(builderType, function(sources) {
            $scope.fieldSources = sources;
        });
    }

    /* DIALOGS */

    /* Instance Dialog */
    $scope.openInstanceDialog = function (name) {
        if (name) {
            $scope.draftInstance = angular.copy($scope.index.Instances[name]);
            $scope.draftInstance.originalName = name;
        }
        else {
            $scope.draftInstance = { Type: defaultInstanceType };
            $scope.draftInstance.originalName = 'new';
        }
        dialog.show('dlgInstance');
    }

    $scope.getNumberOfInstances = function () {
        if ($scope.index && $scope.index.Instances) {
            return Object.keys($scope.index.Instances).length;
        }
        return 0;
    }

    $scope.getNumberOfBuilds = function () {
        if ($scope.index && $scope.index.Builds) {
            return Object.keys($scope.index.Builds).length;
        }
        return 0;
    }

    $scope.saveInstanceDialog = function () {
        if ($scope.draftInstance.Name.length == 0) return;
        $scope.index.Instances[$scope.draftInstance.Name] = $scope.draftInstance;
        $scope.draftInstance = null;
        dialog.hide('dlgInstance');
    }

    $scope.deleteInstance = function (name) {
        delete $scope.index.Instances[name];
    }

    $scope.deleteBuild = function (name) {
        delete $scope.index.Builds[name];
    }

    /* Build Dialog */
    $scope.openBuildDialog = function (name) {
        if (name) {
            $scope.draftBuild = angular.copy($scope.index.Builds[name]);
            $scope.draftBuild.originalName = name;
        }
        else {
            var type = defaultBuildType;
            if ($scope.getNumberOfBuilds() > 0) {
                type = $scope.index.Builds[Object.keys($scope.index.Builds)[0]].Type;
            }
            $scope.draftBuild = { Type: type };
            $scope.draftBuild.originalName = 'new';
            $scope.setDefaultBuildAction(type);
        }

        if ($scope.draftBuild.Settings) {
            $scope.draftBuild.settingsArr = [];
            for (name in $scope.draftBuild.Settings) {
                $scope.draftBuild.settingsArr.push({ name: name, value: $scope.draftBuild.Settings[name] });
            }
        }

        dialog.show('dlgBuild');
    }

    $scope.setDefaultBuildAction = function (buildType) {
        if ($scope.buildActions[buildType] && $scope.buildActions[buildType].length > 0) {
            $scope.draftBuild.Action = $scope.buildActions[buildType][0];
        }
        else {
            $scope.draftBuild.Action = '';
        }
    };

    $scope.changeBuildType = function () {
        var buildType = $scope.draftBuild.Type;

        $scope.setDefaultBuildAction(buildType);
    };

    $scope.addSettingToBuild = function (draftBuild) {
        if (!draftBuild.settingsArr)
            draftBuild.settingsArr = [];

        draftBuild.settingsArr.push({ name: '', value: '' });
    }

    $scope.removeSettingFromBuild = function (draftBuild, index) {
        draftBuild.settingsArr.splice(index, 1);
    }

    $scope.saveBuildDialog = function () {
        if ($scope.draftBuild.Name.length == 0) return;
        if ($scope.draftBuild.Type.length == 0) return;
        if ($scope.draftBuild.Action.length == 0) return;

        if ($scope.draftBuild.settingsArr) {
            // validate, search duplicates 
            for (var i = 0; i < $scope.draftBuild.settingsArr.length; i++) {
                for (var j = 0; j < $scope.draftBuild.settingsArr.length; j++) {
                    if (i != j) {
                        if ($scope.draftBuild.settingsArr[i].name === $scope.draftBuild.settingsArr[j].name) {
                            alert(_messages.foundDuplicateNames);
                            return;
                        }
                    }
                }
            }
        }

        if ($scope.draftBuild.settingsArr) {
            $scope.draftBuild.Settings = {};

            for (var i = 0; i < $scope.draftBuild.settingsArr.length; i++) {
                var obj = $scope.draftBuild.settingsArr[i];
                $scope.draftBuild.Settings[obj.name] = obj.value;
            }

            $scope.draftBuild.settingsArr = null;
        }

        $scope.index.Builds[$scope.draftBuild.Name] = $scope.draftBuild;

        if ($scope.draftBuild.originalName != 'new' && $scope.draftBuild.originalName != $scope.draftBuild.Name) {
            delete $scope.index.Builds[$scope.draftBuild.originalName];
        }
        $scope.draftBuild = null;

        $scope.bindFieldSources();

        dialog.hide('dlgBuild');
    }

    /* Field Dialog */
    $scope.newFieldDialog = function (field) {
        $scope.selectedField = null;
        $scope.draftField = field || { class: 'FieldDefinition' };
        dialog.show('FieldDialog');
    }

    $scope.openFieldDialog = function (field) {
        $scope.selectedField = field;
        $scope.draftField = angular.copy(field);
        dialog.show('FieldDialog');
    }

    $scope.addFieldToCopyList = function (field) {
        if (!field.Sources)
            field.Sources = [];
        field.Sources.push('');
    };

    $scope.addGroupToGrouping = function (field) {
        if (!field.Groups) {
            field.Groups = [];
        }
        field.Groups.push({ Name: '', From: '', To: '' });
    };

    $scope.addExcludedField = function (field) {
        if (!field.ExcludedFields) {
            field.ExcludedFields = [];
        }
        field.ExcludedFields.push('');
    }

    $scope.removeExcludedField = function (field, index) {
        field.ExcludedFields.splice(index, 1);
    };

    $scope.removeGroupFromGrouping = function (field, index) {
        field.Groups.splice(index, 1);
    };

    $scope.saveFieldDialog = function () {
        if ($scope.draftField.class == 'ExtensionFieldDefinition' && $scope.draftField.Type.length == 0) return;
        if ($scope.draftField.class != 'ExtensionFieldDefinition' && $scope.draftField.Name.length == 0) return;

        if ($scope.draftField.class == 'CopyFieldDefinition') {
            $scope.draftField.Type = 'System.String';
        }

        if ($scope.selectedField) {
            $scope.selectedField.Name = $scope.draftField.Name;
            $scope.selectedField.SystemName = $scope.draftField.SystemName;
            $scope.selectedField.Type = $scope.draftField.Type;
            $scope.selectedField.Source = $scope.draftField.Source;
            $scope.selectedField.Analyzer = $scope.draftField.Analyzer;
            $scope.selectedField.Boost = $scope.draftField.Boost;
            $scope.selectedField.Indexed = $scope.draftField.Indexed;
            $scope.selectedField.Stored = $scope.draftField.Stored;
            $scope.selectedField.Analyzed = $scope.draftField.Analyzed;
            $scope.selectedField.Sources = $scope.draftField.Sources;
            $scope.selectedField.Groups = $scope.draftField.Groups;
            $scope.selectedField.ExcludedFields = $scope.draftField.ExcludedFields;

        }
        else {
            $scope.index.Schema.FieldsFromIndexDefinition.push($scope.draftField);
        }
        dialog.hide('FieldDialog');
    }

    $scope.removeCopyFieldSource = function (draftField, index) {
        draftField.Sources.splice(index, 1);
    }

    $scope.newFieldTypeDialog = function (fieldType) {
        $scope.selectedFieldType = null;
        $scope.draftFieldType = fieldType || { Name: '', Type: '', Boost: '', Analyzers: [] };
        dialog.show('FieldTypeDialog');
    }

    $scope.openFieldTypeDialog = function (fieldType) {
        $scope.selectedFieldType = fieldType;
        $scope.draftFieldType = angular.copy(fieldType);
        dialog.show('FieldTypeDialog');
    };

    $scope.saveFieldTypeDialog = function () {

        if ($scope.selectedFieldType) {
            $scope.selectedFieldType.Name = $scope.draftFieldType.Name;
            $scope.selectedFieldType.Type = $scope.draftFieldType.Type;
            $scope.selectedFieldType.Boost = $scope.draftFieldType.Boost;
            $scope.selectedFieldType.Analyzers = $scope.draftFieldType.Analyzers;
        }
        else {
            $scope.index.Schema.FieldTypes.push($scope.draftFieldType);
        }

        $scope.bindUserDefinedFieldTypes();

        dialog.hide('FieldTypeDialog');
    };

    $scope.removeFieldType = function (index) {
        $scope.index.Schema.FieldTypes.splice(index, 1);
        $scope.bindUserDefinedFieldTypes();
        $scope.MainForm.$dirty = true;
    };

    $scope.addAnalyzerToFieldType = function (fieldType) {
        if (!fieldType.Analyzers) {
            fieldType.Analyzers = [];
        }
        fieldType.Analyzers.push({ key: '', value: '' });
    };

    $scope.removeAnalyzerFromFieldType = function (fieldType, index) {
        fieldType.Analyzers.splice(index, 1);
        $scope.MainForm.$dirty = true;
    };

    $scope.analyzersDataSource = function (instanceType) {
        for (var i = 0; i < $scope.instanceTypes.length; i++) {
            if ($scope.instanceTypes[i].FullName === instanceType) {
                return $scope.instanceTypes[i].SupportedAnalyzers;
            }
        }

        return null;
    };

    /* Initial setup */
    $scope.getIndex();
    $scope.getStatus();
    $scope.getInstanceTypes();
    $scope.getBuildTypes();
    $scope.getBuildActions();
    $scope.getFieldTypes();
    $scope.getExtensionTypes();
});
