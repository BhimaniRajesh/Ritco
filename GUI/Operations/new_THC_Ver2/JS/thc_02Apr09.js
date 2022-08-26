// JScript File

var doc="document.aspnetForm.ctl00_MyCPH1_"; //common part of all object's name on the form
var docInGrid="document.aspnetForm.ctl00_MyCPH1_";

function MyDateCompare(startDt,endDt){
	var startDtArr;
	var endDtArr;
	
	startDtArr = startDt.split('/');
	endDtArr   = endDt.split('/');
	
	var myStartDt = new Date(startDtArr[2],startDtArr[1]-1,startDtArr[0]);
	var myEndDt   = new Date(endDtArr[2],endDtArr[1]-1,endDtArr[0]);
	var dtDiff    = myEndDt.getTime()-myStartDt.getTime();
	
	dtDiff = dtDiff/86400000;

	
	if(Trim(startDt)==Trim(endDt)){
	  dtDiff = 0;
	}
	//alert(dtDiff);
	return dtDiff
}

//var dtDiff=0;
//var dtDiffSys=0;

//dtDiff = MyDateCompare(mDepDate,mArrivalDate);

function ConfirmNoMF(obj){
//  EnableDisableMFSelection(false);  
  if(obj.checked == true){
    if(!confirm('Are you sure ??')){
        obj.checked = false;
//        EnableDisableMFSelection(true);
    }
  }
}

function EnableDisableMFSelection(boo){
    for (i=0; i < document.forms[0].elements.length; i++) 
    {
        if ((document.forms[0].elements[i].type == 'checkbox') && 
        (document.forms[0].elements[i].name.indexOf('dgMFs') > -1 && eval())
        ) 
        {
         document.forms[0].elements[i].enabled = boo;
        }
    }
}

function IsTHCDateLessThanMFDate(){
 var boo = false;
 var knt=-1;
 if(document.aspnetForm.tcdt.length>1){
 
     for (i=0; i < document.forms[0].elements.length; i++) 
    {
        if ((document.forms[0].elements[i].type == 'checkbox') && (document.forms[0].elements[i].name.indexOf('dgMFs') > -1)) 
        {
         knt += 1;   
         if(document.forms[0].elements[i].checked == true) {
            if(MyDateCompare(document.aspnetForm.tcdt[knt].value,eval(doc+"txtTHCDate").value)<0) boo=true;
         }
        }
    }
//    for(i=0;i<document.aspnetForm.tcdt.length;i++){
//        if(MyDateCompare(document.aspnetForm.tcdt[i].value,eval(doc+"txtTHCDate").value)<0) boo=true;
//    }
 } else
 {
    if(MyDateCompare(document.aspnetForm.tcdt.value,eval(doc+"txtTHCDate").value)<0) boo=true;
 }
 
 return boo;
}

function AtleastOneMFSelected(){
  var knt=0;
  if(eval("document.aspnetForm.chkNoMF").checked==false){
    for (i=0; i < document.forms[0].elements.length; i++) 
    {
        if ((document.forms[0].elements[i].type == 'checkbox') && 
        (document.forms[0].elements[i].name.indexOf('dgMFs') > -1)
        ) 
        {
         if(document.forms[0].elements[i].checked == true) knt+=1;
        }
    }
  } else {
    knt = 1
    for (i=0; i < document.forms[0].elements.length; i++) 
    {
        if ((document.forms[0].elements[i].type == 'checkbox') && 
        (document.forms[0].elements[i].name.indexOf('dgMFs') > -1)
        ) 
        {
         document.forms[0].elements[i].checked = false;
        }
    }
  }
  return knt;
}

function SelectAll(CheckBoxControl) 
{
if (CheckBoxControl.checked == true) 
{
var i;
for (i=0; i < document.forms[0].elements.length; i++) 
{
if ((document.forms[0].elements[i].type == 'checkbox') && 
(document.forms[0].elements[i].name.indexOf('dgMFs') > -1)) 
{
    //if(document.forms[0].elements[i].enabled){
        //alert(document.forms[0].elements[i].name);
        document.forms[0].elements[i].checked = true;
    //}
}
}
} 
else 
{
var i;
for (i=0; i < document.forms[0].elements.length; i++) 
{
if ((document.forms[0].elements[i].type == 'checkbox') && 
(document.forms[0].elements[i].name.indexOf('dgMFs') > -1)) 
{
document.forms[0].elements[i].checked = false;
}
}
}
}

function ValidateData(){
    var boo = false;
    //alert('...***');
    boo = isValidDate(eval(doc+"txtTHCDate").value,'THC Date ');
    if(!boo){
        eval(doc+"txtTHCDate").focus();
        return false;
    }    

    if(MyDateCompare(eval(doc+"hSysDate").value,eval(doc+"txtTHCDate").value)>0) boo=false;
    if(!boo){
        alert("THC Date cannot be greater than Sys. Date:" + eval(doc+"hSysDate").value);
        eval(doc+"txtTHCDate").focus();
        return false;
    }    

    
    boo = matchPattern(eval(doc+"txtHHMM").value,"^([0-1][0-9]|[2][0-3]):([0-5][0-9])$","Actual Dept. Time ");
    if(!boo){
        eval(doc+"txtHHMM").focus();
        return false;
    }    
    
    if(eval(doc+"cboVendorType").value==''){//If Vendor Type Not Selected
        alert('Select Vendor Type :(');
        eval(doc+"cboVendorType").focus();
        return false;
    }
    
    switch(eval(doc+"cboVendorType").value)
    {
    case 'XX'://Market Vendor Selected
        if(Trim(eval(doc+"txtMarketVendor").value)==''){ //If Market Vendor Name Not Entered
            alert('Enter Vendor Name :(');
            eval(doc+"txtMarketVendor").focus();
            return false;
        }
      break;    
    default:
        if(eval(doc+"cboVendors").value==''){//If Vendor Name Not Selected
            alert('Select Vendor Name :(');
            return false;
        }
    }       
    
    switch(eval(doc+"cboRouteMode").value)
    {
    case 'S'://Road
        //alert(eval(doc+"txtMktVeh").value);
        switch(eval(doc+"cboVendorType").value)
        {
        case 'XX':
            if(Trim(eval(doc+"txtMktVeh").value)==''){
                alert('Enter Market Vehicle # :(');
                eval(doc+"txtMktVeh").focus();
                return false;
            }
          break;    
         case '05': //OWN Vendor
            if(eval(doc+"cboVehicles").value==''){
                alert('Select Vehicle :(');
                eval(doc+"cboVehicles").focus();
                return false;
            }

            if(eval(doc+"cboTripSheet").value==''){
                alert('Select TripSheet # :(');
                eval(doc+"cboTripSheet").focus();
                return false;
            }
        default:
            if(eval(doc+"cboVehicles").value==''){
                alert('Select Vehicle :(');
                eval(doc+"cboVehicles").focus();
                return false;
            }
        }       
     
        if(eval(doc+"cboVehicleTypes").value==''){ //If Vehicle Type Not Selected
           alert('Select Vehicle Type :(');
           eval(doc+"cboVehicleTypes").focus();
           return false;
        }
        
        if(Trim(eval(doc+"txtEngineNo").value)==''){ //If Engine No Not Entered
          alert('Enter Engine No. :(');
          eval(doc+"txtEngineNo").focus();
          return false;;
        }
      
        if(Trim(eval(doc+"txtChasisNo").value)==''){ //If Chasis No Not Entered
          alert('Enter Chasis No. :(');
          eval(doc+"txtChasisNo").focus();
          return false;;
        }
        
        if(Trim(eval(doc+"txtRCBookNo").value)==''){ //If RC Book No Not Entered
          alert('Enter RC Book No. :(');
          eval(doc+"txtRCBookNo").focus();
          return false;;
        }
        
        boo = isValidDate(eval(doc+"txtVRDate").value,'Vehicle Reg. Date ');
        if(!boo){
            eval(doc+"txtVRDate").focus();
            return false;
        }    
        
        if(MyDateCompare(eval(doc+"hSysDate").value,eval(doc+"txtVRDate").value)>0) boo=false;
        if(!boo){
            alert("Vehicle Reg. Date cannot be greater than Sys. Date:" + eval(doc+"hSysDate").value);
            eval(doc+"txtVRDate").focus();
             if(eval(doc+"txtIPDate").disabled==false)
                 eval(doc+"txtVRDate").focus();
                 
            return false;
        }  
        
        
        boo = isValidDate(eval(doc+"txtIPDate").value,'Insurance Policy Date ');
        if(!boo){
            eval(doc+"txtIPDate").focus();
            return false;
        }   
        
        if(MyDateCompare(eval(doc+"hSysDate").value,eval(doc+"txtIPDate").value)<0) boo=false;
        if(!boo){
            alert("Insurane Policy Date cannot be Less than Sys. Date:" + eval(doc+"hSysDate").value);
              if(eval(doc+"txtIPDate").disabled==false)
                 eval(doc+"txtIPDate").focus();
                 
            return false;
        }  
         
        boo = isValidDate(eval(doc+"txtFCDate").value,'Fitness Certificate Date ');
        if(!boo){
            eval(doc+"txtFCDate").focus();
            return false;
        } 
        
         if(MyDateCompare(eval(doc+"hSysDate").value,eval(doc+"txtFCDate").value)<0) boo=false;
        if(!boo){
            alert("Fitness Certificate Date cannot be Less than Sys. Date:" + eval(doc+"hSysDate").value);
            eval(doc+"txtFCDate").focus();
              if(eval(doc+"txtFCDate").disabled==false)
                 eval(doc+"txtFCDate").focus();
                 
            return false;
        }   
        
        var tmpString = "";
        
        tmpString = Trim(eval(doc+"txtDriver1").value) +  Trim(eval(doc+"txtLicence1").value) +  Trim(eval(doc+"txtIssuedBy1").value) +  Trim(eval(doc+"txtLVDate1").value);
        tmpString += Trim(eval(doc+"txtDriver2").value) +  Trim(eval(doc+"txtLicence2").value) +  Trim(eval(doc+"txtIssuedBy2").value) +  Trim(eval(doc+"txtLVDate2").value);
        
        if(tmpString==""){
            alert('Atleat one Driver Information should be entered :(');
            eval(doc+"txtDriver1").focus();
            return false;
        }


        //Driver 1 Validation
        tmpString = Trim(eval(doc+"txtDriver1").value) +  Trim(eval(doc+"txtLicence1").value) +  Trim(eval(doc+"txtIssuedBy1").value) +  Trim(eval(doc+"txtLVDate1").value);
        if(tmpString!=""){
            if(Trim(eval(doc+"txtDriver1").value)==""){
                alert('Enter Driver 1 Name :(');
                eval(doc+"txtDriver1").focus();
                return false;
            } 
            if(Trim(eval(doc+"txtLicence1").value)==""){
                alert('Enter Driver 1 Licence # :(');
                eval(doc+"txtLicence1").focus();
                return false;
            } 
            if(Trim(eval(doc+"txtIssuedBy1").value)==""){
                alert('Enter Driver 1 Licence Issued By RTO :(');
                eval(doc+"txtIssuedBy1").focus();
                return false;
            } 
            
            boo = isValidDate(eval(doc+"txtLVDate1").value,'Driver 1 Licence Validity Date ');
            if(!boo){
                eval(doc+"txtLVDate1").focus();
                return false;
            } 
        }
        //alert('..');
        //Driver 2 Validation
        tmpString = Trim(eval(doc+"txtDriver2").value) +  Trim(eval(doc+"txtLicence2").value) +  Trim(eval(doc+"txtIssuedBy2").value) +  Trim(eval(doc+"txtLVDate2").value);
        if(tmpString!=""){
            if(Trim(eval(doc+"txtDriver2").value)==""){
                alert('Enter Driver 2 Name :(');
                eval(doc+"txtDriver2").focus();
                return false;
            } 
            if(Trim(eval(doc+"txtLicence2").value)==""){
                alert('Enter Driver 2 Licence # :(');
                eval(doc+"txtLicence2").focus();
                return false;
            } 
            if(Trim(eval(doc+"txtIssuedBy2").value)==""){
                alert('Enter Driver 2 Licence Issued By RTO :(');
                eval(doc+"txtIssuedBy2").focus();
                return false;
            } 
            
            boo = isValidDate(eval(doc+"txtLVDate2").value,'Driver 2 Licence Validity Date ');
            if(!boo){
                eval(doc+"txtLVDate2").focus();
                return false;
            } 
        }
        
        if(Trim(eval(doc+"txtOVFS").value)==""){
            alert("Enter Vehicle Free Space :(");
            eval(doc+"txtOVFS").focus();
            return false;
        }

        if(isNaN(eval(doc+"txtOVFS").value)){
            alert("Enter Numeric Value for Out VFS :(");
            eval(doc+"txtOVFS").focus();
            return false;
        }
        
        if(parseInt(eval(doc+"txtOVFS").value)<0 || parseInt(eval(doc+"txtOVFS").value)>100){
            alert("Vehicle Free Space should be between 0 and 100 :(");
            eval(doc+"txtOVFS").focus();
            return false;
        }
        
        if(Trim(eval(doc+"txtSealNo").value)==""){
            alert("Enter Seal No. :(");
            eval(doc+"txtSealNo").focus();
            return false;
        }

        tmpString = Trim(eval(doc+"txtSealNo").value);
        //alert(tmpString.length);
        if(tmpString.length<3){
            alert("Seal No. should be atleast 3 chars. :(");
            eval(doc+"txtSealNo").focus();
            return false;
        }
  
       //alert('..');
        /*if(Trim(eval(doc+"txtVRDate").value)==''){ //If Veh Reg Date Not Entered
          alert('Enter Vehicle Reg. Date :(');
          eval(doc+"txtVRDate").focus();
          return false;;
        }
        
        if(Trim(eval(doc+"txtIPDate").value)==''){ //If Ins. Policy Date Not Entered
          alert('Enter Insurance Policy Date :(');
          eval(doc+"txtIPDate").focus();
          return false;;
        }

        if(Trim(eval(doc+"txtFCDate").value)==''){ //If Fitness Cert. Date Not Entered
          alert('Enter Fitness Cert. Date :(');
          eval(doc+"txtFCDate").focus();
          return false;;
        }*/
      break;    
    case 'R'://Traine
        if(Trim(eval(doc+"txtTrainName").value)==''){
            alert('Enter Train Name :(');
            eval(doc+"txtTrainName").focus();
            return false;
        }

        if(Trim(eval(doc+"txtTrainNo").value)==''){
            alert('Enter Train No. :(');
            eval(doc+"txtTrainNo").focus();
            return false;
        }

        if(Trim(eval(doc+"txtRRNo").value)==''){
            alert('Enter RR No. :(');
            eval(doc+"txtRRNo").focus();
            return false;
        }
      break;
    default://Air
        if(Trim(eval(doc+"txtAirlineName").value)==''){
            alert('Enter AirLine Name :(');
            eval(doc+"txtAirlineName").focus();
            return false;
        }

        if(Trim(eval(doc+"txtFlightNo").value)==''){
            alert('Enter Fligt No. :(');
            eval(doc+"txtFlightNo").focus();
            return false;
        }

        if(Trim(eval(doc+"txtAirwayBillNo").value)==''){
            alert('Enter Airway Bill No. :(');
            eval(doc+"txtAirwayBillNo").focus();
            return false;
        }
    }       

   var validateURL="./IsValidEmployee.aspx?EmpCode=" + Trim(eval(doc+"txtLoadSupCode").value) + "&sid=" + Math.random();
   boo = ValidateObjectValue(eval(doc+"txtLoadSupCode"),validateURL);
   //alert(boo);
   if(!boo){
     return false;
   } 

    if(Trim(eval(doc+"txtOutRemarks").value)==''){
        alert('Enter Outgoing Remarks :(');
        eval(doc+"txtOutRemarks").focus();
        return false;
    }

    if(Trim(eval(doc+"txtStartKM").value)==""){
        alert("Enter Start KMs :(");
        eval(doc+"txtStartKM").focus();
        return false;
    }

    if(isNaN(eval(doc+"txtStartKM").value)){
        alert("Enter Numeric Value for Start KM :(");
        eval(doc+"txtStartKM").focus();
        return false;
    }
    
    if(parseInt(eval(doc+"txtStartKM").value)<0 ){
        alert("Start KM cannot be negetive :(");
        eval(doc+"txtStartKM").focus();
        return false;
    }

    if(AtleastOneMFSelected()==0){
        alert('Kindly select atleat 1 MF for new THC :(');
        return false;
    }

    //document.aspnetForm.SelectAllCheckBox.enabled = false;
    if(IsTHCDateLessThanMFDate()){
        alert('Atleast one MF selected has Date > THC Date');
        return false;
    }
    
    
    return true;
}

function GenerateTHC(){
    //alert('..>>>');
    var ret_boo = true;
    ret_boo = ValidateData();
  //  alert('here..');
    //alert(ret_boo);
    if(ret_boo){
    
        // alert('here.11.' +doc);
         
            //alert(eval(doc+"cboVendorType").value)
          
            
            if(eval(doc+"cboVendorType").value=='XX'){ //Market Vendor
            
           // alert(eval(doc+"contractamt").value)
                if (eval(doc+"contractamt").value=="")
                {
                    alert("Please enter the 'Contract Amount'")
                    eval(doc+"contractamt").focus();
                    return false;
                }
                if (isNaN(eval(doc+"contractamt").value))
                {
                    alert("'Contract Amount' should be numeric.")
                    eval(doc+"contractamt").focus();
                    return false;
                }
                if (parseFloat(eval(doc+"contractamt").value)<0)
                {
                    alert("'Contract Amount' should not be negative.")
                    eval(doc+"contractamt").focus();
                    return false;
                }
               // alert(eval(doc+"contractamt").value)
                if (parseFloat(eval(doc+"contractamt").value)==0)
                {
                    alert("'Contract Amount' should not be >0.")
                    eval(doc+"contractamt").focus();
                    return false;
                }
                
             }
        //alert('here..');
        if(eval(doc+"cboVendorType").value=='05'){ //OWN Vendor
            if(eval(doc+"txtContractAmountOWN").value=="") {
                alert('Enter Contract Amount :(');
                eval(doc+"txtContractAmountOWN").focus();
                ret_boo = false;
            }
           
            
            if(isNaN(eval(doc+"txtContractAmountOWN").value)) {
                alert('Contract Amount should be Numeric :(');
                eval(doc+"txtContractAmountOWN").focus();
                ret_boo = false;
            }
            
        } else {
            //alert('there..');
            ret_boo=check_advancedetail();
        }
    }
    
    return ret_boo;
}

function balPayAtBlur(id)
{
   // var txt= doc + "balamtbr";
    var txt=eval(doc+"balamtbr").value;
    var findobj=false;
   // alert(txt)
    findobj=GetXMLHttpObject();
    if(findobj)
    {   
     
     var strpg="../CheckExist.aspx?loccd=" + txt ;
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                        alert(res[1]);
                        txt.select();
                        txt.focus();
                    }
                }
        }
      findobj.send(null);
    }    
}

function createXMLHTTPObject()
	{
	    if (window.XMLHttpRequest) { // Mozilla, Safari,...
	        doc = new XMLHttpRequest();
	        if (doc.overrideMimeType) 
	        {
	            doc.overrideMimeType('text/xml');
	        }
	    } else if (window.ActiveXObject) { // IE
	        try {
	            doc = new ActiveXObject("Msxml2.XMLHTTP");
	        } catch (e) {
	            try {
	                doc = new ActiveXObject("Microsoft.XMLHTTP");
	            } catch (e) {}
	        }
	    }
	}
	function Dovalidate() {
	    if (doc.readyState == 4) {
	            //alert(doc.responseText)
	            val=doc.responseText;
	            if (val!="OK")
	            {
	                alert(doc.responseText)
	                formObj.value="";
	                formObj.focus();
	            }
				
				//MyDiv.innerHTML = doc.responseText;
				//document.form1.submit1.focus();
	    }
	}	

//----------------------------------------------

function fbalamt()
{
if (eval(doc+"contractamt").value=="")
{
    alert("Please enter the 'Contract Amount'")
    eval(doc+"contractamt").focus();
    return false;
}
if (isNaN(eval(doc+"contractamt").value))
{
    alert("'Contract Amount' should be numeric.")
    eval(doc+"contractamt").focus();
    return false;
}
if (parseFloat(eval(doc+"contractamt").value)<0)
{
    alert("'Contract Amount' should not be negative.")
    eval(doc+"contractamt").focus();
    return false;
}
camt=eval(doc+"contractamt").value;
var svctax = ("<%=ServiceTaxRate%>"/100)
var othertax = ("<%=OtherTaxRate%>"/100)
eval(doc+"svrcamt").value=0
eval(doc+"cessamt").value=0

if("<%=routecd%>"=="5555")
{
    eval(doc+"svrcamt").value= Math.round((parseInt(camt))* parseFloat(svctax))
    eval(doc+"cessamt").value= Math.round((parseInt(eval(doc+"svrcamt").value))* parseFloat(othertax) )
}
svrcamt=parseInt(eval(doc+"svrcamt").value)
cessamt=parseInt(eval(doc+"cessamt").value)

if (eval(doc+"tel_chrg").value=="")
{
    alert("Please enter the 'Telephone charges'")
    eval(doc+"tel_chrg").focus();
    return false;
}
if (isNaN(eval(doc+"tel_chrg").value))
{
    alert("'Telephone charges' should be numeric.")
    eval(doc+"tel_chrg").focus();
    return false;
}
if (parseFloat(eval(doc+"tel_chrg").value)<0)
{
    alert("'Telephone charges' should not be negative.")
    eval(doc+"tel_chrg").focus();
    return false;
}

if (eval(doc+"mamul_chrg").value=="")
{
    alert("Please enter the 'Mamul charges'")
    eval(doc+"mamul_chrg").focus();
    return false;
}
if (isNaN(eval(doc+"mamul_chrg").value))
{
    alert("'Mamul charges' should be numeric.")
    eval(doc+"mamul_chrg").focus();
    return false;
}
if (parseFloat(eval(doc+"mamul_chrg").value)<0)
{
    alert("'Mamul charges' should not be negative.")
    eval(doc+"mamul_chrg").focus();
    return false;
}
if (eval(doc+"load_chrg").value=="")
{
    alert("Please enter the 'Hamali'")
    eval(doc+"load_chrg").focus();
    return false;
}
if (isNaN(eval(doc+"load_chrg").value))
{
    alert("'Hamali' should be numeric.")
    eval(doc+"load_chrg").focus();
    return false;
}
if (parseFloat(eval(doc+"load_chrg").value)<0)
{
    alert("'Mamul Loading' should not be negative.")
    eval(doc+"load_chrg").focus();
    return false;
}
//if (eval(doc+"contractamt").value==0)
//camt=eval(doc+"stdpcamt").value;
if (eval(doc+"advanceamt").value=="")
{
    alert("Please enter the 'Advance Amount'")
    eval(doc+"advanceamt").focus();
    return false;
}
if (isNaN(eval(doc+"advanceamt").value))
{
    alert("'Advance Amount' should be numeric.")
    eval(doc+"advanceamt").focus();
    return false;
}
if (parseFloat(eval(doc+"advanceamt").value)<0)
{
    alert("'Advance Amount' should not be negative.")
    eval(doc+"advanceamt").focus();
    return false;
}
if (isNaN(eval(doc+"tds_rate").value))
{
    alert("'TDS Rate' should be numeric.")
    eval(doc+"tds_rate").focus();
    return false;
}
if (parseFloat(eval(doc+"tds_rate").value)<0)
{
    alert("'TDS Rate' should not be negative.")
    eval(doc+"tds_rate").focus();
    return false;
}

if (eval(doc+"svtax_rate").value=="")
{
    alert("'Service Tax Rate' should be numeric.")
    eval(doc+"svtax_rate").focus();
    return false;
}
if (isNaN(eval(doc+"svtax_rate").value))
{
    alert("'Service Tax Rate' should be numeric.")
    eval(doc+"svtax_rate").focus();
    return false;
}
if (parseFloat(eval(doc+"svtax_rate").value)<0)
{
    alert("'Service Tax Rate' should not be negative.")
    eval(doc+"svtax_rate").focus();
    return false;
}




var totalcontractamt=parseFloat(eval(doc+"contractamt").value)+parseFloat(eval(doc+"txtmultipt").value)+parseFloat(eval(doc+"txtdetentionchg").value)+parseFloat(eval(doc+"txtheight").value)
eval(doc+"tds_chrg").value=Math.round( parseFloat(totalcontractamt) * (parseFloat(eval(doc+"tds_rate").value)/100))
eval(doc+"svrcamt").value=Math.round(parseFloat(eval(doc+"contractamt").value) * (parseFloat(eval(doc+"svtax_rate").value)/100))
eval(doc+"cessamt").value=Math.round(parseFloat(eval(doc+"svrcamt").value) * (2/100))
eval(doc+"hcessamt").value=Math.round(parseFloat(eval(doc+"svrcamt").value) * (1/100))
svrcamt=parseInt(eval(doc+"svrcamt").value)
cessamt=parseInt(eval(doc+"cessamt").value)
hcessamt=parseInt(eval(doc+"hcessamt").value)
//**inland charges calc******
var indothechrg=0
txtcwt=parseInt(eval(doc+"txtcwt").value)
txtheight=parseInt(eval(doc+"txtheight").value)
txtdetentionchg=parseInt(eval(doc+"txtdetentionchg").value)
txtmultipt=parseInt(eval(doc+"txtmultipt").value)
indothechrg=parseFloat(txtheight)+parseFloat(txtdetentionchg)+parseFloat(txtmultipt)-parseFloat(txtcwt)
//**************************************
//tdsval=Math.ceil(parseFloat(eval(doc+"contractamt").value) * (parseFloat(eval(doc+"tds_rate").value)/100))
//eval(doc+"tds_chrg").value=tdsval
m_loadOperType=eval(doc+"loadOpertype").value
if(m_loadOperType=="P")
{
totchrg =parseFloat(eval(doc+"contractamt").value)+ parseFloat(eval(doc+"tel_chrg").value)- parseFloat(eval(doc+"mamul_chrg").value)+ parseFloat(eval(doc+"load_chrg").value)+parseFloat(indothechrg)
}
else
{
totchrg =parseFloat(eval(doc+"contractamt").value)+ parseFloat(eval(doc+"tel_chrg").value)- parseFloat(eval(doc+"mamul_chrg").value)- parseFloat(eval(doc+"load_chrg").value)+parseFloat(indothechrg)

}

if(totchrg<0)totchrg=0
netpayamt=parseFloat(eval(doc+"advanceamt").value)//-parseFloat(eval(doc+"tds_chrg").value)
if(netpayamt<0) netpayamt=0
eval(doc+"netpayamt").value=roundit(netpayamt)


//eval(doc+"colamt").value=eval(doc+"netpayamt").value
//eval(doc+"chequeamt").value=eval(doc+"netpayamt").value
var totchrg
var advanceamt_paid=eval(doc+"advanceamt_paid").value
//balamt=Math.round(parseFloat(totchrg)-parseFloat(eval(doc+"advanceamt").value)-parseFloat(eval(doc+"tds_chrg").value))+svrcamt+cessamt
balamt=Math.round(parseFloat(totchrg)-parseFloat(eval(doc+"netpayamt").value)+svrcamt+cessamt+hcessamt-parseFloat(eval(doc+"tds_chrg").value)-advanceamt_paid)
if(balamt<0) balamt=0
eval(doc+"balamt").value=Math.round(balamt)
if (parseFloat(balamt)<0)
{
    alert("'Balance Amount' should not be negative.")
    eval(doc+"advanceamt").focus();
    return false;
}

}


        function IsNumericWoDot(sText)
        {
           var ValidChars = "0123456789";
           var IsNumber=true;
           var Char;

           for (i = 0; i < sText.length && IsNumber == true; i++) 
           { 
              Char = sText.charAt(i); 
              
              if (ValidChars.indexOf(Char) == -1) 
              {
                IsNumber = false;
              }
           }
           
           return IsNumber;
        }

        function Nagative_Chk_wDecimal(obj)
        {
	        var temp = trimAll(obj.value) 
        	
	        if (temp == "")	
	        {
		        /*alert("Value can not be blank")
		        obj.focus();
		        return false;*/
		        return true;
	        }
        	
	        if(isNaN(temp))
	        {
		        alert("Value should be Numeric")
		        obj.focus();
		        return false;
	        } 				
        		  
	        if(parseFloat(temp) < 0)
	        {
		        alert("Value should be greater than zero")
		        obj.focus();
		        return false;
	        }
        	
	        obj.value=roundit(temp) 
        	
	        return true;					   
        }
        	
        function Nagative_Chk_woDecimal(obj)
        {
	        var temp = obj.value 
        						
	        if (temp == "")	
	        {
		        alert("Value can not be blank")
		        obj.focus();
		        return false;
	        }
        	
	        if(isNaN(temp))
	        {
		        alert("Value should be Numeric")
		        obj.focus();
		        return false;
	        } 					  
        	
	        if(parseFloat(temp)<0)
	        {
		        alert("Value should be greater than zero")
		        obj.focus();
		        return false;
	        }
        	
	        if(temp.indexOf(".") > 0)
	        {
		        alert("Value should not contain decimal point")
		        obj.focus();
		        return false;
	        } 
        	
	        obj.value=Math.round(temp)
        	 	
	        return true;					 				   
        }

        function rounditn(Num, decplaces)
        {
	        Places = decplaces
        	
            if (Places > 0) 
	        {
	            if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places+1)) 
		        {
			        if (Num.toString().lastIndexOf('.') < 0) 
			        {
				        return Num.toString() +'.00';
			        }
        			
			        var Rounder = Math.pow(10, Places);
        			
			        return Math.round(Num * Rounder) / Rounder;
		        }
		        else 
		        {
			        if (Num.toString().lastIndexOf('.') < 0) 
			        {
				        return Num.toString() +'.00';
			        }
			        else
			        {  
				        if (Num.toString().lastIndexOf('.')+1==Num.toString().length-1)
					        return Num.toString() +'0';	
				        else
					        return Num.toString();				   
    		        }
		        }
	        }
	        else
	        {
	            return Math.round(Num);
            }
        }

        function roundit(Num)
        {
	        Places = 2
        	
	        if (Places > 0)
	        {
		        if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places+1)) 
		        {
			        if (Num.toString().lastIndexOf('.') < 0) 
			        {
				        return Num.toString() + '.00';
			        }
        			
			        var Rounder = Math.pow(10, Places);
        			
			        return Math.round(Num * Rounder) / Rounder;
		        }
		        else 
		        {
			        if (Num.toString().lastIndexOf('.') < 0) 
			        {
				        return Num.toString() +'.00';
			        }
			        else
			        {  
				        if (Num.toString().lastIndexOf('.')+1==Num.toString().length-1)
				        {
					        return Num.toString() +'0';
				        }
				        else
				        {
					        return Num.toString();
				        }
			        }
		        }
	        }
	        else
	        {
	            return Math.round(Num);
	        }
        }


//-----------------------------------
//-----------------------------------

function check_advancedetail()
{
//    debugger
//frm_name="ctl00_MyCPH1_"



//////---------------------Fleet Code---------------------------------------------
//                if(document.getElementById("ctl00_MyCPH1_ddlRouteMode").value == "S" && document.getElementById("ctl00_MyCPH1_ddlVendorType").value == "05")
//                {
//                    if(document.getElementById("ctl00_MyCPH1_ddlTripSheetNo"))
//                    {
//                        //alert(document.getElementById("ctl00_MyCPH1_ddlTripSheetNo").value);
//                        if(document.getElementById("ctl00_MyCPH1_ddlTripSheetNo").value == "" )
//                        {
//                            alert("Select Trip Sheet No. from the List!");
//                            document.getElementById("ctl00_MyCPH1_ddlTripSheetNo").focus();
//                            return false;
//                        }
//                        
//                        mMktVeh = "N";
//                    }
//                }
//////---------------------End Fleet Code---------------------------------------------  



    var advpaidby=eval(doc+"advpaidby").value

    if (eval(doc+"contractamt").value=="")
    {
        alert("Please enter the Contract Amount'")
        eval(doc+"contractamt").focus();
        return false;
    }
    if (isNaN(eval(doc+"contractamt").value))
    {
        alert("'Contract Amount should be numeric.")
        eval(doc+"contractamt").focus();
        return false;
    }
    
    if (parseFloat(eval(doc+"contractamt").value)<0)
    {
        alert("'Contract Amount should not be negative.")
        eval(doc+"contractamt").focus();
        return false;
    }

// return false;
    if (parseFloat(eval(doc+"tds_rate").value)>0)
    {
        if (parseFloat(eval(doc+"tds_rate").value)>100)
        {
            alert("TDS rate can not be greater than 100")
            eval(doc+"tds_rate").focus();
            return false;
        }
    }

//    if (parseFloat(eval(doc+"tds_chrg").value)>0)
//    {
//        
//    }
//    else
//    {
//        eval(doc+"tdsacccode").value=""
//    }
    
     
    if (eval(doc+"tdsacccode").value=="")
        {
            alert("Please select the TDS type")
            eval(doc+"tdsacccode").focus();
            return false;
        }
        
        //var tdsfor=eval(doc+"tdsfor").value
        var tdsacccode=eval(doc+"tdsacccode").value

//        if (tdsfor=="")
//        {
//            alert("Please select TDS deducted for!!!")
//            eval(doc+"tdsfor").focus();
//            return false;
//        }
        
        if(tdsacccode=="")
        {
            alert("Please select TDS Type for!!!")
            eval(doc+"tdsacccode").focus();
            return false;
        }

        if (eval(doc+"pan_no").value=="")
        {
            alert("Please enter the PAN number")
            eval(doc+"pan_no").focus();
            return false;
        }

        if (eval(doc+"pan_no").value!="")
        {
            if (eval(doc+"pan_no").value.length!=10)
            {
            alert("PAN number should be of 10 character")
            eval(doc+"pan_no").focus();
            return false;
            }
        }


        if ((isNaN(eval(doc+"advanceamt").value) == true) || (eval(doc+"advanceamt").value==""))
        {
            alert("Advance Amount should be ZERO or greater than ZERO");
            eval(doc+"advanceamt").focus();
            return false;
        }
        else
        {
            var temp
            temp=eval(doc+"advanceamt").value
            if (temp.substring(0,1)=="-")
            {
                alert("'Advance Amount' can not be negative")
                eval(doc+"advanceamt").focus();
                return false;
            }
        }

/*if (parseFloat(eval(doc+"advanceamt").value)> parseFloat(eval(doc+"contractamt").value) )
{
alert("'Advance Amount' should not be greater than 'Contract Amount'")
eval(doc+"advanceamt").focus();
return false;
}*/

        var advanceamt_paid=eval(doc+"advanceamt_paid").value
        balamt=Math.round(parseFloat(eval(doc+"contractamt").value)-parseFloat(eval(doc+"advanceamt").value))
        totchrg =parseFloat(eval(doc+"contractamt").value)+ parseFloat(eval(doc+"tel_chrg").value)- parseFloat(eval(doc+"mamul_chrg").value)+ parseFloat(eval(doc+"load_chrg").value)
        balamt=Math.round(parseFloat(totchrg)-parseFloat(eval(doc+"advanceamt").value)-parseFloat(eval(doc+"tds_chrg").value)-advanceamt_paid)

        eval(doc+"balamt").value=Math.round(balamt)

        balamt=parseFloat(eval(doc+"balamt").value)

        var totalcontractamt=parseFloat(eval(doc+"contractamt").value)+parseFloat(eval(doc+"txtmultipt").value)+parseFloat(eval(doc+"txtdetentionchg").value)+parseFloat(eval(doc+"txtheight").value)
        eval(doc+"tds_chrg").value=Math.round( parseFloat(totalcontractamt) * (parseFloat(eval(doc+"tds_rate").value)/100))
        eval(doc+"svrcamt").value=Math.round(parseFloat(eval(doc+"contractamt").value) * (parseFloat(eval(doc+"svtax_rate").value)/100))
        eval(doc+"cessamt").value=Math.round(parseFloat(eval(doc+"svrcamt").value) * (2/100))
        svrcamt=parseInt(eval(doc+"svrcamt").value)
        cessamt=parseInt(eval(doc+"cessamt").value)

//***inland charges calc*******
var indothechrg=0
txtcwt=parseInt(eval(doc+"txtcwt").value)
txtheight=parseInt(eval(doc+"txtheight").value)
txtdetentionchg=parseInt(eval(doc+"txtdetentionchg").value)
txtmultipt=parseInt(eval(doc+"txtmultipt").value)
indothechrg=parseFloat(txtheight)+parseFloat(txtdetentionchg)+parseFloat(txtmultipt)-parseFloat(txtcwt)
//**************************************
//tdsval=Math.ceil(parseFloat(eval(doc+"contractamt").value) * (parseFloat(eval(doc+"tds_rate").value)/100))
//eval(doc+"tds_chrg").value=tdsval
m_loadOperType=eval(doc+"loadOpertype").value
    if(m_loadOperType=="P")
    {
        totchrg =parseFloat(eval(doc+"contractamt").value)+ parseFloat(eval(doc+"tel_chrg").value)- parseFloat(eval(doc+"mamul_chrg").value)+ parseFloat(eval(doc+"load_chrg").value)+parseFloat(indothechrg)
    }
    else
    {
        totchrg =parseFloat(eval(doc+"contractamt").value)+ parseFloat(eval(doc+"tel_chrg").value)- parseFloat(eval(doc+"mamul_chrg").value)- parseFloat(eval(doc+"load_chrg").value)+parseFloat(indothechrg)
    }
    if(totchrg<0)
        totchrg=0
        
        netpayamt=parseFloat(eval(doc+"advanceamt").value)//-parseFloat(eval(doc+"tds_chrg").value)
        
    if(netpayamt<0)
     netpayamt=0

        eval(doc+"netpayamt").value=roundit(netpayamt)

        var totchrg
        var advanceamt_paid=eval(doc+"advanceamt_paid").value
        balamt=Math.round(parseFloat(totchrg)-parseFloat(eval(doc+"netpayamt").value)+svrcamt+cessamt-parseFloat(eval(doc+"tds_chrg").value)-advanceamt_paid)

        if(balamt<0)
        balamt=0
       
        eval(doc+"balamt").value=Math.round(balamt)

        if( parseFloat(balamt)<0)
        {
            balamt=0
            eval(doc+"balamt").value=0
        }

        //alert(branches)
        if(parseFloat(balamt)>0 &&((eval(doc+"balamtbr").value=="")))
        {
            alert("Invalid 'Balance Payable at' (i.e. Branch Code) OR Please enter 'Balance Payable at'!!!")
            eval(doc+"balamtbr").focus()
            return false;
        }
        if(parseFloat(balamt)<0)
        {
            alert("Balance amount cannot be less than zero,Please enter valid advance amount!!!")
            eval(doc+"advanceamt").focus()
            return false;
        }
// alert("Done")
// return false;
//

eval(doc+"tds_chrg").disabled=false;
eval(doc+"cessamt").disabled=false;
eval(doc+"hcessamt").disabled=false;
eval(doc+"svrcamt").disabled=false;

eval(doc+"tel_chrg").disabled=false;
eval(doc+"load_chrg").disabled=false;
eval(doc+"mamul_chrg").disabled=false;
eval(doc+"svtax_rate").disabled=false;

return true;

}