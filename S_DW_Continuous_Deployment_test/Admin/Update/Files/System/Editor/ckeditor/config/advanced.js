/**
 * @license Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';

	// Dynamicweb
	config.uiColor = '#C8D9ED';
	config.skin = 'moonocolor';

	config.removePlugins = 'save, newpage, preview, print, templates, flash, smiley, pagebreak, iframe, font, forms, colorbutton';

	config.entities = false;

	config.filebrowserBrowseUrl = '/Admin/Editor/ckeditor/browser.aspx?type=link';
	config.filebrowserImageBrowseUrl = '/Admin/Editor/ckeditor/browser.aspx?type=image';
	config.filebrowserImageBrowseLinkUrl = "/Admin/Editor/ckeditor/browser.aspx?type=link";
	config.filebrowserLinkWindowWidth = '600';
	config.filebrowserLinkWindowHeight = '50';
};
