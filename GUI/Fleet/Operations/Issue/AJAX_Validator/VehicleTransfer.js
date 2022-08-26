// JScript File

var controlIdPrefix = "ctl00_MyCPH1_";
     
function createXMLHttpRequest()
{
  // Mozilla, Safari,...
  if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
  // IE
  else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
}

function CheckVehicleNo(row_Index,txtVehNo,txtVehInternalNo,txtCurrContlLoc,txtCurrKmRead,txtNewVehNo,txtNewContlBranch,txtVehTransferDt)
{
//alert("Hi1")
    var currentTime = new Date()
    var str_Index = "";

   if (txtVehNo.value == "")
    {    
       txtVehNo.value="";
       txtVehInternalNo.value="";
       txtCurrContlLoc.value="";
       txtCurrKmRead.value="";
       txtNewVehNo.value="";
       txtNewContlBranch.value="";
       txtVehTransferDt.value="";
       txtVehNo.focus();
       return true;
    }  
    
 //alert("Hi2")
    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gvVehicleTransfer").rows.length; intIndex++)
        { 
            if (intIndex < 10)
            {
                str_Index = "0" + intIndex; 
                                  
            }
            else
            {
                str_Index = intIndex;
            }
            //alert("Hi3")
            //alert(row_Index)
            if (row_Index == intIndex - 2)
            {
             
                continue;
            }
             
            if (document.getElementById("ctl00_MyCPH1_gvVehicleTransfer_ctl" + str_Index + "_txtVehNo").value == txtVehNo.value)
            {
                alert("This VehicleNo is already exist at row " + (intIndex - 1));
                txtVehNo.focus();
                return;
            }
        }
    
    createXMLHttpRequest();
    if (xmlHttpRequest)
    {
        xmlHttpRequest.onreadystatechange = function()
        {
            if (xmlHttpRequest.readyState == 4)
            {
                //alert(xmlHttpRequest.responseText);
                var returnValue=xmlHttpRequest.responseText.split("~");
                //alert("1 : " + returnValue[0])
                
                if (returnValue[0] == "N") 
                {
                   alert("Invalid Vehicle No.");
                   txtVehInternalNo.value="";
                   txtCurrContlLoc.value="";
                   txtCurrKmRead.value="";
                   txtVehNo.focus();
                   return false;
                }
                else
                {       
                                                
                    txtVehInternalNo.value=returnValue[2];
                    txtCurrContlLoc.value=returnValue[3];
                    txtCurrKmRead.value=returnValue[4];
                       
                } 

            }
        }
      
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetVehicleNo&datetime="+currentTime+"&VEHNO=" + txtVehNo.value, false);
        xmlHttpRequest.send(null);
    }   
}

function CheckNewVehicleNo(txtNewVehNo)
{
     //alert("hi1")
     var currentTime = new Date()
     
     if(txtNewVehNo.value=="")
     {
       return true;
     }
         
    createXMLHttpRequest();
    //alert("hi3")
    if (xmlHttpRequest)
    {
     //alert("ok-1")
        xmlHttpRequest.onreadystatechange = function()
        { 
            if (xmlHttpRequest.readyState == 4)
            {
                //alert(xmlHttpRequest.responseText);
                var returnValue=xmlHttpRequest.responseText.split("~");
                
                if (returnValue[0] == "Y") 
                { 
                    alert("Entered New Vehicle No. is Already Exists.");
                    txtNewVehNo.focus();
                    return false;
                   
                }
                else
                {  
                 
                }
               
            }
        }
       xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetNewVehicleNo&datetime="+currentTime+"&NEW_VEHNO=" + txtNewVehNo.value, false);
       xmlHttpRequest.send(null);
    }       

}

function CheckNewControllingBranch(txtNewContlBranch)
{

 //alert("hi1")
     var currentTime = new Date()
     
     if(txtNewContlBranch.value=="")
     {
       return true;
     }
         
    createXMLHttpRequest();
    //alert("hi3")
    if (xmlHttpRequest)
    {
     //alert("ok-1")
        xmlHttpRequest.onreadystatechange = function()
        { 
            if (xmlHttpRequest.readyState == 4)
            {
                //alert(xmlHttpRequest.responseText);
                var returnValue=xmlHttpRequest.responseText.split("~");
                
                if (returnValue[0] == "N") 
                { 
                    alert("Entered New Controlling Branch is Invalid");
                    txtNewContlBranch.focus();
                    return false;
                   
                }
                else
                {  
                 
                }
               
            }
        }
       xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetNewControllingBranch&datetime="+currentTime+"&LocCode=" + txtNewContlBranch.value, false);
       xmlHttpRequest.send(null)
    }    

}

function CheckTransferDate(txtVehNo,txtVehTransferDt)
{

 //alert("hi1")
     var currentTime = new Date()
     
     if(txtVehTransferDt.value=="")
     {
       return true;
     }
         
    createXMLHttpRequest();
    //alert("hi3")
    if (xmlHttpRequest)
    {
     //alert("ok-1")
        xmlHttpRequest.onreadystatechange = function()
        { 
            if (xmlHttpRequest.readyState == 4)
            {
                //alert(xmlHttpRequest.responseText);
                //alert(returnValue);
                var returnValue=xmlHttpRequest.responseText.split("~");
                
                if (returnValue[0] == "N") 
                { 
                    alert("Transfer Date Should not be Greater Than Today's Date.");
                    txtVehTransferDt.focus();
                    return false;
                   
                }
                else
                {  
                 
                }
               
            }
        }
       xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=GetTransferDate&datetime="+currentTime+"&VEHNO="+txtVehNo.value+"&TransferDate="+txtVehTransferDt.value, false);
       xmlHttpRequest.send(null)
    }    

}

function CheckSubmit()
{

//alert("h1") 
   var tot_rows=document.getElementById(controlIdPrefix + "gvVehicleTransfer").rows.length;
   //alert("submit");
   
     if(tot_rows>0)
        {
            for(i=0;i< tot_rows-1;i++)
            {  
                j=i+2
                var pref="";
                if(j<10)
                {
                    pref = "ctl00_MyCPH1_gvVehicleTransfer_ctl0" + j + "_";
                }                                       
                else
                {         
                    pref = "ctl00_MyCPH1_gvVehicleTransfer_ctl" + j + "_";
                }              
                txtVehNo = document.getElementById(pref +"txtVehNo");
                txtNewVehNo = document.getElementById(pref +"txtNewVehNo");
                txtNewContlBranch = document.getElementById(pref +"txtNewContlBranch");
                txtVehTransferDt = document.getElementById(pref +"txtVehTransferDt");
        
                if(txtVehNo.value == "" )
                {
                    alert("Enter Vehicle Number")
                    //txtManual_TripSheetNo.focus();
                    document.getElementById(pref + "txtVehNo").focus();
                    return false;
                }
                
                 if(txtNewVehNo.value == "" )
                {
                   alert("Enter New Vehicle Number");
                   document.getElementById(pref + "txtNewVehNo").focus();
                   return false;
                }
                
                 if(txtNewContlBranch.value == "")
                {
                    alert("Enter New Controlling Branch");
                    document.getElementById(pref + "txtNewContlBranch").focus();
                    return false;
                }
                
                 if(txtVehTransferDt.value == "" )
                {
                   alert("Enter Vehicle Transfer Date");
                   document.getElementById(pref + "txtVehTransferDt").focus();
                   return false;
                }
                    
                //alert("submit*");
                
                 for(k=0;k<tot_rows-1;k++)
                {  
                    if(i!=k)
                    {
                        m=k+2
                        var pref="";
                        if(j<10)
                        {
                            pref = "ctl00_MyCPH1_gvVehicleTransfer_ctl0" + m + "_";
                        }                                       
                        else
                        {         
                            pref = "ctl00_MyCPH1_gvVehicleTransfer_ctl" + m + "_";
                        }    
                    }
                }
                                             
       }
  }

}