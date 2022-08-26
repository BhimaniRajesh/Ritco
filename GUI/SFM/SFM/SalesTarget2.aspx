<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="SalesTarget2.aspx.cs" Inherits="SFM_SalesTarget2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript">


  
//function calculation(txtAprilVal,txtMayVal,txtJuneVal,txtJulyVal,txtAugVal,txtSeptVal,txtOctVal,txtNovVal,txtDecVal,txtJanVal,txtFebVal,txtMarchVal,txttotalVal)
//  {
//  var totrows="<%=totrows %>"
//  var gndapril = 0;
//  var gndmay = 0;
//  var gndjune= 0;
//  var gndjuly = 0;
//  var gndaug = 0;
//  var gndsept = 0;
//  var gndoct = 0;
//  var gndnov = 0;
//  var gnddec = 0;
//  var gndjan = 0;
//  var gndfeb = 0;
//  var gndmar = 0;
//  var gndtotal = 0;
//  var b = new Boolean();
//  b=false;
////  if (totrows==1)
////	{
//	//debugger
//	
//	        if(isNaN(txtAprilVal.value))
//			{
//						alert("Please Enter Only Number!!!")
//						txtAprilVal.focus();
//						return;
//			}
//			if(txtAprilVal.value<0)
//			{
//						alert("Please Enter Positive Value!!!")
//						txtAprilVal.focus();
//						return;
//			}
//			if(isNaN(txtMayVal.value))
//			{
//						alert("Please Enter Only Number!!!")
//						txtMayVal.focus();
//						return;
//			}
//			if(txtMayVal.value<0)
//			{
//						alert("Please Enter Positive Value!!!")
//						txtMayVal.focus();
//						return;
//			}
//			if(isNaN(txtJuneVal.value))
//			{
//						alert("Please Enter Only Number!!!")
//						txtJuneVal.focus();
//						return;
//			}
//			if(txtJuneVal.value<0)
//			{
//						alert("Please Enter Positive Value!!!")
//						txtJuneVal.focus();
//						return;
//			}
//			if(isNaN(txtJulyVal.value))
//			{
//						alert("Please Enter Only Number!!!")
//						txtJulyVal.focus();
//						return;
//			}
//			if(txtJulyVal.value<0)
//			{
//						alert("Please Enter Positive Value!!!")
//						txtJulyVal.focus();
//						return;
//			}
//			if(isNaN(txtAugVal.value))
//			{
//						alert("Please Enter Only Number!!!")
//						txtAugVal.focus();
//						return;
//			}
//			if(txtAugVal.value<0)
//			{
//						alert("Please Enter Positive Value!!!")
//						txtAugVal.focus();
//						return;
//			}
//			if(isNaN(txtSeptVal.value))
//			{
//						alert("Please Enter Only Number!!!")
//						txtSeptVal.focus();
//						return;
//			}
//			if(txtSeptVal.value<0)
//			{
//						alert("Please Enter Positive Value!!!")
//						txtSeptVal.focus();
//						return;
//			}
//			if(isNaN(txtOctVal.value))
//			{
//						alert("Please Enter Only Number!!!")
//						txtOctVal.focus();
//						return;
//			}
//			if(txtOctVal.value<0)
//			{
//						alert("Please Enter Positive Value!!!")
//						txtOctVal.focus();
//						return;
//			}
//			if(isNaN(txtNovVal.value))
//			{
//						alert("Please Enter Only Number!!!")
//						txtNovVal.focus();
//						return;
//			}
//			if(txtNovVal.value<0)
//			{
//						alert("Please Enter Positive Value!!!")
//						txtNovVal.focus();
//						return;
//			}
//			if(isNaN(txtDecVal.value))
//			{
//						alert("Please Enter Only Number!!!")
//						txtDecVal.focus();
//						return;
//			}
//			if(txtDecVal.value<0)
//			{
//						alert("Please Enter Positive Value!!!")
//						txtDecVal.focus();
//						return;
//			}
//			if(isNaN(txtJanVal.value))
//			{
//						alert("Please Enter Only Number!!!")
//						txtJanVal.focus();
//						return;
//			}
//			if(txtJanVal.value<0)
//			{
//						alert("Please Enter Positive Value!!!")
//						txtJanVal.focus();
//						return;
//			}
//			if(isNaN(txtFebVal.value))
//			{
//						alert("Please Enter Only Number!!!")
//						txtFebVal.focus();
//						return;
//			}
//			if(txtFebVal.value<0)
//			{
//						alert("Please Enter Positive Value!!!")
//						txtFebVal.focus();
//						return;
//			}
//			if(isNaN(txtMarchVal.value))
//			{
//						alert("Please Enter Only Number!!!")
//						txtMarchVal.focus();
//						return;
//			}
//			if(txtMarchVal.value<0)
//			{
//						alert("Please Enter Positive Value!!!")
//						txtMarchVal.focus();
//						return;
//			}
//	
//        varapril=parseFloat(txtAprilVal.value)
//        varmay=parseFloat(txtMayVal.value)
//        varjune=parseFloat(txtJuneVal.value)
//        varjuly=parseFloat(txtJulyVal.value)
//        varaug=parseFloat(txtAugVal.value)
//        varsept=parseFloat(txtSeptVal.value)
//        varoct=parseFloat(txtOctVal.value)
//        varnov=parseFloat(txtNovVal.value)
//        vardec=parseFloat(txtDecVal.value)
//        varjan=parseFloat(txtJanVal.value)
//        varfeb=parseFloat(txtFebVal.value)
//        varmarch=parseFloat(txtMarchVal.value)
//        vartotal=parseFloat(txttotalVal.value)
//        
//       // +=varapril
//        vartotal = parseInt(varapril)+parseInt(varmay)+parseInt(varjune)+parseInt(varjuly)+parseInt(varaug)+parseInt(varsept)+parseInt(varoct)+parseInt(varnov)+parseInt(vardec)+parseInt(varjan)+parseInt(varfeb)+parseInt(varmarch)
//        txttotalVal.value = vartotal;
//        
//      
//        
//        var rows = document.getElementById("ctl00_MyCPH1_MonthlyData").rows.length;
//        var sum = 0;
///*if(rows>9)
//{*/
////var abc = (document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows))
////alert(abc)
//debugger
//if (b==false)
//{
//b=true;
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooApriltot").value = Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooApriltot").value) + Number(txtAprilVal.value);
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooMaytot").value = Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooMaytot").value) + Number(txtMayVal.value);
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooJunetot").value = Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooJunetot").value) + Number(txtJuneVal.value);
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooJulytot").value = Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooJulytot").value) + Number(txtJulyVal.value);
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooAugtot").value = Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooAugtot").value) + Number(txtAugVal.value);
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooSepttot").value = Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooSepttot").value) + Number(txtSeptVal.value);
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooOcttot").value = Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooOcttot").value) + Number(txtOctVal.value);
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooNovtot").value = Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooNovtot").value) + Number(txtNovVal.value);
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooDectot").value = Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooDectot").value) + Number(txtDecVal.value);
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooJantot").value = Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooJantot").value) + Number(txtJanVal.value);
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooFebtot").value = Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooFebtot").value) + Number(txtFebVal.value);
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooMarchtot").value = Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl" + (rows > 9 ? "" : "0" + rows) + "_FooMarchtot").value) + Number(txtMarchVal.value);
//}
///*}
//else
//{
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooApriltot").value =Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooApriltot").value)  + Number(txtAprilVal.value);
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooMaytot").value = Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooMaytot").value) + Number(txtMayVal.value);
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooJunetot").value = Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooJunetot").value) + Number(txtJuneVal.value);
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooJulytot").value = Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooJulytot").value) + Number(txtJulyVal.value);
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooAugtot").value = Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooAugtot").value) + Number(txtAugVal.value);
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooSepttot").value = Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooSepttot").value) + Number(txtSeptVal.value);
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooOcttot").value = Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooOcttot").value) + Number(txtOctVal.value);
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooNovtot").value = Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooNovtot").value) + Number(txtNovtVal.value);
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooDectot").value = Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooDectot").value) + Number(txtDecVal.value);
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooJantot").value = Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooJantot").value) + Number(txtJanVal.value);
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooFebtot").value = Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooFebtot").value) + Number(txtFebVal.value);
//document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooMarchtot").value = Number(document.getElementById("ctl00_MyCPH1_MonthlyData_ctl0" + rows + "_FooMarchtot").value) + Number(txtMarchVal.value);
//}*/


//        


//  }
//  
//  
//  
//  function totalcount(txtAprilVal,txtMayVal,txtJuneVal,txtJulyVal,txtAugVal,txtSeptVal,txtOctVal,txtNovVal,txtDecVal,txtJanVal,txtFebVal,txtMarchVal,txttotalVal)
//  {
//  
//  }
//  
//  function calculationQ(txtQuater1,txtQuater2,txtQuater3,txtQuater4,txttotalVal1)
//  {
//  var totrowsQ="<%=totrowsQ %>"
//  var gndQuater1 = 0;
//  var gndQuater2 = 0;
//  var gndQuater3= 0;
//  var gndQuater4 = 0;
//  
//  var gndtotal1 = 0;
//  
////  if (totrows==1)
////	{
//	//debugger
//	
//	        if(isNaN(txtQuater1.value))
//			{
//						alert("Please Enter Only Number!!!")
//						txtQuater1.focus();
//						return;
//			}
//			if(txtQuater1.value<0)
//			{
//						alert("Please Enter Positive Value!!!")
//						txtQuater1.focus();
//						return;
//			}
//			if(isNaN(txtQuater2.value))
//			{
//						alert("Please Enter Only Number!!!")
//						txtQuater2.focus();
//						return;
//			}
//			if(txtQuater2.value<0)
//			{
//						alert("Please Enter Positive Value!!!")
//						txtQuater2.focus();
//						return;
//			}
//			if(isNaN(txtQuater3.value))
//			{
//						alert("Please Enter Only Number!!!")
//						txtQuater3.focus();
//						return;
//			}
//			if(txtQuater3.value<0)
//			{
//						alert("Please Enter Positive Value!!!")
//						txtQuater3.focus();
//						return;
//			}
//			if(isNaN(txtQuater4.value))
//			{
//						alert("Please Enter Only Number!!!")
//						txtQuater4.focus();
//						return;
//			}
//			if(txtQuater4.value<0)
//			{
//						alert("Please Enter Positive Value!!!")
//						txtQuater4.focus();
//						return;
//			}
//			
//	
//        varQuater1=parseFloat(txtQuater1.value)
//        varQuater2=parseFloat(txtQuater2.value)
//        varQuater3=parseFloat(txtQuater3.value)
//        varQuater4=parseFloat(txtQuater4.value)
//        
//        vartotal1=parseFloat(txttotalVal1.value)
//        
//        
//        vartotal1 = parseInt(varQuater1)+parseInt(varQuater2)+parseInt(varQuater3)+parseInt(varQuater4)
//        txttotalVal1.value = vartotal1;

//  }
//  
//  function totalcountQ()
//  {
//  
//  }
//  
//  function calculationY(txtYear,txttotalVal2)
//  {
//  var totrowsY="<%=totrowsY %>"
//  var gndYear = 0;
//    
//  var gndtotal2 = 0;
//	
//	        if(isNaN(txtYear.value))
//			{
//						alert("Please Enter Only Number!!!")
//						txtYear.focus();
//						return;
//			}
//			if(txtYear.value<0)
//			{
//						alert("Please Enter Positive Value!!!")
//						txtYear.focus();
//						return;
//			}
//			
//			
//	
//        varYear=parseFloat(txtYear.value)
//        
//        
//        vartotal2=parseFloat(txttotalVal2.value)
//        
//        
//        vartotal2 = parseInt(varYear)
//        txttotalVal2.value = vartotal2;

//  }
//  
//  function totalcountY()
//  {
//  
//  }
function AddNo(txt,tot)
{
var bl = new Boolean()
bl = false
var rows = document.getElementById("ctl00_MyCPH1_MonthlyData").rows.length;
var sum = 0;
if(rows>9)
{
tot="ctl00_MyCPH1_MonthlyData_ctl" + rows + tot;
}
else
{
tot="ctl00_MyCPH1_MonthlyData_ctl0" + rows + tot;
}
for(i=0 ;i<rows-2;i++)
{		
j = i+2
if(j>9)
{
var id = "ctl00_MyCPH1_MonthlyData_ctl" + j + txt
}
else
{
var id = "ctl00_MyCPH1_MonthlyData_ctl0" + j + txt
}
 var val = document.getElementById(id).value
 if(val == "")
 {
 }
 else
 {
 bl = true;
}
}
if (bl == false)
{
 return false
 }
for(i=0 ;i<rows-2;i++)
{
j = i+2
if(j>9)
{
var id = "ctl00_MyCPH1_MonthlyData_ctl" + j + txt
}
else
{
var id = "ctl00_MyCPH1_MonthlyData_ctl0" + j + txt
}
 var val = document.getElementById(id).value
 if(Number(val) >= 0 )
 {
 }
  else
  {
 document.getElementById(id).focus();
 return false;
  }
 sum = sum + Number(val)
}
    document.getElementById(tot).innerText = sum;        
}

 function AddRowNo(txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10,txt11,txt12,txt13)//,txt5,txt6,txt7,txt11,txt12,txt13)
 {
 var val1 = document.getElementById(txt1).value;
 var val2= document.getElementById(txt2).value;
 var val3= document.getElementById(txt3).value;
 var val4= document.getElementById(txt4).value;
 var val5= document.getElementById(txt5).value;
 var val6= document.getElementById(txt6).value;
 var val7= document.getElementById(txt7).value;
 var val8= document.getElementById(txt8).value;
 var val9= document.getElementById(txt9).value;
 var val10= document.getElementById(txt10).value;
 var val11= document.getElementById(txt11).value;
 var val12= document.getElementById(txt12).value;
 
 if(val1 == "" && val2 == "" && val3 == "" && val4 == "" && val5 == "" && val6 == "" && val7 == "" && val8 == "" && val9 == "" && val10 == "" && val11 == "" && val12 == "") return false //val11 == "" && && val12 == "") return false
 
 if(isNaN(val1))
 {
 alert("Please Enter Only Number")
 document.getElementById(txt1).focus();
 return false;
 }
 if(isNaN(val2))
 {
    alert("Please Enter Only Number")
    document.getElementById(txt2).focus();
    return false;
  }
 if(isNaN(val3))
 {
    alert("Please Enter Only Number")
    document.getElementById(txt3).focus();
    return false;
  }
 if(isNaN(val4))
 {
    alert("Please Enter Only Number")
    document.getElementById(txt4).focus();
    return false;
  }
 if(isNaN(val5))
 {
    alert("Please Enter Only Number")
    document.getElementById(txt5).focus();
    return false;
  }
  if(isNaN(val6))
 {
    alert("Please Enter Only Number")
    document.getElementById(txt6).focus();
    return false;
  }
  if(isNaN(val7))
 {
    alert("Please Enter Only Number")
    document.getElementById(txt7).focus();
    return false;
  }
  if(isNaN(val8))
 {
    alert("Please Enter Only Number")
    document.getElementById(txt8).focus();
    return false;
  }
 if(isNaN(val9))
 {
    alert("Please Enter Only Number")
    document.getElementById(txt9).focus();
    return false;
  }
  if(isNaN(val10))
 {
    alert("Please Enter Only Number")
    document.getElementById(txt10).focus();
    return false;
  }
  if(isNaN(val11))
 {
    alert("Please Enter Only Number")
    document.getElementById(txt11).focus();
    return false;
  }
 if(isNaN(val12))
 {
    alert("Please Enter Only Number")
    document.getElementById(txt12).focus();
    return false;
  }
 
 
 
 
 
 
 if(Number(val1) < 0 )
 {
    alert("Please Enter Positive Value")
    document.getElementById(txt1).focus();
    return false;
  }
  
  if(Number(val2) < 0 )
 {
    alert("Please Enter Positive Value")
    document.getElementById(txt2).focus();
    return false;
  }
  if(Number(val3) < 0 )
 {
    alert("Please Enter Positive Value")
    document.getElementById(txt3).focus();
    return false;
  }
  if(Number(val4) < 0 )
 {
    alert("Please Enter Positive Value")
    document.getElementById(txt4).focus();
    return false;
  }
  if(Number(val5) < 0 )
 {
    alert("Please Enter Positive Value")
    document.getElementById(txt5).focus();
    return false;
  }
  if(Number(val6) < 0 )
 {
    alert("Please Enter Positive Value")
    document.getElementById(txt6).focus();
    return false;
  }
  if(Number(val7) < 0 )
 {
    alert("Please Enter Positive Value")
    document.getElementById(txt7).focus();
    return false;
  }
  if(Number(val8) < 0 )
 {
    alert("Please Enter Positive Value")
    document.getElementById(txt8).focus();
    return false;
  }
  if(Number(val9) < 0 )
 {
    alert("Please Enter Positive Value")
    document.getElementById(txt9).focus();
    return false;
  }
  if(Number(val10) < 0 )
 {
    alert("Please Enter Positive Value")
    document.getElementById(txt10).focus();
    return false;
  }
  if(Number(val11) < 0 )
 {
    alert("Please Enter Positive Value")
    document.getElementById(txt11).focus();
    return false;
  }
 if(Number(val12) < 0 )
 {
    alert("Please Enter Positive Value")
    document.getElementById(txt12).focus();
    return false;
  }
 document.getElementById(txt13).value = Number(val1) + Number(val2) + Number(val3) + Number(val4) + Number(val5) + Number(val6) + Number(val7) + Number(val8) + Number(val9) + Number(val10) + Number(val11) + Number(val12)
 
 }
 
 
 
 function AddNoQ(txt,tot)
{
var bl = new Boolean()
bl = false
var rows = document.getElementById("ctl00_MyCPH1_QuaterlyData").rows.length;
var sum = 0;
if(rows>9)
{
tot="ctl00_MyCPH1_QuaterlyData_ctl" + rows + tot;
}
else
{
tot="ctl00_MyCPH1_QuaterlyData_ctl0" + rows + tot;
}
for(i=0 ;i<rows-2;i++)
{		
j = i+2
if(j>9)
{
var id = "ctl00_MyCPH1_QuaterlyData_ctl" + j + txt
}
else
{
var id = "ctl00_MyCPH1_QuaterlyData_ctl0" + j + txt
}
 var val = document.getElementById(id).value
 if(val == "")
 {
 }
 else
 {
 bl = true;
}
}
if (bl == false)
{
 return false
 }
for(i=0 ;i<rows-2;i++)
{
j = i+2
if(j>9)
{
var id = "ctl00_MyCPH1_QuaterlyData_ctl" + j + txt
}
else
{
var id = "ctl00_MyCPH1_QuaterlyData_ctl0" + j + txt
}
 var val = document.getElementById(id).value
 if(Number(val) >= 0 )
 {
 }
  else
  {
 document.getElementById(id).focus();
 return false;
  }
 sum = sum + Number(val)
}
    document.getElementById(tot).innerText = sum;        
}

 function AddRowNoQ(txt1,txt2,txt3,txt4,txttot)
 {
 var val1 = document.getElementById(txt1).value;
 var val2= document.getElementById(txt2).value;
 var val3= document.getElementById(txt3).value;
 var val4= document.getElementById(txt4).value;
 
 
 if(val1 == "" && val2 == "" && val3 == "" && val4 == "" ) return false 
 
 if(isNaN(val1))
 {
 alert("Please Enter Only Number")
 document.getElementById(txt1).focus();
 return false;
 }
 if(isNaN(val2))
 {
    alert("Please Enter Only Number")
    document.getElementById(txt2).focus();
    return false;
  }
 if(isNaN(val3))
 {
    alert("Please Enter Only Number")
    document.getElementById(txt3).focus();
    return false;
  }
 if(isNaN(val4))
 {
    alert("Please Enter Only Number")
    document.getElementById(txt4).focus();
    return false;
  }
 
 
 if(Number(val1) < 0 )
 {
    alert("Please Enter Positive Value")
    document.getElementById(txt1).focus();
    return false;
  }
  
  if(Number(val2) < 0 )
 {
    alert("Please Enter Positive Value")
    document.getElementById(txt2).focus();
    return false;
  }
  if(Number(val3) < 0 )
 {
    alert("Please Enter Positive Value")
    document.getElementById(txt3).focus();
    return false;
  }
  if(Number(val4) < 0 )
 {
    alert("Please Enter Positive Value")
    document.getElementById(txt4).focus();
    return false;
  }
 
 document.getElementById(txttot).value = Number(val1) + Number(val2) + Number(val3) + Number(val4)
 
 }
 
 
 
 function AddNoY(txt,tot)
{
var bl = new Boolean()
bl = false
var rows = document.getElementById("ctl00_MyCPH1_YearlyData").rows.length;
var sum = 0;
if(rows>9)
{
tot="ctl00_MyCPH1_YearlyData_ctl" + rows + tot;
}
else
{
tot="ctl00_MyCPH1_YearlyData_ctl0" + rows + tot;
}
for(i=0 ;i<rows-2;i++)
{		
j = i+2
if(j>9)
{
var id = "ctl00_MyCPH1_YearlyData_ctl" + j + txt
}
else
{
var id = "ctl00_MyCPH1_YearlyData_ctl0" + j + txt
}
 var val = document.getElementById(id).value
 if(val == "")
 {
 }
 else
 {
 bl = true;
}
}
if (bl == false)
{
 return false
 }
for(i=0 ;i<rows-2;i++)
{
j = i+2
if(j>9)
{
var id = "ctl00_MyCPH1_YearlyData_ctl" + j + txt
}
else
{
var id = "ctl00_MyCPH1_YearlyData_ctl0" + j + txt
}
 var val = document.getElementById(id).value
 if(Number(val) >= 0 )
 {
 }
  else
  {
 document.getElementById(id).focus();
 return false;
  }
 sum = sum + Number(val)
}
    document.getElementById(tot).innerText = sum;        
}

 function AddRowNoY(txt1,txttot)
 {
 var val1 = document.getElementById(txt1).value;
 
 if(val1 == "") return false 
 
 if(isNaN(val1))
 {
 alert("Please Enter Only Number")
 document.getElementById(txt1).focus();
 return false;
 }
 
 if(Number(val1) < 0 )
 {
    alert("Please Enter Positive Value")
    document.getElementById(txt1).focus();
    return false;
  }
  
 
 document.getElementById(txttot).value = Number(val1)
 
 }
 
 
</script>

<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="Label1" runat="server" Text="Sale Target Entry" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        </table>
        <br />
        
         <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td align="right">
                        <a href="javascript:window.history.go(-1)" title="back">
                        <img border="0" src="../images/back.gif" /></a>
                    </td>
                </tr>
            </table>
            <br />
        
    <div align="left">
    
    <table border="0" cellpadding="3" cols="1" width="50%" bgcolor="#808080" cellspacing="1" class="boxbg">
      
      
       <%--<tr bgcolor="#ffffff"> 
        <td style="width: 242px; height: 25px;"> <div>
         <font class="blackfnt">Sales Person</font></div>
        </td>
        <td   align="center" style="height: 25px"> 
          <div align="left"><font class="blackfnt">
              <asp:Label ID="lblSalePerson" runat="server" Text="Label"></asp:Label></font></div>
        </td>
       </tr>--%>
       
       <tr bgcolor="#ffffff"> 
        <td style="width: 242px"> 
         <div><font class="blackfnt">Industry</font></div>
        </td>
        <td   align="center"> 
          <div align="left"><font class="blackfnt">
              <asp:Label ID="lblIndustry" runat="server" Text="Label"></asp:Label></font></div>
        </td>
       </tr>
       
       <tr bgcolor="#ffffff"> 
        <td style="width: 242px"> 
         <div><font class="blackfnt">Customer/Prospect</font></div>
        </td>
        <td   align="center"> 
          <div align="left"><font class="blackfnt">
              <asp:Label ID="lblProspectId" runat="server" Text="Label"></asp:Label></font></div>
        </td>
       </tr>
       
       <tr bgcolor="#ffffff"> 
        <td style="width: 242px"> 
         <div><font class="blackfnt">Financial Year</font></div>
        </td>
        <td   align="center"> 
          <div align="left"><font class="blackfnt">
              <asp:Label ID="lblYear" runat="server" Text="Label"></asp:Label></font></div>
        </td>
       </tr>
       
       <%--<tr bgcolor="#ffffff"> 
        <td> <div>
         <font class="blackfnt">Status</font></div>
        </td>
        <td   align="center"> 
          <div align="left"><font class="blackfnt">
              <asp:Label ID="lblStatus" runat="server" Text="Label"></asp:Label></font></div>
        </td>
       </tr>--%>
       
       <tr bgcolor="#ffffff">
        <td style="width: 242px">
         <div><font class="blackfnt">Period</font></div>
        </td>
        <td   align="center"> 
          <div align="left"><font class="blackfnt">
              <asp:Label ID="lblPeriod" runat="server" Text="Label"></asp:Label></font></div>
        </td>
       </tr>
        </table> 
 
  <br />
    
    </div>

<div align="center">


            <asp:UpdatePanel ID="UpdatePanel4" RenderMode="Inline"    UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
            
            <asp:GridView align="center" ID="MonthlyData" Width="90%" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
            AllowSorting="true" AllowPaging="false"  PagerStyle-HorizontalAlign="left"
            CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"
            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" ShowFooter="true" 
            EmptyDataText="No Records Found..." Visible="false" OnRowCreated="MonthlyData_RowCreated">
 
            <Columns >
                <asp:TemplateField HeaderText="SRNo." >
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" />
                <ItemTemplate>
                <asp:Label ID="lblSRNo" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                </asp:Label>
                </ItemTemplate>
                </asp:TemplateField>


                <asp:TemplateField>
                <HeaderTemplate >
                              <asp:Label ID="ProspectId" CssClass="blackfnt" Text="Prospect/CustomerID" runat="server"></asp:Label>
                              </HeaderTemplate>
                <ItemTemplate>
                <asp:Label ID="lblProspectId" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"ProspectCode")+":"+DataBinder.Eval(Container.DataItem,"companyName") %>'></asp:Label>  
                </ItemTemplate> 
                </asp:TemplateField> 

                <asp:TemplateField>
                <HeaderTemplate >
                              <asp:Label ID="Status" CssClass="blackfnt" Text="Prospect Status" runat="server"></asp:Label>
                              </HeaderTemplate>
                <ItemTemplate>
                <asp:Label ID="lblStatus" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"AcctCategory") %>'></asp:Label>  
                </ItemTemplate> 
                <FooterTemplate>
                <asp:Label ID="lbltot" Text="Total" runat="server" Font-Bold="true"></asp:Label>  
                </FooterTemplate> 
                </asp:TemplateField> 

                <asp:TemplateField>
                              <HeaderTemplate >
                              <asp:Label ID="April" CssClass="blackfnt" Text="April" runat="server"></asp:Label>
                              </HeaderTemplate>
                                <ItemTemplate>
                                    <center>
                                    
                                              <asp:TextBox ID ="txtAprilVal" runat="server" MaxLength="10" Columns="12" Width="40px" Text="0" ></asp:TextBox>
                                              
                                    </center>
                                </ItemTemplate>
                                <FooterTemplate>
                                <asp:TextBox ID="FooApriltot" Text="0" runat="server" Width="40px" ReadOnly="true"></asp:TextBox>
                                </FooterTemplate> 
                                
                 </asp:TemplateField>
                 <asp:TemplateField>
                              <HeaderTemplate >
                              <asp:Label ID="May" CssClass="blackfnt" Text="May" runat="server"></asp:Label>
                              
                              </HeaderTemplate>
                                <ItemTemplate>
                                    <center>
                                              <asp:TextBox  ID ="txtMayVal" MaxLength="10" Columns="12"  runat="server"  Width="40px" Text="0"></asp:TextBox>
                                              
                                    </center>
                                </ItemTemplate>
                                 <FooterTemplate>
                                <asp:TextBox ID="FooMaytot" Text="0" runat="server" Width="40px" ReadOnly="true"></asp:TextBox>
                                </FooterTemplate> 
                 </asp:TemplateField>
                 <asp:TemplateField>
                              <HeaderTemplate >
                              <asp:Label ID="June" CssClass="blackfnt" Text="June" runat="server"></asp:Label>
                              </HeaderTemplate>
                                <ItemTemplate>
                                    <center>
                                              <asp:TextBox  ID ="txtJuneVal" MaxLength="10" Columns="12"  runat="server"  Width="40px" Text="0"></asp:TextBox>
                                    </center>
                                </ItemTemplate>
                                 <FooterTemplate>
                                <asp:TextBox ID="FooJunetot" Text="0" runat="server" Width="40px" ReadOnly="true"></asp:TextBox>
                                </FooterTemplate> 
                 </asp:TemplateField>
                 <asp:TemplateField>
                              <HeaderTemplate >
                              <asp:Label ID="July" CssClass="blackfnt" Text="July" runat="server"></asp:Label>
                              </HeaderTemplate>
                                <ItemTemplate>
                                    <center>
                                              <asp:TextBox  ID ="txtJulyVal" MaxLength="10" Columns="12"  runat="server"  Width="40px" Text="0"></asp:TextBox>
                                    </center>
                                </ItemTemplate>
                                 <FooterTemplate>
                                <asp:TextBox ID="FooJulytot" Text="0" runat="server" Width="40px" ReadOnly="true"></asp:TextBox>
                                </FooterTemplate> 
                 </asp:TemplateField>
                 <asp:TemplateField>
                              <HeaderTemplate >
                              <asp:Label ID="Aug" CssClass="blackfnt" Text="Aug" runat="server"></asp:Label>
                              </HeaderTemplate>
                                <ItemTemplate>
                                    <center>
                                              <asp:TextBox  ID ="txtAugVal" MaxLength="10" Columns="12" runat="server"  Width="40px" Text="0"></asp:TextBox>
                    </center>
                </ItemTemplate>
                 <FooterTemplate>
                                <asp:TextBox ID="FooAugtot" Text="0" runat="server" Width="40px" ReadOnly="true"></asp:TextBox>
                                </FooterTemplate> 
 </asp:TemplateField>

 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="Sept" CssClass="blackfnt" Text="Sept" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                <center>
                              <asp:TextBox  ID ="txtSeptVal" MaxLength="10" Columns="12" runat="server"  Width="40px" Text="0"></asp:TextBox>
                    </center>
                </ItemTemplate>
                 <FooterTemplate>
                                <asp:TextBox ID="FooSepttot" Text="0" runat="server" Width="40px" ReadOnly="true"></asp:TextBox>
                                </FooterTemplate> 
 </asp:TemplateField>
<asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="Oct" CssClass="blackfnt" Text="Oct" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="txtOctVal" MaxLength="10" Columns="12" runat="server"  Width="40px" Text="0"></asp:TextBox>
                    </center>
                </ItemTemplate>
                 <FooterTemplate>
                                <asp:TextBox ID="FooOcttot" Text="0" runat="server" Width="40px" ReadOnly="true"></asp:TextBox>
                                </FooterTemplate> 
 </asp:TemplateField>
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="Nov" CssClass="blackfnt" Text="Nov" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="txtNovVal" MaxLength="10" Columns="12"   runat="server"  Width="40px" Text="0"></asp:TextBox>
                    </center>
                </ItemTemplate>
                 <FooterTemplate>
                                <asp:TextBox ID="FooNovtot" Text="0" runat="server" Width="40px" ReadOnly="true"></asp:TextBox>
                                </FooterTemplate> 
 </asp:TemplateField>
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="Dec" CssClass="blackfnt" Text="Dec" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="txtDecVal" MaxLength="10" Columns="12"   runat="server"  Width="40px" Text="0"></asp:TextBox>
                    </center>
                </ItemTemplate>
                 <FooterTemplate>
                                <asp:TextBox ID="FooDectot" Text="0" runat="server" Width="40px" ReadOnly="true"></asp:TextBox>
                                </FooterTemplate> 
 </asp:TemplateField>
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="Jan" CssClass="blackfnt" Text="Jan" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="txtJanVal" MaxLength="10" Columns="12"   runat="server"  Width="40px" Text="0"></asp:TextBox>
                    </center>
                </ItemTemplate>
                 <FooterTemplate>
                                <asp:TextBox ID="FooJantot" Text="0" runat="server" Width="40px" ReadOnly="true"></asp:TextBox>
                                </FooterTemplate> 
 </asp:TemplateField>
 
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="Feb" CssClass="blackfnt" Text="Feb" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="txtFebVal" MaxLength="10" Columns="12"  runat="server"  Width="40px" Text="0"></asp:TextBox>
                    </center>
                </ItemTemplate>
                 <FooterTemplate>
                                <asp:TextBox ID="FooFebtot" Text="0" runat="server" Width="40px" ReadOnly="true"></asp:TextBox>
                                </FooterTemplate> 
 </asp:TemplateField>
 
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="March" CssClass="blackfnt" Text="March" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="txtMarchVal" MaxLength="10" Columns="12"  runat="server"  Width="40px" Text="0"></asp:TextBox>
                    </center>
                </ItemTemplate>
                 <FooterTemplate>
                 <asp:TextBox ID="FooMarchtot" Text="0" runat="server" Width="40px" ReadOnly="true"></asp:TextBox>
                 </FooterTemplate> 
 </asp:TemplateField>
 
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="total" CssClass="blackfnt" Text="Total" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="txttotalVal" MaxLength="10" Columns="12"   runat="server"  Width="60px" Text="0" ></asp:TextBox>
                    </center>
                </ItemTemplate>
                 <%--<FooterTemplate>
                                <asp:TextBox ID="FooTOTtot" Text="0" runat="server" Width="60px" ReadOnly="true"></asp:TextBox>
                                </FooterTemplate> --%>
 </asp:TemplateField>


</Columns>
<PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
<HeaderStyle CssClass="bgbluegrey" />
<PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
/>
<FooterStyle CssClass="boxbg" />
                
</asp:GridView>
         </ContentTemplate>
         
         </asp:UpdatePanel>   
         
         
         <asp:UpdatePanel ID="UpdatePanel1" RenderMode="Inline"   UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
            
            <asp:GridView align="center" ID="QuaterlyData" Width="90%" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
            AllowSorting="true" AllowPaging="false" PagerStyle-HorizontalAlign="left"
            CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"
            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" ShowFooter="true" 
            EmptyDataText="No Records Found..." Visible="false" OnRowCreated="QuaterlyData_RowCreated">
 
            <Columns >
                <asp:TemplateField HeaderText="SRNo." >
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" />
                <ItemTemplate>
                <asp:Label ID="lblSRNo1" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                </asp:Label>
                </ItemTemplate>
                </asp:TemplateField>


                <asp:TemplateField>
                <HeaderTemplate >
                              <asp:Label ID="ProspectId1" CssClass="blackfnt" Text="Prospect/CustomerID" runat="server"></asp:Label>
                              </HeaderTemplate>
                <ItemTemplate>
                <asp:Label ID="lblProspectId1" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"ProspectCode")+":"+DataBinder.Eval(Container.DataItem,"companyName") %>'></asp:Label>  
                </ItemTemplate> 
                </asp:TemplateField> 

                <asp:TemplateField>
                <HeaderTemplate >
                              <asp:Label ID="Status1" CssClass="blackfnt" Text="Prospect Status" runat="server"></asp:Label>
                              </HeaderTemplate>
                <ItemTemplate>
                <asp:Label ID="lblStatus1" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"AcctCategory") %>'></asp:Label>  
                </ItemTemplate> 
                <FooterTemplate>
                <asp:Label ID="lbltot1" Text="Total" runat="server" Font-Bold="true"></asp:Label>  
                </FooterTemplate> 
                </asp:TemplateField> 

                <asp:TemplateField>
                              <HeaderTemplate >
                              <asp:Label ID="Quarter1" CssClass="blackfnt" Text="QuarterI" runat="server"></asp:Label>
                              </HeaderTemplate>
                                <ItemTemplate>
                                    <center>
                                    
                                              <asp:TextBox ID ="txtQuater1" runat="server" MaxLength="10" Columns="12" Width="40px" Text="0" ></asp:TextBox>
                                              
                                    </center>
                                </ItemTemplate>
                                <FooterTemplate>
                                 <asp:TextBox ID="FooQuarter1" Text="0" runat="server" Width="40px"></asp:TextBox>
                                 </FooterTemplate> 
                 </asp:TemplateField>
                 <asp:TemplateField>
                              <HeaderTemplate >
                              <asp:Label ID="Quarter2" CssClass="blackfnt" Text="QuarterII" runat="server"></asp:Label>
                              
                              </HeaderTemplate>
                                <ItemTemplate>
                                    <center>
                                              <asp:TextBox  ID ="txtQuater2" MaxLength="10" Columns="12"  runat="server"  Width="40px" Text="0"></asp:TextBox>
                                              
                                    </center>
                                </ItemTemplate>
                                <FooterTemplate>
                                 <asp:TextBox ID="FooQuarter2" Text="0" runat="server" Width="40px"></asp:TextBox>
                                 </FooterTemplate> 
                 </asp:TemplateField>
                 <asp:TemplateField>
                              <HeaderTemplate >
                              <asp:Label ID="Quarter3" CssClass="blackfnt" Text="QuarterIII" runat="server"></asp:Label>
                              </HeaderTemplate>
                                <ItemTemplate>
                                    <center>
                                              <asp:TextBox  ID ="txtQuater3" MaxLength="10" Columns="12"  runat="server"  Width="40px" Text="0"></asp:TextBox>
                                    </center>
                                </ItemTemplate>
                                <FooterTemplate>
                                 <asp:TextBox ID="FooQuarter3" Text="0" runat="server" Width="40px"></asp:TextBox>
                                 </FooterTemplate> 
                 </asp:TemplateField>
                 <asp:TemplateField>
                              <HeaderTemplate >
                              <asp:Label ID="Quarter4" CssClass="blackfnt" Text="QuarterIV" runat="server"></asp:Label>
                              </HeaderTemplate>
                                <ItemTemplate>
                                    <center>
                                              <asp:TextBox  ID ="txtQuater4" MaxLength="10" Columns="12"  runat="server"  Width="40px" Text="0"></asp:TextBox>
                                    </center>
                                </ItemTemplate>
                                <FooterTemplate>
                                 <asp:TextBox ID="FooQuarter4" Text="0" runat="server" Width="40px"></asp:TextBox>
                                 </FooterTemplate> 
                 </asp:TemplateField>
                 
 
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="total1" CssClass="blackfnt" Text="Total" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="txttotalVal1" MaxLength="10" Columns="12"   runat="server"  Width="60px" Text="0"></asp:TextBox>
                    </center>
                </ItemTemplate>
                <%--<FooterTemplate>
                <asp:TextBox ID="FooTotaltot" Text="0" runat="server" Width="60px"></asp:TextBox>
                </FooterTemplate> --%>
 </asp:TemplateField>


</Columns>
<PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
<HeaderStyle CssClass="bgbluegrey" />
<PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
/>
<FooterStyle CssClass="boxbg" />
                
</asp:GridView>
         </ContentTemplate>
         
         </asp:UpdatePanel>  
         
         
         <asp:UpdatePanel ID="UpdatePanel2" RenderMode="Inline"  UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
            
            <asp:GridView align="center" ID="YearlyData" Width="90%" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
            AllowSorting="true" AllowPaging="false" PageSize="10" PagerStyle-HorizontalAlign="left"
            CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"
            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" ShowFooter="true" 
            EmptyDataText="No Records Found..." Visible="false" OnRowCreated="YearlyData_RowCreated">
 
            <Columns >
                <asp:TemplateField HeaderText="SRNo." >
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" />
                <ItemTemplate>
                <asp:Label ID="lblSRNo2" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                </asp:Label>
                </ItemTemplate>
                </asp:TemplateField>


                <asp:TemplateField>
                <HeaderTemplate >
                              <asp:Label ID="ProspectId2" CssClass="blackfnt" Text="Prospect/CustomerID" runat="server"></asp:Label>
                              </HeaderTemplate>
                <ItemTemplate>
                <asp:Label ID="lblProspectId2" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"ProspectCode")+":"+DataBinder.Eval(Container.DataItem,"companyName") %>'></asp:Label>  
                </ItemTemplate> 
                </asp:TemplateField> 

                <asp:TemplateField>
                <HeaderTemplate >
                              <asp:Label ID="Status2" CssClass="blackfnt" Text="Prospect Status" runat="server"></asp:Label>
                              </HeaderTemplate>
                <ItemTemplate>
                <asp:Label ID="lblStatus2" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"AcctCategory") %>'></asp:Label>  
                </ItemTemplate> 
                <FooterTemplate>
                <asp:Label ID="lbltot2" Text="Total" runat="server" Font-Bold="true"></asp:Label>  
                </FooterTemplate> 
                </asp:TemplateField> 

                <asp:TemplateField>
                              <HeaderTemplate >
                              <asp:Label ID="Year1" CssClass="blackfnt" Text="Year" runat="server"></asp:Label>
                              </HeaderTemplate>
                                <ItemTemplate>
                                    <center>
                                    
                                              <asp:TextBox ID ="txtYear" runat="server" MaxLength="10" Columns="12" Width="40px" Text="0" ></asp:TextBox>
                                              
                                    </center>
                                </ItemTemplate>
                                <FooterTemplate>
                                 <asp:TextBox ID="FooYeartot" Text="0" runat="server" Width="40px"></asp:TextBox>
                                 </FooterTemplate> 
                 </asp:TemplateField>
                 
                 
 
 <asp:TemplateField>
              <HeaderTemplate >
              <asp:Label ID="total2" CssClass="blackfnt" Text="Total" runat="server"></asp:Label>
              </HeaderTemplate>
                <ItemTemplate>
                    <center>
                              <asp:TextBox  ID ="txttotalVal2" MaxLength="10" Columns="12"   runat="server"  Width="60px" Text="0"></asp:TextBox>
                    </center>
                </ItemTemplate>
                <%--<FooterTemplate>
                                 <asp:TextBox ID="FooTotalYeartot" Text="0" runat="server" Width="60px"></asp:TextBox>
                                 </FooterTemplate> --%>
 </asp:TemplateField>


</Columns>
<PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
<HeaderStyle CssClass="bgbluegrey" />
<PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
/>
<FooterStyle CssClass="boxbg" />
                
</asp:GridView>
         </ContentTemplate>
         
         </asp:UpdatePanel>  
         
         <br />
         
            <asp:Button ID="btnSubmit" runat="server"  Text="Submit"  OnClick="btnSubmit_Click" Visible="false"/>
            <asp:Button ID="btnQuartly" runat="server"  Text="Submit"  Visible="false" OnClick="btnQuartly_Click"/>
            <asp:Button ID="btnYearly" runat="server"  Text="Submit"  Visible="false" OnClick="btnYearly_Click"/>
            </div>

</asp:Content>

