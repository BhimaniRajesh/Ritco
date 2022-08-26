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
*   FILL ROUTE SEGMENT 
/*************************************************************************************************************/
//function PageLoad()
//{
//    var hfRS,ddlRoute,ddlRouteSegment;
//    hfRS=document.getElementById("ctl00_MyCPH1_hfRS");
//    ddlRoute=document.getElementById("ctl00_MyCPH1_ddlRoute");
//    ddlRouteSegment=document.getElementById("ctl00_MyCPH1_gvTripRouteExp_ctl02_ddlRouteSegment");
//    FillRouteSegment(0,ddlRoute,ddlRouteSegment);
//    ddlRouteSegment.value=hfRS.value;
//}

function FillRouteSegment(row_Index,ddlRoute,ddl_Vehicle_type,ddlFueExp)
{
    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gvTripRouteExp").rows.length; intIndex++)
    {
        if (intIndex < 10)
        {
            str_Index = "0" + intIndex;
        }
        else
        {
            str_Index = intIndex;
        }
        if (row_Index == intIndex - 1)
        {
            continue;
        }
        var D_ddl_Vehicle_type,D_ddlFueExp;
        D_ddl_Vehicle_type=document.getElementById("ctl00_MyCPH1_gvTripRouteExp_ctl" + str_Index + "_ddl_Vehicle_type");
        D_ddlFueExp=document.getElementById("ctl00_MyCPH1_gvTripRouteExp_ctl" + str_Index + "_ddlFueExp");
        //D_ddlRateType=document.getElementById("ctl00_MyCPH1_gvTripRouteExp_ctl" + str_Index + "_ddlRateType");
        D_ddl_Vehicle_type.selectedIndex = 0;
        D_ddlFueExp.selectedIndex = 0;
        //D_ddlRateType.selectedIndex = 0;
//        var part_num=0;
//        var selected_text = ddlRoute.options[ddlRoute.selectedIndex].text;
//        var RouteSegment=selected_text.split(",");
//        var ddlRouteSegment = document.getElementById("ctl00_MyCPH1_gvTripRouteExp_ctl" + str_Index + "_ddlRouteSegment");
//        removeAllOptions(ddlRouteSegment);
//        addOption(ddlRouteSegment, "Select", "0");
//        while (part_num < RouteSegment.length-1)
//        {
//            var rs = RouteSegment[part_num].toString() + "-" + RouteSegment[part_num + 1].toString(); 
//            addOption(ddlRouteSegment, rs, rs);
//            part_num+=1;
//        }
//        if(RouteSegment.length > 3)
//        {
//            var len = RouteSegment.length-1;
//            //if(RouteSegment[0].toString() != RouteSegment[len].toString()) 
//            {
//                while (len > 0)
//                {
//                    var rs1 = RouteSegment[len].toString() + "-" + RouteSegment[len - 1].toString(); 
//                    addOption(ddlRouteSegment, rs1, rs1);
//                    len-=1;
//                }
//            }
//        }
//        else
//        {
//            var len = RouteSegment.length-1;
//            if(RouteSegment[0].toString() != RouteSegment[len].toString()) 
//            {
//                while (len > 0)
//                {
//                    var rs1 = RouteSegment[len].toString() + "-" + RouteSegment[len - 1].toString(); 
//                    addOption(ddlRouteSegment, rs1, rs1);
//                    len-=1;
//                }
//            }
//        }
        
    }
}
/*************************************************************************************************************
*   REMOVE ALL ITEMS FROM DROPDOWN
/*************************************************************************************************************/
function removeAllOptions(selectbox)
{
    var i;
    for(i=selectbox.options.length-1;i>=0;i--)
    {
        selectbox.remove(i);
    }
}
/*************************************************************************************************************
*  ADD ITEMS IN DROPDOWN
/*************************************************************************************************************/
function addOption(selectbox,text,value)
{
    var optn = document.createElement("OPTION");
    optn.text = text;
    optn.value = value;
    selectbox.options.add(optn);
}


/*************************************************************************************************************
*   CHECK VALID ROUTE SEGMENT WITH FTL TYPE AND FUEL EXPENSE
/*************************************************************************************************************/
//function CheckValidRS(row_Index,ddlRateType,ddl_Vehicle_type,ddlFueExp)
//{
//    var qs = new Querystring();
//    var qId = qs.get("Id");
//    var currentTime = new Date();
//    var str_Index = "";
//    var ddlRoute = document.getElementById("ctl00_MyCPH1_ddlRoute");
//    if(ddlRoute.value == "0")
//    {
//        alert("Select Trip Route First !!!");
//        ddlRateType.selectedIndex = 0;
//        ddlRoute.focus();
//        return false;
//    }
//    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gvTripRouteExp").rows.length; intIndex++)
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
//        var D_ddlRateType,D_ddl_Vehicle_type,D_ddlFueExp;
//        D_ddlRateType=document.getElementById("ctl00_MyCPH1_gvTripRouteExp_ctl" + str_Index + "_ddlRateType");
//        D_ddl_Vehicle_type=document.getElementById("ctl00_MyCPH1_gvTripRouteExp_ctl" + str_Index + "_ddl_Vehicle_type");
//        D_ddlFueExp=document.getElementById("ctl00_MyCPH1_gvTripRouteExp_ctl" + str_Index + "_ddlFueExp");
//        if (D_ddlRateType.value == ddlRateType.value && D_ddl_Vehicle_type.value == ddl_Vehicle_type.value && D_ddlFueExp.value == ddlFueExp.value)
//        {
//            alert("This Part already exist at row " + (intIndex - 1));
//            ddlRateType.selectedIndex = 0;
//            ddlRateType.focus();
//            return false;
//        }
//    }
//    createXMLHttpRequest();
//    if (xmlHttpRequest)
//    {
//        xmlHttpRequest.onreadystatechange = function()
//        {
//            if (xmlHttpRequest.readyState == 4)
//            {
//                var returnValue=xmlHttpRequest.responseText.split("~");
//                if (returnValue[0] == "N") 
//                {
//                    ddlRateType.value=ddlRateType.value;
//                }
//                else
//                {
//                    alert("Already Exist !! ");
//                    ddlRateType.selectedIndex = 0;
//                    ddlRateType.focus();
//                }
//            }
//        }
//        xmlHttpRequest.open("GET", "AjaxResponse.aspx?Function=CheckValidRateType&datetime="+currentTime+"&Id="+qId+"&RouteCode="+ ddlRoute.value +"&RateType=" + ddlRateType.value+"&FTLtype="+ ddl_Vehicle_type.value +"&FueExp="+ ddlFueExp.value, false);
//        xmlHttpRequest.send(null);
//    }
//}
/*************************************************************************************************************
*   CHECK VALID FTL TYPE WITH ROUTE SEGMENT AND FUEL EXPENSE
/*************************************************************************************************************/
function CheckValidVehicleType(row_Index,ddl_Vehicle_type,ddlFueExp)
{
    var qs = new Querystring();
    var qId = qs.get("Id");
    var currentTime = new Date();
    var str_Index = "";
    var ddlRoute = document.getElementById("ctl00_MyCPH1_ddlRoute");
    if(ddlRoute.value == "0")
    {
        alert("Select Trip Route First !!!");
        ddl_Vehicle_type.selectedIndex = 0;
        ddlRoute.focus();
        return false;
    }
    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gvTripRouteExp").rows.length; intIndex++)
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
        var D_ddl_Vehicle_type,D_ddlFueExp;
        D_ddl_Vehicle_type=document.getElementById("ctl00_MyCPH1_gvTripRouteExp_ctl" + str_Index + "_ddl_Vehicle_type");
        D_ddlFueExp=document.getElementById("ctl00_MyCPH1_gvTripRouteExp_ctl" + str_Index + "_ddlFueExp");
        if (D_ddl_Vehicle_type.value == ddl_Vehicle_type.value && D_ddlFueExp.value == ddlFueExp.value)
        {
            alert("This Part already exist at row " + (intIndex - 1));
            ddl_Vehicle_type.selectedIndex = 0;
            ddl_Vehicle_type.focus();
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
                if (returnValue[0] == "N") 
                {
                    ddl_Vehicle_type.value=ddl_Vehicle_type.value;
                }
                else
                {
                    alert("Already Exist !! ");
                    ddl_Vehicle_type.selectedIndex = 0;
                    ddl_Vehicle_type.focus();
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckValidVehicleType&datetime="+currentTime+"&Id="+qId+"&RouteCode="+ ddlRoute.value +"&FTLtype="+ ddl_Vehicle_type.value +"&FueExp="+ ddlFueExp.value, false);
        xmlHttpRequest.send(null);
    }	
}
/*************************************************************************************************************
*   CHECK VALID FUEL EXPENSE WITH FTL TYPE AND ROUTE SEGMENT
/*************************************************************************************************************/
function CheckValidFUEL(row_Index,ddl_Vehicle_type,ddlFueExp)
{
    var qs = new Querystring();
    var qId = qs.get("Id");
    var currentTime = new Date();
    var str_Index = "";
    var ddlRoute = document.getElementById("ctl00_MyCPH1_ddlRoute");
    if(ddlRoute.value == "0")
    {
        alert("Select Trip Route First !!!");
        ddlFueExp.selectedIndex = 0;
        ddlRoute.focus();
        return false;
    }
    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gvTripRouteExp").rows.length; intIndex++)
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
        var D_ddl_Vehicle_type,D_ddlFueExp;
        //D_ddlRateType=document.getElementById("ctl00_MyCPH1_gvTripRouteExp_ctl" + str_Index + "_ddlRateType");
        D_ddl_Vehicle_type=document.getElementById("ctl00_MyCPH1_gvTripRouteExp_ctl" + str_Index + "_ddl_Vehicle_type");
        D_ddlFueExp=document.getElementById("ctl00_MyCPH1_gvTripRouteExp_ctl" + str_Index + "_ddlFueExp");
        if (D_ddl_Vehicle_type.value == ddl_Vehicle_type.value && D_ddlFueExp.value == ddlFueExp.value)
        {
            alert("This Part already exist at row " + (intIndex - 1));
            ddlFueExp.selectedIndex = 0;
            ddlFueExp.focus();
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
                if (returnValue[0] == "N") 
                {
                    ddlFueExp.value=ddlFueExp.value;
                }
                else
                {
                    alert("Already Exist !! ");
                    ddlFueExp.selectedIndex = 0;
                    ddlFueExp.focus();
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/AjaxResponse.aspx?Function=CheckValidFuelType&datetime="+currentTime+"&Id="+qId+"&RouteCode="+ ddlRoute.value +"&FTLtype="+ ddl_Vehicle_type.value +"&FueExp="+ ddlFueExp.value, false);
        xmlHttpRequest.send(null);
    }	
}
function CheckValidataion()
{
    var ddlRoute=document.getElementById("ctl00_MyCPH1_ddlRoute");
    if (ddlRoute.value == "0")
    {
        alert("Select Route !!!");
        ddlRoute.focus();
        return false;
    }
    var str_Index = "0";
    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gvTripRouteExp").rows.length; intIndex++)
    {
        if (intIndex < 10)
        {
            str_Index = "0" + intIndex;
        }
        else
        {
            str_Index = intIndex;
        }
        
        var ddlRateType,ddl_Vehicle_type,ddlFueExp,txtStandardRate;
        ddlRateType=document.getElementById("ctl00_MyCPH1_gvTripRouteExp_ctl" + str_Index + "_ddlRateType");
        ddl_Vehicle_type=document.getElementById("ctl00_MyCPH1_gvTripRouteExp_ctl" + str_Index + "_ddl_Vehicle_type");
        ddlFueExp=document.getElementById("ctl00_MyCPH1_gvTripRouteExp_ctl" + str_Index + "_ddlFueExp");
        txtStandardRate=document.getElementById("ctl00_MyCPH1_gvTripRouteExp_ctl" + str_Index + "_txtStandardRate");
        
        if (ddl_Vehicle_type.value == "0")
        {
            alert("Select Vehicle Type !!!");
            ddl_Vehicle_type.focus();
            return false;
        }
        if (ddlFueExp.value == "00")
        {
            alert("Select Fuel Expense !!!");
            ddlFueExp.focus();
            return false;
        }
        if (ddlRateType.value == "0")
        {
            alert("Select Trip Route Expense Rate !!!");
            ddlRateType.focus();
            return false;
        }
        if (txtStandardRate.value == "")
        {
            alert("Enter Standard Rate !!!");
            txtStandardRate.focus();
            return false;
        }
        
    }
}