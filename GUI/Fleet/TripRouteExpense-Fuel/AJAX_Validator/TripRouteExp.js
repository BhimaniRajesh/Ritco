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

function CheckValidataion()
{
   
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
*   CHECK KMPL
/*************************************************************************************************************/
function CheckKMPL(tb_KMPL,lbl_KMPL_Err)
{
    if(tb_KMPL.value =="")
    {
        tb_KMPL.style.borderColor="red";
        lbl_KMPL_Err.innerText="Enter KMPL !!!";
        tb_KMPL.focus();
        return false;
    }
    else
    {
        tb_KMPL.style.borderColor="";
        lbl_KMPL_Err.innerText="";
    }
}


/*************************************************************************************************************
*   CHECK VALID FTL TYPE WITH ROUTE SEGMENT AND FUEL EXPENSE
/*************************************************************************************************************/
function CheckValidVehType(row_Index,ddl_Vehicle_type,lbl_FTLtype_Err)
{
    var qs = new Querystring();
    var qId = qs.get("Id");
    var currentTime = new Date();
    var str_Index = "";
    var ddlRoute = document.getElementById("ctl00_MyCPH1_ddlRoute");
    var lbl_Route_Err=document.getElementById("ctl00_MyCPH1_lbl_Route_Err");
    var gvTripRouteExp=document.getElementById("ctl00_MyCPH1_gvTripRouteExp");
    
    if(ddlRoute.value == "0")
    {
        lbl_Route_Err.innerText="Select Trip Route First !!!";
        ddl_Vehicle_type.selectedIndex = 0;
        ddlRoute.focus();
        return false;
    }
    else
    {
        lbl_Route_Err.innerText="";
        if(ddl_Vehicle_type.value =="00")
        {
            lbl_FTLtype_Err.innerText ="Select FTL Type !!!";
            ddl_Vehicle_type.focus();
            return false;
        }
        else
        {
            lbl_FTLtype_Err.innerText ="";
        }
    }
    
    for (intIndex = 2; intIndex <= gvTripRouteExp.rows.length; intIndex++)
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
        var D_ddlFTLtype;
        D_ddl_Vehicle_type=document.getElementById("ctl00_MyCPH1_gvTripRouteExp_ctl" + str_Index + "_ddl_Vehicle_type");
        
        if (D_ddl_Vehicle_type.value == ddl_Vehicle_type.value)
        {
            lbl_FTLtype_Err.innerText="This Part already exist at row " + (intIndex - 1);
            ddl_Vehicle_type.selectedIndex = 0;
            ddl_Vehicle_type.focus();
            return false;
        }
        else
        {
            lbl_FTLtype_Err.innerText="";
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
                    lbl_FTLtype_Err.innerText="";
                    ddl_Vehicle_type.value=ddl_Vehicle_type.value;
                }
                else
                {
                    ddl_Vehicle_type.selectedIndex = 0;
                    lbl_FTLtype_Err.innerText="Already Exist !! ";
                    ddl_Vehicle_type.focus();
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/wfrm_AJAX_Validator.aspx?Function=CheckValidVehType&datetime="+currentTime+"&Id="+qId+"&RouteCode="+ ddlRoute.value +"&FTLtype="+ ddl_Vehicle_type.value, false);
        xmlHttpRequest.send(null);
    }	
}

function CheckValidataion()
{
    var ddlRoute=document.getElementById("ctl00_MyCPH1_ddlRoute");
    var lbl_Route_Err=document.getElementById("ctl00_MyCPH1_lbl_Route_Err");
    var gvTripRouteExp=document.getElementById("ctl00_MyCPH1_gvTripRouteExp");
    var tb_Avg_Diesel_Rate = document.getElementById("ctl00_MyCPH1_tb_Avg_Diesel_Rate");
    var lbl_Avg_Diesel_Rate_Err = document.getElementById("ctl00_MyCPH1_lbl_Avg_Diesel_Rate_Err");
    
    
    
    if (ddlRoute.value == "0")
    {
        lbl_Route_Err.innerText="Select Route !!!";
        ddlRoute.focus();
        return false;
    }
    else
    {
        
        lbl_Route_Err.innerText="";
    }
    if(parseFloat(tb_Avg_Diesel_Rate.value) == "0")
    {
        tb_Avg_Diesel_Rate.style.borderColor="red";
        lbl_Avg_Diesel_Rate_Err.innerText="Enter Diesel Rate!!!";
        tb_Avg_Diesel_Rate.focus();
        return false;
    }
    else
    {
        lbl_Avg_Diesel_Rate_Err.innerText = "";
    }
    var str_Index = "0";
    for (intIndex = 2; intIndex <= gvTripRouteExp.rows.length; intIndex++)
    {
        if (intIndex < 10)
        {
            str_Index = "0" + intIndex;
        }
        else
        {
            str_Index = intIndex;
        }
        var ddl_Vehicle_type,tb_KMPL,lbl_FTLtype_Err,lbl_KMPL_Err;
        ddl_Vehicle_type=document.getElementById("ctl00_MyCPH1_gvTripRouteExp_ctl" + str_Index + "_ddl_Vehicle_type");
        tb_KMPL=document.getElementById("ctl00_MyCPH1_gvTripRouteExp_ctl" + str_Index + "_tb_KMPL");
        lbl_FTLtype_Err=document.getElementById("ctl00_MyCPH1_gvTripRouteExp_ctl" + str_Index + "_lbl_FTLtype_Err");
        lbl_KMPL_Err=document.getElementById("ctl00_MyCPH1_gvTripRouteExp_ctl" + str_Index + "_lbl_KMPL_Err");
        
        if (ddl_Vehicle_type.value == "00")
        {
            lbl_FTLtype_Err.innerText="Select FTL Type !!!";
            ddl_Vehicle_type.focus();
            return false;
        }
        else
        {
            lbl_FTLtype_Err.innerText="";
        }
        if (tb_KMPL.value == "")
        {
            lbl_KMPL_Err.innerText="Enter KMPL !!!";
            tb_KMPL.style.borderColor="red";
            tb_KMPL.focus();
            return false;
        }
        else
        {
            lbl_KMPL_Err.innerText="";
            tb_KMPL.style.borderColor="";
        }
        
    }
}