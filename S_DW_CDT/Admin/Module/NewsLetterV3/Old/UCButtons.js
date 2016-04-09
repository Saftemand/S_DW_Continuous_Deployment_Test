function NewNewsletter() {
    changeReportSrc('EditNewsletter.aspx');
    return false;
}

function NewRecipient() {
    changeReportSrc('Recipient_Edit.aspx?Active=2');
}

function NewCategory() {
	changeReportSrc('Category_Edit.aspx'); 
}

function CustomFields()
{
    changeReportSrc('/Admin/Module/Common/CustomFields/CustomFields_list.aspx?context=' + recipientCustomFieldContext); 
}

function CheckEmails()
{
	changeReportSrc('CategoriesToValidateList.aspx'); 
}

function ImportRecipient() 
{
        changeReportSrc('Recipient_Import.aspx');
}


