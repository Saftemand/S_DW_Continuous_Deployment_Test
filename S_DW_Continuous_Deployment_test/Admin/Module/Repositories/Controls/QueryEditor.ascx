<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="QueryEditor.ascx.vb" Inherits="Dynamicweb.Admin.Repositories.Controls.QueryEditor" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register TagPrefix="de" Namespace="Dynamicweb.Extensibility" Assembly="Dynamicweb" %>
<%@ Register TagPrefix="omc" Namespace="Dynamicweb.Controls.OMC" Assembly="Dynamicweb.Controls" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!-- Source -->
<dw:GroupBox ID="SourceGroup" runat="server" Title="Source" DoTranslation="true">
    <table>
        <tr>
            <td class="left-label"><dw:TranslateLabel Text="Query" runat="server" /></td>
            <td>
                <select class="std" ng-change="updateDataModel();" ng-model="query.Source" ng-options="ds.Item group by ds.Repository for ds in datasources track by ds.Item">
                </select>
            </td>
        </tr>
    </table>
</dw:GroupBox>

<!-- PARMETERS -->
<dw:GroupBox ID="ParametersGroup" runat="server" Title="Parameters" DoTranslation="true">
    <div id="item" style="border: 1px solid rgba(188, 203, 223, 1);border-bottom:none;margin:3px;">
        <ul>
            <li class="header">
                <span class="pipe"></span><span class="C1"><%=Translate.Translate("Value")%></span>
                <span class="pipe"></span><span class="C2"><%=Translate.Translate("Type")%></span>
                <span class="pipe"></span><span class="C3"><%=Translate.Translate("Default Value")%></span>
            </li>
        </ul>

        <ul id="items2" style="position: relative;">
            <li class="item-field" style="position: relative;" ng-click="openParameterDialog(param);" ng-repeat="param in query.Parameters">
                <span class="C1" >{{param.Name}}</span>
                <span class="C2" >{{param.Type}}</span>
                <span class="C3" >{{param.DefaultValue}}</span>
                <span class="C4" style="float:right;"><a href="" ng-click="removeQueryParameter($index);"><img src="/Admin/Images/Icons/Delete_vsmall.gif" /></a></span>
            </li>
        </ul>
    </div>
</dw:GroupBox>

<dw:GroupBox ID="ExpressionsGroup" runat="server" Title="Expressions" DoTranslation="true">
        <div class="main-content clearfix">
            <div class="container" style="position: relative;">
                <div ng-include="'Expression2.html'" ng-repeat="expr in [query.Expression]"></div>
                <div ng-show="!haveExpressions()">
                    <button ng-click="addExpression()"><%=Translate.Translate("Add expression")%></button>
                    <button ng-click="addExpressionGroup();"><%=Translate.Translate("Add group")%></button>
                </div>
            </div>
        </div>
</dw:GroupBox>

<script type="text/ng-template" id="GroupExpression.html">
    AND
    <div style="padding-left:20px;">
    <ul>
        <li ng-include="'Expression.html'" ng-repeat="expr in expr.Expressions"></li>
    </ul>
    </div>
</script>

	<script type="text/ng-template" id="Expression2.html">

        <table class="expression" ng-if="expr.class == 'GroupExpression'" border="0" width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td>&nbsp;</td>
                <td valign="bottom" class="row-margin row-top"><div></div></td>
                <td class="row-content">
    			    <span>
                        <select class="connector" ng-model="expr.Operator">
                            <option value="And"><%=Translate.Translate("And")%></option>
                            <option value="Or"><%=Translate.Translate("Or")%></option>
                        </select>
	    		    </span>
                    <label><input type="checkbox" style="margin-top:4px;" ng-model="expr.Negate" /><%=Translate.Translate("Negate")%></label>
                    <span style="float:right">
                        <a href="" ng-click="deleteExpressionGroup($parent, $index);"><img src="/Admin/Images/Icons/Delete_vsmall.gif"></a>
                    </span>
                </td>
            </tr>
            <tr ng-repeat="expr in expr.Expressions" >
                <td>&nbsp;</td>
                <td class="row-margin row-center"><div>&nbsp;</div></td>
                <td ng-include="'Expression2.html'"></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td valign="top" class="row-margin row-bottom"><div>&nbsp;</div></td>
                <td class="row-buttons">
                    <button ng-click="addExpression(expr)"><%=Translate.Translate("Add expression")%></button>
					<button ng-click="addExpressionGroup(expr);"><%=Translate.Translate("Add group")%></button>
               </td>
            </tr>
        </table>

		<div ng-if="expr && expr.class != 'GroupExpression'">
			<span>
                <select class="std" ng-model="expr.Left.Field" ng-options="field.SystemName as (field.Name + ' (' + field.Type + ')') for field in model.Fields">
                </select>

				<select class="std operator" ng-model="expr.Operator">
                    <option value="GreaterThan"><%=Translate.Translate("GreaterThan")%></option>
                    <option value="GreaterThanOrEqual"><%=Translate.Translate("GreaterThanOrEqual")%></option>
                    <option value="LessThan"><%=Translate.Translate("LessThan")%></option>
                    <option value="LessThanOrEqual"><%=Translate.Translate("LessThanOrEqual")%></option>
                    <option value="Equal"><%=Translate.Translate("Equal")%></option>
                    <option value="MatchAny"><%=Translate.Translate("MatchAny")%></option>
                    <option value="MatchAll"><%=Translate.Translate("MatchAll")%></option>
                    <option value="Contains"><%=Translate.Translate("Contains")%></option>
                    <option value="In"><%=Translate.Translate("In")%></option>
                    <option value="Between"><%=Translate.Translate("Between")%></option>
                </select>

                <input class="value" disabled="disabled" ng-show="!expr.Right || expr.Right.class == ''" />
				<input class="value" disabled="disabled" ng-model="expr.Right.Value" placeholder="Value" ng-if="expr.Right.class == 'ConstantExpression'" />
				<input class="value" disabled="disabled" ng-model="expr.Right.VariableName" placeholder="Value" ng-if="expr.Right.class == 'ParameterExpression'" />
				<input class="value" disabled="disabled" ng-model="expr.Right.LookupString" placeholder="VariableName" ng-if="expr.Right.class == 'MacroExpression'" />
                <a href="" ng-click="editExpression(expr);" style="display:inline-block;"><img src="/Admin/Images/Icons/Wizard_small.png"></a>
			</span>
            <span style="float:right">
                <a href="" ng-click="deleteExpression($parent, $index);"><img src="/Admin/Images/Icons/Delete_vsmall.gif"></a>
            </span>
    	</div>

	</script>

<style>

    table.expression {
        padding:0px;
        margin:0px;
        border:none;
    }

    table.expression td {
        padding:0px;
        margin:0px;
        border:none;
        height:22px;
    }

    table.expression tr:nth-child(even) td {
        padding:0px;
        margin:0px;
        border:none;
        background-color: #EBF7FD;
    }

    table.expression .row-margin {
    }

    table.expression .row-top div{
        top: 50%;
        width: 100%;
        height:50%;
        border-left : 1px solid grey;
        border-top : 1px solid grey;
    }

    table.expression .row-center div{
        width: 100%;
        height:100%;
        border-left : 1px solid grey;
    }

    table.expression .row-bottom div{
        height:50%;
        margin-bottom:50%;
        border-left : 1px solid grey;
        border-bottom : 1px solid grey;
    }

        table.expression .row-buttons button {
            margin-bottom: 2px;
        }

    
</style>

<script type="text/ng-template" id="BinaryExpression.html">
    <div style="float:clear">
        <ng-include src="'Expression.html'" ng-repeat="expr in [expr.Left]"></ng-include>
        <select class="std" ng-model="">
            <option>{{expr.Field}}</option>
        </select>
        <ng-include src="'Expression.html'" ng-repeat="expr in [expr.Right]"></ng-include>
    </div>
</script>

<script type="text/ng-template" id="FieldExpression.html">
    <span class="styled">
        <select class="std" ng-model="expr.Field" ng-options="field.SystemName as field.Name for field in model.Fields">
        </select>
    </span>
</script>

<script type="text/ng-template" id="ParameterExpression.html">
    <span style="border:1px solid silver">{{expr.VariableName}}</span>
</script>

<script type="text/ng-template" id="ConstantExpression.html">
    <input type="text" ng-model="expr.Value" />
</script>

<script type="text/ng-template" id="MacroExpression.html">
    {{expr.LookupString}}
</script>

<script type="text/ng-template" id="EditConstantExpression.html">
    <table>
    <tr>
        <td class="left-label"><%=Translate.Translate("Type")%></td>
        <td>
            <select class="std" ng-model="rightExpressionDraft.Type">
                <option value="System.String">System.String</option>
                <option value="System.Boolean">System.Boolean</option>
                <option value="System.Decimal">System.Decimal</option>
                <option value="System.Single">System.Single</option>
                <option value="System.Double">System.Double</option>
                <option value="System.Int16">System.Int16</option>
                <option value="System.Int32">System.Int32</option>
                <option value="System.Int64">System.Int64</option>
                <option value="System.DateTime">System.DateTime</option>
                <option value="System.String[]">System.String[]</option>
                <option value="System.Boolean[]">System.Boolean[]</option>
                <option value="System.Decimal[]">System.Decimal[]</option>              
                <option value="System.Single[]">System.Single[]</option>
                <option value="System.Double[]">System.Double[]</option>
                <option value="System.Int16[]">System.Int16[]</option>
                <option value="System.Int32[]">System.Int32[]</option>
                <option value="System.Int64[]">System.Int64[]</option>         
                <option value="System.DateTime[]">System.DateTime[]</option>
            </select>
        </td>
    </tr> 
    <tr>
        <td class="left-label"><label><%=Translate.Translate("Value")%></label></td>
        <td>
            <input ng-model="rightExpressionDraft.Value" type="text" class="std" />
        </td>
    </tr>
    </table>
</script>

<script type="text/ng-template" id="EditParameterExpression.html">
    <table>
    <tr>
        <td class="left-label"><label><%=Translate.Translate("Parameter")%></label></td>
        <td>
            <select class="std" ng-model="rightExpressionDraft.VariableName" ng-options="param.Name as param.Name for param in query.Parameters">
            </select>
        </td>
    </tr>
    </table>
</script>

<script type="text/ng-template" id="EditMacroExpression.html">
    <table>
    <tr>
        <td class="left-label"><label><%=Translate.Translate("Macros")%></label></td>
        <td>
            <select class="std" ng-model="rightExpressionDraft.LookupString" ng-options="ds.original as ds.name group by ds.namespace for ds in supportedActions">
            </select>
        </td>
    </tr>
    </table>
</script>

<dw:GroupBox ID="SortingGroup" runat="server" Title="Sort By" DoTranslation="true">

    <div id="items" style="border: 1px solid rgba(188, 203, 223, 1);border-bottom:none;margin:3px;">
        <ul>
            <li class="header">
                <span class="pipe"></span><span class="C1" style="min-width:300px"><%=Translate.Translate("Field")%></span>
                <span class="pipe"></span><span class="C2"><%=Translate.Translate("Direction")%></span>
            </li>
        </ul>
         <ul id="items1" style="position: relative;">
            <li class="item-field" style="position: relative;" ng-click="openSortingDialog(sort);" ng-repeat="sort in query.SortOrder">
                <span class="C1" style="min-width:300px">{{sort.Field}}</span>
                <span class="C2" >{{sort.SortDirection}}</span>
                <span class="C4" style="float:right;"><a href="" ng-click="removeSortingParameter($index);"><img src="/Admin/Images/Icons/Delete_vsmall.gif" /></a></span>
            </li>
        </ul>
    </div>
</dw:GroupBox>

<dw:GroupBox ID="GroupingGroup" runat="server" Title="Grouping" DoTranslation="true">
</dw:GroupBox>

<dw:GroupBox ID="ProjectionGroup" runat="server" Title="Projection" DoTranslation="true">
</dw:GroupBox>



<style type="text/css">

    .styled{
        overflow: hidden;
        background: url(/Admin/x.gif) no-repeat 96% white;
    }

    #_contentWrapper select {
        height: 20px;
    }

</style>
