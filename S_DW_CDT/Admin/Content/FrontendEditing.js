var setPageData = function () { };
var translate = function () { };
var statusBar = {};

(function () {
	var pageData = null,

	resizeContent = function () {
		var topbar = $('topbar'),
		topbarHeight = topbar ? topbar.getHeight() : 0,
		contentWrapper = $('content');
		if (topbarHeight > 0) {
			if (contentWrapper) {
				contentWrapper.style.top = topbarHeight + 'px';
			}
		}
	},

	setApprovalType = function () {
		var topbar = $('topbar'),
		approvalType = pageData && pageData.approvalType;

		if (topbar) {
			topbar.removeClassName('draft').removeClassName('workflow');

			if (approvalType < 0) {
				topbar.addClassName('draft');
			} else if (approvalType > 0) {
				topbar.addClassName('workflow');
			}
			resizeContent();
		}
	};

	// The real function
	setPageData = function (data) {
		pageData = data;
		setApprovalType();
		/*
		if (typeof history.replaceState != 'undefined') {
			if (pageData.id) {
				var url = document.location.href.replace(/\?.*$/, '');
				url += '?PageID=' + pageData.id;
				history.replaceState(pageData, pageData.title, url);
			}
		}
		//*/

		//if (pageData.title) {
		//	document.title = 'Frontend editing: '+pageData.title;
		//}
	};

	translate = function (text) {
		if (typeof dwFrontendEditing.messages != 'undefined' && dwFrontendEditing.messages[text]) {
			text = dwFrontendEditing.messages[text];
		} else {
			text = '*' + text.replace(/\s+/g, '_');
		}
		return text;
	};

	statusBar = (function () {
		var $status = null,
		$statusContentElement = null,

		getStatusElement = function () {
			if (!$status) {
				$status = $('status');
			}

			return $status;
		},

		getStatusContentElement = function () {
			if (!$statusContentElement) {
				$statusContentElement = $$('#status > .content')[0];
			}

			return $statusContentElement;
		};

		return {
			set: function (message, data) {
				var el = getStatusElement(),
				content = getStatusContentElement();

				if (data && message) {
					if (data.translate) {
						message = translate(message);
					}
					message = message.replace(/@([a-z]+)/i, function (text, key) {
						return data[key];
					});
				}
				if (content) {
					content.update(message); //.appear({ duration: 0.5 });
				}
				if (el) {
					el.show();
					el.removeClassName('info');
					el.removeClassName('success');
					el.removeClassName('alert');
					el.removeClassName('error');
					if (data && data.className) {
						el.addClassName(data.className);
					} else {
						el.addClassName('info');
					}
				}
				return this;
			},

			fade: function (duration) {
				var el = getStatusElement();
				duration = 2;
				if (el) {
					Effect.Queues.get('statusEffects').invoke('cancel');

					el.fade({ from: 1, to: 0, duration: duration, queue: { position: 'end', scope: 'statusEffects' } });
					// .fadeIn(duration/2).fadeOut(duration)
					;
				}
				return this;
			}
		}
	}());

	Event.observe(window, 'load', function () {
		var contentFrame = $('contentFrame');

		resizeContent();
		$('content').show();

		Event.observe('btn-close', 'click', function () {
			var location = document.location;
			var url = location.href.replace(/#.*/, '');
			url = url.replace(/[?&]FrontendEditingState=[a-z]+/gi, '');
			url += (url.indexOf('?') > -1 ? '&' : '?') + 'FrontendEditingState=disable&close=true';
			document.location.href = url;
		});

		Event.observe('toggle-editing', 'change', function () {
			var location = contentFrame.contentDocument.location;
			var url = location.href.replace(/#.*/, '');
			url = url.replace(/[?&]FrontendEditingState=[a-z]+/gi, '');
			url += (url.indexOf('?') > -1 ? '&' : '?') + 'FrontendEditingState=' + (this.checked ? 'edit' : 'browse');
			statusBar.set(translate(this.checked ? 'Inline editing enabled' : 'Inline editing disabled')).fade();
			contentFrame.src = url;
		});
	});
}());
