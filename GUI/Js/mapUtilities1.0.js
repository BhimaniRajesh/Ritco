var map;
var container;
var opacity = 0.4;
var circle;
var centerMarker;
var circleUnits;
var circleRadius;
var zoom = 7;
var icon1;
//var centerPoint = new GLatLng(23, 73);
var centerPoint = new google.maps.LatLng(21, 78);
var newpoints = new Array();
var icon1;
var newpoints1 = new Array();

icon = new Array();
var mapOptions;
function loadMap(lat, lng) {
    mapOptions = {
        zoom: 8,
        center: new google.maps.LatLng(lat, lng),
        draggableCursor: 'crosshair'
    };
    map = new google.maps.Map(document.getElementById('mapDiv'), mapOptions);
}
// This function will plot the point on map.
//parameter : newpoints is a Markers details (Latitude,Longitude,icon,popupcontains)

function addPoints(newpoints) {
    for (var i = 0; i < newpoints.length; i++) {

        loadMap(newpoints[i][1], newpoints[i][0]);
        var point = new GPoint(newpoints[i][1], newpoints[i][0]);
        var popuphtml = newpoints[i][3];
        var marker = createMarkerWebX(point, newpoints[i][2], popuphtml, i);
        map.addOverlay(marker);
    }
}
function createMarkerWebX(point, icon, popuphtml, index) {

    var marker = new GMarker(point, createIcon(icon, index));
    GEvent.addListener(marker, "mouseover", function () {
        marker.openInfoWindowHtml(popuphtml);
    });
    return marker;
}

function createIcon(url, i) {

    icon[i] = new GIcon();
    icon[i].image = url;
    icon[i].iconSize = new GSize(12, 12);
    icon[i].iconAnchor = new GPoint(7, 7);
    icon[i].infoWindowAnchor = new GPoint(7, 7);
    return icon[i];
}
//function createMarkerWebX(point, icon, popuphtml, index) {
//    var popuphtml = "<div id=\"popup\">" + popuphtml + "<\/div>";
//    var marker = new GMarker(point, createIcon(icon, index));
//    GEvent.addListener(marker, "mouseover", function () {
//        marker.openInfoWindowHtml(popuphtml);
//    });
//    return marker;
//}

//function createIcon(url, i) {
//    icon[i] = new GIcon();
//    icon[i].image = url;
//    icon[i].iconSize = new GSize(9, 9);
//    icon[i].iconAnchor = new GPoint(7, 7);
//    icon[i].infoWindowAnchor = new GPoint(7, 7);
//    return icon[i];
//}

function load() {

    if (GBrowserIsCompatible()) {
        container = document.getElementById("mapDiv");
        map = new GMap2(container, { draggableCursor: "crosshair" });
        map.setCenter(centerPoint, 7);

        map.addControl(new GScaleControl());
        map.addControl(new GLargeMapControl());
        map.addControl(new GMapTypeControl(), new GControlPosition(G_ANCHOR_BOTTOM_LEFT, new GSize(0, 5)));
        map.enableContinuousZoom();
        map.enableScrollWheelZoom();
        var pos = new GControlPosition(G_ANCHOR_TOP_LEFT, new GSize(0, 0));
        map.addControl(new MStatusControl({ position: pos }));
        icon1 = new GIcon();
        icon1.image = "black_ball.gif";

        icon1.iconSize = new GSize(8, 8);
        icon1.iconAnchor = new GPoint(7, 7);
        icon1.infoWindowAnchor = new GPoint(7, 7);

        // addPoints1();
    }
}

function showValues() {
    var s = document.getElementById("lat").value;
    alert(s);
}

function Browser() {

    var ua, s, i;

    this.isIE = false;
    this.isNS = false;
    this.version = null;

    ua = navigator.userAgent;

    s = "MSIE";
    if ((i = ua.indexOf(s)) >= 0) {
        this.isIE = true;
        this.version = parseFloat(ua.substr(i + s.length));
        return;
    }

    s = "Netscape6/";
    if ((i = ua.indexOf(s)) >= 0) {
        this.isNS = true;
        this.version = parseFloat(ua.substr(i + s.length));
        return;
    }

    // Treat any other "Gecko" browser as NS 6.1.

    s = "Gecko";
    if ((i = ua.indexOf(s)) >= 0) {
        this.isNS = true;
        this.version = 6.1;
        return;
    }
}

var browser = new Browser();
// Global object to hold drag information.
var dragObj = new Object();
dragObj.zIndex = 0;

function dragStart(event, id) {

    var el;
    var x, y;

    // If an element id was given, find it. Otherwise use the element being
    // clicked on.

    if (id)
        dragObj.elNode = document.getElementById(id);
    else {
        if (browser.isIE)
            dragObj.elNode = window.event.srcElement;
        if (browser.isNS)
            dragObj.elNode = event.target;

        // If this is a text node, use its parent element.

        if (dragObj.elNode.nodeType == 3)
            dragObj.elNode = dragObj.elNode.parentNode;
    }

    //  Get cursor position with respect to the page.

    if (browser.isIE) {
        x = window.event.clientX + document.documentElement.scrollLeft
	      + document.body.scrollLeft;
        y = window.event.clientY + document.documentElement.scrollTop
	      + document.body.scrollTop;
    }
    if (browser.isNS) {
        x = event.clientX + window.scrollX;
        y = event.clientY + window.scrollY;
    }

    // Save starting positions of cursor and element.

    dragObj.cursorStartX = x;
    dragObj.cursorStartY = y;
    dragObj.elStartLeft = parseInt(dragObj.elNode.style.left, 10);
    dragObj.elStartTop = parseInt(dragObj.elNode.style.top, 10);

    if (isNaN(dragObj.elStartLeft)) dragObj.elStartLeft = 0;
    if (isNaN(dragObj.elStartTop)) dragObj.elStartTop = 0;

    // Update element's z-index.

    dragObj.elNode.style.zIndex = ++dragObj.zIndex;

    // Capture mousemove and mouseup events on the page.

    if (browser.isIE) {
        document.attachEvent("onmousemove", dragGo);
        document.attachEvent("onmouseup", dragStop);
        window.event.cancelBubble = true;
        window.event.returnValue = false;
    }
    if (browser.isNS) {
        document.addEventListener("mousemove", dragGo, true);
        document.addEventListener("mouseup", dragStop, true);
        event.preventDefault();
    }
}

function dragGo(event) {

    var x, y;
    //Get cursor position with respect to the page.
    if (browser.isIE) {
        x = window.event.clientX + document.documentElement.scrollLeft
		      + document.body.scrollLeft;
        y = window.event.clientY + document.documentElement.scrollTop
		      + document.body.scrollTop;
    }
    if (browser.isNS) {
        x = event.clientX + window.scrollX;
        y = event.clientY + window.scrollY;
    }

    //Move drag element by the same amount the cursor has moved.
    dragObj.elNode.style.left = (dragObj.elStartLeft + x - dragObj.cursorStartX) + "px";
    dragObj.elNode.style.top = (dragObj.elStartTop + y - dragObj.cursorStartY) + "px";

    if (browser.isIE) {
        window.event.cancelBubble = true;
        window.event.returnValue = false;
    }
    if (browser.isNS)
        event.preventDefault();
}

function dragStop(event) {

    //Stop capturing mousemove and mouseup events.

    if (browser.isIE) {
        document.detachEvent("onmousemove", dragGo);
        document.detachEvent("onmouseup", dragStop);
    }
    if (browser.isNS) {
        document.removeEventListener("mousemove", dragGo, true);
        document.removeEventListener("mouseup", dragStop, true);
    }
}

function drawCircle() {

    var oRadius = document.getElementById("ctl00_MyCPH1_radius").value;


    oRadius = oRadius ? oRadius : 5000;

    if (oRadius.value.match(/[^\d.]/)) {
        alert("Enter a number for radius");
        return;
    }
    alert(oRadius);
    circleRadius = (oRadius / 1000);
    circleUnits = 'KM';
    doDrawCircle();
}

function doDrawCircle() {

    if (circle) {
        map.removeOverlay(circle);
    }

    if (centerMarker) {
        map.setCenter(centerMarker.getLatLng());
    }
    else {
        centerMarker = new GMarker(map.getCenter(), { draggable: true });
        GEvent.addListener(centerMarker, "click", function () {
            centerMarker.openInfoWindowHtml('hi')
        });
        GEvent.addListener(centerMarker, 'dragend', drawCircle);
        map.addOverlay(centerMarker);
    }

    var center = map.getCenter();
    var bounds = new GLatLngBounds();
    var circlePoints = Array();

    with (Math) {
        if (circleUnits == 'KM') {
            alert('KM');
            var d = circleRadius / 6378.8; // radians
        }
        else { //miles
            var d = circleRadius / 3963.189; // radians
        }

        var lat1 = (PI / 180) * center.lat(); // radians
        var lng1 = (PI / 180) * center.lng(); // radians

        for (var a = 0; a < 361; a++) {
            var tc = (PI / 180) * a;
            var y = asin(sin(lat1) * cos(d) + cos(lat1) * sin(d) * cos(tc));
            var dlng = atan2(sin(tc) * sin(d) * cos(lat1), cos(d) - sin(lat1) * sin(y));
            var x = ((lng1 - dlng + PI) % (2 * PI)) - PI; // MOD function
            var point = new GLatLng(parseFloat(y * (180 / PI)), parseFloat(x * (180 / PI)));
            var point = new google.maps.LatLng(parseFloat(y * (180 / PI)), parseFloat(x * (180 / PI)));
            circlePoints.push(point);
            bounds.extend(point);
        }

        if (d < 1.5678565720686044) {
            circle = new GPolygon(circlePoints, '#000000', 2, 1, '#000000', 0.25);
            alert('hi');
        }
        else {
            circle = new GPolygon(circlePoints, '#000000', 2, 1);
        }
        map.addOverlay(circle);

        map.setZoom(map.getBoundsZoomLevel(bounds));
    }
}

function openpopup(ss) {
    mmarker[ss - 1].openInfoWindowHtml(ss1[ss - 1]);
}

function loadMapPoints(pointsArray, joinMap, zoomLevel) {
    var map;
    var icon = new Array();
    addMapPoints(pointsArray, joinMap, zoomLevel);

    function addMapPoints(newpoints, joinMap, zoomLevel) {

        var from, to;
        if (newpoints.length > 0) {
            from = newpoints[0][0];
            to = newpoints[0][1];

            var mpoint;
            var mpopup;
            mapOptions = {
                zoom: zoomLevel,
                center: new google.maps.LatLng(from, to),
                draggableCursor: 'crosshair',
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            map = new google.maps.Map(document.getElementById('mapDiv'), mapOptions);

            var PlanCoordinates = new Array();

            for (var i = 0; i < newpoints.length; i++) {

                var bounds = new google.maps.LatLngBounds();
                bounds.extend(new google.maps.LatLng(newpoints[i][0], newpoints[i][1]));
                PlanCoordinates[i] = new google.maps.LatLng(newpoints[i][0], newpoints[i][1]);

                var marker = new google.maps.Marker({
                    position: new google.maps.LatLng(newpoints[i][0], newpoints[i][1]),
                    map: map,
                    icon: newpoints[i][2],
                    title: newpoints[i][4]
                });

                // process multiple info windows
                (function (marker, i) {
                    // add click event
                    //google.maps.event.addListener(marker, 'click', function () {
                    //    infowindow = new google.maps.InfoWindow({
                    //        content: "<div id=\"popup\">" + newpoints[i][3] + "<\/div>"
                    //    });
                    //    infowindow.open(map, marker);
                    //});

                    google.maps.event.addListener(marker, 'mouseover', function () {
                        infowindow = new google.maps.InfoWindow({
                            content: "<div id=\"popup\">" + newpoints[i][3] + "<\/div>"
                        });
                        infowindow.open(map, marker);
                        //setTimeout(function ()
                        //{
                        //    infowindow.close();
                        //}, '2000');

                        //setTimeout(function () { infowindow.open(map, marker) }, 500);
                    });

                    // assuming you also want to hide the infowindow when user mouses-out
                    google.maps.event.addListener(marker, 'mouseout', function () {
                        //infowindow.close();
                        setTimeout(function ()
                        {
                            infowindow.close();
                        }, '700');
                    });

                })(marker, i);

                //map.fitBounds(bounds);
            }

            var flightPath = new google.maps.Polyline({
                path: PlanCoordinates,
                geodesic: true,
                strokeColor: '#FF0000',
                strokeOpacity: 1.0,
                strokeWeight: 2
            });

            if (zoomLevel == null)
                zoomLevel = 12;

            map.setZoom(zoomLevel);
            map.setCenter(marker.getPosition());

            if (joinMap)
                flightPath.setMap(map);
        }
        else {
            var cityNameCall = "NEW DELHI";
            try {
                cityNameCall = cityName;
            } catch (e) { }
            GetGeocodeByCityName(cityNameCall + ', IN');
        }
    }
}

var myLat, myLong;

function InitGeolocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
            function (position) {
                myLat = position.coords.latitude;
                myLong = position.coords.longitude;
            }
        );
    }
}
function GetGeocodeByCityName(cityName) {
    var geocoder = new google.maps.Geocoder();
    geocoder.geocode({ 'address': cityName }, function (results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            myLat = results[0].geometry.location.lat();
            myLong = results[0].geometry.location.lng();
            map = new google.maps.Map(document.getElementById("mapDiv"), mapOptions);
            loadMap(myLat, myLong);
        }
        else {
            alert("Geocode was not successful for the following reason: " + status);
        }
    });
}
