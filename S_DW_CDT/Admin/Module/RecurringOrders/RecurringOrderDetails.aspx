<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RecurringOrderDetails.aspx.vb" Inherits="Dynamicweb.Admin.RecurringOrders.RecurringOrderDetails" %>
<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="Dynamicweb.Backend" %>
<%@ Register TagPrefix="dw" Namespace="Dynamicweb.Controls" Assembly="Dynamicweb.Controls" %>
<%@ Register Src="~/Admin/Module/eCom_Catalog/dw7/edit/UCOrderEdit.ascx" TagPrefix="oe" TagName="UCOrderEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>    
        <dw:ControlResources ID="ctrlResources" runat="server">
            <Items>
                <dw:GenericResource Url="/Admin/Images/Ribbon/UI/Tab/Tab.css" />
            </Items>
        </dw:ControlResources>
    <style type="text/css">
        table.tabTable{
            height:0px;
        }
        div.list table.main{
            width:779px;
        }
        table.tabTable tbody tr td{
            padding:0px;
        }
    </style>
    <script type="text/javascript">        
        function handleCanceledDeliveries(chkbx) {   
            var canceledIDs = $('CanceledDeliveries').value ? $('CanceledDeliveries').value.split(',') : [];
            if (chkbx.checked && canceledIDs.indexOf(chkbx.value) < 0){
                canceledIDs[canceledIDs.length] = chkbx.value
                $('CanceledDeliveries').value = canceledIDs.join(',');
            }else if(!chkbx.checked && canceledIDs.indexOf(chkbx.value) >= 0){                
                canceledIDs.splice(canceledIDs.indexOf(chkbx.value), 1);
                $('CanceledDeliveries').value = canceledIDs.join(',');
            }
        }

        document.observe('dom:loaded', function () {
            var popup = parent.pwFutureDeliveries_wnd;
            popup._events.allEvents['ok'].handlers.push( function(){
                new Ajax.Request('RecurringOrderDetails.aspx', {
                    method: 'post',
                    parameters: {
                        IsAjax : true,
                        CanceledDeliveries : $('CanceledDeliveries').value,
                        Cmd: 'Save',
                        RecurringOrderId : <%=Base.Request("RecurringOrderId")%>
                    }
                });
            });
        })
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" name="CanceledDeliveries" id="CanceledDeliveries" value="" runat="server" />
                       
    <dw:List ID="FutureDeliveries" ShowFooter="true" runat="server" TranslateTitle="True" StretchContent="true" PageSize="21" ShowPaging="true" Title="Future Deliveries">
        <Columns>
			<dw:ListColumn ID="colDeliveryDate" runat="server" Name="Date" EnableSorting="true"/>
			<dw:ListColumn ID="colSkip" runat="server" Name="Cancel Delivery" EnableSorting="false" ItemAlign="Center" Width="100" HeaderAlign="Center" />
        </Columns>
    </dw:List>        
        <%Translate.GetEditOnlineScript()%>
    </form>
</body>
</html>


