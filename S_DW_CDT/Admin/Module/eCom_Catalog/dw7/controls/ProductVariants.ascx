<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ProductVariants.ascx.vb" Inherits="Dynamicweb.Admin.ProductVariants" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend"%>
<%@ Import Namespace="Dynamicweb.eCommerce.Variants"%>
<table style="margin: 0 0 -5px 0; white-space:nowrap;" cellpadding="0" cellspacing="0" oncontextmenu="Event.stop(arguments[0] || window.event);">
    <thead>
        <tr style="background-color:#DDECFF;font-weight:bold;">
            <td colspan="2" style="padding: 0 10px 0 40px;"><%=Translate.Translate("Variant")%></td>
        <%For Each g As VariantGroup In Product.VariantGroups%>
            <td><span class="pipe"><img src="/Admin/Images/x.gif"/></span>&nbsp;&nbsp;<%=HttpUtility.HtmlEncode(g.Name)%></td>
        <%Next%>
            <td style="width:99%;">&nbsp;</td>
        </tr>
    </thead>
    <tbody>
        <%  Dim disableCreationNewProductVariant As Boolean = Base.ChkBoolean(Base.GetGs("/Globalsettings/Ecom/Integration/DisableCreationNewProductVariant"))
            Dim productGroupID As String = String.Empty
            Dim groups As eCommerce.Products.GroupCollection = Product.Groups()
            If groups.Count > 0 Then
                productGroupID = groups(0).ID
            End If
            
            Dim i As Integer = -1
            For Each v As VariantCombination In Product.VariantCombinations
                i = i + 1
        %>
        <tr style="background-color:#EEF0FF;">
            <td style="padding: 0 0 0 40px;">
                <% Dim td As String = String.Empty
                   Dim imgSrc As String = Base.IIf(v.SimpleVariant, "editvariantasprod_small_dim.gif", "editvariantasprod_small.gif")
                   If v.SimpleVariant AndAlso disableCreationNewProductVariant Then
                        td = String.Format("<a href=""javascript:void(0)""><img style=""border:none;"" id=""EditVarImg_{0}_{1}"" src=""/Admin/Module/eCom_Catalog/dw7/images/{2}"" alt="""" /></a>", Product.ID, v.VariantID, imgSrc)
                   Else
                        td = String.Format("<a href=""#"" onclick=""gotoVariant('{0}', '{1}', '{2}', 'True'); return false;""><img style=""border:none;"" id=""EditVarImg_{0}_{2}"" src=""/Admin/Module/eCom_Catalog/dw7/images/{3}"" alt=""*"" /></a>", Product.ID, productGroupID, v.VariantID, imgSrc)
                   End If%>
                <%=td%>
            </td>
            <td style="padding: 0 10px 0 0">
                <%=HttpUtility.HtmlEncode(v.Product.Name)%>
            </td>
            <%For j As Integer = 0 To Product.VariantGroups.Count - 1%>
                <td style="padding: 0 10px;"><%=HttpUtility.HtmlEncode(VariantNames(i)(j))%></td>
            <%Next%>
            <td style="width:99%;">&nbsp;</td>
        </tr>
        <%Next%>
    </tbody>
</table>
