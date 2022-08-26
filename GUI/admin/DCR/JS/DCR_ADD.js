var doc = "document.aspnetForm.ctl00_MyCPH1_";

function MakeUpper(objRef)
{
    // This gets the value for the textbox that was focussed
    var curValue = objRef.value;     
    //Assign the suggested value to the box
    objRef.value = curValue.toUpperCase();      
}

function CheckSeries(SeriesFromID, TotalLeafsID, DOCTYPEID) {
  
    var SeriesFrom = document.getElementById(SeriesFromID);
    var TotalLeafs = document.getElementById(TotalLeafsID);
    var DOCTYPE = document.getElementById(DOCTYPEID);

    var txtSplitTo = document.getElementById(SeriesFromID.replace("txtSeriesFrom", "txtSplitTo"));

    if (SeriesFrom.value != "" && TotalLeafs.value != "") {

        var objXMLHttpObject = false;
        objXMLHttpObject = GetXMLHttpObject();

        if (objXMLHttpObject) {
            var boolCode = "AjaxResponce.aspx?function=IsValidDCRSeries&SeriesFrom=" + SeriesFrom.value + "&TotalLeafs=" + TotalLeafs.value + "&DocType=" + DOCTYPE.value + "&sid=" + Math.random() + "&sid2" + Math.random();
            objXMLHttpObject.open("GET", boolCode);

            objXMLHttpObject.onreadystatechange = function () {
                if ((objXMLHttpObject.readyState == 4) && (objXMLHttpObject.status == 200)) {

                    var result = objXMLHttpObject.responseText.split("|");
                    if (result[0] == "0") {
                        alert(result[1]);
                        SeriesFrom.value = "";
                        DOCTYPE.disabled = false;
                        SeriesFrom.focus();
                        return false;
                    }
                    else {
                        MakeUpper(SeriesFrom);
                        txtSplitTo.value = TotalLeafs.value;
                        DOCTYPE.disabled = true;
                        return true;
                    }
                }
            }
            objXMLHttpObject.send(null);
        }
    }
    else {
        DOCTYPE.disabled = false;
        txtSplitTo.value = TotalLeafs.value;
    }
    return true;
}

function IsValidPageSize(txtSplitToID, TotalLeafsID) {
    var bRet = true;
    var txtSplitTo = document.getElementById(txtSplitToID);
    var TotalLeafs = document.getElementById(TotalLeafsID);
    
    if (txtSplitTo.value != "" && TotalLeafs.value != "") {
        if (parseInt(txtSplitTo.value) < 10 || parseInt(txtSplitTo.value) > parseInt(TotalLeafs.value)) {
            alert("Page size should be between 10 and " + TotalLeafs.value);
            txtSplitTo.value = TotalLeafs.value;
            txtSplitTo.focus();
            bRet = false
        }
    }
    return bRet;
}

function CheckBook(BookID, DOCTYPEID) {
   
    var txtBook = document.getElementById(BookID);    
    var DOCTYPE = document.getElementById(DOCTYPEID);
    if (txtBook.value != "") {
        
        var objXMLHttpObject = false;
        objXMLHttpObject = GetXMLHttpObject();

        if (objXMLHttpObject) {
            var boolCode = "AjaxResponce.aspx?function=IsValidDCRBookCode&BookCode=" + txtBook.value + "&DocType=" + DOCTYPE.value + "&sid=" + Math.random() + "&sid2" + Math.random();
            
            objXMLHttpObject.open("GET", boolCode);

            objXMLHttpObject.onreadystatechange = function () {
                if ((objXMLHttpObject.readyState == 4) && (objXMLHttpObject.status == 200)) {
                    
                    var result = objXMLHttpObject.responseText.split("|");
                    if (result[0] == "0") {
                        alert(result[1]);
                        txtBook.value = "";
                        txtBook.focus();
                        return false;
                    }
                    else {
                        MakeUpper(txtBook);
                        return true;
                    }
                }
            }
            objXMLHttpObject.send(null);
        }
    }    
    return true;
}

function CheckBranchCode(BranchCode) {
    debugger;     
    var txtAlloteTo = document.getElementById(BranchCode);

    if (txtAlloteTo.value != "") 
    {
        var objXMLHttpObject = false;
        objXMLHttpObject = GetXMLHttpObject();

        if (objXMLHttpObject) {
            var boolCode = "AjaxResponce.aspx?function=IsValidBranchCode&BranchCode=" + txtAlloteTo.value + "&sid=" + Math.random() + "&sid2" + Math.random();

            objXMLHttpObject.open("GET", boolCode);

            objXMLHttpObject.onreadystatechange = function() {
                if ((objXMLHttpObject.readyState == 4) && (objXMLHttpObject.status == 200)) {

                    var result = objXMLHttpObject.responseText.split("|");
                    if (result[0] == "0") {
                        alert(result[1]);
                        txtAlloteTo.value = "";
                        txtAlloteTo.focus();
                        return false;
                    }
                    else {
                        MakeUpper(txtAlloteTo);
                        return true;
                    }
                }
            }
            objXMLHttpObject.send(null);
        }
    }
    return true;
}