function ExportCSV()
{
	_reportScript='reports/IFReport.aspx?ExportCSV=1&HideExButtons=1'; 
	changeFilter();
	changeReportSrc();	
}

function SymmarySettings()
{
	_reportFilter=""; 
	_reportScript='SummarySettings/IFSummarySettings.aspx'; 
	changeReportSrc();
}

function Triggers()
{
	_reportFilter=""; 
	_reportScript='triggers/Triggers_List.aspx'; 
	changeReportSrc();
}

function TriggersRun()
{
	_reportFilter=""; 	
	_reportScript='/Admin/Public/StatisticsV3/TriggersRun.aspx?DoNotRun=true'; 		
	changeReportSrc("trigger");
}

function Configuration()
{
	_reportFilter=""; 
	_reportScript='/Admin/module/Statisticsv2_Cpl.aspx?ReturnToModule=1&ReturnToControlPanel=false'; 
	changeReportSrc();
}