<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="defaultNew.aspx.vb" Inherits="Dynamicweb.Admin.defaultNew" %>

<%@ Import Namespace="Dynamicweb" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="Dynamicweb.Backend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
	<title></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

	<script type="text/javascript" src="lib/prototype.js">
</script>

	<script type="text/javascript" src="lib/scriptaculous.js?load=effects,dragdrop">
</script>

	<script type="text/javascript" src="portal.js">
</script>

	<script type="text/javascript">
<!--
		var settings = {};
		var portal;
		function init() {
			portal = new Portal();
			portal.applySettings(settings);
		}
		Event.observe(window, 'load', init, false);
//-->
</script>

	<style type="text/css" media="all">
		@import "newsportal/style.css";
	</style>
	<style type="text/css" media="all">
		@import "portal.css";
	</style>

	<script type="text/javascript">
</script>

</head>
<body>
	<div id="page_wrapper">
		<div id="header_wrapper">
			<div id="header">
				<h1><%=Translate.Translate("Min Dynamicweb")%></h1>
			</div>
		</div>
		<div id="content" style="background-color:#ffffff;">
			<!-- begin content -->
			<div id="portal">
				<a href="#" id="portal-block-list-link" title="Click to add portlets" name="portal-block-list-link">Add content</a><br class="clear" />
				<div class="portal-column" id="portal-column-0">
					<h2>
						Column 0</h2>
				</div>
				<div class="portal-column" id="portal-column-1">
					<h2>
						Column 1</h2>
				</div>
				
				<div class="portal-column" id="portal-column-block-list" style="display: none;">
					<h2 class="block-list-handle">
						Block List</h2>
					<p>
						Drag and drop to arrange portlets they way you like in available columns.</p>
					<div class="block block-archive" id="block-archive-0">
						<h3 class="handle">
							<a class="block-toggle"><span>toggle</span></a>Calendar</h3>
						<div class="content">
							<div>
								<!-- calendar -->
								<div class="calendar">
									<table summary="A calendar to browse events.">
										<caption>
											<a href="#" title="Previous month">«</a> September 2006 &nbsp;
										</caption>
										<tr class="header-week">
											<th abbr="Sunday">
												Su
											</th>
											<th abbr="Monday">
												Mo
											</th>
											<th abbr="Tuesday">
												Tu
											</th>
											<th abbr="Wednesday">
												We
											</th>
											<th abbr="Thursday">
												Th
											</th>
											<th abbr="Friday">
												Fr
											</th>
											<th abbr="Saturday">
												Sa
											</th>
										</tr>
										<tr class="row-week">
											<td class="day-blank">&nbsp;</td>
											<td class="day-blank">&nbsp;</td>
											<td class="day-blank">&nbsp;</td>
											<td class="day-blank">&nbsp;</td>
											<td class="day-blank">&nbsp;</td>
											<td class="day-normal">1</td>
											<td class="day-today">2</td>
										</tr>
										<tr class="row-week">
											<td class="day-future">3</td>
											<td class="day-future">4</td>
											<td class="day-future">5</td>
											<td class="day-future">6</td>
											<td class="day-future">7</td>
											<td class="day-future">8</td>
											<td class="day-future">9</td>
										</tr>
										<tr class="row-week">
											<td class="day-future">10</td>
											<td class="day-future">11</td>
											<td class="day-future">12</td>
											<td class="day-future">13</td>
											<td class="day-future">14</td>
											<td class="day-future">15</td>
											<td class="day-future">16</td>
										</tr>
										<tr class="row-week">
											<td class="day-future">17</td>
											<td class="day-future">18</td>
											<td class="day-future">19</td>
											<td class="day-future">20</td>
											<td class="day-future">21</td>
											<td class="day-future">22</td>
											<td class="day-future">23</td>
										</tr>
										<tr class="row-week">
											<td class="day-future">24</td>
											<td class="day-future">25</td>
											<td class="day-future">26</td>
											<td class="day-future">27</td>
											<td class="day-future">28</td>
											<td class="day-future">29</td>
											<td class="day-future">30</td>
										</tr>
									</table>
								</div>
							</div>
						</div>
					</div>
					<div class="block block-aggregator" id="block-aggregator-feed-2">
						<h3 class="handle">
							<a class="block-toggle"><span>toggle</span></a> del.icio.us</h3>
						<div class="content">
							<div>
								<div class="item-list">
									<ul>
										<li><a href="http://webkit.org/blog/?p=66">Surfin’ Safari - Blog Archive » The FOUC Problem</a></li>
									</ul>
								</div>
								<div class="more-link">
									<a href="#" title="View this feed's recent news.">more</a>
								</div>
							</div>
						</div>
					</div>
					<div class="block block-aggregator" id="block-aggregator-feed-1">
						<h3 class="handle">
							<a class="block-toggle"><span>toggle</span></a> Google News</h3>
						<div class="content">
							<div>
								<div class="item-list">
									<ul>
										<li><a href="http://news.google.com/news/url?sa=T&amp;ct=us/8-0-0&amp;fd=R&amp;url=http://www.forbes.com/home/feeds/ap/2006/09/02/ap2989847.html&amp;cid=1109217303&amp;ei=k8_5RNHVDsWwwQGHlJ21BQ">Bush: Iraq Has Not Fallen Into Civil War - Forbes</a></li>
									</ul>
								</div>
								<div class="more-link">
									<a href="#" title="View this feed's recent news.">more</a>
								</div>
							</div>
						</div>
					</div>
					<div class="block block-user" id="block-user-3">
						<h3 class="handle">
							<a class="block-toggle"><span>toggle</span></a> Who's online</h3>
						<div class="content">
							<div>
								There are currently 1 user and 0 guests online.
								<div class="item-list">
									<h3>
										Online users</h3>
									<ul>
										<li><a href="#" title="View user profile.">ayman</a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="block block-node" id="block-node-0">
						<h3 class="handle">
							<a class="block-toggle"><span>toggle</span></a> Syndicate</h3>
						<div class="content">
							<div>
								<a href="#" class="feed-icon">
									<img src="feed.png" alt="Syndicate content" title="Syndicate content" width="16" height="16" /></a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- end content -->
		</div>
	</div>
</body>
</html>
