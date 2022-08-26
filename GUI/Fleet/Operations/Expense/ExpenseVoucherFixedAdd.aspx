<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"    CodeFile="ExpenseVoucherFixedAdd.aspx.cs" Inherits="GUI_Fleet_Operations_Expense_ExpenseVoucherFixedAdd" %>

<%--<%@ Reference Control="~/LED/DateSelector.ascx" %>--%>

<%@Register TagPrefix="SControls" TagName="DateSelector" src="~/LED/DateSelector.ascx" %>
<%@ Register TagPrefix="UC5" TagName="UCMyPaymentControl" Src="~/UserControls/MyPaymentControl.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<%--<script type="text/javascript" language="javascript" src="../../../../cal/popcalendar.js"></script>
--%>
<script language="javascript" type="text/javascript">

//     function nwOpen1(mNo,)
//        {
//         
//            
//            window.open("Popup-Vehicle.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
//            
//        }

           
        
function openPopupSKU1(txtVehNo) 
{
    var str_Index = "";
    var selected_VehNo = "";

    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_dgExpense1").rows.length; intIndex++)
   {
        if (intIndex < 10) str_Index = "0" + intIndex; else str_Index = intIndex;
      
            if (document.getElementById("ctl00_MyCPH1_dgExpense1_ctl" + str_Index + "_txtVehNo").value != "")
               {
                selected_VehNo = document.getElementById("ctl00_MyCPH1_dgExpense1_ctl" + str_Index + "_txtVehNo").value;
                
               }
      
        
    }
    
    
    

    window.open("wfrm_Popup_Vehicle.aspx?Selected_VehNo=" + selected_VehNo + "&Opener_tb_SKU_Code=" + txtVehNo.id , null, "height=300,width=400,left=300,top=200,status=no,resizable=yes,scrollbars=yes,toolbar=no,location=no,menubar=no");
}
        
        
        
        
function openPopupSKU2(txtVehNo) 
{
    var str_Index = "";
    var selected_VehNo = "";

    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_dgExpense2").rows.length; intIndex++)
   {
        if (intIndex < 10) str_Index = "0" + intIndex; else str_Index = intIndex;

      
            if (document.getElementById("ctl00_MyCPH1_dgExpense2_ctl" + str_Index + "_txtVehNo").value != "")
               {
                selected_VehNo = document.getElementById("ctl00_MyCPH1_dgExpense2_ctl" + str_Index + "_txtVehNo").value;}
      
        
    }
    
    window.open("wfrm_Popup_Vehicle.aspx?Selected_VehNo=" + selected_VehNo + "&Opener_tb_SKU_Code=" + txtVehNo.id , null, "height=300,width=400,left=300,top=200,status=no,resizable=yes,scrollbars=yes,toolbar=no,location=no,menubar=no");
}
        
        
        
        
        
function openPopupSKU3(txtVehNo) 
{
    var str_Index = "";
    var selected_VehNo = "";

    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_dgExpense3").rows.length; intIndex++)
   {
        if (intIndex < 10) str_Index = "0" + intIndex; else str_Index = intIndex;

      
            if (document.getElementById("ctl00_MyCPH1_dgExpense3_ctl" + str_Index + "_txtVehNo").value != "")
               {
                selected_VehNo = document.getElementById("ctl00_MyCPH1_dgExpense3_ctl" + str_Index + "_txtVehNo").value;}
      
        
    }
    
    
    

    window.open("wfrm_Popup_Vehicle.aspx?Selected_VehNo=" + selected_VehNo + "&Opener_tb_SKU_Code=" + txtVehNo.id , null, "height=300,width=400,left=300,top=200,status=no,resizable=yes,scrollbars=yes,toolbar=no,location=no,menubar=no");
}
        
        
        
        
        
function openPopupSKU4(txtVehNo) 
{
    var str_Index = "";
    var selected_VehNo = "";

    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_dgExpense4").rows.length; intIndex++)
   {
        if (intIndex < 10) str_Index = "0" + intIndex; else str_Index = intIndex;

      
            if (document.getElementById("ctl00_MyCPH1_dgExpense4_ctl" + str_Index + "_txtVehNo").value != "")
               {
                selected_VehNo = document.getElementById("ctl00_MyCPH1_dgExpense4_ctl" + str_Index + "_txtVehNo").value;}
      
        
    }
    
    
    

    window.open("wfrm_Popup_Vehicle.aspx?Selected_VehNo=" + selected_VehNo + "&Opener_tb_SKU_Code=" + txtVehNo.id , null, "height=300,width=400,left=300,top=200,status=no,resizable=yes,scrollbars=yes,toolbar=no,location=no,menubar=no");
}
        








 
        function Check()
        {
            var grid1=document.getElementById("ctl00_MyCPH1_dgExpense1");
            
            var grid2=document.getElementById("ctl00_MyCPH1_dgExpense2");
            
            var grid3=document.getElementById("ctl00_MyCPH1_dgExpense3");
            
            var grid4=document.getElementById("ctl00_MyCPH1_dgExpense4");
            
            var Date=document.getElementById("ctl00_MyCPH1_txtDate").value;
         //   var Vehn=document.getElementById("ctl00_MyCPH1_txtVehNo").value;
            
              var Amt=document.getElementById("ctl00_MyCPH1_txtTotalAmt").value;
            
            
              var ExeAmt=document.getElementById("ctl00_MyCPH1_txtTotalExeAmt").value;
            
            
          //  var Row=document.getElementById("ctl00_MyCPH1_txtRow").value;
        
       
                  if(Date=="")
                  {
                    alert("Please Enter Expense Voucher Date !")
                     document.getElementById("ctl00_MyCPH1_txtDate").focus();
                     
                      return false;
                   
                  }
//                  if(Vehn=="")
//                  {
//                    alert("Please Enter Vehicle No!")
//                    
//                    document.getElementById("ctl00_MyCPH1_txtVehNo").focus();
//                    
//                     return false;
//                  }
             

              
        var r1=grid1.rows.length;
        var r2=grid2.rows.length;
        var r3=grid3.rows.length;
        var r4=grid4.rows.length;
     
      var Nat1="";
      var Nat11="";
         var Nat2="";
      var Nat22="";
         var Nat3="";
      var Nat33="";
         var Nat4="";
      var Nat44="";
      
      
      
      
      
      
      
      
      if(r1>0)
      {
         for(i=0;i< r1-1;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_dgExpense1_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_dgExpense1_ctl" + j + "_";
           
                }    
          
              Nat1=document.getElementById(pref + "ddlNature").value;
              
               var    Veh1=document.getElementById(pref + "txtVehNo").value ;
                         
             if(Veh1=="")
             {
             
             alert("Enter Vehicle No!");
             
             //   document.getElementById("ctl00_MyCPH1_txtDate_txt_Date").focus();
                  document.getElementById(pref + "txtVehNo").focus();
             return false;
           
             }
              
              
        
           
       
         for(k=0;k<r1-1;k++)
        {  
            if(i!=k)
           {  
               m=k+2
               var pref="";
              if(j<10)
              {
              pref = "ctl00_MyCPH1_dgExpense1_ctl0" + m + "_";
              }                                       
              else
              {         
              pref = "ctl00_MyCPH1_dgExpense1_ctl" + m + "_";
              }    
          
             Nat11=document.getElementById(pref + "ddlNature").value ;
                            
           if(Nat1==Nat11)
           {
           alert("Please Select different Expense in each row!");
           return false;
           }
         }
       }
     }
   }
  
  
  
  
      if(r2>0)
      {
         for(i=0;i< r2-1;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_dgExpense2_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_dgExpense2_ctl" + j + "_";
           
                }    
          
              Nat2=document.getElementById(pref + "ddlNature").value;
              
              var    Veh2=document.getElementById(pref + "txtVehNo").value ;
                         
             if(Veh2=="")
             {
             
             alert("Enter Vehicle No!");
               document.getElementById(pref + "txtVehNo").focus();
             return false;
            
             }
        
        
        
        
        
        
        
        
           
       
         for(k=0;k<r2-1;k++)
        {  
            if(i!=k)
           {  
               m=k+2
               var pref="";
              if(j<10)
              {
              pref = "ctl00_MyCPH1_dgExpense2_ctl0" + m + "_";
              }                                       
              else
              {         
              pref = "ctl00_MyCPH1_dgExpense2_ctl" + m + "_";
              }    
          
             Nat22=document.getElementById(pref + "ddlNature").value ;
                            
           if(Nat2==Nat22)
           {
           alert("Please Select different Expense in each row!");
           return false;
           }
         }
       }
     }
   }
  
  
   if(r3>0)
      {
         for(i=0;i< r3-1;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_dgExpense3_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_dgExpense3_ctl" + j + "_";
           
                }    
          
              Nat3=document.getElementById(pref + "ddlNature").value;
              
              
               var    Veh3=document.getElementById(pref + "txtVehNo").value ;
             
             
             if(Veh3=="")
             {
             
             alert("Enter Vehicle No!");
                document.getElementById(pref + "txtVehNo").focus();
             return false;
         
             }
              
              
              
              
        
           
       
         for(k=0;k<r3-1;k++)
        {  
            if(i!=k)
           {  
               m=k+2
               var pref="";
              if(j<10)
              {
              pref = "ctl00_MyCPH1_dgExpense3_ctl0" + m + "_";
              }                                       
              else
              {         
              pref = "ctl00_MyCPH1_dgExpense3_ctl" + m + "_";
              }    
          
             Nat33=document.getElementById(pref + "ddlNature").value ;
                            
           if(Nat3==Nat33)
           {
           alert("Please Select different Expense in each row!");
           return false;
           }
         }
       }
     }
   }
  
  
  
  
   if(r4>0)
      {
         for(i=0;i< r4-1;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_dgExpense4_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_dgExpense4_ctl" + j + "_";
           
                }    
          
              Nat4=document.getElementById(pref + "ddlNature").value;
              
              
         var    Veh44=document.getElementById(pref + "txtVehNo").value ;
             
             
             if(Veh44=="")
             {
             
             alert("Enter Vehicle No!");
                document.getElementById(pref + "txtVehNo").focus();
             return false;
          
             }
             
             
              
              
        
           
       
         for(k=0;k<r4-1;k++)
        {  
            if(i!=k)
           {  
               m=k+2
               var pref="";
              if(j<10)
              {
              pref = "ctl00_MyCPH1_dgExpense4_ctl0" + m + "_";
              }                                       
              else
              {         
              pref = "ctl00_MyCPH1_dgExpense4_ctl" + m + "_";
              }    
          
             Nat44=document.getElementById(pref + "ddlNature").value ;
             
             
      
                            
           if(Nat4==Nat44)
           {
           alert("Please Select different Expense in each row!");
           return false;
           }
         }
       }
     }
     
   }
  
  
  
                  if(Amt=="")
               {
             
                
                   alert("Total Amount  Should be Greater than 0!")
                  return false;
                                  
                 
               }
                  
                   if(Amt!="")
               {
                  if( parseFloat(Amt)<=0)
                 {
                
                   alert("Total Amount  Should be Greater than 0!")
                  return false;
                                  
                  }
               }
                  
                  
                    if(ExeAmt=="")
                  {
                                  
                     alert("Approved Total Amount  Should be Greater than 0!")
                     return false;
                
                   
                   }
                                    
                  
                    if(ExeAmt!="")
                  {
                    if( parseFloat(ExeAmt)<=0)
                     {
                 
                     alert("Approved Total Amount  Should be Greater than 0!")
                     return false;
                
                     }
                 }
            
  
  
  if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Cash"  )
        {
           {
              document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtCashAmt').value=document.getElementById('ctl00$MyCPH1$txtTotalExeAmt').value;
           }
           document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value=document.getElementById('ctl00$MyCPH1$txtTotalExeAmt').value;
           document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtAmtApplA').value=document.getElementById('ctl00$MyCPH1$txtTotalExeAmt').value;
           
        }
        
         if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Bank"  )
        {
           {
              document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtChqAmt').value=document.getElementById('ctl00$MyCPH1$txtTotalExeAmt').value;
           }
           document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value=document.getElementById('ctl00$MyCPH1$txtTotalExeAmt').value;
           document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtAmtApplA').value=document.getElementById('ctl00$MyCPH1$txtTotalExeAmt').value;
        }
        
         if(document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$ddlPayMode').value == "Both"  )
        {
        
           document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtNetPay').value=document.getElementById('ctl00$MyCPH1$txtTotalExeAmt').value;
           document.getElementById('ctl00$MyCPH1$UCMyPaymentControl1$txtAmtApplA').value=document.getElementById('ctl00$MyCPH1$txtTotalExeAmt').value;
        }
             
        if (!CheckData())
          {
           return false;
          }
   
    if (confirm("Do you want to submit")==false)
		{
		  return false;
		}
   
  
  
  }

  function calculateBalance()
    {
      
              var grid1=document.getElementById("ctl00_MyCPH1_dgExpense1");
        var r1=grid1.rows.length;
      
              var grid2=document.getElementById("ctl00_MyCPH1_dgExpense2");
        var r2=grid2.rows.length;
        
              var grid3=document.getElementById("ctl00_MyCPH1_dgExpense3");
        var r3=grid3.rows.length;
        
              var grid4=document.getElementById("ctl00_MyCPH1_dgExpense4");
        var r4=grid4.rows.length;
      
       var totadv="0.00",totamt="0.00";
      
      // var mtotadv="0.00",mtotamt="0.00";
      var totadv1="0.00",totamt1="0.00";
        var totadv2="0.00",totamt2="0.00";
          var totadv3="0.00",totamt3="0.00";
            var totadv4="0.00",totamt4="0.00";

       
        for(i=0;i< r1-1;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_dgExpense1_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_dgExpense1_ctl" + j + "_";
           
                }    
          
            var amt1=document.getElementById(pref + "txtAmt");
            var EAmt1=document.getElementById(pref + "txtExeAmt");
       
    
         if(amt1.value!="")
         {
           totadv1=parseFloat(totadv1) + parseFloat(amt1.value);
         }
       
        if(EAmt1.value!="")
         {
           totamt1=parseFloat(totamt1) + parseFloat(EAmt1.value);
         }
         
            
    }
 
  
    
      
         for(i=0;i< r2-1;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_dgExpense2_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_dgExpense2_ctl" + j + "_";
           
                }    
          
            var amt2=document.getElementById(pref + "txtAmt");
            var EAmt2=document.getElementById(pref + "txtExeAmt");
    
    
         if(amt2.value!="")
         {
           totadv2=parseFloat(totadv2) + parseFloat(amt2.value);
         }
       
        if(EAmt2.value!="")
         {
           totamt2=parseFloat(totamt2) + parseFloat(EAmt2.value);
         }
         
        
       
            
    }
  
    
     for(i=0;i< r3-1;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_dgExpense3_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_dgExpense3_ctl" + j + "_";
           
                }    
          
            var amt3=document.getElementById(pref + "txtAmt");
            var EAmt3=document.getElementById(pref + "txtExeAmt");
    
    
         if(amt3.value!="")
         {
           totadv3=parseFloat(totadv3) + parseFloat(amt3.value);
         }
       
        if(EAmt3.value!="")
         {
           totamt3=parseFloat(totamt3) + parseFloat(EAmt3.value);
         }
         
        
       
            
    }
     
  
     for(i=0;i< r4-1;i++)
        {  
            j=i+2
            var pref="";
  
              if(j<10)
              {
              pref = "ctl00_MyCPH1_dgExpense4_ctl0" + j + "_";
         
              
               }                                       
               else
                {         
             pref = "ctl00_MyCPH1_dgExpense4_ctl" + j + "_";
           
                }    
          
            var amt4=document.getElementById(pref + "txtAmt");
            var EAmt4=document.getElementById(pref + "txtExeAmt");
    
    
         if(amt4.value!="")
         {
           totadv4=parseFloat(totadv4) + parseFloat(amt4.value);
         }
       
        if(EAmt4.value!="")
         {
           totamt4=parseFloat(totamt4) + parseFloat(EAmt4.value);
         }
         
        
       
            
    }
    
        
           
           
        totadv=parseFloat(totadv1)+parseFloat(totadv2)+parseFloat(totadv3)+parseFloat(totadv4);
       
            
     
        
        totamt=parseFloat(totamt1)+parseFloat(totamt2)+parseFloat(totamt3)+parseFloat(totamt4);
          
           document.getElementById("ctl00_MyCPH1_txtTotalAmt").value= totadv;       
           
           document.getElementById("ctl00_MyCPH1_txtTotalExeAmt").value=totamt;       
            
           
        
         
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

 <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"> </script>
 <script language="javascript" type="text/javascript">
var cal = new CalendarPopup("Div1"); 
cal.setCssPrefix("TEST");
cal.showNavigationDropdowns();
var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");


var FinYear="<%=Session["FinYear"]%>"
		var FinYear_to=parseInt(FinYear)+1
		
		if(FinYear_to<10)
		{
		FinYear_to="0"+FinYear_to
		}
		var FinYear_fromdate="01/04/"+FinYear
		var FinYear_todate="31/03/"+FinYear_to
		var Sle_finyear=FinYear+"-"+FinYear_to

 function ValidateDate(obj)
    {
      if (obj.value!="")
      {
	    if (isDate(obj.value)==false)
	    {
		    obj.focus();
		    return false;
	    }
        return true;
      }
    }
     var dtCh= "/";
     var minYear="1900";
    var maxYear="2100";
     function DaysArray(n) 
     {
	    for (var i = 1; i <= n; i++) 
	    {
		    this[i] = 31
		    if (i==4 || i==6 || i==9 || i=="11") {this[i] = 30}
		    if (i==2) {this[i] = 29}
       } 
        return this;
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
</script> 



     

        
 


<p align="center">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" width="45%">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Fixed Expense Voucher</asp:Label>
 
            </td>
            
             <td align=left>
                       
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color=red><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  
         
          </td>      
        </tr>
    </table>
    
    </p>
   
    <hr align="center" size="1" color="#8ba0e5">
      <br/> 
      <p align="center">
    <table  align="center" width="80%">
       <tr>
       <td>
       
              <asp:UpdatePanel ID="UpdatePanel10" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
 
 
      
      <table cellspacing="1" cellpadding="3" width="100%" class="boxbg" border="0">
            
            <tr style="background-color: white">
                <td colspan="4" align="center">
                    <asp:Label ID="lblError"  runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
                    
                    </td>
                   </tr>
            
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="EXPENSE VOUCHER(FIXED) FORM"></asp:Label>
                    </td>
                           
                    
            </tr>
            
            <tr style="background-color: white">
              
                <td align="left" nowrap>
                <font class="blackfnt" color=red></font> <font class=bluefnt>Expense Voucher Date</font>
                </td>
                <td align="left">
             <%--<SControls:DateSelector     ID="txtDate" runat="server" /> --%>
         <asp:TextBox ID="txtDate" runat="server" onblur="javascript:ValidateDate(this)"
                                BorderStyle="Groove" CssClass="input" MaxLength="10" Width="80px"></asp:TextBox>
                            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDate,'anchor22','dd/MM/yyyy'); return false;" id="a1" name="anchor22">
                                <img alt="Cal" border="0" src="../../../images/calendar.jpg" /></a>

                </td>
                 
                
            </tr>
           
               
     
                 <tr style="background-color: white">
                <td nowrap><font class=bluefnt>Enter Manual Voucher No.</font></td>
                
                
                <td colspan="3"    align=left>
                   <asp:TextBox ID="txtManualVno" BorderStyle="Groove"     runat="server"  ></asp:TextBox>
                </td>
                
                </tr>                
                            <tr class="bgbluegrey">
                <td colspan=4 align="center"><font class=blackfnt><b>ACCOUNT DETAILS-EXPENSE INCURRED</b></font></td>
            </tr>
                
                
                             <tr style="background-color: white">
                
     <td width="10%"><font class=blackfnt>Enter no. of rows</font></td>
                
                
                <td  colspan="3" align=left>
                
                        <asp:UpdatePanel ID="UpdatePanel4" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
                <asp:TextBox ID="txtRow1" runat="server" MaxLength="3" Width="30" BorderStyle="Groove"  AutoPostBack="true" OnTextChanged="txtRow_TextChanged"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1"  ValidationGroup="VGDtFromTo" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtRow1"  ></asp:RequiredFieldValidator>
                    </ContentTemplate>
                     <Triggers>
                          <asp:AsyncPostBackTrigger ControlID="txtRow1" EventName="TextChanged" />
                   
                    </Triggers>
                    </asp:UpdatePanel> 
                </td>
              
            
            </tr> 

 
                      </tr>                
                            <tr class="bgbluegrey">
                <td colspan=4 align="left"><font class=blackfnt><b>STATUTORY EXPENSE</b></font></td>
            </tr>
                
                        
             <tr style="background-color: white">
                <td   colspan="4" align="left" style="height: 185px">
                                    
                                    <asp:DataGrid ID="dgExpense1" runat="server" AutoGenerateColumns="False"
                                                    CellPadding="2" CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                                    BorderWidth="3px" Width="100%" OnItemDataBound="dgExpense_ItemDataBound" >
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
                                                        
                                                         
                                                      
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Nature Of Expense">
                                                            <ItemTemplate>
                                                                
                                                                <asp:DropDownList ID="ddlNature" runat="server"  Width="150px" BorderStyle="Groove" MaxLength="50"></asp:DropDownList>
                                                                
                                                                
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                       
                                                              <asp:TemplateColumn HeaderText="Vehicle No.">
                                                            <ItemTemplate>
                                                         <asp:TextBox ID="txtVehNo"   AutoPostBack="true" CssClass="input"  runat=server  Text='<%#Eval("VehicleNo")%>' OnTextChanged="txtVehNo_TextChanged"></asp:TextBox>
                                                 
                                                         
                                                           <asp:Label ID="lbl_Popup_SKU"      runat="server" BorderStyle="Groove" TabIndex="18"  
                                                            Width="14px"><a>...</a></asp:Label> 
                                                         
                                                         
                                
                                                           <asp:Label ID="lblVehCheck"  Visible="false"    runat="server"    CssClass="redfnt"></asp:Label> 
                            
                                                           <asp:RequiredFieldValidator ID="ReqtxtVehNo" runat="server"   ValidationGroup="VGDtFromTo"    Display="Dynamic" Text="!" ControlToValidate="txtVehNo"  ></asp:RequiredFieldValidator>
                                                                
                                                                
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Amount Spent">
                                                            <ItemTemplate>
                                                                  <asp:TextBox ID="txtAmt" runat="server" MaxLength="7" Width="65" BorderStyle="Groove"   onblur="javascript:return calculateBalance()"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"      Text='<%# DataBinder.Eval(Container.DataItem,"Amount") %>'  ></asp:TextBox>
                                                                  
                                                                <asp:RegularExpressionValidator ID="REVtxtAmt" runat="server" ControlToValidate="txtAmt"   ValidationGroup="VGDtFromTo"
                                                            ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                            Width="1px"></asp:RegularExpressionValidator>
                                                        </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="Bill/Receipt No. if any(Attach supportings)">
                                                            <ItemTemplate>
                                                            <asp:TextBox ID="txtBillNo" runat="server" MaxLength="100" Width="100px" BorderStyle="Groove"   ></asp:TextBox> 
                                                                
                                                                
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="true" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                       
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Amount Approved By Fleet Executive">
                                                        
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtExeAmt" runat="server" MaxLength="7" Width="100px" BorderStyle="Groove"  onblur="javascript:return calculateBalance()"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"      Text='<%# DataBinder.Eval(Container.DataItem,"EAmt") %>'    ></asp:TextBox>
                                                                  <asp:RegularExpressionValidator ID="REVtxtExeAmt" runat="server" ControlToValidate="txtExeAmt"   ValidationGroup="VGDtFromTo"
                                                            ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                            Width="1px"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="true" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="Remarks">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtRemarks" runat="server"  MaxLength="250"  Width="100px" BorderStyle="Groove" ></asp:TextBox>
                                                                
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
            
            
            
            
                                      <tr style="background-color: white">
                
     <td width="10%" style="height: 69px"><font class=blackfnt>Enter no. of rows</font></td>
                
                
                <td  colspan="3" align=left style="height: 69px">
                
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
                <asp:TextBox ID="txtRow2" runat="server" MaxLength="3" Width="30" BorderStyle="Groove"  AutoPostBack="true"  OnTextChanged="txtRow2_TextChanged"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator2"  ValidationGroup="VGDtFromTo" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtRow2"  ></asp:RequiredFieldValidator>
                    </ContentTemplate>
                     <Triggers>
                          <asp:AsyncPostBackTrigger ControlID="txtRow2" EventName="TextChanged" />
                   
                    </Triggers>
                    </asp:UpdatePanel> 
                </td>
              
            
            </tr> 
                       </tr>                
                            <tr class="bgbluegrey">
                <td colspan=4 align="left"><font class=blackfnt><b>CREW SALARY EXPENSE</b></font></td>
            </tr>
           
                        
             <tr style="background-color: white">
                <td   colspan="4"  align="left">
                                    
                                    <asp:DataGrid ID="dgExpense2" runat="server" AutoGenerateColumns="False"
                                                    CellPadding="2" CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                                    BorderWidth="3px" Width="100%" OnItemDataBound="dgExpense2_ItemDataBound" >
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
                                                        
                                                         
                                                      
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Nature Of Expense">
                                                            <ItemTemplate>
                                                                
                                                                <asp:DropDownList ID="ddlNature" runat="server"  Width="150px" BorderStyle="Groove" MaxLength="50"></asp:DropDownList>
                                                                
                                                                
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                         
                                                              <asp:TemplateColumn HeaderText="Vehicle No.">
                                                            <ItemTemplate>
                                                         <asp:TextBox ID="txtVehNo"   AutoPostBack="true" CssClass="input"  runat=server  Text='<%#Eval("VehicleNo")%>' OnTextChanged="txtVehNo_TextChanged"></asp:TextBox>
                                                 
                                                         
                                                           <asp:Label ID="lbl_Popup_SKU"      runat="server" BorderStyle="Groove" TabIndex="18"  
                                                            Width="14px"><a>...</a></asp:Label> 
                                                         
                                                         
                                
                                                           <asp:Label ID="lblVehCheck"  Visible="false"    runat="server"    CssClass="redfnt"></asp:Label> 
                            
                                                           <asp:RequiredFieldValidator ID="ReqtxtVehNo" runat="server"   ValidationGroup="VGDtFromTo"    Display="Dynamic" Text="!" ControlToValidate="txtVehNo"  ></asp:RequiredFieldValidator>
                                                                
                                                                
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Amount Spent">
                                                            <ItemTemplate>
                                                                  <asp:TextBox ID="txtAmt" runat="server" MaxLength="7" Width="65" BorderStyle="Groove"  onblur="javascript:return calculateBalance()"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"      Text='<%# DataBinder.Eval(Container.DataItem,"Amount") %>'  ></asp:TextBox>
                                                                  
                                                                <asp:RegularExpressionValidator ID="REVtxtAmt" runat="server" ControlToValidate="txtAmt"   ValidationGroup="VGDtFromTo"
                                                            ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                            Width="1px"></asp:RegularExpressionValidator>
                                                        </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="Bill/Receipt No. if any(Attach supportings)">
                                                            <ItemTemplate>
                                                            <asp:TextBox ID="txtBillNo" runat="server" MaxLength="100" Width="100px" BorderStyle="Groove"   ></asp:TextBox> 
                                                                
                                                                
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="true" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                       
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Amount Approved By Fleet Executive">
                                                        
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtExeAmt" runat="server" MaxLength="7" Width="100px" BorderStyle="Groove"   onblur="javascript:return calculateBalance()"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"      Text='<%# DataBinder.Eval(Container.DataItem,"EAmt") %>'  ></asp:TextBox>
                                                                  <asp:RegularExpressionValidator ID="REVtxtExeAmt" runat="server" ControlToValidate="txtExeAmt"  ValidationGroup="VGDtFromTo"
                                                            ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                            Width="1px"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="true" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="Remarks">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtRemarks" runat="server"   MaxLength="250" Width="100px" BorderStyle="Groove" ></asp:TextBox>
                                                                
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
             
            
                                      <tr style="background-color: white">
                
     <td width="10%"><font class=blackfnt>Enter no. of rows</font></td>
                
                
                <td  colspan="3" align=left>
                
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
                <asp:TextBox ID="txtRow3" runat="server" MaxLength="3" Width="30" BorderStyle="Groove"  AutoPostBack="true" OnTextChanged="txtRow3_TextChanged"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator3"  ValidationGroup="VGDtFromTo" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtRow3"  ></asp:RequiredFieldValidator>
                    </ContentTemplate>
                     <Triggers>
                          <asp:AsyncPostBackTrigger ControlID="txtRow3" EventName="TextChanged" />
                   
                    </Triggers>
                    </asp:UpdatePanel> 
                </td>
              
            
            </tr> 
          
                        </tr>                
                            <tr class="bgbluegrey">
                <td colspan=4 align="left"><font class=blackfnt><b>VEHICLE TRACKING SERVICE EXPENSE</b></font></td>
            </tr>
             <tr style="background-color: white">
                <td  colspan="4" align="left">
                
                
             
                                    
                                    <asp:DataGrid ID="dgExpense3" runat="server" AutoGenerateColumns="False"
                                                    CellPadding="2" CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                                    BorderWidth="3px" Width="100%" OnItemDataBound="dgExpense3_ItemDataBound" >
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
                                                        
                                                         
                                                      
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Nature Of Expense">
                                                            <ItemTemplate>
                                                                
                                                                <asp:DropDownList ID="ddlNature" runat="server"  Width="150px" BorderStyle="Groove" MaxLength="50"></asp:DropDownList>
                                                                
                                                                
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        
                                                        
                                                              <asp:TemplateColumn HeaderText="Vehicle No.">
                                                            <ItemTemplate>
                                                         <asp:TextBox ID="txtVehNo"   AutoPostBack="true" CssClass="input"  runat=server  Text='<%#Eval("VehicleNo")%>' OnTextChanged="txtVehNo_TextChanged"></asp:TextBox>
                                                 
                                                         
                                                           <asp:Label ID="lbl_Popup_SKU"      runat="server" BorderStyle="Groove" TabIndex="18"  
                                                            Width="14px"><a>...</a></asp:Label> 
                                                         
                                                         
                                
                                                           <asp:Label ID="lblVehCheck"  Visible="false"    runat="server"    CssClass="redfnt"></asp:Label> 
                            
                                                           <asp:RequiredFieldValidator ID="ReqtxtVehNo" runat="server"   ValidationGroup="VGDtFromTo"    Display="Dynamic" Text="!" ControlToValidate="txtVehNo"  ></asp:RequiredFieldValidator>
                                                                
                                                                
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Amount Spent">
                                                            <ItemTemplate>
                                                                  <asp:TextBox ID="txtAmt" runat="server" MaxLength="7" Width="65" BorderStyle="Groove"  onblur="javascript:return calculateBalance()"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"      Text='<%# DataBinder.Eval(Container.DataItem,"Amount") %>'  ></asp:TextBox>
                                                                  
                                                                <asp:RegularExpressionValidator ID="REVtxtAmt" runat="server" ControlToValidate="txtAmt"   ValidationGroup="VGDtFromTo"
                                                            ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                            Width="1px"></asp:RegularExpressionValidator>
                                                        </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="Bill/Receipt No. if any(Attach supportings)">
                                                            <ItemTemplate>
                                                            <asp:TextBox ID="txtBillNo" runat="server" MaxLength="100"  Width="100px" BorderStyle="Groove"   ></asp:TextBox> 
                                                                
                                                                
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="true" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                       
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Amount Approved By Fleet Executive">
                                                        
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtExeAmt" runat="server" MaxLength="7"   Width="100px" BorderStyle="Groove"  onblur="javascript:return calculateBalance()"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"      Text='<%# DataBinder.Eval(Container.DataItem,"EAmt") %>'   ></asp:TextBox>
                                                                  <asp:RegularExpressionValidator ID="REVtxtExeAmt" runat="server" ControlToValidate="txtExeAmt"   ValidationGroup="VGDtFromTo"
                                                            ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                            Width="1px"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="true" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="Remarks">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtRemarks" runat="server" MaxLength="250" Width="100px" BorderStyle="Groove" ></asp:TextBox>
                                                                
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
            
            
            
                                      <tr style="background-color: white">
                
     <td width="10%"><font class=blackfnt>Enter no. of rows</font></td>
                
                
                <td  colspan="3" align=left>
                
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server" RenderMode="Inline" UpdateMode="Conditional">
                    <ContentTemplate>
                <asp:TextBox ID="txtRow4" runat="server" MaxLength="3" Width="30" BorderStyle="Groove"  AutoPostBack="true" OnTextChanged="txtRow4_TextChanged"></asp:TextBox>
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator4"  ValidationGroup="VGDtFromTo" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtRow4"  ></asp:RequiredFieldValidator>
                    </ContentTemplate>
                     <Triggers>
                          <asp:AsyncPostBackTrigger ControlID="txtRow4" EventName="TextChanged" />
                   
                    </Triggers>
                    </asp:UpdatePanel> 
                </td>
              
            
            </tr> 
           
                    </tr>                
                            <tr class="bgbluegrey">
                <td colspan=4 align="left"><font class=blackfnt><b>FINANCIAL EXPENSE</b></font></td>
            </tr>
                
                
                        
             <tr style="background-color: white">
                <td  colspan="4"   align="left">
                                    
                                    <asp:DataGrid ID="dgExpense4" runat="server" AutoGenerateColumns="False"
                                                    CellPadding="2" CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                                    BorderWidth="3px" Width="100%" OnItemDataBound="dgExpense4_ItemDataBound" >
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
                                                        
                                                         
                                                      
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Nature Of Expense">
                                                            <ItemTemplate>
                                                                
                                                                <asp:DropDownList ID="ddlNature" runat="server"  Width="150px" BorderStyle="Groove" MaxLength="50"></asp:DropDownList>
                                                                
                                                                
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        
                                                               <asp:TemplateColumn HeaderText="Vehicle No.">
                                                            <ItemTemplate>
                                                         <asp:TextBox ID="txtVehNo"   AutoPostBack="true" CssClass="input"  runat=server  Text='<%#Eval("VehicleNo")%>' OnTextChanged="txtVehNo_TextChanged"></asp:TextBox>
                                                       
                                                         
                                                           <asp:Label ID="lbl_Popup_SKU"      runat="server" BorderStyle="Groove" TabIndex="18"  
                                                            Width="14px"><a>...</a></asp:Label> 
                                                         
                                                         
                                
                                                           <asp:Label ID="lblVehCheck"  Visible="false"    runat="server"    CssClass="redfnt"></asp:Label> 
                            
                                                           <asp:RequiredFieldValidator ID="ReqtxtVehNo" runat="server"   ValidationGroup="VGDtFromTo"    Display="Dynamic" Text="!" ControlToValidate="txtVehNo"  ></asp:RequiredFieldValidator>
                                                                
                                                                
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Amount Spent">
                                                            <ItemTemplate>
                                                                  <asp:TextBox ID="txtAmt" runat="server" MaxLength="7" Width="65" BorderStyle="Groove"  onblur="javascript:return calculateBalance()"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"      Text='<%# DataBinder.Eval(Container.DataItem,"Amount") %>'  ></asp:TextBox>
                                                                  
                                                                <asp:RegularExpressionValidator ID="REVtxtAmt" runat="server" ControlToValidate="txtAmt"  ValidationGroup="VGDtFromTo"
                                                            ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                            Width="1px"></asp:RegularExpressionValidator>
                                                        </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="Bill/Receipt No. if any(Attach supportings)">
                                                            <ItemTemplate>
                                                            <asp:TextBox ID="txtBillNo" runat="server" MaxLength="100"  Width="60px" BorderStyle="Groove"   ></asp:TextBox> 
                                                                
                                                                
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="true" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                       
                                                        
                                                        
                                                        <asp:TemplateColumn HeaderText="Amount Approved By Fleet Executive">
                                                        
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtExeAmt" runat="server" MaxLength="7" Width="100px" BorderStyle="Groove"  onblur="javascript:return calculateBalance()"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))"      Text='<%# DataBinder.Eval(Container.DataItem,"EAmt") %>'   ></asp:TextBox>
                                                                  <asp:RegularExpressionValidator ID="REVtxtExeAmt" runat="server" ControlToValidate="txtExeAmt"   ValidationGroup="VGDtFromTo"
                                                            ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                            Width="1px"></asp:RegularExpressionValidator>
                                                            </ItemTemplate>
                                                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="False" />
                                                            <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                Font-Underline="False" Wrap="true" />
                                                        </asp:TemplateColumn>
                                                        
                                                        
                                                         <asp:TemplateColumn HeaderText="Remarks">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtRemarks" runat="server" MaxLength="250"  Width="100px" BorderStyle="Groove" ></asp:TextBox>
                                                                
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
       <table Width="100%"   cellspacing="1" cellpadding="3" class="boxbg" border="0">
        <tr style="background-color: white">
        <td width="237px" >
      <font class=blackfnt><b>Total</b></font>
        
        </td>
          
           <td align="left" width="400px">
     <asp:TextBox ID="txtTotalAmt" runat="server"  ReadOnly="true" Width="65px" BorderStyle="Groove"></asp:TextBox>
        </td>
        
         <td align="left" >
         <asp:TextBox ID="txtTotalExeAmt" runat="server"  ReadOnly="true" Width="100" BorderStyle="Groove"></asp:TextBox>
        </td>
       
        
        
      
      </tr>
      </table>
       
  <br/>
  <%--<table Width="100%"   cellspacing="1" cellpadding="3" class="boxbg" border="0">
        <tr style="background-color: white">
        <td width="10%"><font class="bluefnt">Attachments:</font></td>
                
                
                <td colspan=3 align=left>
                
                      <asp:FileUpload ID="fileAttach"  BorderStyle="Groove"  runat="server" />
               
               
                    
                </td>
        </tr>
        </table>
        <br/>--%>
  
  
  <table Width="100%"   cellspacing="1" cellpadding="3" class="boxbg" border="0">
  
  
             <tr class="bgbluegrey">
                <td colspan=4 align=center ><font class=blackfnt><b>Verifying Authorities</b></font></td>
            </tr>
                            
                    <tr style="background-color: white">
                        <td align="center"><font class=blackfnt>Checked By Fleet Executive</font></td>
                        <td align="center"><font class=blackfnt>Verified By Branch Head</font></td>
                       
                    </tr> 
                    
                    <tr style="background-color: white">
                        <td align="center"><asp:TextBox ID="txtCheckedBy" runat="server"  Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox></td>
                        <td align="center"><asp:TextBox ID="txtVerifiedBy" runat="server"  Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox></td>
           
                    </tr> 
                    
                    
                     <tr style="background-color: white">
                        <td align="center"><font class=blackfnt>Received By</font></td>
                        <td align="center"><font class=blackfnt>Approved & Accounted By Branch Commercial</font></td>

                    </tr> 
                     <tr style="background-color: white">
                        <td align="center"><asp:TextBox ID="txtReceivedBy" runat="server"  Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox></td>
                        <td align="center"><asp:TextBox ID="txtApprovedBy" runat="server"  Width="150px" BorderStyle="Groove" MaxLength="50"></asp:TextBox></td>
              
                    </tr> 
                    
                    
                    
   </table>
 
 <br>
        <asp:UpdatePanel ID="UpdatePanePayment" UpdateMode="Conditional" RenderMode="Inline" runat="server" Visible=true >
            <ContentTemplate>
                <UC5:UCMyPaymentControl ID="UCMyPaymentControl1" runat="server" ></UC5:UCMyPaymentControl>
            </ContentTemplate>
        </asp:UpdatePanel> 
       
  <br/>
 
    <table  width="100%">
  
     <tr>
     <td align="center">
      <asp:Button ID="cmdSubmit" runat="server" Text="Submit >>"    ValidationGroup="VGDtFromTo" OnClick="SubmitData"  OnClientClick="javascript:return Check()"   />
      </td>
      </tr> 

  </table>     
   </ContentTemplate>
                     <Triggers>
                       <%--   <asp:AsyncPostBackTrigger ControlID="txtVehNo" EventName="TextChanged" />--%>
                          <asp:AsyncPostBackTrigger ControlID="txtRow1" EventName="TextChanged" />
                                                 <asp:AsyncPostBackTrigger ControlID="txtRow2" EventName="TextChanged" />
                                                                          <asp:AsyncPostBackTrigger ControlID="txtRow3" EventName="TextChanged" />
                                                                                                   <asp:AsyncPostBackTrigger ControlID="txtRow4" EventName="TextChanged" />
                                                                                                    
                    </Triggers>
                    </asp:UpdatePanel> 
  </td>
  </tr>
           </table>  
 </p>
 
 <div id="Div1" style="position: absolute; visibility: hidden; background-color: white;layer-background-color: white; z-index: 99;">
    </div> 
</asp:Content> 
