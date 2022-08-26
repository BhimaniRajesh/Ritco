 //function OnLoad(No_SM,SM)
//    {
//        No_SM.style["display"] = "none";
//        SM.style["display"] = "none";
//    }
//    function OnChangeOrderType(ddlOrderType,No_SM,SM)
//    {
//        if(ddlOrderType.selectedIndex == 0)
//        {
//            No_SM.style["display"] = "none";
//            SM.style["display"] = "none";
//        }
//        else if (ddlOrderType.value == "06")
//        {
//            No_SM.style["display"] = "none";
//            SM.style["display"] = "block"; 
//        }
//        else
//        {
//            SM.style["display"] = "none";
//            No_SM.style["display"] = "block";
//        }
//    }
function numeric(e) { return ((e.keyCode == 8) || (e.keyCode == 110) || (e.keyCode == 190) || (e.keyCode > 47 && e.keyCode <58)||(e.keyCode > 95 && e.keyCode <106) || (e.keyCode == 9) || (e.keyCode == 46));  }
function nwOpen(mNo)
{
    //window.open("/ERP.NET/GUI/Fleet/Webadmin/Driver/PopupVehicleNo.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
    window.open("Popup-Vehicle.aspx?Mno=" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=450,height=220,status=no,left=220,top=70")
}
function calculate()
{
    var totHrs="0.00",totcost="0.00";
    var mtotHrs="0.00",mtotcost="0.00";
    
    var txttotEstHrs=document.getElementById("ctl00_MyCPH1_txttotEstHrs");
    var txttotEstCost=document.getElementById("ctl00_MyCPH1_txttotEstCost");
    
    var txtTotalEstimatedLabHours=document.getElementById("ctl00_MyCPH1_txtTotalEstimatedLabHours");
    var txtTotalEstimatedLabCost=document.getElementById("ctl00_MyCPH1_txtTotalEstimatedLabCost");
    var txtTotalPartCost=document.getElementById("ctl00_MyCPH1_txtTotalPartCost");
    var txtTotalEstimated=document.getElementById("ctl00_MyCPH1_txtTotalEstimated");
    
    var grid=document.getElementById("ctl00_MyCPH1_gvTaskDetails");
    if(grid != null)
    {
        var r=grid.rows.length;
        for(k=0;k<r-1;k++)
        {  
            j=k+2
            var pref="";
            if(j<10)
            {
                pref = "ctl00_MyCPH1_gvTaskDetails_ctl0" + j + "_";
            }                                       
            else
            {         
                pref = "ctl00_MyCPH1_gvTaskDetails_ctl" + j + "_";
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
    }
    var totHrsSM="0.00",totcostSM="0.00";
    var mtotHrsSM="0.00",mtotcostSM="0.00";
    
    var gvSMTaskDet=document.getElementById("ctl00_MyCPH1_gvSMTaskDet");
    if(gvSMTaskDet != null)
    {
        for(i=0;i<gvSMTaskDet.rows.length-1;i++)
        {  
            j=i+2
            var pref="";
            if(j<10)
            {
                pref = "ctl00_MyCPH1_gvSMTaskDet_ctl0" + j + "_";
            }                                       
            else
            {         
                pref = "ctl00_MyCPH1_gvSMTaskDet_ctl" + j + "_";
            }    
            var chkSelect =document.getElementById(pref + "chkSelect");
            if(chkSelect!=null)
            {
                if(chkSelect.checked == true)
                {
                    if(document.getElementById(pref + "txtEstHrs")!=null)
                    {
                        var txtEstHrs= document.getElementById(pref + "txtEstHrs") 
                        if(txtEstHrs.value!="")
                        {
                            totHrsSM=parseFloat(totHrsSM)+parseFloat(txtEstHrs.value);
                        }
                    }
                    if(document.getElementById(pref + "txtEstCost")!=null)
                    {
                        var txtEstCost= document.getElementById(pref + "txtEstCost") 
                        if(txtEstCost.value!="")
                        {
                            totcostSM=parseFloat(totcostSM)+parseFloat(txtEstCost.value);
                        }
                    }
                    mtotHrsSM=parseFloat(totHrsSM);
                    mtotcostSM=parseFloat(totcostSM);
                }
            }
        }
    }
    if(txtTotalEstimatedLabHours != null)
    {
        txttotEstHrs.value=parseFloat(totHrs) + parseFloat(totHrsSM);     
    }
    if(txttotEstCost != null)
    {
        txttotEstCost.value=parseFloat(totcost) + parseFloat(totcostSM); 
    }
    if(txtTotalEstimatedLabHours != null)
    {
        txtTotalEstimatedLabHours.value =parseFloat(totHrs) + parseFloat(totHrsSM);
    }
    if(txtTotalEstimatedLabCost != null)
    {
        txtTotalEstimatedLabCost.value =parseFloat(totcost) + parseFloat(totcostSM);
    }
    if(txtTotalEstimated != null && txtTotalPartCost != null)
    {
        if(txtTotalPartCost.value == "")
        {
            txtTotalPartCost.value = "0.00";
        }
        txtTotalEstimated.value = parseFloat(totcost) + parseFloat(totcostSM) + parseFloat(txtTotalPartCost.value);
    }
}

function OnSelectSM(chkSelect)
{
    calculate();
}

function OnPartDescCalculate(txtQty,txtCostUnit,txtCost)
{
    if(txtQty.value!="" && txtCostUnit.value!="")
    {
        txtCost.value=parseFloat(txtQty.value) * parseFloat(txtCostUnit.value);
        calculateSpare();
        calculate();
    }
}
function OnEstHrsCalculate(txtEstHrs,txtEstCost,txtEstLabourHrs)
{
    if(txtEstHrs.value == ""){txtEstHrs.value="0";}
    if(txtEstLabourHrs.value == ""){txtEstLabourHrs.value="0";}
    txtEstCost.value = parseFloat(txtEstHrs.value) * parseFloat(txtEstLabourHrs.value);
    calculateSpare();
    calculate();
}


function CheckVehicleNo(txtVehicleNo, lblCategory, lblMfg, lblModel, lblError, txtKMReading, txt_Tmp_CurrentKM) {
    var currentTime = new Date()
    var ddlSCtype = document.getElementById("ctl00_MyCPH1_ddlSCtype");
    var ddlOrderType = document.getElementById("ctl00_MyCPH1_ddlOrderType");
    var hf_Vehicle_Attached_TS = document.getElementById("ctl00_MyCPH1_hf_Vehicle_Attached_TS");
    var hf_Vehicle_Attached_JS = document.getElementById("ctl00_MyCPH1_hf_Vehicle_Attached_JS");


    if (txtVehicleNo.value == "") {
        lblCategory.value = "";
        lblMfg.value = "";
        lblModel.value = "";
        lblError.innerText = "";
        txtKMReading.value = "";
        txt_Tmp_CurrentKM.value = "";
        ddlSCtype.value = "";
        ddlOrderType.value = "";
        ddlSCtype.disabled = true;
        ddlOrderType.disabled = true;
        return;
    }
    createXMLHttpRequest();
    if (xmlHttpRequest) {
        xmlHttpRequest.onreadystatechange = function () {
            if (xmlHttpRequest.readyState == 4) {
                var returnValue = xmlHttpRequest.responseText.split("~");
                if (returnValue[0] == "Y") {
                    //alert(hf_Vehicle_Attached_TS.value);
                    if (hf_Vehicle_Attached_TS.value == "Y") {
                        if (returnValue[2] != "Available") {
                            txtKMReading.value = "";
                            lblCategory.value = "";
                            lblMfg.value = "";
                            lblModel.value = "";
                            lblError.innerText = "Vehicle is In Transit !!!";
                            txt_Tmp_CurrentKM.value = "";
                            txtVehicleNo.focus();
                            ddlSCtype.value = "";
                            ddlOrderType.value = "";
                            ddlSCtype.disabled = true;
                            ddlOrderType.disabled = true;
                            return false;
                        }
                    }
                    else {
                        //alert(hf_Vehicle_Attached_JS.value);
                        if (hf_Vehicle_Attached_JS.value == "Y") {
                            if (returnValue[8] == "In Transit") {
                                txtKMReading.value = "";
                                lblCategory.value = "";
                                lblMfg.value = "";
                                lblModel.value = "";
                                lblError.innerText = "Vehicle is under maintenance in Job Order Number " + returnValue[9] + " !!!";
                                txt_Tmp_CurrentKM.value = "";
                                txtVehicleNo.focus();
                                ddlSCtype.value = "";
                                ddlOrderType.value = "";
                                ddlSCtype.disabled = true;
                                ddlOrderType.disabled = true;
                                return false;
                            }
                            else {
                                //alert("valid");
                                lblError.innerText = "";
                                txtKMReading.value = returnValue[1];
                                txtVehicleNo.value = txtVehicleNo.value;
                                lblMfg.value = returnValue[3];
                                lblModel.value = returnValue[4];
                                lblCategory.value = returnValue[5];
                                txt_Tmp_CurrentKM.value = returnValue[7];
                                ddlSCtype.disabled = false;
                                ddlOrderType.disabled = false;
                            }
                        }
                        else {
                            //alert("valid");
                            lblError.innerText = "";
                            txtKMReading.value = returnValue[1];
                            txtVehicleNo.value = txtVehicleNo.value;
                            lblMfg.value = returnValue[3];
                            lblModel.value = returnValue[4];
                            lblCategory.value = returnValue[5];
                            txt_Tmp_CurrentKM.value = returnValue[7];
                            ddlSCtype.disabled = false;
                            ddlOrderType.disabled = false;
                        }
                    }
                }
                else {
                    txtKMReading.value = "";
                    lblCategory.value = "";
                    lblMfg.value = "";
                    lblModel.value = "";
                    lblError.innerText = "Invalid Vehicle Number !!!";
                    txtVehicleNo.focus();
                    ddlSCtype.value = "";
                    ddlOrderType.value = "";
                    ddlSCtype.disabled = true;
                    ddlOrderType.disabled = true;
                    return false;
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckVehicleNo&datetime=" + currentTime + "&VehNo=" + txtVehicleNo.value, false);
        xmlHttpRequest.send(null);
    }
}

function calculateSpare()
{
    var mtotcost="0.00";
    var dgSpare=document.getElementById("ctl00_MyCPH1_dgSpare");
    var txtTotalPartCost=document.getElementById("ctl00_MyCPH1_txtTotalPartCost");
    var txtTotalEstimated=document.getElementById("ctl00_MyCPH1_txtTotalEstimated");
    var txtTotalEstimatedLabCost=document.getElementById("ctl00_MyCPH1_txtTotalEstimatedLabCost");
    
    
    
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
    //alert(mtotcost);
    if(txtTotalPartCost != null)
    {
        txtTotalPartCost.value=mtotcost;  
    }
    else
    {
        txtTotalPartCost.value="0.00";  
    }
    if(txtTotalEstimated != null && txtTotalEstimatedLabCost != null)
    {
        if(txtTotalEstimatedLabCost.value == "")
        {
            txtTotalEstimatedLabCost.value = "0.00";
        }
        else
        {
            txtTotalEstimated.value=parseFloat(mtotcost)+parseFloat(txtTotalEstimatedLabCost.value);  
        }
    }
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

function OnTaskDescChange(row_Index,ddlTask,ddlTaskType,txtEstHrs,txtEstCost,txtEstLabourHrs)
{
    var currentTime = new Date()    
    var str_Index = "";
    var txtEstLabourHrs = document.getElementById("ctl00_MyCPH1_txtEstLabourHrs");
    if(txtEstLabourHrs.value == "")
    {
        alert("Enter Labour Cost per Hour !!!");
        ddlTask.value = "";
        txtEstLabourHrs.focus();
        return false;
    }
    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gvTaskDetails").rows.length; intIndex++)
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
        if (document.getElementById("ctl00_MyCPH1_gvTaskDetails_ctl" + str_Index + "_ddlTask").value == ddlTask.value)
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
                    //alert(ddlTaskType.value)
                    //alert(returnValue[1])
                    ddlTaskType.value=returnValue[1];
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

function OnPartDescChange(row_Index,ddlPartNo,ddlTaskType,txtCostUnit,txtCost,txtSpareRemark)
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
                    ddlTaskType.value=returnValue[2];
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
    //var SCtypeval=document.getElementById("ctl00_MyCPH1_ddlSCtype");
    var WLoc=document.getElementById("ctl00_MyCPH1_ddlWLoc");
    var vendor=document.getElementById("ctl00_MyCPH1_ddlVendor");
    if(SCtype.value=="Workshop")
    {
        if(WLoc.value=="")
        {
            alert("Please select the Workshop Location");
            WLoc.focus();
            return false;
        }
    }
    if(SCtype.value=="Vendor")
    {
        if(vendor.value=="")
        {
            alert("Please select the Vvendor");
            vendor.focus();
            return false;
        }
    }
    
    var JobOrderDt=document.getElementById("ctl00_MyCPH1_txtOrderDate").value;
    var SendDtDt_WS=document.getElementById("ctl00_MyCPH1_txtDCSendDt");
    
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
 
    var EReturnDt_WS=document.getElementById("ctl00_MyCPH1_txtDCReturnDt");
    
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

    var txt_Tmp_CurrentKM = document.getElementById("ctl00_MyCPH1_txt_Tmp_CurrentKM");
    if (txt_Tmp_CurrentKM.value == "") {
        alert("Enter Tmp KM. Reading !!!")
        txt_Tmp_CurrentKM.focus();
        return false;
    }
    
    var grid=document.getElementById("ctl00_MyCPH1_gvTaskDetails");
    var r=grid.rows.length;
    var TaksSel=0;
    for(i=0;i<r-1;i++)
    {  
        j=i+2;
        var pref="";
        if(j<10)
        {
            pref = "ctl00_MyCPH1_gvTaskDetails_ctl0" + j + "_";
        }                                       
        else
        {         
            pref = "ctl00_MyCPH1_gvTaskDetails_ctl" + j + "_";
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
            pref = "ctl00_MyCPH1_gvTaskDetails_ctl0" + j + "_";
        }                                       
        else
        {         
            pref = "ctl00_MyCPH1_gvTaskDetails_ctl" + j + "_";
        }  
        var mtask= document.getElementById(pref + "ddlTask");
        for(k1=i+1;k1<r-1;k1++)
        { 
            l1=k1+2
            var tpref="";
            if(l1<10)
            {
                tpref = "ctl00_MyCPH1_gvTaskDetails_ctl0" + l1 + "_";
            }                                       
            else
            {         
                tpref = "ctl00_MyCPH1_gvTaskDetails_ctl" + l1 + "_";
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
//    function hitme()
//    {
//        //var shell = new ActiveXObject("WScript.shell");
//        //shell.SendKeys("{ENTER}",[10]);
//        //shell.Quit;
//    }
var cal = new CalendarPopup("Div1"); 
cal.setCssPrefix("TEST");
cal.showNavigationDropdowns();




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
function stripCharsInBag(s, bag)
{
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
    
function checkForSM()
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
    //var SCtypeval=document.getElementById("ctl00_MyCPH1_ddlSCtype");
    var WLoc=document.getElementById("ctl00_MyCPH1_ddlWLoc");
    var vendor=document.getElementById("ctl00_MyCPH1_ddlVendor");
    if(SCtype.value=="Workshop")
    {
        if(WLoc.value=="")
        {
            alert("Please select the Workshop Location");
            WLoc.focus();
            return false;
        }
    }
    if(SCtype.value=="Vendor")
    {
        if(vendor.value=="")
        {
            alert("Please select the Vvendor");
            vendor.focus();
            return false;
        }
    }
    
    var JobOrderDt=document.getElementById("ctl00_MyCPH1_txtOrderDate").value;
    var SendDtDt_WS=document.getElementById("ctl00_MyCPH1_txtDCSendDt");
    
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

 
 
    var EReturnDt_WS=document.getElementById("ctl00_MyCPH1_txtDCReturnDt");
    
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
}


function CheckEstLabourHrs(txtEstLabourHrs)
{ 
   var ddlOrderType = document.getElementById("ctl00_MyCPH1_ddlOrderType").value;

   if(ddlOrderType!="")
   {
       var txtTaskRow = document.getElementById("ctl00_MyCPH1_txtTaskRow").value;
       if(parseFloat(txtTaskRow)!=0 || parseFloat(txtTaskRow)!="")
       {
            var grid=document.getElementById("ctl00_MyCPH1_gvTaskDetails");
            if(grid != null)
            {
                var r=grid.rows.length;
                for(k=0;k<r-1;k++)
                {  
                    j=k+2
                    var pref="";
                    if(j<10)
                    {
                        pref = "ctl00_MyCPH1_gvTaskDetails_ctl0" + j + "_";
                    }                                       
                    else
                    {         
                        pref = "ctl00_MyCPH1_gvTaskDetails_ctl" + j + "_";
                    }    
                    document.getElementById(pref + "txtEstCost").value =  parseFloat(document.getElementById(pref + "txtEstHrs").value) * parseFloat(txtEstLabourHrs.value);
                    calculateSpare();
                    calculate();
                }
            }
        }
    }
}