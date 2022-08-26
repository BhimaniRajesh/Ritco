<%@Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master" CodeFile="UpdateJob.aspx.cs" Inherits="GUI_Fleet_Job_PrepareJob" %>
<%@Register TagPrefix="SControls" TagName="DateSelector" src="~/LED/DateSelector.ascx" %>
<%@ Register
    Assembly="AjaxControlToolkit"
    Namespace="AjaxControlToolkit"
    TagPrefix="ajaxToolkit" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >

    <script src="../../images/DateControl.js" language="javascript"  type="text/javascript"></script>
    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"> </script>
 
    <script language="javascript" type="text/javascript">
    function nwOpen(mNo)
    {
        //window.open("/ERP.NET/GUI/Fleet/Webadmin/Driver/PopupVehicleNo.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        window.open("Popup-Vehicle.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
    }
   function CheckVehicleNo(txtVehicleNo,lblCategory,lblMfg,lblModel,lblError,txtKMReading)
    {
        var currentTime = new Date()    
        if(txtVehicleNo.value == "")
        {
            lblCategory.value = "";
            lblMfg.value = "";
            lblModel.value = "";
            lblError.innerText = "";
            txtKMReading.value="";
        }
        createXMLHttpRequest();
        if (xmlHttpRequest)
        {
            xmlHttpRequest.onreadystatechange = function()
            {
                if (xmlHttpRequest.readyState == 4)
                {
                    var returnValue=xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "Y") 
                    {
                        if (returnValue[2] != "Available") 
                        {
                            txtKMReading.value="";
                            lblCategory.value = "";
                            lblMfg.value = "";
                            lblModel.value = "";
                            lblError.innerText = "Vehicle is In Transit !!!";
                            txtVehicleNo.focus();
                            return false;
                        }
                        else
                        {
                            lblError.innerText="";
                            txtKMReading.value=returnValue[1];
                            txtVehicleNo.value = txtVehicleNo.value;
                            lblMfg.value = returnValue[3];
                            lblModel.value = returnValue[4];
                            lblCategory.value = returnValue[5];
                            //Session("Type_Code") = returnValue[6];
                        }
                    }
                    else
                    {
                        txtKMReading.value="";
                        lblCategory.value = "";
                        lblMfg.value = "";
                        lblModel.value = "";
                        lblError.innerText = "Invalid Vehicle Number !!!";
                        txtVehicleNo.focus();
                        return false;
                    }
                }
            }
            xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckVehicleNo&datetime="+currentTime+"&VehNo=" + txtVehicleNo.value, false);
            xmlHttpRequest.send(null);
        }
    }
    function  calculate()
    {
        var totHrs="0.00",totcost="0.00";
        var mtotHrs="0.00",mtotcost="0.00";
        var grid=document.getElementById("ctl00_MyCPH1_DataGrid1");
        var r=grid.rows.length;
        for(k=0;k<r-1;k++)
        {  
            j=k+2
            var pref="";
            if(j<10)
            {
                pref = "ctl00_MyCPH1_DataGrid1_ctl0" + j + "_";
            }                                       
            else
            {         
                pref = "ctl00_MyCPH1_DataGrid1_ctl" + j + "_";
            }    
            if(document.getElementById(pref + "txtEstHrs")!=null)
            {
                var EstHrs= document.getElementById(pref + "txtEstHrs") 
                if(EstHrs.value!=""  )
                {
                    totHrs=parseFloat(totHrs)+parseFloat(EstHrs.value);
                }
            }
            if(document.getElementById(pref + "txtEstCost")!=null)
            {
                var EstCost= document.getElementById(pref + "txtEstCost") 
                if(EstCost.value!="")
                {
                    totcost=parseFloat(totcost)+parseFloat(EstCost.value);
                }
            }

            mtotHrs=parseFloat(totHrs);
            mtotcost=parseFloat(totcost);
        }
        document.getElementById("ctl00_MyCPH1_txttotEstHrs").value= totHrs;       
        document.getElementById("ctl00_MyCPH1_txttotEstCost").value=totcost; 
        document.getElementById("ctl00_MyCPH1_txtTotalEstimatedLabHours").value= totHrs;       
        document.getElementById("ctl00_MyCPH1_txtTotalEstimatedLabCost").value=totcost;     
    }
    function OnPartDescCalculate(txtQty,txtCostUnit,txtCost)
    {
        if(txtQty.value!="" && txtCostUnit.value!="")
        {
            txtCost.value=parseFloat(txtQty.value) * parseFloat(txtCostUnit.value);
            calculateSpare();
        }
    }
    function calculateSpare()
    {
        var mtotcost="0.00";
        var dgSpare=document.getElementById("ctl00_MyCPH1_dgSpare");
        if(dgSpare != null)
        {
            var r=dgSpare.rows.length;
            for(k=0;k<r-1;k++)
            {  
                j=k+2
                var pref="";
                if(j<10)
                {
                    pref = "ctl00_MyCPH1_dgSpare_ctl0" + j + "_";
                }                                       
                else
                {         
                    pref = "ctl00_MyCPH1_dgSpare_ctl" + j + "_";
                }    
                if(document.getElementById(pref + "txtCost")!=null)
                {
                    var EstCost= document.getElementById(pref + "txtCost") 
                    if(EstCost.value!="")
                    {
                        mtotcost=parseFloat(mtotcost)+parseFloat(EstCost.value);
                    }
                }
                mtotcost=parseFloat(mtotcost);
            }
        }
        document.getElementById("ctl00_MyCPH1_txtTotalPartCost").value=mtotcost;  
        document.getElementById("ctl00_MyCPH1_txtTotalEstimated").value=parseFloat(mtotcost)+parseFloat(document.getElementById("ctl00_MyCPH1_txtTotalEstimatedLabCost").value);  
        
    }
    function validFloat(event,txtid)
    {
        var tb=document.getElementById(txtid);
        var txt=tb.value;
        if(event.keyCode==13)
        {
            return true;
        }
        if(event.keyCode==46)
        {
            if(txt.indexOf('.')!=-1)
            {
                event.keyCode=0;
            }
            if((event.keyCode<46 || event.keyCode>57) || event.keyCode==47)
            {
                event.keyCode=0;
                return false;
            }
        }
    } 

function createXMLHttpRequest()
{
    // Mozilla, Safari,...
    if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
    // IE
    else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
}
function OnTaskDescChange(row_Index,ddlTask,txtTaskType,txtEstHrs,txtEstCost,txtEstLabourHrs)
{
    var currentTime = new Date()    
    var str_Index = "";
    
    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_DataGrid1").rows.length; intIndex++)
    {
        if (intIndex < 10)
        {
            str_Index = "0" + intIndex;
        }
        else
        {
            str_Index = intIndex;
        }
        if (row_Index == intIndex - 2)
        {
            continue;
        }
        if (document.getElementById("ctl00_MyCPH1_DataGrid1_ctl" + str_Index + "_ddlTask").value == ddlTask.value)
        {
            alert("This Part already exist at row " + (intIndex - 1));
            ddlTask.value = "";
            ddlTask.focus();
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
                var returnValue=xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "Y") 
                {
                    txtTaskType.value=returnValue[1];
                    txtEstHrs.value=returnValue[2];
                    if(txtEstLabourHrs.value != "")
                    {
                        txtEstCost.value=parseFloat(txtEstHrs.value) * parseFloat(txtEstLabourHrs.value);
                    }
                    else
                    {
                        txtEstCost.value=parseFloat(txtEstHrs.value) * 0;
                    }
                    calculate();
                    calculateSpare();
                }
                else
                {
                    txtTaskType.value="";
                    txtEstHrs.value="";
                    txtEstCost.value="";
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=OnTaskDescChange&datetime="+currentTime+"&TaskId=" + ddlTask.value, false);
        xmlHttpRequest.send(null);
    }
}

function OnPartDescChange(row_Index,ddlPartNo,txtCostUnit,txtCost,txtSpareRemark)
{
    var currentTime = new Date()    
    var str_Index = "";
    
    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_dgSpare").rows.length; intIndex++)
    {
        if (intIndex < 10)
        {
            str_Index = "0" + intIndex;
        }
        else
        {
            str_Index = intIndex;S
        }
        if (row_Index == intIndex - 2)
        {
            continue;
        }
        if (document.getElementById("ctl00_MyCPH1_dgSpare_ctl" + str_Index + "_ddlPartNo").value == ddlPartNo.value)
        {
            alert("This Part already exist at row " + (intIndex - 1));
            ddlPartNo.value = "";
            ddlPartNo.focus();
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
                var returnValue=xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "Y") 
                {
                    txtCostUnit.value=returnValue[1];
                }
                else
                {
                    txtCostUnit.value="";
                    txtCost.value="";
                    txtSpareRemark.value="";
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=OnPartDescChange&datetime="+currentTime+"&PartId=" + ddlPartNo.value, false);
        xmlHttpRequest.send(null);
    }
}

function check()
{
    var VehicleNo=document.getElementById("ctl00_MyCPH1_txtVehicleNo");
    if(VehicleNo.value=="")
    {
        alert("Please enter the Vehicle No.");
        VehicleNo.focus();
        return false;
    }
    var txtOrderDate=document.getElementById("ctl00_MyCPH1_txtOrderDate");
    if(txtOrderDate.value=="")
    {
        alert("Please enter Job Order Date!");
        txtOrderDate.focus();
        return false;
    }
    var JobCardType=document.getElementById("ctl00_MyCPH1_ddlOrderType");
    if(JobCardType.value=="")
    {
        alert("Please select the Job card type");
        JobCardType.focus();
        return false;
    }
    var SCtype=document.getElementById("ctl00_MyCPH1_ddlSCtype");
    if(SCtype.value=="")
    {
        alert("Please select the Service center type");
        SCtype.focus();
        return false;
    }
    var SCtypeval=document.getElementById("ctl00_MyCPH1_ddlSCtype");
    var WLoc=document.getElementById("ctl00_MyCPH1_ddlWLoc");
    var vendor=document.getElementById("ctl00_MyCPH1_ddlVendor");
    if(SCtypeval.value=="Workshop")
    {
        if(WLoc.value=="")
        {
            alert("Please select the Workshop Location");
            WLoc.focus();
            return false;
        }
    }
    if(SCtypeval.value=="Vendor")
    {
        if(vendor.value=="")
        {
            alert("Please select the Vvendor");
            vendor.focus();
            return false;
        }
    }
    
    var JobOrderDt=document.getElementById("ctl00_MyCPH1_txtOrderDate").value;
    var SendDtDt_WS=document.getElementById("ctl00_MyCPH1_txtDCSendDt_WS_txt_Date");
    
    if(SendDtDt_WS.value=="")
    {
        alert("Please enter Send date to workshop/location")
        SendDtDt_WS.focus();
        return false;
    }
    if(SendDtDt_WS.value.length<10)
    {
        alert("The date format should be : dd/mm/yyyy")
        SendDtDt_WS.focus(); 
        return false
    }
    if(!Date.parse(SendDtDt_WS.value))
    {
        alert("Invalid Send date to workshop/location !!!")
        SendDtDt_WS.focus(); 
        return false
    }
    var mServerDt = ("<%=ServerDt%>"); 
    if(Date.parse(SendDtDt_WS.value)> Date.parse(mServerDt))
    {
       alert("Send date to workshop/location can not be greater than today's date !!!")
       SendDtDt_WS.focus(); 
       return false
    }
    if(Date.parse(SendDtDt_WS.value)< Date.parse(JobOrderDt.innerText))
    {
        alert("Send date to workshop/location can not be less than Job Order date !!!")
        SendDtDt_WS.focus(); 
        return false
    }

 
 
    var EReturnDt_WS=document.getElementById("ctl00_MyCPH1_txtDCReturnDt_WS_txt_Date");
    
    if(EReturnDt_WS.value=="")
    {
        alert("Please enter Estimated return date")
        EReturnDt_WS.focus();
        return false;
    }
    if(EReturnDt_WS.value.length<10)
    {
        alert("The date format should be : dd/mm/yyyy")
        EReturnDt_WS.focus(); 
        return false
    }
    if(!Date.parse(EReturnDt_WS.value))
    {
       alert("Invalid Estimated return date !!!")
       EReturnDt_WS.focus(); 
       return false
    }
    if(Date.parse(EReturnDt_WS.value)< Date.parse(SendDtDt_WS.value))
    {
        alert("Estimated return date can not be less than Send date to workshop/location !!!")
        EReturnDt_WS.focus(); 
        return false
    }
    var txtTotalEstimatedLabHours=document.getElementById("ctl00_MyCPH1_txtTotalEstimatedLabHours");
    if(txtTotalEstimatedLabHours.value == "")
    {
        alert("Enter Estimated Labour Hours !!!")
        txtTotalEstimatedLabHours.focus(); 
        return false;
    }
    var grid=document.getElementById("ctl00_MyCPH1_DataGrid1");
    var r=grid.rows.length;
    var TaksSel=0;
    for(i=0;i<r-1;i++)
    {  
        j=i+2;
        var pref="";
        if(j<10)
        {
            pref = "ctl00_MyCPH1_DataGrid1_ctl0" + j + "_";
        }                                       
        else
        {         
            pref = "ctl00_MyCPH1_DataGrid1_ctl" + j + "_";
        }    

        var mgroup= document.getElementById(pref + "ddlWorkGroup");
        var mtask= document.getElementById(pref + "ddlTask");                      
      
//            if(mSelect.checked==true)
//             { 
        TaksSel=TaksSel+1;             
        if(mgroup.value=="")
        {
            alert("Please select Workgroup")
            document.getElementById(pref + "ddlWorkGroup").focus();
            return false;
        }
                
        if(mtask.value=="")
        {
            alert("Please select Task")
            document.getElementById(pref + "ddlTask").focus();
            return false;
        }
                
            
        var EstHrs= document.getElementById(pref + "txtEstHrs")  
        if(EstHrs.value=="")
        {
            alert("Enter Estimated Labour Hours!!")
            document.getElementById(pref + "txtEstHrs").focus();  
            return false;
        }
        var EstCost= document.getElementById(pref + "txtEstCost")         
        if(EstCost.value=="")
        {
            alert("Enter Estimated Labour Cost!!")
            document.getElementById(pref + "txtEstCost").focus();  
            return false;
        }
    }

    for(i=0;i<r-1;i++)
    {  

        j=i+2
        var pref="";
        if(j<10)
        {
            pref = "ctl00_MyCPH1_DataGrid1_ctl0" + j + "_";
        }                                       
        else
        {         
            pref = "ctl00_MyCPH1_DataGrid1_ctl" + j + "_";
        }  
        var mtask= document.getElementById(pref + "ddlTask");
        for(k1=i+1;k1<r-1;k1++)
        { 
            l1=k1+2
            var tpref="";
            if(l1<10)
            {
                tpref = "ctl00_MyCPH1_DataGrid1_ctl0" + l1 + "_";
            }                                       
            else
            {         
                tpref = "ctl00_MyCPH1_DataGrid1_ctl" + l1 + "_";
            }   
            var TempTask= document.getElementById(tpref + "ddlTask") 
            //alert("TempTask : " + TempTask.value);
            //alert("mtask : " + mtask.value);
            if(TempTask.value==mtask.value)
            {
                alert("Duplicate Task !!!")
                TempTask.focus();
                return false;
            }
        }
    }
    
    if(parseFloat(TaksSel)==0)
    {
        alert("Please select atleast one task to prepare the Job order !!!")
        return false;
    }
        
        // Spare part validation
 
    var dgrid=document.getElementById("ctl00_MyCPH1_dgSpare");
    var r1=dgrid.rows.length;
    j=0;
    for(i=0;i<r1-1;i++)
    {  
        j=i+2
        var pref="";
        if(j<10)
        {
            pref = "ctl00_MyCPH1_dgSpare_ctl0" + j + "_";
        }                                       
        else
        {         
            pref = "ctl00_MyCPH1_dgSpare_ctl" + j + "_";
        }    
        var PartNo= document.getElementById(pref + "ddlPartNo")
        var PartQty= document.getElementById(pref + "txtQty")     
        var PartCost= document.getElementById(pref + "txtCost")                        

        if(PartNo.value=="")
        {
            alert("Please select Part!!")
            document.getElementById(pref + "ddlPartNo").focus();  
            return false;
        }

        if(PartQty.value=="")
        {
            alert("Please enter Part quantity!!")
            document.getElementById(pref + "txtQty").focus();  
            return false;
        }

        if(PartCost.value=="")
        {
            alert("Please enter Part Cost!!")
            return false;
        }

        for(k=i+1;k<r1-1;k++)
        { 
            l=k+2
            var mpref="";
            if(l<10)
            {
                mpref = "ctl00_MyCPH1_dgSpare_ctl0" + l + "_";
            }                                       
            else
            {         
                mpref = "ctl00_MyCPH1_dgSpare_ctl" + l + "_";
            }   
            var TempPartNo= document.getElementById(mpref + "ddlPartNo") 
            var TempPartQty= document.getElementById(mpref + "txtQty")     

            if(TempPartNo.value==PartNo.value)
            {
                alert("Duplicate Part !!!")
                TempPartNo.focus();
                return false;
            }
        }
    }
   //alert("submit");
   //return false;
    }
    function hitme()
    {
        //var shell = new ActiveXObject("WScript.shell");
        //shell.SendKeys("{ENTER}",[10]);
        //shell.Quit;
    }
    var cal = new CalendarPopup("Div1"); 
    cal.setCssPrefix("TEST");
    cal.showNavigationDropdowns();
    
    
    var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");

    var FinYear="<%=Session["FinYear"]%>"
    var FinYear_to=parseInt(FinYear)+1
		
    if(FinYear_to<10)
    {
        FinYear_to="0"+FinYear_to
    }
    var FinYear_fromdate="01/04/"+FinYear
    var FinYear_todate="31/03/"+FinYear_to
    var Sle_finyear=FinYear+"-"+FinYear_to
 
    function ValidateDate(obj)
    {
      if (obj.value!="")
      {
        if (isDate(obj.value)==false)
        {
	        obj.focus();
	        return false;
        }
        return true;
      }
    }
    var dtCh= "/";
    var minYear="1900";
    var maxYear="2100";
    function DaysArray(n) 
    {
        for (var i = 1; i <= n; i++) 
        {
            this[i] = 31
            if (i==4 || i==6 || i==9 || i=="11") {this[i] = 30}
            if (i==2) {this[i] = 29}
        } 
        return this;
    }
   function isDate(dtStr)
   {
	    var daysInMonth = DaysArray(12)
	    var pos1=dtStr.indexOf(dtCh)
	    var pos2=dtStr.indexOf(dtCh,pos1+1)
	    var strDay=dtStr.substring(0,pos1)
	    var strMonth=dtStr.substring(pos1+1,pos2)
	    var strYear=dtStr.substring(pos2+1)
	    strYr=strYear
	    if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	    if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	    for (var i = 1; i <= 3; i++) {
		    if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	    }
    	
	    month=parseInt(strMonth)
	    day=parseInt(strDay)
	    year=parseInt(strYr)
	    if (pos1==-1 || pos2==-1){
		    alert("The date format should be : dd/mm/yyyy")
		    return false
	    }
	    if (strMonth.length<1 || month<1 || month>12){
		    alert("Please enter a valid month")
		    return false
	    }
	    if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
		    alert("Please enter a valid day")
		    return false
	    }
	    if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
		    alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear)
		    return false
	    }
    	 
	    if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
		    alert("Please enter a valid date")
		    return false
	    }
	    return true
    } 
     function stripCharsInBag(s, bag){
	    var i;
        var returnString = "";
        // Search through string's characters one by one.
        // If character is not in bag, append to returnString.
        for (i = 0; i < s.length; i++){   
            var c = s.charAt(i);
            if (bag.indexOf(c) == -1) returnString += c;
        }
        return returnString;
    }
    function isInteger(s){
	    var i;
        for (i = 0; i < s.length; i++){   
            // Check that current character is number.
            var c = s.charAt(i);
            if (((c < "0") || (c > "9"))) return false;
        }
        // All characters are numbers.
        return true;
    }
   </script>
 
 <div id="Div1" style="position: absolute; visibility: hidden; background-color: white;layer-background-color: white; z-index: 99;">
    </div> 
<table cellspacing="1" style="width: 800px ">
        <tr style="background-color: white">
            <td align="left" style="height: 26px">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Prepare Job Order</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
            
                 <td align="right">
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color="red"><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  
         
          </td>      
            
            
            
            
        </tr>
    </table>
            
            <br/>
            <br/>        
     <table  align="center"  cellspacing="2" width="95%" >                                                                    
                                         
                        <tr  align="center"  style="background-color: white">
               
                <td align="center" >
    <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                  
     <table  align="center"  cellspacing="2" width="800px" class="boxbg">                                                                    
                           
                           
                          <tr style="background-color: white">
                        <td colspan="4" align="center">
                             <asp:Label ID="lblError"  runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label> 
                        </td>
                    </tr>                
                        
                           
                               <tr class="bgbluegrey">
                        <td colspan="4" align="center">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Prepare Job Order</asp:Label>
                        </td>
                    </tr>
                           
                                          
                        <tr style="background-color: white">
               
                <td align="left" >
                    <asp:Label ID="Label4" runat="server" CssClass="bluefnt"   Text="Vehicle No."></asp:Label>
                                         
                </td>
                <td align="left" > 
                  <%--OnTextChanged="txtVehNo_TextChanged" AutoPostBack="true" onblur="javascript:hitme()"--%>
                <asp:TextBox ID="txtVehicleNo" runat="server" CssClass="input"   BorderStyle="Groove"  >
                    </asp:TextBox>       <asp:Label ID="lblPopup"     runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen(1)">...</a>'
                                Width="14px"> </asp:Label>
                                    <asp:RequiredFieldValidator ID="ReqtxtVehicleNo" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtVehicleNo"></asp:RequiredFieldValidator>
                               
                                <asp:Label ID="lblCheck" runat="server"  ForeColor="red" Visible="false"/>
            
                    
                </td>
            
                                                       
                             <td align="left" >
                                 <asp:Label ID="Label1" runat="server" Text="Vehicle Category" CssClass="bluefnt"  ></asp:Label>
                               
                                </td>
                            <td  align="left">
                                 <asp:TextBox ID="lblCategory" BorderStyle="None"  runat="server" CssClass="blackfnt" />
                                </td>
                             
                        </tr>
                        
                        
                          <tr style="background-color: white" align="center">
                                                      
                             <td align="left"  >
                                 <asp:Label ID="Label2" runat="server" Text="Manufacturer" CssClass="bluefnt"  />
                               
                                </td>
                            <td align="left" >
                                 <asp:TextBox ID="lblMfg" runat="server" BorderStyle="None"  CssClass="blackfnt" />
                                </td>
                                      <td align="left" >
                                 <asp:Label ID="Label3" runat="server" Text="Model" CssClass="bluefnt"  ></asp:Label>
                               
                                </td>
                            <td align="left" >
                                 <asp:TextBox ID="lblModel" runat="server" BorderStyle="None"   CssClass="blackfnt" />
                                </td>
                             
                        </tr>
                        
                        
                        
                        
                        <tr style="background-color: white" align="center">
                                                    
                             <td align="left"  >
                                 <asp:Label ID="Label5" runat="server" Text="Work Order No" CssClass="bluefnt"  ></asp:Label>
                               
                                </td>
                            <td align="left" >
                            <asp:Label ID="lblDriverCodeVal" runat="server" CssClass="redfnt" Text="Sys. Generated"></asp:Label>
                                 
                             
                                </td>
                                                   
                                      <td align="left" >
                                 <asp:Label ID="Label7" runat="server" Text="Job Order Date" CssClass="bluefnt"  ></asp:Label>
                                </td>
                            <td align="left" >
                                 
                                    <asp:TextBox ID="txtOrderDate" runat="server" onblur="javascript:ValidateDate(this)"
                                BorderStyle="Groove" CssClass="input" MaxLength="10" Width="80px"></asp:TextBox>
                            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtOrderDate,'anchor22','dd/MM/yyyy'); return false;" id="a1" name="anchor22">
                                <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
                                </td>
                             
                        </tr>
                        
                          <tr style="background-color: white" align="center">
                                                    
                             <td align="left"  >
                                 <asp:Label ID="Label9" runat="server" Text="JobCard Type" CssClass="bluefnt"  ></asp:Label>
                               
                                </td>
                            <td align="left" >
                                 <asp:DropDownList ID="ddlOrderType" runat="server" CssClass="blackfnt">
                             </asp:DropDownList>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" Text="!" ControlToValidate="ddlOrderType"></asp:RequiredFieldValidator>
                             
                             
                            <%-- <asp:ListItem Value="" Selected="true">Select</asp:ListItem>
                                    
                                    <asp:ListItem Value="Repair/Breakdown">Repair/Breakdown</asp:ListItem>
                                    <asp:ListItem Value="Manual Preventive Maintainence">Manual Preventive Maintainence</asp:ListItem>
--%>                   
                                </td>
                                                   
                                      <td align="left" >
                                 <asp:Label ID="Label11" runat="server" Text="Order Status" CssClass="bluefnt"  ></asp:Label>
                               
                                </td>
                            <td align="left" >
                                 <asp:Label ID="lblOrderStatus" runat="server" CssClass="blackfnt">
                                 
                             </asp:Label>
                                </td>
                             
                        </tr>
                        
                        
                          <tr style="background-color: white" align="center">
                                                    
                             <td align="left"  >
                                 <asp:Label ID="Label13" runat="server" Text="Service Centre Type " CssClass="bluefnt"  ></asp:Label>
                               
                                </td>
                            <td align="left" >
                                 <asp:DropDownList ID="ddlSCtype" runat="server" Width="100px"  AutoPostBack="true"   CssClass="blackfnt" OnSelectedIndexChanged="ddlSCtype_SelectedIndexChanged">
                                    
                                     <asp:ListItem Value="" Selected="true">-- Select --</asp:ListItem>
                                    
                                    
                                    <asp:ListItem Value="Workshop">Workshop</asp:ListItem>
                                    <asp:ListItem Value="Vendor">Vendor</asp:ListItem>
                                 
                             </asp:DropDownList>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic" Text="!" ControlToValidate="ddlSCtype"></asp:RequiredFieldValidator>
                                </td>
                                                   
                                      <td align="left" >
                                 <asp:Label ID="lblVendor" runat="server" Text="Vendor Name" CssClass="bluefnt" Visible="false"  ></asp:Label>
                                <asp:Label ID="lblWLoc" runat="server" Text="Workshop Location" CssClass="bluefnt" Visible="false"  ></asp:Label>
                                </td>
                            <td align="left" >
                                 <asp:DropDownList ID="ddlVendor" runat="server" CssClass="blackfnt" Visible="false">
                                                              </asp:DropDownList>
                                                              
                                <asp:DropDownList ID="ddlWLoc" runat="server" CssClass="blackfnt" Visible="false"></asp:DropDownList>
                                                              
                                                              
                                </td>
                             
                        </tr>
                        
                        
                        <tr style="background-color: white" align="center">
                                                    
                             <td align="left"  >
                                 <asp:Label ID="Label8" runat="server" Text="Send date to WorkShop " CssClass="bluefnt"  ></asp:Label>
                                </td>
                            <td align="left" nowrap >
                              <%-- <SControls:DateSelector     ID="txtDCSendDt_WS" runat="server" /> --%>
                                  <asp:TextBox ID="txtDCSendDt" runat="server" onblur="javascript:ValidateDate(this)"
                                BorderStyle="Groove" CssClass="input" MaxLength="10" Width="80px"></asp:TextBox>
                            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDCSendDt,'anchor23','dd/MM/yyyy'); return false;" id="a2" name="anchor23">
                                <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
                                
                            </td>
                            
                             <td align="left"  >
                                 <asp:Label ID="Label10" runat="server" Text="Estimated return date " CssClass="bluefnt"  ></asp:Label>
                                </td>
                            <td align="left" nowrap>
                               <%-- <SControls:DateSelector ID="txtDCReturnDt_WS" runat="server" /> --%>
                               <asp:TextBox ID="txtDCReturnDt" runat="server" onblur="javascript:ValidateDate(this)"
                                BorderStyle="Groove" CssClass="input" MaxLength="10" Width="80px"></asp:TextBox>
                            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDCReturnDt,'anchor24','dd/MM/yyyy'); return false;" id="a3" name="anchor24">
                                <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
                            </td>
                        </tr>
                        
                        <tr style="background-color: white" align="center">
                                      <td align="left" >
                                 <asp:Label ID="Label18" runat="server" Text="Starting KM Reading"  CssClass="bluefnt"  ></asp:Label>
                                </td>
                            <td align="left" >
                                 <asp:TextBox ID="txtKMReading" runat="server"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  BorderStyle="None" >
                                 
                             </asp:TextBox>
                             
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtKMReading"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtKMReading" Display="Dynamic"></asp:RegularExpressionValidator>                    
                             
                                </td>
                                
                                                
                                      <td align="left" >
                                 <asp:Label ID="Label12" runat="server" Text="Estimated Labour Hours"  CssClass="bluefnt"  ></asp:Label>
                               
                                </td>
                                <td align="left" >
                                 <asp:TextBox ID="txtEstLabourHrs" runat="server" style="text-align: right" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  BorderStyle="Groove" CssClass="input">
                                 
                             </asp:TextBox>
                             
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtEstLabourHrs"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtKMReading" Display="Dynamic"></asp:RegularExpressionValidator>                    
                             
                                </td>
                                
                                        </tr>
                        <tr style="background-color: white" align="center">
                                                    
                             <td align="left"  >
                                 <asp:Label ID="Label20" runat="server" Text="Total Estimated Labour Hrs"  Font-Bold="true"  CssClass="bluefnt"  ></asp:Label>
                               
                                </td>
                            <td align="left" >
                                 <asp:TextBox ID="txttotEstHrs" runat="server" CssClass="input" style="text-align: right"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))" BorderStyle="Groove" >
                                                              </asp:TextBox>
                                                              
                                                              <%--<asp:RequiredFieldValidator ID="reqtxtEstHrs" runat="server" Display="Dynamic" Text="!" ControlToValidate="txttotEstHrs"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegtxtEstHrs" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txttotEstHrs" Display="Dynamic"></asp:RegularExpressionValidator>                    --%>
                                                              
                                                              
                                </td>
                                                   
                                      <td align="left" >
                                 <asp:Label ID="Label22" runat="server" Text="Total Estimated Labour Cost"  Font-Bold="true" CssClass="bluefnt"  ></asp:Label>
                               
                                </td>
                            <td align="left" >  
                                 <asp:TextBox ID="txttotEstCost" runat="server" CssClass="input"  style="text-align: right"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  BorderStyle="Groove" >
                                 
                             </asp:TextBox>
                             
                               <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" Text="!" ControlToValidate="txttotEstCost"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txttotEstCost" Display="Dynamic"></asp:RegularExpressionValidator>    --%>                
                                                              
                             
                                </td>
                             
                        </tr>
                        
                             
                     
                     </table>
        </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="txtVehicleNo" EventName="TextChanged" />
                <asp:AsyncPostBackTrigger ControlID="ddlSCtype" EventName="SelectedIndexChanged" />
            </Triggers>
        </asp:UpdatePanel>
                     
                                          <br/>
<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <asp:Panel ID="pnlTaskDet" runat="server" Width="100%" >          
    
        <table  cellspacing="1" width="85%"  class="boxbg" border="0">
            <tr class="bgbluegrey">
                <td width="75%" >
                    <asp:Label ID="Label6" CssClass="blackfnt"      Font-Bold="true" runat="server">Task Details</asp:Label>
                   
                </td>
                <td  align="left" width="15%">
                    <asp:Label  CssClass="blackfnt" ID="Label15" runat="server">Enter no. of rows </asp:Label>  
                </td>
                <td  width="5%" >
                    <asp:TextBox ID="txtTaskRow" MaxLength="2" runat=server  Width="20" BorderStyle="Groove"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  Text="0"  AutoPostBack="true" OnTextChanged="txtTaskRow_TextChanged"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegtxtRow" runat="server"
                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                    ControlToValidate="txtRow" Display="Dynamic"></asp:RegularExpressionValidator>
                </td>
                <td  width="5%">
                    <asp:Label ID="lblTaskL" runat="server" Font-Bold="True">Show...</asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>


                    
      <table cellspacing="2"  width="100%" align="center">
        <tr align="center">
            <td align="center">
                        <asp:Panel ID="pblTask" runat="server" >
                        <asp:GridView ID="DataGrid1" runat="server"      OnRowDataBound="DataGrid1_ItemDataBound" 
                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" 
                            HeaderStyle-CssClass="dgHeaderStyle"  PagerStyle-HorizontalAlign="left" OnRowCommand="DataGrid1_RowCommand" >
                            <Columns>
                            
                                 <asp:TemplateField HeaderText="Work Group" >
	                                <ItemTemplate>
	                               	   <asp:Label ID="lblWorkGroup" runat="server"    CssClass="blackfnt"    ></asp:Label>
	                               	   <asp:DropDownList ID="ddlWorkGroup" runat="server"   Width="150px" 
                                            AutoPostBack="True"  CssClass="blackfnt" 
                                            OnSelectedIndexChanged="ddlWorkGroup_SelectedIndexChanged" ></asp:DropDownList> 
                                              <%--SelectedValue='<%# Eval("W_GRPCD") %>'--%>
	                                <asp:RequiredFieldValidator ID="ReqddlWorkGroup" SelectedValue='<%# Eval("W_GRPCD") %>' runat="server" Display="Dynamic" Text="!"  ValidationGroup="Group11" ControlToValidate="ddlWorkGroup"></asp:RequiredFieldValidator>
	                               </ItemTemplate>
	                              </asp:TemplateField>
	                              

	                              <asp:TemplateField HeaderText="Task Description" >
	                                <ItemTemplate>
	                         	        <asp:DropDownList ID="ddlTask" runat="server"   Width="350px" 
                                            CssClass="blackfnt" OnSelectedIndexChanged="ddlTask_SelectedIndexChanged" ></asp:DropDownList>  <%--SelectedValue='<%# Eval("Taskcd") %>'  --%>
	                                </ItemTemplate>
	                              </asp:TemplateField>

	                               <asp:TemplateField HeaderText="Task Type" >
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtTaskType" Text='<%# Eval("TaskType") %>'  MaxLength="10" runat="server"  Width="150px" BorderStyle="None" ></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateField>
	                              
	                              <asp:TemplateField HeaderText="Estimated Labour Hours" >
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtEstHrs" style="text-align: right" MaxLength="10" 
                                            runat="server"  Width="50px" BorderStyle="None" 
                                            Text='<%# Eval("W_EST_LABOUR_HRS") %>' ></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateField>
	                              
	                              
	                               <asp:TemplateField HeaderText="Estimated Labour Cost" >
	                                <ItemTemplate>
	                                    <asp:TextBox ID="txtEstCost" style="text-align: right"  MaxLength="10" 
                                            runat="server"  Width="50px" BorderStyle="None" 
                                            Text='<%# Eval("W_EST_LABOUR_COST") %>' ></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateField>
	                              
	                              
	                              
	                               <asp:TemplateField HeaderText="Remarks" >
	                                <ItemTemplate>
    	                              <asp:TextBox ID="txtRemarks" runat="server" BorderStyle="Groove"   Width="200px" 
                                            CssClass="blackfnt" Text='<%# Eval("T_Remarks") %>'   ></asp:TextBox>
	                                </ItemTemplate>
	                              </asp:TemplateField>
  
                            </Columns>
                      
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
             </asp:Panel>  
            <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender3" runat="Server"
                        TargetControlID="pblTask"
                        CollapsedSize="0"
                        Collapsed="True"
                        ExpandControlID="pnlTaskDet"
                        CollapseControlID="pnlTaskDet"
                        AutoCollapse="False"
                        AutoExpand="False"
                        TextLabelID="lblTaskL"
                        CollapsedText="Show..."
                        ExpandedText="Hide..." 
                        ExpandDirection="Vertical" />
 
            </td>
        </tr>
    </table>
    <br/>
    
    
    <asp:Panel ID="tblSpare" runat="server" Width="100%" >          
    
        <table  cellspacing="1" width="85%"  class="boxbg" border="0">
            <tr class="bgbluegrey">
                <td width="75%" >
                    <asp:Label ID="lblHead" CssClass="blackfnt"  Font-Bold="true" runat="server">Spare Part-Requirements(Estimates)</asp:Label>
                   
                </td>
                <td  align="left" width="15%">
                    <asp:Label  CssClass="blackfnt" ID="lblRow" runat="server">Enter no. of rows </asp:Label>  
                </td>
                <td  width="5%" >
                    <asp:TextBox ID="txtRow" runat="server" MaxLength="2" Width="20px" BorderStyle="Groove"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  AutoPostBack="true"  Text="0" OnTextChanged="txtRow_TextChanged" ></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server"
                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"  ValidationGroup="row"  
                    ControlToValidate="txtRow" Display="Dynamic"></asp:RegularExpressionValidator>
                </td>
                <td  width="5%">
                    <asp:Label ID="lblTDSH" runat="server" Font-Bold="True">Show...</asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>

     <table cellspacing="1" width="100%">
        <tr align="center">
            <td align="center" >
                             
     <asp:Panel ID="pnlSpare" runat="server" >
            <asp:DataGrid ID="dgSpare" runat="server"    
            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
            CellSpacing="1" CssClass="dgRowStyle" 
            HeaderStyle-CssClass="dgHeaderStyle"  PagerStyle-HorizontalAlign="left" OnItemDataBound="dgSpare_ItemDataBound"
            width="85%" >
            <Columns>


            <asp:TemplateColumn HeaderText="Sr.No.">
                <ItemTemplate>
                    <center>
                    <%# Container.ItemIndex+1 %>.
                    <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                    </center>
                </ItemTemplate>
                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                Font-Underline="False" Wrap="False" />
                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                Font-Underline="False" Wrap="False" />
            </asp:TemplateColumn>


            <asp:TemplateColumn HeaderText="Work Group" >
                <ItemTemplate>
                    <asp:Label ID="lblWorkGroup" runat="server"    CssClass="blackfnt"    ></asp:Label>
                    <asp:DropDownList ID="ddlWorkGroup" runat="server"   Width="150px" AutoPostBack="true"  CssClass="blackfnt" OnSelectedIndexChanged="ddlWorkGroup_SelectedChanged"  ></asp:DropDownList> 
                    <asp:RequiredFieldValidator ID="ReqddlWorkGroup" runat="server" Display="Dynamic" Text="!"  ValidationGroup="Group11" ControlToValidate="ddlWorkGroup"></asp:RequiredFieldValidator>
                </ItemTemplate>
            </asp:TemplateColumn>



            <asp:TemplateColumn HeaderText="Part Description" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                <ItemTemplate>
                    <asp:DropDownList ID="ddlPartNo" runat="server"  Width="150px"  CssClass="blackfnt"    ></asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateColumn>

            <asp:TemplateColumn HeaderText="Quantity" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                <ItemTemplate>
                    <asp:TextBox ID="txtQty" MaxLength="10" Text='<%# Eval("PART_QTY") %>'  runat="server" style="text-align: right" Width="100px"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  CssClass="blackfnt" BorderStyle="Groove"  ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqtxtQty"   ValidationGroup="G1"   runat="server" Display="Dynamic" Text="!" ControlToValidate="txtQty"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegtxtQty" runat="server"
                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                    ControlToValidate="txtQty" Display="Dynamic"></asp:RegularExpressionValidator>                    
                </ItemTemplate>
            </asp:TemplateColumn>


            <asp:TemplateColumn HeaderText="Cost/Unit" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                <ItemTemplate>
                    <asp:TextBox ID="txtCostUnit" Width="100px" Text='<%# Eval("COST_UNIT") %>' style="text-align: right" BorderStyle="None"  runat="server"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateColumn>

            <asp:TemplateColumn HeaderText="Cost" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                <ItemTemplate>
                    <asp:TextBox ID="txtCost" style="text-align: right" runat="server" Text='<%# Eval("COST") %>'  Width="100px"   CssClass="blackfnt" BorderStyle="None"  ></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqtxtCost"   ValidationGroup="G1"   runat="server" Display="Dynamic" Text="!" ControlToValidate="txtCost"></asp:RequiredFieldValidator>
                </ItemTemplate>
            </asp:TemplateColumn>

            <asp:TemplateColumn HeaderText="Remarks" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                <ItemTemplate>
                    <asp:TextBox ID="txtSpareRemark" runat="server" Text='<%# Eval("S_Remarks") %>'  CssClass="blackfnt" BorderStyle="Groove"    ></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateColumn>

            </Columns>

            <PagerStyle HorizontalAlign="Left" />
            <HeaderStyle CssClass="dgHeaderStyle" />
            </asp:DataGrid>
            </asp:Panel>
             <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="Server"
                        TargetControlID="pnlSpare"
                        CollapsedSize="0"
                        Collapsed="True"
                        ExpandControlID="tblSpare"
                        CollapseControlID="tblSpare"
                        AutoCollapse="False"
                        AutoExpand="False"
                        TextLabelID="lblTDSH"
                        CollapsedText="Show..."
                        ExpandedText="Hide..." 
                        ExpandDirection="Vertical" />
            
            </td>
        </tr>
    </table >
    
      
    
    <br/>
    
     <asp:Panel ID="pnlSummaryHdr" runat="server" Width="50%" >          
    
        <table  cellspacing="1" width="100%"  class="boxbg" border="0">
            <tr class="bgbluegrey">
                <td width="75%" >
                    <asp:Label ID="Label14" CssClass="blackfnt"      Font-Bold="true" runat="server">Summary</asp:Label>
                   
                </td>
                
                <td  width="5%">
                    <asp:Label ID="lblSummaryHdr" runat="server" Font-Bold="True">Show...</asp:Label>
                </td>
            </tr>
        </table>
   
    
                               
     <asp:Panel ID="pnlSummary" runat="server" Width="100%" >
        <table  cellspacing="1" class="boxbg" width="100%"    border="0">
            <tr style="background-color: white" >
                <td width="50%" >
                    <asp:Label Font-Bold="true"  CssClass="bluefnt" ID="Label16"  Text="Total Estimated Labour Hours"    runat="server"></asp:Label>
                </td>
                <td  align="left" width="50%">
                    <asp:TextBox Font-Bold="true"  CssClass="bluefnt" ID="txtTotalEstimatedLabHours" 
                        style="text-align: right" BorderStyle="None" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr style="background-color: white" >
                <td width="50%" >
                    <asp:Label ID="Label17" Font-Bold="true"  CssClass="bluefnt"  Text="Total Estimated Labour Cost"   runat="server"></asp:Label>
                </td>
                <td  align="left" width="50%">
                    <asp:TextBox Font-Bold="true"  CssClass="bluefnt" ID="txtTotalEstimatedLabCost" style="text-align: right" BorderStyle="None" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr style="background-color: white" >
                <td width="50%" >
                    <asp:Label ID="Label19" Font-Bold="true"  CssClass="bluefnt"  Text="Total Estimated Part Cost"    runat="server"></asp:Label>
                </td>
                <td  align="left" width="50%">
                    <asp:TextBox Font-Bold="true"  CssClass="bluefnt" ID="txtTotalPartCost" style="text-align: right" BorderStyle="None" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr style="background-color: white" >
                <td width="50%" >
                    <asp:Label ID="Label21" Font-Bold="true"  CssClass="bluefnt"  Text="Total Estimated Cost"    runat="server"></asp:Label>
                </td>
                <td  align="left" width="50%">
                    <asp:TextBox Font-Bold="true"  CssClass="bluefnt" ID="txtTotalEstimated" style="text-align: right" BorderStyle="None" runat="server"></asp:TextBox>
                </td>
            </tr>
          
        </table>
      </asp:Panel>
       </asp:Panel>
             <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender4" runat="Server"
                        TargetControlID="pnlSummary"
                        CollapsedSize="0"
                        Collapsed="True"
                        ExpandControlID="pnlSummaryHdr"
                        CollapseControlID="pnlSummaryHdr"
                        AutoCollapse="False"
                        AutoExpand="False"
                        TextLabelID="lblSummaryHdr"
                        CollapsedText="Show..."
                        ExpandedText="Hide..." 
                        ExpandDirection="Vertical" />
            
    <br />
    
    
            <table  align="center"   style="width: 100%"     >    
                       
                       <tr style="background-color: white" align="center">
                          <td  align="center" colspan="2">
                           <asp:Button ID="cmdSubmit" runat="server" Text="Submit"  ValidationGroup="Group11"  OnClientClick="javascript:return check()"  OnClick="cmdSubmit_Click1"   /> 
                       </td>
                      </tr>
                     </table>
   
   
    
   </ContentTemplate>
                    <Triggers>
                     
                   
            <asp:AsyncPostBackTrigger ControlID="cmdSubmit" EventName="Click" />
 </Triggers>
   </asp:UpdatePanel>
    
            </td>
        </tr>
     </table>
  
      
    </asp:Content>
