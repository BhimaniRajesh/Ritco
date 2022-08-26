User_Ctrl_FrmNm="ctl00_MyCPH1_UCMyPaymentControl1_"
/*************************************************************************************************************
             FUNCTION FOR NO OF DECIMAL VALUE
*************************************************************************************************************/

 function rounditn(Num,decplaces)
	{
		Places=decplaces
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
				//alert("Hi")
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
		else return Math.round(Num);
		
	}     
	
/*************************************************************************************************************
            function assignment in keypress doesn't allow any character other than number
*************************************************************************************************************/

 
function validInt(event)
{
    if(event.keyCode==13)
    {
    return true;
    }
    if(event.keyCode<48 || event.keyCode>57)
    {
    event.keyCode=0;return false;
    }
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

/*************************************************************************************************************
          FUNCTION FOR ADD DUE DATE
*************************************************************************************************************/

function ADD_DueDate()
{
		var dockdta=document.getElementById("ctl00_MyCPH1_TxtVoucherDT").value
		
		dockdta_dd=dockdta.substring(0,2)
		dockdta_mm=dockdta.substring(3,5)
		dockdta_yy=dockdta.substring(6,10)  
			
		var dockdt_billdt=new Date(months[parseFloat(dockdta_mm)] + " " + parseFloat(dockdta_dd) + ", " + parseFloat(dockdta_yy))
		var days=parseInt(document.getElementById("ctl00_MyCPH1_Txt_DueDays").value)
		dues=dateAdd('D',days,dockdt_billdt)
		document.getElementById("ctl00_MyCPH1_Txt_Duedate").value=Datadate1(dues)
}
function dateAdd(intval, numb, base){
	/*intval is YYYY, M, D, H, N, S as in VBscript; numb is amount +/-; base is javascript date object*/
	switch(intval){
		case "M":
			base.setMonth(base.getMonth() + numb);
			break;
		case "YYYY":
			base.setFullYear(base.getFullYear() + numb);
			break;
		case "D":
			base.setDate(base.getDate() + numb);
			break;
		case "H":
			base.setHours(base.getHours() + numb);
			break;
		case "N":
			base.setMinutes(base.getMinutes() + numb);
			break;
		case "S":
			base.setSeconds(base.getSeconds() + numb);
			break;
		default:
	}
	return base
}	
function Datadate1(dt)
{
	dd=parseInt(dt.getDate())
	//alert(dd)
	mm=parseInt(dt.getMonth()+1)
	//alert(mm)
	yy=parseInt(dt.getFullYear())
	//alert(yy)
	    
	    if(parseInt(dd)<10)
	    {
	    dd="0"+dd
	    }
	    
	    if(parseInt(mm)<10)
	    {
	    mm="0"+mm
	    }
	    
	    dt=dd + "/" + mm + "/" + yy
	    //alert(dt)
	 	return dt
	 	
	 	
	 	    
}
/*****************************************************************************************************************
                                THIS FUCNTION IS USED TO RETRIEVE HTTP OBJECT
                                    return type XMLHttpObject
*****************************************************************************************************************/
function GetXMLHttpObject()
  { 
      var xmlHttp;
      try
        {    
            xmlHttp=new XMLHttpRequest();    // Firefox, Opera 8.0+, Safari    
        }
      catch (e)
        {
            // Internet Explorer    
            try
              {  
                  xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");      
              }
            catch (e)
              {      
                try
                    {xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");}
                catch (e)
                    {
                        alert("Your browser does not support AJAX!");        
                        return false;        
                    }      
              }    
         }
         return xmlHttp;  
   }
   
function matchPattern(Str,Pattern,str) 
    {
        var matchArray = Str.match(Pattern); // is the format ok?
        if (matchArray == null){
                alert("Please Enter " + str + " in correct format");
                return false;
        } else {
            return true;
        }
    }
    
    /*************************************************************************************************************
             FUNCTION VALIDATES DATESTR........ UT STR IS ONLY STRING TO DISPLAY CONTROL NAME
*************************************************************************************************************/

function ValidateDate(obj)
    {
          if (obj.value!="")
          {       
         // alert(isDate(obj.value))
            if (isDate(obj.value)==false)
	        {
                obj.focus()
		        return false
	        }
	         
          }
          
    }
var dtCh= "/";
var minYear=1900;
var maxYear=2100;

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

function daysInFebruary (year){
	// February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}

function DaysArray(n) {
	for (var i = 1; i <= n; i++) {
		this[i] = 31
		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
		if (i==2) {this[i] = 29}
   } 
   return this
}

function isDate(dtStr){
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

    /*************************************************************************************************************
             FUNCTION VALIDATES Vendor/Vehicle COde
*************************************************************************************************************/

 function VenDor_Vechicle_Blur(Obj,Mode)
 {
                
    
                if(Obj.value=="")
                {
                        return false;
                }
                var Search_Char="~"
		        if (Obj.value.indexOf(Search_Char)==-1)
		        {
		           alert("Invalid  "+ Mode +"  Name~Code Format");
		           Obj.focus();
		           return false
		        }
    Obj.value=Obj.value.toUpperCase()
    var Code_ID=Obj;
   
    var Code_Value=Code_ID.value;
    Code_Value_Arr=Code_Value.split("~");
    
    var Code_Value_0=Code_Value_Arr[0]
    var Code_Value_1=Code_Value_Arr[1]
    
    if(Code_Value_1=="")
    return false;
    
    var findobj=false;
    findobj=GetXMLHttpObject();
   
    if(findobj)
    {
    //alert("Hi..1")
    //alert(Code_Value_1)
    //alert(Mode)
     var strpg="../CheckExist.aspx?Mode="+Mode+"&Code=" + Code_Value_1 + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
            // alert("Hi..2")
            // alert(findobj.readyState)
             // alert(findobj.status)
             if(findobj.readyState==4 && findobj.status==200)
                {
                    //alert(findobj.responseText)
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                        alert(Mode + "  Code is not Valid... Please Enter Valid "+ Mode +" Code");
                        Code_ID.value="";
                        Code_ID.focus();
                        return false;
                    }
                   
                }
         }
    findobj.send(null);
    }
    return false;
}

/*************************************************************************************************************
             FUNCTION FOr Check All
*************************************************************************************************************/
var  FRM_NM="ctl00_MyCPH1_"
function Check_All(Grd_Name,Obj_chk_All,Obj_Chk_Ind,CalC_YN)
	    {
	             
	             Grid_Id=Grd_Name
	             var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
                 var rows=grid.rows.length;  
                 var Check_One="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                 if(document.getElementById("ctl00$MyCPH1$"+Grid_Id+"$ctl01$"+Obj_chk_All).checked)
                 {
                      for(var b=2;b<=rows;b++)
                      {
                            // alert(b)
                            if(b<10)
                            {
                                GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + b + "_";
                            }
                            else
                            {
                                 GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_";
                            }       
                             
                                        document.getElementById(GV_FRM_NM+Obj_Chk_Ind).checked=true
                           //alert("hi..")
                      }
                  }
                  else
                  {
                             for(var b=2;b<=rows;b++)
                              {
                                    //alert(b)
                                    if(b<10)
                                    {
                                        GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + b + "_";
                                    }
                                    else
                                    {
                                         GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_";
                                    }
                                    
                                    document.getElementById(GV_FRM_NM+Obj_Chk_Ind).checked=false
                             
                              }
                  }
                  if(CalC_YN=="Y")
                  {
                   // alert("hi..1")
                     Check_Calc('GridDocList','ChkAll','Chk_Docno')
                     // alert("hi..2")
                  }
    }
    
        
    	function Check_Calc(Grd_Name,Obj_chk_All,Obj_Chk_Ind)
	    {        
	            
	             Grid_Id=Grd_Name
	             var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
                 var rows=grid.rows.length;  
                  var Check_ALL="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                 var Total_adv_amt="0.00",Total_PendAmt="0.00"
                 var Total_billAmount="0"
                  for(var b=2;b<=rows;b++)
                  {
                  
                                    if(b<10)
                                    {
                                        GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + b + "_";
                                    }
                                    else
                                    {
                                         GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_";
                                    }
                                 //alert("1...."+b)
                                document.getElementById("ctl00$MyCPH1$"+Grid_Id+"$ctl01$"+Obj_chk_All).checked=true
                                if(document.getElementById(GV_FRM_NM+Obj_Chk_Ind).checked==false)
                                {
                                    //alert(document.getElementById(GV_FRM_NM+Obj_Chk_Ind).checked)
                                     Check_ALL="Y"
                                }
                                if(Check_ALL=="Y")
                                {
                                    document.getElementById("ctl00$MyCPH1$"+Grid_Id+"$ctl01$"+Obj_chk_All).checked=false
                                }
 
                    } 
                  
                  
                 
                
	    }
	    
 /*************************************************************************************************************
           Advance Payment Calculation Function
*************************************************************************************************************/

	function Total_calC_THC_ADVPayment()
	{ 
	    //alert("hi..")
		var grid=document.getElementById("ctl00_MyCPH1_GV_THC_ADV_PAYMENT");
        var rows=grid.rows.length;  
        var Total_AdvAmt=0
        
        for(var b=2;b<rows;b++)
        {
                                    if(b<10)
                                    {
                                        GV_FRM_NM="ctl00_MyCPH1_GV_THC_ADV_PAYMENT_ctl0" + b + "_";
                                    }
                                    else
                                    {
                                         GV_FRM_NM="ctl00_MyCPH1_GV_THC_ADV_PAYMENT_ctl" + b + "_";
                                    }
          IndPCAmt=document.getElementById(GV_FRM_NM+"indpcamt").value 
          IndOthAmt=document.getElementById(GV_FRM_NM+"indothamt").value 
          //IndTds=document.getElementById(GV_FRM_NM+"Ind_Tds").value     
          //IndStax=document.getElementById(GV_FRM_NM+"Ind_Stax").value         
          IndAdvAmt=document.getElementById(GV_FRM_NM+"indadvamt").value 
          Ind_BalAmt=document.getElementById(GV_FRM_NM+"Ind_BalAmt").value     
          var NetBalAmt=0
                  if(parseFloat(IndPCAmt)>0)
                  {
                    NetBalAmt=parseFloat(IndPCAmt)+parseFloat(IndOthAmt)-parseFloat(IndAdvAmt)
                        if(parseFloat(NetBalAmt)< 0)
                        {
                            WO_AdvAmt=parseFloat(IndPCAmt)+parseFloat(IndOthAmt) 
                            alert("Advance Amount Should Be Less Then Contract Amt + Other Amt. - Tds + S.Tax : " + WO_AdvAmt )
                            document.getElementById(GV_FRM_NM+"indadvamt").focus()
                            return false;
                        }
                        else
                        {
                            document.getElementById(GV_FRM_NM+"Ind_BalAmt").value=rounditn(NetBalAmt,2)
                        }
                 }
          Total_AdvAmt= parseFloat(Total_AdvAmt)+parseFloat(document.getElementById(GV_FRM_NM+"indadvamt").value)    
        }
        if(rows<10)
        {
           GV_FRM_NM="ctl00_MyCPH1_GV_THC_ADV_PAYMENT_ctl0" + rows + "_";
        }
        else
        {
           GV_FRM_NM="ctl00_MyCPH1_GV_THC_ADV_PAYMENT_ctl" + rows + "_";
        }
        document.getElementById(GV_FRM_NM+"TotalNetamt").value=rounditn(Total_AdvAmt,2)
        document.getElementById(User_Ctrl_FrmNm+"txtNetPay").value=rounditn(Total_AdvAmt,2) 
        document.getElementById(User_Ctrl_FrmNm+"txtAmtApplA").value=rounditn(Total_AdvAmt,2) 
        if(document.getElementById(User_Ctrl_FrmNm+"ddlPayMode").value=="Cash")
        {
          document.getElementById(User_Ctrl_FrmNm+"txtCashAmt").value=rounditn(Total_AdvAmt,2) 
        }
        else if(document.getElementById(User_Ctrl_FrmNm+"ddlPayMode").value=="Bank")
        {
          document.getElementById(User_Ctrl_FrmNm+"txtChqAmt").value=rounditn(Total_AdvAmt,2) 
        }
        
	}
	
	/*************************************************************************************************************
           Balance Payment/BillEntry Calculation Function
*************************************************************************************************************/
var PaymentAmt_Flag = "N";
function Total_calC_THC_BalPayment(OBJ, Cnt, COl_Cnt, Contract_Type) 
{
    Objname = OBJ.name.replace(Form_name, '');
    if (Objname == "indNetBillPaymentAmt") 
    {
        PaymentAmt_Flag = "Y";
    }
    var grid = document.getElementById("ctl00_MyCPH1_GV_THC_BAL_PAYMENT");
    var rows = grid.rows.length;
    Total_SvcTax = 0;
    Total_Tds = 0;
    Tot_bal_Amt = 0;
    Total_BalanceAMT = 0;
    IND_BalanceAMT = 0;
    Total_PaymentAMT = 0;
    if (Cnt < 10)
        Form_name = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + "0" + Cnt + "$";
    else
        Form_name = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + Cnt + "$";
       
    var Advamt=parseFloat(document.getElementById(Form_name+"indadvamt").value);
    var OtherAmt = parseFloat(document.getElementById(Form_name + "indothamt").value);

    Charge_Val_Tot = 0;
    Hnd_SCHG_Arr=document.getElementById(Form_name+"Hnd_SCHG").value.split("*/"); 
    for (var k=0;k<Hnd_SCHG_Arr.length;k++)
    {
         j = parseFloat(k) + parseFloat(1);
         if(document.getElementById(Form_name+"SCHG"+j))
         {
               Code_Operand_Arr=Hnd_SCHG_Arr[k].split("~");
               Code_Operand = Code_Operand_Arr[3];
               Charge_Val = Code_Operand + document.getElementById(Form_name + "SCHG" + j).value;
               Charge_Val_Tot = parseFloat(Charge_Val_Tot) + parseFloat(Charge_Val);
         }
         
    }
    if(Contract_Type=="KM_BASED")
    {
      var Tot_ind_Balamt = -parseFloat(Advamt) + parseFloat(OtherAmt) + parseFloat(Charge_Val_Tot);

    }
    else
    {
      ContractAmt = parseFloat(document.getElementById(Form_name + "indpcamt").value);
      var Tot_ind_Balamt = parseFloat(ContractAmt) - parseFloat(Advamt) + parseFloat(OtherAmt) + parseFloat(Charge_Val_Tot);
    }    
    if(parseFloat(Tot_ind_Balamt)<=0)
    {
      if (PaymentAmt_Flag == "N") {
          if (document.getElementById(FRM_NM + "RD_Process_Payment").checked) {
              document.getElementById(Form_name + "indNetBillPaymentAmt").value = "0.00"
          }
      }
      document.getElementById(Form_name + "indNetPaymentAmt").value = "0.00";
    }
    else
    {
        if (PaymentAmt_Flag == "N") 
        {
     
          if (document.getElementById(FRM_NM + "RD_Process_Payment").checked) {
              document.getElementById(Form_name + "indNetBillPaymentAmt").value = rounditn(Tot_ind_Balamt, 2);
          }
        }
        document.getElementById(Form_name + "indNetPaymentAmt").value = rounditn(Tot_ind_Balamt, 2);
    }
    if (parseFloat(document.getElementById(Form_name + "indNetPaymentAmt").value) < parseFloat(document.getElementById(Form_name + "indNetBillPaymentAmt").value)) 
    {
        alert("Bill Entry Payment Amount sould be less then Bill Entry Amount");
        document.getElementById(Form_name + "indNetBillPaymentAmt").value = 0.00;
        document.getElementById(Form_name + "indNetBillPaymentAmt").focus();
        return false;
    }

    if(rows < 10)
        Form_name_Footer = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + "0" + rows + "$"
    else
        Form_name_Footer = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + rows + "$"

    //alert(rows);
    //alert(Form_name_Footer);
    var Grid=document.getElementById("ctl00_MyCPH1_GV_THC_BAL_PAYMENT");
    var rows=grid.rows.length;  
    Grid_Id="GV_THC_BAL_PAYMENT"
    TOTal_CHG_AMT=0
    for (var b = 2; b <= rows - 1; b++) {
        if (b < 10) {
            GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl0" + b + "_";
            GV_FRM_NM_Footer = "ctl00_MyCPH1_" + Grid_Id + "_ctl0" + rows + "_";
        }
        else {
            GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl" + b + "_";
            GV_FRM_NM_Footer = "ctl00_MyCPH1_" + Grid_Id + "_ctl" + rows + "_";
        }
        GV_FRM_NM_Footer = Form_name_Footer
        //alert(GV_FRM_NM_Footer);
        if (document.getElementById(GV_FRM_NM + "SCHG" + COl_Cnt)) {
            TOTal_CHG_AMT = rounditn(parseFloat(TOTal_CHG_AMT) + parseFloat(document.getElementById(GV_FRM_NM + "SCHG" + COl_Cnt).value), 2)
        }
        //alert(TOTal_CHG_AMT)
        if (document.getElementById(GV_FRM_NM_Footer + "Total_SCHG" + COl_Cnt)) {
            document.getElementById(GV_FRM_NM_Footer + "Total_SCHG" + COl_Cnt).value = rounditn(TOTal_CHG_AMT, 2)
        }
        Total_BalanceAMT = rounditn(parseFloat(Total_BalanceAMT) + parseFloat(document.getElementById(GV_FRM_NM + "indNetPaymentAmt").value), 2)
        Total_PaymentAMT = parseFloat(Total_PaymentAMT) + parseFloat(document.getElementById(GV_FRM_NM + "indNetBillPaymentAmt").value)
    }
    document.getElementById(Form_name_Footer+"Total_BalanceAMT").value=rounditn(Total_BalanceAMT,2)
    if(Contract_Type=="KM_BASED")
    {
        Total_BalanceAMT=parseFloat(Total_BalanceAMT)+parseFloat(document.getElementById(FRM_NM+"Txt_ContractAmt").value)
    }

    document.getElementById(FRM_NM + "Txt_PaymentAmt").value = rounditn(Total_PaymentAMT, 2);
    document.getElementById(FRM_NM + "Hnd_PaymentAmt").value = rounditn(Total_PaymentAMT, 2);

    document.getElementById(FRM_NM + "Txt_PendingAmt").value = rounditn(Total_BalanceAMT - Total_PaymentAMT, 2);
    document.getElementById(Form_name1 + "Total_BillPayment").value = rounditn(Total_PaymentAMT, 2);
    document.getElementById(FRM_NM+"txtAmtAppl").value=rounditn(Total_BalanceAMT,2)
    document.getElementById(FRM_NM + "txtAmtApplL").value = rounditn(Total_BalanceAMT, 2)

    Stax_Tds_Calc()
}
function Total_calC_THC_BalPayment_New(OBJ, Cnt, COl_Cnt, Contract_Type) 
{
    Objname = OBJ.name.replace(Form_name, '');
    if (Objname == "indNetBillPaymentAmt") {
        PaymentAmt_Flag = "Y";
    }
    var grid = document.getElementById("ctl00_MyCPH1_GV_THC_BAL_PAYMENT");
    var rows = grid.rows.length;
    Total_SvcTax = 0;
    Total_Tds = 0;
    Tot_bal_Amt = 0;
    Total_BalanceAMT = 0;
    IND_BalanceAMT = 0;
    Total_PaymentAMT = 0;
    if (Cnt < 10)
        Form_name = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + "0" + Cnt + "$";
    else
        Form_name = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + Cnt + "$";

    var Advamt = parseFloat(document.getElementById(Form_name + "indadvamt").value);
    var OtherAmt = parseFloat(document.getElementById(Form_name + "indothamt").value);

    Charge_Val_Tot = 0;
    Hnd_SCHG_Arr = document.getElementById(Form_name + "Hnd_SCHG").value.split("*/");
    for (var k = 0; k < Hnd_SCHG_Arr.length; k++) {
        j = parseFloat(k) + parseFloat(1);
        if (document.getElementById(Form_name + "SCHG" + j)) {
            Code_Operand_Arr = Hnd_SCHG_Arr[k].split("~");
            Code_Operand = Code_Operand_Arr[3];
            Charge_Val = Code_Operand + document.getElementById(Form_name + "SCHG" + j).value;
            Charge_Val_Tot = parseFloat(Charge_Val_Tot) + parseFloat(Charge_Val);
        }

    }
    if (Contract_Type == "KM_BASED") {
        var Tot_ind_Balamt = -parseFloat(Advamt) + parseFloat(OtherAmt) + parseFloat(Charge_Val_Tot);

    }
    else {
        ContractAmt = parseFloat(document.getElementById(Form_name + "indpcamt").value);
        var Tot_ind_Balamt = parseFloat(ContractAmt) - parseFloat(Advamt) + parseFloat(OtherAmt) + parseFloat(Charge_Val_Tot);
    }
    if (parseFloat(Tot_ind_Balamt) < 0) 
    {
        alert("Total Charges Amount Should Be Less Than Balance Amount");
        document.getElementById(Form_name + "indNetPaymentAmt").value = rounditn(Tot_ind_Balamt, 0);
    }
    else if (parseFloat(Tot_ind_Balamt) == 0) 
    {
        if (PaymentAmt_Flag == "N") {
            if (document.getElementById(FRM_NM + "RD_Process_Payment").checked) {
                document.getElementById(Form_name + "indNetBillPaymentAmt").value = "0.00";
            }
        }
        document.getElementById(Form_name + "indNetPaymentAmt").value = "0.00";
    }
    else 
    {
        if (PaymentAmt_Flag == "N") {
            if (document.getElementById(FRM_NM + "RD_Process_Payment").checked) {
                document.getElementById(Form_name + "indNetBillPaymentAmt").value = rounditn(Tot_ind_Balamt, 0);
            }
        }
        document.getElementById(Form_name + "indNetPaymentAmt").value = rounditn(Tot_ind_Balamt, 0);
    }
    
    if (parseFloat(document.getElementById(Form_name + "indNetPaymentAmt").value) < parseFloat(document.getElementById(Form_name + "indNetBillPaymentAmt").value)) 
    {
        alert("Bill Entry Payment Amount sould be less then Bill Entry Amount");
        document.getElementById(Form_name + "indNetBillPaymentAmt").value = 0.00;
        document.getElementById(Form_name + "indNetBillPaymentAmt").focus();
        return false;
    }

    if (rows < 10)
        Form_name_Footer = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + "0" + rows + "$"
    else
        Form_name_Footer = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + rows + "$"
    
    var Grid = document.getElementById("ctl00_MyCPH1_GV_THC_BAL_PAYMENT");
    var rows = grid.rows.length;
    Grid_Id = "GV_THC_BAL_PAYMENT"
    TOTal_CHG_AMT = 0
    for (var b = 2; b <= rows - 1; b++) {
        if (b < 10) {
            GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl0" + b + "_";
            GV_FRM_NM_Footer = "ctl00_MyCPH1_" + Grid_Id + "_ctl0" + rows + "_";
        }
        else {
            GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl" + b + "_";
            GV_FRM_NM_Footer = "ctl00_MyCPH1_" + Grid_Id + "_ctl" + rows + "_";
        }
        GV_FRM_NM_Footer = Form_name_Footer
        //alert(GV_FRM_NM_Footer);
        if (document.getElementById(GV_FRM_NM + "SCHG" + COl_Cnt)) {
            TOTal_CHG_AMT = rounditn(parseFloat(TOTal_CHG_AMT) + parseFloat(document.getElementById(GV_FRM_NM + "SCHG" + COl_Cnt).value), 2)
        }
        //alert(TOTal_CHG_AMT)
        if (document.getElementById(GV_FRM_NM_Footer + "Total_SCHG" + COl_Cnt)) {
            document.getElementById(GV_FRM_NM_Footer + "Total_SCHG" + COl_Cnt).value = rounditn(TOTal_CHG_AMT, 2)
        }
        Total_BalanceAMT = rounditn(parseFloat(Total_BalanceAMT) + parseFloat(document.getElementById(GV_FRM_NM + "indNetPaymentAmt").value), 2)
        //Total_PaymentAMT = parseFloat(Total_PaymentAMT) + parseFloat(document.getElementById(GV_FRM_NM + "indNetBillPaymentAmt").value)
        Total_PaymentAMT = rounditn(parseFloat(Total_PaymentAMT) + parseFloat(document.getElementById(GV_FRM_NM + "indNetBillPaymentAmt").value), 0);    
    }
    document.getElementById(Form_name_Footer + "Total_BalanceAMT").value = rounditn(Total_BalanceAMT, 2)
    document.getElementById(Form_name_Footer + "Total_BillPayment").value = rounditn(Total_PaymentAMT, 0);
    
    if (Contract_Type == "KM_BASED") {
        Total_BalanceAMT = parseFloat(Total_BalanceAMT) + parseFloat(document.getElementById(FRM_NM + "Txt_ContractAmt").value)
    }

    document.getElementById(FRM_NM + "Txt_PaymentAmt").value = rounditn(Total_PaymentAMT, 2);
    document.getElementById(FRM_NM + "Hnd_PaymentAmt").value = rounditn(Total_PaymentAMT, 2);

    document.getElementById(FRM_NM + "Txt_PendingAmt").value = rounditn(Total_BalanceAMT - Total_PaymentAMT, 2);
    document.getElementById(Form_name1 + "Total_BillPayment").value = rounditn(Total_PaymentAMT, 2);
    document.getElementById(FRM_NM + "txtAmtAppl").value = rounditn(Total_BalanceAMT, 2)
    document.getElementById(FRM_NM + "txtAmtApplL").value = rounditn(Total_BalanceAMT, 2)

    Stax_Tds_Calc()
}
	function Stax_Tds_Calc()
	{   
	    var TaxAmount=0
	    if(document.getElementById(FRM_NM+"Svctax_yn").checked)
	    {
	       AmtAply=document.getElementById(FRM_NM+"txtAmtAppl").value 
	       document.getElementById(FRM_NM+"txtServiceTax").value=rounditn((parseFloat(AmtAply)*10)/100,2)
	       document.getElementById(FRM_NM+"txtEduCess").value=rounditn((parseFloat(document.getElementById(FRM_NM+"txtServiceTax").value)*2)/100,2)
	       document.getElementById(FRM_NM+"txtHEduCess").value=rounditn((parseFloat(document.getElementById(FRM_NM+"txtServiceTax").value)*1)/100,2)
	       
	       var AmtAply_Tds=document.getElementById(FRM_NM+"txtAmtAppl").value
	       TaxAmount = parseFloat(TaxAmount)+ parseFloat(document.getElementById(FRM_NM+"txtServiceTax").value) 
	       TaxAmount = parseFloat(TaxAmount)+  parseFloat(document.getElementById(FRM_NM+"txtEduCess").value) 
	       TaxAmount = parseFloat(TaxAmount)+ parseFloat(document.getElementById(FRM_NM+"txtHEduCess").value)
	       
	       document.getElementById(FRM_NM+"txtAmtApplL").value=rounditn(parseFloat(TaxAmount)+parseFloat(AmtAply_Tds),2)
	    }
	    else
	    {
	       document.getElementById(FRM_NM+"txtServiceTax").value="0.00"
	       document.getElementById(FRM_NM+"txtEduCess").value="0.00"
	       document.getElementById(FRM_NM+"txtHEduCess").value="0.00"
	       document.getElementById(FRM_NM+"txtAmtApplL").value=document.getElementById(FRM_NM+"txtAmtAppl").value
	    }
	    
	    document.getElementById(FRM_NM+"txtTDSRate").value=rounditn(document.getElementById(FRM_NM+"txtTDSRate").value,3)	    
	    if(document.getElementById(FRM_NM+"TDS_yn").checked)
	    {
	       AmtAply=document.getElementById(FRM_NM+"txtAmtApplL").value
	       document.getElementById(FRM_NM+"txtTDSAmt").value=rounditn((parseFloat(AmtAply)*parseFloat(document.getElementById(FRM_NM+"txtTDSRate").value))/100,2)
	       TaxAmount = parseFloat(TaxAmount)- parseFloat(document.getElementById(FRM_NM+"txtTDSAmt").value)
	    }
	    else
	    {
	       document.getElementById(FRM_NM+"txtTDSAmt").value="0.00"
	    }
	    
	    Total_BalanceAMT=parseFloat(document.getElementById(FRM_NM+"txtAmtAppl").value)+parseFloat(TaxAmount)	   
       
        if(document.getElementById(FRM_NM+"RD_Process_Bill").checked)
        {
            document.getElementById(FRM_NM + "Txt_billamt").value = rounditn(Total_BalanceAMT, 2)
            document.getElementById(FRM_NM + "Txt_PendingAmt").value = rounditn(Total_BalanceAMT, 2)
        }

        else if (document.getElementById(FRM_NM + "RD_Process_Payment").checked) 
        {
            //var Total_PaymentAmt = document.getElementById(FRM_NM + "Txt_PaymentAmt").value;
            var Total_PaymentAmt = document.getElementById(FRM_NM + "Hnd_PaymentAmt").value;

            if (parseFloat(Total_PaymentAmt) < parseFloat(Total_BalanceAMT)) 
            {
                document.getElementById(FRM_NM + "Txt_PendingAmt").value = rounditn(Total_BalanceAMT - Total_PaymentAMT, 2);
                document.getElementById(FRM_NM + "Txt_billamt").value = rounditn(Total_BalanceAMT, 2);

                document.getElementById(User_CTR_Frm_Name + "txtNetPay").value = rounditn(Total_PaymentAmt, 2);
                document.getElementById(User_CTR_Frm_Name + "txtAmtApplA").value = rounditn(Total_PaymentAmt, 2);
            }
            else 
            {
                Total_PaymentAmt = Total_BalanceAMT
                document.getElementById(FRM_NM + "Txt_PendingAmt").value = rounditn(Total_BalanceAMT - Total_PaymentAmt, 2);
                document.getElementById(FRM_NM + "Txt_billamt").value = rounditn(Total_BalanceAMT, 2);
                document.getElementById(FRM_NM + "Txt_PaymentAmt").value = rounditn(Total_BalanceAMT, 2);

                document.getElementById(User_CTR_Frm_Name + "txtNetPay").value = rounditn(Total_PaymentAmt, 2);
                document.getElementById(User_CTR_Frm_Name + "txtAmtApplA").value = rounditn(Total_PaymentAmt, 2);
            }
            if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value == "Cash")
            {
                document.getElementById(User_CTR_Frm_Name + "txtCashAmt").value = rounditn(Total_PaymentAmt, 2);
            }
            if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value == "Bank")
            {
                document.getElementById(User_CTR_Frm_Name + "txtChqAmt").value = rounditn(Total_PaymentAmt, 2);
            }
            if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value == "Both" )
            {
                document.getElementById(User_CTR_Frm_Name+"txtCashAmt").value = "0.00";
                document.getElementById(User_CTR_Frm_Name+"txtChqAmt").value = "0.00";
            }   
        }
	}
	function Total_calC_THC_BalPayment_Onload()
	{ 
 		        var grid=document.getElementById("ctl00_MyCPH1_GV_THC_BAL_PAYMENT");
                var rows=grid.rows.length;

                Total_AdvAMT = 0;
                Total_ContractAmt = 0;
                Total_OthAmt = 0;
                Total_BalanceAMT = 0;
                IND_BalanceAMT = 0;
                Ind_TOT_oth = 0;
                Total_BalAMT = 0;
                Total_PaymentAMT = 0;
                for (var i=2; i <= rows-1; i++)
                {
                            if(i < 10)
                                Form_name = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + "0" + i + "$"
                            else
                                Form_name = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + i + "$"
                           Total_AdvAMT=parseFloat(Total_AdvAMT)+parseFloat(document.getElementById(Form_name+"indadvamt").value)
                           Total_ContractAmt=parseFloat(Total_ContractAmt)+parseFloat(document.getElementById(Form_name+"indpcamt").value)
                           Total_OthAmt=parseFloat(Total_OthAmt)+parseFloat(document.getElementById(Form_name+"indothamt").value)
                           
                           document.getElementById(Form_name+"indnetpay").value=rounditn(parseFloat(document.getElementById(Form_name+"indpcamt").value)-parseFloat(document.getElementById(Form_name+"indadvamt").value)+parseFloat(document.getElementById(Form_name+"indothamt").value),2)
                           Total_BalAMT=parseFloat(Total_BalAMT)+parseFloat(document.getElementById(Form_name+"indnetpay").value)

                           document.getElementById(Form_name + "indNetPaymentAmt").value = rounditn(document.getElementById(Form_name + "indnetpay").value, 2);
                           if (document.getElementById(FRM_NM + "RD_Process_Payment").checked) {
                               document.getElementById(Form_name + "indNetBillPaymentAmt").value = rounditn(document.getElementById(Form_name + "indnetpay").value, 2);
                           }
                           Total_BalanceAMT = parseFloat(Total_BalanceAMT) + parseFloat(document.getElementById(Form_name + "indNetPaymentAmt").value);
                           Total_PaymentAMT = parseFloat(Total_PaymentAMT) + parseFloat(document.getElementById(Form_name + "indNetBillPaymentAmt").value);

                }
                if(i < 10)
                    Form_name1 = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + "0" + i + "$"
                else
                    Form_name1 = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + i + "$"
                document.getElementById(Form_name1 + "TotalNetamt").value = rounditn(Total_AdvAMT, 2);
                document.getElementById(Form_name1 + "Total_PCAMT").value = rounditn(Total_ContractAmt, 2);
                document.getElementById(Form_name1 + "Total_OTHAMT").value = rounditn(Total_OthAmt, 2);
                document.getElementById(Form_name1 + "Total_Balamt").value = rounditn(Total_BalAMT, 2);
                document.getElementById(Form_name1 + "Total_BalanceAMT").value = rounditn(Total_BalanceAMT, 2);
                document.getElementById(Form_name1 + "Total_BillPayment").value = rounditn(Total_PaymentAMT, 2);
                document.getElementById(FRM_NM + "Hnd_PaymentAmt").value = rounditn(Total_PaymentAMT, 2);
                document.getElementById(FRM_NM + "Txt_PaymentAmt").value = rounditn(Total_PaymentAMT, 2);
                document.getElementById(FRM_NM + "Txt_PendingAmt").value = rounditn(Total_BalanceAMT - Total_PaymentAMT, 2);
                document.getElementById(FRM_NM + "txtAmtAppl").value = rounditn(Total_BalanceAMT, 2);
                document.getElementById(FRM_NM + "txtAmtApplL").value = rounditn(Total_BalanceAMT, 2);
                
                Stax_Tds_Calc()
        
 
	}
	function Total_calC_THC_BalPayment_KMBASED_Onload()
	{ 
 		        var grid=document.getElementById("ctl00_MyCPH1_GV_THC_BAL_PAYMENT");
                var rows=grid.rows.length;  
         
	            Total_AdvAMT=0
	            Total_KM=0
	            Total_OthAmt=0
	            Total_BalanceAMT=0
                IND_BalanceAMT=0
                Ind_TOT_oth=0
	            Total_BalAMT=0
                for (var i=2; i <= rows-1; i++)
                {
                      // alert("hi..")
                            if(i < 10)
                                Form_name = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + "0" + i + "$"
                            else
                                Form_name = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + i + "$"
                           Total_AdvAMT=parseFloat(Total_AdvAMT)+parseFloat(document.getElementById(Form_name+"indadvamt").value)
                           Total_KM=parseFloat(Total_KM)+parseFloat(document.getElementById(Form_name+"Txt_TotalKM").value)
                           Total_OthAmt=parseFloat(Total_OthAmt)+parseFloat(document.getElementById(Form_name+"indothamt").value)
                           document.getElementById(Form_name+"indnetpay").value=rounditn(-parseFloat(document.getElementById(Form_name+"indadvamt").value)+parseFloat(document.getElementById(Form_name+"indothamt").value),2)
                           if(parseFloat(document.getElementById(Form_name+"indnetpay").value)<0)
                           {
                            document.getElementById(Form_name+"indnetpay").value="0.00"
                           }
                           Total_BalAMT=parseFloat(Total_BalAMT)+parseFloat(document.getElementById(Form_name+"indnetpay").value)
                           document.getElementById(Form_name+"indNetPaymentAmt").value=rounditn(document.getElementById(Form_name+"indnetpay").value,2)
                           Total_BalanceAMT=parseFloat(Total_BalanceAMT)+parseFloat(document.getElementById(Form_name+"indNetPaymentAmt").value)
                }
                if(i < 10)
                    Form_name1 = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + "0" + i + "$"
                else
                    Form_name1 = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + i + "$"
                document.getElementById(Form_name1+"TotalNetamt").value=rounditn(Total_AdvAMT,2)
                document.getElementById(Form_name1+"Txt_TotalTravelKM").value=rounditn(Total_KM,0)
                document.getElementById(Form_name1+"Total_OTHAMT").value=rounditn(Total_OthAmt,2)
                document.getElementById(Form_name1+"Total_Balamt").value=rounditn(Total_BalAMT,2)
                
                document.getElementById(Form_name1+"Total_BalanceAMT").value=rounditn(Total_BalanceAMT,2)
                Total_BalanceAMT=parseFloat(Total_BalanceAMT)+parseFloat(document.getElementById(FRM_NM+"Txt_ContractAmt").value)
                document.getElementById(FRM_NM+"txtAmtAppl").value=rounditn(Total_BalanceAMT,2)
                document.getElementById(FRM_NM+"txtAmtApplL").value=rounditn(Total_BalanceAMT,2)
                
               // document.getElementById(FRM_NM+"Txt_ContractAmt").value=rounditn(Total_BalanceAMT,2)
                
                Stax_Tds_Calc()
	}

	function THC_BalPayment_OnSubmit(GRID_ID, ContractType) 
	{	    
	    var GridBalPayment = document.getElementById("ctl00_MyCPH1_GV_THC_BAL_PAYMENT");
	    var rowscnt = GridBalPayment.rows.length;
	    Grid_Id_BalPayment = "GV_THC_BAL_PAYMENT"

	    for (var b = 2; b <= rowscnt - 1; b++) {
	        if (b < 10) {
	            GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id_BalPayment + "_ctl0" + b + "_";
	            GV_FRM_NM_Footer = "ctl00_MyCPH1_" + Grid_Id_BalPayment + "_ctl0" + rows + "_";
	        }
	        else {
	            GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id_BalPayment + "_ctl" + b + "_";
	            GV_FRM_NM_Footer = "ctl00_MyCPH1_" + Grid_Id_BalPayment + "_ctl" + rows + "_";
	        }

	        Total_BalanceAMT = rounditn(parseFloat(document.getElementById(GV_FRM_NM + "indNetPaymentAmt").value), 0);

	        if (parseFloat(Total_BalanceAMT) < 0) {
	            alert("Net Payable Amount Should Be Greater Than Zero(0)")
	            return false;
	        }
	    }
	
	
	
	        //alert(GRID_ID)
	            var server_dt=document.getElementById(FRM_NM+"Hnd_ServerDt").value
                var dt =document.getElementById(FRM_NM+"TxtVoucherDT").value
				var hdndockdt;
			    var Maxdt="01/01/2007";
                 var grid=document.getElementById("ctl00_MyCPH1_"+GRID_ID);
                 var rows=grid.rows.length;  
                 var Check_One="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                  var i=0    
                  for(var b=2;b<=rows-1;b++)
                  {
                            //alert(b)
                            if(b<10)
                            {
                                GV_FRM_NM="ctl00_MyCPH1_"+GRID_ID+"_ctl0" + b + "_";
                                hdndockdt="ctl00_MyCPH1_"+GRID_ID+"_ctl0" + b + "_Hnd_Docdt" 
                            }
                            else
                            {
                                 GV_FRM_NM="ctl00_MyCPH1_"+GRID_ID+"_ctl" + b + "_";
                                 hdndockdt="ctl00_MyCPH1_"+GRID_ID+"_ctl" + b + "_Hnd_Docdt";
                            }
                            hdndockdt = document.getElementById(hdndockdt).value;     
                                 Check_One="Y"
                                 i=i+1 
                                 var Maxdt1 =Maxdt
                				
				                 var Maxdt_dd=Maxdt1.substring(0,2)
				                 var Maxdt_mm=Maxdt1.substring(3,5)
				                 var Maxdt_yy=Maxdt1.substring(6,10)
                                    
		                         var hdndockdt1 =hdndockdt
				                 var hdndockdt_dd=hdndockdt1.substring(0,2)
				                 var hdndockdt_mm=hdndockdt1.substring(3,5)
				                 var hdndockdt_yy=hdndockdt1.substring(6,10)
				                 Maxdt1=new Date(months[parseFloat(Maxdt_mm)] + " " + parseFloat(Maxdt_dd) + ", " + parseFloat(Maxdt_yy))
		                         hdndockdt1=new Date(months[parseFloat(hdndockdt_mm)] + " " + parseFloat(hdndockdt_dd) + ", " + parseFloat(hdndockdt_yy))
                                if (hdndockdt1>Maxdt1)
                                {
                                Maxdt1=hdndockdt1
                                Maxdt=hdndockdt
                                }
                     }
                                if (dt=="")
				                {
						                alert( "Payment Date Should Not Be Blank !!!")
						                document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						                return false;
				                }
				            var dt_dd=dt.substring(0,2)
				            var dt_mm=dt.substring(3,5)
				            var dt_yy=dt.substring(6,10)

		                    var sdt =server_dt
				            var sdt_dd=sdt.substring(0,2)
				            var sdt_mm=sdt.substring(3,5)
				            var sdt_yy=sdt.substring(6,10)
            				
				
				            dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		                    server_dt=new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))
                
                var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2)
				var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5)
				var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10)
				FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))
				
				var FinYear_todate_dd=FinYear_todate.substring(0,2)
				var FinYear_todate_mm=FinYear_todate.substring(3,5)
				var FinYear_todate_yy=FinYear_todate.substring(6,10)
				FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))
			
				if (dt>FinYear_todate1 || dt<FinYear_fromdate1)
				{
						alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Payment Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						return false;
				}
				
                 Fromdate1=Maxdt1
			     Fromdate=Maxdt
                              if (dt<Fromdate1)
				                {
						                alert( "Payment Date Should Be Greater than  "+ Fromdate +"  !!!")
						                document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						                return false;
				                }
				                if (dt>server_dt)
				                {
						                alert( "Payment Date should not be greater than today's date !!!")
						                document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						                return false;
				                }
		    if(document.getElementById(FRM_NM+"RD_Process_Bill").checked)
			{
			    if(document.getElementById(FRM_NM+"Txt_Manual_Voucherno").value=="")
			    {
			        alert("Plz Enter Vendor Billno.")
			        document.getElementById(FRM_NM+"Txt_Manual_Voucherno").focus();
			        return false;
			    }
			    if(document.getElementById(FRM_NM+"Txt_VDate").value=="")
			    {
			        alert("Plz Enter Vendor Bill Date")
			        document.getElementById(FRM_NM+"Txt_VDate").focus();
			        return false;
			    }
			    if(document.getElementById(FRM_NM+"Txt_DueDays").value=="")
			    {
			        alert("Plz Enter Vendor Bill Due Days")
			        document.getElementById(FRM_NM+"Txt_DueDays").focus();
			        return false;
			    }

			}

			var Txt_PaymentAmt = document.getElementById(FRM_NM + "Txt_PaymentAmt");
			var Txt_PendingAmt = document.getElementById(FRM_NM + "Txt_PendingAmt");
			var Txt_billamt = document.getElementById(FRM_NM + "Txt_billamt");

			if (parseFloat(Txt_billamt.value) < 0) {
			    alert("Bill Amount Should Be Greater Than Zero(0)");
			    return false;
			}
			if (parseFloat(Txt_PaymentAmt.value) > parseFloat(Txt_billamt.value)) {
			    alert("Bill Payment Amount Should Be Less Than Bill Amount");
			    return false;
			}
			if (parseFloat(Txt_PendingAmt.value) < 0) {
			    alert("Bill Pending Amount Should Not Be Lesss Than Zero(0)");
			    return false;
			}
			
			
			if(document.getElementById(FRM_NM+"Svctax_yn").checked)	
			{
			     
			    if(document.getElementById(FRM_NM+"txtSrvTaxNo").value=="")
			    {
			        alert("Plz Enter Service Tax Reg No.")
			        document.getElementById(FRM_NM+"txtSrvTaxNo").focus();
			        return false;
			    }
			}     	                
			if(document.getElementById(FRM_NM+"TDS_yn").checked)	
			{
			    
			    if(document.getElementById(FRM_NM+"Tdssection").value=="")
			    {
			        alert("Plz Select TDS Ledger")
			        document.getElementById(FRM_NM+"Tdssection").focus();
			        return false;
			    }
			    if(parseFloat(document.getElementById(FRM_NM+"txtTDSRate").value)<=0)
			    {
			        alert("Plz Enter TDS Rate")
			        document.getElementById(FRM_NM+"txtTDSRate").focus();
			        return false;
			    }
			    if(document.getElementById(FRM_NM+"txtPanNo").value=="")
			    {
			        alert("Plz Enter PANNO.")
			        document.getElementById(FRM_NM+"txtPanNo").focus();
			        return false;
			    }
			}                
			if(document.getElementById(FRM_NM+"RD_Process_Payment").checked)
			{
			            if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="-1")
                        {
                                                   alert( "Plz Select Mode of Transacction !!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddlPayMode").focus();
						                          return false;
                        }	
                        if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="Both" && i>1)
                        {
                                                  alert( "You have Selected Multiple Records For Both Payment,You have to select Single Records For Both Paymtn!!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddlPayMode").focus();
						                          return false;
                        }	                		                
		             if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="Cash")
                     {
                        if(parseFloat(document.getElementById(User_CTR_Frm_Name+"txtCashAmt").value)<0)
                         {                         
                                                // alert( "Cash Amount Must Be Greater Than Zero !!!")
                             alert("Cash Amount Must Be Positive !!!")
						                          return false;
                         }
                         if(document.getElementById(User_CTR_Frm_Name+"ddrCashcode").value=="")
                         {                         
                                                  alert( "PLz Select Cash Account !!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddrCashcode").focus();
						                          return false;
                         }
                         
                    }
                    else if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="Bank")
                    {
                        if(parseFloat(document.getElementById(User_CTR_Frm_Name+"txtChqAmt").value)<=0)
                         {  
                                     alert( "Cheque Amount Must Be Greater Than Zero !!!")
						            // document.getElementById(FRM_Name+"txtreqdt").focus();
						             return false;
			            }
			            if(document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").value=="")
                         {                         
                                                  alert( "PLz Select BANK Account !!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").focus();
						                          return false;
                         }
                         if(document.getElementById(User_CTR_Frm_Name+"txtChqNo").value=="")
                         {                         
                                                  alert( "PLz Enter Cheque No!!!")
						                          document.getElementById(User_CTR_Frm_Name+"txtChqNo").focus();
						                          return false;
                         }
                         if(document.getElementById(User_CTR_Frm_Name+"txtChqDate").value=="")
                         {                         
                                                  alert( "PLz Enter Cheque Date !!!")
						                          document.getElementById(User_CTR_Frm_Name+"txtChqDate").focus();
						                          return false;
                         }
                         
                    }
                     else if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="Both")
                     {
                        if(parseFloat(document.getElementById(User_CTR_Frm_Name+"txtCashAmt").value)<=0)
                         {                         
                                                  alert( "Cash Amount Must Be Greater Than Zero !!!")
						                         document.getElementById(User_CTR_Frm_Name+"txtCashAmt").focus();
						                          return false;
                         }
                          if(document.getElementById(User_CTR_Frm_Name+"ddrCashcode").value=="")
                         {                         
                                                  alert( "PLz Select Cash Account !!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddrCashcode").focus();
						                          return false;
                         }
                         if(parseFloat(document.getElementById(User_CTR_Frm_Name+"txtChqAmt").value)<=0)
                         {  
                                     alert( "Cheque Amount Must Be Greater Than Zero !!!")
						             document.getElementById(User_CTR_Frm_Name+"txtChqAmt").focus();
						             return false;
			            }
			            if(document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").value=="")
                         {                         
                                                  alert( "PLz Select BANK Account !!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").focus();
						                          return false;
                         }
                         if(document.getElementById(User_CTR_Frm_Name+"txtChqNo").value=="")
                         {                         
                                                  alert( "PLz Enter Cheque No!!!")
						                          document.getElementById(User_CTR_Frm_Name+"txtChqNo").focus();
						                          return false;
                         }
                         if(document.getElementById(User_CTR_Frm_Name+"txtChqDate").value=="")
                         {                         
                                                  alert( "PLz Enter Cheque Date !!!")
						                          document.getElementById(User_CTR_Frm_Name+"txtChqDate").focus();
						                          return false;
                         }
                          
                    }	 
        
        }
        if(document.getElementById(FRM_NM+"RD_Process_Bill").checked)
	    {
            if(!confirm("Are You Sure That All Bill Entry  Details Are Correct Or Not"))
            return false; 
        }
        else if(document.getElementById(FRM_NM+"RD_Process_Payment").checked)
	    {
            if(!confirm("Are You Sure That All Payment Details Are Correct Or Not"))
            return false; 
        }
        
        for(var b=2;b<=rows-1;b++)
        {
                            if(b<10)
                            {
                                GV_FRM_NM="ctl00_MyCPH1_"+GRID_ID+"_ctl0" + b + "_";
                            }
                            else
                            {
                                 GV_FRM_NM="ctl00_MyCPH1_"+GRID_ID+"_ctl" + b + "_";
                            }
                            //TOTALKM
                            if(ContractType!="KM_Based")
                                    document.getElementById(GV_FRM_NM+"indpcamt").disabled=false	
                            else if(ContractType=="KM_Based")
                            {
                                    document.getElementById(GV_FRM_NM+"Txt_TotalKM").disabled=false	
                                    document.getElementById(FRM_NM+"Txt_billamt").disabled=false	
                                    document.getElementById(FRM_NM+"Txt_billamt").disabled=false
                                    document.getElementById(FRM_NM+"Txt_ContractAmt").disabled=false	
                             }       
                            document.getElementById(GV_FRM_NM+"indothamt").disabled=false	
                            document.getElementById(GV_FRM_NM+"indadvamt").disabled=false	
                            document.getElementById(GV_FRM_NM+"indnetpay").disabled=false	
                            document.getElementById(GV_FRM_NM+"indNetPaymentAmt").disabled=false	
        }
        
        
        	
       	document.getElementById(User_CTR_Frm_Name+"txtChqDate").disabled=false	
		document.getElementById(User_CTR_Frm_Name+"txtChqNo").disabled=false	
		document.getElementById(User_CTR_Frm_Name+"txtChqAmt").disabled=false	
		document.getElementById(User_CTR_Frm_Name+"txtNetPay").disabled=false
		document.getElementById(User_CTR_Frm_Name+"txtCashAmt").disabled=false	
		document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").disabled=false	
}   


/*********************************************Bill Entry Payment *********************************************/
/*********************************************************************************************************************/
	function Total_calC_THC_BalPayment_KMBASED_Onload()
	{ 
 		        var grid=document.getElementById("ctl00_MyCPH1_GV_THC_BAL_PAYMENT");
                var rows=grid.rows.length;  
         
	            Total_AdvAMT=0
	            Total_KM=0
	            Total_OthAmt=0
	            Total_BalanceAMT=0
                IND_BalanceAMT=0
                Ind_TOT_oth=0
	            Total_BalAMT=0
                for (var i=2; i <= rows-1; i++)
                {
                      // alert("hi..")
                            if(i < 10)
                                Form_name = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + "0" + i + "$"
                            else
                                Form_name = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + i + "$"
                           Total_AdvAMT=parseFloat(Total_AdvAMT)+parseFloat(document.getElementById(Form_name+"indadvamt").value)
                           Total_KM=parseFloat(Total_KM)+parseFloat(document.getElementById(Form_name+"Txt_TotalKM").value)
                           Total_OthAmt=parseFloat(Total_OthAmt)+parseFloat(document.getElementById(Form_name+"indothamt").value)
                           document.getElementById(Form_name+"indnetpay").value=rounditn(-parseFloat(document.getElementById(Form_name+"indadvamt").value)+parseFloat(document.getElementById(Form_name+"indothamt").value),2)
                           if(parseFloat(document.getElementById(Form_name+"indnetpay").value)<0)
                           {
                            document.getElementById(Form_name+"indnetpay").value="0.00"
                           }
                           Total_BalAMT=parseFloat(Total_BalAMT)+parseFloat(document.getElementById(Form_name+"indnetpay").value)
                           document.getElementById(Form_name+"indNetPaymentAmt").value=rounditn(document.getElementById(Form_name+"indnetpay").value,2)
                           Total_BalanceAMT=parseFloat(Total_BalanceAMT)+parseFloat(document.getElementById(Form_name+"indNetPaymentAmt").value)
                }
                if(i < 10)
                    Form_name1 = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + "0" + i + "$"
                else
                    Form_name1 = "ctl00$MyCPH1$GV_THC_BAL_PAYMENT$ctl" + i + "$"
                document.getElementById(Form_name1+"TotalNetamt").value=rounditn(Total_AdvAMT,2)
                document.getElementById(Form_name1+"Txt_TotalTravelKM").value=rounditn(Total_KM,0)
                document.getElementById(Form_name1+"Total_OTHAMT").value=rounditn(Total_OthAmt,2)
                document.getElementById(Form_name1+"Total_Balamt").value=rounditn(Total_BalAMT,2)
                
                document.getElementById(Form_name1+"Total_BalanceAMT").value=rounditn(Total_BalanceAMT,2)
                Total_BalanceAMT=parseFloat(Total_BalanceAMT)+parseFloat(document.getElementById(FRM_NM+"Txt_ContractAmt").value)
                document.getElementById(FRM_NM+"txtAmtAppl").value=rounditn(Total_BalanceAMT,2)
                document.getElementById(FRM_NM+"txtAmtApplL").value=rounditn(Total_BalanceAMT,2)
                
               // document.getElementById(FRM_NM+"Txt_ContractAmt").value=rounditn(Total_BalanceAMT,2)
                
                Stax_Tds_Calc()
	}
		 
	function OnSubmit_BillEntryPayment()
	{
	        //alert(GRID_ID)
	        //alert("hi;;")
	            var server_dt=document.getElementById(FRM_NM+"Hnd_Server_dt").value
                var dt =document.getElementById(FRM_NM+"TxtVoucherDT").value
				var hdndockdt;
			    var Maxdt="01/01/2007";
			    GRID_ID="GV_BillList"
                 var grid=document.getElementById("ctl00_MyCPH1_"+GRID_ID);
                 var rows=grid.rows.length;  
                 var Check_One="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                  var i=0    
                //  alert(rows)
                  for(var b=2;b<=rows-1;b++)
                  {
                            //alert(b)
                            if(b<10)
                            {
                                GV_FRM_NM="ctl00_MyCPH1_"+GRID_ID+"_ctl0" + b + "_";
                                hdndockdt="ctl00_MyCPH1_"+GRID_ID+"_ctl0" + b + "_hnd_Billdate" 
                            }
                            else
                            {
                                 GV_FRM_NM="ctl00_MyCPH1_"+GRID_ID+"_ctl" + b + "_";
                                 hdndockdt="ctl00_MyCPH1_"+GRID_ID+"_ctl" + b + "_hnd_Billdate";
                            }
                          //  alert("he...1")
                            hdndockdt = document.getElementById(hdndockdt).value;     
                                 Check_One="Y"
                                 i=i+1 
                                 var Maxdt1 =Maxdt
                				
				                 var Maxdt_dd=Maxdt1.substring(0,2)
				                 var Maxdt_mm=Maxdt1.substring(3,5)
				                 var Maxdt_yy=Maxdt1.substring(6,10)
                                    
		                         var hdndockdt1 =hdndockdt
				                 var hdndockdt_dd=hdndockdt1.substring(0,2)
				                 var hdndockdt_mm=hdndockdt1.substring(3,5)
				                 var hdndockdt_yy=hdndockdt1.substring(6,10)
				                 Maxdt1=new Date(months[parseFloat(Maxdt_mm)] + " " + parseFloat(Maxdt_dd) + ", " + parseFloat(Maxdt_yy))
		                         hdndockdt1=new Date(months[parseFloat(hdndockdt_mm)] + " " + parseFloat(hdndockdt_dd) + ", " + parseFloat(hdndockdt_yy))
                                if (hdndockdt1>Maxdt1)
                                {
                                Maxdt1=hdndockdt1
                                Maxdt=hdndockdt
                                }
                     }
                                if (dt=="")
				                {
						                alert( "Payment Date Should Not Be Blank !!!")
						                document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						                return false;
				                }
				            var dt_dd=dt.substring(0,2)
				            var dt_mm=dt.substring(3,5)
				            var dt_yy=dt.substring(6,10)

		                    var sdt =server_dt
				            var sdt_dd=sdt.substring(0,2)
				            var sdt_mm=sdt.substring(3,5)
				            var sdt_yy=sdt.substring(6,10)
            				
				
				            dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		                    server_dt=new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))
                
                var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2)
				var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5)
				var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10)
				FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))
				
				var FinYear_todate_dd=FinYear_todate.substring(0,2)
				var FinYear_todate_mm=FinYear_todate.substring(3,5)
				var FinYear_todate_yy=FinYear_todate.substring(6,10)
				FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))
			
				if (dt>FinYear_todate1 || dt<FinYear_fromdate1)
				{
						alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Payment Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						return false;
				}
				
                 Fromdate1=Maxdt1
			     Fromdate=Maxdt
                              if (dt<Fromdate1)
				                {
						                alert( "Payment Date Should Be Greater than  "+ Fromdate +"  !!!")
						                document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						                return false;
				                }
				                if (dt>server_dt)
				                {
						                alert( "Payment Date should not be greater than today's date !!!")
						                document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						                return false;
				                }
				              //  alert("hi...2")
			            if(document.getElementById(FRM_NM+"Txt_Manual_Voucherno").value=="")
			            {
			                alert("Plz Enter Manual Voucherno")
			                document.getElementById(FRM_NM+"Txt_Manual_Voucherno").focus();
			                return false;
			            }
			            
			            if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="-1")
                        {
                                                   alert( "Plz Select Mode of Transacction !!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddlPayMode").focus();
						                          return false;
                        }	
                        if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="Both" && i>1)
                        {
                                                  alert( "You have Selected Multiple Records For Both Payment,You have to select Single Records For Both Paymtn!!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddlPayMode").focus();
						                          return false;
                        }	                		                
		             if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="Cash")
                     {
                        if(parseFloat(document.getElementById(User_CTR_Frm_Name+"txtCashAmt").value)<=0)
                         {                         
                                                  alert( "Cash Amount Must Be Greater Than Zero !!!")
						                         // document.getElementById(FRM_Name+"txtreqdt").focus();
						                          return false;
                         }
                         if(document.getElementById(User_CTR_Frm_Name+"ddrCashcode").value=="")
                         {                         
                                                  alert( "PLz Select Cash Account !!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddrCashcode").focus();
						                          return false;
                         }
                         
                    }
                    else if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="Bank")
                    {
                        if(parseFloat(document.getElementById(User_CTR_Frm_Name+"txtChqAmt").value)<=0)
                         {  
                                     alert( "Cheque Amount Must Be Greater Than Zero !!!")
						            // document.getElementById(FRM_Name+"txtreqdt").focus();
						             return false;
			            }
			            if(document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").value=="")
                         {                         
                                                  alert( "PLz Select BANK Account !!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").focus();
						                          return false;
                         }
                         if(document.getElementById(User_CTR_Frm_Name+"txtChqNo").value=="")
                         {                         
                                                  alert( "PLz Enter Cheque No!!!")
						                          document.getElementById(User_CTR_Frm_Name+"txtChqNo").focus();
						                          return false;
                         }
                         if(document.getElementById(User_CTR_Frm_Name+"txtChqDate").value=="")
                         {                         
                                                  alert( "PLz Enter Cheque Date !!!")
						                          document.getElementById(User_CTR_Frm_Name+"txtChqDate").focus();
						                          return false;
                         }
                         
                    }
                     else if(document.getElementById(User_CTR_Frm_Name+"ddlPayMode").value=="Both")
                     {
                        if(parseFloat(document.getElementById(User_CTR_Frm_Name+"txtCashAmt").value)<=0)
                         {                         
                                                  alert( "Cash Amount Must Be Greater Than Zero !!!")
						                         document.getElementById(User_CTR_Frm_Name+"txtCashAmt").focus();
						                          return false;
                         }
                          if(document.getElementById(User_CTR_Frm_Name+"ddrCashcode").value=="")
                         {                         
                                                  alert( "PLz Select Cash Account !!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddrCashcode").focus();
						                          return false;
                         }
                         if(parseFloat(document.getElementById(User_CTR_Frm_Name+"txtChqAmt").value)<=0)
                         {  
                                     alert( "Cheque Amount Must Be Greater Than Zero !!!")
						             document.getElementById(User_CTR_Frm_Name+"txtChqAmt").focus();
						             return false;
			            }
			            if(document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").value=="")
                         {                         
                                                  alert( "PLz Select BANK Account !!!")
						                          document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").focus();
						                          return false;
                         }
                         if(document.getElementById(User_CTR_Frm_Name+"txtChqNo").value=="")
                         {                         
                                                  alert( "PLz Enter Cheque No!!!")
						                          document.getElementById(User_CTR_Frm_Name+"txtChqNo").focus();
						                          return false;
                         }
                         if(document.getElementById(User_CTR_Frm_Name+"txtChqDate").value=="")
                         {                         
                                                  alert( "PLz Enter Cheque Date !!!")
						                          document.getElementById(User_CTR_Frm_Name+"txtChqDate").focus();
						                          return false;
                         }
  
        
        }

            if(!confirm("Are You Sure That All Payment Details Are Correct Or Not"))
            return false; 
           
       	document.getElementById(User_CTR_Frm_Name+"txtChqDate").disabled=false	
		document.getElementById(User_CTR_Frm_Name+"txtChqNo").disabled=false	
		document.getElementById(User_CTR_Frm_Name+"txtChqAmt").disabled=false	
		document.getElementById(User_CTR_Frm_Name+"txtNetPay").disabled=false
		document.getElementById(User_CTR_Frm_Name+"txtCashAmt").disabled=false	
		document.getElementById(User_CTR_Frm_Name+"ddrBankaccode").disabled=false	
}   


/*************************************************************************************************************
             FUNCTION FOr Check All---For BA
*************************************************************************************************************/
var  FRM_NM="ctl00_MyCPH1_"
function Check_All_BA(Grd_Name,Obj_chk_All,Obj_Chk_Ind,CalC_YN)
	    {
	             
	             Grid_Id=Grd_Name
	             var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
                 var rows=grid.rows.length;  
                 var Check_One="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                 if(document.getElementById("ctl00$MyCPH1$"+Grid_Id+"$ctl01$"+Obj_chk_All).checked)
                 {
                      for(var b=2;b<=rows;b++)
                      {
                            // alert(b)
                            if(b<10)
                            {
                                GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + b + "_";
                            }
                            else
                            {
                                 GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_";
                            }       
                             
                                        document.getElementById(GV_FRM_NM+Obj_Chk_Ind).checked=true
                           //alert("hi..")
                      }
                  }
                  else
                  {
                             for(var b=2;b<=rows;b++)
                              {
                                    //alert(b)
                                    if(b<10)
                                    {
                                        GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + b + "_";
                                    }
                                    else
                                    {
                                         GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_";
                                    }
                                    
                                    document.getElementById(GV_FRM_NM+Obj_Chk_Ind).checked=false
                             
                              }
                  }
                  if(CalC_YN=="Y")
                  {
                   // alert("hi..1")
                     Check_Calc_BA('GridDocList','ChkAll','Chk_Docno')
                     // alert("hi..2")
                  }
    }
    function Check_Calc_BA(Grd_Name,Obj_chk_All,Obj_Chk_Ind)
	    {        
	            //Txt_Commission
	             Grid_Id=Grd_Name
	             var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
                 var rows=grid.rows.length;  
                  var Check_ALL="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                 var Total_adv_amt="0.00",Total_PendAmt="0.00"
                 var Total_billAmount="0"
                  for(var b=2;b<=rows;b++)
                  {
                  
                                    if(b<10)
                                    {
                                        GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + b + "_";
                                    }
                                    else
                                    {
                                         GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_";
                                    }
                                 //alert("1...."+b)
                                document.getElementById("ctl00$MyCPH1$"+Grid_Id+"$ctl01$"+Obj_chk_All).checked=true
                                if(document.getElementById(GV_FRM_NM+Obj_Chk_Ind).checked==false)
                                {
                                    //alert(document.getElementById(GV_FRM_NM+Obj_Chk_Ind).checked)
                                     Check_ALL="Y"
                                }
                                if(Check_ALL=="Y")
                                {
                                    document.getElementById("ctl00$MyCPH1$"+Grid_Id+"$ctl01$"+Obj_chk_All).checked=false
                                }
                    } 
	    }
	    function Check_Calc_BA_Individual(Obj)
	    {        
	            //Txt_Commission
	           Total_Comission=parseFloat(document.getElementById(FRM_NM+"Txt_Commission").value);  
	           Hnd_Values=Obj.id.replace('Chk_Docno','Hnd_Values')
	           Hnd_Values_Arr=document.getElementById(Hnd_Values).value.split("~");
	           Ind_Commission=Hnd_Values_Arr[1]
	           if(Obj.checked)
	                Total_Comission=parseFloat(Total_Comission)+parseFloat(Hnd_Values_Arr[1])
	           else
	                Total_Comission=parseFloat(Total_Comission)-parseFloat(Hnd_Values_Arr[1])
	           document.getElementById(FRM_NM+"Txt_Commission").value=rounditn(Total_Comission,2)
	           document.getElementById(FRM_NM+"Txt_Commission_1").value=rounditn(Total_Comission,2)
	           document.getElementById(FRM_NM+"txtAmtAppl").value=rounditn(Total_Comission,2)
	           Calc_BA_OtherAmount()
	    }
	    function Calc_BA_OtherAmount()
	    {
	         var TaxAmount=0
	         if(document.getElementById(FRM_NM+"Svctax_yn").checked)
	            {
	               AmtAply=document.getElementById(FRM_NM+"txtAmtAppl").value 
	               document.getElementById(FRM_NM+"txtServiceTax").value=rounditn((parseFloat(AmtAply)*10)/100,2)
	               document.getElementById(FRM_NM+"txtEduCess").value=rounditn((parseFloat(document.getElementById(FRM_NM+"txtServiceTax").value)*2)/100,2)
	               document.getElementById(FRM_NM+"txtHEduCess").value=rounditn((parseFloat(document.getElementById(FRM_NM+"txtServiceTax").value)*1)/100,2)
	               var AmtAply_Tds=document.getElementById(FRM_NM+"txtAmtAppl").value
	               TaxAmount = parseFloat(TaxAmount)+ parseFloat(document.getElementById(FRM_NM+"txtServiceTax").value) 
	               TaxAmount = parseFloat(TaxAmount)+  parseFloat(document.getElementById(FRM_NM+"txtEduCess").value) 
	               TaxAmount = parseFloat(TaxAmount)+ parseFloat(document.getElementById(FRM_NM+"txtHEduCess").value)
	               document.getElementById(FRM_NM+"txtAmtApplL").value=rounditn(parseFloat(TaxAmount)+parseFloat(AmtAply_Tds),2)
	            }
	            else
	            {
	               document.getElementById(FRM_NM+"txtServiceTax").value="0.00"
	               document.getElementById(FRM_NM+"txtEduCess").value="0.00"
	               document.getElementById(FRM_NM+"txtHEduCess").value="0.00"
	               document.getElementById(FRM_NM+"txtAmtApplL").value=document.getElementById(FRM_NM+"txtAmtAppl").value
	            }
	            document.getElementById(FRM_NM+"txtTDSRate").value=rounditn(document.getElementById(FRM_NM+"txtTDSRate").value,3)
	            if(document.getElementById(FRM_NM+"TDS_yn").checked)
	            {
	               AmtAply=document.getElementById(FRM_NM+"txtAmtApplL").value
	               document.getElementById(FRM_NM+"txtTDSAmt").value=rounditn((parseFloat(AmtAply)*parseFloat(document.getElementById(FRM_NM+"txtTDSRate").value))/100,2)
	               TaxAmount = parseFloat(TaxAmount)- parseFloat(document.getElementById(FRM_NM+"txtTDSAmt").value)
	               document.getElementById(FRM_NM+"Txt_Commission").value=parseFloat( document.getElementById(FRM_NM+"Txt_Commission_1").value)+ TaxAmount
	            }
	            else
	            {
	               document.getElementById(FRM_NM+"txtTDSAmt").value="0.00"
	            }
	            
	         Total_Comission=parseFloat(document.getElementById(FRM_NM+"Txt_Commission").value)
	         OthAmt=parseFloat(document.getElementById(FRM_NM+"Txt_OthAmt").value)
	         Oth_ded=parseFloat(document.getElementById(FRM_NM+"Txt_Oth_ded").value)
	         Tds=parseFloat(document.getElementById(FRM_NM+"txtTDSAmt").value)
	         Tot_BillAmt=parseFloat(Total_Comission)-parseFloat(Oth_ded)+parseFloat(OthAmt)
	         if(parseFloat(Tot_BillAmt)<0)
	         {
	                alert("Bill Amount Should Be Greater Than Zero")
	                document.getElementById(FRM_NM+"Txt_Oth_ded").value="0.00"
	                document.getElementById(FRM_NM+"txtTDSRate").value="0.000"
	                document.getElementById(FRM_NM+"txtTDSAmt").value="0.00"
	                Calc_BA_OtherAmount()
	         }
	         else
	         {
	                document.getElementById(FRM_NM+"Txt_BillAmt").value=rounditn(Tot_BillAmt,2)
	         }
	         
	            
	    
        }
        function BA_OnSubmit()
        {
	         // alert("hi...")
	          GRID_ID="GridDocList"
	            var server_dt=document.getElementById(FRM_NM+"Hnd_ServerDt").value
                var dt =document.getElementById(FRM_NM+"TxtVoucherDT").value
				var hdndockdt;
			    var Maxdt="01/01/2007";
                 var grid=document.getElementById("ctl00_MyCPH1_"+GRID_ID);
                 var rows=grid.rows.length;  
                 var Check_One="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                 //alert("hi...1")
                  var i=0    
                  for(var b=2;b<=rows;b++)
                  {
                            //alert(b)
                            if(b<10)
                            {
                                GV_FRM_NM="ctl00_MyCPH1_"+GRID_ID+"_ctl0" + b + "_";
                                Hnd_Values="ctl00_MyCPH1_"+GRID_ID+"_ctl0" + b + "_Hnd_Values" 
                                Hnd_Values_Arr=document.getElementById(Hnd_Values).value.split("~");
                            }
                            else
                            {
                                 GV_FRM_NM="ctl00_MyCPH1_"+GRID_ID+"_ctl" + b + "_";
                                 Hnd_Values="ctl00_MyCPH1_"+GRID_ID+"_ctl" + b + "_Hnd_Values";
                                 Hnd_Values_Arr=document.getElementById(Hnd_Values).value.split("~");
                            }
                                if(document.getElementById(GV_FRM_NM+"Chk_Docno").checked)
                                {
                                         hdndockdt = Hnd_Values_Arr[0] ;     
                                         Check_One="Y"
                                         i=i+1 
                                         var Maxdt1 =Maxdt
                        				
				                         var Maxdt_dd=Maxdt1.substring(0,2)
				                         var Maxdt_mm=Maxdt1.substring(3,5)
				                         var Maxdt_yy=Maxdt1.substring(6,10)
                                            
		                                 var hdndockdt1 =hdndockdt
				                         var hdndockdt_dd=hdndockdt1.substring(0,2)
				                         var hdndockdt_mm=hdndockdt1.substring(3,5)
				                         var hdndockdt_yy=hdndockdt1.substring(6,10)
				                         Maxdt1=new Date(months[parseFloat(Maxdt_mm)] + " " + parseFloat(Maxdt_dd) + ", " + parseFloat(Maxdt_yy))
		                                 hdndockdt1=new Date(months[parseFloat(hdndockdt_mm)] + " " + parseFloat(hdndockdt_dd) + ", " + parseFloat(hdndockdt_yy))
                                        if (hdndockdt1>Maxdt1)
                                        {
                                        Maxdt1=hdndockdt1
                                        Maxdt=hdndockdt
                                        }
                                }
                     }
                    //  alert("hi...1")
                                if (dt=="")
				                {
						                alert( "Payment Date Should Not Be Blank !!!")
						                document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						                return false;
				                }
				            var dt_dd=dt.substring(0,2)
				            var dt_mm=dt.substring(3,5)
				            var dt_yy=dt.substring(6,10)

		                    var sdt =server_dt
				            var sdt_dd=sdt.substring(0,2)
				            var sdt_mm=sdt.substring(3,5)
				            var sdt_yy=sdt.substring(6,10)
            				
				
				            dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		                    server_dt=new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))
                
                var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2)
				var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5)
				var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10)
				FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))
				
				var FinYear_todate_dd=FinYear_todate.substring(0,2)
				var FinYear_todate_mm=FinYear_todate.substring(3,5)
				var FinYear_todate_yy=FinYear_todate.substring(6,10)
				FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))
			
				if (dt>FinYear_todate1 || dt<FinYear_fromdate1)
				{
						alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Payment Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						return false;
				}
				
                 Fromdate1=Maxdt1
			     Fromdate=Maxdt
                              if (dt<Fromdate1)
				                {
						                alert( "Payment Date Should Be Greater than  "+ Fromdate +"  !!!")
						                document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						                return false;
				                }
				                if (dt>server_dt)
				                {
						                alert( "Payment Date should not be greater than today's date !!!")
						                document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						                return false;
				                }
			    if(document.getElementById(FRM_NM+"Txt_VBillno").value=="")
			    {
			        alert("Plz Enter Vendor Billno.")
			        document.getElementById(FRM_NM+"Txt_VBillno").focus();
			        return false;
			    }
			    if(document.getElementById(FRM_NM+"Txt_VDate").value=="")
			    {
			        alert("Plz Enter Vendor Bill Date")
			        document.getElementById(FRM_NM+"Txt_VDate").focus();
			        return false;
			    }
			    if(document.getElementById(FRM_NM+"Txt_DueDays").value=="")
			    {
			        alert("Plz Enter Vendor Bill Due Days")
			        document.getElementById(FRM_NM+"Txt_DueDays").focus();
			        return false;
			    }
			    
			 if(Check_One=="N")
			 {
			    alert("Plz Select Atleast One Record :- ")
			    return false;
			 }   
			if(document.getElementById(FRM_NM+"Svctax_yn").checked)	
			{
			     
			    if(document.getElementById(FRM_NM+"txtSrvTaxNo").value=="")
			    {
			        alert("Plz Enter Service Tax Reg No.")
			        document.getElementById(FRM_NM+"txtSrvTaxNo").focus();
			        return false;
			    }
			}     	                
			if(document.getElementById(FRM_NM+"TDS_yn").checked)	
			{
			    
			    if(document.getElementById(FRM_NM+"Tdssection").value=="")
			    {
			        alert("Plz Select TDS Ledger")
			        document.getElementById(FRM_NM+"Tdssection").focus();
			        return false;
			    }
			    if(parseFloat(document.getElementById(FRM_NM+"txtTDSRate").value)<=0)
			    {
			        alert("Plz Enter TDS Rate")
			        document.getElementById(FRM_NM+"txtTDSRate").focus();
			        return false;
			    }
			    if(document.getElementById(FRM_NM+"txtPanNo").value=="")
			    {
			        alert("Plz Enter PANNO.")
			        document.getElementById(FRM_NM+"txtPanNo").focus();
			        return false;
			    }
			}                
		    if(parseFloat(document.getElementById(FRM_NM+"Txt_BillAmt").value)<=0)
			{
			        alert("Bill Amount Sould be Greater than Zero")
			       // document.getElementById(FRM_NM+"Txt_BillAmt").focus();
			        return false;
			}
			 
            if(!confirm("Are You Sure That All Bill Entry  Details Are Correct Or Not"))
            return false; 
            document.getElementById(FRM_NM+"Button1").style.display="none";
		    document.getElementById(FRM_NM+"Txt_BillAmt").disabled=false	
		    document.getElementById(FRM_NM+"Txt_Commission_1").disabled=false	
		    document.getElementById(FRM_NM+"txtServiceTax").disabled=false	
		    document.getElementById(FRM_NM+"txtEduCess").disabled=false	
		    document.getElementById(FRM_NM+"txtHEduCess").disabled=false
		    document.getElementById(FRM_NM+"txtTDSAmt").disabled=false	
		    
        }
 /*************************************************************************************************************
             FUNCTION FOr Check All
*************************************************************************************************************/
/*************************************************************************************************************
             FUNCTION FOr Check All---For 3PL
*************************************************************************************************************/
var  FRM_NM="ctl00_MyCPH1_"
function Check_All_3PL(Grd_Name,Obj_chk_All,Obj_Chk_Ind,CalC_YN)
	    {
	            // alert("Hi...")
	             Grid_Id=Grd_Name
	            /// alert(Grid_Id)
	             var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
                 var rows=grid.rows.length;  
                 var Check_One="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                 if(document.getElementById("ctl00$MyCPH1$"+Grid_Id+"$ctl01$"+Obj_chk_All).checked)
                 {
                      for(var b=2;b<=rows;b++)
                      {
                            if(b<10)
                                GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + b + "_";
                            else
                                 GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_";
                             document.getElementById(GV_FRM_NM+Obj_Chk_Ind).checked=true
                      }
                  }
                  else
                  {
                             for(var b=2;b<=rows;b++)
                              {
                                    if(b<10)
                                        GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + b + "_";
                                    else
                                         GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_";
                                    
                                    document.getElementById(GV_FRM_NM+Obj_Chk_Ind).checked=false
                              }
                  }
                  if(CalC_YN=="Y")
                     Check_Calc_3PL('GridDocList','ChkAll','Chk_Docno')
    }
    
    function Check_Calc_3PL(Grd_Name,Obj_chk_All,Obj_Chk_Ind)
	    {        
	             Grid_Id=Grd_Name
	            //alert("hi..")
	             var grid=document.getElementById("ctl00_MyCPH1_"+Grid_Id);
                 var rows=grid.rows.length;  
                  var Check_ALL="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                 var Total_adv_amt="0.00",Total_PendAmt="0.00"
                 var Total_billAmount="0"
                 //alert(rows)
                  for(var b=2;b<=rows;b++)
                  {
                  
                                    if(b<10)
                                        GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl0" + b + "_";
                                    else
                                         GV_FRM_NM="ctl00_MyCPH1_"+Grid_Id+"_ctl" + b + "_";
                                    
                                document.getElementById("ctl00$MyCPH1$"+Grid_Id+"$ctl01$"+Obj_chk_All).checked=true
                                if(document.getElementById(GV_FRM_NM+Obj_Chk_Ind).checked==false)
                                {
                                     document.getElementById("ctl00$MyCPH1$"+Grid_Id+"$ctl01$"+Obj_chk_All).checked=false
                                }    
                                else
                                {
                                    // alert("hdfg")
                                   //  Check_Calc_3PL_Individual(document.getElementById(GV_FRM_NM+Obj_Chk_Ind))
                                 Hnd_Values=document.getElementById(GV_FRM_NM+"Hnd_Values").value
                                 //alert(Hnd_Values)
                                 Hnd_Values_Arr=Hnd_Values.split("~");
                                 //alert(Hnd_Values_Arr[1])
                                 Total_billAmount=rounditn(parseFloat(Total_billAmount)+parseFloat(Hnd_Values_Arr[1]),2)  
                                 //alert(Total_billAmount)
                                 Calc_3PL_OtherAmount()
                                 }
                    } 
                     document.getElementById(FRM_NM+"Txt_Subtotal").value=rounditn(Total_billAmount,2)
	                 document.getElementById(FRM_NM+"Txt_BillAmt").value=rounditn(Total_billAmount,2)
	                 document.getElementById(FRM_NM+"txtAmtAppl").value=rounditn(Total_billAmount,2)
	                 document.getElementById(FRM_NM+"txtAmtApplL").value=rounditn(Total_billAmount,2)
	    }
	    function Check_Calc_3PL_Individual(Obj)
	    {        
	           Total_Comission=parseFloat(document.getElementById(FRM_NM+"Txt_Subtotal").value);  
	           Hnd_Values=Obj.id.replace('Chk_Docno','Hnd_Values')
	           Hnd_Values_Arr=document.getElementById(Hnd_Values).value.split("~");
	           Ind_Commission=Hnd_Values_Arr[1]
	           if(Obj.checked)
	                Total_Comission=parseFloat(Total_Comission)+parseFloat(Hnd_Values_Arr[1])
	           else
	                Total_Comission=parseFloat(Total_Comission)-parseFloat(Hnd_Values_Arr[1])
	           document.getElementById(FRM_NM+"Txt_Subtotal").value=rounditn(Total_Comission,2)
	           document.getElementById(FRM_NM+"Txt_BillAmt").value=rounditn(Total_Comission,2)
	           document.getElementById(FRM_NM+"txtAmtAppl").value=rounditn(Total_Comission,2)
	           Calc_3PL_OtherAmount()
	    }
	    function Calc_3PL_OtherAmount()
	    {
	         var TaxAmount=0
	         if(parseFloat(document.getElementById(FRM_NM+"txtAmtAppl").value)>0)
	         {
	                     if(document.getElementById(FRM_NM+"Svctax_yn").checked)
	                        {
	                           AmtAply=document.getElementById(FRM_NM+"txtAmtAppl").value 
	                           document.getElementById(FRM_NM+"txtServiceTax").value=rounditn((parseFloat(AmtAply)*10)/100,2)
	                           document.getElementById(FRM_NM+"txtEduCess").value=rounditn((parseFloat(document.getElementById(FRM_NM+"txtServiceTax").value)*2)/100,2)
	                           document.getElementById(FRM_NM+"txtHEduCess").value=rounditn((parseFloat(document.getElementById(FRM_NM+"txtServiceTax").value)*1)/100,2)
	                           var AmtAply_Tds=document.getElementById(FRM_NM+"txtAmtAppl").value
	                           TaxAmount = parseFloat(TaxAmount)+ parseFloat(document.getElementById(FRM_NM+"txtServiceTax").value) 
	                           TaxAmount = parseFloat(TaxAmount)+  parseFloat(document.getElementById(FRM_NM+"txtEduCess").value) 
	                           TaxAmount = parseFloat(TaxAmount)+ parseFloat(document.getElementById(FRM_NM+"txtHEduCess").value)
	                           document.getElementById(FRM_NM+"txtAmtApplL").value=rounditn(parseFloat(TaxAmount)+parseFloat(AmtAply_Tds),2)
	                          // document.getElementById(FRM_NM+"Txt_Subtotal").value=rounditn(document.getElementById(FRM_NM+"txtAmtApplL").value,2)
	                           document.getElementById(FRM_NM+"Txt_BillAmt").value=rounditn(document.getElementById(FRM_NM+"txtAmtApplL").value,2)
	                        }
	                        else
	                        {
	                           document.getElementById(FRM_NM+"txtServiceTax").value="0.00"
	                           document.getElementById(FRM_NM+"txtEduCess").value="0.00"
	                           document.getElementById(FRM_NM+"txtHEduCess").value="0.00"
	                           document.getElementById(FRM_NM+"txtAmtApplL").value=document.getElementById(FRM_NM+"txtAmtAppl").value
	                        }
	                        document.getElementById(FRM_NM+"txtTDSRate").value=rounditn(document.getElementById(FRM_NM+"txtTDSRate").value,3)
	                        if(document.getElementById(FRM_NM+"TDS_yn").checked)
	                        {
	                           AmtAply=document.getElementById(FRM_NM+"txtAmtApplL").value
	                           document.getElementById(FRM_NM+"txtTDSAmt").value=rounditn((parseFloat(AmtAply)*parseFloat(document.getElementById(FRM_NM+"txtTDSRate").value))/100,2)
	                           TaxAmount = parseFloat(TaxAmount)- parseFloat(document.getElementById(FRM_NM+"txtTDSAmt").value)
	                          // alert(TaxAmount)
	                           document.getElementById(FRM_NM+"Txt_BillAmt").value=rounditn(parseFloat(document.getElementById(FRM_NM+"Txt_Subtotal").value)+ TaxAmount,2)
	                         //  document.getElementById(FRM_NM+"Txt_Subtotal").value=rounditn(parseFloat(document.getElementById(FRM_NM+"txtAmtAppl").value)+ TaxAmount,2)
	                        }
	                        else
	                        {
	                           document.getElementById(FRM_NM+"txtTDSAmt").value="0.00"
	                        }
            	            
	                     Total_Comission=parseFloat(document.getElementById(FRM_NM+"Txt_BillAmt").value)
	                     OthAmt=parseFloat(document.getElementById(FRM_NM+"Txt_OthAmt").value)
	                     Oth_ded=parseFloat(document.getElementById(FRM_NM+"Txt_Oth_ded").value)
	                     Tds=parseFloat(document.getElementById(FRM_NM+"txtTDSAmt").value)
	                     Tot_BillAmt=parseFloat(Total_Comission)-parseFloat(Oth_ded)+parseFloat(OthAmt)
	                     if(parseFloat(Tot_BillAmt)<0)
	                     {
	                            alert("Bill Amount Should Be Greater Than Zero")
	                            document.getElementById(FRM_NM+"Txt_Oth_ded").value="0.00"
	                            document.getElementById(FRM_NM+"txtTDSRate").value="0.000"
	                            document.getElementById(FRM_NM+"txtTDSAmt").value="0.00"
	                            Calc_BA_OtherAmount()
	                     }
	                     else
	                     {
	                            document.getElementById(FRM_NM+"Txt_BillAmt").value=rounditn(Tot_BillAmt,2)
	                            //document.getElementById(FRM_NM+"Txt_Subtotal").value=rounditn(Tot_BillAmt,2)
	                     }
	          }
	          else
	          {
	                           document.getElementById(FRM_NM+"txtServiceTax").value="0.00"
	                           document.getElementById(FRM_NM+"txtEduCess").value="0.00"
	                           document.getElementById(FRM_NM+"txtHEduCess").value="0.00"
	                           //document.getElementById(FRM_NM+"Txt_Oth_ded").value="0.00"
	                            document.getElementById(FRM_NM+"txtTDSRate").value="0.000"
	                            document.getElementById(FRM_NM+"txtTDSAmt").value="0.00"
	                            document.getElementById(FRM_NM+"txtAmtApplL").value="0.00"
	          }
        }
        
        function PL_OnSubmit()
        {
	          //alert("hi...")
	          GRID_ID="GridDocList"
	            var server_dt=document.getElementById(FRM_NM+"Hnd_ServerDt").value
                var dt =document.getElementById(FRM_NM+"TxtVoucherDT").value
				var hdndockdt;
			    var Maxdt="01/01/2007";
                 var grid=document.getElementById("ctl00_MyCPH1_"+GRID_ID);
                 var rows=grid.rows.length;  
                 var Check_One="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                 //alert("hi...1")
                  var i=0    
                  for(var b=2;b<=rows;b++)
                  {
                            //alert(b)
                            if(b<10)
                            {
                                GV_FRM_NM="ctl00_MyCPH1_"+GRID_ID+"_ctl0" + b + "_";
                                Hnd_Values="ctl00_MyCPH1_"+GRID_ID+"_ctl0" + b + "_Hnd_Values" 
                                Hnd_Values_Arr=document.getElementById(Hnd_Values).value.split("~");
                            }
                            else
                            {
                                 GV_FRM_NM="ctl00_MyCPH1_"+GRID_ID+"_ctl" + b + "_";
                                 Hnd_Values="ctl00_MyCPH1_"+GRID_ID+"_ctl" + b + "_Hnd_Values";
                                 Hnd_Values_Arr=document.getElementById(Hnd_Values).value.split("~");
                            }
                                if(document.getElementById(GV_FRM_NM+"Chk_Docno").checked)
                                {
                                         hdndockdt = Hnd_Values_Arr[0] ;     
                                         Check_One="Y"
                                         i=i+1 
                                         var Maxdt1 =Maxdt
                        				
				                         var Maxdt_dd=Maxdt1.substring(0,2)
				                         var Maxdt_mm=Maxdt1.substring(3,5)
				                         var Maxdt_yy=Maxdt1.substring(6,10)
                                            
		                                 var hdndockdt1 =hdndockdt
				                         var hdndockdt_dd=hdndockdt1.substring(0,2)
				                         var hdndockdt_mm=hdndockdt1.substring(3,5)
				                         var hdndockdt_yy=hdndockdt1.substring(6,10)
				                         Maxdt1=new Date(months[parseFloat(Maxdt_mm)] + " " + parseFloat(Maxdt_dd) + ", " + parseFloat(Maxdt_yy))
		                                 hdndockdt1=new Date(months[parseFloat(hdndockdt_mm)] + " " + parseFloat(hdndockdt_dd) + ", " + parseFloat(hdndockdt_yy))
                                        if (hdndockdt1>Maxdt1)
                                        {
                                        Maxdt1=hdndockdt1
                                        Maxdt=hdndockdt
                                        }
                                }
                     }
                    //  alert("hi...1")
                                if (dt=="")
				                {
						                alert( "Payment Date Should Not Be Blank !!!")
						                document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						                return false;
				                }
				            var dt_dd=dt.substring(0,2)
				            var dt_mm=dt.substring(3,5)
				            var dt_yy=dt.substring(6,10)

		                    var sdt =server_dt
				            var sdt_dd=sdt.substring(0,2)
				            var sdt_mm=sdt.substring(3,5)
				            var sdt_yy=sdt.substring(6,10)
            				
				
				            dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		                    server_dt=new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))
                
                var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2)
				var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5)
				var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10)
				FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))
				
				var FinYear_todate_dd=FinYear_todate.substring(0,2)
				var FinYear_todate_mm=FinYear_todate.substring(3,5)
				var FinYear_todate_yy=FinYear_todate.substring(6,10)
				FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))
			
				if (dt>FinYear_todate1 || dt<FinYear_fromdate1)
				{
						alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Payment Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						return false;
				}
				
                 Fromdate1=Maxdt1
			     Fromdate=Maxdt
                              if (dt<Fromdate1)
				                {
						                alert( "Payment Date Should Be Greater than  "+ Fromdate +"  !!!")
						                document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						                return false;
				                }
				                if (dt>server_dt)
				                {
						                alert( "Payment Date should not be greater than today's date !!!")
						                document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						                return false;
				                }
			    if(document.getElementById(FRM_NM+"Txt_VBillno").value=="")
			    {
			        alert("Plz Enter Vendor Billno.")
			        document.getElementById(FRM_NM+"Txt_VBillno").focus();
			        return false;
			    }
			    if(document.getElementById(FRM_NM+"Txt_VDate").value=="")
			    {
			        alert("Plz Enter Vendor Bill Date")
			        document.getElementById(FRM_NM+"Txt_VDate").focus();
			        return false;
			    }
			    if(document.getElementById(FRM_NM+"Txt_DueDays").value=="")
			    {
			        alert("Plz Enter Vendor Bill Due Days")
			        document.getElementById(FRM_NM+"Txt_DueDays").focus();
			        return false;
			    }
			    
			 if(Check_One=="N")
			 {
			    alert("Plz Select Atleast One Record :- ")
			    return false;
			 }   
			if(document.getElementById(FRM_NM+"Svctax_yn").checked)	
			{
			     
			    if(document.getElementById(FRM_NM+"txtSrvTaxNo").value=="")
			    {
			        alert("Plz Enter Service Tax Reg No.")
			        document.getElementById(FRM_NM+"txtSrvTaxNo").focus();
			        return false;
			    }
			}     	                
			if(document.getElementById(FRM_NM+"TDS_yn").checked)	
			{
			    
			    if(document.getElementById(FRM_NM+"Tdssection").value=="")
			    {
			        alert("Plz Select TDS Ledger")
			        document.getElementById(FRM_NM+"Tdssection").focus();
			        return false;
			    }
			    if(parseFloat(document.getElementById(FRM_NM+"txtTDSRate").value)<=0)
			    {
			        alert("Plz Enter TDS Rate")
			        document.getElementById(FRM_NM+"txtTDSRate").focus();
			        return false;
			    }
			    if(document.getElementById(FRM_NM+"txtPanNo").value=="")
			    {
			        alert("Plz Enter PANNO.")
			        document.getElementById(FRM_NM+"txtPanNo").focus();
			        return false;
			    }
			}                
		    if(parseFloat(document.getElementById(FRM_NM+"Txt_BillAmt").value)<=0)
			{
			        alert("Bill Amount Sould be Greater than Zero")
			       // document.getElementById(FRM_NM+"Txt_BillAmt").focus();
			        return false;
			}
			 
            if(!confirm("Are You Sure That All Bill Entry  Details Are Correct Or Not"))
            return false; 
            document.getElementById(FRM_NM+"Button1").style.display="none";
		    document.getElementById(FRM_NM+"Txt_BillAmt").disabled=false	
		    //document.getElementById(FRM_NM+"Txt_Commission_1").disabled=false	
		    document.getElementById(FRM_NM+"txtServiceTax").disabled=false	
		    document.getElementById(FRM_NM+"txtEduCess").disabled=false	
		    document.getElementById(FRM_NM+"txtHEduCess").disabled=false
		    document.getElementById(FRM_NM+"txtTDSAmt").disabled=false	
		    
        }