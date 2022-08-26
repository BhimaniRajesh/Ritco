<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="RouteMaster.aspx.cs" Inherits="GUI_admin_TripRouteMaster" Title="Trip Route Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <link href="../../images/style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../../../GUI/images/CommonJS.js"></script>
    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript">
/*************************************************************************************************************
*   LOCATION MASTER TEST FOR CONTROLLING BRANCH
/*************************************************************************************************************/        
function checkCity(id, isID)
{
    var obj;
    
    if(isID == "TRUE")
    {     
       obj = document.getElementById(id); 
    }  
    else
    {
      obj = id; 
    }   
         
    obj.value = obj.value.toUpperCase(); 
    var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");    
    //alert(obj.value );
    if (obj.value != "")
    {            
        var objXMLHttpObject = false;
        objXMLHttpObject = GetXMLHttpObject();          
        hdnajaxstate.value = "1";
        
        if(objXMLHttpObject)
        {
           var boolLocationCode = "AjaxResponse.aspx?mode=check&code1=City&code2=" + obj.value + "&sid=" + Math.random() + "&sid2" + Math.random(); 
           objXMLHttpObject.open("GET", boolLocationCode);
           
           objXMLHttpObject.onreadystatechange = function()
           {
                if((objXMLHttpObject.readyState == 4) && (objXMLHttpObject.status == 200))
                {                              
                      var result = objXMLHttpObject.responseText.split("|");                        
                      
                      if(result[0] == "false")
                      { 
                          alert(result[1]);
                          obj.value = "";
                          obj.focus();  
                          hdnajaxstate.value = "0";                     
                          return false;  
                      }
                      else
                      {
                          hdnajaxstate.value = "0";
                      }                           
                }
           }
            objXMLHttpObject.send(null);
          }
    }
    return true;
}
/*************************************************************************************************************/
function checkLocation(id, isID)
{
    var obj;
    
    if(isID == "TRUE")
    {     
       obj = document.getElementById(id); 
    }  
    else
    {
      obj = id; 
    }   
         
    obj.value = obj.value.toUpperCase(); 
    var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");    
    //alert(obj.value );
    if (obj.value != "")
    {            
        var objXMLHttpObject = false;
        objXMLHttpObject = GetXMLHttpObject();          
        hdnajaxstate.value = "1";
        
        if(objXMLHttpObject)
        {
           var boolLocationCode = "AjaxResponse.aspx?mode=check&code1=LocName&code2=" + obj.value + "&sid=" + Math.random() + "&sid2" + Math.random(); 
           objXMLHttpObject.open("GET", boolLocationCode);
           
           objXMLHttpObject.onreadystatechange = function()
           {
                if((objXMLHttpObject.readyState == 4) && (objXMLHttpObject.status == 200))
                {                              
                      var result = objXMLHttpObject.responseText.split("|");                        
                      
                      if(result[0] == "false")
                      { 
                          alert(result[1]);
                          obj.value = "";
                          obj.focus();  
                          hdnajaxstate.value = "0";                     
                          return false;  
                      }
                      else
                      {
                          hdnajaxstate.value = "0";
                      }                           
                }
           }
            objXMLHttpObject.send(null);
          }
    }
    return true;
}
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
/*************************************************************************************************************/

/*************************************************************************************************************
*   CHECK BRANCH IF CHECKBOX IS SELECTED BRANCH TEXTBOX MUST IS NOT EMPTY
    AND IF CHEKBOX ROUND TRIP IS FALSE THAN DOES NOT SAME BRANCH NAME
/*************************************************************************************************************/        
function checkBranch()
{       
    var chkRoundTrip = document.getElementById("ctl00_MyCPH1_chkRoundTrip");
   chkRoundTrip
    var gvTripRoute = document.getElementById("ctl00_MyCPH1_gvTripRoute"); 
    var rows;
    var count = 0;
    var chkSelect, txtbranchname;
        
    if(gvTripRoute != null)
    {
        rows = gvTripRoute.rows.length;      
            
        for(i=0;i<rows-3;i++)
        {
            j = i+3;             
                      
            if (j<10)
            {          
                if (j==3)
                {
                    continue;
                }            
                Prefix = "ctl00_MyCPH1_gvTripRoute_ctl0"+ j;                               
            }
            else
            { 
                Prefix = "ctl00_MyCPH1_gvTripRoute_ctl"+ j;                                             
            }
                    
            chkSelect = document.getElementById(Prefix +"_chkSelect");
            txtbranchname = document.getElementById(Prefix +"_txtbranchname");    
            ///////// FOR CHECK DUPLICATE CITY      ////////////////////////////
            if(chkRoundTrip.checked == false)
            {
                checkDuplicate(txtbranchname,chkRoundTrip);
            }                    
            //////////////////////////////////////////////////////////////////
            if (chkSelect.checked == true)
            {
                if (txtbranchname.value == "")
                {
                    alert("Branch Name Should Not Remain Blank.");
                    return false;
                }
                count+=1;
            }             
        }
           
//        if (count < 2)
//        {
//            alert("Please Select Minimum 2 branches.")
//            return false;
//        }
//        else
//        {                
//            return true;
//        }      
        return true;         
    }     
}
/*************************************************************************************************************/

/*************************************************************************************************************
*   CHECK BRANCH IF CHECKBOX IS SELECTED BRANCH TEXTBOX MUST IS NOT EMPTY
/*************************************************************************************************************/        
function checkRoute()
{        
        var route = "";    
    
        var ddlRouteMode = document.getElementById("ctl00_MyCPH1_ddlRouteMode");       
        var gvTripRoute = document.getElementById("ctl00_MyCPH1_gvTripRoute");
        var rows;
        var chkSelect, txtbranchname;
         
         if(gvTripRoute != null)
        {        
            rows = gvTripRoute.rows.length - 1;
           
            for(i=0; i<rows-2; i++)
            {
                j=i+3;
                
                if (j<10)
                {
                    chkSelect = document.getElementById("ctl00_MyCPH1_gvTripRoute_ctl0"+j+"_chkSelect");
                    txtbranchname = document.getElementById("ctl00_MyCPH1_gvTripRoute_ctl0"+j+"_txtbranchname");            
                    
                    if (chkSelect.checked == true)
                    {
                       if(route == "")
                       {
                           route = txtbranchname.value;
                       }
                       else
                       {
                           route = route + "~" + txtbranchname.value;
                       }
                    }
                }
                else
                {
                    chkSelect = document.getElementById("ctl00_MyCPH1_gvTripRoute_ctl"+j+"_chkSelect");
                    txtbranchname = document.getElementById("ctl00_MyCPH1_gvTripRoute_ctl"+j+"_txtbranchname");            
                    
                    if (chkSelect.checked == true)
                    {
                        route = route +"~" + txtbranchname.value;                          
                    }
                }
            }               
            
            var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");        
        
            var objXMLHttpObject = false;
            objXMLHttpObject = GetXMLHttpObject();          
            
            if(objXMLHttpObject)
            {
               var boolLocationCode = "AjaxResponse.aspx?mode=check&code1=routecodecity&code2=" + route + "&routemode=" + ddlRouteMode.value +"&sid=" + Math.random() + "&sid2" + Math.random(); 
               objXMLHttpObject.open("GET", boolLocationCode);
               hdnajaxstate.value = "1";
               
               objXMLHttpObject.onreadystatechange = function()
               {
                    if((objXMLHttpObject.readyState == 4) && (objXMLHttpObject.status == 200))
                    {                              
                          var result = objXMLHttpObject.responseText.split("|");                        
                          
                          if(result[0] == "true")
                          { 
                              alert(result[1]);                         
                              hdnajaxstate.value = "0";                     
                              return false;  
                          }
                          else
                          {
                            hdnajaxstate.value = "0";
                          }                           
                    }
               }                  
                 objXMLHttpObject.send(null);
              }   
          }
          return true;
}
/*************************************************************************************************************/

/*************************************************************************************************************
*   CHECK BRANCH IS ALREADY ENTER.
/*************************************************************************************************************/        
function checkDuplicate(obj,chkRoundTrip)
{       
    if(chkRoundTrip.checked == false)
    {
        var gvTripRoute = document.getElementById("ctl00_MyCPH1_gvTripRoute"); 
        var rows, Prefix;
        var chkSelect, txtbranchname; 
            if(gvTripRoute != null)
            {
                rows = gvTripRoute.rows.length;                  
                for(i=0;i<rows-3;i++)
                {
                    j = i+3;             
                    if (j<10)
                    {          
                    if (j==3)
                    {
                        continue;
                    }            
                    Prefix = "ctl00_MyCPH1_gvTripRoute_ctl0"+ j;                               
                }
                else
                {
                    Prefix = "ctl00_MyCPH1_gvTripRoute_ctl"+ j;                                             
                }
                chkSelect = document.getElementById(Prefix +"_chkSelect");
                txtbranchname = document.getElementById(Prefix +"_txtbranchname");    
                if (chkSelect.checked == true && obj.id != Prefix+"_txtbranchname")
                {
                    if(txtbranchname.value == obj.value && txtbranchname.value != "")
                    {
                        alert("Branch name already enter.");  
                        obj.focus();  
                        obj.value = "";
                        return false;
                    }
                }
            }
        }
        return true;
    }
}   
/*************************************************************************************************************/
  
/*************************************************************************************************************
*   IF CHECK ANY CHECK BOX CALCULATE TOTAL KM
/*************************************************************************************************************/   
function totalDistance()
{
 
      var gvTripRoute = document.getElementById("ctl00_MyCPH1_gvTripRoute"); 
      var txtDistance = document.getElementById("ctl00_MyCPH1_txtDistance");
      var hiddentxtdist = document.getElementById("ctl00_MyCPH1_hiddentxtdist");  
      var rows, Prefix;
      var chkSelect, txtRowDistance; 
        if(gvTripRoute != null)
        {
            rows = gvTripRoute.rows.length;           
            txtDistance.value = 0;
            
              for(i=0;i<rows-3;i++)
              {
                    j = i+3;             
              
                    if (j<10)
                    {          
                        if (j==3)
                        {
                            continue;
                        }            
                        Prefix = "ctl00_MyCPH1_gvTripRoute_ctl0"+j;                               
                    }
                    else
                    { 
                        Prefix = "ctl00_MyCPH1_gvTripRoute_ctl"+j;                                             
                    }
                
                    chkSelect = document.getElementById(Prefix +"_chkSelect");
                    txtRowDistance = document.getElementById(Prefix +"_txtDistance");    
                    if (chkSelect.checked == true)
                    {                       
                        if (!isNaN(txtDistance.value))
                        {
                           txtDistance.value = Number(txtDistance.value)+ Number(txtRowDistance.value);
                           hiddentxtdist.value = txtDistance.value; 
                        }
                    }
              }  
         }  
}
/*************************************************************************************************************/

/*************************************************************************************************************
*   IF CHECK ANY CHECK BOX CALCULATE TOTAL HOUR
/*************************************************************************************************************/   
//function totalHour()
//{      
//      var gvTripRoute = document.getElementById("ctl00_MyCPH1_gvTripRoute"); 
//      var txttransithrs = document.getElementById("ctl00_MyCPH1_txttransithrs");
//      var hiddentxtdist = document.getElementById("ctl00_MyCPH1_hiddentxtdist");  
//      var rows, Prefix;
//      var chkSelect, txtttimehr, txtstimehr, txtttimemn, txtstimemn;
//    
//      if(gvTripRoute != null)
//      {
//            rows = gvTripRoute.rows.length;           
//            txttransithrs.value = 0;
//            
//              for(i=0;i<rows-3;i++)
//              {
//                    j = i+3;             
//              
//                    if (j<10)
//                    {          
//                        if (j==3)
//                        {
//                            continue;
//                        }            
//                        Prefix = "ctl00_MyCPH1_gvTripRoute_ctl0"+ j;                               
//                    }
//                    else
//                    { 
//                        Prefix = "ctl00_MyCPH1_gvTripRoute_ctl"+ j;                                             
//                    }
//                
//                    chkSelect = document.getElementById(Prefix +"_chkSelect");
//                         
//                    if (chkSelect.checked == true)
//                    {
//                          txtttimehr = document.getElementById(Prefix+"_txtttimehr"); 
//                          txtstimehr = document.getElementById(Prefix+"_txtstimehr");
//                          txtttimemn = document.getElementById(Prefix+"_txtttimemn"); 
//                          txtstimemn = document.getElementById(Prefix+"_txtstimemn");
//                          
//                          txttransithrs.value = Number(txttransithrs.value)+ Number(txtttimehr.value)+ Number(txtstimehr.value)+(Number(txtttimemn.value))/60 +(Number(txtstimemn.value))/60;                       
//                     }
//              }  
//       }   
//}
function totalHour()
{      
    var gvTripRoute = document.getElementById("ctl00_MyCPH1_gvTripRoute"); 
    var txttransithrs = document.getElementById("ctl00_MyCPH1_txttransithrs");
    var hiddentxtdist = document.getElementById("ctl00_MyCPH1_hiddentxtdist");  
    var rows, Prefix;
    var chkSelect, txtttimehr, txtstimehr, txtttimemn, txtstimemn;
    var thour = 0;
    var tmin = 0;
                
    if(gvTripRoute != null)
    {
        rows = gvTripRoute.rows.length;           
        //txttransithrs.value = 0;
        for(i=0;i<rows-2;i++)
        {
            j = i+3;             

            if (j<10)
            {          
                if (j==3)
                {
                    continue;
                }            
                Prefix = "ctl00_MyCPH1_gvTripRoute_ctl0"+ j;                               
            }
            else
            { 
                Prefix = "ctl00_MyCPH1_gvTripRoute_ctl"+ j;                                             
            }

            chkSelect = document.getElementById(Prefix +"_chkSelect");

            if (chkSelect.checked == true)
            {
                txtttimehr = document.getElementById(Prefix+"_txtttimehr"); 
                txtstimehr = document.getElementById(Prefix+"_txtstimehr");
                txtttimemn = document.getElementById(Prefix+"_txtttimemn"); 
                txtstimemn = document.getElementById(Prefix+"_txtstimemn");

                thour = parseFloat(thour) +  parseFloat(txtttimehr.value) + parseFloat(txtstimehr.value);
                tmin = parseFloat(tmin) +  parseFloat(txtttimemn.value) + parseFloat(txtstimemn.value);
            }
        }
    }   
    var totTransitHr="";
    var totTransitMin="";
    
    totTransitHr = parseInt(thour) + parseInt((parseInt(tmin) / 60));
    totTransitMin = (parseInt(tmin) % 60);
    
    txttransithrs.value = totTransitHr + "." + totTransitMin;
}
/*************************************************************************************************************/


/*************************************************************************************************************
*   FOOTER TOTAL 
/*************************************************************************************************************/   
//function footerTotal()
//{
//        var gvTripRoute = document.getElementById("ctl00_MyCPH1_gvTripRoute");
//        var rows;
//        var Prefix, fPrefix;
//        var chkSelect, txtttimehr, txtttimemn, txtstimehr, txtstimemn;  
//        if(gvTripRoute != null)
//        {          
//            rows = gvTripRoute.rows.length+1;  
//            
//             if (rows < 10)
//                fPrefix = "ctl00_MyCPH1_gvTripRoute_ctl0"+rows;
//             else
//                fPrefix = "ctl00_MyCPH1_gvTripRoute_ctl"+rows;
//                
//            
//            var ftxtthtotal = document.getElementById(fPrefix+"_txtthtotal"); 
//            var ftxttmtotal = document.getElementById(fPrefix+"_txttmtotal");
//            var ftxtshtotal = document.getElementById(fPrefix+"_txtshtotal");
//            var ftxtsmtotal = document.getElementById(fPrefix+"_txtsmtotal");
//            
//            
//            ftxtthtotal.value = 0;
//            ftxttmtotal.value = 0;
//            ftxtshtotal.value = 0;
//            ftxtsmtotal.value = 0;
//                
//            for(i=0;i<rows - 3;i++)
//            {
//                j = i+3;             
//                if (j<10)
//                {          
//                    if (j==3)
//                    {
//                        continue;
//                    }            
//                    Prefix = "ctl00_MyCPH1_gvTripRoute_ctl0"+ j;                               
//                }
//                else
//                { 
//                    Prefix = "ctl00_MyCPH1_gvTripRoute_ctl"+ j;                                             
//                }
//                chkSelect = document.getElementById(Prefix +"_chkSelect");
//                if (chkSelect.checked == true)
//                {  
//                    txtttimehr = document.getElementById(Prefix+"_txtttimehr");
//                    txtttimemn = document.getElementById(Prefix+"_txtttimemn");  
//                    txtstimehr = document.getElementById(Prefix+"_txtstimehr");
//                    txtstimemn = document.getElementById(Prefix+"_txtstimemn"); 
//                    
//                    ftxtthtotal.value = Number(ftxtthtotal.value)+ Number(txtttimehr.value);
//                    ftxttmtotal.value = Number(ftxttmtotal.value)+ Number(txtttimemn.value);
//                    ftxtshtotal.value = Number(ftxtshtotal.value)+ Number(txtstimehr.value);
//                    ftxtsmtotal.value = Number(ftxtsmtotal.value)+ Number(txtstimemn.value);     
//                }  
//            }
//        }                    
//}
function footerTotal()
{
        var txtDistance = document.getElementById("ctl00_MyCPH1_txtDistance");
        var txttransithrs = document.getElementById("ctl00_MyCPH1_txttransithrs");
//        var txtSchHH = document.getElementById("ctl00_MyCPH1_txtSchHH");
//        var txtSchMM = document.getElementById("ctl00_MyCPH1_txtSchMM");
    
        var gvTripRoute = document.getElementById("ctl00_MyCPH1_gvTripRoute");
        var rows;
        var Prefix, fPrefix;
        var chkSelect, txtttimehr, txtttimemn, txtstimehr, txtstimemn,txtDistTotal,txtdistance;  
        if(gvTripRoute != null)
        {          
            rows = gvTripRoute.rows.length+1;  
            
             if (rows < 10)
                fPrefix = "ctl00_MyCPH1_gvTripRoute_ctl0"+rows;
             else
                fPrefix = "ctl00_MyCPH1_gvTripRoute_ctl"+rows;
                
            
            var ftxtthtotal = document.getElementById(fPrefix+"_txtthtotal"); 
            var ftxttmtotal = document.getElementById(fPrefix+"_txttmtotal");
            var ftxtshtotal = document.getElementById(fPrefix+"_txtshtotal");
            var ftxtsmtotal = document.getElementById(fPrefix+"_txtsmtotal");
            var ftxtDistTotal = document.getElementById(fPrefix+"_txtDistTotal");
            
            
            ftxtthtotal.value = 0;
            ftxttmtotal.value = 0;
            ftxtshtotal.value = 0;
            ftxtsmtotal.value = 0;
            ftxtDistTotal.value = 0;
                
            for(i=0;i<rows - 3;i++)
            {
                j = i+3;             
                if (j<10)
                {          
                    if (j==3)
                    {
                        continue;
                    }            
                    Prefix = "ctl00_MyCPH1_gvTripRoute_ctl0"+ j;                               
                }
                else
                { 
                    Prefix = "ctl00_MyCPH1_gvTripRoute_ctl"+ j;                                             
                }
                chkSelect = document.getElementById(Prefix +"_chkSelect");
                if (chkSelect.checked == true)
                {  
                    txtttimehr = document.getElementById(Prefix+"_txtttimehr");
                    txtttimemn = document.getElementById(Prefix+"_txtttimemn");  
                    txtstimehr = document.getElementById(Prefix+"_txtstimehr");
                    txtstimemn = document.getElementById(Prefix+"_txtstimemn"); 
                    txtdistance = document.getElementById(Prefix+"_txtdistance"); 
                    
                    
                    ftxtthtotal.value = Number(ftxtthtotal.value)+ Number(txtttimehr.value);
                    ftxttmtotal.value = Number(ftxttmtotal.value)+ Number(txtttimemn.value);
                    ftxtshtotal.value = Number(ftxtshtotal.value)+ Number(txtstimehr.value);
                    ftxtsmtotal.value = Number(ftxtsmtotal.value)+ Number(txtstimemn.value);  
                    ftxtDistTotal.value = Number(ftxtDistTotal.value)+ Number(txtdistance.value);    
                    
                    
                    txtDistance.value = ftxtDistTotal.value;
                    txttransithrs.value = ftxtthtotal.value;
//                    txtSchHH.value = ftxtshtotal.value;
//                    txtSchMM.value = ftxtsmtotal.value;
         
                }  
            }
        }                    
}
/*************************************************************************************************************/
      
var enterflag=false;
function enterflagtrue()
{   
    enterflag=true;
}
function enterflagfalse()
{    
    enterflag=false;
}
function disableenter()
{    
    if (enterflag == false) 
    {
        if (window.event.keyCode == 13)
        {
            event.returnValue=false;
            event.cancel = true;          
            return false;
        }
    }
    else
    {
        enterflag=false;
    }
}        
     
/*************************************************************************************************************
*   VALIDATION FOR ALL INPUT WHEN SUBMIT BUTTON CLICK
/*************************************************************************************************************/             
function btnSubmitCheck()
{         
    var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");            
    if(hdnajaxstate.value != "0")
    {
        alert("Let the Internal Processes Over. Please wait 5-10 seconds or LogOut.");
        return false;
    }
    var txtSchHH = document.getElementById("ctl00_MyCPH1_txtSchHH");   
    if(txtSchHH.value == "")
    {
        alert("Please Enter Valid Hour.");
        txtSchHH.focus();
        return false;
    }       
    var txtSchMM = document.getElementById("ctl00_MyCPH1_txtSchMM");  
    if(txtSchMM.value == "")
    {
        alert("Please Enter Valid Minutes.");
        txtSchMM.focus();
        return false;
    }
    var txtStandRate = document.getElementById("ctl00_MyCPH1_txtStandRate");   
    if(txtStandRate!=null)
    {
        if(txtStandRate.value == "")
        {
            alert("Please Enter Valid Standard Rate.");
            txtStandRate.focus();
            return false;
        }
    }
    var txtCity = document.getElementById("ctl00_MyCPH1_txtCity");  
    if(txtCity.value == "")
    {
        alert("Please Enter Valid Location.");
        txtCity.focus();
        return false;
    }
    
    if(checkBranch() == false)
    { 
       return false;
    }
    if(!confirm("Are you sure you want to Submit this Record ?")) 
    {
        return false;
    }               
    return true;         
}

function btnAddRows()
{
        var TxtRows = document.getElementById("ctl00_MyCPH1_TxtRows");  
        if(TxtRows.value == "")
        {
                alert("Please Enter Number of rows.");
                TxtRows.focus();
                return false;
        }
        else
        {
            if(parseInt(TxtRows.value) < 0)
            {
                alert("Please Enter Positive Number.");
                TxtRows.focus();
                return false;
            }
        }
        return true;
}
/*************************************************************************************************************
*   Fill Route Description 
/*************************************************************************************************************/             
function FillRouteDesc(txtbranchname,txtRouteDesc)
{
    var tmp="";
    var gvTripRoute = document.getElementById("ctl00_MyCPH1_gvTripRoute"); 
    var rows, Prefix;
    if(gvTripRoute != null)
    {
        rows = gvTripRoute.rows.length;                  
        for(i=0;i<rows-2;i++)
        {
            j = i+3;             
            if (j<10)
            {          
                if (j==3)
                {
                    continue;
                }            
                Prefix = "ctl00_MyCPH1_gvTripRoute_ctl0"+ j;                               
            }
            else
            { 
                Prefix = "ctl00_MyCPH1_gvTripRoute_ctl"+ j;                                             
            }
            txtbranchname = document.getElementById(Prefix +"_txtbranchname");   
            if(txtbranchname.value != "")
            {
                if(tmp == "")
                {
                    tmp = txtbranchname.value;
                }
                else
                {
                    tmp = tmp + "~" + txtbranchname.value;
                }
            }
        } 
    }  
    txtRouteDesc.value = tmp;
    return true;
}
/*************************************************************************************************************
*   POP UP for Controlling Branch (city)
/*************************************************************************************************************/ 
function nwOpen(mNo)
{
    window.open("popupbranch.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
}
</script>
   
    <asp:Panel runat="server" HorizontalAlign="left" Style="width: 10in" ID="pnlMain">
        <br />
        <asp:Table ID="tblMain" runat="server" HorizontalAlign="center" CssClass="boxbg"
            CellSpacing="1" BorderWidth="0" Width="100%" BorderStyle="Groove">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="center" ColumnSpan="6" CssClass="blackfnt" Style="height: 20px;">
                    <b>TRIP ROUTE MASTER</b></asp:TableCell>
                </asp:TableRow>
            
            <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                <asp:TableCell HorizontalAlign="left">
                  Trip Route Code 
                </asp:TableCell> 
                <asp:TableCell Style="height: 24px;" HorizontalAlign="left">
                   <asp:Label ID="lblRouteCode" runat="server" CssClass="redfnt">&lt;System Generated&gt;</asp:Label>
                </asp:TableCell>
                <asp:TableCell Style="height: 24px" HorizontalAlign="left" ColumnSpan="2">
                    Route Description</asp:TableCell>
                <asp:TableCell ColumnSpan="2" Style="height: 24px; width: 298px" HorizontalAlign="left">
                    <asp:TextBox ID="txtRouteDesc" Width="400px" runat="server"></asp:TextBox>
                </asp:TableCell>
            </asp:TableRow>
            
          
            
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="left" Style="height: 24px; width: 150px;">
                    Route Mode 
                </asp:TableCell>
                <asp:TableCell Style="width: 160px; height: 24px;">
                    <asp:DropDownList ID="ddlRouteMode" runat="server" Width="100px" CssClass="blackfnt">
                        <asp:ListItem Value="S">Road</asp:ListItem>
                        <asp:ListItem Value="R">Rail</asp:ListItem>
                        <asp:ListItem Value="A">Air</asp:ListItem>
                    </asp:DropDownList>
                </asp:TableCell>
             
                <asp:TableCell  HorizontalAlign="left" Style="width: 310px; height: 24px;">
                   Dist.(Km) 
                 
                  </asp:TableCell>
                    <asp:TableCell  Style="height: 24px; width: 298px" HorizontalAlign="left">
                    <asp:TextBox ID="txtDistance" BorderStyle="Groove" CssClass="blackfnt" ReadOnly="false"
                        Text="0" runat="server" Width="68px"></asp:TextBox>
                   
                 
                    <asp:HiddenField ID="hiddentxtdist" runat="server" />
                </asp:TableCell>
                <asp:TableCell  Style="height: 24px; width: 100px" HorizontalAlign="left">
                Transit Time
                </asp:TableCell>
                 <asp:TableCell  Style="height: 24px; width: 298px" HorizontalAlign="left">
                   <asp:TextBox ID="txttransithrs" BorderStyle="Groove" CssClass="blackfnt" runat="server"
                         Text="0" Width="68px"></asp:TextBox>
                            </asp:TableCell>
            </asp:TableRow>
            
            
            
            <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                <asp:TableCell HorizontalAlign="left">
                  Controlling Location
                </asp:TableCell>
                <asp:TableCell Style="height: 24px;" HorizontalAlign="left">
              
                    <asp:TextBox ID="txtCity" onblur="javascript:return checkLocation(this.getAttribute('id'), 'TRUE')"
                        runat="server" BorderStyle="Groove" Width="100px" CssClass="blackfnt" autocomplete="true" ></asp:TextBox>
                         <asp:Label ID="Label4" runat="server" BorderStyle="Groove" Text='<a href="javascript:nwOpen(1)">...</a>'
                        Width="14px" TabIndex="18"></asp:Label>
                        
                         <ajaxToolkit:AutoCompleteExtender
                                          
                              runat="server" 
                        BehaviorID="AutoCompleteEx1"
                        ID="autoComplete1" 
                        TargetControlID="txtCity"
                        ServicePath="../../../services/FleetAutoComplet.asmx" 
                        ServiceMethod="GetLocationName"
                        MinimumPrefixLength="1" 
                        CompletionInterval="1000"
                        EnableCaching="true"
                        CompletionSetCount="20"
                        CompletionListCssClass="autocomplete_completionListElement" 
                        CompletionListItemCssClass="autocomplete_listItem" 
                        CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                        DelimiterCharacters=";, :"
                        ShowOnlyCurrentWordInCompletionListItem="true" >
                        
                   <Animations>
                    <OnShow>
                        <Sequence>
                            <%-- Make the completion list transparent and then show it --%>
                            <OpacityAction Opacity="0" />
                            <HideAction Visible="true" />
                            
                            <%--Cache the original size of the completion list the first time
                                the animation is played and then set it to zero --%>
                            <ScriptAction Script="
                                // Cache the size and setup the initial size
                                var behavior = $find('AutoCompleteEx1');
                                if (!behavior._height) {
                                    var target = behavior.get_completionList();
                                    behavior._height = target.offsetHeight - 2;
                                    target.style.height = '0px';
                                }" />
                            
                            <%-- Expand from 0px to the appropriate size while fading in --%>
                            <Parallel Duration=".4">
                                <FadeIn />
                                <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx1')._height" />
                            </Parallel>
                        </Sequence>
                    </OnShow>
                    <OnHide>
                        <%-- Collapse down to 0px and fade out --%>
                        <Parallel Duration=".4">
                            <FadeOut />
                            <Length PropertyKey="height" StartValueScript="$find('AutoCompleteEx1')._height" EndValue="0" />
                        </Parallel>
                    </OnHide>
                </Animations>
                </ajaxToolkit:AutoCompleteExtender>
                </asp:TableCell>
                <asp:TableCell Style="height: 24px" HorizontalAlign="left" ColumnSpan="2">
                    Departure time from starting Location (24 Hour Format)</asp:TableCell>
                <asp:TableCell ColumnSpan="2" Style="height: 24px; width: 298px" HorizontalAlign="left">
                    <asp:TextBox ID="txtSchHH" MaxLength="2" onblur="checkDecimal(this.getAttribute('id'), 'TRUE')"
                        BorderStyle="Groove" CssClass="blackfnt" onkeypress="javascript:return validInt(event);"
                        runat="server" Width="20px"></asp:TextBox>&nbsp; :
                    <asp:TextBox ID="txtSchMM" MaxLength="2" onblur="checkDecimal(this.getAttribute('id'), 'TRUE')"
                        CssClass="blackfnt" BorderStyle="Groove" onkeypress="javascript:return validInt(event);"
                        runat="server" Width="20px" />(HH : MM)
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtSchHH"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                </asp:TableCell>
            </asp:TableRow>
            
            
             <asp:TableRow  Width="100%" CssClass="bgwhite" VerticalAlign="Middle">
               
                <asp:TableCell Style="height: 24px;" HorizontalAlign="left">
                        <asp:Table ID="Table1" runat="server" Width="150px" BorderWidth="0" CellPadding="0"
                        CellSpacing="0">
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell HorizontalAlign="left" Width="25%">
                            <asp:Label ID="Label3" runat="server" Width="80px"  Text="Round Trip"></asp:Label>
                                  
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left">
                                <asp:CheckBox ID="chkRoundTrip" runat="server" CssClass="blackfnt" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                
                </asp:TableCell>
                 <asp:TableCell HorizontalAlign="left">
                  <asp:Table ID="tblActiveFlag" runat="server" Width="150px" BorderWidth="0" CellPadding="0"
                        CellSpacing="0">
                        <asp:TableRow CssClass="bgwhite">
                            <asp:TableCell HorizontalAlign="left" Width="25%">
                                <asp:Label ID="Label2" runat="server" Width="75px"  Text="Active Flag"></asp:Label>
                                
                            </asp:TableCell>
                            <asp:TableCell HorizontalAlign="left">
                                <asp:CheckBox ID="chkActiveFlag" runat="server" CssClass="blackfnt" Checked="True" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                
                </asp:TableCell>
                <asp:TableCell Style="height: 24px" HorizontalAlign="left" ColumnSpan="2">
                   </asp:TableCell>
                <asp:TableCell ColumnSpan="2" Style="height: 24px; width: 298px" HorizontalAlign="left">
                   
                </asp:TableCell>
            </asp:TableRow>
            
            <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                <asp:TableCell HorizontalAlign="left">
                   </asp:TableCell>
                <asp:TableCell HorizontalAlign="left">
                 </asp:TableCell>
                <asp:TableCell HorizontalAlign="left">
                     </asp:TableCell>
                <asp:TableCell HorizontalAlign="left">
                 
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left" VerticalAlign="Middle" ColumnSpan="2">
                    
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle" Height="25px">
                <asp:TableCell HorizontalAlign="center" ColumnSpan="6">
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgbluegrey" VerticalAlign="Middle">
                <asp:TableCell HorizontalAlign="center" ColumnSpan="6">
                    <asp:Label ID="label1" runat="server" Font-Bold="true" CssClass="blackfnt" Text="Enter Number Of Rows "></asp:Label>&nbsp;
                    <asp:TextBox ID="TxtRows" runat="server" BorderStyle="Groove" MaxLength="2" CssClass="blackfnt"
                        onkeypress="javascript:return validInt(event);" Width="44px"></asp:TextBox>
                    <asp:Button ID="CmdAddRows" CausesValidation="false" OnClientClick="Javascript:return btnAddRows();" CssClass="blackfnt" runat="server"
                        OnClick="CmdAddRows_Click" Text="Add Rows" Width="80px" />
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle" ID="trGvRoute" runat="server">
                <asp:TableCell HorizontalAlign="center" ColumnSpan="6">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                            <asp:GridView ShowFooter="true" ID="gvTripRoute" BorderWidth="0" CellSpacing="1"
                                runat="server" AutoGenerateColumns="false" Width="100%" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey"
                                FooterStyle-CssClass="bgwhite" OnRowCreated="gvTripRoute_RowCreated" OnRowDataBound="gvTripRoute_RowDataBound"
                                PagerSettings-Mode="NumericFirstLast" PageSize="10" SelectedIndex="1">
                                <Columns>
                                    <asp:TemplateField HeaderText="Select" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkSelect" CssClass="blackfnt" runat="server" />
                                            <asp:HiddenField ID="hdfRutNo" Value="" runat="server" />
                                            <asp:HiddenField ID="hdfRutCode" Value="" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="City Name" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtbranchname" BorderStyle="Groove" runat="server" CssClass="blackfnt"
                                                MaxLength="50"></asp:TextBox>
                                                   
                                                <ajaxToolkit:AutoCompleteExtender
                                                runat="server" 
                                                ID="extLocation" 
                                                TargetControlID="txtbranchname"
                                                ServicePath="../../../services/FleetAutoComplet.asmx" 
                                                ServiceMethod="GetLocationCode"
                                                MinimumPrefixLength="1" 
                                                CompletionInterval="1000"
                                                EnableCaching="true"
                                                CompletionSetCount="20"
                                                CompletionListCssClass="autocomplete_completionListElement" 
                                                CompletionListItemCssClass="autocomplete_listItem" 
                                                CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                                DelimiterCharacters=";, :"
                                                ShowOnlyCurrentWordInCompletionListItem="true" >
                                             <%--   <Animations>
                                                <OnShow>
                                                <Sequence>
                                                <OpacityAction Opacity="0" />
                                                <HideAction Visible="true" />

                                                <ScriptAction Script="
                                                // Cache the size and setup the initial size
                                                var behavior = $find('AutoCompleteExB');
                                                if (!behavior._height) {
                                                var target = behavior.get_completionList();
                                                behavior._height = target.offsetHeight - 2;
                                                target.style.height = '0px';
                                                }" />

                                                <Parallel Duration=".4">
                                                <FadeIn />
                                                <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteExB')._height" />
                                                </Parallel>
                                                </Sequence>
                                                </OnShow>
                                                <OnHide>
                                                <Parallel Duration=".4">
                                                <FadeOut />
                                                <Length PropertyKey="height" StartValueScript="$find('AutoCompleteExB')._height" EndValue="0" />
                                                </Parallel>
                                                </OnHide>
                                                </Animations>--%>
                                                </ajaxToolkit:AutoCompleteExtender>
                                         
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:Label ID="lbltotal" runat="server" CssClass="blackfnt" Text="Total" Font-Bold="true"></asp:Label>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Dist (In Km)" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtdistance" Text="0"  runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                                MaxLength="100"></asp:TextBox>                                            
                                        </ItemTemplate>
                                         <FooterTemplate>
                                            <asp:TextBox runat="server" Text="0" ID="txtDistTotal" CssClass="blackfnt" BorderStyle="Groove"
                                                ReadOnly="true"></asp:TextBox>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="(Hours)" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtttimehr" Text="0"  runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                                MaxLength="4"></asp:TextBox>                                           
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox runat="server" Text="0" ID="txtthtotal" CssClass="blackfnt" BorderStyle="Groove"
                                                ReadOnly="true"></asp:TextBox>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="(Min)" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtttimemn" Text="0" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                                MaxLength="2"></asp:TextBox>                                            
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox runat="server" Text="0" ID="txttmtotal" CssClass="blackfnt" BorderStyle="Groove"
                                                ReadOnly="true"></asp:TextBox>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="(Hours)" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtstimehr" Text="0" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                                MaxLength="4"></asp:TextBox>                                           
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox runat="server" Text="0" ReadOnly="true" CssClass="blackfnt" BorderStyle="Groove"
                                                ID="txtshtotal"></asp:TextBox>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="(Mins)" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtstimemn" Text="0" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                                MaxLength="2"></asp:TextBox>                                           
                                        </ItemTemplate>
                                        <FooterTemplate>
                                            <asp:TextBox runat="server" Text="0" ReadOnly="true" CssClass="blackfnt" BorderStyle="Groove"
                                                ID="txtsmtotal"></asp:TextBox>
                                        </FooterTemplate>
                                    </asp:TemplateField>
                                      <asp:TemplateField HeaderText="Obward/Return" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlOnwardReturn" runat="server">
                                            <%--<asp:ListItem Text="Select" Value="0" />--%>
                                            <asp:ListItem Text="Onward" Value="Onward" />
                                            <asp:ListItem Text="Return" Value="Return" />
                                            </asp:DropDownList>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="CmdAddRows" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgbluegrey" VerticalAlign="Middle" ID="trBtnSubmit" runat="server">
                <asp:TableCell HorizontalAlign="center" ColumnSpan="6">
                    <asp:Button ID="btnSubmit" CssClass="blackfnt" runat="server" Text="Update Route Master"
                        OnClientClick="Javascript:return btnSubmitCheck();" OnClick="btnSubmit_Click" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <br />    
        <asp:HiddenField ID="hdnajaxstate" runat="server" Value="0" />
        <div id="divDate" style="position: absolute; visibility: hidden; background-color: white;
            z-index: 99;">
        </div>
        <asp:UpdateProgress ID="uppMain" runat="server">
            <ProgressTemplate>
                <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                    -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                    <tr>
                        <td align="right">
                            <img src="../../images/loading.gif" alt="" />
                        </td>
                        <td>
                            <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                        </td>
                    </tr>
                </table>
                <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                    background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                    opacity: .50; -moz-opacity: .50;" runat="server">
                    <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                        left: 50%;" ID="Panel2" runat="server">
                    </asp:Panel>
                </asp:Panel>
            </ProgressTemplate>
        </asp:UpdateProgress>
    </asp:Panel>
</asp:Content>
