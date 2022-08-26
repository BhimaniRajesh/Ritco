// JScript File
function createXMLHttpRequest() {
    // Mozilla, Safari,...
	if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
	// IE
	else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
}
function AccBlur(tb_AccCode,tb_Description)
{
    var currentTime = new Date()
    var lbl_Err_AccCode = document.getElementById("ctl00_MyCPH1_lbl_Err_AccCode");
    if (tb_AccCode.value == ""){lbl_Err_AccCode.innerText="";  return; }
    
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
                    lbl_Err_AccCode.innerText = "Account Code is not Valid... Please Enter Valid Account Code!!!";
                    tb_AccCode.value="";
                    tb_Description.value="";
                    tb_AccCode.focus();
                    return false;
                }
                else
                {
                    lbl_Err_AccCode.innerText = "";
                    tb_Description.value=returnValue[1];
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckValidAccCode&datetime="+currentTime+"&AccCode="+tb_AccCode.value, false);
        xmlHttpRequest.send(null);
    }
}

/*************************************************************************************************************
*   For Blink Controls
/*************************************************************************************************************/
var g_blinkTime = 100;
var g_blinkCounter = 0;

function blinkElement(elementId)
{
 if ( (g_blinkCounter % 2) == 0 )
 {
  if ( document.getElementById )
  {
   document.getElementById(elementId).style.visibility = 'visible';
  }
  // IE 4...
  else if ( document.all )
  {
   document.all[elementId].style.visibility = 'visible';
  }
  // NS 4...
  else if ( document.layers )
  {
   document.layers[elementId].visibility = 'visible';
  }
 }
 else
 {
  if ( document.getElementById )
  {
   document.getElementById(elementId).style.visibility = 'hidden';
  }
  // IE 4...
  else if ( document.all )
  {
   document.all[elementId].style.visibility = 'hidden';
  }
  // NS 4...
  else if ( document.layers )
  {
   document.layers[elementId].visibility = 'hidden';
  }
 }

 if ( g_blinkCounter < 1 )
 {
  g_blinkCounter++;
 } 
 else
 {
  g_blinkCounter--
 }

 window.setTimeout('blinkElement(\"' + elementId + '\")', g_blinkTime);
}
/*************************************************************************************************************
*   For +/- Value
/*************************************************************************************************************/

function PlusMinus(tb_Polarity,e) 
{
    var lbl_Polarity_Err = document.getElementById("ctl00_MyCPH1_lbl_Polarity_Err");
    if(tb_Polarity.value == "")
    {
        tb_Polarity.style.borderColor="";
        lbl_Polarity_Err.innerText = "";
        return;
    }
    if(tb_Polarity.value != "+" && tb_Polarity.value != "-")
    {
        tb_Polarity.style.borderColor="red";
        lbl_Polarity_Err.innerText="Invalid !!! (Allow only [+/-] )";
        //blinkElement("ctl00_MyCPH1_lbl_Polarity_Err");
        tb_Polarity.focus();
        return false;
    }
    else
    {
        tb_Polarity.style.borderColor="";
        lbl_Polarity_Err.innerText = "";
    }
}

/*************************************************************************************************************
*   For Check Valid Expenses
/*************************************************************************************************************/
function CheckValidExp(tb_Trip_Exp)
{
    var currentTime = new Date();
    var lbl_Trip_Exp_Err = document.getElementById("ctl00_MyCPH1_lbl_Trip_Exp_Err");
    var hfId = document.getElementById("ctl00_MyCPH1_hfId");
    if(tb_Trip_Exp.value == "")
    {
        tb_Trip_Exp.value="";
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
                    tb_Trip_Exp.style.borderColor="";
                    tb_Trip_Exp.value=tb_Trip_Exp.value;
                    lbl_Trip_Exp_Err.innerText = "";
                }
                else
                {
                    lbl_Trip_Exp_Err.innerText = "Already Exist !! ";
                    tb_Trip_Exp.style.borderColor="red";
                    tb_Trip_Exp.focus();
                    return false;
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckValidExp&datetime="+currentTime+"&Id="+hfId.value+"&Exp="+ tb_Trip_Exp.value, false);
        xmlHttpRequest.send(null);
    }
}
////////////////
function CheckValidataion()
{
    var tb_Trip_Exp = document.getElementById("ctl00_MyCPH1_tb_Trip_Exp");
    var lbl_Trip_Exp_Err = document.getElementById("ctl00_MyCPH1_lbl_Trip_Exp_Err");
    var tb_Polarity = document.getElementById("ctl00_MyCPH1_tb_Polarity");
    var lbl_Polarity_Err = document.getElementById("ctl00_MyCPH1_lbl_Polarity_Err");
    
    if(tb_Trip_Exp.value == "")
    {
        tb_Trip_Exp.style.borderColor="red";
        lbl_Trip_Exp_Err.innerText="Enter Expense !!!";
        tb_Trip_Exp.focus();
        return false;
    }
    else
    {
        lbl_Trip_Exp_Err.innerText = "";
    }
    if(tb_Polarity.value == "")
    {
        tb_Polarity.style.borderColor="red";
        lbl_Polarity_Err.innerText="Enter Polarity !!!";
        tb_Polarity.focus();
        return false;
    }
    else
    {
        lbl_Polarity_Err.innerText = "";
    }
}
