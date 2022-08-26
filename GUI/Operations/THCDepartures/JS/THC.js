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
 eval(doc+"hTHCSelected").value=rdo.value;
 //alert(eval(doc+"hDRSSelected").value);
}

function PassSelectedTHCForDeparture(){
    if(eval(doc+"hTHCSelected").value==""){
        alert('Please select a THC for Departure');
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
    //Stock Update Date Validation
    //-----------------------------------------------------
    if(!isValidDate(eval(doc+"txtStockUpdateDate").value,'Stock Update Date ')) return false;
    if(MyDateCompare(eval(doc+"txtStockUpdateDate").value,eval(doc+"hSysDate").value)<0){
        alert('Stock Update Date cannot be greater than System Date:' + eval(doc+"hSysDate").value);
        eval(doc+"txtStockUpdateDate").focus();
        return false;
    }
    if(MyDateCompare(eval(doc+"txtStockUpdateDate").value,eval(doc+"hTHCArrvDate").value)>0){
        alert('Stock Update Date cannot be less than THC Arrival Date:' + eval(doc+"hTHCArrvDate").value);
        eval(doc+"txtStockUpdateDate").focus();
        return false;
    }
    //-----------------------------------------------------
    
    tmpDt = Trim(eval(doc+"txtStockUpdateDate").value);
    tmpDtArr = tmpDt.split('/');
    tmpDt = Trim(tmpDtArr[1]) + '/' +  Trim(tmpDtArr[0]) + '/' + Trim(tmpDtArr[2]);

    //-----------------------------------------------------
    //Loop Through Stock Update List Details
    //-----------------------------------------------------
    for(i=0;i<parseInt(eval(doc+"hStockList").value);i++){
        delyStatus = "U";
        xmlData = xmlData + "<SU><SUDate>" + tmpDt + "</SUDate>";
        //-----------------------------------------------------
        //Package Validation
        //-----------------------------------------------------
        if(i>9)
        {
            xmlData = xmlData + "<TCNO>" + Trim(eval('document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_hMF').value) + "</TCNO>"
            xmlData = xmlData + "<DOCKET>" + Trim(eval('document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_hDocket').value) + "</DOCKET>"
            xmlData = xmlData + "<DOCKETSF>" + Trim(eval('document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_hDocketSF').value) + "</DOCKETSF>"
            cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_txtArrvPkgs';
            cntrNameHidden = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_hPkgs';
        } else 
        {
            xmlData = xmlData + "<TCNO>" + Trim(eval('document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl'+ '0' + i +'_hMF').value) + "</TCNO>"
            xmlData = xmlData + "<DOCKET>" + Trim(eval('document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0' + i +'_hDocket').value) + "</DOCKET>"
            xmlData = xmlData + "<DOCKETSF>" + Trim(eval('document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0' + i +'_hDocketSF').value) + "</DOCKETSF>"
            cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0'+ i +'_txtArrvPkgs'; 
            cntrNameHidden = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0'+ i +'_hPkgs';
        }
        
        if(Trim(eval(cntrName).value)=='') {
            alert('Packages Arrived cannot be empty :(');
            eval(cntrName).focus();
            return false;
        }   

        if(isNaN(Trim(eval(cntrName).value))) {
            alert('Packages Arrived should be Numeric :(');
            eval(cntrName).focus();
            return false;
        }   

        if(parseInt(Trim(eval(cntrName).value)) < 0){
            alert('Packages Arrived cannot be negative :(');
            eval(cntrName).focus();
            return false;
        }

        
        if(parseInt(Trim(eval(cntrName).value)) > parseInt(Trim(eval(cntrNameHidden).value))){
            alert('Packages Arrived cannot be greater than Actual Pkgs. :(');
            eval(cntrName).focus();
            return false;
        }

        xmlData = xmlData + "<PKGSTOBEARRIVED>" + Trim(eval(cntrNameHidden).value) + "</PKGSTOBEARRIVED>";
        xmlData = xmlData + "<PKGSARRIVED>" + Trim(eval(cntrName).value) + "</PKGSARRIVED>";
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
        //Weight Validation
        //-----------------------------------------------------
        if(i>9)
        {
//            xmlData = xmlData + "<DOCKET>" + Trim(eval('document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_hDocket').value) + "</DOCKET>"
//            xmlData = xmlData + "<DOCKETSF>" + Trim(eval('document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_hDocketSF').value) + "</DOCKETSF>"
            cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_txtArrvWt';
            cntrNameHidden = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_hWt';
        } else 
        {
//            xmlData = xmlData + "<DOCKET>" + Trim(eval('document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0' + i +'_hDocket').value) + "</DOCKET>"
//            xmlData = xmlData + "<DOCKETSF>" + Trim(eval('document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0' + i +'_hDocketSF').value) + "</DOCKETSF>"
            cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0'+ i +'_txtArrvWt'; 
            cntrNameHidden = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0'+ i +'_hWt';
        }
        
        if(Trim(eval(cntrName).value)=='') {
            alert('Wt. Arrived cannot be empty :(');
            eval(cntrName).focus();
            return false;
        }   

        if(isNaN(Trim(eval(cntrName).value))) {
            alert('Wt Arrived should be Numeric :(');
            eval(cntrName).focus();
            return false;
        }   

        if(parseInt(Trim(eval(cntrName).value)) < 0){
            alert('Wt. Arrived cannot be negative :(');
            eval(cntrName).focus();
            return false;
        }
        
        if(parseInt(Trim(eval(cntrName).value)) > parseInt(Trim(eval(cntrNameHidden).value))){
            alert('Wt. Arrived cannot be greater than Actual Wt. :(');
            eval(cntrName).focus();
            return false;
        }

        if(delyStatus == "P" && parseInt(Trim(eval(cntrName).value))==parseInt(Trim(eval(cntrNameHidden).value))){
            alert('Wt. Arrived should be less than Actual Wt. as Pkgs. arrived is less than Actual Pkgs.:(');
            eval(cntrName).focus();
            return false;
        }


        xmlData = xmlData + "<WTTOBEARRIVED>" + Trim(eval(cntrNameHidden).value) + "</WTTOBEARRIVED>";
        xmlData = xmlData + "<WTARRIVED>" + Trim(eval(cntrName).value) + "</WTARRIVED>";


        if(i>9)
        {
            cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_cboArrivalConditions';
        } else 
        {
            cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0'+ i +'_cboArrivalConditions'; 
        }

        if(Trim(eval(cntrName).value)=='') {
            alert('Select Arrival Condition :(');
            eval(cntrName).focus();
            return false;
        }   
        xmlData = xmlData + "<ARRVCOND>" + Trim(eval(cntrName).value) + "</ARRVCOND>";

        if(i>9)
        {
            cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_cboGodowns';
        } else 
        {
            cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0'+ i +'_cboGodowns'; 
        }

        if(Trim(eval(cntrName).value)=='0') {
            alert('Select Godown :(');
            eval(cntrName).focus();
            return false;
        }   
        
        xmlData = xmlData + "<GODOWN>" + Trim(eval(cntrName).value) + "</GODOWN>";
        
        //-----------------------------------------------------
        //Delivery Date Validation
        //-----------------------------------------------------
        if(i>9)
        {
            cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_txtDelyDt';
            cntrNameCommDelyDt = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i + '_hCDelyDt';
            cntrNameHidden = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i + '_hDelyOnStockUpdate';
        } else 
        {
            cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0'+ i +'_txtDelyDt'; 
            cntrNameCommDelyDt = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0' + i + '_hCDelyDt';
            cntrNameHidden = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0' + + i + '_hDelyOnStockUpdate';
        }

        //If Dely On Arrival
        if(Trim(eval(cntrNameHidden).value)=='1')
        {
            if(Trim(eval(cntrName).value)=='') {
                alert('Delivery Date cannot be empty :(');
                eval(cntrName).focus();
                return false;
            }   

            if(!isValidDate(eval(cntrName).value,'Delivery Date ')) return false;

            if(MyDateCompare(eval(doc+"txtStockUpdateDate").value,eval(cntrName).value)>0){
                alert('Delivery Date cannot be greater than Stock Update Date:' + eval(doc+"txtStockUpdateDate").value);
                eval(cntrName).focus();
                return false;
            }

            if(MyDateCompare(eval(doc+"hTHCArrvDate").value,eval(cntrName).value)<0){
                alert('Delivery Date cannot be less than THC Arrival Date:' + eval(doc+"hTHCArrvDate").value);
                eval(cntrName).focus();
                return false;
            }

            tmpDt = Trim(eval(cntrName).value);
            tmpDtArr = tmpDt.split('/');
            tmpDt = Trim(tmpDtArr[1]) + '/' +  Trim(tmpDtArr[0]) + '/' + Trim(tmpDtArr[2]);
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
            xmlData = xmlData + "<DELYPERSON>" + Trim(eval(cntrName).value) + "</DELYPERSON></SU>";


//            //-----------------------------------------------------
//            //COD-DOD Validation
//            //-----------------------------------------------------
//            if(i>9)
//            {
//              cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_txtCODDOCCollected';
//              cntrNameHidden = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_hCODDODAmount';
//              cntrNameCODDOD = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_hCODDOD';
//              cntrNameCODDODNo = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + i +'_txtCODDODNo';
//            } else 
//            {
//              cntrName = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0'+ i +'_txtCODDOCCollected'; 
//              cntrNameHidden = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0'+  i +'_hCODDODAmount';
//              cntrNameCODDOD = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' + '0'+  i +'_hCODDOD';
//              cntrNameCODDODNo = 'document.aspnetForm.ctl00_MyCPH1_rptDocketList_ctl' +  '0'+ i +'_txtCODDODNo';
//            }

//        
//            if(eval(cntrNameCODDOD).value=="Y"){ //IF CODDOD    
//                if(Trim(eval(cntrName).value)==""){
//                    alert('Enter CODDOD Collected');
//                    eval(cntrName).focus();
//                    return false;
//                }

//                if(isNaN(Trim(eval(cntrName).value))) {
//                    alert('CODDOD Collected should be Numeric :(');
//                    eval(cntrName).focus();
//                    return false;
//                }   
//                
//                if(parseInt(Trim(eval(cntrName).value)) < parseInt(Trim(eval(cntrNameHidden).value))){
//                    alert('CODDOD Collected cannot be less than CODDOD Amount :(');
//                    eval(cntrName).focus();
//                    return false;
//                }

//                if(Trim(eval(cntrNameCODDODNo).value)==""){
//                    alert('Enter CODDOD No');
//                    eval(cntrNameCODDODNo).focus();
//                    return false;
//                }
//                xmlData = xmlData + "<CODDODAMOUNT>" + Trim(eval(cntrNameHidden).value) + "</CODDODAMOUNT>";
//                xmlData = xmlData + "<CODDODCOLLECTED>" + Trim(eval(cntrName).value) + "</CODDODCOLLECTED>";
//                xmlData = xmlData + "<CODDODNO>" + Trim(eval(cntrNameCODDODNo).value) + "</CODDODNO></DRS>";
//            } else { //
//                xmlData = xmlData + "<CODDODAMOUNT>0</CODDODAMOUNT>";
//                xmlData = xmlData + "<CODDODCOLLECTED>0</CODDODCOLLECTED>";
//                xmlData = xmlData + "<CODDODNO>-</CODDODNO></DRS>";
//            }
         } else {
            xmlData = xmlData + "<DELYDATE>01/01/1900</DELYDATE>";
            xmlData = xmlData + "<DELYSTATUS>N</DELYSTATUS>";
            xmlData = xmlData + "<DELYTIME>00:00</DELYTIME>";
            xmlData = xmlData + "<DELYREASON>-</DELYREASON>";
            xmlData = xmlData + "<DELYPERSON>-</DELYPERSON></SU>";
         }  
         //End If Dely On Arrival 
    }//End of Loop Through SU Details


    xmlData = xmlData + "</root>";
    eval(doc+"hXMLData").value=xmlData;
//    alert(eval(doc+"hXMLData").value);
//    return false;
    document.aspnetForm.method="post";
    document.aspnetForm.action="./StockUpdateSubmit.aspx";
    document.aspnetForm.submit();
}




function ValidateData2(){
    var boo = false;

    if(Trim(eval(doc+"txtVFS").value)==""){
        alert("Enter Vehicle Free Space :(");
        eval(doc+"txtVFS").focus();
        return false;
    }

    if(isNaN(eval(doc+"txtVFS").value)){
        alert("Enter Numeric Value for Out VFS :(");
        eval(doc+"txtVFS").focus();
        return false;
    }
    
    if(parseInt(eval(doc+"txtVFS").value)<0 || parseInt(eval(doc+"txtVFS").value)>100){
        alert("Vehicle Free Space should be between 0 and 100 :(");
        eval(doc+"txtVFS").focus();
        return false;
    }
    
    if(Trim(eval(doc+"txtSeal").value)==""){
        alert("Enter Seal No. :(");
        eval(doc+"txtSeal").focus();
        return false;
    }

    tmpString = Trim(eval(doc+"txtSeal").value);
    if(tmpString.length<3){
        alert("Seal No. should be atleast 3 chars. :(");
        eval(doc+"txtSeal").focus();
        return false;
    }

    boo = isValidDate(eval(doc+"txtATD").value,'THC Actual Departure Date ');
    if(!boo){
        eval(doc+"txtATD").focus();
        return false;
    }    

    if(MyDateCompare(eval(doc+"hSysDate").value,eval(doc+"txtATD").value)>0) boo=false;
    if(!boo){
        alert("THC Actual Departure Date cannot be greater than Sys. Date:" + eval(doc+"hSysDate").value);
        eval(doc+"txtATD").focus();
        return false;
    }    

    //alert(eval(doc+"hATADate").value);
    if(MyDateCompare(eval(doc+"hATADate").value,eval(doc+"txtATD").value)<0) boo=false;
    if(!boo){
        alert("THC Actual Departure Date cannot be Less than ATA:" + eval(doc+"hATADate").value);
        eval(doc+"txtATD").focus();
        return false;
    }    
    
    boo = matchPattern(eval(doc+"txtHHMM").value,"^([0-1][0-9]|[2][0-3]):([0-5][0-9])$","Actual Dept. Time ");
    if(!boo){
        eval(doc+"txtHHMM").focus();
        return false;
    }    
        
    if(MyDateCompare(eval(doc+"hATADate").value,eval(doc+"txtATD").value)==0 && eval(doc+"txtHHMM").value<eval(doc+"hATATime").value){
        alert("THC Actual Departure Time cannot be Less than ATA:" + eval(doc+"hATATime").value);
        eval(doc+"txtHHMM").focus();
        return false;
    }        
        

   var validateURL="./IsValidEmployee.aspx?EmpCode=" + Trim(eval(doc+"txtEmpCode").value) + "&sid=" + Math.random();
   boo = ValidateObjectValue(eval(doc+"txtEmpCode"),validateURL);
   if(!boo){
     return false;
   } 

    if(Trim(eval(doc+"txtOutgoingRemarks").value)==''){
        alert('Enter Outgoing Remarks :(');
        eval(doc+"txtOutgoingRemarks").focus();
        return false;
    }

    //return true;
}




function ValidateData(){
    //alert(eval("document.aspnetForm."+"radDate[0]").checked);
    var boo = false;
    eval(doc+"hTHCSelected").value="";
    eval(doc+"hDateRange").value="2";
    if(Trim(eval(doc+"txtTHCList").value)=='' && eval("document.aspnetForm."+"radDate[0]").checked){
        eval(doc+"hDateRange").value="0";
        boo = isValidDate(eval(doc+"txtFrom").value,'THC Arrival From Date ');
        if(!boo){
            eval(doc+"txtFrom").focus();
            return false;
        }    

        boo = isValidDate(eval(doc+"txtTo").value,'THC Arrival To Date ');
        if(!boo){
            eval(doc+"txtTo").focus();
            return false;
        }    

        if(MyDateCompare(eval(doc+"txtFrom").value,eval(doc+"txtTo").value)<0){
            alert('THC Arrival From Date > To Date :(');
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
    //FreezeGridViewHeader(eval(doc +'dgTHC'),'WrapperDiv');
    return true;
}


function ValidateData2_OLD(){
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
(document.forms[0].elements[i].name.indexOf('dgMF') > -1)) 
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


    function FreezeGridViewHeader(gridID,wrapperDivCssClass) 
    {
        /// <summary>
        ///   Used to create a fixed GridView header and allow scrolling
        /// </summary>
        /// <param name="gridID" type="String">
        ///   Client-side ID of the GridView control
        /// </param>
        /// <param name="wrapperDivCssClass" type="String">
        ///   CSS class to be applied to the GridView's wrapper div element.  
        ///   Class MUST specify the CSS height and width properties.  
        ///   Example: width:800px;height:400px;border:1px solid black;
        /// </param>
        var grid = document.getElementById(gridID);
        if (grid != 'undefined')
        {
            grid.style.visibility = 'hidden';
            var div = null;
            if (grid.parentNode != 'undefined') 
            {
                //Find wrapper div output by GridView
                div = grid.parentNode;
                if (div.tagName == "DIV")
                {
                    div.className = wrapperDivCssClass;  
                    div.style.overflow = "auto";                   
                }
            }                
            //Find DOM TBODY element and remove first TR tag from 
            //it and add to a THEAD element instead so CSS styles
            //can be applied properly in both IE and FireFox
            var tags = grid.getElementsByTagName('TBODY');
            if (tags != 'undefined')
            {
                var tbody = tags[0];
                var trs = tbody.getElementsByTagName('TR');
                var headerHeight = 8;
                if (trs != 'undefined') 
                {
                    headerHeight += trs[0].offsetHeight;
                    var headTR = tbody.removeChild(trs[0]);
                    var head = document.createElement('THEAD');
                    head.appendChild(headTR);
                    grid.insertBefore(head, grid.firstChild);
                }
                //Needed for Firefox
                tbody.style.height = 
                  (div.offsetHeight -  headerHeight) + 'px';
                tbody.style.overflowX = "hidden";
                tbody.overflow = 'auto';
                tbody.overflowX = 'hidden';
            }
            grid.style.visibility = 'visible';
        }
    }
