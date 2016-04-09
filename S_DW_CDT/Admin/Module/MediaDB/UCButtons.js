function Search()
{
	changeReportSrc('Media_List.aspx?Action=Search');	
}

function Inbox()
{
    changeReportSrc('Files_inbox.aspx');
}

function Thumbnails()
{
	changeReportSrc('Files_ThumbNails_list.aspx');
}

function Fields()
{
    changeReportSrc('Media_Field_List.aspx');
}

function Orientation() {
    changeReportSrc('Media_Orientation_List.aspx');
}

function Mediatypes() {
    changeReportSrc('Media_types_List.aspx');
}

function NewGroup()
{
	changeReportSrc('/Admin/module/MediaDB/Group_Edit.aspx');
}