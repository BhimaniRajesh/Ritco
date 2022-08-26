<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="VehicleMasterAdd.aspx.cs" Inherits="GUI_admin_VehicleMaster_VehicleMasterAdd"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="../../../GUI/images/CommonJS.js"></script>

    <script language="javascript" type="text/javascript" src="VehicleMaster.js?v11"></script>
    <script language="vbscript" type="text/vbscript">
        
        function findDateDifference(dtFrom, dtTo, interval)
            
            findDateDifference = DateDiff(interval, dtFrom, dtTo)
            
        end function
        
    </script>
    <script language="javascript" type="text/javascript">

        var serviceUrl = '<%=ResolveClientUrl("~/RestService/VehicleMasterService.svc")%>';
        var empCode = '<%= SessionUtilities.CurrentEmployeeID %>';
        var currentDate = '<%=SessionUtilities.Now.ToString("dd/MM/yyyy")%>';
        var currentTime = '<%=SessionUtilities.Now.ToString("HH:mm")%>';
        var companyCode = '<%= SessionUtilities.DefaultCompanyCode %>';

    </script>

    <script language="javascript" type="text/javascript">

        // ===================================================================
        // Author: Matt Kruse <matt@mattkruse.com>
        // WWW: http://www.mattkruse.com/
        //
        // NOTICE: You may use this code for any purpose, commercial or
        // private, without any further permission from the author. You may
        // remove this notice from your final code if you wish, however it is
        // appreciated by the author if at least my web site address is kept.
        //
        // You may *NOT* re-distribute this code in any way except through its
        // use. That means, you can include it in your product, or your web
        // site, or any other form where the code is actually being used. You
        // may not put the plain javascript up on your site for download or
        // include it in your javascript libraries for download. 
        // If you wish to share this code with others, please just point them
        // to the URL instead.
        // Please DO NOT link directly to my .js files from your site. Copy
        // the files to your server and use them there. Thank you.
        // ===================================================================

        /* SOURCE FILE: AnchorPosition.js */



        function NoofTyrescheck(str) {
            var NoTyres = document.getElementById(str).value
            if (NoTyres.length < 2) {
                alert("Please Enter At least in 2 digit. !!")
                document.getElementById(str).focus()
                return false
            }

        }


        var s = "1"
        function vehiclecheck(str) {
            if (document.getElementById(str).value != "") {
                document.getElementById(str).value = trimAll(document.getElementById(str).value)
                document.getElementById(str).value = document.getElementById(str).value.toUpperCase()
                var a = false
                a = IsText(document.getElementById(str).value.toUpperCase())
                if (a == false) {
                    alert("Only Numbers and Alphabates Are Allowed !!")
                    p = "2"
                    document.getElementById(str).focus()
                    return false
                }
                var b = document.getElementById(str).value
                if (b.length < 4 || b.length > 10) {
                    alert("Please Enter Valid Vehicle No. Length !!")
                    document.getElementById(str).focus()
                    return false
                }
                var p = "1"
                for (i = 0; i < vehno.length; i++) {

                    if (document.getElementById(str).value == vehno[i]) {
                        alert("Vehicle already exists !!")
                        document.getElementById(str).focus()
                        p = "2"
                        return false
                    }


                }
                if (p == "1") {


                    //alert("This vehicle is not registred !!")
                    //document.getElementById(str).focus()
                    //return false
                }
            }
            else {
                return false
            }
        }
        function chkdateloc(obj) {
            ////debugger
            //if (dateattach==true)
            //{
            if (obj.value != "") {
                var dockdt = obj.value

                if (dockdt.length < 10) {
                    //alert("Please enter the date in dd/mm/yyyy format")
                    obj.focus();
                    return false;
                }

                if (isDate1(obj.value) == false) {
                    obj.focus()
                    return false
                }

            }
            if (obj.value != "") {
                var mToday = "<%=strToday %>";
                mToday = mToday.substring(3, 5) + "/" + mToday.substring(0, 2) + "/" + mToday.substring(6, 10);
                var mLocStartDate = obj.value;
                mLocStartDate = mLocStartDate.substring(3, 5) + "/" + mLocStartDate.substring(0, 2) + "/" + mLocStartDate.substring(6, 10);

                //Check for Date From and Date To Date range
                if (findDateDifference(mToday, mLocStartDate, "d") < 0) {
                    alert("Enter Date Greater Than Today!");
                    obj.focus();
                    return false;
                }
            }
            else {
                return false
            }
        }
        function chkdatereg(obj) {
            ////debugger
            if (dateattach == false) {
                return false
            }
            if (obj.value != "") {
                var dockdt = obj.value

                if (dockdt.length < 10) {
                    //alert("Please enter the date in dd/mm/yyyy format")
                    obj.focus();
                    return false;
                }

                if (isDate1(obj.value) == false) {
                    obj.focus()
                    return false
                }

            }
            if (obj.value != "") {
                var mToday = "<%=strToday %>";
                mToday = mToday.substring(3, 5) + "/" + mToday.substring(0, 2) + "/" + mToday.substring(6, 10);
                var mLocStartDate = obj.value;
                mLocStartDate = mLocStartDate.substring(3, 5) + "/" + mLocStartDate.substring(0, 2) + "/" + mLocStartDate.substring(6, 10);

                //Check for Date From and Date To Date range
                if (findDateDifference(mToday, mLocStartDate, "d") > 0) {
                    alert("Enter Date Less Than Today!");
                    obj.focus();
                    return false;
                }
            }
            else {
                return false
            }
        }
        function vehiclecheckonsubmit(str) {
            if (document.getElementById(str).value != "") {
                document.getElementById(str).value = trimAll(document.getElementById(str).value)
                document.getElementById(str).value = document.getElementById(str).value.toUpperCase()
                s = "1"
                for (i = 0; i < vehno.length; i++) {

                    if (document.getElementById(str).value == vehno[i]) {
                        //alert("Vehicle already exists !!")
                        document.getElementById(str).focus()
                        s = "2"
                        return false
                    }

                }

            }
            else {
                return false
            }
        }
        function trimAll(strValue) {
            //Trimming left most white space characters
            while (strValue.substring(0, 1) == ' ') {
                strValue = strValue.substring(1, strValue.length);
            }
            //Trimming right most white space characters
            while (strValue.substring(strValue.length - 1, strValue.length) == ' ') {
                strValue = strValue.substring(0, strValue.length - 1);
            }

            return strValue;
        }
        function checklocation(obj) {
            if (obj.value != "") {
                var a;
                a = 1;
                obj.value = obj.value.toUpperCase()
                for (i = 0; i < str.length; i++) {

                    if (obj.value == str[i]) {
                        a = 2
                        break;
                        //return false;
                    }
                    else {
                        continue
                    }
                }
                if (a != 2) {
                    alert("please enter valid location")
                    obj.focus();
                }
            }
        }
        function getAnchorPosition(anchorname) { var useWindow = false; var coordinates = new Object(); var x = 0, y = 0; var use_gebi = false, use_css = false, use_layers = false; if (document.getElementById) { use_gebi = true; } else if (document.all) { use_css = true; } else if (document.layers) { use_layers = true; } if (use_gebi && document.all) { x = AnchorPosition_getPageOffsetLeft(document.all[anchorname]); y = AnchorPosition_getPageOffsetTop(document.all[anchorname]); } else if (use_gebi) { var o = document.getElementById(anchorname); x = AnchorPosition_getPageOffsetLeft(o); y = AnchorPosition_getPageOffsetTop(o); } else if (use_css) { x = AnchorPosition_getPageOffsetLeft(document.all[anchorname]); y = AnchorPosition_getPageOffsetTop(document.all[anchorname]); } else if (use_layers) { var found = 0; for (var i = 0; i < document.anchors.length; i++) { if (document.anchors[i].name == anchorname) { found = 1; break; } } if (found == 0) { coordinates.x = 0; coordinates.y = 0; return coordinates; } x = document.anchors[i].x; y = document.anchors[i].y; } else { coordinates.x = 0; coordinates.y = 0; return coordinates; } coordinates.x = x; coordinates.y = y; return coordinates; }
        function getAnchorWindowPosition(anchorname) { var coordinates = getAnchorPosition(anchorname); var x = 0; var y = 0; if (document.getElementById) { if (isNaN(window.screenX)) { x = coordinates.x - document.body.scrollLeft + window.screenLeft; y = coordinates.y - document.body.scrollTop + window.screenTop; } else { x = coordinates.x + window.screenX + (window.outerWidth - window.innerWidth) - window.pageXOffset; y = coordinates.y + window.screenY + (window.outerHeight - 24 - window.innerHeight) - window.pageYOffset; } } else if (document.all) { x = coordinates.x - document.body.scrollLeft + window.screenLeft; y = coordinates.y - document.body.scrollTop + window.screenTop; } else if (document.layers) { x = coordinates.x + window.screenX + (window.outerWidth - window.innerWidth) - window.pageXOffset; y = coordinates.y + window.screenY + (window.outerHeight - 24 - window.innerHeight) - window.pageYOffset; } coordinates.x = x; coordinates.y = y; return coordinates; }
        function AnchorPosition_getPageOffsetLeft(el) { var ol = el.offsetLeft; while ((el = el.offsetParent) != null) { ol += el.offsetLeft; } return ol; }
        function AnchorPosition_getWindowOffsetLeft(el) { return AnchorPosition_getPageOffsetLeft(el) - document.body.scrollLeft; }
        function AnchorPosition_getPageOffsetTop(el) { var ot = el.offsetTop; while ((el = el.offsetParent) != null) { ot += el.offsetTop; } return ot; }
        function AnchorPosition_getWindowOffsetTop(el) { return AnchorPosition_getPageOffsetTop(el) - document.body.scrollTop; }

        /* SOURCE FILE: date.js */
        var MONTH_NAMES = new Array('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'); var DAY_NAMES = new Array('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat');
        function LZ(x) { return (x < 0 || x > 9 ? "" : "0") + x }
        function isDate(val, format) { var date = getDateFromFormat(val, format); if (date == 0) { return false; } return true; }
        function compareDates(date1, dateformat1, date2, dateformat2) { var d1 = getDateFromFormat(date1, dateformat1); var d2 = getDateFromFormat(date2, dateformat2); if (d1 == 0 || d2 == 0) { return -1; } else if (d1 > d2) { return 1; } return 0; }
        function formatDate(date, format) { format = format + ""; var result = ""; var i_format = 0; var c = ""; var token = ""; var y = date.getYear() + ""; var M = date.getMonth() + 1; var d = date.getDate(); var E = date.getDay(); var H = date.getHours(); var m = date.getMinutes(); var s = date.getSeconds(); var yyyy, yy, MMM, MM, dd, hh, h, mm, ss, ampm, HH, H, KK, K, kk, k; var value = new Object(); if (y.length < 4) { y = "" + (y - 0 + 1900); } value["y"] = "" + y; value["yyyy"] = y; value["yy"] = y.substring(2, 4); value["M"] = M; value["MM"] = LZ(M); value["MMM"] = MONTH_NAMES[M - 1]; value["NNN"] = MONTH_NAMES[M + 11]; value["d"] = d; value["dd"] = LZ(d); value["E"] = DAY_NAMES[E + 7]; value["EE"] = DAY_NAMES[E]; value["H"] = H; value["HH"] = LZ(H); if (H == 0) { value["h"] = 12; } else if (H > 12) { value["h"] = H - 12; } else { value["h"] = H; } value["hh"] = LZ(value["h"]); if (H > 11) { value["K"] = H - 12; } else { value["K"] = H; } value["k"] = H + 1; value["KK"] = LZ(value["K"]); value["kk"] = LZ(value["k"]); if (H > 11) { value["a"] = "PM"; } else { value["a"] = "AM"; } value["m"] = m; value["mm"] = LZ(m); value["s"] = s; value["ss"] = LZ(s); while (i_format < format.length) { c = format.charAt(i_format); token = ""; while ((format.charAt(i_format) == c) && (i_format < format.length)) { token += format.charAt(i_format++); } if (value[token] != null) { result = result + value[token]; } else { result = result + token; } } return result; }
        function _isInteger(val) { var digits = "1234567890"; for (var i = 0; i < val.length; i++) { if (digits.indexOf(val.charAt(i)) == -1) { return false; } } return true; }
        function _getInt(str, i, minlength, maxlength) { for (var x = maxlength; x >= minlength; x--) { var token = str.substring(i, i + x); if (token.length < minlength) { return null; } if (_isInteger(token)) { return token; } } return null; }
        function getDateFromFormat(val, format) { val = val + ""; format = format + ""; var i_val = 0; var i_format = 0; var c = ""; var token = ""; var token2 = ""; var x, y; var now = new Date(); var year = now.getYear(); var month = now.getMonth() + 1; var date = 1; var hh = now.getHours(); var mm = now.getMinutes(); var ss = now.getSeconds(); var ampm = ""; while (i_format < format.length) { c = format.charAt(i_format); token = ""; while ((format.charAt(i_format) == c) && (i_format < format.length)) { token += format.charAt(i_format++); } if (token == "yyyy" || token == "yy" || token == "y") { if (token == "yyyy") { x = 4; y = 4; } if (token == "yy") { x = 2; y = 2; } if (token == "y") { x = 2; y = 4; } year = _getInt(val, i_val, x, y); if (year == null) { return 0; } i_val += year.length; if (year.length == 2) { if (year > 70) { year = 1900 + (year - 0); } else { year = 2000 + (year - 0); } } } else if (token == "MMM" || token == "NNN") { month = 0; for (var i = 0; i < MONTH_NAMES.length; i++) { var month_name = MONTH_NAMES[i]; if (val.substring(i_val, i_val + month_name.length).toLowerCase() == month_name.toLowerCase()) { if (token == "MMM" || (token == "NNN" && i > 11)) { month = i + 1; if (month > 12) { month -= 12; } i_val += month_name.length; break; } } } if ((month < 1) || (month > 12)) { return 0; } } else if (token == "EE" || token == "E") { for (var i = 0; i < DAY_NAMES.length; i++) { var day_name = DAY_NAMES[i]; if (val.substring(i_val, i_val + day_name.length).toLowerCase() == day_name.toLowerCase()) { i_val += day_name.length; break; } } } else if (token == "MM" || token == "M") { month = _getInt(val, i_val, token.length, 2); if (month == null || (month < 1) || (month > 12)) { return 0; } i_val += month.length; } else if (token == "dd" || token == "d") { date = _getInt(val, i_val, token.length, 2); if (date == null || (date < 1) || (date > 31)) { return 0; } i_val += date.length; } else if (token == "hh" || token == "h") { hh = _getInt(val, i_val, token.length, 2); if (hh == null || (hh < 1) || (hh > 12)) { return 0; } i_val += hh.length; } else if (token == "HH" || token == "H") { hh = _getInt(val, i_val, token.length, 2); if (hh == null || (hh < 0) || (hh > 23)) { return 0; } i_val += hh.length; } else if (token == "KK" || token == "K") { hh = _getInt(val, i_val, token.length, 2); if (hh == null || (hh < 0) || (hh > 11)) { return 0; } i_val += hh.length; } else if (token == "kk" || token == "k") { hh = _getInt(val, i_val, token.length, 2); if (hh == null || (hh < 1) || (hh > 24)) { return 0; } i_val += hh.length; hh--; } else if (token == "mm" || token == "m") { mm = _getInt(val, i_val, token.length, 2); if (mm == null || (mm < 0) || (mm > 59)) { return 0; } i_val += mm.length; } else if (token == "ss" || token == "s") { ss = _getInt(val, i_val, token.length, 2); if (ss == null || (ss < 0) || (ss > 59)) { return 0; } i_val += ss.length; } else if (token == "a") { if (val.substring(i_val, i_val + 2).toLowerCase() == "am") { ampm = "AM"; } else if (val.substring(i_val, i_val + 2).toLowerCase() == "pm") { ampm = "PM"; } else { return 0; } i_val += 2; } else { if (val.substring(i_val, i_val + token.length) != token) { return 0; } else { i_val += token.length; } } } if (i_val != val.length) { return 0; } if (month == 2) { if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) { if (date > 29) { return 0; } } else { if (date > 28) { return 0; } } } if ((month == 4) || (month == 6) || (month == 9) || (month == 11)) { if (date > 30) { return 0; } } if (hh < 12 && ampm == "PM") { hh = hh - 0 + 12; } else if (hh > 11 && ampm == "AM") { hh -= 12; } var newdate = new Date(year, month - 1, date, hh, mm, ss); return newdate.getTime(); }
        function parseDate(val) { var preferEuro = (arguments.length == 2) ? arguments[1] : false; generalFormats = new Array('y-M-d', 'MMM d, y', 'MMM d,y', 'y-MMM-d', 'd-MMM-y', 'MMM d'); monthFirst = new Array('M/d/y', 'M-d-y', 'M.d.y', 'MMM-d', 'M/d', 'M-d'); dateFirst = new Array('d/M/y', 'd-M-y', 'd.M.y', 'd-MMM', 'd/M', 'd-M'); var checkList = new Array('generalFormats', preferEuro ? 'dateFirst' : 'monthFirst', preferEuro ? 'monthFirst' : 'dateFirst'); var d = null; for (var i = 0; i < checkList.length; i++) { var l = window[checkList[i]]; for (var j = 0; j < l.length; j++) { d = getDateFromFormat(val, l[j]); if (d != 0) { return new Date(d); } } } return null; }

        /* SOURCE FILE: PopupWindow.js */
        function PopupWindow_getXYPosition(anchorname) { var coordinates; if (this.type == "WINDOW") { coordinates = getAnchorWindowPosition(anchorname); } else { coordinates = getAnchorPosition(anchorname); } this.x = coordinates.x; this.y = coordinates.y; }
        function PopupWindow_setSize(width, height) { this.width = width; this.height = height; }
        function PopupWindow_populate(contents) { this.contents = contents; this.populated = false; }
        function PopupWindow_setUrl(url) { this.url = url; }
        function PopupWindow_setWindowProperties(props) { this.windowProperties = props; }
        function PopupWindow_refresh() { if (this.divName != null) { if (this.use_gebi) { document.getElementById(this.divName).innerHTML = this.contents; } else if (this.use_css) { document.all[this.divName].innerHTML = this.contents; } else if (this.use_layers) { var d = document.layers[this.divName]; d.document.open(); d.document.writeln(this.contents); d.document.close(); } } else { if (this.popupWindow != null && !this.popupWindow.closed) { if (this.url != "") { this.popupWindow.location.href = this.url; } else { this.popupWindow.document.open(); this.popupWindow.document.writeln(this.contents); this.popupWindow.document.close(); } this.popupWindow.focus(); } } }
        function PopupWindow_showPopup(anchorname) { this.getXYPosition(anchorname); this.x += this.offsetX; this.y += this.offsetY; if (!this.populated && (this.contents != "")) { this.populated = true; this.refresh(); } if (this.divName != null) { if (this.use_gebi) { document.getElementById(this.divName).style.left = this.x + "px"; document.getElementById(this.divName).style.top = this.y + "px"; document.getElementById(this.divName).style.visibility = "visible"; } else if (this.use_css) { document.all[this.divName].style.left = this.x; document.all[this.divName].style.top = this.y; document.all[this.divName].style.visibility = "visible"; } else if (this.use_layers) { document.layers[this.divName].left = this.x; document.layers[this.divName].top = this.y; document.layers[this.divName].visibility = "visible"; } } else { if (this.popupWindow == null || this.popupWindow.closed) { if (this.x < 0) { this.x = 0; } if (this.y < 0) { this.y = 0; } if (screen && screen.availHeight) { if ((this.y + this.height) > screen.availHeight) { this.y = screen.availHeight - this.height; } } if (screen && screen.availWidth) { if ((this.x + this.width) > screen.availWidth) { this.x = screen.availWidth - this.width; } } var avoidAboutBlank = window.opera || (document.layers && !navigator.mimeTypes['*']) || navigator.vendor == 'KDE' || (document.childNodes && !document.all && !navigator.taintEnabled); this.popupWindow = window.open(avoidAboutBlank ? "" : "about:blank", "window_" + anchorname, this.windowProperties + ",width=" + this.width + ",height=" + this.height + ",screenX=" + this.x + ",left=" + this.x + ",screenY=" + this.y + ",top=" + this.y + ""); } this.refresh(); } }
        function PopupWindow_hidePopup() { if (this.divName != null) { if (this.use_gebi) { document.getElementById(this.divName).style.visibility = "hidden"; } else if (this.use_css) { document.all[this.divName].style.visibility = "hidden"; } else if (this.use_layers) { document.layers[this.divName].visibility = "hidden"; } } else { if (this.popupWindow && !this.popupWindow.closed) { this.popupWindow.close(); this.popupWindow = null; } } }
        function PopupWindow_isClicked(e) { if (this.divName != null) { if (this.use_layers) { var clickX = e.pageX; var clickY = e.pageY; var t = document.layers[this.divName]; if ((clickX > t.left) && (clickX < t.left + t.clip.width) && (clickY > t.top) && (clickY < t.top + t.clip.height)) { return true; } else { return false; } } else if (document.all) { var t = window.event.srcElement; while (t.parentElement != null) { if (t.id == this.divName) { return true; } t = t.parentElement; } return false; } else if (this.use_gebi && e) { var t = e.originalTarget; while (t.parentNode != null) { if (t.id == this.divName) { return true; } t = t.parentNode; } return false; } return false; } return false; }
        function PopupWindow_hideIfNotClicked(e) { if (this.autoHideEnabled && !this.isClicked(e)) { this.hidePopup(); } }
        function PopupWindow_autoHide() { this.autoHideEnabled = true; }
        function PopupWindow_hidePopupWindows(e) { for (var i = 0; i < popupWindowObjects.length; i++) { if (popupWindowObjects[i] != null) { var p = popupWindowObjects[i]; p.hideIfNotClicked(e); } } }
        function PopupWindow_attachListener() { if (document.layers) { document.captureEvents(Event.MOUSEUP); } window.popupWindowOldEventListener = document.onmouseup; if (window.popupWindowOldEventListener != null) { document.onmouseup = new Function("window.popupWindowOldEventListener();PopupWindow_hidePopupWindows();"); } else { document.onmouseup = PopupWindow_hidePopupWindows; } }
        function PopupWindow() { if (!window.popupWindowIndex) { window.popupWindowIndex = 0; } if (!window.popupWindowObjects) { window.popupWindowObjects = new Array(); } if (!window.listenerAttached) { window.listenerAttached = true; PopupWindow_attachListener(); } this.index = popupWindowIndex++; popupWindowObjects[this.index] = this; this.divName = null; this.popupWindow = null; this.width = 0; this.height = 0; this.populated = false; this.visible = false; this.autoHideEnabled = false; this.contents = ""; this.url = ""; this.windowProperties = "toolbar=no,location=no,status=no,menubar=no,scrollbars=auto,resizable,alwaysRaised,dependent,titlebar=no"; if (arguments.length > 0) { this.type = "DIV"; this.divName = arguments[0]; } else { this.type = "WINDOW"; } this.use_gebi = false; this.use_css = false; this.use_layers = false; if (document.getElementById) { this.use_gebi = true; } else if (document.all) { this.use_css = true; } else if (document.layers) { this.use_layers = true; } else { this.type = "WINDOW"; } this.offsetX = 0; this.offsetY = 0; this.getXYPosition = PopupWindow_getXYPosition; this.populate = PopupWindow_populate; this.setUrl = PopupWindow_setUrl; this.setWindowProperties = PopupWindow_setWindowProperties; this.refresh = PopupWindow_refresh; this.showPopup = PopupWindow_showPopup; this.hidePopup = PopupWindow_hidePopup; this.setSize = PopupWindow_setSize; this.isClicked = PopupWindow_isClicked; this.autoHide = PopupWindow_autoHide; this.hideIfNotClicked = PopupWindow_hideIfNotClicked; }

        /* SOURCE FILE: CalendarPopup.js */

        function CalendarPopup() { var c; if (arguments.length > 0) { c = new PopupWindow(arguments[0]); } else { c = new PopupWindow(); c.setSize(150, 175); } c.offsetX = -90; c.offsetY = 25; c.autoHide(); c.monthNames = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"); c.monthAbbreviations = new Array("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"); c.dayHeaders = new Array("S", "M", "T", "W", "T", "F", "S"); c.returnFunction = "CP_tmpReturnFunction"; c.returnMonthFunction = "CP_tmpReturnMonthFunction"; c.returnQuarterFunction = "CP_tmpReturnQuarterFunction"; c.returnYearFunction = "CP_tmpReturnYearFunction"; c.weekStartDay = 0; c.isShowYearNavigation = false; c.displayType = "date"; c.disabledWeekDays = new Object(); c.disabledDatesExpression = ""; c.yearSelectStartOffset = 35; c.currentDate = null; c.todayText = "Today"; c.cssPrefix = ""; c.isShowNavigationDropdowns = false; c.isShowYearNavigationInput = false; window.CP_calendarObject = null; window.CP_targetInput = null; window.CP_dateFormat = "MM/dd/yyyy"; c.copyMonthNamesToWindow = CP_copyMonthNamesToWindow; c.setReturnFunction = CP_setReturnFunction; c.setReturnMonthFunction = CP_setReturnMonthFunction; c.setReturnQuarterFunction = CP_setReturnQuarterFunction; c.setReturnYearFunction = CP_setReturnYearFunction; c.setMonthNames = CP_setMonthNames; c.setMonthAbbreviations = CP_setMonthAbbreviations; c.setDayHeaders = CP_setDayHeaders; c.setWeekStartDay = CP_setWeekStartDay; c.setDisplayType = CP_setDisplayType; c.setDisabledWeekDays = CP_setDisabledWeekDays; c.addDisabledDates = CP_addDisabledDates; c.setYearSelectStartOffset = CP_setYearSelectStartOffset; c.setTodayText = CP_setTodayText; c.showYearNavigation = CP_showYearNavigation; c.showCalendar = CP_showCalendar; c.hideCalendar = CP_hideCalendar; c.getStyles = getCalendarStyles; c.refreshCalendar = CP_refreshCalendar; c.getCalendar = CP_getCalendar; c.select = CP_select; c.setCssPrefix = CP_setCssPrefix; c.showNavigationDropdowns = CP_showNavigationDropdowns; c.showYearNavigationInput = CP_showYearNavigationInput; c.copyMonthNamesToWindow(); return c; }
        function CP_copyMonthNamesToWindow() { if (typeof (window.MONTH_NAMES) != "undefined" && window.MONTH_NAMES != null) { window.MONTH_NAMES = new Array(); for (var i = 0; i < this.monthNames.length; i++) { window.MONTH_NAMES[window.MONTH_NAMES.length] = this.monthNames[i]; } for (var i = 0; i < this.monthAbbreviations.length; i++) { window.MONTH_NAMES[window.MONTH_NAMES.length] = this.monthAbbreviations[i]; } } }
        function CP_tmpReturnFunction(y, m, d) { if (window.CP_targetInput != null) { var dt = new Date(y, m - 1, d, 0, 0, 0); if (window.CP_calendarObject != null) { window.CP_calendarObject.copyMonthNamesToWindow(); } window.CP_targetInput.value = formatDate(dt, window.CP_dateFormat); } else { alert('Use setReturnFunction() to define which function will get the clicked results!'); } }
        function CP_tmpReturnMonthFunction(y, m) { alert('Use setReturnMonthFunction() to define which function will get the clicked results!\nYou clicked: year=' + y + ' , month=' + m); }
        function CP_tmpReturnQuarterFunction(y, q) { alert('Use setReturnQuarterFunction() to define which function will get the clicked results!\nYou clicked: year=' + y + ' , quarter=' + q); }
        function CP_tmpReturnYearFunction(y) { alert('Use setReturnYearFunction() to define which function will get the clicked results!\nYou clicked: year=' + y); }
        function CP_setReturnFunction(name) { this.returnFunction = name; }
        function CP_setReturnMonthFunction(name) { this.returnMonthFunction = name; }
        function CP_setReturnQuarterFunction(name) { this.returnQuarterFunction = name; }
        function CP_setReturnYearFunction(name) { this.returnYearFunction = name; }
        function CP_setMonthNames() { for (var i = 0; i < arguments.length; i++) { this.monthNames[i] = arguments[i]; } this.copyMonthNamesToWindow(); }
        function CP_setMonthAbbreviations() { for (var i = 0; i < arguments.length; i++) { this.monthAbbreviations[i] = arguments[i]; } this.copyMonthNamesToWindow(); }
        function CP_setDayHeaders() { for (var i = 0; i < arguments.length; i++) { this.dayHeaders[i] = arguments[i]; } }
        function CP_setWeekStartDay(day) { this.weekStartDay = day; }
        function CP_showYearNavigation() { this.isShowYearNavigation = (arguments.length > 0) ? arguments[0] : true; }
        function CP_setDisplayType(type) { if (type != "date" && type != "week-end" && type != "month" && type != "quarter" && type != "year") { alert("Invalid display type! Must be one of: date,week-end,month,quarter,year"); return false; } this.displayType = type; }
        function CP_setYearSelectStartOffset(num) { this.yearSelectStartOffset = num; }
        function CP_setDisabledWeekDays() { this.disabledWeekDays = new Object(); for (var i = 0; i < arguments.length; i++) { this.disabledWeekDays[arguments[i]] = true; } }
        function CP_addDisabledDates(start, end) { if (arguments.length == 1) { end = start; } if (start == null && end == null) { return; } if (this.disabledDatesExpression != "") { this.disabledDatesExpression += "||"; } if (start != null) { start = parseDate(start); start = "" + start.getFullYear() + LZ(start.getMonth() + 1) + LZ(start.getDate()); } if (end != null) { end = parseDate(end); end = "" + end.getFullYear() + LZ(end.getMonth() + 1) + LZ(end.getDate()); } if (start == null) { this.disabledDatesExpression += "(ds<=" + end + ")"; } else if (end == null) { this.disabledDatesExpression += "(ds>=" + start + ")"; } else { this.disabledDatesExpression += "(ds>=" + start + "&&ds<=" + end + ")"; } }
        function CP_setTodayText(text) { this.todayText = text; }
        function CP_setCssPrefix(val) { this.cssPrefix = val; }
        function CP_showNavigationDropdowns() { this.isShowNavigationDropdowns = (arguments.length > 0) ? arguments[0] : true; }
        function CP_showYearNavigationInput() { this.isShowYearNavigationInput = (arguments.length > 0) ? arguments[0] : true; }
        function CP_hideCalendar() { if (arguments.length > 0) { window.popupWindowObjects[arguments[0]].hidePopup(); } else { this.hidePopup(); } }
        function CP_refreshCalendar(index) { var calObject = window.popupWindowObjects[index]; if (arguments.length > 1) { calObject.populate(calObject.getCalendar(arguments[1], arguments[2], arguments[3], arguments[4], arguments[5])); } else { calObject.populate(calObject.getCalendar()); } calObject.refresh(); }
        function CP_showCalendar(anchorname) { if (arguments.length > 1) { if (arguments[1] == null || arguments[1] == "") { this.currentDate = new Date(); } else { this.currentDate = new Date(parseDate(arguments[1])); } } this.populate(this.getCalendar()); this.showPopup(anchorname); }
        function CP_select(inputobj, linkname, format) { var selectedDate = (arguments.length > 3) ? arguments[3] : null; if (!window.getDateFromFormat) { alert("calendar.select: To use this method you must also include 'date.js' for date formatting"); return; } if (this.displayType != "date" && this.displayType != "week-end") { alert("calendar.select: This function can only be used with displayType 'date' or 'week-end'"); return; } if (inputobj.type != "text" && inputobj.type != "hidden" && inputobj.type != "textarea") { alert("calendar.select: Input object passed is not a valid form input object"); window.CP_targetInput = null; return; } if (inputobj.disabled) { return; } window.CP_targetInput = inputobj; window.CP_calendarObject = this; this.currentDate = null; var time = 0; if (selectedDate != null) { time = getDateFromFormat(selectedDate, format) } else if (inputobj.value != "") { time = getDateFromFormat(inputobj.value, format); } if (selectedDate != null || inputobj.value != "") { if (time == 0) { this.currentDate = null; } else { this.currentDate = new Date(time); } } window.CP_dateFormat = format; this.showCalendar(linkname); }
        function getCalendarStyles() { var result = ""; var p = ""; if (this != null && typeof (this.cssPrefix) != "undefined" && this.cssPrefix != null && this.cssPrefix != "") { p = this.cssPrefix; } result += "<STYLE>\n"; result += "." + p + "cpYearNavigation,." + p + "cpMonthNavigation{background-color:#C0C0C0;text-align:center;vertical-align:center;text-decoration:none;color:#000000;label-weight:bold;}\n"; result += "." + p + "cpDayColumnHeader, ." + p + "cpYearNavigation,." + p + "cpMonthNavigation,." + p + "cpCurrentMonthDate,." + p + "cpCurrentMonthDateDisabled,." + p + "cpOtherMonthDate,." + p + "cpOtherMonthDateDisabled,." + p + "cpCurrentDate,." + p + "cpCurrentDateDisabled,." + p + "cpTodayText,." + p + "cpTodayTextDisabled,." + p + "cpText{label-family:arial;label-size:8pt;}\n"; result += "TD." + p + "cpDayColumnHeader{text-align:right;border:solid thin #C0C0C0;border-width:0px 0px 1px 0px;}\n"; result += "." + p + "cpCurrentMonthDate, ." + p + "cpOtherMonthDate, ." + p + "cpCurrentDate{text-align:right;text-decoration:none;}\n"; result += "." + p + "cpCurrentMonthDateDisabled, ." + p + "cpOtherMonthDateDisabled, ." + p + "cpCurrentDateDisabled{color:#D0D0D0;text-align:right;text-decoration:line-through;}\n"; result += "." + p + "cpCurrentMonthDate, .cpCurrentDate{color:#000000;}\n"; result += "." + p + "cpOtherMonthDate{color:#808080;}\n"; result += "TD." + p + "cpCurrentDate{color:white;background-color: #C0C0C0;border-width:1px;border:solid thin #800000;}\n"; result += "TD." + p + "cpCurrentDateDisabled{border-width:1px;border:solid thin #FFAAAA;}\n"; result += "TD." + p + "cpTodayText, TD." + p + "cpTodayTextDisabled{border:solid thin #C0C0C0;border-width:1px 0px 0px 0px;}\n"; result += "A." + p + "cpTodayText, SPAN." + p + "cpTodayTextDisabled{height:20px;}\n"; result += "A." + p + "cpTodayText{color:black;}\n"; result += "." + p + "cpTodayTextDisabled{color:#D0D0D0;}\n"; result += "." + p + "cpBorder{border:solid thin #808080;}\n"; result += "</STYLE>\n"; return result; }
        function CP_getCalendar() { var now = new Date(); if (this.type == "WINDOW") { var windowref = "window.opener."; } else { var windowref = ""; } var result = ""; if (this.type == "WINDOW") { result += "<HTML><HEAD><TITLE>Calendar</TITLE>" + this.getStyles() + "</HEAD><BODY MARGINWIDTH=0 MARGINHEIGHT=0 TOPMARGIN=0 RIGHTMARGIN=0 LEFTMARGIN=0>\n"; result += '<CENTER><TABLE WIDTH=100% BORDER=0 BORDERWIDTH=0 CELLSPACING=0 CELLPADDING=0>\n'; } else { result += '<TABLE CLASS="' + this.cssPrefix + 'cpBorder" WIDTH=144 BORDER=1 BORDERWIDTH=1 CELLSPACING=0 CELLPADDING=1>\n'; result += '<TR><TD ALIGN=CENTER>\n'; result += '<CENTER>\n'; } if (this.displayType == "date" || this.displayType == "week-end") { if (this.currentDate == null) { this.currentDate = now; } if (arguments.length > 0) { var month = arguments[0]; } else { var month = this.currentDate.getMonth() + 1; } if (arguments.length > 1 && arguments[1] > 0 && arguments[1] - 0 == arguments[1]) { var year = arguments[1]; } else { var year = this.currentDate.getFullYear(); } var daysinmonth = new Array(0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31); if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) { daysinmonth[2] = 29; } var current_month = new Date(year, month - 1, 1); var display_year = year; var display_month = month; var display_date = 1; var weekday = current_month.getDay(); var offset = 0; offset = (weekday >= this.weekStartDay) ? weekday - this.weekStartDay : 7 - this.weekStartDay + weekday; if (offset > 0) { display_month--; if (display_month < 1) { display_month = 12; display_year--; } display_date = daysinmonth[display_month] - offset + 1; } var next_month = month + 1; var next_month_year = year; if (next_month > 12) { next_month = 1; next_month_year++; } var last_month = month - 1; var last_month_year = year; if (last_month < 1) { last_month = 12; last_month_year--; } var date_class; if (this.type != "WINDOW") { result += "<TABLE WIDTH=144 BORDER=0 BORDERWIDTH=0 CELLSPACING=0 CELLPADDING=0>"; } result += '<TR>\n'; var refresh = windowref + 'CP_refreshCalendar'; var refreshLink = 'javascript:' + refresh; if (this.isShowNavigationDropdowns) { result += '<TD CLASS="' + this.cssPrefix + 'cpMonthNavigation" WIDTH="78" COLSPAN="3"><select CLASS="' + this.cssPrefix + 'cpMonthNavigation" name="cpMonth" onChange="' + refresh + '(' + this.index + ',this.options[this.selectedIndex].value-0,' + (year - 0) + ');">'; for (var monthCounter = 1; monthCounter <= 12; monthCounter++) { var selected = (monthCounter == month) ? 'SELECTED' : ''; result += '<option value="' + monthCounter + '" ' + selected + '>' + this.monthNames[monthCounter - 1] + '</option>'; } result += '</select></TD>'; result += '<TD CLASS="' + this.cssPrefix + 'cpMonthNavigation" WIDTH="10">&nbsp;</TD>'; result += '<TD CLASS="' + this.cssPrefix + 'cpYearNavigation" WIDTH="56" COLSPAN="3"><select CLASS="' + this.cssPrefix + 'cpYearNavigation" name="cpYear" onChange="' + refresh + '(' + this.index + ',' + month + ',this.options[this.selectedIndex].value-0);">'; for (var yearCounter = year - this.yearSelectStartOffset; yearCounter <= year + this.yearSelectStartOffset; yearCounter++) { var selected = (yearCounter == year) ? 'SELECTED' : ''; result += '<option value="' + yearCounter + '" ' + selected + '>' + yearCounter + '</option>'; } result += '</select></TD>'; } else { if (this.isShowYearNavigation) { result += '<TD CLASS="' + this.cssPrefix + 'cpMonthNavigation" WIDTH="10"><A CLASS="' + this.cssPrefix + 'cpMonthNavigation" HREF="' + refreshLink + '(' + this.index + ',' + last_month + ',' + last_month_year + ');">&lt;</A></TD>'; result += '<TD CLASS="' + this.cssPrefix + 'cpMonthNavigation" WIDTH="58"><SPAN CLASS="' + this.cssPrefix + 'cpMonthNavigation">' + this.monthNames[month - 1] + '</SPAN></TD>'; result += '<TD CLASS="' + this.cssPrefix + 'cpMonthNavigation" WIDTH="10"><A CLASS="' + this.cssPrefix + 'cpMonthNavigation" HREF="' + refreshLink + '(' + this.index + ',' + next_month + ',' + next_month_year + ');">&gt;</A></TD>'; result += '<TD CLASS="' + this.cssPrefix + 'cpMonthNavigation" WIDTH="10">&nbsp;</TD>'; result += '<TD CLASS="' + this.cssPrefix + 'cpYearNavigation" WIDTH="10"><A CLASS="' + this.cssPrefix + 'cpYearNavigation" HREF="' + refreshLink + '(' + this.index + ',' + month + ',' + (year - 1) + ');">&lt;</A></TD>'; if (this.isShowYearNavigationInput) { result += '<TD CLASS="' + this.cssPrefix + 'cpYearNavigation" WIDTH="36"><INPUT NAME="cpYear" CLASS="' + this.cssPrefix + 'cpYearNavigation" SIZE="4" MAXLENGTH="4" VALUE="' + year + '" onBlur="' + refresh + '(' + this.index + ',' + month + ',this.value-0);"></TD>'; } else { result += '<TD CLASS="' + this.cssPrefix + 'cpYearNavigation" WIDTH="36"><SPAN CLASS="' + this.cssPrefix + 'cpYearNavigation">' + year + '</SPAN></TD>'; } result += '<TD CLASS="' + this.cssPrefix + 'cpYearNavigation" WIDTH="10"><A CLASS="' + this.cssPrefix + 'cpYearNavigation" HREF="' + refreshLink + '(' + this.index + ',' + month + ',' + (year + 1) + ');">&gt;</A></TD>'; } else { result += '<TD CLASS="' + this.cssPrefix + 'cpMonthNavigation" WIDTH="22"><A CLASS="' + this.cssPrefix + 'cpMonthNavigation" HREF="' + refreshLink + '(' + this.index + ',' + last_month + ',' + last_month_year + ');">&lt;&lt;</A></TD>\n'; result += '<TD CLASS="' + this.cssPrefix + 'cpMonthNavigation" WIDTH="100"><SPAN CLASS="' + this.cssPrefix + 'cpMonthNavigation">' + this.monthNames[month - 1] + ' ' + year + '</SPAN></TD>\n'; result += '<TD CLASS="' + this.cssPrefix + 'cpMonthNavigation" WIDTH="22"><A CLASS="' + this.cssPrefix + 'cpMonthNavigation" HREF="' + refreshLink + '(' + this.index + ',' + next_month + ',' + next_month_year + ');">&gt;&gt;</A></TD>\n'; } } result += '</TR></TABLE>\n'; result += '<TABLE WIDTH=120 BORDER=0 CELLSPACING=0 CELLPADDING=1 ALIGN=CENTER>\n'; result += '<TR>\n'; for (var j = 0; j < 7; j++) { result += '<TD CLASS="' + this.cssPrefix + 'cpDayColumnHeader" WIDTH="14%"><SPAN CLASS="' + this.cssPrefix + 'cpDayColumnHeader">' + this.dayHeaders[(this.weekStartDay + j) % 7] + '</TD>\n'; } result += '</TR>\n'; for (var row = 1; row <= 6; row++) { result += '<TR>\n'; for (var col = 1; col <= 7; col++) { var disabled = false; if (this.disabledDatesExpression != "") { var ds = "" + display_year + LZ(display_month) + LZ(display_date); eval("disabled=(" + this.disabledDatesExpression + ")"); } var dateClass = ""; if ((display_month == this.currentDate.getMonth() + 1) && (display_date == this.currentDate.getDate()) && (display_year == this.currentDate.getFullYear())) { dateClass = "cpCurrentDate"; } else if (display_month == month) { dateClass = "cpCurrentMonthDate"; } else { dateClass = "cpOtherMonthDate"; } if (disabled || this.disabledWeekDays[col - 1]) { result += '	<TD CLASS="' + this.cssPrefix + dateClass + '"><SPAN CLASS="' + this.cssPrefix + dateClass + 'Disabled">' + display_date + '</SPAN></TD>\n'; } else { var selected_date = display_date; var selected_month = display_month; var selected_year = display_year; if (this.displayType == "week-end") { var d = new Date(selected_year, selected_month - 1, selected_date, 0, 0, 0, 0); d.setDate(d.getDate() + (7 - col)); selected_year = d.getYear(); if (selected_year < 1000) { selected_year += 1900; } selected_month = d.getMonth() + 1; selected_date = d.getDate(); } result += '	<TD CLASS="' + this.cssPrefix + dateClass + '"><A HREF="javascript:' + windowref + this.returnFunction + '(' + selected_year + ',' + selected_month + ',' + selected_date + ');' + windowref + 'CP_hideCalendar(\'' + this.index + '\');" CLASS="' + this.cssPrefix + dateClass + '">' + display_date + '</A></TD>\n'; } display_date++; if (display_date > daysinmonth[display_month]) { display_date = 1; display_month++; } if (display_month > 12) { display_month = 1; display_year++; } } result += '</TR>'; } var current_weekday = now.getDay() - this.weekStartDay; if (current_weekday < 0) { current_weekday += 7; } result += '<TR>\n'; result += '	<TD COLSPAN=7 ALIGN=CENTER CLASS="' + this.cssPrefix + 'cpTodayText">\n'; if (this.disabledDatesExpression != "") { var ds = "" + now.getFullYear() + LZ(now.getMonth() + 1) + LZ(now.getDate()); eval("disabled=(" + this.disabledDatesExpression + ")"); } if (disabled || this.disabledWeekDays[current_weekday + 1]) { result += '		<SPAN CLASS="' + this.cssPrefix + 'cpTodayTextDisabled">' + this.todayText + '</SPAN>\n'; } else { result += '		<A CLASS="' + this.cssPrefix + 'cpTodayText" HREF="javascript:' + windowref + this.returnFunction + '(\'' + now.getFullYear() + '\',\'' + (now.getMonth() + 1) + '\',\'' + now.getDate() + '\');' + windowref + 'CP_hideCalendar(\'' + this.index + '\');">' + this.todayText + '</A>\n'; } result += '		<BR>\n'; result += '	</TD></TR></TABLE></CENTER></TD></TR></TABLE>\n'; } if (this.displayType == "month" || this.displayType == "quarter" || this.displayType == "year") { if (arguments.length > 0) { var year = arguments[0]; } else { if (this.displayType == "year") { var year = now.getFullYear() - this.yearSelectStartOffset; } else { var year = now.getFullYear(); } } if (this.displayType != "year" && this.isShowYearNavigation) { result += "<TABLE WIDTH=144 BORDER=0 BORDERWIDTH=0 CELLSPACING=0 CELLPADDING=0>"; result += '<TR>\n'; result += '	<TD CLASS="' + this.cssPrefix + 'cpYearNavigation" WIDTH="22"><A CLASS="' + this.cssPrefix + 'cpYearNavigation" HREF="javascript:' + windowref + 'CP_refreshCalendar(' + this.index + ',' + (year - 1) + ');">&lt;&lt;</A></TD>\n'; result += '	<TD CLASS="' + this.cssPrefix + 'cpYearNavigation" WIDTH="100">' + year + '</TD>\n'; result += '	<TD CLASS="' + this.cssPrefix + 'cpYearNavigation" WIDTH="22"><A CLASS="' + this.cssPrefix + 'cpYearNavigation" HREF="javascript:' + windowref + 'CP_refreshCalendar(' + this.index + ',' + (year + 1) + ');">&gt;&gt;</A></TD>\n'; result += '</TR></TABLE>\n'; } } if (this.displayType == "month") { result += '<TABLE WIDTH=120 BORDER=0 CELLSPACING=1 CELLPADDING=0 ALIGN=CENTER>\n'; for (var i = 0; i < 4; i++) { result += '<TR>'; for (var j = 0; j < 3; j++) { var monthindex = ((i * 3) + j); result += '<TD WIDTH=33% ALIGN=CENTER><A CLASS="' + this.cssPrefix + 'cpText" HREF="javascript:' + windowref + this.returnMonthFunction + '(' + year + ',' + (monthindex + 1) + ');' + windowref + 'CP_hideCalendar(\'' + this.index + '\');" CLASS="' + date_class + '">' + this.monthAbbreviations[monthindex] + '</A></TD>'; } result += '</TR>'; } result += '</TABLE></CENTER></TD></TR></TABLE>\n'; } if (this.displayType == "quarter") { result += '<BR><TABLE WIDTH=120 BORDER=1 CELLSPACING=0 CELLPADDING=0 ALIGN=CENTER>\n'; for (var i = 0; i < 2; i++) { result += '<TR>'; for (var j = 0; j < 2; j++) { var quarter = ((i * 2) + j + 1); result += '<TD WIDTH=50% ALIGN=CENTER><BR><A CLASS="' + this.cssPrefix + 'cpText" HREF="javascript:' + windowref + this.returnQuarterFunction + '(' + year + ',' + quarter + ');' + windowref + 'CP_hideCalendar(\'' + this.index + '\');" CLASS="' + date_class + '">Q' + quarter + '</A><BR><BR></TD>'; } result += '</TR>'; } result += '</TABLE></CENTER></TD></TR></TABLE>\n'; } if (this.displayType == "year") { var yearColumnSize = 4; result += "<TABLE WIDTH=144 BORDER=0 BORDERWIDTH=0 CELLSPACING=0 CELLPADDING=0>"; result += '<TR>\n'; result += '	<TD CLASS="' + this.cssPrefix + 'cpYearNavigation" WIDTH="50%"><A CLASS="' + this.cssPrefix + 'cpYearNavigation" HREF="javascript:' + windowref + 'CP_refreshCalendar(' + this.index + ',' + (year - (yearColumnSize * 2)) + ');">&lt;&lt;</A></TD>\n'; result += '	<TD CLASS="' + this.cssPrefix + 'cpYearNavigation" WIDTH="50%"><A CLASS="' + this.cssPrefix + 'cpYearNavigation" HREF="javascript:' + windowref + 'CP_refreshCalendar(' + this.index + ',' + (year + (yearColumnSize * 2)) + ');">&gt;&gt;</A></TD>\n'; result += '</TR></TABLE>\n'; result += '<TABLE WIDTH=120 BORDER=0 CELLSPACING=1 CELLPADDING=0 ALIGN=CENTER>\n'; for (var i = 0; i < yearColumnSize; i++) { for (var j = 0; j < 2; j++) { var currentyear = year + (j * yearColumnSize) + i; result += '<TD WIDTH=50% ALIGN=CENTER><A CLASS="' + this.cssPrefix + 'cpText" HREF="javascript:' + windowref + this.returnYearFunction + '(' + currentyear + ');' + windowref + 'CP_hideCalendar(\'' + this.index + '\');" CLASS="' + date_class + '">' + currentyear + '</A></TD>'; } result += '</TR>'; } result += '</TABLE></CENTER></TD></TR></TABLE>\n'; } if (this.type == "WINDOW") { result += "</BODY></HTML>\n"; } return result; }

    </script>
    <script language="javascript" type="text/javascript">

        var cal = new CalendarPopup("divDate");

        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

    </script>
    <script language="javascript" type="text/javascript">
        function setVehicleNo(obj) {
            document.getElementById("ctl00_MyCPH1_txtRgnNo").value = document.getElementById("ctl00_MyCPH1_txtVehicleNo").value;
        }
        // JScript File
        function checknumber(obj) {
            // debugger;
            if (isNaN(obj.value)) {
                alert("Value Should Be Numeric !!")
                obj.focus()
                return false
            }
            if (obj.value < 0) {
                alert("Value should be greater than zero !!")
                obj.value = "";
                obj.focus();
                return false;
            }
            else {
                document.getElementById("ctl00_MyCPH1_txtPayload").value = document.getElementById("ctl00_MyCPH1_txtGVW").value - document.getElementById("ctl00_MyCPH1_txtUnladen").value;
                document.getElementById("ctl00_MyCPH1_txtCapacity").value = document.getElementById("ctl00_MyCPH1_txtGVW").value - document.getElementById("ctl00_MyCPH1_txtUnladen").value;

                document.getElementById("ctl00_MyCPH1_hdnPayload").value = document.getElementById("ctl00_MyCPH1_txtGVW").value - document.getElementById("ctl00_MyCPH1_txtUnladen").value;
                document.getElementById("ctl00_MyCPH1_hdnCapacity").value = document.getElementById("ctl00_MyCPH1_txtGVW").value - document.getElementById("ctl00_MyCPH1_txtUnladen").value;
                return true;
            }
        }
        var months = new Array("", "January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December");

        var dtCh = "/";
        var minYear = 1900;
        var maxYear = 2100;

        function isInteger(s) {
            for (var i = 0; i < s.length; i++) {
                // Check that current character is number.
                var c = s.charAt(i);
                if (((c < "0") || (c > "9"))) return false;
            }
            // All characters are numbers.
            return true;
        }

        function stripCharsInBag(s, bag) {
            var returnString = "";
            // Search through string's characters one by one.
            // If character is not in bag, append to returnString.
            for (var i = 0; i < s.length; i++) {
                var c = s.charAt(i);
                if (bag.indexOf(c) == -1) returnString += c;
            }

            return returnString;
        }

        function daysInFebruary(year) {
            // February has 29 days in any year evenly divisible by four,
            // EXCEPT for centurial years which are not also divisible by 400.
            return (((year % 4 == 0) && ((!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28);
        }

        function DaysArray(n) {
            for (var i = 1; i <= n; i++) {
                this[i] = 31
                if (i == 4 || i == 6 || i == 9 || i == 11) { this[i] = 30 }
                if (i == 2) { this[i] = 29 }
            }

            return this
        }

        function isDate1(dtStr) {
            ////debugger
            var daysInMonth = DaysArray(12)
            var pos1 = dtStr.indexOf(dtCh)
            var pos2 = dtStr.indexOf(dtCh, pos1 + 1)
            var strDay = dtStr.substring(0, pos1)
            var strMonth = dtStr.substring(pos1 + 1, pos2)
            var strYear = dtStr.substring(pos2 + 1)

            strYr = strYear

            if (strDay.charAt(0) == "0" && strDay.length > 1) strDay = strDay.substring(1)
            if (strMonth.charAt(0) == "0" && strMonth.length > 1) strMonth = strMonth.substring(1)

            for (var i = 1; i <= 3; i++) {
                if (strYr.charAt(0) == "0" && strYr.length > 1) strYr = strYr.substring(1)
            }

            month = parseInt(strMonth)
            day = parseInt(strDay)
            year = parseInt(strYr)

            if (pos1 == -1 || pos2 == -1) {
                alert("The date format should be : dd/mm/yyyy")
                return false
            }

            if (strDay.length < 1 || day < 1 || day > 31 || (month == 2 && day > daysInFebruary(year)) || day > daysInMonth[month]) {
                alert("Please enter a valid day")
                return false
            }

            if (strMonth.length < 1 || month < 1 || month > 12) {
                alert("Please enter a valid month")
                return false
            }

            if (strYear.length != 4 || year == 0 || year < minYear || year > maxYear) {
                alert("Please enter a valid 4 digit year between " + minYear + " and " + maxYear)
                return false
            }

            if (dtStr.indexOf(dtCh, pos2 + 1) != -1 || isInteger(stripCharsInBag(dtStr, dtCh)) == false) {
                alert("Please enter a valid date")
                return false
            }

            return true
        }

        function ValidateTime(objMF, strHHMM) {
            objMF.value = trimAll(objMF.value);

            if (objMF.value == "") {
                if (strHHMM == "2") {
                    alert("Enter Time in Minutes between 1 & 59");
                }
                else {
                    alert("Enter Time in Hours between 1 & 23");
                }
                return false;
            }

            if (strHHMM == "1") {
                if (IsNumericWoDot(objMF.value) == false) {
                    alert("Enter Time in Hours between 1 & 23");
                    return false;
                }

                if (eval(objMF.value) < 1 && eval(objMF.value) > 23) {
                    alert("Enter Time in Hours between 1 & 23");
                    return false;
                }
            }
            else {
                if (IsNumericWoDot(objMF.value) == false) {
                    alert("Enter Time in Minutes between 1 & 59");
                    return false;
                }

                if (eval(objMF.value) < 1 && eval(objMF.value) > 59) {
                    alert("Enter Time in Minutes between 1 & 59");
                    return false;
                }
            }
        }
        var dateattach
        function ValidateDate(obj) {
            ////debugger
            dateattach = false
            if (obj.value != "") {
                var dockdt = obj.value
                if (dockdt.length < 10) {
                    alert("Please enter the date in dd/mm/yyyy format")
                    obj.focus();
                    return false;
                }

                if (isDate1(obj.value) == false) {
                    dateattach = false
                    obj.focus()
                    return false
                }
                //alert("Hiii")
                dateattach = true
                return true
            }
        }

        function MyDateDiff(start, end, interval, rounding) {
            var iOut = 0;
            var bufferA = Date.parse(start);
            var bufferB = Date.parse(end);

            // check that the start parameter is a valid Date. 
            if (isNaN(bufferA) || isNaN(bufferB)) {
                alert(startMsg);
                return null;
            }

            // check that an interval parameter was not numeric. 
            if (interval.charAt == 'undefined') {
                // the user specified an incorrect interval, handle the error. 
                alert(intervalMsg);
                return null;
            }

            var number = bufferB - bufferA;

            // what kind of add to do? 
            switch (interval.charAt(0)) {
                case 'd': case 'D':
                    iOut = parseInt(number / 86400000);
                    if (rounding) iOut += parseInt((number % 86400000) / 43200001);
                    break;
                case 'h': case 'H':
                    iOut = parseInt(number / 3600000);
                    if (rounding) iOut += parseInt((number % 3600000) / 1800001);
                    break;
                case 'm': case 'M':
                    iOut = parseInt(number / 60000);
                    if (rounding) iOut += parseInt((number % 60000) / 30001);
                    break;
                case 's': case 'S':
                    iOut = parseInt(number / 1000);
                    if (rounding) iOut += parseInt((number % 1000) / 501);
                    break;
                default:
                    // If we get to here then the interval parameter
                    // didn't meet the d,h,m,s criteria.  Handle
                    // the error. 		
                    alert(intervalMsg);
                    return null;
            }

            return iOut;
        }

        function trimAll(strValue) {
            //Trimming left most white space characters
            while (strValue.substring(0, 1) == ' ') {
                strValue = strValue.substring(1, strValue.length);
            }
            //Trimming right most white space characters
            while (strValue.substring(strValue.length - 1, strValue.length) == ' ') {
                strValue = strValue.substring(0, strValue.length - 1);
            }
            return strValue;
        }

        function IsNumeric(sText) {
            var ValidChars = "0123456789.";
            var IsNumber = true;
            var Char;

            for (i = 0; i < sText.length && IsNumber == true; i++) {
                Char = sText.charAt(i);

                if (ValidChars.indexOf(Char) == -1) {
                    IsNumber = false;
                }
            }

            return IsNumber;
        }

        function IsNumericWoDot(sText) {
            var ValidChars = "0123456789";
            var IsNumber = true;
            var Char;

            for (i = 0; i < sText.length && IsNumber == true; i++) {
                Char = sText.charAt(i);

                if (ValidChars.indexOf(Char) == -1) {
                    IsNumber = false;
                }
            }

            return IsNumber;
        }

        function Nagative_Chk_wDecimal(obj) {
            var temp = trimAll(obj.value)

            if (temp == "") {
                /*alert("Value can not be blank")
                obj.focus();
                return false;*/
                return true;
            }

            if (isNaN(temp)) {
                alert("Value should be Numeric")
                obj.focus();
                return false;
            }

            if (parseFloat(temp) < 0) {
                alert("Value should be greater than zero")
                obj.focus();
                return false;
            }

            obj.value = roundit(temp)

            return true;
        }

        function Nagative_Chk_woDecimal(obj) {
            var temp = obj.value

            if (temp == "") {
                alert("Value can not be blank")
                obj.focus();
                return false;
            }

            if (isNaN(temp)) {
                alert("Value should be Numeric")
                obj.focus();
                return false;
            }

            if (parseFloat(temp) < 0) {
                alert("Value should be greater than zero")
                obj.focus();
                return false;
            }

            if (temp.indexOf(".") > 0) {
                alert("Value should not contain decimal point")
                obj.focus();
                return false;
            }

            obj.value = Math.round(temp)

            return true;
        }

        function rounditn(Num, decplaces) {
            Places = decplaces

            if (Places > 0) {
                if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places + 1)) {
                    if (Num.toString().lastIndexOf('.') < 0) {
                        return Num.toString() + '.00';
                    }

                    var Rounder = Math.pow(10, Places);

                    return Math.round(Num * Rounder) / Rounder;
                }
                else {
                    if (Num.toString().lastIndexOf('.') < 0) {
                        return Num.toString() + '.00';
                    }
                    else {
                        if (Num.toString().lastIndexOf('.') + 1 == Num.toString().length - 1)
                            return Num.toString() + '0';
                        else
                            return Num.toString();
                    }
                }
            }
            else {
                return Math.round(Num);
            }
        }

        function roundit(Num) {
            Places = 2

            if (Places > 0) {
                if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places + 1)) {
                    if (Num.toString().lastIndexOf('.') < 0) {
                        return Num.toString() + '.00';
                    }

                    var Rounder = Math.pow(10, Places);

                    return Math.round(Num * Rounder) / Rounder;
                }
                else {
                    if (Num.toString().lastIndexOf('.') < 0) {
                        return Num.toString() + '.00';
                    }
                    else {
                        if (Num.toString().lastIndexOf('.') + 1 == Num.toString().length - 1) {
                            return Num.toString() + '0';
                        }
                        else {
                            return Num.toString();
                        }
                    }
                }
            }
            else {
                return Math.round(Num);
            }
        }

    </script>
    <script language="javascript" type="text/javascript">

        var months = new Array("", "January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December");

        var dtCh = "/";
        var minYear = 1900;
        var maxYear = 2100;

        function isInteger(s) {
            for (var i = 0; i < s.length; i++) {
                // Check that current character is number.
                var c = s.charAt(i);
                if (((c < "0") || (c > "9"))) return false;
            }
            // All characters are numbers.
            return true;
        }

        function stripCharsInBag(s, bag) {
            var returnString = "";
            // Search through string's characters one by one.
            // If character is not in bag, append to returnString.
            for (var i = 0; i < s.length; i++) {
                var c = s.charAt(i);
                if (bag.indexOf(c) == -1) returnString += c;
            }

            return returnString;
        }

        function daysInFebruary(year) {
            // February has 29 days in any year evenly divisible by four,
            // EXCEPT for centurial years which are not also divisible by 400.
            return (((year % 4 == 0) && ((!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28);
        }

        function DaysArray(n) {
            for (var i = 1; i <= n; i++) {
                this[i] = 31
                if (i == 4 || i == 6 || i == 9 || i == 11) { this[i] = 30 }
                if (i == 2) { this[i] = 29 }
            }

            return this
        }

        function isDate1(dtStr) {
            var daysInMonth = DaysArray(12)
            var pos1 = dtStr.indexOf(dtCh)
            var pos2 = dtStr.indexOf(dtCh, pos1 + 1)
            var strDay = dtStr.substring(0, pos1)
            var strMonth = dtStr.substring(pos1 + 1, pos2)
            var strYear = dtStr.substring(pos2 + 1)

            strYr = strYear

            if (strDay.charAt(0) == "0" && strDay.length > 1) strDay = strDay.substring(1)
            if (strMonth.charAt(0) == "0" && strMonth.length > 1) strMonth = strMonth.substring(1)

            for (var i = 1; i <= 3; i++) {
                if (strYr.charAt(0) == "0" && strYr.length > 1) strYr = strYr.substring(1)
            }

            month = parseInt(strMonth)
            day = parseInt(strDay)
            year = parseInt(strYr)

            if (pos1 == -1 || pos2 == -1) {
                alert("The date format should be : dd/mm/yyyy")
                return false
            }

            if (strDay.length < 1 || day < 1 || day > 31 || (month == 2 && day > daysInFebruary(year)) || day > daysInMonth[month]) {
                alert("Please enter a valid day")
                return false
            }

            if (strMonth.length < 1 || month < 1 || month > 12) {
                alert("Please enter a valid month")
                return false
            }

            if (strYear.length != 4 || year == 0 || year < minYear || year > maxYear) {
                alert("Please enter a valid 4 digit year between " + minYear + " and " + maxYear)
                return false
            }

            if (dtStr.indexOf(dtCh, pos2 + 1) != -1 || isInteger(stripCharsInBag(dtStr, dtCh)) == false) {
                alert("Please enter a valid date")
                return false
            }

            return true
        }

        //        function ValidateDate(obj)
        //        {  
        //            if (obj.value!="")
        //            {
        //	            var dockdt=obj.value
        //        	
        //		        if(dockdt.length<10)
        //		        {
        //		            alert("Please enter the date in dd/mm/yyyy format")
        //		            obj.focus();
        //		            return false;
        //		        }
        //        	
        //	            if (isDate1(obj.value)==false)
        //	            {
        //		            obj.focus()
        //		            return false
        //	            }
        //        	    
        //                return true
        //            }  
        //        }

        function MyDateDiff(start, end, interval, rounding) {
            var iOut = 0;
            var bufferA = Date.parse(start);
            var bufferB = Date.parse(end);

            // check that the start parameter is a valid Date. 
            if (isNaN(bufferA) || isNaN(bufferB)) {
                alert(startMsg);
                return null;
            }

            // check that an interval parameter was not numeric. 
            if (interval.charAt == 'undefined') {
                // the user specified an incorrect interval, handle the error. 
                alert(intervalMsg);
                return null;
            }

            var number = bufferB - bufferA;

            // what kind of add to do? 
            switch (interval.charAt(0)) {
                case 'd': case 'D':
                    iOut = parseInt(number / 86400000);
                    if (rounding) iOut += parseInt((number % 86400000) / 43200001);
                    break;
                case 'h': case 'H':
                    iOut = parseInt(number / 3600000);
                    if (rounding) iOut += parseInt((number % 3600000) / 1800001);
                    break;
                case 'm': case 'M':
                    iOut = parseInt(number / 60000);
                    if (rounding) iOut += parseInt((number % 60000) / 30001);
                    break;
                case 's': case 'S':
                    iOut = parseInt(number / 1000);
                    if (rounding) iOut += parseInt((number % 1000) / 501);
                    break;
                default:
                    // If we get to here then the interval parameter
                    // didn't meet the d,h,m,s criteria.  Handle
                    // the error. 		
                    alert(intervalMsg);
                    return null;
            }

            return iOut;
        }

        function trimAll(strValue) {
            //Trimming left most white space characters
            while (strValue.substring(0, 1) == ' ') {
                strValue = strValue.substring(1, strValue.length);
            }
            //Trimming right most white space characters
            while (strValue.substring(strValue.length - 1, strValue.length) == ' ') {
                strValue = strValue.substring(0, strValue.length - 1);
            }

            return strValue;
        }

        function IsNumeric(sText) {
            var ValidChars = "0123456789.";
            var IsNumber = true;
            var Char;

            for (i = 0; i < sText.length && IsNumber == true; i++) {
                Char = sText.charAt(i);

                if (ValidChars.indexOf(Char) == -1) {
                    IsNumber = false;
                }
            }

            return IsNumber;
        }

        function IsNumericWoDot(sText) {
            var ValidChars = "0123456789";
            var IsNumber = true;
            var Char;

            for (i = 0; i < sText.length && IsNumber == true; i++) {
                Char = sText.charAt(i);

                if (ValidChars.indexOf(Char) == -1) {
                    IsNumber = false;
                }
            }

            return IsNumber;
        }

        function Nagative_Chk_wDecimal(obj) {
            var temp = trimAll(obj.value)

            if (temp == "") {
                /*alert("Value can not be blank")
                obj.focus();
                return false;*/
                return true;
            }

            if (isNaN(temp)) {
                alert("Value should be Numeric")
                obj.focus();
                return false;
            }

            if (parseFloat(temp) < 0) {
                alert("Value should be greater than zero")
                obj.focus();
                return false;
            }

            obj.value = roundit(temp)

            return true;
        }

        function Nagative_Chk_woDecimal(obj) {
            var temp = obj.value

            if (temp == "") {
                alert("Value can not be blank")
                obj.focus();
                return false;
            }

            if (isNaN(temp)) {
                alert("Value should be Numeric")
                obj.focus();
                return false;
            }

            if (parseFloat(temp) < 0) {
                alert("Value should be greater than zero")
                obj.focus();
                return false;
            }

            if (temp.indexOf(".") > 0) {
                alert("Value should not contain decimal point")
                obj.focus();
                return false;
            }

            obj.value = Math.round(temp)

            return true;
        }

        function rounditn(Num, decplaces) {
            Places = decplaces

            if (Places > 0) {
                if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places + 1)) {
                    if (Num.toString().lastIndexOf('.') < 0) {
                        return Num.toString() + '.00';
                    }

                    var Rounder = Math.pow(10, Places);

                    return Math.round(Num * Rounder) / Rounder;
                }
                else {
                    if (Num.toString().lastIndexOf('.') < 0) {
                        return Num.toString() + '.00';
                    }
                    else {
                        if (Num.toString().lastIndexOf('.') + 1 == Num.toString().length - 1)
                            return Num.toString() + '0';
                        else
                            return Num.toString();
                    }
                }
            }
            else {
                return Math.round(Num);
            }
        }

        function roundit(Num) {
            Places = 2

            if (Places > 0) {
                if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places + 1)) {
                    if (Num.toString().lastIndexOf('.') < 0) {
                        return Num.toString() + '.00';
                    }

                    var Rounder = Math.pow(10, Places);

                    return Math.round(Num * Rounder) / Rounder;
                }
                else {
                    if (Num.toString().lastIndexOf('.') < 0) {
                        return Num.toString() + '.00';
                    }
                    else {
                        if (Num.toString().lastIndexOf('.') + 1 == Num.toString().length - 1) {
                            return Num.toString() + '0';
                        }
                        else {
                            return Num.toString();
                        }
                    }
                }
            }
            else {
                return Math.round(Num);
            }
        }

    </script>
    <script language="javascript" type="text/javascript">
        function IsText(sText) {
            var ValidChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            var IsText = true;
            var Char;

            for (i = 0; i < sText.length && IsText == true; i++) {
                Char = sText.charAt(i);

                if (ValidChars.indexOf(Char) == -1) {
                    IsText = false;
                }
            }

            return IsText;
        }

        var dtCh = "/";
        var minYear = 1900;
        var maxYear = 2100;

        function Chk(ddVehicleType, txtVehicleNo, ddVndrNm, lstPermitStates, lstRut, txtVhclInsuranceDt, txtFitnessDt,
            txtManufacturerDt, txtNationalPermitDt, txt5YearPermitDt, txtRoadTaxDt, txtFuelEfficiencyDt, txtCNoPolicyNoDt, btnSubmit) {
            //alert("In Chk Function");
            //debugger
            if (s == "1") {

                if (document.getElementById("ctl00_MyCPH1_ddVehicleType").value == "") {
                    alert("Select Atleast One Vehicle Type");
                    document.getElementById("ctl00_MyCPH1_ddVehicleType").focus();
                    return false;
                }
                if (document.getElementById("ctl00_MyCPH1_txtVehicleNo").value == "") {
                    alert("Please Enter Vehicle No.");
                    document.getElementById("ctl00_MyCPH1_txtVehicleNo").focus();
                    return false;
                }
                if (document.getElementById("ctl00_MyCPH1_txtVehicleNo").value != "") {
                    if (!isNaN(document.getElementById("ctl00_MyCPH1_txtVehicleNo").value)) {
                        alert("Only Numbers are Not Allowed.");
                        document.getElementById("ctl00_MyCPH1_txtVehicleNo").focus();
                        return false;
                    }
                }
                var a = false
                a = IsText(document.getElementById("ctl00_MyCPH1_txtVehicleNo").value.toUpperCase())
                if (a == false) {
                    alert("Only Numbers and Alphabates Are Allowed !!")
                    p = "2"
                    document.getElementById("ctl00_MyCPH1_txtVehicleNo").focus()
                    return false
                }
                if (document.getElementById("ctl00_MyCPH1_ddVndrNm").value == "") {
                    alert("Please Entre Vendor ");
                    document.getElementById("ctl00_MyCPH1_ddVndrNm").focus();
                    return false;
                }
                //		    if(document.getElementById("ctl00_MyCPH1_ddTonnage").value=="")
                //	        {
                //		        alert("Please Select 'Vendor Tons '");
                //		        document.getElementById("ctl00_MyCPH1_ddTonnage").focus();
                //		        return false;
                //	        }
                //if (document.getElementById("ctl00_MyCPH1_lstPermitStates").value == "") {
                //    alert("Please Select 'Permit States '");
                //    document.getElementById("ctl00_MyCPH1_lstPermitStates").focus();
                //    return false;
                //}

                //	        if(document.getElementById("ctl00_MyCPH1_lstRut").value=="")
                //	        {
                //		        alert("Please Select 'Routes '");
                //		        document.getElementById("ctl00_MyCPH1_lstRut").focus();
                //		        return false;
                //	        }
                //	        if(document.getElementById("ctl00_MyCPH1_txtLicenseNo").value=="")
                //	        {
                //		        alert("Please Select 'License No.'");
                //		        document.getElementById("ctl00_MyCPH1_txtLicenseNo").focus();
                //		        return false;
                //	        }

                //	        if(document.getElementById("ctl00_MyCPH1_txtLicenseNo").value!="")
                //	        {
                //		        if(!isNaN(txtLicenseNo.value))
                //		        {
                //		        alert("Only Numbers are Not Allowed.");
                //		        document.getElementById("ctl00_MyCPH1_txtLicenseNo").focus();
                //		        return false;
                //		        }
                //	        }

                if (document.getElementById("ctl00_MyCPH1_txtVhclInsuranceDt").value == "") {
                    alert("Please Enter the Vehicle Insurance Date.");
                    document.getElementById("ctl00_MyCPH1_txtVhclInsuranceDt").focus();
                    return false;
                }

                /*if(txtVhclInsuranceDt.value=="dd/mm/yyyy")
                {
                alert("Please Enter the Vehicle Insurance Date.")
                txtVhclInsuranceDt.focus();
                return false;
                }
                */

                if (document.getElementById("ctl00_MyCPH1_txtVhclInsuranceDt").value != "dd/mm/yyyy") {
                    if (ValidateDate(document.getElementById("ctl00_MyCPH1_txtVhclInsuranceDt")) == false) {
                        return false;
                    }
                    else {
                        var mToday = "<%=strToday %>";
                        mToday = mToday.substring(3, 5) + "/" + mToday.substring(0, 2) + "/" + mToday.substring(6, 10);
                        var mVehInsDate = document.getElementById("ctl00_MyCPH1_txtVhclInsuranceDt").value;
                        mVehInsDate = mVehInsDate.substring(3, 5) + "/" + mVehInsDate.substring(0, 2) + "/" + mVehInsDate.substring(6, 10);

                        //Check for Date From and Date To Date range
                        if (findDateDifference(mToday, mVehInsDate, "d") < 0) {
                            //alert("Enter 'Vehicle Insurance Date' greater than Today!");
                            //document.getElementById("ctl00_MyCPH1_txtVhclInsuranceDt").focus();
                            //return false;
                        }
                    }
                }



                //            if (parseFloat(tm)>0)
                //            {
                //             alert("Insurance Date cannot be Less than System date !!!")
                //             txtVhclInsuranceDt.focus();
                //             return false;
                //            }

                if (document.getElementById("ctl00_MyCPH1_txtFitnessDt").value == "") {
                    alert("Please Enter the Fitness Certificate Date.")
                    document.getElementById("ctl00_MyCPH1_txtFitnessDt").focus();
                    return false;
                }

                if (document.getElementById("ctl00_MyCPH1_txtFitnessDt").value != "dd/mm/yyyy") {
                    if (ValidateDate(document.getElementById("ctl00_MyCPH1_txtFitnessDt")) == false) {
                        return false;
                    }
                    else {
                        var mToday = "<%=strToday %>";
                        mToday = mToday.substring(3, 5) + "/" + mToday.substring(0, 2) + "/" + mToday.substring(6, 10);
                        var mVehFitDate = document.getElementById("ctl00_MyCPH1_txtFitnessDt").value;
                        mVehFitDate = mVehFitDate.substring(3, 5) + "/" + mVehFitDate.substring(0, 2) + "/" + mVehFitDate.substring(6, 10);

                        //Check for Date From and Date To Date range
                        if (findDateDifference(mToday, mVehFitDate, "d") < 0) {
                            //alert("Enter 'Vehicle Fitness Date' greater than Today!");
                            //document.getElementById("ctl00_MyCPH1_txtFitnessDt").focus();
                            //return false;
                        }
                    }
                }
                if (isNaN(document.getElementById("ctl00_MyCPH1_txtDrivers").value)) {
                    alert("Enter Driver No. in numeric");
                    document.getElementById("ctl00_MyCPH1_txtDrivers").focus();
                    return false;
                }
                if (document.getElementById("ctl00_MyCPH1_txtDrivers").value < 0) {
                    alert("Enter Driver No. in positive numeric");
                    document.getElementById("ctl00_MyCPH1_txtDrivers").focus();
                    return false;
                }
                if (isNaN(document.getElementById("ctl00_MyCPH1_txtLength").value)) {
                    alert("Enter Length in numeric");
                    document.getElementById("ctl00_MyCPH1_txtLength").focus();
                    return false;
                }
                if (document.getElementById("ctl00_MyCPH1_txtLength").value < 0) {
                    alert("Enter Length in positive numeric");
                    document.getElementById("ctl00_MyCPH1_txtLength").focus();
                    return false;
                }
                if (isNaN(document.getElementById("ctl00_MyCPH1_txtWidth").value)) {
                    alert("Enter Width in numeric");
                    document.getElementById("ctl00_MyCPH1_txtWidth").focus();
                    return false;
                }
                if (document.getElementById("ctl00_MyCPH1_txtWidth").value < 0) {
                    alert("Enter Width in positive numeric");
                    document.getElementById("ctl00_MyCPH1_txtWidth").focus();
                    return false;
                }
                if (isNaN(document.getElementById("ctl00_MyCPH1_txtHeight").value)) {
                    alert("Enter Height in numeric");
                    document.getElementById("ctl00_MyCPH1_txtHeight").focus();
                    return false;
                }
                if (document.getElementById("ctl00_MyCPH1_txtHeight").value < 0) {
                    alert("Enter Height in positive numeric");
                    document.getElementById("ctl00_MyCPH1_txtHeight").focus();
                    return false;
                }
                //if (isNaN(document.getElementById("ctl00_MyCPH1_txtRate").value)) {
                //    alert("Enter Rate in numeric");
                //    document.getElementById("ctl00_MyCPH1_txtRate").focus();
                //    return false;
                //}
                //if (document.getElementById("ctl00_MyCPH1_txtRate").value < 0) {
                //    alert("Enter Rate in positive numeric");
                //    document.getElementById("ctl00_MyCPH1_txtRate").focus();
                //    return false;
                //}
                if (isNaN(document.getElementById("ctl00_MyCPH1_txtGVW").value)) {
                    alert("Enter GVW in numeric");
                    document.getElementById("ctl00_MyCPH1_txtGVW").focus();
                    return false;
                }
                if (document.getElementById("ctl00_MyCPH1_txtGVW").value < 0) {
                    alert("Enter GVW in positive numeric");
                    document.getElementById("ctl00_MyCPH1_txtGVW").focus();
                    return false;
                }
                if (isNaN(document.getElementById("ctl00_MyCPH1_txtUnladen").value)) {
                    alert("Enter Unladen in numeric");
                    document.getElementById("ctl00_MyCPH1_txtUnladen").focus();
                    return false;
                }
                if (document.getElementById("ctl00_MyCPH1_txtUnladen").value < 0) {
                    alert("Enter Unladen in positive numeric");
                    document.getElementById("ctl00_MyCPH1_txtUnladen").focus();
                    return false;
                }
                //            if((document.getElementById("ctl00_MyCPH1_txtUnladen").value) > (document.getElementById("ctl00_MyCPH1_txtGVW").value))
                //            {
                //                alert("Enter Unladen value less than GVW");
                //                document.getElementById("ctl00_MyCPH1_txtUnladen").focus();
                //                return false;
                //            }

                document.getElementById("ctl00_MyCPH1_txtPayload").value = document.getElementById("ctl00_MyCPH1_txtGVW").value - document.getElementById("ctl00_MyCPH1_txtUnladen").value;
                document.getElementById("ctl00_MyCPH1_txtCapacity").value = document.getElementById("ctl00_MyCPH1_txtGVW").value - document.getElementById("ctl00_MyCPH1_txtUnladen").value;

                document.getElementById("ctl00_MyCPH1_hdnPayload").value = document.getElementById("ctl00_MyCPH1_txtGVW").value - document.getElementById("ctl00_MyCPH1_txtUnladen").value;
                document.getElementById("ctl00_MyCPH1_hdnCapacity").value = document.getElementById("ctl00_MyCPH1_txtGVW").value - document.getElementById("ctl00_MyCPH1_txtUnladen").value;

                document.getElementById("ctl00_MyCPH1_txtRgnNo").value = document.getElementById("ctl00_MyCPH1_txtVehicleNo").value;

                if (isNaN(document.getElementById("ctl00_MyCPH1_txtPayload").value)) {
                    alert("Payload Should Be numeric");
                    //document.getElementById("ctl00_MyCPH1_txtPayload").focus();
                    return false;
                }
                if (document.getElementById("ctl00_MyCPH1_txtPayload").value < 0) {
                    alert("Payload Should Be positve numeric");
                    //document.getElementById("ctl00_MyCPH1_txtPayload").focus();
                    return false;
                }

                //if (isNaN(document.getElementById("ctl00_MyCPH1_txtCapacity").value)) {
                //    alert("Enter Capacity in numeric");
                //    document.getElementById("ctl00_MyCPH1_txtCapacity").focus();
                //    return false;
                //}
                if (document.getElementById("ctl00_MyCPH1_txtCapacity").value < 0) {
                    alert("Capacity should be in positive numeric");
                    // document.getElementById("ctl00_MyCPH1_txtCapacity").focus();
                    return false;
                }

                if (document.getElementById("ctl00_MyCPH1_txtRgnDt").value != "dd/mm/yyyy" && document.getElementById("ctl00_MyCPH1_txtRgnDt").value != "") {
                    if (ValidateDate(document.getElementById("ctl00_MyCPH1_txtRgnDt")) == false) {
                        return false;
                    }
                    else {
                        var mToday = "<%=strToday %>";
                        mToday = mToday.substring(3, 5) + "/" + mToday.substring(0, 2) + "/" + mToday.substring(6, 10);
                        var DateAttach = document.getElementById("ctl00_MyCPH1_txtRgnDt").value;
                        DateAttach = DateAttach.substring(3, 5) + "/" + DateAttach.substring(0, 2) + "/" + DateAttach.substring(6, 10);

                        //Check for Date From and Date To Date range
                        if (findDateDifference(mToday, DateAttach, "d") > 0) {
                            //alert("Enter 'Registeration Date' Less Than Today!");
                            //document.getElementById("ctl00_MyCPH1_txtRgnDt").focus();
                            //return false;
                        }
                    }
                }

                if (document.getElementById("ctl00_MyCPH1_txtAttachingDt").value != "dd/mm/yyyy" && document.getElementById("ctl00_MyCPH1_txtAttachingDt").value != "") {
                    if (ValidateDate(document.getElementById("ctl00_MyCPH1_txtAttachingDt")) == false) {
                        return false;
                    }
                    else {
                        var mToday = "<%=strToday %>";
                        mToday = mToday.substring(3, 5) + "/" + mToday.substring(0, 2) + "/" + mToday.substring(6, 10);
                        var DateAttach = document.getElementById("ctl00_MyCPH1_txtAttachingDt").value;
                        DateAttach = DateAttach.substring(3, 5) + "/" + DateAttach.substring(0, 2) + "/" + DateAttach.substring(6, 10);

                        //Check for Date From and Date To Date range
                        if (findDateDifference(mToday, DateAttach, "d") < 0) {
                            //alert("Enter 'Date Of Attaching' greater than Today!");
                            //document.getElementById("ctl00_MyCPH1_txtAttachingDt").focus();
                            //return false;
                        }
                    }
                }

                //********************************* Valid 1 START *************************************//
                //debugger
                if (document.getElementById("ctl00_MyCPH1_txtManufacturerDt").value == "") {
                    alert("Please Enter the Manufacturer Date.")
                    document.getElementById("ctl00_MyCPH1_txtManufacturerDt").focus();
                    return false;
                }

                if (document.getElementById("ctl00_MyCPH1_txtManufacturerDt").value != "dd/mm/yyyy") {
                    if (ValidateDate(document.getElementById("ctl00_MyCPH1_txtManufacturerDt")) == false) {
                        return false;
                    }
                    else {
                        var mToday = "<%=strToday %>";
                        mToday = mToday.substring(3, 5) + "/" + mToday.substring(0, 2) + "/" + mToday.substring(6, 10);
                        var mVehFitDate = document.getElementById("ctl00_MyCPH1_txtManufacturerDt").value;
                        mVehFitDate = mVehFitDate.substring(3, 5) + "/" + mVehFitDate.substring(0, 2) + "/" + mVehFitDate.substring(6, 10);

                        //Check for Date From and Date To Date range
                        if (findDateDifference(mToday, mVehFitDate, "d") > 0) {
                            alert("Enter 'Manufacturer Date' should not greater than Today!");
                            document.getElementById("ctl00_MyCPH1_txtManufacturerDt").focus();
                            return false;
                        }
                    }
                }

                //debugger
                if (document.getElementById("ctl00_MyCPH1_txtNationalPermitDt").value == "") {
                    alert("Please Enter the National Permit Date.")
                    document.getElementById("ctl00_MyCPH1_txtNationalPermitDt").focus();
                    return false;
                }

                if (document.getElementById("ctl00_MyCPH1_txtNationalPermitDt").value != "dd/mm/yyyy") {
                    if (ValidateDate(document.getElementById("ctl00_MyCPH1_txtNationalPermitDt")) == false) {
                        return false;
                    }
                    else {
                        var mToday = "<%=strToday %>";
                        mToday = mToday.substring(3, 5) + "/" + mToday.substring(0, 2) + "/" + mToday.substring(6, 10);
                        var mVehFitDate = document.getElementById("ctl00_MyCPH1_txtNationalPermitDt").value;
                        mVehFitDate = mVehFitDate.substring(3, 5) + "/" + mVehFitDate.substring(0, 2) + "/" + mVehFitDate.substring(6, 10);

                        //Check for Date From and Date To Date range
                        if (findDateDifference(mToday, mVehFitDate, "d") < 0) {
                            //alert("Enter 'National Permit Date' greater than Today!");
                            //document.getElementById("ctl00_MyCPH1_txtNationalPermitDt").focus();
                            //return false;
                        }
                    }
                }


                //debugger
                if (document.getElementById("ctl00_MyCPH1_txt5YearPermitDt").value == "") {
                    alert("Please Enter the 5 Year Permit Date.")
                    document.getElementById("ctl00_MyCPH1_txt5YearPermitDt").focus();
                    return false;
                }

                if (document.getElementById("ctl00_MyCPH1_txt5YearPermitDt").value != "dd/mm/yyyy") {
                    if (ValidateDate(document.getElementById("ctl00_MyCPH1_txt5YearPermitDt")) == false) {
                        return false;
                    }
                    else {
                        var mToday = "<%=strToday %>";
                        mToday = mToday.substring(3, 5) + "/" + mToday.substring(0, 2) + "/" + mToday.substring(6, 10);
                        var mVehFitDate = document.getElementById("ctl00_MyCPH1_txt5YearPermitDt").value;
                        mVehFitDate = mVehFitDate.substring(3, 5) + "/" + mVehFitDate.substring(0, 2) + "/" + mVehFitDate.substring(6, 10);

                        //Check for Date From and Date To Date range
                        if (findDateDifference(mToday, mVehFitDate, "d") < 0) {
                            //alert("Enter '5 Year Permit Date' greater than Today!");
                            //document.getElementById("ctl00_MyCPH1_txt5YearPermitDt").focus();
                            //return false;
                        }
                    }
                }
                //******************************** Valid 1 END ***********************************//


                //********************************* Valid 2 START *************************************//
                //debugger
                if (document.getElementById("ctl00_MyCPH1_txtRoadTaxDt").value == "") {
                    alert("Please Enter the Road Tax Date.")
                    document.getElementById("ctl00_MyCPH1_txtRoadTaxDt").focus();
                    return false;
                }

                if (document.getElementById("ctl00_MyCPH1_txtRoadTaxDt").value != "dd/mm/yyyy") {
                    if (ValidateDate(document.getElementById("ctl00_MyCPH1_txtRoadTaxDt")) == false) {
                        return false;
                    }
                    else {
                        var mToday = "<%=strToday %>";
                        mToday = mToday.substring(3, 5) + "/" + mToday.substring(0, 2) + "/" + mToday.substring(6, 10);
                        var mVehFitDate = document.getElementById("ctl00_MyCPH1_txtRoadTaxDt").value;
                        mVehFitDate = mVehFitDate.substring(3, 5) + "/" + mVehFitDate.substring(0, 2) + "/" + mVehFitDate.substring(6, 10);

                        //Check for Date From and Date To Date range
                        if (findDateDifference(mToday, mVehFitDate, "d") < 0) {
                            //alert("Enter 'Road Tax Date' greater than Today!");
                            //document.getElementById("ctl00_MyCPH1_txtRoadTaxDt").focus();
                            //return false;
                        }
                    }
                }
                if (document.getElementById("ctl00_MyCPH1_txtFuelEfficiencyLtr").value == "" || document.getElementById("ctl00_MyCPH1_txtFuelEfficiencyLtr").value == "0") {
                    alert("Please Enter the Fuel Efficiency(Ltr).")
                    document.getElementById("ctl00_MyCPH1_txtFuelEfficiencyLtr").focus();
                    return false;
                }
                //debugger
               <%-- if (document.getElementById("ctl00_MyCPH1_txtFuelEfficiencyDt").value == "") {
                    alert("Please Enter the Fuel Efficiency Date.")
                    document.getElementById("ctl00_MyCPH1_txtFuelEfficiencyDt").focus();
                    return false;
                }

                if (document.getElementById("ctl00_MyCPH1_txtFuelEfficiencyDt").value != "dd/mm/yyyy") {
                    if (ValidateDate(document.getElementById("ctl00_MyCPH1_txtFuelEfficiencyDt")) == false) {
                        return false;
                    }
                    else {
                        var mToday = "<%=strToday %>";
                        mToday = mToday.substring(3, 5) + "/" + mToday.substring(0, 2) + "/" + mToday.substring(6, 10);
                        var mVehFitDate = document.getElementById("ctl00_MyCPH1_txtFuelEfficiencyDt").value;
                        mVehFitDate = mVehFitDate.substring(3, 5) + "/" + mVehFitDate.substring(0, 2) + "/" + mVehFitDate.substring(6, 10);

                        //Check for Date From and Date To Date range
                        if (findDateDifference(mToday, mVehFitDate, "d") < 0) {
                            alert("Enter 'Fuel Efficiency Date' greater than Today!");
                            document.getElementById("ctl00_MyCPH1_txtFuelEfficiencyDt").focus();
                            return false;
                        }
                    }
                }--%>


                //debugger
                //if (document.getElementById("ctl00_MyCPH1_txtBodyTypeDt").value == "") {
                //    alert("Please Enter the Body Type Date.")
                //    document.getElementById("ctl00_MyCPH1_txtBodyTypeDt").focus();
                //    return false;
                //}

               <%-- if (document.getElementById("ctl00_MyCPH1_txtBodyTypeDt").value != "dd/mm/yyyy") {
                    if (ValidateDate(document.getElementById("ctl00_MyCPH1_txtBodyTypeDt")) == false) {
                        return false;
                    }
                    else {
                        var mToday = "<%=strToday %>";
                        mToday = mToday.substring(3, 5) + "/" + mToday.substring(0, 2) + "/" + mToday.substring(6, 10);
                        var mVehFitDate = document.getElementById("ctl00_MyCPH1_txtBodyTypeDt").value;
                        mVehFitDate = mVehFitDate.substring(3, 5) + "/" + mVehFitDate.substring(0, 2) + "/" + mVehFitDate.substring(6, 10);

                        //Check for Date From and Date To Date range
                        if (findDateDifference(mToday, mVehFitDate, "d") < 0) {
                            alert("Enter 'Body Type Date' greater than Today!");
                            document.getElementById("ctl00_MyCPH1_txtBodyTypeDt").focus();
                            return false;
                        }
                    }
                }--%>

                if (document.getElementById("ctl00_MyCPH1_txtCNoPolicyNo").value == "") {
                    alert("Please Enter the C.No/Policy No.")
                    document.getElementById("ctl00_MyCPH1_txtCNoPolicyNo").focus();
                    return false;
                }
                //debugger
               <%-- if (document.getElementById("ctl00_MyCPH1_txtCNoPolicyNoDt").value == "") {
                    alert("Please Enter the C.No/Policy No. Date.")
                    document.getElementById("ctl00_MyCPH1_txtCNoPolicyNoDt").focus();
                    return false;
                }

                if (document.getElementById("ctl00_MyCPH1_txtCNoPolicyNoDt").value != "dd/mm/yyyy") {
                    if (ValidateDate(document.getElementById("ctl00_MyCPH1_txtCNoPolicyNoDt")) == false) {
                        return false;
                    }
                    else {
                        var mToday = "<%=strToday %>";
                        mToday = mToday.substring(3, 5) + "/" + mToday.substring(0, 2) + "/" + mToday.substring(6, 10);
                        var mVehFitDate = document.getElementById("ctl00_MyCPH1_txtCNoPolicyNoDt").value;
                        mVehFitDate = mVehFitDate.substring(3, 5) + "/" + mVehFitDate.substring(0, 2) + "/" + mVehFitDate.substring(6, 10);

                        //Check for Date From and Date To Date range
                        if (findDateDifference(mToday, mVehFitDate, "d") < 0) {
                            alert("Enter 'C.No/Policy No. Date' greater than Today!");
                            document.getElementById("ctl00_MyCPH1_txtCNoPolicyNoDt").focus();
                            return false;
                        }
                    }
                }--%>




                //******************************** Valid 2 END ***********************************//







                alert("Submitted")
                document.getElementById("ctl00_MyCPH1_txtPayload").disabled = false;
                document.getElementById("ctl00_MyCPH1_txtCapacity").disabled = false;
                return true
            }
            else {
                return false
            }
        }
        function nwOpen(mNo) {
            window.open("popupbranch.aspx?" + mNo, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
    </script>
    <script language="vbscript" type="text/vbscript">
        
        function findDateDifference(dtFrom, dtTo, interval)
            
            findDateDifference = DateDiff(interval, dtFrom, dtTo)
            
        end function
        
    </script>
    <div align="left" style="width: 10in">
        <table border="0" cellpadding="0" cellspacing="0" style="width: 940px">
            <tr>
                <td style="width: 821px">&nbsp;
                </td>
            </tr>
            <tr>
                <td style="width: 821px">
                    <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 940px">
                        <tr>
                            <td height="30" style="width: 895px">
                                <a><font class="blklnkund"><strong>Module</strong></font></a> &gt; <a><font class="blklnkund">
                                    <strong>Administrator </strong></font></a>&gt; <a href="../operations.aspx"><font
                                        class="blklnkund"><strong>Operations</strong></font></a> <font class="bluefnt"><strong>&gt; Vehicle Master</strong> </font>
                            </td>
                        </tr>
                        <tr>
                            <td class="horzblue" style="width: 895px">
                                <img src="../../images/clear.gif" width="2" height="1" alt="" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 895px">
                                <img src="../../images/clear.gif" width="15" height="10" alt="" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 895px">
                                <a href="javascript:window.history.go(-1)" title="back">
                                    <img src="../../images/back.gif" border="0" alt="" /></a>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 895px">
                                <br />
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td valign="top" style="width: 57%">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td height="300" valign="top" style="width: 806px">
                                                        <!--START-->
                                                        <table align="center" border="0" cellpadding="5" cellspacing="1" width="95%" class="boxbg">
                                                            <tr class="bgbluegrey">
                                                                <td colspan="3" align="center">
                                                                    <font class="blackfnt"><b>VEHICLE MASTER SCREEN</b></font>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <br />
                                                        <table align="center" border="0" cellpadding="2" cellspacing="1" width="95%" class="boxbg">
                                                            <tr class="bgbluegrey">
                                                                <td align="center">
                                                                    <font class="bluefnt"><b>Vehicle Information</b></font>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="3" bgcolor="#FFFFFF">
                                                                    <table border="0" cellspacing="0" width="100%" cellpadding="2">
                                                                        <tr>
                                                                            <td>
                                                                                <font class="blackfnt">Vehicle Type &nbsp;&nbsp;:</font>
                                                                            </td>
                                                                            <td>
                                                                                <asp:DropDownList ID="ddVehicleType" runat="server" Width="179px">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">Controlling Branch</font>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtCntrlBranch" MaxLength="50" runat="server" Width="64px" onblur="return checklocation(this)"></asp:TextBox>
                                                                                <%--OnChange="Javascript:this.value=this.value.toUpperCase();"--%>
                                                                                <asp:Label ID="Label1" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                                                    Width="14px"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">Vehicle No. &nbsp; &nbsp;:</font>
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtVehicleNo" onblur="return vehiclecheck('ctl00_MyCPH1_txtVehicleNo')" onchange="return setVehicleNo(this)"
                                                                                    runat="server" Width="94px"></asp:TextBox>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <span style="font-size: 8pt; font-family: Verdana">Vendor Type</span>
                                                                            </td>
                                                                            <td>
                                                                                <asp:UpdatePanel ID="up1" runat="server">
                                                                                    <ContentTemplate>
                                                                                        <asp:DropDownList ID="cmbvendortype" AutoPostBack="true" OnSelectedIndexChanged="popvendorname"
                                                                                            runat="server" Width="179px">
                                                                                        </asp:DropDownList>
                                                                                    </ContentTemplate>
                                                                                </asp:UpdatePanel>
                                                                            </td>
                                                                            <td>
                                                                                <span style="font-size: 8pt; font-family: Verdana">Vendor Name :</span>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">
                                                                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                                        <ContentTemplate>
                                                                                            <asp:DropDownList ID="ddVndrNm" runat="server" Width="128px">
                                                                                            </asp:DropDownList>
                                                                                        </ContentTemplate>
                                                                                        <Triggers>
                                                                                            <asp:AsyncPostBackTrigger ControlID="cmbvendortype" EventName="SelectedIndexChanged" />
                                                                                        </Triggers>
                                                                                    </asp:UpdatePanel>
                                                                                </font>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">&nbsp;<span style="font-size: 8pt">Permit Type&nbsp;:</span></font>
                                                                            </td>
                                                                            <td>

                                                                                <font class="blackfnt">
                                                                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                                                        <ContentTemplate>
                                                                                            <asp:DropDownList ID="ddlPermitType" runat="server" Width="128px">
                                                                                            </asp:DropDownList>
                                                                                        </ContentTemplate>

                                                                                    </asp:UpdatePanel>
                                                                                </font>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <span style="font-size: 8pt; font-family: Verdana">Routes &nbsp; &nbsp; &nbsp; &nbsp;
                                                                                    &nbsp; : </span>
                                                                            </td>
                                                                            <td valign="top" style="width: 169px">
                                                                                <asp:ListBox ID="lstRut" runat="server" Height="60px" Width="180px" SelectionMode="Multiple"></asp:ListBox>
                                                                            </td>
                                                                            <td>
                                                                                <span style="font-size: 8pt; font-family: Verdana">No. Of Drivers</span>
                                                                            </td>
                                                                            <td>&nbsp;<asp:TextBox ID="txtDrivers" MaxLength="2" onblur="return checknumber(this)"
                                                                                runat="server" Width="30px"></asp:TextBox>
                                                                            </td>
                                                                            <td>No of Tyres Attached with Vehicle
                                                                            </td>
                                                                            <td>
                                                                                <asp:TextBox ID="txtNoTyres" runat="server" onblur="return NoofTyrescheck('ctl00_MyCPH1_txtNoTyres')"
                                                                                    MaxLength="2"></asp:TextBox>
                                                                            </td>
                                                                        </tr>

                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <table align="center" border="0" cellpadding="2" cellspacing="1" width="95%" class="boxbg">
                                                            <tr class="bgbluegrey">
                                                                <td align="center" height="18">
                                                                    <font class="bluefnt"><b />Other Information</font>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="3" bgcolor="#FFFFFF">
                                                                    <table border="0" cellspacing="0" width="100%" cellpadding="3">
                                                                        <tr>
                                                                            <td style="height: 28px">
                                                                                <font class="blackfnt">RC Book No.</font>
                                                                            </td>
                                                                            <td style="width: 129px; height: 28px;">
                                                                                <font class="blackfnt">
                                                                                    <asp:TextBox ID="txtRcBookNo" runat="server" Width="107px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox></font>
                                                                            </td>
                                                                            <td style="height: 28px">
                                                                                <font class="blackfnt">Registration No.</font>
                                                                            </td>
                                                                            <td style="height: 28px">
                                                                                <font class="blackfnt">
                                                                                    <asp:TextBox ID="txtRgnNo" runat="server" Width="107px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox></font>
                                                                            </td>
                                                                            <td style="height: 28px">
                                                                                <span style="font-size: 8pt; font-family: Verdana">Registration Date</span>
                                                                            </td>
                                                                            <td style="height: 28px">
                                                                                <font class="blackfnt">
                                                                                    <asp:TextBox ID="txtRgnDt" onblur="return ValidateDate(this);" runat="server"
                                                                                        Width="86px"></asp:TextBox>
                                                                                    <a href="#" onclick="cal.select(ctl00_MyCPH1_txtRgnDt, 'alnktxtRgnDt', 'dd/MM/yyyy'); return false;"
                                                                                        id="alnktxtRgnDt">
                                                                                        <img src="../../../GUI/images/calendar.jpg" border="0" alt="" /></a></font>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="height: 28px">
                                                                                <font class="blackfnt">Registered State</font>
                                                                            </td>
                                                                            <td style="width: 129px; height: 28px;">
                                                                                <font class="blackfnt">
                                                                                    <asp:TextBox runat="server" ID="txtRegisteredState" Width="107px" onblur="javascript:return IsStateExist(this);"></asp:TextBox>
                                                                                    <asp:HiddenField runat="server" ID="hdnRegisteredState" />
                                                                                </font>
                                                                            </td>
                                                                            <td style="height: 28px">
                                                                                <font class="blackfnt">Registered RTO</font>
                                                                            </td>
                                                                            <td style="width: 129px; height: 28px;">
                                                                                <font class="blackfnt">
                                                                                    <asp:TextBox runat="server" ID="txtRegisteredRTO" Width="107px"></asp:TextBox>
                                                                                </font>
                                                                            </td>
                                                                            <td style="height: 28px">
                                                                                <font class="blackfnt">Invoice No</font>
                                                                            </td>
                                                                            <td style="width: 129px; height: 28px;">
                                                                                <font class="blackfnt">
                                                                                    <asp:TextBox runat="server" ID="txtInvoiceNo" Width="107px"></asp:TextBox>
                                                                                </font>
                                                                            </td>

                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <font class="blackfnt"><font color="red">*</font>Vehicle Insurance
                                                                                    <br />
                                                                                    Validity Date</font>
                                                                            </td>
                                                                            <td style="width: 129px">
                                                                                <font class="blackfnt">:
                                                                                    <asp:TextBox ID="txtVhclInsuranceDt" runat="server" Width="86px" onblur="return ValidateDate(this)"></asp:TextBox></font>
                                                                                <a href="#" onclick="cal.select(ctl00_MyCPH1_txtVhclInsuranceDt, 'alnktxtVhclInsuranceDt', 'dd/MM/yyyy'); return false;"
                                                                                    id="alnktxtVhclInsuranceDt">
                                                                                    <img src="../../../GUI/images/calendar.jpg" border="0" alt="" />
                                                                                </a>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt"><font color="red">*</font>Fitness Certificate Date</font>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">:
                                                                                    <asp:TextBox ID="txtFitnessDt" onblur="return ValidateDate(this)" runat="server"
                                                                                        Width="86px"></asp:TextBox>&nbsp;<%--onblur="return ValidateFitnessDate(this)"--%>
                                                                                </font><a href="#" onclick="cal.select(ctl00_MyCPH1_txtFitnessDt, 'alnktxtFitnessDt', 'dd/MM/yyyy'); return false;"
                                                                                    id="alnktxtFitnessDt">
                                                                                    <img src="../../../GUI/images/calendar.jpg" border="0" alt="" />
                                                                                </a>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">Date Of Attaching</font>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">:<asp:TextBox ID="txtAttachingDt" onblur="return ValidateDate(this),chkdateloc(this)"
                                                                                    runat="server" Width="86px"></asp:TextBox>&nbsp; </font><a href="#" onclick="cal.select(ctl00_MyCPH1_txtAttachingDt, 'alnktxtAttachingDt', 'dd/MM/yyyy'); return false;"
                                                                                        id="alnktxtAttachingDt">
                                                                                        <img src="../../../GUI/images/calendar.jpg" border="0" alt="" />
                                                                                    </a>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <font class="blackfnt">Chasis No.</font>
                                                                            </td>
                                                                            <td style="width: 129px">
                                                                                <font class="blackfnt">:
                                                                                    <asp:TextBox ID="txtChasisNo" runat="server" Width="107px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                                                                                </font>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">Engine No.</font>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">:
                                                                                    <asp:TextBox ID="txtEngineNo" runat="server" Width="107px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                                                                                </font>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">Active Flag</font>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">:<asp:UpdatePanel ID="upChkActFlag" runat="server">
                                                                                    <ContentTemplate>
                                                                                        <asp:CheckBox ID="c1" runat="server" AutoPostBack="True" OnCheckedChanged="c1_CheckedChanged"
                                                                                            Width="10px" Checked="True" />
                                                                                        <asp:TextBox ID="txtActFlag" runat="server" ReadOnly="True" Width="40px" OnChange="Javascript:this.value=this.value.toUpperCase();">Y</asp:TextBox>&nbsp;
                                                                                    </ContentTemplate>
                                                                                    <Triggers>
                                                                                        <asp:AsyncPostBackTrigger ControlID="c1" EventName="CheckedChanged" />
                                                                                    </Triggers>
                                                                                </asp:UpdatePanel>
                                                                                </font>
                                                                            </td>
                                                                        </tr>

                                                                        <%-- ********************* 1 START ************************ --%>
                                                                        <tr>
                                                                            <td>
                                                                                <font class="blackfnt"><font color="red">*</font>Manufacturer Year</font>
                                                                            </td>
                                                                            <td style="width: 129px">
                                                                                <font class="blackfnt">:
                                                                                    <asp:TextBox ID="txtManufacturerDt" runat="server" Width="86px" onblur="return ValidateDate(this)"></asp:TextBox></font>
                                                                                <a href="#" onclick="cal.select(ctl00_MyCPH1_txtManufacturerDt, 'alnktxtManufacturerDt', 'dd/MM/yyyy'); return false;"
                                                                                    id="alnktxtManufacturerDt">
                                                                                    <img src="../../../GUI/images/calendar.jpg" border="0" alt="" />
                                                                                </a>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt"><font color="red">*</font>National Permit</font>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">:
                                                                                    <asp:TextBox ID="txtNationalPermitDt" onblur="return ValidateDate(this)" runat="server"
                                                                                        Width="86px"></asp:TextBox>&nbsp;<%--onblur="return ValidateFitnessDate(this)"--%>
                                                                                </font><a href="#" onclick="cal.select(ctl00_MyCPH1_txtNationalPermitDt, 'alnktxtNationalPermitDt', 'dd/MM/yyyy'); return false;"
                                                                                    id="alnktxtNationalPermitDt">
                                                                                    <img src="../../../GUI/images/calendar.jpg" border="0" alt="" />
                                                                                </a>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt"><font color="red">*</font>5 Year Permit</font>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">:<asp:TextBox ID="txt5YearPermitDt"
                                                                                    runat="server" Width="86px"></asp:TextBox>&nbsp; </font><a href="#" onclick="cal.select(ctl00_MyCPH1_txt5YearPermitDt, 'alnktxt5YearPermitDt', 'dd/MM/yyyy'); return false;"
                                                                                        id="alnktxt5YearPermitDt">
                                                                                        <img src="../../../GUI/images/calendar.jpg" border="0" alt="" />
                                                                                    </a>
                                                                            </td>
                                                                        </tr>


                                                                        <%-- ******************** 1 END ************************ --%>



                                                                        <%-- ********************* 2 START ************************ --%>
                                                                        <tr>
                                                                            <td>
                                                                                <font class="blackfnt"><font color="red">*</font>Road Tax</font>
                                                                            </td>
                                                                            <td style="width: 129px">
                                                                                <font class="blackfnt">:
                                                                                    <asp:TextBox ID="txtRoadTaxDt" runat="server" Width="86px" onblur="return ValidateDate(this)"></asp:TextBox></font>
                                                                                <a href="#" onclick="cal.select(ctl00_MyCPH1_txtRoadTaxDt, 'alnktxtRoadTaxDt', 'dd/MM/yyyy'); return false;"
                                                                                    id="alnktxtRoadTaxDt">
                                                                                    <img src="../../../GUI/images/calendar.jpg" border="0" alt="" />
                                                                                </a>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt"><font color="red">*</font>Fuel Efficiency</font>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">:
                                                                                    <asp:TextBox ID="txtFuelEfficiencyLtr" onblur="return checknumber(this)" runat="server"
                                                                                        Width="86px" Text="0"></asp:TextBox>&nbsp; Ltr<%--onblur="return ValidateFitnessDate(this)"--%>
                                                                                </font>
                                                                            </td>
                                                                            <td style="display: none;">
                                                                                <font class="blackfnt">:
                                                                                    <asp:TextBox ID="txtFuelEfficiencyDt" onblur="return ValidateDate(this)" runat="server"
                                                                                        Width="86px"></asp:TextBox>&nbsp;<%--onblur="return ValidateFitnessDate(this)"--%>
                                                                                </font><a href="#" onclick="cal.select(ctl00_MyCPH1_txtFuelEfficiencyDt, 'alnktxtFuelEfficiencyDt', 'dd/MM/yyyy'); return false;"
                                                                                    id="alnktxtFuelEfficiencyDt">
                                                                                    <img src="../../../GUI/images/calendar.jpg" border="0" alt="" />
                                                                                </a>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt"><font color="red">*</font>Body Type</font>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">
                                                                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                                                        <ContentTemplate>
                                                                                            <asp:DropDownList ID="ddlBodyType" runat="server" Width="128px">
                                                                                            </asp:DropDownList>
                                                                                        </ContentTemplate>

                                                                                    </asp:UpdatePanel>
                                                                                </font>
                                                                                <%--<font class="blackfnt">:<asp:TextBox ID="txtBodyTypeDt"
                                                                                    runat="server" Width="86px"></asp:TextBox>&nbsp; </font><a href="#" onclick="cal.select(ctl00_MyCPH1_txtBodyTypeDt, 'alnktxtBodyTypeDt', 'dd/MM/yyyy'); return false;"
                                                                                        id="alnktxtBodyTypeDt">
                                                                                        <img src="../../../GUI/images/calendar.jpg" border="0" alt="" />
                                                                                    </a>--%>
                                                                            </td>
                                                                        </tr>
                                                                        <%-- ******************** 2 END ************************ --%>


                                                                        <%-- ******************** 3 START ************************ --%>

                                                                        <tr>
                                                                            <td>
                                                                                <font class="blackfnt"><font color="red">*</font>CNo./Policy No.</font>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">:
                                                                                    <asp:TextBox ID="txtCNoPolicyNo" runat="server"
                                                                                        Width="86px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>&nbsp;<%--onblur="return ValidateFitnessDate(this)"--%>
                                                                                </font>
                                                                            </td>
                                                                            <td style="width: 129px; display: none;">
                                                                                <font class="blackfnt">:
                                                                                    <asp:TextBox ID="txtCNoPolicyNoDt" runat="server" Width="86px"></asp:TextBox></font>
                                                                                <a href="#" onclick="cal.select(ctl00_MyCPH1_txtCNoPolicyNoDt, 'alnktxtCNoPolicyNoDt', 'dd/MM/yyyy'); return false;"
                                                                                    id="alnktxtCNoPolicyNoDt">
                                                                                    <img src="../../../GUI/images/calendar.jpg" border="0" alt="" />
                                                                                </a>
                                                                            </td>
                                                                            <td>
                                                                                <span style="font-size: 8pt; font-family: Verdana">Engine Type</span>
                                                                            </td>
                                                                            <td style="width: 169px">
                                                                                <font class="blackfnt">
                                                                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                                                        <ContentTemplate>
                                                                                            <asp:DropDownList ID="ddlEngineType" runat="server" Width="128px">
                                                                                            </asp:DropDownList>
                                                                                        </ContentTemplate>

                                                                                    </asp:UpdatePanel>
                                                                                </font>

                                                                            </td>
                                                                            <td>Horse Type
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">
                                                                                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                                                                        <ContentTemplate>
                                                                                            <asp:DropDownList ID="ddlHorseType" runat="server" Width="128px">
                                                                                            </asp:DropDownList>
                                                                                        </ContentTemplate>

                                                                                    </asp:UpdatePanel>
                                                                                </font>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="height: 28px">
                                                                                <font class="blackfnt">Insurance Name</font>
                                                                            </td>
                                                                            <td style="width: 129px; height: 28px;">
                                                                                <font class="blackfnt">
                                                                                    <asp:TextBox runat="server" ID="txtInsuranceName" Width="107px"></asp:TextBox>
                                                                                </font>
                                                                            </td>
                                                                            <td style="height: 28px">
                                                                                <font class="blackfnt">Manufacturer Name</font>
                                                                            </td>
                                                                            <td style="width: 129px; height: 28px;">
                                                                                <font class="blackfnt">
                                                                                    <asp:TextBox runat="server" ID="txtManufacturerName" Width="107px"></asp:TextBox>
                                                                                </font>
                                                                            </td>

                                                                            <td style="height: 28px">
                                                                                <font class="blackfnt">Fuel Econommy</font>
                                                                            </td>
                                                                            <td style="width: 129px; height: 28px;">
                                                                                <font class="blackfnt">
                                                                                    <asp:TextBox runat="server" ID="txtFuelEconommy" Width="107px" Text="0.0" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                                                                </font>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <font class="blackfnt">Private Vehicle</font>
                                                                            </td>
                                                                            <td>
                                                                                <font class="blackfnt">:
                                                                                        <asp:CheckBox ID="chkPrivateVehicle" runat="server" />
                                                                                </font>
                                                                            </td>
                                                                        </tr>
                                                                        <%-- ******************** 3 END ************************ --%>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <table align="center" border="0" cellpadding="2" cellspacing="1" width="95%" class="boxbg">
                                                            <tr class="bgbluegrey">
                                                                <td colspan="8">
                                                                    <div align="center">
                                                                        <font class="bluefnt"><b>Inner Dimension in ft</b></font>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr bgcolor="#FFFFFF">
                                                                <td>
                                                                    <font class="blackfnt">Length&nbsp;&nbsp;&nbsp;:</font>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtLength" onblur="return checknumber(this)" runat="server" Width="107px"
                                                                        MaxLength="5"></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <font class="blackfnt">Width &nbsp;&nbsp;&nbsp;:</font>
                                                                </td>
                                                                <td style="width: 5px">
                                                                    <asp:TextBox ID="txtWidth" onblur="return checknumber(this)" runat="server" Width="107px"
                                                                        MaxLength="5"></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <font class="blackfnt">Height &nbsp;&nbsp;&nbsp;:</font>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtHeight" onblur="return checknumber(this)" runat="server" Width="107px"
                                                                        MaxLength="5"></asp:TextBox>
                                                                </td>
                                                                <td></td>
                                                                <td></td>
                                                                <%--<td>
                                                                    <font class="blackfnt">Rate/Km &nbsp;&nbsp;&nbsp;:</font>
                                                                </td>
                                                                <td style="width: 5px">
                                                                    <asp:TextBox ID="txtRate" onblur="return checknumber(this)" runat="server" Width="107px"
                                                                        MaxLength="5"></asp:TextBox>
                                                                </td>--%>
                                                            </tr>
                                                            <tr bgcolor="#FFFFFF">
                                                                <td colspan="8">&nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr class="bgbluegrey">
                                                                <td colspan="8">
                                                                    <div align="center">
                                                                        <font class="bluefnt"><b>Payload Capacity as per RC in Ton</b></font>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr bgcolor="#FFFFFF">
                                                                <td>
                                                                    <font class="blackfnt">GVW&nbsp;&nbsp;&nbsp;:</font>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtGVW" onblur="return checknumber(this)" runat="server" Width="107px"
                                                                        MaxLength="5"></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <font class="blackfnt">Unladen&nbsp;&nbsp;&nbsp;:</font>
                                                                </td>
                                                                <td style="width: 5px">
                                                                    <asp:TextBox ID="txtUnladen" onblur="return checknumber(this)" runat="server" Width="107px"
                                                                        MaxLength="5"></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <font class="blackfnt">Payload &nbsp;&nbsp;&nbsp;:</font>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtPayload" onblur="return checknumber(this)" runat="server" Width="107px"
                                                                        MaxLength="5"></asp:TextBox>
                                                                    <asp:HiddenField ID="hdnPayload" runat="server" />
                                                                </td>
                                                                <td>
                                                                    <font class="blackfnt">Capacity &nbsp;&nbsp;&nbsp;:</font>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtCapacity" onblur="return checknumber(this)" runat="server" Width="107px"
                                                                        MaxLength="5"></asp:TextBox>
                                                                    <asp:HiddenField ID="hdnCapacity" runat="server" />
                                                                </td>
                                                            </tr>
                                                            <tr bgcolor="#FFFFFF">
                                                                <td colspan="8">&nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr bgcolor="#FFFFFF">
                                                                <td colspan="8">
                                                                    <font class="blackfnt">* GVW : Gross Vehicle Weight as per RC Book
                                                                        <br />
                                                                        * Unladen Weight: Empty vehicle weight as per RC Book </font>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <br />
                                                        <table border="0" cellspacing="2" cellpadding="4" width="50%" align="center">
                                                            <tr>
                                                                <td align="right">
                                                                    <asp:Label ID="lblMsg" runat="server" ForeColor="#C00000"></asp:Label>
                                                                    <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" />
                                                                </td>
                                                                <%--OnClientClick="return ValidateData()"--%>
                                                                <td>
                                                                    <asp:Button ID="btnReset" runat="server" Text="Reset" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <!--END-->
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 806px">&nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 806px"></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
    </div>
</asp:Content>
