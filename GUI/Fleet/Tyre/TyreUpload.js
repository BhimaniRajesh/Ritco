// JScript File

var controlIdPrefix = "ctl00_MyCPH1_";
var a=true;
function numeric(e) { return ((e.keyCode == 8) || (e.keyCode > 47 && e.keyCode <58)||(e.keyCode > 95 && e.keyCode <106) || (e.keyCode == 9) || (e.keyCode == 46));  }
function createXMLHttpRequest() {
    // Mozilla, Safari,...
	if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
	// IE
	else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
}
function Change(obj, evt)
{
    if(evt.type=="focus")
        obj.style.borderColor="red";
    else if(evt.type=="blur")
        obj.style.borderColor="black";
}

function CheckValid()
{
    var FileUpload_Tyre = document.getElementById("ctl00_MyCPH1_FileUpload_Tyre"); 
    var lbl_Error_Msg = document.getElementById("ctl00_MyCPH1_lbl_Error_Msg"); 
    
    if(FileUpload_Tyre.value == "")
    {
        lbl_Error_Msg.innerText = "Select File.";
        FileUpload_Tyre.style.borderColor="red";
        a = false;
        return false;
    }
    if(a==false)
    {
        lbl_Error_Msg.innerText = "Invalid File Format.";
        FileUpload_Tyre.style.borderColor="red";
        a = false;
        return false;
    }
}
function getSize(FileUpload_Tyre)
{
    var oas = new ActiveXObject("Scripting.FileSystemObject");
    var d = FileUpload_Tyre.value;
    var e = oas.getFile(d);
    var f = e.size;
    return(f);
}
function ValidFile(FileUpload_Tyre)
{
    var lbl_Error_Msg = document.getElementById(controlIdPrefix+"lbl_Error_Msg"); 
    if(FileUpload_Tyre.value!="")
    {
        var path = FileUpload_Tyre.value;
        var Index = path.lastIndexOf(".");
        var length = path.length;

        var filetype = path.substring(Index,length)
        if ((filetype.toLowerCase() == ".xls") ||(filetype.toLowerCase() == ".xlsx"))
        {
            lbl_Error_Msg.innerText = "";
            FileUpload_Tyre.style.borderColor="green";
            a = true;
            var x = getSize(FileUpload_Tyre); 
            if (x > 1048576)
            {
                //alert("only upto 1 MB file is allowed");
                lbl_Error_Msg.innerText = "only upto 1 MB file is allowed";
                FileUpload_Tyre.style.borderColor="red";
                a = false;
                return false;
            }
        }
        else
        {
            lbl_Error_Msg.innerText = "Invalid File Format.";
            FileUpload_Tyre.style.borderColor="red";
            a = false;
            return false;
        }
    }
    else
    {
//        lbl_Error_Msg.innerText = "Select File.";
//        FileUpload_Tyre.style.borderColor="red";
//        a = false;
//        return false;
    }
}