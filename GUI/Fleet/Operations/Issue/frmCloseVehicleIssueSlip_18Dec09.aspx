<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="frmCloseVehicleIssueSlip_18Dec09.aspx.cs" Inherits="Issue_frmCloseVehicleIssueSlip" %>

<%@Register TagPrefix="SControls" TagName="DateSelector" src="~/LED/DateSelector.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script type="text/javascript" language="javascript" src="../../../../cal/popcalendar.js"></script>
<script type="text/javascript" language="javascript" src="../../../../GUI/Js/Date.js"></script>

    <script src="../../../JS/dw_lib.js" type="text/javascript"></script>
    <script src="../../../JS/dw_glider.js" type="text/javascript"></script>
    <script src="../../../JS/dw_glide.js" type="text/javascript"></script>
 <script language="javascript" type="text/javascript">

function CheckKM(row_Index,txtKM_Reading,txtLKmRead)
{
    var str_Index = "";
    var lbl_OilExp_Expense=document.getElementById("ctl00_MyCPH1_lbl_OilExp_Expense");
    var dgHSD_OIL_EXP=document.getElementById("ctl00_MyCPH1_dgHSD_OIL_EXP");
    
    if(parseFloat(txtKM_Reading.value) < parseFloat(txtLKmRead.value))
    {
        lbl_OilExp_Expense.innerText ="Current km reading cannot be less than last km reading!";
        txtKM_Reading.style.borderColor="red";
        txtKM_Reading.focus();
        return false;
    }
    else
    {
        lbl_OilExp_Expense.innerText ="";
        txtKM_Reading.style.borderColor="";
    }
    str_Index = parseFloat(row_Index) + 3;
    if (parseFloat(str_Index) < 10)
    {
        str_Index = "0" + str_Index;
    }
    if(parseFloat(str_Index) <= dgHSD_OIL_EXP.rows.length)
    {
        var _txtLKmRead = document.getElementById("ctl00_MyCPH1_dgHSD_OIL_EXP_ctl" + str_Index + "_txtLKmRead");
        _txtLKmRead.value = txtKM_Reading.value;
    }
}
function CalculateDiesel()
{
    var dgHSD_OIL_EXP=document.getElementById("ctl00_MyCPH1_dgHSD_OIL_EXP");
    var txtFuelFilledEnroute=document.getElementById("ctl00_MyCPH1_txtFuelFilledEnroute");
    var totamt="0.00";
    
    for(i=0;i<dgHSD_OIL_EXP.rows.length-1;i++)
    {
        j=i+2;
        var pref="";
        if(j<10)
        {
            pref = "ctl00$MyCPH1$dgHSD_OIL_EXP$ctl0" + j + "$";
        }
        else
        {
            pref = "ctl00$MyCPH1$dgHSD_OIL_EXP$ctl" + j + "$";
        }
        var txtDiesel_Ltr=document.getElementById(pref + "txtDiesel_Ltr");
        var txtDieselRate_Ltr=document.getElementById(pref + "txtDieselRate_Ltr");
        var txtAmt=document.getElementById(pref + "txtAmt");
        txtAmt.value = parseFloat(txtDiesel_Ltr.value) * parseFloat(txtDieselRate_Ltr.value);
        if(txtDiesel_Ltr.value!="")
        {
            totamt=parseFloat(totamt) + parseFloat(txtDiesel_Ltr.value);
        }
        
    }
    txtFuelFilledEnroute.value = totamt;
    CheckClosingKM();
}
function CalculateDieselLiters(txtDiesel_Ltr,txtDieselRate_Ltr,txtAmt)
{
    txtAmt.value = parseFloat(txtDiesel_Ltr.value) * parseFloat(txtDieselRate_Ltr.value);
    CheckClosingKM();
}


function CheckApprovedAmt(row_Index,txtExeAmt1)
{
    var dgHSD_OIL_EXP=document.getElementById("ctl00_MyCPH1_dgHSD_OIL_EXP");
    var hfApprovedAmt=document.getElementById("ctl00_MyCPH1_hfApprovedAmt");
    var txtApprovedFuelAmt=document.getElementById("ctl00_MyCPH1_txtApprovedFuelAmt");
 
    var totamt="0.00";
    
    for(i=0;i<dgHSD_OIL_EXP.rows.length-1;i++)
    {
        j=i+2;
        var pref="";
        if(j<10)
        {
            pref = "ctl00$MyCPH1$dgHSD_OIL_EXP$ctl0" + j + "$";
        }
        else
        {
            pref = "ctl00$MyCPH1$dgHSD_OIL_EXP$ctl" + j + "$";
        }
        var txtExeAmt=document.getElementById(pref + "txtExeAmt");
        if(txtExeAmt.value!="")
        {
            totamt=parseFloat(totamt) + parseFloat(txtExeAmt.value);
        }
    }
    hfApprovedAmt.value = totamt;
}
function CheckEnRouteExpDetails()
{
    var hfApprovedAmt=document.getElementById("ctl00_MyCPH1_hfApprovedAmt");
    var txtCloseKM=document.getElementById("ctl00_MyCPH1_txtCloseKM");
    var txtExeAmt=document.getElementById("ctl00_MyCPH1_txtExeAmt");
    var txtApprovedFuelAmt=document.getElementById("ctl00_MyCPH1_txtApprovedFuelAmt");
    var gvEnroute=document.getElementById("ctl00_MyCPH1_gvEnroute");
    var dgHSD_OIL_EXP=document.getElementById("ctl00_MyCPH1_dgHSD_OIL_EXP");
    var txtApprovedFuelAmt=document.getElementById("ctl00_MyCPH1_txtApprovedFuelAmt");
    CheckApprovedAmt();
    if(txtCloseKM.value == "")
    {
        alert("Enter Closing KM!!!");
        txtCloseKM.focus();
        return false;
    }
    if(dgHSD_OIL_EXP.rows.length > 1)
    {
        for(i=0;i<dgHSD_OIL_EXP.rows.length-1;i++)
        {
            j=i+2;
            var pref="";
            if(j<10)
            {
                pref = "ctl00$MyCPH1$dgHSD_OIL_EXP$ctl0" + j + "$";
            }
            else
            {
                pref = "ctl00$MyCPH1$dgHSD_OIL_EXP$ctl" + j + "$";
            }
            var txtOilPlace=document.getElementById(pref + "txtOilPlace");
            var ddlPPName=document.getElementById(pref + "ddlPPName");
            var ddlBrand=document.getElementById(pref + "ddlBrand");
            var ddlFuelType=document.getElementById(pref + "ddlFuelType");
            var txtLKmRead=document.getElementById(pref + "txtLKmRead");
            var txtKM_Reading=document.getElementById(pref + "txtKM_Reading");
            var txtDiesel_Ltr=document.getElementById(pref + "txtDiesel_Ltr");
            var txtDieselRate_Ltr=document.getElementById(pref + "txtDieselRate_Ltr");
            var txtAmt=document.getElementById(pref + "txtAmt");
            var txtExeAmt=document.getElementById(pref + "txtExeAmt");
            var ddlPayment=document.getElementById(pref + "ddlPayment");
            if (txtOilPlace.value == "")
            {
                alert("Enter Place !!!");
                txtOilPlace.focus();
                return false;
            }
            if (ddlPPName.value == "")
            {
                alert("Select Petrol Pump Name !!!");
                ddlPPName.focus();
                return false;
            }
            if (ddlBrand.value == "")
            {
                alert("Select Brand !!!");
                ddlBrand.focus();
                return false;
            }
            if (ddlFuelType.value == "")
            {
                alert("Select Fuel Type !!!");
                ddlFuelType.focus();
                return false;
            }
            if (txtKM_Reading.value == "")
            {
                alert("Enter KM Reading !!!");
                txtKM_Reading.focus();
                return false;
            }
            if (txtDiesel_Ltr.value == "0")
            {
                alert("Enter Diesel !!!");
                txtDiesel_Ltr.focus();
                return false;
            }
            if (txtDieselRate_Ltr.value == "0")
            {
                alert("Enter Diesel Rate/litres !!!");
                txtDieselRate_Ltr.focus();
                return false;
            }
            if (txtExeAmt.value == "")
            {
                alert("Enter Amount Approved By Fleet Executive !!!");
                txtExeAmt.focus();
                return false;
            }
        }
    }
    for(i=0;i<gvEnroute.rows.length-2;i++)
    {
        j=i+2;
        var pref="";
        if(j<10)
        {
            pref = "ctl00$MyCPH1$gvEnroute$ctl0" + j + "$";
        }
        else
        {
            pref = "ctl00$MyCPH1$gvEnroute$ctl" + j + "$";
        }
        var ddlNExpense=document.getElementById(pref+"ddlNExpense");
        var txtAmount=document.getElementById(pref+"txtAmount");
        var hfEAmt=document.getElementById(pref+"hfEAmt");
        var txtEAmt=document.getElementById(pref+"txtEAmt");
        
        if(txtAmount.value != "" || hfEAmt.value != "" || txtEAmt.value != "")
        {
            if (ddlNExpense.value == "0")
            {
                alert("Select Nature of Expense!!!");
                ddlNExpense.focus();
                return false;
            }
            if (txtAmount.value == "")
            {
                alert("Enter Amount!!!");
                txtAmount.focus();
                return false;
            }
            if(hfEAmt.value == "")
            {
                if (txtEAmt.value == "")
                {
                    alert("Standard Amount is Required. \n Kindly check the FTL Type mappaing with Vehicle Master or Trip Route Expense Master Entry!!!");
                    txtEAmt.focus();
                    return false;
                }
            }
        }
    }
    
    if(hfApprovedAmt.value != "")
    {
        if(parseFloat(txtApprovedFuelAmt.value) < parseFloat(hfApprovedAmt.value))
        {
            var ConFirmBox = confirm("Approved fuel amount is greater than amount approved by fleet executive.\n\n Are you sure?");
            if(ConFirmBox==false)
            {
                txtExeAmt.focus();
                return false;
            }
        }
    }
}
function createXMLHttpRequest() {
    // Mozilla, Safari,...
	if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
	// IE
	else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
}
function CheckValidExp(row_Index,ddlNExpense,txtEAmt,hfEAmt,hfPolarity)
{
    var currentTime = new Date();
    var str_Index = "";
    var lblVehno=document.getElementById("ctl00_MyCPH1_lblVehno");
    var hfRouteCode=document.getElementById("ctl00_MyCPH1_hfRouteCode");
    
    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gvEnroute").rows.length-2; intIndex++)
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
        
        var D_ddlNExpense;
        
        D_ddlNExpense=document.getElementById("ctl00_MyCPH1_gvEnroute_ctl" + str_Index + "_ddlNExpense");
        //D_ddlRouteSegment=document.getElementById("ctl00_MyCPH1_gvEnroute_ctl" + str_Index + "_ddlRouteSegment");
        if (D_ddlNExpense.value == ddlNExpense.value)
        {
            alert("This Part already exist at row " + (intIndex - 1));
            ddlNExpense.selectedIndex = 0;
            ddlNExpense.focus();
            return false;
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
                FillPolarity(ddlNExpense,hfPolarity);
                //alert(hfPolarity.value);
                if (returnValue[0] == "N") 
                {
                    txtEAmt.disabled = false;
                    txtEAmt.value="";
                    hfEAmt.value="";
                }
                else
                {
                    txtEAmt.disabled = true;
                    txtEAmt.value=returnValue[1];
                    hfEAmt.value=returnValue[1];
                    
                }
            }
        }
        xmlHttpRequest.open("GET", "AjaxResponse.aspx?Function=FillStandardAmt&datetime="+currentTime+"&RouteCode="+ hfRouteCode.value +"&ExpCode=" + ddlNExpense.value+"&Vehno="+ lblVehno.innerText, false);
        xmlHttpRequest.send(null);
    }
}
function FillPolarity(ddlNExpense,hfPolarity)
{
    var currentTime = new Date();
    
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
                    hfPolarity.value=returnValue[1];
                }
            }
        }
        xmlHttpRequest.open("GET", "AjaxResponse.aspx?Function=FillPolarity&datetime="+currentTime+"&ExpCode="+ ddlNExpense.value, false);
        xmlHttpRequest.send(null);
    } 
}
function CheckClosingKM()
{
    var prefix = "ctl00_MyCPH1_";
    var lblStartKm=document.getElementById(prefix+"lblStartKm");
    var txtCloseKM=document.getElementById(prefix+"txtCloseKM");
    var txtTotalKms=document.getElementById(prefix+"txtTotalKms");
    var hfKMPL=document.getElementById(prefix+"hfKMPL");
    var txtApprovedDiesel=document.getElementById(prefix+"txtApprovedDiesel");
    var lblAverageDieselRate=document.getElementById(prefix+"lblAverageDieselRate");
    var txtApprovedFuelAmt=document.getElementById(prefix+"txtApprovedFuelAmt");
    var txtFuelFilledEnroute=document.getElementById(prefix+"txtFuelFilledEnroute");
    //var txtFuelFilled=document.getElementById(prefix+"txtFuelFilled");
    var txtTotalKms=document.getElementById(prefix+"txtTotalKms");
    var txtKMPL=document.getElementById(prefix+"txtKMPL");
    var lbl_Closing_KM_Err=document.getElementById(prefix+"lbl_Closing_KM_Err");
  
    if(lblAverageDieselRate.innerText == "")
    {
        lblAverageDieselRate.innerText = "0.0";
    }
    if(hfKMPL.value == "")
    {
        hfKMPL.value = "0.0";
    }
    if(txtCloseKM.value != "" && lblStartKm.innerText != "")
    {
        if(parseFloat(txtCloseKM.value) < parseFloat(lblStartKm.innerText))
        {
            lbl_Closing_KM_Err.innerText = "Close Km Cannot  be less than  Start Km!";
            txtTotalKms.value="";
            txtCloseKM.focus();
            return false;
        }
        else
        {
            lbl_Closing_KM_Err.innerText = "";
            txtTotalKms.value=(parseFloat(txtCloseKM.value) - parseFloat(lblStartKm.innerText)).toString();;
            if((parseFloat(txtTotalKms.value)) > 10000)
            {
                txtTotalKms.style.borderColor="red";
                lbl_Closing_KM_Err.innerText = "Trip sheet total km should not be greater than 10,000 Km!";
                txtCloseKM.focus();
                return false;
            }
            else
            {
                txtTotalKms.style.borderColor="";
                lbl_Closing_KM_Err.innerText = "";
                if((parseFloat(txtTotalKms.value)) > 5000)
                {
                    var ConFirmBox = confirm("Trip sheet total km is greater than 5,000 Km. \n\n Are you sure?");
                    if(ConFirmBox==false)
                    {
                        txtCloseKM.focus();
                        return false;
                    }
                }
                if(parseFloat(hfKMPL.value) != 0)
                {
                    txtApprovedDiesel.value = ((parseFloat(txtTotalKms.value) / parseFloat(hfKMPL.value)).toFixed(2)).toString();
                }
                else
                {
                    txtApprovedDiesel.value = "0.0";
                }
                if(parseFloat(txtApprovedDiesel.value) != 0)
                {
                    txtApprovedFuelAmt.value = ((parseFloat(txtApprovedDiesel.value)* parseFloat(lblAverageDieselRate.innerText)).toFixed(2)).toString();
                }
                else
                {
                    txtApprovedFuelAmt.value = "0.0";
                }
            }
        }
    }
    //if(txtFuelFilledEnroute.value != "" && txtFuelFilled.value != "" && txtTotalKms.value != "")
    if(txtFuelFilledEnroute.value != "" && txtTotalKms.value != "")
    {
        if(parseFloat(txtFuelFilledEnroute.value) != 0)
        {
            txtKMPL.value = (parseFloat(txtTotalKms.value) / parseFloat(txtFuelFilledEnroute.value)).toFixed(2);
        }
        else
        {
            txtKMPL.value ="0.0";
        }
    }
}


//function CheckValidRS(row_Index,ddlNExpense,ddlRouteSegment)
//{
//    var str_Index = "";
//    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gvEnroute").rows.length-2; intIndex++)
//    {
//        if (intIndex < 10)
//        {
//            str_Index = "0" + intIndex;
//        }
//        else
//        {
//            str_Index = intIndex;
//        }
//        if (row_Index == intIndex - 2)
//        {
//            continue;
//        }
//        
//        var D_ddlNExpense,D_ddlRouteSegment;
//        
//        D_ddlNExpense=document.getElementById("ctl00_MyCPH1_gvEnroute_ctl" + str_Index + "_ddlNExpense");
//        D_ddlRouteSegment=document.getElementById("ctl00_MyCPH1_gvEnroute_ctl" + str_Index + "_ddlRouteSegment");
//        
//        if (D_ddlNExpense.value == ddlNExpense.value && D_ddlRouteSegment.value == ddlRouteSegment.value)
//        {
//            alert("This Part already exist at row " + (intIndex - 1));
//            ddlRouteSegment.selectedIndex = 0;
//            ddlRouteSegment.focus();
//            return false;
//        }
//    }
//}



function ValidDateHSD(txtDate,lblIssueDt)
{
    var date = new Date()
    var lbl_OilExp_Expense = document.getElementById("ctl00_MyCPH1_lbl_OilExp_Expense");
    var d="",m="";
    
    d = date.getDate().toString();
    m = (date.getMonth()+1).toString();
    
    if(d.length == 1){d="0"+d;}
    if(m.length == 1){m="0"+m;}
    
    date = d + "/" + m + "/"+ date.getFullYear();
    
    if(txtDate.value=="")
    {
        lbl_OilExp_Expense.innerText = "";
        txtDate.style.borderColor = ""; 
        return true;
    }
    else
    {
        if(!isDate(txtDate.value,"dd/mm/yyyy"))
        {
            txtDate.style.borderColor = "red"; 
            lbl_OilExp_Expense.innerText = "Please Enter Valid date ( Format :: dd/mm/yyyy ) !!!";
            txtDate.value="";
            txtDate.focus();
            return false;
        }
        else
        {
            if(!IsDateGreater(date,txtDate.value))
            {
                txtDate.style.borderColor = "red"; 
                lbl_OilExp_Expense.innerText="Bill Date should not be greater than today's date for HSD/OIL Expenses!";
                txtDate.focus();
                return false;
            }
            else
            {
                txtDate.style.borderColor = ""; 
                lbl_OilExp_Expense.innerText="";
            }
            if(!IsDateGreater(txtDate.value,lblIssueDt.innerText))
            {
                txtDate.style.borderColor = "red"; 
                lbl_OilExp_Expense.innerText="Bill Date should not be less than Issue Slip Date for HSD/OIL Expenses!";
                txtDate.focus();
                return false;
            }
            else
            {
                txtDate.style.borderColor = ""; 
                lbl_OilExp_Expense.innerText="";
            }
            
        }
    }
}              
                    
function ValidDate(txtDate,lblIssueDt)
{
    var date = new Date()
    var lbl_Enroute_Err = document.getElementById("ctl00_MyCPH1_lbl_Enroute_Err");
    var d="",m="";
    
    d = date.getDate().toString();
    m = (date.getMonth()+1).toString();
    
    if(d.length == 1){d="0"+d;}
    if(m.length == 1){m="0"+m;}
    
    date = d + "/" + m + "/"+ date.getFullYear();
    
    if(txtDate.value=="")
    {
        lbl_Enroute_Err.innerText = "";
        txtDate.style.borderColor = ""; 
        return true;
    }
    else
    {
        if(!isDate(txtDate.value,"dd/mm/yyyy"))
        {
            txtDate.style.borderColor = "red"; 
            lbl_Enroute_Err.innerText = "Please Enter Valid date ( Format :: dd/mm/yyyy ) !!!";
            txtDate.value="";
            txtDate.focus();
            return false;
        }
        else
        {
            if(!IsDateGreater(date,txtDate.value))
            {
                txtDate.style.borderColor = "red"; 
                lbl_Enroute_Err.innerText="Bill Date should not be greater than today's date for En-route Expense details!";
                txtDate.focus();
                return false;
            }
            else
            {
                txtDate.style.borderColor = ""; 
                lbl_Enroute_Err.innerText="";
            }
            if(!IsDateGreater(txtDate.value,lblIssueDt.innerText))
            {
                txtDate.style.borderColor = "red"; 
                lbl_Enroute_Err.innerText="Bill Date should not be less than Issue Slip Date for En-route Expense details!";
                txtDate.focus();
                return false;
            }
            else
            {
                txtDate.style.borderColor = ""; 
                lbl_Enroute_Err.innerText="";
            }
            
        }
    }
}

function calculateBalance()
{
    var totadv="0.00",totamt="0.00";
    for(i=0;i< 20;i++)
    {  
        j=i+2
        var pref="";
        if(j<10)
        {
            pref = "ctl00$MyCPH1$dgEnroute$ctl0" + j + "$";
        }                                       
        else
        {         
            pref = "ctl00$MyCPH1$dgEnroute$ctl" + j + "$";
        }    
        var amt=document.getElementById(pref + "txtAmt");
        var EAmt=document.getElementById(pref + "txtEAmt");
        if(amt.value!="")
        {
            totadv=parseFloat(totadv) + parseFloat(amt.value);
        }
        if(EAmt.value!="")
        {
            totamt=parseFloat(totamt) + parseFloat(EAmt.value);
        }
    }
    document.getElementById("ctl00$MyCPH1$dgEnroute$ctl22$txtEnAmtTotal").value=totadv;       
    document.getElementById("ctl00$MyCPH1$dgEnroute$ctl22$txtETotalAmt").value=totamt;       
}

function GVcalculateBalance()
{
//    var txtETotalAmt = document.getElementById('<%=((TextBox)gvEnroute.FooterRow.FindControl("txtETotalAmt")).ClientID%>');
//    var txtEnAmtTotal = document.getElementById('<%=((TextBox)gvEnroute.FooterRow.FindControl("txtEnAmtTotal")).ClientID%>');
    
    var gvEnroute=document.getElementById("ctl00_MyCPH1_gvEnroute");
    var l = 0;
    l=gvEnroute.rows.length;
    
    var txtETotalAmt = document.getElementById("ctl00_MyCPH1_gvEnroute_ctl0" + l + "_txtETotalAmt");
    var txtEnAmtTotal = document.getElementById("ctl00_MyCPH1_gvEnroute_ctl0" + l + "_txtEnAmtTotal");
    var hfEnAmtTotal = document.getElementById("ctl00_MyCPH1_hfEnAmtTotal");
    var hfETotalAmt = document.getElementById("ctl00_MyCPH1_hfETotalAmt");
                       
    var totadv="0.00",totamt="0.00";
    
    for(i=0;i<l-2;i++)
    {
        j=i+2
        var pref="";
        if(j<10)
        {
            pref = "ctl00_MyCPH1_gvEnroute_ctl0" + j + "_";
        }                                       
        else
        {         
            pref = "ctl00_MyCPH1_gvEnroute_ctl" + j + "_";
        }   
        
        var amt=document.getElementById(pref + "txtAmount");
        var EAmt=document.getElementById(pref + "txtEAmt");
        var hfPolarity=document.getElementById(pref + "hfPolarity");
        if(hfPolarity.value == "+")
        {
            if(amt.value!="")
            {
                totadv=parseFloat(totadv) + parseFloat(amt.value);
            }
            if(EAmt.value!="")
            {
                totamt= parseFloat(totamt) + parseFloat(EAmt.value);
            }
        }
        else if (hfPolarity.value == "-")
        {
            if(amt.value!="")
            {
                totadv=parseFloat(totadv) - parseFloat(amt.value);
            }
            if(EAmt.value!="")
            {
                totamt= parseFloat(totamt) - parseFloat(EAmt.value);
            }
        }
    }
    txtEnAmtTotal.value=totadv;       
    txtETotalAmt.value=totamt;    
    hfEnAmtTotal.value=totadv;   
    hfETotalAmt.value=totamt;    
}

function validFloat(event,txtid)
{
    var tb=document.getElementById(txtid);
    var txt=tb.value;
    if(event.keyCode==13)
    return true;

    if(event.keyCode==46)
    if(txt.indexOf('.')!=-1)
    event.keyCode=0;
    
    if((event.keyCode<46 || event.keyCode>57) || event.keyCode==47)
    {event.keyCode=0;return false;}
} 


</script>


    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Trip Sheet >> Close Vehicle Issue Slip </asp:Label>
               <%-- <hr align="center" size="1" color="#8ba0e5">--%>
            </td>
            
             <td align=right>
                <asp:UpdateProgress ID="UpdateProgress2" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color="red"><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  
         
          </td>      
        </tr>
    </table>
    
    
    <hr align="center" size="1" color="#8ba0e5">
      <br />
      
                           
        <%--<table cellspacing="1" cellpadding="3" style="width: 100%" align="left" class="boxbg" border="0">
            
        <tr style="background-color: white">
            <td colspan="4" align="left" >--%>
               

                    <table cellspacing="1" cellpadding="3" style="width: 95%" align="left" class="boxbg" border="0">
                        <tr style="background-color: white">
                            <td colspan="4" align="left">
                                <asp:Label ID="lblError"  runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
                                <asp:Label ID="lblError1"  runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
                                
                            </td>
                        </tr>
                        <tr class="bgbluegrey">
                            <td colspan="4" align="left">
                                <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="CLOSE/UPDATE VEHICLE ISSUE SLIP"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td colspan=4 align=left style="background-color: white">   
                                <table border="1" cellpadding="1" cellspacing="0" class="boxbg" width="700px">
                                    <tr style="background-color: white">
                                        <td align="left" >
                                            <font class="bluefnt">Issue Slip Id</font>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblIssueNo" runat="server" CssClass="blackfnt"></asp:Label>
                                        </td>
                                        <td align="left">
                                            <font class="bluefnt">Manual Tripsheet No.</font>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblManualNo" runat="server" CssClass="blackfnt"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr style="background-color: white">
                                        <td align="left">
                                            <font class="bluefnt">Issue Slip Date</font>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblIssueDt" runat="server" CssClass="blackfnt"></asp:Label>
                                        </td>
                                        <td align="left" >
                                            <font class="bluefnt">Issue Slip Close Date</font>
                                        </td>
                                        <td align="left">
                                            <SControls:DateSelector     ID="txtDateFrom" runat="server" /> 
                                        </td>
                                    </tr>
                                    <tr style="background-color: white">
                                        <td align="left" >
                                            <font class="bluefnt">Starting Location</font>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblStartLoc" runat="server" CssClass="blackfnt"></asp:Label>
                                        </td>
                                        <td align="left">
                                            <font class=bluefnt>End Location</font>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblEndLoc" runat="server" CssClass="blackfnt"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr style="background-color: white">
                                        <td align="left" >
                                            <font class="bluefnt">Category</font>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblCategory" runat="server" CssClass="blackfnt"></asp:Label>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblCustCodeHead" runat="server" CssClass="bluefnt"  Text="Customer Code"  Visible="false"></asp:Label>
                                            <asp:Label ID="lblMarketHead" runat="server" CssClass="bluefnt"  Text="Market/Own"  Visible="false"></asp:Label>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblCustcodeMarket" runat="server" CssClass="blackfnt"></asp:Label>
                                        </td>
                                        </tr>
                                    <tr  style="background-color: white">
                                        <td >
                                            <font class="bluefnt">Route</font>
                                        </td>
                                        <td colspan="3" >
                                            <asp:Label ID="lblRoute" runat="server" CssClass="blackfnt"></asp:Label>
                                        </td> 
                                    </tr>
                                    <%if (lblCategory.Text=="External Usage"){ %>
                                    <tr  style="background-color: white">
                                        <td><font class="bluefnt">Enter no. of THCs</font></td>
                                        <td colspan="3" >
                                            <font class="bluefnt">
                                             
                                                <asp:TextBox ID="txtAddTHCrow" runat="server" MaxLength="3" Width="30" BorderStyle="Groove"
                                                OnTextChanged="add_rowTHC" AutoPostBack="true"></asp:TextBox>
                                             
                                            </font>
                                        </td>
                                    </tr>
                                    <tr style="background-color: white">
                                        <td colspan="4">

                                            <asp:DataGrid ID="dgTHC" runat="server" AutoGenerateColumns="False" CellPadding="2"
                                            CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                            BorderWidth="3px" Width="100%" OnItemDataBound="dgTHCDet_ItemDataBound">
                                            <Columns>
                                            <asp:TemplateColumn HeaderText="Sr.No.">
                                                <ItemTemplate>
                                                    <center>
                                                        <%# Container.ItemIndex+1 %>
                                                        .
                                                        <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                    </center>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            
                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="From">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtFrom" runat="server"   Width="150px" BorderStyle="Groove" MaxLength="100" CssClass="input"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="reqFrom" runat="server" Display="Dynamic" Text="!" ValidationGroup="VGDtFromTo" ControlToValidate="txtFrom"></asp:RequiredFieldValidator>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="To">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtTo" runat="server" MaxLength="100" Width="150px" BorderStyle="Groove" CssClass="input"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="reqTo" runat="server" Display="Dynamic" Text="!" ValidationGroup="VGDtFromTo" ControlToValidate="txtTo"></asp:RequiredFieldValidator>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" Wrap="False" />
                                            </asp:TemplateColumn>

                                            <asp:TemplateColumn HeaderText="THC No.">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtTHCNo" runat="server"   Width="100px"
                                                    BorderStyle="Groove" MaxLength="100" CssClass="input"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="reqTHCNo" runat="server" Display="Dynamic" Text="!"
                                                    ValidationGroup="VGDtFromTo" ControlToValidate="txtTHCNo"></asp:RequiredFieldValidator>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                    Font-Underline="False" Wrap="False" />
                                            </asp:TemplateColumn>

                                            <asp:TemplateColumn HeaderText="THC Date">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtTHCDt" runat="server"   Width="65px" 
                                                    BorderStyle="Groove" MaxLength="10" CssClass="input"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="reqTHCDt" runat="server" Display="Dynamic" Text="!"
                                                    ValidationGroup="VGDtFromTo" ControlToValidate="txtTHCDt"></asp:RequiredFieldValidator>
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                     Font-Underline="False" Wrap="False" />
                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                     Font-Underline="False" Wrap="False" />
                                            </asp:TemplateColumn>

                                            <asp:TemplateColumn HeaderText="Freight Amount">
                                            <ItemTemplate>
                                            <asp:TextBox ID="txtFreightAmt" runat="server"   Width="60px"
                                            BorderStyle="Groove" MaxLength="6" CssClass="input" AutoPostBack=true OnTextChanged="CalcTHCContractAmt"></asp:TextBox>


                                            <asp:RequiredFieldValidator ID="reqFreightAmt" runat="server" Display="Dynamic" Text="!"
                                            ValidationGroup="VGDtFromTo" ControlToValidate="txtFreightAmt"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegFreightAmt" runat="server" ErrorMessage="!"
                                            ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true" ControlToValidate="txtFreightAmt"
                                            Display="Dynamic"></asp:RegularExpressionValidator>



                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                            </asp:TemplateColumn>


                                            <asp:TemplateColumn HeaderText="Labour charge">
                                            <ItemTemplate>
                                            <asp:TextBox ID="txtLabourChrg" runat="server"   Width="60px"
                                            BorderStyle="Groove" MaxLength="6" CssClass="input" AutoPostBack=true OnTextChanged="CalcTHCContractAmt"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="reqLabourChrg" runat="server" Display="Dynamic" Text="!"
                                            ValidationGroup="VGDtFromTo" ControlToValidate="txtLabourChrg"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegLabourChrg" runat="server" ErrorMessage="!"
                                            ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true" ControlToValidate="txtLabourChrg"
                                            Display="Dynamic"></asp:RegularExpressionValidator>

                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                            </asp:TemplateColumn>

                                            <asp:TemplateColumn HeaderText="Other charge" >
                                            <ItemTemplate>
                                            <asp:TextBox ID="txtOtherChrg" runat="server"   Width="60px"
                                            BorderStyle="Groove" MaxLength="6" CssClass="input" AutoPostBack=true OnTextChanged="CalcTHCContractAmt"></asp:TextBox>

                                            <asp:RequiredFieldValidator ID="reqOtherChrg" runat="server" Display="Dynamic" Text="!"
                                            ValidationGroup="VGDtFromTo" ControlToValidate="txtOtherChrg"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegOtherChrg" runat="server" ErrorMessage="!"
                                            ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true" ControlToValidate="txtOtherChrg"
                                            Display="Dynamic"></asp:RegularExpressionValidator>

                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                            </asp:TemplateColumn>

                                            <asp:TemplateColumn HeaderText="Total">
                                            <ItemTemplate>
                                            <asp:TextBox ID="txtTHCTotalAmt"  style="text-align: right"  runat="server"   Width="60px"
                                            BorderStyle="Groove" MaxLength="6" ReadOnly="true" CssClass="input"></asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                            </asp:TemplateColumn>


                                            </Columns>
                                            <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                            ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                            <FooterStyle BackColor="White" ForeColor="#000066" />
                                            <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                            <ItemStyle ForeColor="#000066" />
                                            <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey" Font-Italic="False"
                                            Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                        </asp:DataGrid>

             
                                    </td>
                                </tr>

                                <tr style="background-color: white">
                                    <td><font class="bluefnt"><b>Total Freight Amount</b></font></td>
                                    <td><asp:Label ID="TotFreightChrg" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label></td>
                                    <td><font class="bluefnt"><b>Total Labour Charge</b</font></td>
                                    <td><asp:Label ID="TotLabourChrg" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label></td>
                                </tr>  

                                <tr style="background-color: white">
                                    <td><font class="bluefnt"><b>Total Other Amount</b</font></td>
                                    <td><asp:Label ID="TotOtherChrg" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label></td>
                                    <td><font class="bluefnt"><b>Total Amount</b</font></td>
                                    <td><asp:Label ID="TotChrg" runat="server" CssClass="blackfnt" Font-Bold="true"></asp:Label></td>
                                </tr> 

                            <%} %>
                                              
              </table>
                 </td>
            </tr>
            <tr>
     <td colspan=4 align=left style="background-color: white">   
       <table border="1" cellpadding="1" cellspacing="0"  class="boxbg" width="700px">
       <tr style="background-color: white" >
              <td align="left" colspan="4" >
                  <font class="redfnt">
                  <asp:HiddenField ID="hfApprovedAmt" runat="server" Value="" /> 
                      <asp:Label ID="lbl_Closing_KM_Err" runat="server" Text=""></asp:Label></font>
                </td>
            </tr>
       
       
         <tr style="background-color: white" >
              <td align="left"  >
                  <font class="bluefnt">Vehicle No.</font>
                </td>
                <td align="left">
                    <asp:Label ID="lblVehno" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
                
                <td align="left" >
                  <font class="bluefnt">Driver</font>
                </td>
                <td align="left">
                  <asp:Label ID="lblDriverName" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
                
            </tr>
            
            <tr style="background-color: white" >
              <td align="left"  >
                  <font class="bluefnt">Vehicle Type</font>
                </td>
                <td align="left">
                    <asp:Label ID="lblFTLType" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
                
                <td colspan="2">
                  
                </td>
                
                
            </tr>
            
            
             <tr style="background-color: white">
              <td align="left" >
                  <font class="bluefnt">Driver License No.</font>
                </td>
                <td align="left">
                   <font class="bluefnt" >
                        <asp:Label ID="lblLicno" runat="server" CssClass="balckfnt"></asp:Label>
                   </font>
                </td>
                
                <td align="left" >
                  <font class="bluefnt">License Valid upto</font>
                </td>
                <td align="left">
                   <font class="bluefnt" >
                   <asp:Label ID="lblValidDt" runat="server" CssClass="balckfnt"></asp:Label>
                   </font>
                </td>
                
            </tr>
            
            
             <tr style="background-color: white">
              <td align="left" >
                  <font class="bluefnt">Starting Km. Reading</font>
                </td>
                <td align="left">
                    <asp:Label ID="lblStartKm" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
                <td align="left" >
                  <font class="bluefnt">Closing Km. Reading</font>
                </td>
                <td align="left"> 
          
               
                    <asp:TextBox ID="txtCloseKM"  style="text-align: right"  runat="server" BorderStyle="Groove" Width="100" MaxLength="6"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"    CssClass="input" ></asp:TextBox>
                     <asp:RequiredFieldValidator ID="reqCloseKM" runat="server" Display="Dynamic" Text="!"   ValidationGroup="VGDtFromTo"     ControlToValidate="txtCloseKM"></asp:RequiredFieldValidator>

                </td>
                
                
                
                </tr>
                
                <tr style="background-color: white">
                 <td align="left" >
                  <font class="bluefnt">Fuel Filled enroute</font>
                </td>
                 <td align="left">
             
                 
                    <asp:TextBox ID="txtFuelFilledEnroute" runat="server"   Text="0"   BorderStyle="None"  Width="100" MaxLength="6" ></asp:TextBox><%--AutoPostBack="true"    OnTextChanged="txtFuelFilledEnroute_TextChanged"--%>
                    <%-- <asp:RequiredFieldValidator ID="ReqFuelFilledEnroute"  ValidationGroup="VGDtFromTo"     runat="server" Display="Dynamic" Text="!" ControlToValidate="txtFuelFilledEnroute"></asp:RequiredFieldValidator>--%>
                                              


                </td>
                <td align="left" >
                  <%--<font class="bluefnt">Fuel filled Ltrs.</font>--%>
                </td>
                 <td align="left" >
                   <asp:TextBox ID="txtFuelFilled"   Visible="false"  BorderStyle="none"  runat="server" CssClass="blackfnt" />
                </td>
                
               
                </tr>
           
           
             <tr style="background-color: white">
             <td align="left" >
                  <font class="bluefnt">Total Kms.</font>
                </td>
                <td align="left"> 
                
              
                    <asp:TextBox ID="txtTotalKms" style="text-align: right"  runat="server" BorderStyle="none" Width="100" MaxLength="6" ></asp:TextBox>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" Text="!"   ValidationGroup="VGDtFromTo"     ControlToValidate="txtCloseKM"></asp:RequiredFieldValidator>
                                                   

              


                </td>
           
           <td  >
             <font class="bluefnt">Actual KMPL</font>
           
           
           
           
           
           </td>
           
           
          <td>
               
              <asp:TextBox ID="txtKMPL" style="text-align: right"  CssClass="blackfnt" runat="server" BorderStyle="None" ></asp:TextBox>
           </td> 
           
           
           
           </tr>
           
                <tr style="background-color: white">
             <td align="left" >
                  <font class="bluefnt">Approved KMPL.</font>
                </td>
                <td align="left"> 
              
                    <asp:TextBox ID="txtApprKMPL" style="text-align: right"  BorderStyle="None" Width="100" MaxLength="6"   CssClass="blackfnt"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   runat="server"></asp:TextBox>
                <%--<asp:RequiredFieldValidator ID="ReqtxtApprKMPL" runat="server" Display="Dynamic" Text="!"   ValidationGroup="VGDtFromTo"     ControlToValidate="txtApprKMPL"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegApprKMPL" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtApprKMPL" Display="Dynamic"></asp:RegularExpressionValidator>--%>
              </td>
              <td align="left" >
                  <font class="bluefnt">Approved Diesel (liters)</font>
                </td>
                <td align="left"> 
                    
                    <asp:TextBox ID="txtApprovedDiesel" style="text-align: right"  runat="server" CssClass="blackfnt" Text="" BorderStyle="None"  />              
                    <asp:HiddenField ID="hfKMPL" runat="server" />
              </td>
              
              
              </tr>
              
            
              
              
               <tr style="background-color: white">
             <td align="left" >
                  <font class="bluefnt">Average Diesel Rate</font>
                </td>
                <td align="left"> 
                    <asp:Label ID="lblAverageDieselRate" style="text-align: right" runat="server" CssClass="blackfnt" Text=""></asp:Label>              
                </td>
              <td align="left" >
                  <font class="bluefnt">Approved Fuel Amount</font>
                </td>
                <td align="left"> 
                    <asp:TextBox ID="txtApprovedFuelAmt" style="text-align: right" CssClass="blackfnt" runat="server" BorderStyle="None" ></asp:TextBox>
                </td>
              
              
              </tr>
              
              
     
            
             <tr style="background-color: white">
                <td colspan="4" align="center">
            
                              <table border="0" Width="100%">
                                 <tr>
                                    <td style="text-align: left">
                                    
                                    <asp:DataGrid ID="dgAdvanceDet" runat="server" AutoGenerateColumns="False"
                                                    CellPadding="2" CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                                    BorderWidth="3px" Width="100%" OnItemDataBound="dgAdvanceDet_ItemDataBound">
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
                                                        
                                                        <asp:TemplateColumn HeaderText="Place">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtAdvPlace"     runat="server"  ReadOnly="true"    CssClass="input" Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqAdvPlace" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtAdvPlace"></asp:RequiredFieldValidator>
                                                                
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Advance Date">
                                                            <ItemTemplate>
                                                                  <asp:TextBox ID="txtAdvDt" CssClass="input"  runat="server" MaxLength="10"  ReadOnly="true"     Width="65" BorderStyle="Groove"></asp:TextBox>
                                                                  <asp:RequiredFieldValidator ID="reqAdvDt" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtAdvDt"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="REVAdvDt" runat="server" ControlToValidate="txtAdvDt"
                                                            ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                                            Width="1px"></asp:RegularExpressionValidator>
                                                        </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="Amount">
                                                            <ItemTemplate>
                                                            <asp:TextBox ID="txtAdvAmt" style="text-align: right"  runat="server"  Width="60px" BorderStyle="None" MaxLength="6"></asp:TextBox>
                                                              <%--  <asp:RequiredFieldValidator ID="reqAdvAmt" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtAdvAmt"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegAdvAmt" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtAdvAmt" Display="Dynamic"></asp:RegularExpressionValidator>--%>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Branch Name">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtBranchCode" runat="server"  ReadOnly="true"   CssClass="input" Width="100px" BorderStyle="Groove" MaxLength="15"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqBranchCode" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtBranchCode"></asp:RequiredFieldValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="Advance paid by">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtSignature" runat="server"  ReadOnly="true"    CssClass="input" Width="100px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                                                                <asp:RequiredFieldValidator ID="reqSignature" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtSignature"></asp:RequiredFieldValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        </Columns>
                                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                                        ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <ItemStyle ForeColor="#000066" />
                                                    <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey"
                                                        Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                                </asp:DataGrid>
                                    
                                    
                                    
                                     
                                    </td>
                                 </tr>
                               </table>  
                                      
                                                        

                </td>
            </tr>
              
         </table>
        </td>
      </tr>              
            
            
            <tr class="bgbluegrey">
                <td colspan=4 align="left"><font class=blackfnt><b>HSD/OIL Expenses</b></font></td>
            </tr>
            
            <tr style="background-color: white">
                <td width="5%" nowrap><font class="blackfnt">Enter no. of rows</font></td>
                <td colspan="3" align="left"><asp:TextBox ID="txtAddRowOilExp" runat="server" MaxLength="3" Width="30"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  BorderStyle="Groove" OnTextChanged="add_rowOil" AutoPostBack=true ></asp:TextBox></td>
            </tr>
            
            <tr style="background-color: white">
                <td colspan="4" align="center">
                 <asp:UpdatePanel ID="UpdatePanel4" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                <ContentTemplate> 
                    <table border="0" Width="100%">
                        <tr align="left">
                            <td>
                                <font class="redfnt">
                                <asp:Label ID="lbl_OilExp_Expense" runat="server" Text=""></asp:Label></font>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: left">
                                <asp:DataGrid ID="dgHSD_OIL_EXP" runat="server" AutoGenerateColumns="False"
                                CellPadding="2" CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                BorderWidth="3px" Width="100%" OnItemDataBound="dgHSD_OIL_EXP_ItemDataBound" >
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
                                    
                                    <asp:TemplateColumn HeaderText="Place">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtOilPlace" runat="server" CssClass="input" Width="80px" BorderStyle="Groove" MaxLength="50" Enabled=false ></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="reqOilPlace" runat="server" Display="Dynamic" Text="!"   ValidationGroup="VGDtFromTo" ControlToValidate="txtOilPlace"></asp:RequiredFieldValidator>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="Petrol Pump Name">
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlPPName" runat="server" CssClass="input" Width="100px" BorderStyle="Groove" MaxLength="50" Enabled=false></asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="reqPPName" runat="server" Display="Dynamic" Text="!" ValidationGroup="VGDtFromTo"    ControlToValidate="ddlPPName"></asp:RequiredFieldValidator>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="True" />
                                    </asp:TemplateColumn>
                                    
                                    
                                    <asp:TemplateColumn HeaderText="Brand">
                                        <ItemTemplate>
                                            <asp:DropDownList ID="ddlBrand" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="50" Enabled=false></asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="reqBrand" runat="server" Display="Dynamic" Text="!"  ValidationGroup="VGDtFromTo"   ControlToValidate="ddlBrand"></asp:RequiredFieldValidator>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:TemplateColumn>
                                        
                                   <asp:TemplateColumn HeaderText="Fuel Type">
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlFuelType" runat="server" CssClass="input" Width="70px" BorderStyle="Groove" Enabled=false></asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="reqFuelType" runat="server" Display="Dynamic" Text="!"   ValidationGroup="VGDtFromTo" ControlToValidate="ddlFuelType"></asp:RequiredFieldValidator>
                                    </ItemTemplate>
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    </asp:TemplateColumn>
                                
                                
                                
                                
                                   <asp:TemplateColumn HeaderText="Last Km Reading">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtLKmRead" Width="50px" BorderStyle="None" runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="True" />
                                    </asp:TemplateColumn>
                                
                                        
                                 <asp:TemplateColumn HeaderText="KM Reading">
                                    <ItemTemplate>
                                    <asp:TextBox ID="txtKM_Reading" runat="server" CssClass="input" Width="60px" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"    BorderStyle="Groove" MaxLength="6" Enabled="false"></asp:TextBox> <%--AutoPostBack="True" OnTextChanged="txtKM_Reading_TextChanged" --%>
                                       
                                    <asp:RequiredFieldValidator ID="reqKM_Reading" runat="server" Display="Dynamic" Text="!"  ValidationGroup="VGDtFromTo" ControlToValidate="txtKM_Reading"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegKM_Reading" runat="server"
                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                        ControlToValidate="txtKM_Reading" Display="Dynamic"></asp:RegularExpressionValidator>
                                          
                                    </ItemTemplate>
                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="False" />
                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                        Font-Underline="False" Wrap="True" />
                                </asp:TemplateColumn>
                                        
                                         <asp:TemplateColumn HeaderText="Bill No.">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtBillno" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="25" Enabled=false></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="reqBillno" runat="server" Display="Dynamic" Text="!"  ValidationGroup="VGDtFromTo"  ControlToValidate="txtBillno"></asp:RequiredFieldValidator>
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                        </asp:TemplateColumn> 
                                        
                                         <asp:TemplateColumn HeaderText="Bill Date">
                                            <ItemTemplate>
                                                  <asp:TextBox ID="txtBilldt" runat="server" MaxLength="10" Width="65" BorderStyle="groove" CssClass="input"   Enabled="false"></asp:TextBox>
                                                  <%--<asp:RequiredFieldValidator ID="reqBilldt" runat="server" Display="Dynamic" Text="!" ValidationGroup="VGDtFromTo"  ControlToValidate="txtBilldt"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="REVBilldt" runat="server" ControlToValidate="txtBilldt"
                                            ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                            Width="1px"></asp:RegularExpressionValidator>--%>
                                        </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="True" />
                                        </asp:TemplateColumn>
                                        
                                        
                                        <asp:TemplateColumn HeaderText="Diesel (Qtn. in litres)">
                                            <ItemTemplate>
                                            <asp:TextBox ID="txtDiesel_Ltr" runat="server" CssClass="input" Width="60px"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  BorderStyle="Groove" MaxLength="6" Enabled="false" /><%--OnTextChanged="Diesel_Oil_Calc" AutoPostBack="true" --%>
                                                <%--<asp:RequiredFieldValidator ID="reqDiesel_Ltr" runat="server" Display="Dynamic" Text="!" ValidationGroup="VGDtFromTo"   ControlToValidate="txtDiesel_Ltr"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegDiesel_Ltr" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtDiesel_Ltr" Display="Dynamic"></asp:RegularExpressionValidator>--%>
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="True" />
                                        </asp:TemplateColumn>
                                        
                                         <asp:TemplateColumn HeaderText="Diesel Rate/litres">
                                            <ItemTemplate>
                                            <asp:TextBox ID="txtDieselRate_Ltr" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"    MaxLength="6" Enabled=false></asp:TextBox><%--OnTextChanged="Diesel_Oil_Calc" AutoPostBack=true --%>
                                                <asp:RequiredFieldValidator ID="reqDieselRate_Ltr" runat="server" Display="Dynamic" Text="!"   ValidationGroup="VGDtFromTo" ControlToValidate="txtDieselRate_Ltr"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegDieselRate_Ltr" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtDieselRate_Ltr" Display="Dynamic"></asp:RegularExpressionValidator>
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="True" />
                                        </asp:TemplateColumn>
                                        
                                        <asp:TemplateColumn HeaderText="Amount">
                                            <ItemTemplate>
                                            <asp:TextBox ID="txtAmt" runat="server" Width="60px" BorderStyle="None" MaxLength="6"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"  Enabled=false></asp:TextBox>
                                               <%-- <asp:RequiredFieldValidator ID="reqAmt" runat="server" Display="Dynamic" Text="!"  ValidationGroup="VGDtFromTo" ControlToValidate="txtAmt"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegAmt" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtAmt" Display="Dynamic"></asp:RegularExpressionValidator>--%>
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                        </asp:TemplateColumn>
                                        
                                        
                                        
                                         <asp:TemplateColumn HeaderText="Amount Approved By Fleet Executive">
                                            <ItemTemplate>
                                            <asp:TextBox ID="txtExeAmt" runat="server" CssClass="input" Width="60px" BorderStyle="Groove" MaxLength="6"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   ReadOnly=false Enabled=false></asp:TextBox>
                                                <asp:RequiredFieldValidator ID="reqExeAmt" runat="server" Display="Dynamic" Text="!"  ValidationGroup="VGDtFromTo" ControlToValidate="txtExeAmt"></asp:RequiredFieldValidator>
                                                <asp:RegularExpressionValidator ID="RegExeAmt" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtExeAmt" Display="Dynamic"></asp:RegularExpressionValidator>
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="True" />
                                        </asp:TemplateColumn>
                                        
                                        
                                        
                                        
                                        
                                        
                                            <asp:TemplateColumn HeaderText="By Card/Cash">
                                            <ItemTemplate>
                                            <asp:DropDownList ID="ddlPayment" runat="server" CssClass="input" Width="80px" BorderStyle="Groove" Enabled=false OnSelectedIndexChanged="CardNo_Dispaly" AutoPostBack=true>
                                               <asp:ListItem Value="0" Text="select" />
                                               <asp:ListItem Value="1" Text="Cash" />
                                               <asp:ListItem Value="2" Text="Diesel Card" />
                                            </asp:DropDownList>
                                            <BR>
                                            <asp:Label ID="FCCard" runat="server"></asp:Label>
                                                <asp:RequiredFieldValidator ID="reqPayment" runat="server" Display="Dynamic" Text="!"  ValidationGroup="VGDtFromTo" ControlToValidate="ddlPayment"></asp:RequiredFieldValidator>

                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="True" />
                                        </asp:TemplateColumn>
                                        
                                            <asp:TemplateColumn HeaderText="Remarks">
                                            <ItemTemplate>
                                            <asp:TextBox ID="txtRemarks" runat="server" CssClass="input" Width="80px" BorderStyle="Groove"  ReadOnly=false Enabled=false></asp:TextBox>
                                              
                                            </ItemTemplate>
                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                Font-Underline="False" Wrap="False" />
                                        </asp:TemplateColumn>
                                                                                              
                                           </Columns>
                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                        ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                    <SelectedItemStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                    <ItemStyle ForeColor="#000066" />
                                    <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey"
                                        Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                                </asp:DataGrid>
                    
                    
                    
                     
                    </td>
                 </tr>
               </table>  
                </ContentTemplate>
                    <Triggers>
                                        
                        <asp:AsyncPostBackTrigger ControlID="txtAddRowOilExp" EventName="TextChanged" />
                                       
                    </Triggers>
                 </asp:UpdatePanel> 
                 
               </td>
            </tr>
               
                               
    <tr>
     <td colspan=4 align=left style="background-color: white">  

            <tr class="bgbluegrey">
                <td colspan="4" align="left">
                    <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Font-Bold="true" Text="En-route Expenses"></asp:Label></td>
            </tr>
            
            
            <tr style="background-color: white">
                <td width="5%" nowrap><font class="blackfnt">Enter no. of rows</font></td>
                <td colspan=3 align="left">
                    <asp:HiddenField ID="hfRouteDesc" runat="server" />
                    <asp:HiddenField ID="hfRouteCode" runat="server" />
                    
                    <asp:UpdatePanel ID="u1" runat ="server" UpdateMode="Always" RenderMode="Inline" >
                    <ContentTemplate >
                        <asp:TextBox ID="tb_Row_No" runat="server" Text="0" MaxLength="2" Width="20px" AutoPostBack="true"  BorderStyle="Groove" OnTextChanged="tb_Row_No_TextChanged"  ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_tb_Row_No" runat="server" ControlToValidate="tb_Row_No"  ErrorMessage="Required Field!"></asp:RequiredFieldValidator>
                    </ContentTemplate>
                </asp:UpdatePanel></td>
            </tr>
            
                
                                    
                     <tr style="background-color: white" align="left">
                <td colspan="4">
                   
                  <asp:UpdatePanel ID="u2" runat="server" UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                      
                                <font class="redfnt">
                                <asp:Label ID="lbl_Enroute_Err" runat="server" Text=""></asp:Label></font>
                       
                        <asp:GridView ID="gvEnroute" runat="server" CellPadding="2" CellSpacing="1" AutoGenerateColumns="False" SelectedIndex="1" OnRowDataBound="gvEnroute_RowDataBound" Width="700px" BorderColor="#006699" BorderStyle="None" BorderWidth="3px" CssClass="blackfnt" ShowFooter="True">
                            <Columns>
                                <asp:TemplateField HeaderText="SR.NO.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server" ></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" HorizontalAlign="Center" VerticalAlign="Middle"  />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Nature of Expense">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlNExpense" runat="server" Width="200px">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" Width="20%" VerticalAlign="Top" />
                                    <FooterTemplate>
                                        <asp:Label ID="lblTotal11" runat="server" Font-Bold="true" ReadOnly="true" Text="Total"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                
                               <asp:TemplateField HeaderText ="Amount Spent">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                    <ItemTemplate>
                                         <asp:TextBox ID="txtAmount" CssClass="input" Width="75px"  runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Amount") %>'  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   BorderStyle="Groove"       ></asp:TextBox>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txtEnAmtTotal" runat="server"  Font-Bold="true" BorderStyle="NONE" ></asp:TextBox>
                                    </FooterTemplate>
                                    <ItemStyle Width="20%" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                </asp:TemplateField>
                        
                                 <asp:TemplateField HeaderText="Bill No.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False"  />
                                    <ItemTemplate>
                                           <asp:TextBox ID="txtBillNo" runat="server" CssClass="input" Width="75px"  BorderStyle="Groove" ></asp:TextBox>

                                      
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" HorizontalAlign="Center"  VerticalAlign="Top" Font-Bold="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Bill date">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False"  />
                                    <ItemTemplate>
                                      <asp:TextBox ID="txtDate" runat="server"  CssClass="input" Width="75px" BorderStyle="Groove" ></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" HorizontalAlign="Center"  VerticalAlign="Top" Font-Bold="False" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Standard amount">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False"  />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtEAmt" runat="server" CssClass="input" Width="75px" onblur="javascript:return calculateBalance()"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"    Text='<%# DataBinder.Eval(Container.DataItem,"EAmt") %>'   BorderStyle="Groove" MaxLength="50" ></asp:TextBox>
                                        <asp:HiddenField ID="hfEAmt" runat="server" />     
                                        <asp:HiddenField ID="hfPolarity" runat="server" />              
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" HorizontalAlign="Center"  VerticalAlign="Top" Font-Bold="False" />
                                     <FooterTemplate>
                                                                <asp:TextBox ID="txtETotalAmt" runat="server"  Font-Bold="true"  BorderStyle="None" ></asp:TextBox>
                                                            </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Remarks">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="False"  />
                                    <ItemTemplate>
                                      <asp:TextBox ID="txtRemark"     runat="server"  CssClass="input" Width="100px" BorderStyle="Groove" MaxLength="50"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" HorizontalAlign="Center"  VerticalAlign="Top" Font-Bold="False" />
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle ForeColor="Black" Font-Bold="False" Font-Italic="False" Font-Size="8pt" CssClass="bgbluegrey" />
                        </asp:GridView>
                     </ContentTemplate>
                </asp:UpdatePanel>
                 <asp:HiddenField ID="hfEnAmtTotal" runat="server" />
                    <asp:HiddenField ID="hfETotalAmt" runat="server" />
                 </td></tr>                  
        
           
         
             <tr class="bgbluegrey">
                <td colspan=4 align="left" style="height: 19px"><font class=blackfnt><b>Verifying Authorities</b></font></td>
            </tr>
            
            
             <tr style="background-color: white">
                <td colspan=4>
                 <table cellspacing="1" cellpadding="3" style="width: 700px" align="left" class="boxbg" border="0">
            
                    
                    
                    <tr style="background-color: white">
                        <td align="center"><font class="blackfnt">Prepared By</font></td>
                        <td align="center"><font class="blackfnt">Checked By</font></td>
                        <td align="center"><font class="blackfnt">Apporved By</font></td>
                        <td align="center" ><font class="blackfnt">Audited By</font></td>
                    </tr> 
                    
                    <tr style="background-color: white">
                        <td align="center"><asp:TextBox ID="txtPreparedBy" runat="server" CssClass="input"   Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox></td>
                        <td align="center"><asp:TextBox ID="txtCheckedBy" runat="server" CssClass="input" Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox></td>
                        <td align="center"><asp:TextBox ID="txtApprovedBy" runat="server" CssClass="input" Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox></td>
                        <td align="center" rowspan=2 valign="top"><asp:TextBox ID="txtAuditedBy" CssClass="input" runat="server"  Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox></td>
                    </tr> 
                    
                    <tr style="background-color: white">
                        <td align="center"><font class="blackfnt">Fleet Accounts</font></td>
                        <td align="center"><font class="blackfnt">Fleet Manager</font></td>
                        <td align="center"><font class="blackfnt"><b>HOD</b></font></td>
                    </tr> 
                    </table>
                 
                </td>
               </tr>     
    

  <tr>
    <td colspan="4" align="left"  style="background-color: white">
    <asp:Button ID="cmdSubmit" runat="server" OnClientClick="javascript:return CheckEnRouteExpDetails()"   ValidationGroup="VGDtFromTo" Text="Submit" OnClick="SubmitData" /> 
    </td>
  </tr>   

               
     
  
  
 </table>
  
 
</asp:Content> 