// JScript File
var controlIdPrefix = "ctl00_MyCPH1_";
function numeric(e) { return ((e.keyCode == 8) || (e.keyCode > 47 && e.keyCode <58)||(e.keyCode > 95 && e.keyCode <106) || (e.keyCode == 9) || (e.keyCode == 46));  }
function createXMLHttpRequest() {
    // Mozilla, Safari,...
	if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
	// IE
	else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
}

function checkDocType(row_Index,txtDocType)
{
    var qs = new Querystring()
    var qDocId = qs.get("DOCUTYPEID")
    var currentTime = new Date()
    var str_Index = "";
    if (txtDocType.value == "")
    {
        txtDocType.value="";
        return;
    }
    for (intIndex = 2; intIndex <= document.getElementById(controlIdPrefix + "gvDocuType").rows.length; intIndex++)
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
        if (document.getElementById(controlIdPrefix + "gvDocuType_ctl" + str_Index + "_txtDocType").value == txtDocType.value)
        {
            alert("This Part already exist at row " + (intIndex - 1));
            txtDocType.value = "";
            txtDocType.focus();
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
                    alert("Document Type is Already Exist!!!");
                    txtDocType.value="";
                    txtDocType.focus();
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/wfrm_AJAX_Validator.aspx?Function=CheckValidDocType&datetime="+currentTime+"&DodId="+qDocId+"&DocType=" + txtDocType.value, false);
        xmlHttpRequest.send(null);
    }	
}
function ValidationDocEntry()
{
    var tot_rows=document.getElementById(controlIdPrefix + "gvDocuType").rows.length;
    var txtDocType="";
    var ddlRenewqlAutu="";
    if(tot_rows>0)
    {
        for(i=0;i< tot_rows-1;i++)
        {  
            j=i+2
            var pref="";
            if(j<10)
            {
                pref = "ctl00_MyCPH1_gvDocuType_ctl0" + j + "_";
            }                                       
            else
            {         
                pref = "ctl00_MyCPH1_gvDocuType_ctl" + j + "_";
            }    
            txtDocType=document.getElementById(pref + "txtDocType").value;
            if(txtDocType=="")
            {
                alert("Enter Document Type !!!");
                document.getElementById(pref + "txtDocType").focus();
                return false;
            }
            ddlRenewqlAutu=document.getElementById(pref + "ddlRenewqlAutu").value;
            if(ddlRenewqlAutu=="0")
            {
                alert("Select Renewal Authority !!!");
                document.getElementById(pref + "ddlRenewqlAutu").focus();
                return false;
            }
        }
    }
}
////////////////////////////////////////////////////////

function checkVehNo(txtVehNo,hfVehIntId,txtKm,hfVehType)
{
    var currentTime = new Date()
    //var ConnStr="<%= Session["SqlProvider"] %>";
    var str_Index = "";
    if (txtVehNo.value == "")
    {
        txtVehNo.value="";
        hfVehIntId.value="";
        txtKm.value="";
        hfVehType.value="";
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
                    alert("Invalid Vehicle Number");
                    txtVehNo.value="";
                    hfVehIntId.value="";
                    txtKm.value="";
                    hfVehType.value="";
                    txtVehNo.focus();
                }
                else
                {
                    txtVehNo.value=returnValue[1];
                    hfVehIntId.value=returnValue[2];
                    txtKm.value=returnValue[3];
                    hfVehType=returnValue[4];
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/wfrm_AJAX_Validator.aspx?Function=CheckValidVehNo&datetime="+currentTime+"&VehNo=" + txtVehNo.value, false);
        xmlHttpRequest.send(null);
    }	
}
function ValidationDocMstEntry()
{
    var txtVehNo = document.getElementById(controlIdPrefix + "txtVehNo");
    if(txtVehNo.value == "")
    {
        alert("Enter Vehicle Number !!!");
        txtVehNo.focus();
        return false;
    }
    var ddlDocumentType = document.getElementById(controlIdPrefix + "ddlDocumentType");
    if(ddlDocumentType.value == "0")
    {
        alert("Select Document Type !!!");
        ddlDocumentType.focus();
        return false;
    }
}

function ValidationDocDetEntry()
{
    var currentTime = new Date()
    var tot_rows=document.getElementById("ctl00_MyCPH1_gvDocuTypeDet").rows.length;
    var LinkButton1="";
    var FileUpload1="";
    var txtRenewAutuName="";
    var txtStartDt="";
    var txtExpityDt="";
    var myFSO="";
    var txtCost="";
    //var ddlStates="";
    var txtReminderInDays="";
    var hfDocId=document.getElementById(controlIdPrefix + "hfDocId");
    
    var a = "02,0" + document.getElementById("ctl00_MyCPH1_gvDocuTypeDet").rows.length;
    var str_Index=a.split(",");
    var part_num=0;
    
    while (part_num < str_Index.length)
    {
        if (document.getElementById("ctl00_MyCPH1_gvDocuTypeDet_ctl" + str_Index[part_num] + "_LinkButton1").innerText == "Update")  
        {
            txtReminderInDays=document.getElementById(controlIdPrefix + "txtReminderInDays");
            if(txtReminderInDays.value=="0")
            {
                alert("Enter Reminder Days !!!");
                txtReminderInDays.focus();
                return false;
            }
            //alert("Doc no :" + document.getElementById("ctl00_MyCPH1_gvDocuTypeDet_ctl" + str_Index[part_num] + "_txtDocumnetNo").value);
            if(document.getElementById("ctl00_MyCPH1_gvDocuTypeDet_ctl" + str_Index[part_num] + "_txtDocumnetNo").value=="")
            {
                alert("Enter Document Number !!!");
                document.getElementById("ctl00_MyCPH1_gvDocuTypeDet_ctl" + str_Index[part_num] + "_txtDocumnetNo").focus();
                return false;
            }
            if(document.getElementById("ctl00_MyCPH1_gvDocuTypeDet_ctl" + str_Index[part_num] + "_txtRenewAutuName").value=="")
            {
                alert("Enter Renewal Authority Name !!!");
                document.getElementById("ctl00_MyCPH1_gvDocuTypeDet_ctl" + str_Index[part_num] + "_txtRenewAutuName").focus();
                return false;
            }
            var PrevDocExDt="";
            
            txtStartDt=document.getElementById("ctl00_MyCPH1_gvDocuTypeDet_ctl" + str_Index[part_num] + "_txtStartDt");
            
            if(txtStartDt.value=="")
            {
                alert("Enter Start Date !!!");
                txtStartDt.focus();
                return false;
            }
            else
            {   
                var hf_DocDetId=document.getElementById("ctl00_MyCPH1_gvDocuTypeDet_ctl" + str_Index[part_num] + "_hf_DocDetId");
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
                                PrevDocExDt=returnValue[1];
                            }
                        }
                    }
                    xmlHttpRequest.open("GET", "AJAX_Validator/wfrm_AJAX_Validator.aspx?Function=CheckStartDate&datetime="+currentTime+"&DocDetId="+hf_DocDetId.value+"&DocId=" + hfDocId.value, false);
                    xmlHttpRequest.send(null);
                }
            }
            if(PrevDocExDt != "")
            {
                if(!IsDateGreater(txtStartDt.value,PrevDocExDt))
                {   
                    alert("Start date of document number should be greater than expiry date of previous record!!!");
                    txtStartDt.focus();
                    return false;
                }
            }
                                
            txtExpityDt=document.getElementById("ctl00_MyCPH1_gvDocuTypeDet_ctl" + str_Index[part_num] + "_txtExpityDt");
            if(txtExpityDt.value=="")
            {
                alert("Enter Expiry Date !!!");
                txtExpityDt.focus();
                return false;
            }
            else
            {
                if(IsDateGreater(txtStartDt.value,txtExpityDt.value))
                {
                    alert("Expiry date must be greater than Start date !!!");
                    return false;
                }
            }
            FileUpload1=document.getElementById("ctl00_MyCPH1_gvDocuTypeDet_ctl" + str_Index[part_num] + "_FileUpload1");
            if(FileUpload1.value!="")
            {
                var path = FileUpload1.value;//document.getElementById('file1').value;
                var Index = path.lastIndexOf(".");
                var length = path.length;

                var filetype = path.substring(Index,length)
                if ((filetype.toLowerCase() == ".doc") ||(filetype.toLowerCase() == ".pdf") ||(filetype.toLowerCase() == ".jpg") ||(filetype.toLowerCase() == ".gif") ||(filetype.toLowerCase() == ".xls") ||(filetype.toLowerCase() == ".tiff")||(filetype.toLowerCase() == ".tif"))
                {
                    var x = getSize(FileUpload1); 
                    if (x > 1048576)
                    {
                        alert("only upto 1 MB file is allowed");
                        FileUpload1.focus();
                        return false;
                    }
                }
                else
                {
                    alert("Only .doc, .pdf, .jpg, .gif, .xls, .tiff, .tif is allowed");
                    FileUpload1.focus();
                    return false;
                }
            }
            if(document.getElementById("ctl00_MyCPH1_gvDocuTypeDet_ctl" + str_Index[part_num] + "_txtCost") != "null")
            {
                txtCost=document.getElementById("ctl00_MyCPH1_gvDocuTypeDet_ctl" + str_Index[part_num] + "_txtCost");
                if(txtCost.value=="")
                {
                    alert("Enter Cost !!!");
                    txtCost.focus();
                    return false;
                }
            }
//            if(document.getElementById("ctl00_MyCPH1_gvDocuTypeDet_ctl" + str_Index[part_num] + "_ddlStates") != "null")
//            {
//                ddlStates=document.getElementById("ctl00_MyCPH1_gvDocuTypeDet_ctl" + str_Index[part_num] + "_ddlStates");
//                if(ddlStates.value=="0")
//                {
//                    alert("Select State !!!");
//                    txtCost.focus();
//                    return false;
//                }
//            }
        }
        part_num+=1;
    }
}
function IsDateGreater(DateValue1, DateValue2)
{
    var a=DateValue1.split("/");
    var b=DateValue2.split("/");
    DateValue1 = a[1]+ "/" + a[0]+ "/" + a[2];
    DateValue2 = b[1]+ "/" + b[0]+ "/" + b[2];
    if(Date.parse(DateValue1) > Date.parse(DateValue2))
        return true;
    else
        return false;
}
   
function getSize(FileUpload1)
{
    var oas = new ActiveXObject("Scripting.FileSystemObject");
    var d = FileUpload1.value;
    var e = oas.getFile(d);
    var f = e.size;
    return(f);
}
function CheckDocNo(row_Index,txtDocumnetNo,hfVehIntId,hfDoctype,hfDocId,hf_DocDetId)
{
    var currentTime = new Date()
    var str_Index = "";
    if (txtDocumnetNo.value == "")
    {
        txtDocumnetNo.value="";
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
                    txtDocumnetNo.value=txtDocumnetNo.value;
                }
                else
                {
                    alert("Document Number already exist !!!");
                    txtDocumnetNo.value="";
                    txtDocumnetNo.focus();
                }
            }
        }
        xmlHttpRequest.open("GET", "AJAX_Validator/wfrm_AJAX_Validator.aspx?Function=CheckDocNo&datetime="+currentTime+"&DocDetId="+hf_DocDetId.value+"&DocNo=" + txtDocumnetNo.value+"&VehNo="+hfVehIntId.value+"&DocumentType="+hfDoctype.value+"&DocId="+hfDocId.value, false);
        xmlHttpRequest.send(null);
    }	
}


function ValidFile()
{
    var currentTime = new Date()
    var FileUpload1="";
    var a = "02,0" + document.getElementById("ctl00_MyCPH1_gvDocuTypeDet").rows.length;
    var str_Index=a.split(",");
    var part_num=0;
    
    while (part_num < str_Index.length)
    {
        if (document.getElementById("ctl00_MyCPH1_gvDocuTypeDet_ctl" + str_Index[part_num] + "_LinkButton1").innerText == "Update")  
        {
            FileUpload1=document.getElementById("ctl00_MyCPH1_gvDocuTypeDet_ctl" + str_Index[part_num] + "_FileUpload1");
            if(FileUpload1.value!="")
            {
                var path = FileUpload1.value;//document.getElementById('file1').value;
                var Index = path.lastIndexOf(".");
                var length = path.length;

                var filetype = path.substring(Index,length)
                if ((filetype.toLowerCase() == ".doc") ||(filetype.toLowerCase() == ".pdf") ||(filetype.toLowerCase() == ".jpg")||(filetype.toLowerCase() == ".tif") ||(filetype.toLowerCase() == ".tiff") ||(filetype.toLowerCase() == ".gif") ||(filetype.toLowerCase() == ".xls"))
                {
                    var x = getSize(FileUpload1); 
                    if (x > 1048576)
                    {
                        alert("only upto 1 MB file is allowed");
                        FileUpload1.focus();
                        return false;
                    }
                }
                else
                {
                    alert("Only .doc, .pdf, .jpg, .gif, .xls, .tif, .tiff is allowed");
                    FileUpload1.focus();
                    return false;
                }
            }
        }
        part_num+=1;
    }
}