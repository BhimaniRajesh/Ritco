<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="OctCustBillStep2.aspx.cs" Inherits="octroi_OctCustBillStep2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <br />
    <table align="left" style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Finance</b></font> </a><b>&gt; </b><a><font class="blklnkund"><b>Octroi</b></font>
                        <b>&gt; </b></a><a><font class="bluefnt"><b>Prepare Octroi Bill </b></font></a>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <br />

    <script type="text/javascript" language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="./../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript">
    
    
            var cal = new CalendarPopup("testdiv1"); 
	    cal.setCssPrefix("TEST");
	    cal.showNavigationDropdowns();
	    
	    
	    
    var doc = null; 
var formobj;
var MyDiv = document.getElementById("ReportingToCombo");
	var formObj = null;

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

function validRPDate(id)
{

    var txtdate=document.getElementById(id);
    
        if(!isValidDate(txtdate.value,"Recipt Date"))
        txtdate.focus();
            return false;
}



function nonnon(event)
{
    
    event.keyCode=0;
    return false;
  
}

function validBillDate(id)
{

    var txtdate=document.getElementById(id);
    
        if(!isValidDate(txtdate.value,"Bill Date"))
        txtdate.focus();
            return false;
}
function validDueDate(id)
{

    var txtdate=document.getElementById(id);
    
        if(!isValidDate(txtdate.value,"Due Date"))
        txtdate.focus();
            return false;
}

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

	
	function calc()
    {
    
        var grid=document.getElementById("ctl00_MyCPH1_DataGrid1");
        var norows=grid.rows.length;
       
        var pref="";
//        var grandtotal=0.00;
//        var octamt=0.00;
//        var processchrg=0.00;
//        var stax=0.00;
//        var cess=0.00;
//        var hcess=0.00;
      //  var otchg=0.00;
       var grandtotal2=0.00;
         var pref="";
       
        var octamt=0.00;
        var processchrg=0.00;
        var stax=0.00;
        var cess=0.00;
        var hcess=0.00;
        var othr=0.00;
        var forsvc=0.00;
          var Formnae="ctl00$MyCPH1$DataGrid1$ctl"//02$txtoctamt"
  
         for (i=0;i<norows-1;i++ )
    {
       // alert(i)
        j=i+2;
        var grandtotal=0.00;
        
        
                if(j<10)
                {
                           pref=Formnae+"0"+j+"$"
                }
                 else
                 {
                            pref=Formnae+j+"$"
                  }
            
            var txtoctamt=document.getElementById(pref+"txtoctamt");
            var txtoctper=document.getElementById(pref+"txtoctper");
            var txtclearchrg=document.getElementById(pref+"txtclearchrg");
            var txtprochrg_per=document.getElementById(pref+"txtprochrg_per");
            var txtprochrg=document.getElementById(pref+"txtprochrg");
            var txtstax=document.getElementById(pref+"txtstax");
            var txtcess=document.getElementById(pref+"txtcess");
            var txthcess=document.getElementById(pref+"txthcess");
            var txtotchg=document.getElementById(pref+"txtotchg");
            var txttotalamt=document.getElementById(pref+"txttotalamt");
          //  var txttotalamt=document.getElementById(pref+"txttotalamt");
           var txtdeclval=document.getElementById(pref+"txtdeclval");



            octamt=parseFloat(txtoctamt.value);
            if(octamt==0)
            {
            }
            else
            {
          //  debugger
          
            var perct = parseFloat(txtoctamt.value) * 100 / parseFloat(txtdeclval.value);
            txtoctper.value = rounditn(perct,2);
            
            
            grandtotal=grandtotal + octamt;  // Assigning Octroi Amount to Grand Total
            
            grandtotal=grandtotal + parseFloat(txtclearchrg.value); // Adding Cleasrance Charges to Grand Total
            
            processchrg=parseFloat(txtoctamt.value) * parseFloat(txtprochrg_per.value) / 100;
            
            grandtotal = grandtotal + processchrg; // Adding Processing Charges to Grand Total
            txtprochrg.value=rounditn(processchrg,2)
            
            //Calculating STAX where STAX = 12 % Processing Charges 
            forsvc = parseFloat(txtclearchrg.value)+processchrg+parseFloat(txtotchg.value)
            //alert(forsvc)
            //alert("hi....")
           // alert(document.getElementById("ctl00_MyCPH1_svctax_yn").checked)
             if(document.getElementById("ctl00_MyCPH1_svctax_yn").checked==true)
            {
            
            stax = (forsvc * 12) / 100;
            txtstax.value=rounditn(stax,2);
            grandtotal = grandtotal + stax; // Adding STAX to Grand Total
            
            // Calculating CESS = 2 % of STAX
            cess=(stax*2)/100;
            txtcess.value=rounditn(cess,2);
            grandtotal = grandtotal + cess;
            
            //Calculating HCESS = 1 % of STAX
            hcess=(stax*1)/100;
            txthcess.value=rounditn(hcess,2);
            grandtotal = grandtotal + hcess;
            }
             else
             {
             txtstax.value="0.00"
             txtcess.value="0.00"
             txthcess.value="0.00"
             }
             othr=parseFloat(txtotchg.value);
            grandtotal = grandtotal+othr;
            txttotalamt.value=rounditn(grandtotal,2);
            grandtotal2+=grandtotal;
            //alert("hi..2")
              document.getElementById("ctl00_MyCPH1_txtbillamt").value =rounditn(grandtotal2,2);
              //alert("hi..2.1")
              document.getElementById("ctl00_MyCPH1_h11").value = rounditn(grandtotal2,2);
              // alert("hi..3")
              }
        }

    }
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
	var p=true
	function doWork() {
	   
	    if (doc.readyState == 4) {
	    
	     
	    
	    
	     //alert(doc.responseText)
	          
	           
	           var res=doc.responseText.split("|");
	           
	           if (res[0]!="OK")
	           {
	          
	            alert(res[0])
	            p=false
	            rt=""
	            var aa=document.getElementById("ctl00_MyCPH1_hid").value;
	            document.getElementById(aa).value="";
	           // document.getElementById(aa).focus();
	            return false
	                //formobj.value="";
	                //formobj.focus();
	           }
	           else
	           {
	         //  debugger
	                  var s= document.getElementById("ctl00_MyCPH1_hi").value;
	                  document.getElementById(s).value = res[1];
	                  
	                  var hamt= document.getElementById("ctl00_MyCPH1_h_amt").value;
	                  document.getElementById(hamt).value = res[2];
	                  
	                  var hno= document.getElementById("ctl00_MyCPH1_h_rno").value;
	                  document.getElementById(hno).value = res[3];
	                  
	                  var hdt= document.getElementById("ctl00_MyCPH1_h_rdt").value;
	                  document.getElementById(hdt).value = res[4];
	                  
	                 
	           }
	    }
	}
       
        var f1,f2
        f1="1"
        f2="1"
        var dno=""


function dktcheck(d)
        {
    //    debugger
    var txtdno=d.id;
          var txdec=d.id;
         
             document.getElementById("ctl00_MyCPH1_hid").value=txtdno;
             
          txdec=txdec.replace( "txtdockno", "txtdeclval");
           
          
            document.getElementById("ctl00_MyCPH1_hi").value=txdec;
            
        var dno=d.value;
        
        var tx_rno=txtdno.replace( "txtdockno", "txtrcptno");
        document.getElementById("ctl00_MyCPH1_h_rno").value=tx_rno;
         var tx_rdt=txtdno.replace( "txtdockno", "txtrcptdate");
         document.getElementById("ctl00_MyCPH1_h_rdt").value=tx_rdt;
          var tx_amt=txtdno.replace( "txtdockno", "txtoctamt");
          document.getElementById("ctl00_MyCPH1_h_amt").value=tx_amt;
          
                createXMLHTTPObject();
                 if (doc)
				 { 
             	                arg=new Date()
             	              //  var cst= <%=custcls%>;
             	               // alert(cst);
             	               var ccst=document.getElementById("ctl00_MyCPH1_h2").value
             	               // alert(ccst);
					            doc.onreadystatechange = doWork; 
					            doc.open("GET", "dochk.aspx?dno=" + dno+"&cust="+ccst, false);
					          //  doc.open("GET", "dochk.aspx?dno=" + dno, false);
					            doc.send(null);
				  }
               
             
        }
        
        
//         
//        
//function checklocation(obj)
//        {
//        
//        var a;
//        a=1;
//     obj.value = obj.value.toUpperCase()
//        //str=str.toUpperCase()
//        
//        if(obj.value != "")
//        {
//       for(i=0;i<str.length;i++)
//       {
//       
//       str[i]=str[i].toUpperCase()

//            if(obj.value==str[i])
//            {
//                 a=2
//                  break;
//               
//                
//            }
//            else
//            { 
//               
//                continue
//            }
//       }
//      
//       if(a!=2)
//       {
//             alert("Invalid Cnote/HWB No.")
//           obj.focus();
//       }
//       }
// 

//}   

 Form_name="ctl00$MyCPH1$"
 
 function Nagative_Chk_wDecimal(obj)
{

var temp
temp=obj.value


if (temp=="")
{
alert("Value can not be blank")
obj.focus();
return false;
}
if(isNaN(temp))
{
alert("Value should be Numeric")
obj.value=""
obj.focus();
return false;
}
if(parseFloat(temp)<=0)
{
alert("Value should be greater than zero")
obj.value=""
obj.focus();
return false;
}
 
return true;
}

function ValidateData()
   {
                if(document.getElementById("ctl00_MyCPH1_txtbillcolloc"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtbillcolloc").value == "")
                    {
                        alert("Enter Location Code");
                        document.getElementById("ctl00_MyCPH1_txtbillcolloc").focus();
                        return false;
                    }                    
                    else if(document.getElementById("ctl00_MyCPH1_lblErrorLocation1"))
                    {
                        if(document.getElementById("ctl00_MyCPH1_lblErrorLocation1").style.display == '')
                        {
                            alert("Invalid 'Location Code'");
                            document.getElementById("ctl00_MyCPH1_txtbillcolloc").focus();
                            return false;
                        }
                    }
                }
                
                if(document.getElementById("ctl00_MyCPH1_txtbillsubloc"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtbillsubloc").value == "")
                    {
                        alert("Enter Location Code");
                        document.getElementById("ctl00_MyCPH1_txtbillsubloc").focus();
                        return false;
                    }                    
                    else if(document.getElementById("ctl00_MyCPH1_lblErrorLocation"))
                    {
                        if(document.getElementById("ctl00_MyCPH1_lblErrorLocation").style.display == '')
                        {
                            alert("Invalid 'Location Code'");
                            document.getElementById("ctl00_MyCPH1_txtbillsubloc").focus();
                            return false;
                        }
                    }
                }
                
        var mDerviedControlForDocketNo = "";
        var mDerviedControlForMRReceiptNo = "";
        var mDerviedControlForMRReceiptDate = "";
        
        //Check for No. of Rows
        if(document.getElementById("ctl00_MyCPH1_roww"))
        {
            if(document.getElementById("ctl00_MyCPH1_roww").value != "")
            {
                for(var mLoopCounter = 1; mLoopCounter <= document.getElementById("ctl00_MyCPH1_roww").value; mLoopCounter++)
                {
                    
                    j=mLoopCounter+1
                    mDerviedControlForDocketNo = "ctl00_MyCPH1_DataGrid1_ctl" + (mLoopCounter < 10 ? ("0" + (mLoopCounter + 1)) : (mLoopCounter + 1)) + "_txtdockno";
                    mDerviedControlForMRReceiptNo = "ctl00_MyCPH1_DataGrid1_ctl" + (mLoopCounter < 10 ? ("0" + (mLoopCounter + 1)) : (mLoopCounter + 1)) + "_txtrcptno";
                    mDerviedControlForMRReceiptDate = "ctl00_MyCPH1_DataGrid1_ctl" + (mLoopCounter < 10 ? ("0" + (mLoopCounter + 1)) : (mLoopCounter + 1)) + "_txtrcptdate"
                     mDerviedControlForMRtxtprochrg_per = "ctl00_MyCPH1_DataGrid1_ctl" + (mLoopCounter < 10 ? ("0" + (mLoopCounter + 1)) : (mLoopCounter + 1)) + "_txtprochrg_per"
                      mDerviedControlForMRtxtprochrg = "ctl00_MyCPH1_DataGrid1_ctl" + (mLoopCounter < 10 ? ("0" + (mLoopCounter + 1)) : (mLoopCounter + 1)) + "_txtprochrg"
                      // mDerviedControlForMRtxttotalamt = "ctl00_MyCPH1_DataGrid1_ctl" + (mLoopCounter < 10 ? ("0" + (mLoopCounter + 1)) : (mLoopCounter + 1)) + "_txttotalamt"
                        mDerviedControlForMRtxtoctper = "ctl00_MyCPH1_DataGrid1_ctl" + (mLoopCounter < 10 ? ("0" + (mLoopCounter + 1)) : (mLoopCounter + 1)) + "_txttxtoctper"
                        //alert("hi...")
                        //alert(mDerviedControlForMRReceiptDate)
                       // alert(mDerviedControlForMRtxtprochrg_per)
                         if(mLoopCounter < 10)
                        {
                                               
                            frm3=Form_name+"DataGrid1$ctl"+"0"+j+"$"
                        }
                        else
                        {
                            frm3=Form_name+"DataGrid1$ctl"+j+"$"
                           
                        }
                    
                        
                        document.getElementById(frm3+"txtprochrg_per").disabled=false
                        document.getElementById(frm3+"txtprochrg").disabled=false
                        document.getElementById(frm3+"txtoctper").disabled=false
                        document.getElementById(frm3+"txttotalamt").disabled=false
                        
                    if(document.getElementById(mDerviedControlForDocketNo) && document.getElementById(mDerviedControlForMRReceiptNo) && document.getElementById(mDerviedControlForMRReceiptDate))
                    {
                        if(document.getElementById(mDerviedControlForDocketNo).value != "")
                        {                           
                            if(document.getElementById(mDerviedControlForMRReceiptNo).value == "")
                            {
                                alert("Enter Receipt No. for Docket No. " + document.getElementById(mDerviedControlForDocketNo).value);
                                document.getElementById(mDerviedControlForMRReceiptNo).focus();
                                return false;
                            }
                            if(document.getElementById(mDerviedControlForMRReceiptDate).value == "")
                            {
                                alert("Enter Receipt Date for Docket No. " + document.getElementById(mDerviedControlForDocketNo).value);
                                document.getElementById(mDerviedControlForMRReceiptDate).focus();
                                return false;
                            }
                        }
                    }                    
                }
            }
            else
            {
                return false;
            }
        }
        
        return true;
        
        
   }
   
      
   function AddRowNo(txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8)
  {
  
//  
//	 var val1 = document.getElementById(txt1).value;
//     var val2 = document.getElementById(txt2).value;
//     var val3 = document.getElementById(txt3).value;
//     //alert(val3)
//     var val4 = document.getElementById(txt4).value;
//     var val5 = document.getElementById(txt5).value;
//     var val6 = document.getElementById(txt6).value;
//     var val7 = document.getElementById(txt7).value;
//     var val8 = document.getElementById(txt8).value;
//     
// // if(val1 == "" && val2 == "" && val3 == "" && val4 == "" && val5 == "" && val6 == "" && val7 == "" && val8 == "") 
////  return false   
//  
// if(isNaN(val1))
// {
// alert("Please Enter Only Number")
// document.getElementById(txt1).focus();
// return false;
// }
// 
//  if(isNaN(val2))
// {
//    alert("Please Enter Only Number")
//    document.getElementById(txt2).focus();
//    return false;
//  }
// if(isNaN(val3))
// {
//    alert("Please Enter Only Number")
//    document.getElementById(txt3).focus();
//    return false;
//  }
// if(isNaN(val4))
// {
//    alert("Please Enter Only Number")
//    document.getElementById(txt4).focus();
//    return false;
//  }
// if(isNaN(val5))
// {
//    alert("Please Enter Only Number")
//    document.getElementById(txt5).focus();
//    return false;
//  }
//  if(isNaN(val6))
// {
//    alert("Please Enter Only Number")
//    document.getElementById(txt6).focus();
//    return false;
//    
//  }
//  if(isNaN(val7))
// {
//    alert("Please Enter Only Number")
//    document.getElementById(txt7).focus();
//    return false;
//  }
//  if(isNaN(val8))
// {
//    alert("Please Enter Only Number")
//    document.getElementById(txt8).focus();    
//    return false;
//    document.getElementById(txt8).value=0
// }
//  
//  if(Number(val1) < 0 )
// {
//    alert("Please Enter Positive Value")
//    document.getElementById(txt1).focus();
//    return false;
//  }
//  
//  if(Number(val2) < 0 )
// {
//    alert("Please Enter Positive Value")
//    document.getElementById(txt2).focus();
//    return false;
//  }
//  if(Number(val3) < 0 )
// {
//    alert("Please Enter Positive Value")
//    document.getElementById(txt3).focus();
//    return false;
//  }
//  if(Number(val4) < 0 )
// {
//    alert("Please Enter Positive Value")
//    document.getElementById(txt4).focus();
//    return false;
//  }
//  if(Number(val5) < 0 )
// {
//    alert("Please Enter Positive Value")
//    document.getElementById(txt5).focus();
//    return false;
//  }
//  if(Number(val6) < 0 )
// {
//    alert("Please Enter Positive Value")
//    document.getElementById(txt6).focus();
//    return false;
//  }
//  if(Number(val7) < 0 )
// {
//    alert("Please Enter Positive Value")
//    document.getElementById(txt7).focus();
//    return false;
//  }


//    var Oct_Per=Math.round((parseFloat(val1)*100)/parseFloat(val7))
//    if(isNaN(Oct_Per))
//    {
//    document.getElementById(txt2).value = 0
//    }
//    else
//    {
//    document.getElementById(txt2).value = Oct_Per
//    }
//     
//    //debugger
//     
//    var OctPer=Math.round(((parseFloat(val1)*parseFloat(val4))/100))
//    if(isNaN(OctPer))
//    {
//    document.getElementById(txt5).value=0
//    }
//    else
//    {
//    document.getElementById(txt5).value=OctPer
//    }   
//    var TotalChrg= parseFloat(val1)+OctPer+parseFloat(val6) +parseFloat(val3)
//    if(isNaN(TotalChrg))
//    {
//        document.getElementById(txt8).value= 0
//    }
//    else
//    {    
//    document.getElementById(txt8).value= TotalChrg
//    }
//    if(isNaN(document.getElementById("ctl00_MyCPH1_txtbillamt").value))
//    {
//        document.getElementById("ctl00_MyCPH1_txtbillamt").value =0
//    }
//    else
//    {
//        var mDerviedControlForDocketNo = "";
//        var mDerviedControlForMRTotal = "";
//        
//        
//        //Check for No. of Rows
//        if(document.getElementById("ctl00_MyCPH1_roww"))
//        {
//            if(document.getElementById("ctl00_MyCPH1_roww").value != "")
//            {
//           // document.getElementById("ctl00_MyCPH1_txtbillamt").value =0
//                var mTotal = 0;
//                for(var mLoopCounter = 1; mLoopCounter <= document.getElementById("ctl00_MyCPH1_roww").value; mLoopCounter++)
//                {
//                    mDerviedControlForDocketNo = "ctl00_MyCPH1_DataGrid1_ctl" + (mLoopCounter < 10 ? ("0" + (mLoopCounter + 1)) : (mLoopCounter + 1)) + "_txtdockno";
//                  //  mDerviedControlForMRTotal = "ctl00_MyCPH1_DataGrid1_ctl" + (mLoopCounter < 10 ? ("0" + (mLoopCounter + 1)) : (mLoopCounter + 1)) + "_txttotalamt";                   
//                    
//                    if(document.getElementById(mDerviedControlForDocketNo) && document.getElementById(mDerviedControlForMRTotal))
//                    {
////                        if(document.getElementById(mDerviedControlForDocketNo).value != "" && document.getElementById(mDerviedControlForMRTotal).value != "")
////                        {   
////                            mTotal += parseInt(document.getElementById(mDerviedControlForMRTotal).value);
////                        }                               
//                    }                    
//                }                
////                document.getElementById("ctl00_MyCPH1_txtbillamt").value = mTotal;
////                document.getElementById("ctl00_MyCPH1_h11").value = mTotal;
//            }
//            else
//            {
//                return false;
//            }
//        }        
//        return true;    
//    }
 }
 function tupper(obj)
{
 
obj.value=obj.value.toUpperCase()
//txtrcpno.Attributes.Add("onblur", "javascript:tupper(this)");
}
function Svctax_enable_disable()
    { 
  
 
        var grid=document.getElementById("ctl00_MyCPH1_DataGrid1");
        var norows=grid.rows.length;
       
        var pref="";
   
       var Formnae="ctl00$MyCPH1$DataGrid1$ctl"//02$txtoctamt"
  
         for (i=0;i<norows-1;i++ )
            {

                j=i+2;
                var grandtotal=0.00;
                
                
                        if(j<10)
                        {
                                   pref=Formnae+"0"+j+"$"
                        }
                         else
                         {
                                    pref=Formnae+j+"$"
                         }
                          
                          
                   if(document.getElementById("ctl00_MyCPH1_svctax_yn").checked==true)
                   {
                    document.getElementById(pref+"txtstax").disabled=true;
                    document.getElementById(pref+"txtcess").disabled=true;
                    document.getElementById(pref+"txthcess").disabled=true;
                   }
                   else
                   {
                   document.getElementById(pref+"txtstax").disabled=false;
                    document.getElementById(pref+"txtcess").disabled=false;
                    document.getElementById(pref+"txthcess").disabled=false;
                   }
                   
       }
       calc()
 }
    </script>

    <br />
    <div style="width: 9.5in">
        <br />
        <br />
        <asp:Panel ID="plnerr" Visible="false" runat="server">
            <table width="90%">
                <tr>
                    <td align="center">
                        <asp:Label ID="Error" ForeColor="red" Text="Error:" Font-Bold="true" runat="server"></asp:Label>
                        <br />
                        <asp:Label ID="lblerr" ForeColor="red" Font-Bold="true" runat="server"></asp:Label>
                        <br />
                        <br />
                        <asp:Label ID="Label3" Text="Please Try Again....." runat="server"></asp:Label>
                        <br />
                        <br />
                        <asp:Button ID="Button1" Text="OK" runat="server" Width="170" OnClick="btn_ok_Click" />
                    </td>
                </tr>
            </table>
        </asp:Panel>
        <asp:Panel ID="pnl1" runat="server">
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 50%"
                align="center">
                <tr bgcolor="white" style="height: 25px">
                    <td style="width: 209px">
                        <font class="blackfnt">Customer</font>
                    </td>
                    <td>
                        <font class="blackfnt">
                            <asp:Label ID="Label1" runat="server" Text="Label" Width="237px"></asp:Label></font></td>
                </tr>
            </table>
            <br />
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 80%"
                align="center">
                <tr bgcolor="white" style="height: 25px">
                    <td style="width: 111px">
                        <font class="blackfnt">Bill Number</font>
                    </td>
                    <td style="width: 195px">
                        <font class="blackfnt" color="red">System Generated...</font></td>
                    <td style="width: 188px">
                        <font class="blackfnt">Bill Date</font></td>
                    <td>
                        <asp:TextBox ID="txtbgndt" onblur="javascript:return validBillDate(this.getAttribute('id'));"
                            runat="server" Width="94px"></asp:TextBox>
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtbgndt,'anchor2','dd/MM/yyyy'); return false;"
                            name="anchor2" id="a2">
                            <img src="./../../images/calendar.jpg" border="0"></img>
                        </a><font class="blackfnt">dd/mm/yyyy</font></td>
                </tr>
                <tr bgcolor="white" style="height: 25px">
                    <td>
                        <font class="blackfnt">Party name</font></td>
                    <td>
                        <font class="blackfnt">
                            <asp:Label ID="LblPTMSCD" runat="server" Width="191px"></asp:Label></font></td>
                    <td>
                        <font class="blackfnt">Billing Party Address</font></td>
                    <td>
                    </td>
                </tr>
                <tr bgcolor="white" style="height: 25px">
                    <td>
                        <font class="blackfnt">Generated at location</font></td>
                    <td>
                        <font class="blackfnt">
                            <%=Session["brcd"].ToString() %>
                        </font>
                    </td>
                    <td>
                        <font class="blackfnt">Bill Submission at</font></td>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>
                                <asp:TextBox ID="txtbillsubloc" runat="server" Width="91px" class="input" AutoPostBack="true"
                                    OnTextChanged="txtbillsubloc_TextChanged"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                                    ControlToValidate="txtbillsubloc"></asp:RequiredFieldValidator>
                                <label class="blackfnt" id="lblErrorLocation" runat="server" style="color: Red;"
                                    visible="false">
                                    &nbsp;Invalid Location Code!!!
                                </label>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="txtbillsubloc" EventName="TextChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr bgcolor="white" style="height: 25px">
                    <td>
                        <font class="blackfnt">Generated for location</font></td>
                    <td>
                        <font class="blackfnt">
                            <%=Session["brcd"].ToString() %>
                        </font>
                    </td>
                    <td>
                        <font class="blackfnt">Bill Collection at</font></td>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanel21" runat="server">
                            <ContentTemplate>
                                <asp:TextBox ID="txtbillcolloc" runat="server" Width="91px" AutoPostBack="true" OnTextChanged="txtbillcolloc_TextChanged"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*"
                                    ControlToValidate="txtbillcolloc"></asp:RequiredFieldValidator>
                                <label class="blackfnt" id="lblErrorLocation1" runat="server" style="color: Red;"
                                    visible="false">
                                    &nbsp;Invalid Location Code!!!
                                </label>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="txtbillcolloc" EventName="TextChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr bgcolor="white" style="height: 25px">
                    <td style="height: 25px">
                        <font class="blackfnt">Bill Amount</font></td>
                    <td style="height: 25px">
                        &nbsp;<asp:TextBox ID="txtbillamt" runat="server" Columns="10" MaxLength="10" ReadOnly="True"></asp:TextBox>
                        <asp:HiddenField ID="h11" runat="server" />
                    </td>
                    <td style="height: 25px">
                        <font class="blackfnt">Due Date</font></td>
                    <td style="height: 25px">
                        <asp:TextBox ID="txtduedate" runat="server" onblur="javascript:return validDueDate(this.getAttribute('id'));"
                            Width="99px"></asp:TextBox>
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtduedate,'anchor3','dd/MM/yyyy'); return false;"
                            name="anchor3" id="a3">
                            <img src="./../../images/calendar.jpg" border="0"></img>
                        </a><font class="blackfnt">dd/mm/yyyy</font></td>
                </tr>
                <tr bgcolor="white" style="height: 25px">
                    <td style="height: 25px">
                    </td>
                    <td style="height: 25px">
                        <asp:HiddenField ID="hi" runat="server" />
                        <asp:HiddenField ID="h2" runat="server" />
                        <asp:HiddenField ID="hid" runat="server" />
                        <asp:HiddenField ID="h_rno" runat="server" />
                        <asp:HiddenField ID="h_rdt" runat="server" />
                        <asp:HiddenField ID="h_amt" runat="server" />
                    </td>
                    <td style="height: 25px">
                    </td>
                    <td style="height: 25px">
                    </td>
                </tr>
            </table>
            &nbsp;<br />
            <font class="redfnt"><strong>
                <asp:CheckBox runat="server" ID="svctax_yn"   Checked="true" />
                Check here to Enable Service tax Deatils for the Octroi BIll detail
                <br />
            </strong></font>
            <center>
                <asp:UpdatePanel ID="DataGrid2_Update" runat="server"  UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                        <center>
                            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" align="center">
                                <tr bgcolor="white">
                                    <td align="left" style="width: 91px; height: 40px;">
                                        <font class="bluefnt">Enter Row No *</font></td>
                                    <td style="height: 40px">
                                        <asp:TextBox ID="roww" runat="server" Text="1" Width="40px" BorderStyle="Groove"></asp:TextBox></td>
                                    <td style="width: 63px; height: 40px">
                                        <%--<asp:LinkButton ID="btnAdd" runat="server" Text="Add Row" CausesValidation="false" OnClick="btnAdd_Grid" >
                        </asp:LinkButton>--%>
                                        <asp:Button ID="btnAdd" runat="server" Text="Add Row" CausesValidation="false" OnClick="btnAdd_Grid">
                                        </asp:Button>
                                    </td>
                                </tr>
                            </table>
                            &nbsp;</center>
                        <center>
                            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" align="center">
                                <tr bgcolor="white">
                                    <td align="left" colspan="2">
                                        <asp:DataGrid ID="DataGrid1" runat="server" AutoGenerateColumns="False" CellPadding="1"
                                            CssClass="boxbg" BorderWidth="0" CellSpacing="1" Width="90%">
                                            <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                                            <SelectedItemStyle BackColor="#009999" Font-Bold="True" />
                                            <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center"
                                                Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White"
                                                Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                                            <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                                            <HeaderStyle CssClass="bgbluegrey" />
                                            <Columns>
                                                <asp:TemplateColumn HeaderText="Sr. No.">
                                                    <ItemTemplate>
                                                        <center>
                                                            <font class="blackfnt">
                                                                <%# Container.ItemIndex+1 %>
                                                            </font>
                                                        </center>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderStyle-CssClass="blackfnt">
                                                    <HeaderTemplate>
                                                        <center>
                                                            <asp:Label ID="l1" runat="server" Text='<%#Session["DocketCalledAs"]+" No."%>'></asp:Label>
                                                        </center>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtdockno" runat="server" onblur="return dktcheck(this)" BorderStyle="Groove"
                                                            Columns="6" Text='<%# DataBinder.Eval(Container.DataItem, "dockno")%>'></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                    HeaderText="Declared Value">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtdeclval" runat="server" BorderStyle="Groove" Columns="6"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                    HeaderText="Octroi Amt.">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtoctamt" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                                            onblur="javascript:return calc()" BorderStyle="Groove" Columns="6" Text="0"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                    HeaderText="Octroi(%)">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtoctper" runat="server" onkeypress="javascript:return nonnon(event,this.getAttribute('id'));"
                                                            onblur="javascript:return calc()" BorderStyle="Groove" Columns="6" 
                                                            Text="0"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                    HeaderText="Clearance Charges">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtclearchrg" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                                            onblur="javascript:return calc()" BorderStyle="Groove" Columns="6" Text="0"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                    HeaderText="Processing Charges(%)">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtprochrg_per" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                                            onblur="javascript:return calc()" BorderStyle="Groove" Columns="6" Text="0"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                    HeaderText="Processing Charges">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtprochrg" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                                            BorderStyle="Groove" Columns="6" Text="0"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                    HeaderText="Other Charges">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtotchg" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                                            onblur="javascript:return calc()" BorderStyle="Groove" Columns="6" Text="0"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                    HeaderText="S.Tax">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtstax" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                                            onblur="javascript:return calc()" BorderStyle="Groove" Columns="6" Text="0"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                    HeaderText="Cess">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtcess" runat="server" onblur="javascript:return calc()" BorderStyle="Groove"
                                                            Columns="6" Text="0"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                    HeaderText="Higher Edu. Cess">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txthcess" runat="server" onkeypress="javascript:return validFloat(event,this.getAttribute('id'));"
                                                            onblur="javascript:return calc()" BorderStyle="Groove" Columns="6" Text="0"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                    HeaderText="Total">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txttotalamt" runat="server" onkeypress="javascript:return nonnon(event,this.getAttribute('id'));"
                                                            onblur="javascript:return calc()" BorderStyle="Groove" Columns="6" Text="0"  ></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                    HeaderText="Reciept No.">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtrcptno" runat="server" BorderStyle="Groove" Columns="6"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="center"
                                                    HeaderText="Receipt Date ">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtrcptdate" runat="server" BorderStyle="Groove" onblur="javascript:return validRPDate(this.getAttribute('id'));"
                                                            Columns="6"></asp:TextBox>
                                                        <%-- <asp:RegularExpressionValidator ID="rg1" runat="server" ControlToValidate="txtrcptdate"
                                                    ErrorMessage="MM/DD/YY" ValidationExpression="^(([1-9])|(0[1-9])|(1[0-2]))\/(([1-9])|(0[1-9])|(1[0-9])|(2[0-9])|(3[0-1]))\/((\d{2})|(\d{4}))$"></asp:RegularExpressionValidator>--%>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                            </Columns>
                                        </asp:DataGrid>
                                    </td>
                                </tr>
                                <tr bgcolor="white">
                                    <td align="left">
                                        <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Text="Remark"></asp:Label>&nbsp;
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtRemark" runat="server" Height="49px" TextMode="MultiLine" Width="381px"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </center>
                    </ContentTemplate>
                    <Triggers>
                        <%--<asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />--%>
                        <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
        </asp:Panel>
    </div>
    <br />
    <center>
        <asp:LinkButton ID="Button11" runat="server" Font-Bold="true" Font-Underline="true"
            Text="Confirm Bill Generation" OnClientClick="return ValidateData()" OnClick="Button11_Click"></asp:LinkButton>
    </center>
    <br />
    <br />
    <br />
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
    <%-- <asp:Button ID="Button11" runat="server" Text="Submit" OnClientClick="return ValidateData()"
            OnClick="Button11_Click" /></center>--%>
</asp:Content>
