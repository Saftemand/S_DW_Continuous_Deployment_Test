var _SiteMapPageDetailFolder = "../../../Public/StatisticsV3/"

function changePageDetailSrc(detailID)
{
	var strLocation = _SiteMapPageDetailFolder + "IFPageDetail.aspx?PageDetailID=" + detailID + "&" + window.parent.GetFilter();
	window.open(strLocation, "newWind", "resizable=no,scrollbars=yes,toolbar=no,location=no,directories=no,status=no,width=520,height=500");
}

