<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="POBillEntry_Step3.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" %>

<%@ Register TagPrefix="UC5" TagName="UCMyPaymentControl" Src="~/UserControls/MyPaymentControl.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="./../../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../FA.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
	    cal.setCssPrefix("TEST");
	    cal.showNavigationDropdowns();
	     User_CTR_Frm_Name="ctl00_MyCPH1_UCMyPaymentControl1_"
	        var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
	    FRM_NM="ctl00_MyCPH1_"
	     var FinYear="<%=Session["FinYear"]%>"
		var FinYear_to=parseInt(FinYear)+1
		
		if(FinYear_to<10)
		{
		FinYear_to="0"+FinYear_to
		}
		var FinYear_fromdate="01/04/"+FinYear
		var FinYear_todate="31/03/"+FinYear_to
		var Sle_finyear=FinYear+"-"+FinYear_to
	    function Check_Calc()
	    {
	             var grid=document.getElementById("ctl00_MyCPH1_GV_Booking");
                 var rows=grid.rows.length;  
                 var Check_One="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                 var Total_adv_amt="0.00",Total_PendAmt="0.00"
                  for(var b=2;b<=rows-1;b++)
                  {
                        //alert(b)
                        if(b<10)
                        {
                            GV_FRM_NM="ctl00_MyCPH1_GV_Booking_ctl0" + b + "_";
                        }
                        else
                        {
                             GV_FRM_NM="ctl00_MyCPH1_GV_Booking_ctl" + b + "_";
                        }

 
                                    NetAmt=parseFloat(document.getElementById(GV_FRM_NM+"TXTCurramt").value)
 
                                    Total_amount=parseFloat(Total_amount)+parseFloat(document.getElementById(GV_FRM_NM+"TXTCurramt").value)
                                    document.getElementById(GV_FRM_NM+"TXTCurramt").value=rounditn(document.getElementById(GV_FRM_NM+"TXTCurramt").value,2)
                                    Total_adv_amt=parseFloat(Total_adv_amt)+parseFloat(document.getElementById(GV_FRM_NM+"LblPaidamt").innerText)
                                    Total_PendAmt=parseFloat(Total_PendAmt)+parseFloat(document.getElementById(GV_FRM_NM+"LblPendamt").innerText)
                    }
                     
                    if(b<10)
                        {
                            GV_FRM_NM1="ctl00_MyCPH1_GV_Booking_ctl0" + b + "_";
                        }
                        else
                        {
                             GV_FRM_NM1="ctl00_MyCPH1_GV_Booking_ctl" + b + "_";
                        }
                     document.getElementById(GV_FRM_NM1+"Txt_Total_netamt").value=rounditn(Total_amount,2)
                     document.getElementById(GV_FRM_NM1+"Txt_Total_AdvAmt").value=rounditn(Total_adv_amt,2)
                     document.getElementById(GV_FRM_NM1+"Txt_Total_Pendamt").value=rounditn(Total_PendAmt,2)
                     
                     document.getElementById(FRM_NM+"Hnd_NetAmt").value=rounditn(Total_amount,2)
                     document.getElementById(FRM_NM+"Hnd_AdvAmt").value=rounditn(Total_adv_amt,2)
                     document.getElementById(FRM_NM+"Hnd_PendAmt").value=rounditn(Total_PendAmt,2)
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
 function ValidateDate(obj)
    {

      if (obj.value!="")
      {
        
	    if (isDate(obj.value)==false)
	    {
    	
		    obj.focus()
		    return false
	    }
        return true
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
function OnSubmit()
{
                
                 var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
                           
                   var dt =document.getElementById(FRM_NM+"TxtVoucherDT").value
				   var hdndockdt;
			      var Maxdt="01/01/2007";
			   
                 var grid=document.getElementById("ctl00_MyCPH1_GV_Booking");
                 var rows=grid.rows.length;  
                 var Check_One="N"
                 var Total_amount="0.00",NetAmt="0.00",TotalNetAmt="0.00"
                 var Total_adv_amt="0.00",Total_PendAmt="0.00"
                  var i=0    
                  for(var b=2;b<=rows-1;b++)
                  {
                        //alert(b)
                            if(b<10)
                            {
                                GV_FRM_NM="ctl00_MyCPH1_GV_Booking_ctl0" + b + "_";
                                hdndockdt="ctl00_MyCPH1_GV_Booking_ctl0" + b + "_POdate" 
                            }
                            else
                            {
                                 GV_FRM_NM="ctl00_MyCPH1_GV_Booking_ctl" + b + "_";
                                 hdndockdt="ctl00_MyCPH1_GV_Booking_ctl" + b + "_POdate";
                            }
                            hdndockdt = document.getElementById(hdndockdt).value;
//                            NetAmt=parseFloat(document.getElementById(GV_FRM_NM+"TXTCurramt").value)
// 
//                            Total_amount=parseFloat(Total_amount)+parseFloat(document.getElementById(GV_FRM_NM+"TXTCurramt").value)
//                            document.getElementById(GV_FRM_NM+"TXTCurramt").value=rounditn(document.getElementById(GV_FRM_NM+"TXTCurramt").value,2)
//                            Total_adv_amt=parseFloat(Total_adv_amt)+parseFloat(document.getElementById(GV_FRM_NM+"LblPaidamt").innerText)
//                            Total_PendAmt=parseFloat(Total_PendAmt)+parseFloat(document.getElementById(GV_FRM_NM+"LblPendamt").innerText)
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
                            // alert(Maxdt1)
				                   // alert(hdndockdt1)
			                       // alert(Maxdt1)
                                if (hdndockdt1>Maxdt1)
                                {
                                Maxdt1=hdndockdt1
                                Maxdt=hdndockdt
                                }
                            //}
                     }
//                     if(b<10)
//                        {
//                            GV_FRM_NM1="ctl00_MyCPH1_GV_Booking_ctl0" + b + "_";
//                        }
//                        else
//                        {
//                             GV_FRM_NM1="ctl00_MyCPH1_GV_Booking_ctl" + b + "_";
//                        }
//                     document.getElementById(GV_FRM_NM1+"Txt_Total_netamt").value=rounditn(Total_amount,2)
//                     document.getElementById(GV_FRM_NM1+"Txt_Total_AdvAmt").value=rounditn(Total_adv_amt,2)
//                     document.getElementById(GV_FRM_NM1+"Txt_Total_Pendamt").value=rounditn(Total_PendAmt,2)
//                     
//                     document.getElementById(FRM_NM+"Hnd_NetAmt").value=rounditn(Total_amount,2)
//                     document.getElementById(FRM_NM+"Hnd_AdvAmt").value=rounditn(Total_adv_amt,2)
//                     document.getElementById(FRM_NM+"Hnd_PendAmt").value=rounditn(Total_PendAmt,2)
                                if (dt=="")
				                {
						                alert( "PO Vendor Bill Date Should Not Be Blank !!!")
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
						            alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO PO Vendor Bill Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						            document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						            return false;
				            }
            				
                             Fromdate1=Maxdt1
			                 Fromdate=Maxdt
                              if (dt<Fromdate1)
				                {
						                alert( "PO Vendor Bill Date Should Be Greater than  "+ Fromdate +"  !!!")
						                document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						                return false;
				                }
				                if (dt>server_dt)
				                {
						                alert( "PO Vendor Bill Date should not be greater than today's date !!!")
						                document.getElementById(FRM_NM+"TxtVoucherDT").focus();
						                return false;
				                }
				                
				          
				              if(document.getElementById(FRM_NM+"LblCr_Account").innerText==":")
	 	                        {
	 	                            alert("No Credit Account for the same Vendor Type")
	 	                            //document.getElementById(FRM_NM+"LblCr_Account").focus();
	 	                            return false;
	 	                        }    
	 	                        vendorbillno=document.getElementById(FRM_NM+"Txt_vendorbillno").value
	                            if (vendorbillno=="") 
	                            {
		                            alert("Please Enter vendor bill no!!!")
		                            document.getElementById(FRM_NM+"Txt_vendorbillno").focus()
		                            return false; 
	                            }    
	                            if(document.getElementById(FRM_NM+"Txt_VendorBillDt").value=="")
	                            {
		                            alert("Please Enter Vendor Bill Date!!!")
		                            document.getElementById(FRM_NM+"Txt_VendorBillDt").focus();
		                            return false;
	                            }
	                            if(document.getElementById(FRM_NM+"Txt_Duedate").value=="")
	                            {
		                            alert("Please Enter Bill Due Date!!!")
		                            document.getElementById(FRM_NM+"Txt_Duedate").focus();
		                            return false;
	                            }
	                               var dt =document.getElementById(FRM_NM+"Txt_Duedate").value
		                            //alert(dt)
		                            var dt_dd=dt.substring(0,2)
		                            var dt_mm=dt.substring(3,5)
		                            var dt_yy=dt.substring(6,10)
                            		
		                            duedt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		                            //alert(duedt)
                            		
		                            dt =document.getElementById(FRM_NM+"TxtVoucherDT").value
		                            dt_dd=dt.substring(0,2)
		                            dt_mm=dt.substring(3,5)
		                            dt_yy=dt.substring(6,10)
                            		
		                            gendt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
                            		
		                            if (duedt<gendt)
		                            {
		                             alert( "Due Date Should be greater than Bill Date !!!")
		                             document.getElementById(FRM_NM+"Txt_Duedate").focus();
		                             return false;
		                            }
		
//        if(parseFloat(NetAmt) == 0)
//        {
//            alert( "Please enter the bill amount !!!")
//		    return false;
//        }
        
        document.getElementById("ctl00_MyCPH1_ON_Submit").style.display="none"		

}
function ADD_DueDate()
{
		var dockdta=document.getElementById("ctl00_MyCPH1_TxtVoucherDT").value
		
		dockdta_dd=dockdta.substring(0,2)
		dockdta_mm=dockdta.substring(3,5)
		dockdta_yy=dockdta.substring(6,10)
			
		var dockdt_billdt=new Date(months[parseFloat(dockdta_mm)] + " " + parseFloat(dockdta_dd) + ", " + parseFloat(dockdta_yy))
		var days=parseInt(document.getElementById("ctl00_MyCPH1_Txt_DueDays").value)
      //  alert(days)
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
// this function assignment in keypress doesn't allow any character other than number.
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
    </script>

    <div align="left" style="width: 9.5in;">
        <table style="width: 1100px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Payments</b></font></a> <b>&gt; </b><a href=""><font class="blklnkund"><b>Generalized
                            PO</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Bill Entry Details</b></font>
                </td>
            </tr>
        </table>
        <br />
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <table border="0" cellpadding="3" width="800" cellspacing="1" align="left" class="boxbg">
                        <tr class="bgbluegrey">
                            <td align="center">
                                <font class="blackfnt"><b>Bill Entry Details</b></font>
                            </td>
                        </tr>
                    </table>
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <table border="0" cellpadding="3" width="800" cellspacing="1" align="left" class="boxbg">
                        <tr bgcolor="white">
                            <td align="Left">
                                <font class="blackfnt">Bill Entry No</font>
                            </td>
                            <td align="Left">
                                <font class="redfnt">System Generated...</font>
                            </td>
                            <td align="Left">
                                <font class="blackfnt">Bill Entry Date </font>
                            </td>
                            <td align="Left">
                                <font class="blackfnt">
                                    <asp:TextBox ID="TxtVoucherDT" Width="70" runat="server" BorderStyle="Groove" CssClass="input"
                                        onblur="javascript:return ValidateDate(this);"></asp:TextBox>
                                    <a href="#" onclick="cal.select(ctl00$MyCPH1$TxtVoucherDT,'anchor2','dd/MM/yyyy'); return false;"
                                        name="anchor2" id="a2">
                                        <img src="./../../../images/calendar.jpg" border="0"></img>
                                    </a><font class="blackfnt">dd/mm/yyyy</font></font>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="Left">
                                <font class="blackfnt">Vendor Name</font>
                            </td>
                            <td align="Left" colspan="3">
                                <font class="blackfnt">
                                    <asp:Label ID="lblVendor" runat="server" Text=""></asp:Label></font>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td style="width: 205">
                                <label class="blackfnt">
                                    Vendor Credit Accounts :</label>
                            </td>
                            <td style="width: 343" colspan="3">
                                &nbsp;<asp:Label ID="LblCr_Account" Text="All" runat="server" CssClass="blackfnt"></asp:Label>
                                <asp:HiddenField ID="HND_CR_Account" runat="server" Value="" />
                                <asp:HiddenField ID="Hnd_AdvAmt" runat="server" Value="" />
                                <asp:HiddenField ID="Hnd_PendAmt" runat="server" Value="" />
                                <asp:HiddenField ID="Hnd_NetAmt" runat="server" Value="" />
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="Left">
                                <font class="blackfnt">Vendor Service TaxNO.</font>
                            </td>
                            <td align="Left">
                                <font class="redfnt">
                                    <asp:Label ID="V_Staxno" runat="server" Text=""></asp:Label></font>
                            </td>
                            <td align="Left">
                                <font class="blackfnt">Vendor PAN NO.</font>
                            </td>
                            <td align="Left">
                                <font class="blackfnt">
                                    <asp:Label ID="V_PANNO" runat="server" Text=""></asp:Label></font>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="Left">
                                <font class="blackfnt">Vendor Billno</font>
                            </td>
                            <td align="Left">
                                <font class="redfnt">
                                    <asp:TextBox ID="Txt_vendorbillno" Width="70" Text="" Style="text-align: Left" 
                                    runat="server" onblur="javascript:return Check_Calc()"
                                        BorderStyle="Groove" CssClass="input"></asp:TextBox></font>
                            </td>
                            <td align="Left">
                                <font class="blackfnt">Vendor Bill Date</font>
                            </td>
                            <td align="Left">
                                <font class="blackfnt">
                                    <asp:TextBox ID="Txt_VendorBillDt" Width="70" Text="" Style="text-align: Left" runat="server"
                                        BorderStyle="Groove" CssClass="input" onblur="javascript:return ValidateDate(this);"></asp:TextBox>
                                    <a href="#" onclick="cal.select(ctl00$MyCPH1$Txt_VendorBillDt,'anchor3','dd/MM/yyyy'); return false;"
                                        name="anchor3" id="a1">
                                        <img src="./../../../images/calendar.jpg" border="0"></img>
                                    </a><font class="blackfnt">dd/mm/yyyy</font></font>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="Left">
                                <font class="blackfnt">Due Days</font>
                            </td>
                            <td align="Left">
                                <font class="redfnt">
                                    <asp:TextBox ID="Txt_DueDays" onkeypress="javascript:return validInt(event)" onblur="javascript:ADD_DueDate()"
                                        Width="70" Text="15" Style="text-align: Left" runat="server" BorderStyle="Groove"
                                        CssClass="input"></asp:TextBox></font>
                            </td>
                            <td align="Left">
                                <font class="blackfnt">Due Date</font>
                            </td>
                            <td align="Left">
                                <font class="blackfnt">
                                    <asp:TextBox ID="Txt_Duedate" Width="70" Text="" Style="text-align: Left" runat="server"
                                        BorderStyle="Groove" CssClass="input" onblur="javascript:return ValidateDate(this);"></asp:TextBox>
                                    <a href="#" onclick="cal.select(ctl00$MyCPH1$Txt_Duedate,'anchor4','dd/MM/yyyy'); return false;"
                                        name="anchor4" id="a4">
                                        <img src="./../../../images/calendar.jpg" border="0"></img>
                                    </a><font class="blackfnt">dd/mm/yyyy</font></font>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="Left">
                                <font class="blackfnt">Remarks</font>
                            </td>
                            <td align="Left" colspan="3">
                                <font class="redfnt">
                                    <asp:TextBox ID="Txt_Remarks" onblur="javascript:this.value=this.value.toUpperCase()"
                                        Width="200" Text="" Rows="3" TextMode="MultiLine" MaxLength="500" Style="text-align: Left"
                                        runat="server" BorderStyle="Groove" CssClass="input"></asp:TextBox></font>
                            </td>
                        </tr>
                    </table>
                    <br />
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <asp:GridView ID="GV_Booking" runat="server" align="left" BorderWidth="1" CellPadding="2"
                        HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                        BackColor="white" FooterStyle-CssClass="bgbluegrey" AllowPaging="False" PageSize="100"
                        Width="800" AllowSorting="False" AutoGenerateColumns="false" ShowFooter="true"
                        PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                        <PagerStyle VerticalAlign="Bottom" />
                        <Columns>
                            <asp:TemplateField HeaderText="PO Code" ItemStyle-Wrap="false">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="LblPOCODE" Text='<%# DataBinder.Eval(Container.DataItem, "pocode") %>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="PO Date" ItemStyle-Wrap="false">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="LBLPODT" Text='<%# DataBinder.Eval(Container.DataItem, "podt") %>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Adv. VoucherNo" ItemStyle-Wrap="false">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="LBLVoucherno" Text='<%# DataBinder.Eval(Container.DataItem, "Adv_Voucherno") %>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Adv. VoucherNo Date" ItemStyle-Wrap="false">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="LBLVRDT" Text='<%# DataBinder.Eval(Container.DataItem, "Adv_Voucherdt") %>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="PO Total Amount" ItemStyle-Wrap="false">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="LBLPOAMT" Text='<%# DataBinder.Eval(Container.DataItem, "Totalamt") %>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Advance Paid Amount" ItemStyle-Wrap="false">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:Label ID="LblPaidamt" Text='<%# DataBinder.Eval(Container.DataItem, "Paidamt") %>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <FooterStyle HorizontalAlign="Right" />
                                <FooterTemplate>
                                    <asp:TextBox ID="Txt_Total_AdvAmt" Width="70" Text="0.00" Style="text-align: Right"
                                        runat="server" BorderStyle="Groove" Enabled="false" CssClass="input"></asp:TextBox>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Pending  Amount" ItemStyle-Wrap="false">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:Label ID="LblPendamt" Text='<%# DataBinder.Eval(Container.DataItem, "Pendamt") %>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <FooterStyle HorizontalAlign="Right" />
                                <FooterTemplate>
                                    <asp:TextBox ID="Txt_Total_Pendamt" Width="70" Text="0.00" Style="text-align: Right"
                                        runat="server" BorderStyle="Groove" Enabled="false" CssClass="input"></asp:TextBox>
                                </FooterTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Bill  Amount" ItemStyle-Wrap="false">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                <ItemTemplate>
                                    <asp:TextBox ID="TXTCurramt" runat="server" Width="70" MaxLength="8" Style="text-align: Right"
                                        onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Enabled="false"
                                        Text='<%# DataBinder.Eval(Container.DataItem, "Pendamt") %>' onblur="javascript:return Check_Calc()" BorderStyle="Groove" CssClass="input"></asp:TextBox>
                                    <asp:HiddenField ID="POdate" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "podate") %>' />
                                    <asp:HiddenField ID="Hnd_totalAmt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "Pendamt") %>' />
                                </ItemTemplate>
                                <FooterStyle HorizontalAlign="Right" />
                                <FooterTemplate>
                                    <asp:TextBox ID="Txt_Total_netamt" Width="70" Text='<%# DataBinder.Eval(Container.DataItem, "Pendamt") %>' 
                                    Style="text-align: Right"  runat="server" BorderStyle="Groove" Enabled="false" 
                                    CssClass="input"></asp:TextBox>
                                </FooterTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <br />
                </td>
            </tr>
        </table>
        <table align="left" cellspacing="1" width="800" class="boxbg" border="0" id="ON_Submit"
            runat="server">
            <tr class="bgbluegrey">
                <td colspan="4" align="center" style="height: 21px">
                    <asp:Button ID="btn_submit" Text="Submit" CssClass="blackfnt" OnClick="btn_submit_Click"
                        OnClientClick="javascript:return OnSubmit()" runat="server" />
                </td>
            </tr>
        </table>

        <script>
            function loadme() {

                ADD_DueDate()
            }
            window.onload = loadme
        </script>

    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
