(function(window, undefined) {
	var debug = function() {
		if ((typeof(console) != 'undefined') && (typeof(console.debug) == 'function')) {
			;;; console.debug.apply(console, arguments);
		}
	}

	var getEl = function(el) {
		if (typeof el === 'string') {
			el = document.getElementById(el);
		}
		return el;
	},

	getValue = function(el) {
		el = getEl(el);
		return el ? el.value : null;
	},

	// setValue = function(el, value) {
	//	el = getEl(el);
	//	if (el) {
	//		el.value = value;
	//	}
	// },

	getAttribute = function(el, name) {
		el = getEl(el);
		if (el) {
			return el.getAttribute(name);
		}
	},

	// Get first element with specified name and, optionally, passing filter
	getElementByName = function(name, root, filter) {
		root = getEl(root);
		root || (root = document.body);
		var i, elements = root.getElementsByTagName(name);
		for (i = 0; i < elements.length; i++) {
			if (!filter || filter(elements[i])) {
				return elements[i];
			}
		}
	},

	// @see http://stackoverflow.com/a/6160317
	hasClass = function(el, cls) {
		el = getEl(el);
		return el && el.className.match(new RegExp('(\\s|^)' + cls + '(\\s|$)'));
	},

	addClass = function(el, cls) {
		el = getEl(el);
		if (el && !hasClass(el, cls)) {
			el.className += " " + cls;
		}
	},

	removeClass = function(el, cls) {
		el = getEl(el);
		if (el && hasClass(el, cls)) {
			var reg = new RegExp('(\\s|^)' + cls + '(\\s|$)');
			el.className = el.className.replace(reg, ' ');
		}
	},

	getStyle = function(el, name) {
		el = getEl(el);
		if (el && el.style[name]) {
			return el.style[name];
		}
	},

	setStyle = function(el, values) {
		var p;
		el = getEl(el);
		if (el) {
			for (p in values) if (values.hasOwnProperty(p)) {
				el.style[p] = values[p];
			}
		}
	},

	processChildren = function(el, f) {
		var child;
		el = getEl(el);
		if (el) {
			for (child = el.firstChild; child; child = child.nextSibling) {
				if (child.nodeType === 1) {
					f(child);
				}
			}
		}
	},

	// @see http://stackoverflow.com/a/383245
	/*
	 * Recursively merge properties of two objects
	 */
	mergeRecursive = function(obj1, obj2) {
		for (var p in obj2) if (obj2.hasOwnProperty(p)) {
			try {
				// Property in destination object set; update its value.
				if ( obj2[p].constructor==Object ) {
					obj1[p] = mergeRecursive((typeof obj1[p] == 'undefined') ? {} : obj1[p], obj2[p]);
				} else {
					obj1[p] = obj2[p];
				}

			} catch(e) {
				// Property in destination object not set; create it and set its value.
				obj1[p] = obj2[p];
			}
		}

		return obj1;
	},

	// @see http://stackoverflow.com/a/4298672
	debouncer = function( func , timeout ) {
		var timeoutID;
		timeout = timeout || 200;
		return function () {
			var scope = this , args = arguments;
			clearTimeout( timeoutID );
			timeoutID = setTimeout( function () {
				func.apply( scope , Array.prototype.slice.call( args ) );
			} , timeout );
		}
	}

	if (typeof(window.Dynamicweb) == 'undefined') {
		window.Dynamicweb = {};
	}

	window.Dynamicweb.MapSettings = {};

	window.Dynamicweb.Map = function(options) {
		var settings = mergeRecursive(mergeRecursive({}, window.Dynamicweb.MapSettings), options),

		element,
		mapElement,
		listElement,

		map = null,
		clusterer = null,
		infoWindow,
		listPosition,
		showAllLocations,

		getInfoWindowContent = function(container) {
			var content = document.createElement('div');
			addClass(content, settings.infoWindow.className);
			processChildren(container, function(el) {
				content.appendChild(el.cloneNode(true));
			});
			return content;
		},

		getInfoWindow = function(marker) {
			if (settings.infoWindow.useSingleWindow) {
				if (!infoWindow) {
					infoWindow = new google.maps.InfoWindow();
				}
				infoWindow.setContent(getInfoWindowContent(marker._locationElement));
				marker._infoWindow = infoWindow;
			} else {
				if (!marker._infoWindow) {
					marker._infoWindow = new google.maps.InfoWindow({
						content: getInfoWindowContent(marker._locationElement)
					});
				}
			}
			return marker._infoWindow;
		},

		showInfoWindow = function() {
			var marker = this,
			map = marker.getMap(),
			infoWindow = getInfoWindow(marker);
			if (infoWindow) {
				infoWindow.open(map, marker);
				if (marker._locationElement) {
					processChildren(listElement, function(el) {
						removeClass(el, 'current');
					});
					addClass(marker._locationElement, 'current');
					// if (settings.list.fixHeight && settings.list.scrollIntoView && marker._locationElement.scrollIntoView) {
					// @TODO: scroll into view *inside* container
					// marker._locationElement.scrollIntoView();
					// }
				}
			}
		},

		showMarker = function() {
			var marker = this._marker,
			cluster = getMarkerCluster(marker),
			bounds;
			if (marker && map) {
				showInfoWindow.apply(marker);
				map.panTo(marker.getPosition());
				if (cluster) {
					if (cluster.getSize() > 1) {
						try {
							bounds = cluster.getBounds();
						} catch (ex) {}
						if (bounds) {
							map.fitBounds(bounds);
						}
					}
				}
				if (settings.list.showInfoWindowZoom && (settings.list.showInfoWindowZoom > map.getZoom())) {
					map.setZoom(settings.list.showInfoWindowZoom);
				}
			}
		},

		showLocation = function(marker) {
			var cluster = getMarkerCluster(marker);
			if (!cluster) {
				marker.setMap(map);
			}
			removeClass(marker._locationElement, 'hidden');
		},

		hideLocation = function(marker) {
			marker.setMap(null);
			addClass(marker._locationElement, 'hidden');
		},

		filterBounds = null,

		/**
		 * Show locations (markers) within map bounds
		 */
		filterLocations = function(filter) {
			var i, marker
			// , mapBounds = map.getBounds()
			;
			filterBounds = null;

			for (i = 0; i < markers.length; i++) {
				marker = markers[i];
				if (!filter || filter(marker)) {
					// Never show a marker that has been hidden by a search
					// if (isSearch || mapBounds.contains(marker.getPosition())) { // && (!searchQuery || (marker._searchQuery == searchQuery))) {
					// @TODO if search is active, inly show markers matching search query
					if (!searchCenter || !searchRadius || matchesSearch(marker)) {
						showLocation(marker);
						if (!filterBounds) {
							filterBounds = new google.maps.LatLngBounds();
						}
						if (filterBounds) {
							filterBounds.extend(marker.getPosition());
						}
					}
				} else {
					hideLocation(marker);
				}
			}
		},

		resetFilter = function() {
			var i, marker;
			filterBounds = null;
			for (i = 0; i < markers.length; i++) {
				marker = markers[i];
				showLocation(marker);
				if (!filterBounds) {
					filterBounds = new google.maps.LatLngBounds();
				}
				if (filterBounds) {
					filterBounds.extend(marker.getPosition());
				}
			}
		},

		getMarkerCluster = function(marker) {
			var i, j, markers;
			if (clusterer) {
				clusters = clusterer.getClusters();
				if (clusters) {
					for (i = 0; i < clusters.length; i++) {
						markers = clusters[i].getMarkers();
						if (markers) {
							for (j = 0; j < markers.length; j++) {
								if (markers[j] == marker) {
									return clusters[i];
								}
							}
						}
					}
				}
			}
		},

		searchForm,
		searchCenter = null,
		searchRadius = null,
		searchQueryField,
		searchRadiusField;
		searchMarker = null,

		searchLocations = function() {
			var geocoder,
			address = getValue(searchQueryField);
			if (!address) {
				// alert('Empty address');
				return;
			}

			geocoder = new google.maps.Geocoder();
			geocoder.geocode({address: address}, function(results, status) {
				var maxDistance = parseFloat(getValue(searchRadiusField)),
				unit = getAttribute(searchRadiusField, 'data-unit'),
				numberOfMatches = 0;

				if (status == google.maps.GeocoderStatus.OK) {
					resetSearch();

					searchCenter = results[0].geometry.location;
					switch (unit) {
					case 'km':
						searchRadius = 1000*maxDistance;
						break;
					case 'mi':
						searchRadius = 1609.344*maxDistance;
						break;
					default:
						searchRadius = maxDistance;
						break;
					}

					filterLocations(function(marker) {
						var distance = getDistance(marker.getPosition(), searchCenter);
						if (distance < searchRadius) {
							numberOfMatches++;
							return true;
						}
					});

					if (!searchMarker) {
						// @see https://developers.google.com/maps/documentation/javascript/reference#Circle
						searchMarker = new google.maps.Circle(settings.search.circleOptions)
					}
					if (searchMarker) {
						searchMarker.setMap(map);
						searchMarker.setCenter(searchCenter);
						searchMarker.setRadius(searchRadius);
						// searchMarker.setTitle(address);
					}

					if (settings.search.fitBounds && filterBounds) {
						map.fitBounds(filterBounds);
						if (settings.search.fitBoundsMaxZoom && (settings.search.fitBoundsMaxZoom < map.getZoom())) {
							map.setZoom(settings.search.fitBoundsMaxZoom);
						}
					} else if (settings.search.fitRadius) {
						map.fitBounds(searchMarker.getBounds());
					}
				} else {
					alert('Address '+address + ' not found');
				}
			});
		},

		resetSearch = function() {
			searchCenter = null;
			searchRadius = null;
			filterLocations(function(marker) {
				return true;
			});
			if (searchMarker) {
				searchMarker.setMap(null);
			}
		},

		deg2rad = function(angle) {
			return (angle / 180) * Math.PI;
		},

		// @see https://developers.google.com/maps/articles/phpsqlsearch_v3
		// @see http://www.movable-type.co.uk/scripts/latlong.html
		getDistance = function(m0, m1) {
			var lat0 = deg2rad(m0.lat()),
			lng0 = deg2rad(m0.lng()),
			lat1 = deg2rad(m1.lat()),
			lng1 = deg2rad(m1.lng());

			return 6371000*Math.acos(Math.cos(lat0)*Math.cos(lat1)*Math.cos(lng1-lng0)+Math.sin(lat0)*Math.sin(lat1));
		},


		matchesSearch = function(marker) {
			if (searchCenter && searchRadius) {
				return getDistance(marker.getPosition(), searchCenter) <= searchRadius;
			}
			return true;
		},

		initSearch = function() {
			searchForm = getElementByName('form', element);
			if (searchForm) {
				searchQueryField = getElementByName('input', searchForm, function(el) {
					return el.type == 'text';
				});
				searchRadiusField = getElementByName('select');

				google.maps.event.addDomListener(searchForm, 'submit', function(event) {
					event.preventDefault();
					searchLocations();
				});

				google.maps.event.addDomListener(searchForm, 'reset', function(event) {
					resetSearch();
				});
			}
		},

		init = function() {
			var defaultSettings = {
				elementId: null,
				map: {
					elementId: null,
					center: new google.maps.LatLng(0, 0),
					zoom: 0,
					mapTypeId: google.maps.MapTypeId.SATELLITE
				},
				marker: {
					showInfoWindowAction: 'click',
					icon: null
				},
				infoWindow: {
					className: 'dynamicweb-map-info-window',
					useSingleWindow: true
				},
				list: {
					elementId: null,
					fixHeight: false,
					scrollIntoView: false,
					showInfoWindowAction: false,
					showInfoWindowZoom: false,
					showOnlyLocationsOnMap: false
				},
				clusterer: {
					enabled: false,
					gridSize: 60, // (number) The grid size of a cluster in pixels.
					maxZoom: null, // (number) The maximum zoom level that a marker can be part of a cluster.
					zoomOnClick: true, // (boolean) Whether the default behaviour of clicking on a cluster is to zoom into it.
					averageCenter: false, // (boolean) Wether the center of each cluster should be the average of all markers in the cluster.
					minimumClusterSize: 2 // (number) The minimum number of markers to be in a cluster before the markers are hidden and a count is shown.
					// , styles: [
					//	// { // (object) An object that has style properties:
					//	//	url: null, // (string) The image url.
					//	//	height: 0, // (number) The image height.
					//	//	width: 0, // (number) The image width.
					//	//	anchor: [], // (Array) The anchor position of the label text.
					//	//	textColor: 'black', // (string) The text color.
					//	//	textSize: 11, // (number) The text size.
					//	//	backgroundPosition: '0 0' // (string) The position of the backgound x, y.
					//	// }
					// ]
				},
				search: {
					fitRadius: true,
					fitBounds: !true,
					fitBoundsMaxZoom: 12,
					circleOptions: {
						fillColor: '#000000',
						fillOpacity: 0.1,
						strokeColor: '#ffffff',
						strokeOpacity: 1.0,
						strokeWeight: 1
					}
				}
			};

			if (settings.map) {
				if (settings.map.center) {
					// Convert center from array to LatLng
					settings.map.center = new google.maps.LatLng(settings.map.center[0], settings.map.center[1]);
				}
				if (settings.map.mapType && google.maps.MapTypeId[settings.map.mapType]) {
					settings.map.mapTypeId = google.maps.MapTypeId[settings.map.mapType];
				}
			}

			settings = mergeRecursive(mergeRecursive({}, defaultSettings), settings);

			element = getEl(settings.elementId);
			mapElement = getEl(settings.map.elementId);
			listElement = getEl(settings.list.elementId);

			if (typeof MarkerClusterer == 'undefined') {
				settings.clusterer.enabled = false;
			}

			if (element) {
				listPosition = getAttribute(element, 'data-list-position');
				if (listPosition) {
					addClass(element, 'list-'+listPosition);
					switch (listPosition) {
					case 'left':
					case 'right':
						settings.list.fixHeight = true;
						settings.list.scrollIntoView = true;
						break;
					}
				}

				if (mapElement && listElement) {
					map = new google.maps.Map(mapElement, settings.map);
					if (!settings.clusterer.enabled) {
						settings.marker.map = map;
					}

					if (settings.list.fixHeight === true) {
						setStyle(listElement, {
							'height': getStyle(mapElement.parentNode, 'height'),
							'overflow': 'auto'
						});
					}

					markers = [];

					// Create markers
					processChildren(listElement, function(el) {
						var lat = parseFloat(getAttribute(el, 'data-lat')),
						lng = parseFloat(getAttribute(el, 'data-lng')),
						title = getAttribute(el, 'data-title'),
						icon = getAttribute(el, 'data-icon'),
						markerOptions,
						marker;

						if (!isNaN(lat) && !isNaN(lng)) {
							markerOptions = mergeRecursive({}, mergeRecursive(settings.marker, {
								position: new google.maps.LatLng(lat, lng),
								title: title
							}));
							if (icon) {
								markerOptions.icon = icon;
							}

							marker = new google.maps.Marker(markerOptions);
							markers.push(marker);

							marker._locationElement = el;
							el._marker = marker;
							google.maps.event.addListener(marker, settings.marker.showInfoWindowAction, showInfoWindow);
							if (settings.list.showInfoWindowAction) {
								google.maps.event.addDomListener(el, settings.list.showInfoWindowAction, showMarker);
							}
						}
					});

					if (settings.clusterer.enabled) {
						clusterer = new MarkerClusterer(map, markers, settings.clusterer);
					}

					// google.maps.event.addListener(map, 'center_changed', debouncer(function() {
					//	var map = this;
					//	;;; debug('center_changed', map.getCenter());
					// }));

					// google.maps.event.addListener(map, 'zoom_changed', debouncer(function() {
					//	// var map = this;
					//	;;; debug('zoom_changed', map.getZoom(), map.getBounds());
					// }));

					if (settings.list.showOnlyLocationsOnMap) {
						google.maps.event.addListener(map, 'bounds_changed', debouncer(function() {
							// if (settings.search.fitBounds && boundsSetBySearch) {
							//	boundsSetBySearch = false;
							//	return;
							// }
							var bounds = map.getBounds();
							if (bounds) {
								filterLocations(function(marker) {
									return bounds.contains(marker.getPosition());
								});
							}
						}));
					}
				}

				initSearch();

				showAllLocations = getElementByName('*', element, function(el) {
					return hasClass(el, 'show-all-locations');
				});
				if (showAllLocations) {
					google.maps.event.addDomListener(showAllLocations, 'click', function() {
						resetSearch();
						resetFilter();
						if (filterBounds) {
							map.fitBounds(filterBounds);
							// if (settings.search.fitBoundsMaxZoom && (settings.search.fitBoundsMaxZoom < map.getZoom())) {
							//	map.setZoom(settings.search.fitBoundsMaxZoom);
							// }
						}
					});
				}
			}
		}

		google.maps.event.addDomListener(window, 'load', init);
	}
}(window));
