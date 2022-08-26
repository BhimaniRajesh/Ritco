<%@ Page Language="C#"   MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result_BA_BillEntry.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_BA_Payment_ver1_Result_BA_BillEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" type="text/javascript" src="../../../Images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();


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
    
    function checkall(obj)
           {
            
           
            var sumtxt=document.getElementById("ctl00_MyCPH1_txtNetCommission");
	                          var Nettxt=document.getElementById("ctl00_MyCPH1_TotalNetpayable");
	                         var Nettot=parseFloat(Nettxt.value);
	                         var tot=parseFloat(sumtxt.value);
	         
             var mTotalRecords = "<%=intTotalRecords %>"
            
             //if (mTotalRecords>500)
              //  mTotalRecords='500'
            
                        for (var i=0; i < mTotalRecords; i++)
                        {
                            j = i + 2;
                        
                             if(j < 10)
                            {
                                chk_ind = "ctl00$MyCPH1$dgDocket$ctl" + "0" + j + "$chkOrderNo"
                                                                //alert(mDerivedControlName)
                            }
                            else
                            {
                                chk_ind = "ctl00$MyCPH1$dgDocket$ctl" + j + "$chkOrderNo"
                               
                            }
                            
                            var len=chk_ind.length;
                            var id2=chk_ind.substring(0,len-10);
                            
                            var txt=document.getElementById(id2+"hdncomm");
                            
                          // alert("hi..."+chk_ind)
                            if(document.getElementById(chk_ind).disabled==false)
                            {
                                if(obj.checked==true)
                                {
                                    document.getElementById(chk_ind).checked=true;
                                        var num=parseFloat(txt.value);
                                        
	                                    tot=tot+num;
	                                    Nettot=Nettot+num;
                                }
                                else
                                {
                                     document.getElementById(chk_ind).checked=false;
                                     var num=parseFloat(txt.value);
	                                 tot=tot-num;
	                                 Nettot=Nettot-num;
                                }
                            }
                           // alert("hi...22")
                       }
                       
                    sumtxt.value=rounditn(tot,2);
	                 Nettxt.value=rounditn(Nettot,2);
	                 
	                
	                 
            }
function  Check_num(obj){
		if (isNaN(obj.value))
    	{
     	 alert("Please enter in numeric")
      		obj.focus();
      		obj.value="0.00"
      	return false;
    	}
	}
	var FinYear="<%=Session["FinYear"]%>"
var FinYear_to=parseInt(FinYear)+1

if(FinYear_to<10)
{
FinYear_to="0"+FinYear_to
}
var FinYear_fromdate="01/04/"+FinYear
var FinYear_todate="31/03/"+FinYear_to
var Sle_finyear=FinYear+"-"+FinYear_to


    </script>

    <script type="text/javascript" language="JavaScript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	var months = new Array("","January", "February", "March", "April", "May", "June",
	"July", "August", "September", "October", "November", "December");
	
	function fnetCommission(id)
	{
	var len=id.length;
	 var id2=id.substring(0,len-10);
	 
	 var chk=document.getElementById(id);
	 var txt=document.getElementById(id2+"hdncomm");
	 var sumtxt=document.getElementById("ctl00_MyCPH1_txtNetCommission");
	  var Nettxt=document.getElementById("ctl00_MyCPH1_TotalNetpayable");
	 var Nettot=parseFloat(Nettxt.value);
	 var tot=parseFloat(sumtxt.value);
	 if(chk.checked==true)
	 {
	    var num=parseFloat(txt.value);
	    tot=tot+num;
	    Nettot=Nettot+num;
	 }
	 else
	 {
        var num=parseFloat(txt.value);
	    tot=tot-num;
	    Nettot=Nettot-num;
	 }
	    sumtxt.value=tot;
	     Nettxt.value=Nettot;
	}
	
	function fnetcalc()
	{
	    //alert("hi..")
	 var netCommission=parseFloat(document.getElementById("ctl00_MyCPH1_txtNetCommission").value);
   // alert(netCommission)
   document.getElementById("ctl00_MyCPH1_tds_chrg").value=Math.round(netCommission * (parseFloat(document.getElementById("ctl00_MyCPH1_tds_rate").value)/100))
	//alert(document.getElementById("ctl00_MyCPH1_tds_chrg").value)
	 var Nettxt=document.getElementById("ctl00_MyCPH1_TotalNetpayable");	  
	 var Nettot=parseFloat(Nettxt.value);
	// alert(Nettot)
	 var OT_plus=document.getElementById("ctl00_MyCPH1_oth_amt");
	  var OT_plustot=parseFloat(OT_plus.value);
	 
	   var OT_Minus=document.getElementById("ctl00_MyCPH1_oth_ded");
	   var OT_Minustot=parseFloat(OT_Minus.value);
	   var sumtxt=document.getElementById("ctl00_MyCPH1_txtNetCommission");
	   var sumtxttot=parseFloat(sumtxt.value);
	//   alert(sumtxttot)
	   tds_chrg=parseFloat(document.getElementById("ctl00_MyCPH1_tds_chrg").value)
	 var  abc=sumtxttot+OT_plustot-OT_Minustot-tds_chrg
	   Nettxt.value=Math.round(parseFloat(abc))
	   //Nettot=Math.round(parseFloat(abc))
	   // alert(Nettot)
	   // alert(Nettxt.value)
	}
	
	  function fsubmit()
	{
	
	 /////////////////   09 Feb 09 ///////////////////
	                 
	                
	            var GV_frmname="ctl00_MyCPH1_dgDocket_";
                var GV=document.getElementById("ctl00_MyCPH1_dgDocket");
                var rno = parseInt(GV.rows.length)+1;//"<%=intTotalRecords %>"
                var pref="";
                var chkcount=0;
                for(var ij=2;ij<rno;ij++)
                {
                        if(ij<10)
                             pref=GV_frmname + "ctl0" + ij + "_";                            
                        else
                             pref=GV_frmname + "ctl" + ij + "_";
                       
                        var chk=document.getElementById(pref + "chkOrderNo");
                         
                       if(chk.checked==true)
                       {
                         chkcount++; 
                       }                  
                }
	            if(chkcount==0)
                    {
                        alert("No Row Selected..........");
                        return false;
                    }
	                 
	                 /////////////////   09 Feb 09 ///////////////////
	
	
	
	
	var transdate=document.getElementById("ctl00_MyCPH1_transdate");
	
	if(transdate.value=="")
	{
		alert("Please enter Bill Generation Date!!!")
		transdate.focus();
		return false;
	}

//	 if(transdate.value!="")
//		    {
//		       if(!isValidDate(transdate.value,"Bill Generation Date!!!"))
//                     return false;
//		    }
		    
		    var vendorbilldt=document.getElementById("ctl00_MyCPH1_vendorbilldt");
		
	if(vendorbilldt.value=="")
	{
		alert("Please enter Vendor Bill Date!!!")
		vendorbilldt.focus();
		return false;
	}
	
//	 if(vendorbilldt.value!="")
//		    {
//		       if(!isValidDate(vendorbilldt.value,"Vendor Bill Date!!!"))
//                     return false;
//		    }
	
	var dt1 =vendorbilldt.value			
   // alert(dt)
	var dt_dd1=dt1.substring(0,2)	
	var dt_mm1=dt1.substring(3,5)
	var dt_yy1=dt1.substring(6,10)
		//alert(" hi .." + dt)
	bgndt1=new Date(months[parseFloat(dt_mm1)] + " " + parseFloat(dt_dd1) + ", " + parseFloat(dt_yy1))
	
    var dt =transdate.value			
    //alert(dt)
	var dt_dd=dt.substring(0,2)	
	var dt_mm=dt.substring(3,5)
	var dt_yy=dt.substring(6,10)
		//alert(" hi .." + dt)
	bgndt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
	//alert(bgndt)
			
	currdate="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
	dt_dd=currdate.substring(0,2)
	dt_mm=currdate.substring(3,5)
	dt_yy=currdate.substring(6,10)
	//alert("hi")
	currdate=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		
		
		
		
	///alert(currdate)
	if (currdate < bgndt)
	{
			alert("Bill Date should be less than or equal to  system Date \n")
			vendorbilldt.focus();
			return false;
	}
	
	var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2)
    var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5)
    var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10)
    FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))

    var FinYear_todate_dd=FinYear_todate.substring(0,2)
    var FinYear_todate_mm=FinYear_todate.substring(3,5)
    var FinYear_todate_yy=FinYear_todate.substring(6,10)
    FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))

    if (bgndt1>FinYear_todate1 || bgndt1<FinYear_fromdate1)
    {
    alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Financial Close Date Should Be Between "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
    vendorbilldt.focus();
    return false;
    }
    
    if (bgndt>FinYear_todate1 || bgndt<FinYear_fromdate1)
    {
    alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Financial Close Date Should Be Between "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
    transdate.focus();
    return false;
    }

	vendorbillno=document.getElementById("ctl00_MyCPH1_vendorbillno");
	if (vendorbillno.value=="") 
	{
		alert("Please enter vendor bill no!!!")
		vendorbillno.focus()
		return false; 
	}
	
	var duedt=document.getElementById("ctl00_MyCPH1_duedt");
	if(duedt.value=="")
	{
		alert("Please enter Due Date!!!")
		duedt.focus();
		return false;
	}
	
//	 if(duedt.value!="")
//		    {
//		       if(!isValidDate(duedt.value,"Vendor Bill Date!!!"))
//                     return false;
//		    }
		
	
		    var dt =duedt.value
	//alert(dt)
	var dt_dd=dt.substring(0,2)
	var dt_mm=dt.substring(3,5)
	var dt_yy=dt.substring(6,10)
		
	duedt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
	//alert(duedt)
		
	dt =vendorbilldt.value
	dt_dd=dt.substring(0,2)
	dt_mm=dt.substring(3,5)
	dt_yy=dt.substring(6,10)
		
	gendt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		//alert("hi.....1")
	if (duedt<gendt)
	{
	 alert( "Due Date Should be greater than Bill Date !!!")
	duedt.focus();
	 return false;
	}
	
	//alert("hi.....o0")
	   var txttds_rate=document.getElementById("ctl00_MyCPH1_tds_rate");
	    
	    if(parseFloat(txttds_rate.value)<0 || parseFloat(txttds_rate.value)>100 )
	    {
		    alert("Please enter proper 'TDS Rate'.")
		    txttds_rate.focus();
		    return false;
	    }
	    
	   
	    svtax_rate=document.getElementById("ctl00_MyCPH1_svtax_rate");
	    if (parseFloat(svtax_rate.value)<0 || parseFloat(svtax_rate.value)>100 )
	    {
		    alert("'Service Tax Rate'  should not be negative.")
		    svtax_rate.focus();
		    return false;
	    }
	    tds_chrg=document.getElementById("ctl00_MyCPH1_tds_chrg");
	    tdsacccode=document.getElementById("ctl00_MyCPH1_tdsacccode");
	    tdsfor=document.getElementById("ctl00_MyCPH1_tdsfor");
	   /// alert("hi.....2")
	    if(parseFloat(tds_chrg.value)>0)
	    {
		    if ((tdsacccode.value==""))
		    {
			    alert("Please select 'TDS Type' ")
			    tdsacccode.focus();
			    return false;
		    }
		    if ((tdsfor.value==""))
		    {
			    alert("'TDS  Deducted For' can be Blank.")
			    tdsfor.focus();
			    return false;
		    }
	    }
	    
	    fnetcalc();	
	   
    var totnet=document.getElementById("ctl00_MyCPH1_TotalNetpayable");
	TotalNetpayable=parseFloat(totnet.value)
	 
	    if (parseFloat(TotalNetpayable)<0)
	    {
		    alert("'Net amount' should not be negative.")
		    totnet.focus();
		    return false;
	    }
	    
	    
	    //////////////// 09 Feb 09 /////////////////////////////////
//	   //  alert("hi.....3")
//	      var GV_frmname="ctl00_MyCPH1_dgDocket_";
//                var GV=document.getElementById("ctl00_MyCPH1_dgDocket");

//                //var rno=GV.rows.length;
//                var rno = "<%=intTotalRecords %>"
////alert("hi.....3"+rno)
//                var pref="";
//                var chkcount=0;
//                
//                //if(rno>500)
//                 //   rno='500'
//                    
//    //  alert("hi....R.---"+rno)   
//       
//            
//                for(var ij=2;ij<rno;ij++)
//                {
//                
//                // alert("hi...."+ij)    
//                        if(ij<10)
//                             pref=GV_frmname + "ctl0" + ij + "_";                            
//                        else
//                             pref=GV_frmname + "ctl" + ij + "_";
//                       
//                        var chk=document.getElementById(pref + "chkOrderNo");
//                         
//                       if(chk.checked==true)
//                       {
//                         //alert(chk + " - "+ij+ " - "+rno)
//                         chkcount++; 
//                       }                  
//              
//                }//for loop ENDS HERE
//	    
//	     // alert("hi.....4")
//	      if(chkcount==0)
//                    {
//                        alert("No Row Selected..........");
//                        return false;
//                    }
                    
                    //////////////// 09 Feb 09 /////////////////////////////////
                    document.getElementById("ctl00_MyCPH1_TotalNetpayable").disabled=false
                     document.getElementById("ctl00_MyCPH1_txtNetCommission").disabled=false
//                    alert("done")
//                    return false;    
                    click_count=parseFloat(document.getElementById("ctl00_MyCPH1_click_count").value);
  //alert(click_count)
  
                                                        if(click_count > 0)
														{
															alert("Sorry... You cannot click twice !!!")
															return false;
														}  
														else
														{
														//alert(click_count)
															click_count=click_count+1
															//alert(click_count)
															document.getElementById("ctl00_MyCPH1_click_count").value=click_count
															//alert(click_count)
//														
//															document.frm.action = "DirectBAPayment_Submit.asp"  
//															document.frm.method = "post"
//															document.frm.submit()   
													    }    
													    
													    
													    alert("Success.....Total Dockets "+chkcount)
													    document.getElementById("ctl00_MyCPH1_TotalNetpayable").disabled=false;
													    document.getElementById("ctl00_MyCPH1_txtNetCommission").disabled=false;
	    // return false;
	            
	}
	
	
    </script>

    <asp:HiddenField ID="click_count" Value="0" runat="server" />
    <div align="left">
        <table style="width: 8.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong>&gt;<font
                            class="blklnkund"><strong> Finance </strong></font><font class="bluefnt"><strong>&gt;
                            </strong><strong>BA Bill Entry</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                    <div align="center">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="../../../images/back.gif" border="0" />
                    </a>
                </td>
            </tr>
            <tr>
                <td>
                    <table id="Table1" align="letf" runat="server" cellpadding="3" cellspacing="1" style="width: 5.5in;"
                        class="boxbg">
                        <tr style="background-color: #FFFFFF">
                            <td class="blackfnt" style="height: 10px">
                                <font class="balckfnt">Vendor</font></td>
                            <td>
                                <asp:Label ID="lblVend" runat="server" CssClass="blackfnt"></asp:Label></td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td class="blackfnt" style="height: 10px">
                                <font class="balckfnt">Booking Date </font>
                            </td>
                            <td>
                                <asp:Label ID="lblDockDt" runat="server" CssClass="blackfnt"></asp:Label></td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td class="blackfnt" style="height: 10px">
                                <font class="balckfnt">Type </font>
                            </td>
                            <td>
                                <asp:Label ID="lblTyp" runat="server" CssClass="blackfnt"></asp:Label></td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td class="blackfnt" style="height: 10px">
                                <font class="balckfnt">Mode </font>
                            </td>
                            <td>
                                <asp:Label ID="lblTyp1" runat="server" CssClass="blackfnt"></asp:Label></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td><br /><br />
                    <table id="Table3" align="left" runat="server" cellpadding="3" cellspacing="1" style="width: 9.0in;"
                        class="boxbg">
                        <tr style="background-color: #FFFFFF">
                            <td>
                                <asp:Label ID="Label2" Text="Bill Entry Number" runat="server" CssClass="blackfnt"></asp:Label></td>
                            <td>
                                <asp:Label ID="Label18" Text="System Generated..." ForeColor="red" runat="server"
                                    CssClass="blackfnt"></asp:Label></td>
                            <td>
                                <asp:Label ID="Label3" Text="Bill Entry date" runat="server" CssClass="blackfnt"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="transdate" CssClass="input" onblur="javascript:isValidDate(this.value,'Bill Generation Date!!!')"
                                    runat="server" Width="60" MaxLength="10"></asp:TextBox>
                                <a href="#" onclick="cal.select(ctl00$MyCPH1$transdate,'anchor1','dd/MM/yyyy'); return false;"
                                    name="anchor1" id="anchor1">
                                    <img src="../../../images/calendar.jpg" border="0"></img>
                                </a>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td>
                                <asp:Label ID="Label19" Text="Vendor Bill number" runat="server" CssClass="blackfnt"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="vendorbillno" CssClass="input" runat="server" Width="90" MaxLength="15"
                                    onblur="this.value=this.value.toUpperCase()"></asp:TextBox></asp:Label></td>
                            <td>
                                <asp:Label ID="Label21" Text="Vendor Bill date" runat="server" CssClass="blackfnt"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="vendorbilldt" CssClass="input" onblur="javascript:isValidDate(this.value,'Vendor Bill date!!!')"
                                    runat="server" Width="60" MaxLength="10"></asp:TextBox>
                                <a href="#" onclick="cal.select(ctl00$MyCPH1$vendorbilldt,'anchor2','dd/MM/yyyy'); return false;"
                                    name="anchor2" id="a1">
                                    <img src="../../../images/calendar.jpg" border="0"></img>
                                </a>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td>
                                <asp:Label ID="Label22" Text="Due date" runat="server" CssClass="blackfnt"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="duedt" CssClass="input" onblur="javascript:isValidDate(this.value,'Due Date!!!')"
                                    runat="server" Width="60" MaxLength="10"></asp:TextBox>
                                <a href="#" onclick="cal.select(ctl00$MyCPH1$duedt,'anchor12','dd/MM/yyyy'); return false;"
                                    name="anchor12" id="a2">
                                    <img src="../../../images/calendar.jpg" border="0"></img>
                                </a>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td>
                                <asp:Label ID="Label4" Text="Service Tax No." runat="server" CssClass="blackfnt"></asp:Label></td>
                            <td>
                            </td>
                            <td>
                                <asp:Label ID="Label5" Text="PAN Number" runat="server" CssClass="blackfnt"></asp:Label></td>
                            <td>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td>
                                <asp:Label ID="Label6" Text="Total Commission" runat="server" CssClass="blackfnt"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="txtNetCommission" Text="0" CssClass="input" Enabled="false" onBlur="javascript:Check_num(this)"
                                    runat="server" Width="60" MaxLength="10"></asp:TextBox></td>
                            <td>
                                <asp:Label ID="Label7" Text="TDS Type" runat="server" CssClass="blackfnt"></asp:Label></td>
                            <td>
                                <asp:DropDownList CssClass="input" ID="tdsacccode" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td>
                                <asp:Label ID="Label8" Text="Service Tax rate (%)" runat="server" CssClass="blackfnt"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="svtax_rate" Text="0.00" runat="server" Width="60" MaxLength="10"
                                    onBlur="javascript:Check_num(this);fnetcalc();"></asp:TextBox></td>
                            <td>
                                <asp:Label ID="Label9" Text="TDS Deducted For" runat="server" CssClass="blackfnt"></asp:Label></td>
                            <td>
                                <asp:DropDownList CssClass="input" ID="tdsfor" runat="server">
                                    <asp:ListItem Text="-- Select --" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Corporate" Value="C"></asp:ListItem>
                                    <asp:ListItem Text="Non Corporate" Value="NC"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td>
                                <asp:Label ID="Label10" Text="Service Tax (+) " runat="server" CssClass="blackfnt"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="svrcamt" Text="0.00" ReadOnly="true" runat="server" Width="60" MaxLength="10"
                                    onBlur="javascript:Check_num(this)" onchange="this.value=Math.round(this.value,3)"></asp:TextBox></td>
                            <td>
                                <asp:Label ID="Label11" Text="" runat="server" CssClass="blackfnt"></asp:Label></td>
                            <td>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td>
                                <asp:Label ID="Label12" Text="Cess (+)" runat="server" CssClass="blackfnt"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="cessamt" Text="0.00" runat="server" ReadOnly="true" Width="60" MaxLength="10"
                                    onBlur="javascript:Check_num(this)"></asp:TextBox></td>
                            <td>
                                <asp:Label ID="Label13" Text="Other Amount (+)" runat="server" CssClass="blackfnt"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="oth_amt" Text="0.00" CssClass="input" runat="server" Width="60"
                                    MaxLength="10" onBlur="javascript:Check_num(this);fnetcalc();"></asp:TextBox></td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td>
                                <asp:Label ID="Label14" Text="TDS rate (%)    " runat="server" CssClass="blackfnt"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="tds_rate" Text="0.00" runat="server" Width="60" MaxLength="10" onBlur="javascript:Check_num(this);fnetcalc();"></asp:TextBox></td>
                            <td>
                                <asp:Label ID="Label15" Text="Other Deductiom (-)" runat="server" CssClass="blackfnt"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="oth_ded" Text="0.00" CssClass="input" runat="server" Width="60"
                                    MaxLength="10" onBlur="javascript:Check_num(this);fnetcalc();"></asp:TextBox></td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td>
                                <asp:Label ID="Label16" Text="TDS amount (-)" runat="server" CssClass="blackfnt"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="tds_chrg" Text="0.00" runat="server" Width="60" MaxLength="10" onBlur="javascript:Check_num(this)"></asp:TextBox></td>
                            <td>
                                <asp:Label ID="Label17" Text="Net Amount " runat="server" CssClass="blackboldfnt"></asp:Label></td>
                            <td>
                                <asp:TextBox ID="TotalNetpayable" Enabled="false" CssClass="input" Text="0.00" runat="server"
                                    Width="60" MaxLength="10" onBlur="javascript:Check_num(this)"></asp:TextBox></td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td>
                                <asp:Label ID="Label20" Text="Remark" runat="server" CssClass="blackfnt"></asp:Label></td>
                            <td colspan="3">
                                <asp:TextBox ID="txtremarks" TextMode="MultiLine" runat="server" Width="200px" Height="60"></asp:TextBox></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="left" valign="top">
                <br /><br />
                    <asp:GridView align="Left" ID="dgDocket" runat="server" CellSpacing="1" CellPadding="2"
                        HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="false" PageSize="500"
                        PagerStyle-HorizontalAlign="left" CssClass="boxbg" FooterStyle-CssClass="boxbg"
                        PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                       OnPageIndexChanging="pgChange"  PagerSettings-LastPageText="[Last]" OnRowDataBound="dgDocket_RowDataBound" EmptyDataText="No Records Found...">
                        <Columns>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderTemplate>
                                    <center>
                                        <input type="checkbox" id="chkall" runat="server" class="input" onclick="javascript:checkall(this)" />
                                        <%--  <asp:CheckBox id="chkDock" runat="server"   />--%>
                                    </center>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <%-- <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>--%>
                                    <asp:CheckBox ID="chkOrderNo" runat="server" class="input" onclick="javascript:fnetCommission(this.getAttribute('id'))" />
                                    <asp:HiddenField ID="hdncomm" runat="server" Value='<% #DataBinder.Eval(Container.DataItem, "commission")%>' />
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" BackColor="white" />
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <ItemTemplate>
                                    <%-- <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>--%>
                                    <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" BackColor="white" />
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblColname" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lbldockno" Text='<% #DataBinder.Eval(Container.DataItem, "dockno")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" BackColor="white" />
                                <HeaderStyle Wrap="false" CssClass="blackfnt" />
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="docket" HeaderText="Docket No">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>--%>
                            <asp:BoundField DataField="dockdt" HeaderText=" Date">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="Center" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField DataField="orgncd" HeaderText="Origin ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="Center" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField DataField="REASSIGN_DESTCD" HeaderText="Destination ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="Center" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Cnor" HeaderText="Consignor  ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Cnee" HeaderText="Consignee   ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField DataField="NEw_cnne" HeaderText=" Billing Party  ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField DataField="PAYBASIS" HeaderText="Pay Basis">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField Visible="false" DataField="PAYBASIS" HeaderText="Pay BasisCode">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField DataField="tRANS_MODE" HeaderText="Mode">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText=" Bill No / MR No">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblBill_MRNo" Text='<% #DataBinder.Eval(Container.DataItem, "BILL_MRNO")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" BackColor="white" />
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText=" Bill/MR Collected ">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblBill_MRNoStatus" Text='<% #DataBinder.Eval(Container.DataItem, "BILL_MRNO_STATUS")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="pkgsno" HeaderText=" Package      ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField DataField="actuwt" HeaderText=" ActualWt   ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField DataField="subtot" HeaderText=" Sub Total   ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Stax_cess" HeaderText=" S.Tax+cess   ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField DataField="dkttot" HeaderText=" Total Amount  ">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fREIGHT" HeaderText="Freight Amount  ">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Deducation" HeaderText=" Deduction ">
                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" BackColor="white" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText=" SlabRate ">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblSlabrate" Text='<% #DataBinder.Eval(Container.DataItem, "Slabrate")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText=" Booking & Delivery Exp. ">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblCommossion" Text='<% #DataBinder.Eval(Container.DataItem, "commission")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <%-- <asp:BoundField DataField="Slabrate" HeaderText=" SlabRate ">
                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="commission" HeaderText=" Booking & Delivery Exp. ">
                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                       <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" BackColor="white" />
                    </asp:BoundField>--%>
                        </Columns>
                        <RowStyle />
                        <PagerStyle HorizontalAlign="Left" Font-Bold="true" CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]"
                            Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td>
                    <table id="Table4" align="center" runat="server" cellpadding="3" cellspacing="1"
                        style="width: 5.5in;">
                        <tr style="background-color: #FFFFFF">
                            <td bgcolor="#ffffff" align="center" colspan="4">
                                <br />
                                <asp:Button ID="btnShow" runat="server" Text="Submit" OnClientClick="javascript:return fsubmit()"
                                    Width="75px" OnClick="btnShow_Click" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
