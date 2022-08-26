/*****************************************************************************************************************
THIS FUCNTION IS USED TO RETRIEVE HTTP OBJECT
return type XMLHttpObject
*****************************************************************************************************************/
function GetXMLHttpObject() {
    var xmlHttp;
    try {
        xmlHttp = new XMLHttpRequest();    // Firefox, Opera 8.0+, Safari    
    }
    catch (e) {
        // Internet Explorer    
        try {
            xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
        }
        catch (e) {
            try
                    { xmlHttp = new ActiveXObject("Microsoft.XMLHTTP"); }
            catch (e) {
                alert("Your browser does not support AJAX!");
                return false;
            }
        }
    }
    return xmlHttp;
}

function appendOption(listCtrl, optionText, optionValue) {
    var newOption = document.createElement('option');
    newOption.text = optionText;
    newOption.value = optionValue;
    try {
        listCtrl.add(newOption, null); // standards compliant; doesn't work in IE
    }
    catch (ex) {
        listCtrl.add(newOption); // IE only
    }
}