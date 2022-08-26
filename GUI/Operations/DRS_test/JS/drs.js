// JScript File

var doc="document.aspnetForm.ctl00_MyCPH1_"; //common part of all object's name on the form
var docInGrid="document.aspnetForm.ctl00_MyCPH1_";
var tmpDt="";
var tmpDtArr;

function SelectOne(rdo,gridName)
{
/* Getting an array of all the "INPUT" controls on the form.*/
all=document.getElementsByTagName("input");
 for(i=0;i<all.length;i++)
 {
  if(all[i].type=="radio")/*Checking if it is a radio button*/
  {
/*I have added '__ctl' ASP.NET adds '__ctl' to all 
    the controls of DataGrid.*/
   var count=all[i].id.indexOf(gridName+'_ctl');
   //alert(count); 
   if(count!=-1)
   {
    all[i].checked=false;
   }
  }
 }
 rdo.checked=true;/* Finally making the clicked radio button CHECKED */
 eval(doc+"hDRSSelected").value=rdo.value;
 //alert(eval(doc+"hDRSSelected").value);
}

function PassSelectedDRSForUpdate(){
    if(eval(doc+"hDRSSelected").value==""){
        alert('Please select a DRS for update');
        return false;
    }
    return true;
}

function MyDateCompare(startDt,endDt){
	var startDtArr;
	var endDtArr;
	
	startDtArr = startDt.split('/');
	endDtArr   = endDt.split('/');
	
	var myStartDt = new Date(startDtArr[2],startDtArr[1]-1,startDtArr[0]);
	var myEndDt   = new Date(endDtArr[2],endDtArr[1]-1,endDtArr[0]);
	var dtDiff    = myEndDt.getTime()-myStartDt.getTime();
	
	dtDiff = dtDiff/86400000;
	return dtDiff;
}

function ValidateDocketData(){
    var cntrName="";
    var cntrNameHidden="";
    
    var cntrNameCommDelyDt="";
    
    var cntrNameCODDOD = "";
    var cntrNameCODDODNo = "";
    
    var delyStatus = "U"; //Undely By Default
    
    var xmlData="<root>";
    //alert('1');
    //alert(eval(doc+"hXMLData").value);
    
    //-----------------------------------------------------
    //Close KM Validation
    //-----------------------------------------------------
    if(Trim(eval(doc+"txtCloseKM").value)==""){
        alert('Close KM cannot be empty :(');
        eval(doc+"txtCloseKM").focus();
        return false;
    }

    if(isNaN(Trim(eval(doc+"txtCloseKM").value))) {
        alert('Close KM should be Numeric :(');
        eval(doc+"txtCloseKM").focus();
        return false;
    }   

    //alert('2');

    if(parseInt(Trim(eval(doc+"txtCloseKM").value)) <= parseInt(Trim(eval("document.aspnetForm.hStartKM").value))){
        alert('Close KM cannot be less than or equal to Start KM :(');
        eval(doc+"txtCloseKM").focus();
        return false;
    }
    //-----------------------------------------------------
    

    //-----------------------------------------------------
    //Loop Through DRS Details
    //-----------------------------------------------------
    for(i=0;i<parseInt(eval(doc+"hDktsInDRS").value);i++){
        
        xmlData = xmlData + "<DRS><DRSCode>" + Trim(eval(doc+"hDRS").value) + "</DRSCode>";
        xmlData = xmlData + "<CLOSEKM>" + Trim(eval(doc+"txtCloseKM").value) + "</CLOSEKM>";
        //-----------------------------------------------------
        //Package Validation
        //-----------------------------------------------------
        if(i>9)
        {
            xmlData = xmlData + "<DOCKET>" + Trim(eval('document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_hDocket').value) + "</DOCKET>"
            xmlData = xmlData + "<DOCKETSF>" + Trim(eval('document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_hDocketSF').value) + "</DOCKETSF>"
            cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_txtPkgsDelivered';
            cntrNameHidden = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_hPkgsPending';
        } else 
        {
            xmlData = xmlData + "<DOCKET>" + Trim(eval('document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0' + i +'_hDocket').value) + "</DOCKET>"
            xmlData = xmlData + "<DOCKETSF>" + Trim(eval('document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0' + i +'_hDocketSF').value) + "</DOCKETSF>"
            cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0'+ i +'_txtPkgsDelivered'; 
            cntrNameHidden = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0'+ i +'_hPkgsPending';
        }
        
        if(Trim(eval(cntrName).value)=='') {
            alert('Packages Delivered cannot be empty :(');
            eval(cntrName).focus();
            return false;
        }   

        if(isNaN(Trim(eval(cntrName).value))) {
            alert('Packages Delivered should be Numeric :(');
            eval(cntrName).focus();
            return false;
        }   
        
        if(parseInt(Trim(eval(cntrName).value)) > parseInt(Trim(eval(cntrNameHidden).value))){
            alert('Packages Delivered cannot be greater than Pending Pkgs. :(');
            eval(cntrName).focus();
            return false;
        }

        xmlData = xmlData + "<PKGSWASPENDING>" + Trim(eval(cntrNameHidden).value) + "</PKGSWASPENDING>";
        xmlData = xmlData + "<PKGSDELIVERED>" + Trim(eval(cntrName).value) + "</PKGSDELIVERED>";
        //-----------------------------------------------------
        if(parseInt(Trim(eval(cntrName).value)) < parseInt(Trim(eval(cntrNameHidden).value))  && parseInt(Trim(eval(cntrName).value))!=0){
            delyStatus = "P"; // Part Dely. 
        } else {
            if(parseInt(Trim(eval(cntrName).value))!=0) {
                delyStatus = "F"; // Full Dely.
            } 
        }
        //-----------------------------------------------------
        
        
        //-----------------------------------------------------
        //Delivery Date Validation
        //-----------------------------------------------------
        cntrNameHidden = "document.aspnetForm.hDRSDate";
        if(i>9)
        {
            cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_txtDelyDt';
            cntrNameCommDelyDt = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i + '_hCommDelyDt';
        } else 
        {
            cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0'+ i +'_txtDelyDt'; 
            cntrNameCommDelyDt = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0' + i + '_hCommDelyDt';
        }
        
        if(Trim(eval(cntrName).value)=='') {
            alert('Delivery Date cannot be empty :(');
            eval(cntrName).focus();
            return false;
        }   

        if(!isValidDate(eval(cntrName).value,'Delivery Date ')) return false;
        
        if(MyDateCompare(eval(cntrNameHidden).value,eval(cntrName).value)<0){
            alert('Delivery Date cannot be less than DRS Generated Date:' + eval(cntrNameHidden).value);
            eval(cntrName).focus();
            return false;
        }
        //alert(tmpDt);
        
        tmpDt = Trim(eval(cntrName).value);
        tmpDtArr = tmpDt.split('/');
        
        tmpDt = Trim(tmpDtArr[1]) + '/' +  Trim(tmpDtArr[0]) + '/' + Trim(tmpDtArr[2]);
        //alert(tmpDt);
        xmlData = xmlData + "<DELYDATE>" + tmpDt + "</DELYDATE>";

        
        //-----------------------------------------------------
        if(MyDateCompare(eval(cntrNameCommDelyDt).value,eval(cntrName).value)>0 && delyStatus=="F"){
            delyStatus = "L"; //Late Dely
        }
        //-----------------------------------------------------
        xmlData = xmlData + "<DELYSTATUS>" + delyStatus + "</DELYSTATUS>";
        
        //-----------------------------------------------------
        //Delivery Time Validation
        //-----------------------------------------------------
        if(i>9)
        {
          cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_txtHHMM';
        } else 
        {
          cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0'+ i +'_txtHHMM'; 
        }

        if(!matchPattern(eval(cntrName).value,"^([0-1][0-9]|[2][0-3]):([0-5][0-9])$","Delivery Time ")){
            eval(cntrName).focus();
            return false;
        }
        xmlData = xmlData + "<DELYTIME>" + Trim(eval(cntrName).value) + "</DELYTIME>";

        //-----------------------------------------------------
        //Dely Reason Validation
        //-----------------------------------------------------
        if(i>9)
        {
            cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_cboReason';
        } else 
        {
            cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0'+ i +'_cboReason'; 
        }

        var cntrNameText = eval(cntrName)[eval(cntrName).selectedIndex].text;
        if(delyStatus=="U" && (eval(cntrName).value=="" || cntrNameText.indexOf('(Undelivery')==-1) ){
            alert('Select Undelivery Reason');
            eval(cntrName).focus();
            return false;
        }

        if(delyStatus=="L" && (eval(cntrName).value=="" || cntrNameText.indexOf('(Late')==-1) ){
            alert('Select Late Delivery Reason');
            eval(cntrName).focus();
            return false;
        }

        if(delyStatus=="P" && (eval(cntrName).value=="" || cntrNameText.indexOf('(Part')==-1) ){
            alert('Select Part Delivery Reason');
            eval(cntrName).focus();
            return false;
        }
        xmlData = xmlData + "<DELYREASON>" + Trim(eval(cntrName).value) + "</DELYREASON>";

        //-----------------------------------------------------
        //Person Validation
        //-----------------------------------------------------
        if(i>9)
        {
          cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_txtPerson';
        } else 
        {
          cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0'+ i +'_txtPerson'; 
        }

        if(Trim(eval(cntrName).value)==""){
            alert('Enter Person');
            eval(cntrName).focus();
            return false;
        }
        xmlData = xmlData + "<DELYPERSON>" + Trim(eval(cntrName).value) + "</DELYPERSON>";


        //-----------------------------------------------------
        //COD-DOD Validation
        //-----------------------------------------------------
        if(i>9)
        {
          cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_txtCODDOCCollected';
          cntrNameHidden = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_hCODDODAmount';
          cntrNameCODDOD = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_hCODDOD';
          cntrNameCODDODNo = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_txtCODDODNo';
        } else 
        {
          cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0'+ i +'_txtCODDOCCollected'; 
          cntrNameHidden = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0'+  i +'_hCODDODAmount';
          cntrNameCODDOD = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0'+  i +'_hCODDOD';
          cntrNameCODDODNo = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' +  '0'+ i +'_txtCODDODNo';
        }

    
        if(eval(cntrNameCODDOD).value=="Y"){ //IF CODDOD    
            if(Trim(eval(cntrName).value)==""){
                alert('Enter CODDOD Collected');
                eval(cntrName).focus();
                return false;
            }

            if(isNaN(Trim(eval(cntrName).value))) {
                alert('CODDOD Collected should be Numeric :(');
                eval(cntrName).focus();
                return false;
            }   
            
            if(parseInt(Trim(eval(cntrName).value)) < parseInt(Trim(eval(cntrNameHidden).value))){
                alert('CODDOD Collected cannot be less than CODDOD Amount :(');
                eval(cntrName).focus();
                return false;
            }

            if(Trim(eval(cntrNameCODDODNo).value)==""){
                alert('Enter CODDOD No');
                eval(cntrNameCODDODNo).focus();
                return false;
            }
            xmlData = xmlData + "<CODDODAMOUNT>" + Trim(eval(cntrNameHidden).value) + "</CODDODAMOUNT>";
            xmlData = xmlData + "<CODDODCOLLECTED>" + Trim(eval(cntrName).value) + "</CODDODCOLLECTED>";
            xmlData = xmlData + "<CODDODNO>" + Trim(eval(cntrNameCODDODNo).value) + "</CODDODNO></DRS>";
        } else { //
            xmlData = xmlData + "<CODDODAMOUNT>0</CODDODAMOUNT>";
            xmlData = xmlData + "<CODDODCOLLECTED>0</CODDODCOLLECTED>";
            xmlData = xmlData + "<CODDODNO>-</CODDODNO></DRS>";
        }
    }//End of Loop Through DRS Details
    xmlData = xmlData + "</root>";
    eval(doc+"hXMLData").value=xmlData;
    document.aspnetForm.method="post";
    document.aspnetForm.action="./UpdateDRSSubmit.aspx";
    document.aspnetForm.submit();
}


function ValidateData(){
    //alert(eval("document.aspnetForm."+"radDate[0]").checked);
    var boo = false;
    eval(doc+"hDRSSelected").value="";
    eval(doc+"hDateRange").value="2";
    if(Trim(eval(doc+"txtDRSList").value)=='' && eval("document.aspnetForm."+"radDate[0]").checked){
        eval(doc+"hDateRange").value="0";
        boo = isValidDate(eval(doc+"txtFrom").value,'DRS From Date ');
        if(!boo){
            eval(doc+"txtFrom").focus();
            return false;
        }    

        boo = isValidDate(eval(doc+"txtTo").value,'DRS To Date ');
        if(!boo){
            eval(doc+"txtTo").focus();
            return false;
        }    

        if(MyDateCompare(eval(doc+"txtFrom").value,eval(doc+"txtTo").value)<0){
            alert('DRS From Date > To Date :(');
            eval(doc+"txtTo").focus();
            return false;
        }
    } else {
      for(i=1;i<4;i++) {
        //alert(i + "--" + eval("document.aspnetForm."+"radDate[" + i + "]").checked);
        if(eval("document.aspnetForm."+"radDate[" + i + "]").checked){
            eval(doc+"hDateRange").value=i;
        }
      }
      
      //alert(eval(doc+"hDateRange").value);
    }
//    //boo = matchPattern(eval(doc+"txtHHMM").value,"^([0-1][0-9]|[2][0-3]):([0-5][0-9])$","Actual Dept. Time ");
    return true;
}


function ValidateData2(){
    var boo = false;
    if(eval(doc+"cboDocketDate").value=='' && Trim(eval(doc + "txtDocketList").value)==''){
        alert("Docket Bkg. Or Arrival Date?");
        eval(doc+"cboDocketDate").focus();
        return false;
    }
    
    eval(doc+"hDateRange").value="2";
    if(Trim(eval(doc+"txtDocketList").value)=='' && eval("document.aspnetForm."+"radDate[0]").checked){
        eval(doc+"hDateRange").value="0";
        boo = isValidDate(eval(doc+"txtFrom").value,'Docket From Date ');
        if(!boo){
            eval(doc+"txtFrom").focus();
            return false;
        }    

        boo = isValidDate(eval(doc+"txtTo").value,'Docket To Date ');
        if(!boo){
            eval(doc+"txtTo").focus();
            return false;
        }    

        if(MyDateCompare(eval(doc+"txtFrom").value,eval(doc+"txtTo").value)<0){
            alert('Docket From Date > To Date :(');
            eval(doc+"txtTo").focus();
            return false;
        }
    } else {
      for(i=1;i<4;i++) {
        if(eval("document.aspnetForm."+"radDate[" + i + "]").checked){
            eval(doc+"hDateRange").value=i;
        }
      }
    }

    if(eval(doc+"cboTranMode").value==''){
        alert("Select Transition Mode");
        eval(doc+"cboTranMode").focus();
        return false;
    }
    return true;
}

function parseDRSData(){
    var boo = false;
    boo = isValidDate(eval(doc+"txtDate").value,'DRS Date ');
    if(!boo){
        eval(doc+"txtDate").focus();
        return false;
    }    

    if(MyDateCompare(eval(doc+"hSysDate").value,eval(doc+"txtDate").value)>0) boo=false;
    if(!boo){
        alert("DRS Date cannot be greater than Sys. Date:" + eval(doc+"hSysDate").value);
        eval(doc+"txtDate").focus();
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
    
    switch(eval(doc+"cboVendorType").value)
    {
    case 'XX':
        if(Trim(eval(doc+"txtVehicle").value)==''){
            alert('Enter Market Vehicle # :(');
            eval(doc+"txtVehicle").focus();
            return false;
        }
      break;    
     case '05': //OWN Vendor
        if(eval(doc+"cboVehicles").value==''){
            alert('Select Vehicle :(');
            eval(doc+"cboVehicles").focus();
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
    boo = isValidDate(eval(doc+"txtIPDate").value,'Insurance Policy Date ');
    if(!boo){
        eval(doc+"txtIPDate").focus();
        return false;
    }    
    boo = isValidDate(eval(doc+"txtFCDate").value,'Fitness Certificate Date ');
    if(!boo){
        eval(doc+"txtFCDate").focus();
        return false;
    } 
        
    var tmpString = "";
    
    tmpString = Trim(eval(doc+"txtDriver").value);
    
    if(tmpString==""){
        alert('Enter Driver Name');
        eval(doc+"txtDriver").focus();
        return false;
    }

    boo = matchPattern(eval(doc+"txtHHMM").value,"^([0-1][0-9]|[2][0-3]):([0-5][0-9])$","Actual Dept. Time ");
    if(!boo){
        eval(doc+"txtHHMM").focus();
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

    if(AtleastOneDocketSelected()==0){
        alert('Kindly select atleat 1 Docket for DRS Generation :(');
        return false;
    }

    if(IsDRSDateLessThanDocketDate()){
        alert('Atleast one Docket selected has Date > DRS Date');
        return false;
    }

    return true;
}


function AtleastOneDocketSelected(){
  var knt=0;
    for (i=0; i < document.forms[0].elements.length; i++) 
    {
        if ((document.forms[0].elements[i].type == 'checkbox') && 
        (document.forms[0].elements[i].name.indexOf('dgDRS') > -1)
        ) 
        {
         if(document.forms[0].elements[i].checked == true) knt+=1;
        }
    }
  return knt;
}

function IsDRSDateLessThanDocketDate(){
 var boo = false;
 var knt=-1;
 if(document.aspnetForm.dockdt.length>1){
 
     for (i=0; i < document.forms[0].elements.length; i++) 
    {
        if ((document.forms[0].elements[i].type == 'checkbox') && (document.forms[0].elements[i].name.indexOf('dgDRS') > -1)) 
        {
         knt += 1;   
         if(document.forms[0].elements[i].checked == true) {
            if(MyDateCompare(document.aspnetForm.dockdt[knt].value,eval(doc+"txtDate").value)<0) boo=true;
         }
        }
    }
 } else
 {
    if(MyDateCompare(document.aspnetForm.dockdt.value,eval(doc+"txtDate").value)<0) boo=true;
 }
 
 return boo;
}

function SelectAll(CheckBoxControl) 
{
if (CheckBoxControl.checked == true) 
{
var i;
for (i=0; i < document.forms[0].elements.length; i++) 
{
if ((document.forms[0].elements[i].type == 'checkbox') && 
(document.forms[0].elements[i].name.indexOf('dgDRS') > -1)) 
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
(document.forms[0].elements[i].name.indexOf('dgDRS') > -1)) 
{
document.forms[0].elements[i].checked = false;
}
}
}
}
