// JScript File
function createXMLHttpRequest() {
    // Mozilla, Safari,...
	if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
	// IE
	else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
}
/*************************************************************************************************************
*   FOR NUMERIC TEXTBOX
/*************************************************************************************************************/
function numeric(e) { return ((e.keyCode == 8) || (e.keyCode == 110) || (e.keyCode == 190) || (e.keyCode > 47 && e.keyCode <58)||(e.keyCode > 95 && e.keyCode <106) || (e.keyCode == 9) || (e.keyCode == 46));  }
/*************************************************************************************************************
*   CHECK FOR VALID DECIMAL VALUE
/*************************************************************************************************************/        
function checkDecimal(id, isID)
{
    var txtID;
        
    if(isID == "TRUE")
    {
       txtID = document.getElementById(id); 
    }
    else
    {
       txtID = id; 
    }          
       
    if (txtID.value != "")	
    {   	
         if(isNaN(txtID.value))
         {
            alert("Value should be Numeric.");
            txtID.value = "";        
            return false;
         } 				
         if(parseFloat(txtID.value) < 0)
         {
            alert("Value should be greater than zero.");
            txtID.value = "";                      
            return false;
          }
     }
     return true;					   
}
function CheckValidMin(id, isID)
{
    var txtID;
    if(isID == "TRUE")
    {
       txtID = document.getElementById(id); 
    }
    else
    {
       txtID = id; 
    }       
    if(checkDecimal(id, isID))
    {
        if(parseFloat(txtID.value) > 59)
        {
            alert("Invalid Minute");
            txtID.focus();
            return false;
        }
    }
}

var pref = "ctl00_MyCPH1_";
function GetObject(o)
{
   return document.getElementById('ctl00_MyCPH1_' + o)
}
function HideTripsheetTb()
{
    var tb_Tripsheet_No=GetObject("tb_Tripsheet_No");
    tb_Tripsheet_No.style.visibility="hidden";
}
//function nwOpen(th,tb_Tripsheet_No,hfVehIntId,lbl_TripSheet_Err)
function OpenPopupTS()
{
    var tb_Tripsheet_No = GetObject("tb_Tripsheet_No");
    var hfVehIntId = GetObject("hfVehIntId");
    var lbl_TripSheet_Err =GetObject("lbl_TripSheet_Err");
    var txtVehNo=GetObject("txtVehNo");
    alert(txtVehNo.value)
    var lblVehNoErr=GetObject("lblVehNoErr");
    if(hfVehIntId.value == "")
    {
        lblVehNoErr.innerText = "Fisrt Select Vehicle Number.";
        tb_Tripsheet_No.value = "";
        txtVehNo.focus();
        return false;
    }
    else
    {
        alert("Popup_TripsheetNo.aspx?TsNo=" + tb_Tripsheet_No+"&VehNo="+txtVehNo.value+"&lblErr="+lbl_TripSheet_Err,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70");
        window.open("Popup_TripsheetNo.aspx?TsNo=ctl00_MyCPH1_tb_Tripsheet_No&VehNo="+txtVehNo.value+"&lblErr=ctl00_MyCPH1_lbl_TripSheet_Err","pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70");
        return false;
    }
}
function createXMLHttpRequest()
{
    // Mozilla, Safari,...
    if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
    // IE
    else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
}
function checkVehNo(txtVehNo,hfVehIntId,txtKm,lblVehNoErr,tb_Tripsheet_No)
{
    var currentTime = new Date()
    //var TripsheeNo = document.getElementById("TripsheeNo");
    var TripsheeNo = GetObject("TripsheeNo");
    if (txtVehNo.value == "")
    {
        txtVehNo.value="";
        hfVehIntId.value="";
        txtKm.value="";
        lblVehNoErr.innerText="";
        TripsheeNo.innerHTML="";
        tb_Tripsheet_No.value="";
        return;
    }
    createXMLHttpRequest();
    if (xmlHttpRequest)
    {
        xmlHttpRequest.onreadystatechange = function()
        {
            if (xmlHttpRequest.readyState == 4)
            {
                var returnValue=xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") 
                {
                    lblVehNoErr.innerText = "Invalid Vehicle Number";
                    txtVehNo.value="";
                    hfVehIntId.value="";
                    txtKm.value="";
                    TripsheeNo.innerHTML="";
                    txtVehNo.focus();
                    tb_Tripsheet_No.value="";
                    return false;
                }
                else
                {
                    lblVehNoErr.innerText = "";
                    txtVehNo.value=returnValue[1];
                    hfVehIntId.value=returnValue[2];
                    txtKm.value=returnValue[3];
                    TripsheeNo.innerHTML=returnValue[4];
                    TripsheeNo.title=returnValue[4];
                    tb_Tripsheet_No.value=returnValue[4];
                    TripsheeNo.href="../Operations/Issue/frmViewPrintVehicleIssueSlipNew.aspx?PrintMode=0&VSlipNo="+returnValue[4];
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/wfrm_AJAX_Validator.aspx?Function=CheckValidVehNoRotate&datetime="+currentTime+"&VehNo=" + txtVehNo.value, false);
        xmlHttpRequest.send(null);
    }	
}
function checkLocation(tb_Location,lbl_Location_Err)
{
    var currentTime = new Date()
    if (tb_Location.value == "")
    {
        tb_Location.value="";
        lbl_Location_Err.innerText="";
        return;
    }
    createXMLHttpRequest();
    if (xmlHttpRequest)
    {
        xmlHttpRequest.onreadystatechange = function()
        {
            if (xmlHttpRequest.readyState == 4)
            {
                var returnValue=xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "N") 
                {
                    lbl_Location_Err.innerText = "Invalid Location";
                    tb_Location.value="";
                    tb_Location.focus();
                    return false;
                }
                else
                {
                    lbl_Location_Err.innerText = "";
                    tb_Location.value=tb_Location.value;
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/wfrm_AJAX_Validator.aspx?Function=checkLocation&datetime="+currentTime+"&Location=" + tb_Location.value, false);
        xmlHttpRequest.send(null);
    }	
}
function checkTSNumber(tb_Tripsheet_No,lbl_TripSheet_Err,txtVehNo,lblVehNoErr)
{
    var currentTime = new Date()
    if (txtVehNo.value == "")
    {
        lblVehNoErr.innerText="Fisrt Select Vehicle Number.";
        tb_Tripsheet_No.value="";
        lbl_TripSheet_Err.innerText="";
        txtVehNo.focus();
        return false;
    }
    else
    {
        if(tb_Tripsheet_No.value == "")
        {
            tb_Tripsheet_No.value="";
            lbl_TripSheet_Err.innerText="";
            return;
        }
        createXMLHttpRequest();
        if (xmlHttpRequest)
        {
            xmlHttpRequest.onreadystatechange = function()
            {
                if (xmlHttpRequest.readyState == 4)
                {
                    var returnValue=xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "N") 
                    {
                        lbl_TripSheet_Err.innerText = "Invalid Tripsheet Number !!!";
                        tb_Tripsheet_No.value="";
                        tb_Tripsheet_No.focus();
                        return false;
                    }
                    else
                    {
                        lbl_TripSheet_Err.innerText = "";
                        tb_Tripsheet_No.value=tb_Tripsheet_No.value;
                    }
                }
            }
            xmlHttpRequest.open("GET", "AJAX_Validator/wfrm_AJAX_Validator.aspx?Function=checkTSNumber&datetime="+currentTime+"&VehNo="+txtVehNo.value+"&TSNo="+tb_Tripsheet_No.value, false);
            xmlHttpRequest.send(null);
        }	
    }
}
function CheckValidataion()
{
   
}
