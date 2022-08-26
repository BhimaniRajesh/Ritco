var _isPostback=true;
document.onclick = function() {
    if (event.srcElement.tagName !='' || event.srcElement.tagName !=null)
        _isPostback = false;
    else
        _isPostback = true;
};

//window.onbeforeunload = CloseSession;

function CloseSession()
{
    if (_isPostback != false) {
        //alert("You have been successfully logged out!");
        location.href = '<%=ResolveClientUrl("~/GUI/Logout.aspx")%>';
    }
}

//Disable right mouse click Script

//var message = "Function Disabled!";

//function clickIE4() {
//    if (event.button == 2) {
//        alert(message);
//        return false;
//    }
//}

//function clickNS4(e) {
//    if (document.layers || document.getElementById && !document.all) {
//        if (e.which == 2 || e.which == 3) {
//            alert(message);
//            return false;
//        }
//    }
//}

//if (document.layers) {
//    document.captureEvents(Event.MOUSEDOWN);
//    document.onmousedown = clickNS4;
//}

//else if (document.all && !document.getElementById) {
//    document.onmousedown = clickIE4;
//}

//document.oncontextmenu = new Function("alert(message);return false")

////Disable F5,BackSpace,Ctrl + R and Ctrl + N  Script
//document.onkeydown= function(){
//    if (event.keyCode == 116) {
//        event.keyCode = 0;
//        event.cancelBubble = true;
//        alert("Function Disabled!");
//        return false;
//    }
//    else if (window.event.ctrlKey && (window.event.keyCode == 78 || window.event.keyCode == 82)) {
//        event.keyCode = 0;
//        event.cancelBubble = true;
//        alert("Function Disabled!");
//        return false;
//    }

//}
