<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="BAPayment_Direct_step2.aspx.cs" Inherits="GUI_Finance_VendorPayment_new_BA_Payment_BAPayment_Direct_step2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript">
function  Check_num(obj){
		if (isNaN(obj.value))
    	{
     	 alert("Please enter in numeric")
      		obj.focus();
      		obj.value="0"
      	return false;
    	}
	}
    </script>

    <script type="text/javascript" language="JavaScript" src="../../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../../../images/commonJs.js"></script>

    <script type="text/javascript" language="JavaScript">
    var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	var months = new Array("","January", "February", "March", "April", "May", "June",
	"July", "August", "September", "October", "November", "December");
	var FinYear="<%=Session["FinYear"]%>"
var FinYear_to=parseInt(FinYear)+1

if(FinYear_to<10)
{
FinYear_to="0"+FinYear_to
}
var FinYear_fromdate="01/04/"+FinYear
var FinYear_todate="31/03/"+FinYear_to
var Sle_finyear=FinYear+"-"+FinYear_to
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

    
    
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
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
	     Nettxt.value=rounditn(Nettot,2);
	      var cboModeOfTransaction=document.getElementById("ctl00_MyCPH1_cboModeOfTransaction");
	     frm_name="ctl00$MyCPH1$"
	   if(cboModeOfTransaction.value=="Cash")
        {
       
         document.getElementById(frm_name+"txtCashAmount").value=Nettxt.value
         document.getElementById(frm_name+"txtPaymentAmt").value="0.00"
        
        }
        else 
        {
         document.getElementById(frm_name+"txtPaymentAmt").value=Nettxt.value
         document.getElementById(frm_name+"txtCashAmount").value="0.00"
        }
	}
	
	function fnetcalc()
	{
	
	 var netCommission=parseFloat(document.getElementById("ctl00_MyCPH1_txtNetCommission").value);
   // alert(netCommission)
   document.getElementById("ctl00_MyCPH1_tds_chrg").value=Math.round(netCommission * (parseFloat(document.getElementById("ctl00_MyCPH1_tds_rate").value)/100))
	
	 var Nettxt=document.getElementById("ctl00_MyCPH1_TotalNetpayable");	  
	 var Nettot=parseFloat(Nettxt.value);
	// alert(Nettot)
	 var OT_plus=document.getElementById("ctl00_MyCPH1_oth_amt");
	  var OT_plustot=parseFloat(OT_plus.value);
	 
	   var OT_Minus=document.getElementById("ctl00_MyCPH1_oth_ded");
	   var OT_Minustot=parseFloat(OT_Minus.value);
	   var sumtxt=document.getElementById("ctl00_MyCPH1_txtNetCommission");
	   var sumtxttot=parseFloat(sumtxt.value);
	    tds_chrg=parseFloat(document.getElementById("ctl00_MyCPH1_tds_chrg").value)
	 var  abc=sumtxttot+OT_plustot-OT_Minustot-tds_chrg
	   Nettxt.value=Math.round(parseFloat(abc))
	   
	   var cboModeOfTransaction=document.getElementById("ctl00_MyCPH1_cboModeOfTransaction");
	 // var OT_plustot=parseFloat(OT_plus.value);
	  // alert(cboModeOfTransaction.value)
	    frm_name="ctl00$MyCPH1$"
	   if(cboModeOfTransaction.value=="Cash")
        {
       
         document.getElementById(frm_name+"txtCashAmount").value=Nettxt.value
         document.getElementById(frm_name+"txtPaymentAmt").value="0.00"
        
        }
        else
        {
         document.getElementById(frm_name+"txtPaymentAmt").value=Nettxt.value
         document.getElementById(frm_name+"txtCashAmount").value="0.00"
        }
	   
	   //Nettot=Math.round(parseFloat(abc))
	   // alert(Nettot)
	   // alert(Nettxt.value)
	}
	
	
	function cahs_N_bank(obj)
    {
        frm_name="ctl00$MyCPH1$"
         var Nettxt=document.getElementById(frm_name+"TotalNetpayable");
        if(obj.value=="Cash")
        {
       
         document.getElementById(frm_name+"txtCashAmount").value=Nettxt.value
         document.getElementById(frm_name+"txtPaymentAmt").value="0.00"
        
        }
        else
        {
         document.getElementById(frm_name+"txtPaymentAmt").value=Nettxt.value
         document.getElementById(frm_name+"txtCashAmount").value="0.00"
        }
    }
	
	function fsubmit()
	{
	
	
	 var transdate=document.getElementById("ctl00_MyCPH1_transdate");
	
	if(transdate.value=="")
	{
		alert("Please enter Vaoucher Date!!!")
		transdate.focus();
		return false;
	}
	
	var dt =transdate.value			
    //alert(dt)
	var dt_dd=dt.substring(0,2)	
	var dt_mm=dt.substring(3,5)
	var dt_yy=dt.substring(6,10)
		//alert(" hi .." + dt)
	var bgndt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
	alert(bgndt)
			
	currdate="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
	dt_dd=currdate.substring(0,2)
	dt_mm=currdate.substring(3,5)
	dt_yy=currdate.substring(6,10)
	//alert("hi")
	currdate=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		
		
		
		
	///alert(currdate)
	if (currdate < bgndt)
	{
			alert("Voucher Date should be less than or equal to  system Date \n")
			transdate.focus();
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

    if (bgndt>FinYear_todate1 || bgndt<FinYear_fromdate1)
    {
        alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Financial Close Date Should Be Between "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
        transdate.focus();
        return false;
    }
	
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
	    
	    
	    
	    
	      var GV_frmname="ctl00_MyCPH1_dgDocket_";
                var GV=document.getElementById("ctl00_MyCPH1_dgDocket");

                var r=GV.rows.length;

                var pref="";
                var chkcount=0;
                for(var i=2;i<r+1;i++)
                {
                if(i<10)
                     pref=GV_frmname + "ctl0" + i + "_";
                else
                     pref=GV_frmname + "ctl" + i + "_";

                var chk=document.getElementById(pref + "chkOrderNo");
               if(chk.checked==true)
               {
                chkcount++; 
               }

                  
              
                }//for loop ENDS HERE
	    
	    
	      if(chkcount==0)
                    {
                        alert("No Row Selected..........");
                        return false;
                    }
	    
	    
	    
	    var transtype=document.getElementById("ctl00_MyCPH1_cboModeOfTransaction");
	    //alert("hi..12.")
	    /// alert(transtype.value)
	    if(transtype.value=="")
	    {
		    alert("Please Select Mode of transaction !!! ")
		    transtype.focus();
		    return false;
	    }
	    //debugger
	      acccode=document.getElementById("ctl00_MyCPH1_cboPaymentAccount");
	      chqno=document.getElementById("ctl00_MyCPH1_txtChequeNo");
	      chqdate=document.getElementById("ctl00_MyCPH1_txtChequeDate");
	      chequeamt=document.getElementById("ctl00_MyCPH1_txtPaymentAmt");
	      colamt=document.getElementById("ctl00_MyCPH1_txtPaymentAmt");
	      

	   
	    if(transtype.value=="Cash")
	    {
		   chqno.value=""
		   chqdate.value=""
		   chequeamt.value=0
		  
		    if (acccode.value.indexOf("CASH")<=0)
		    {
			    alert("Please select Cash Account!!!")
			   acccode.focus()
			    return false;
		    }
		     
	    }
	    
    //  alert(transtype.value)
	    
	    if(transtype.value=="Cheque" || transtype.value=="DD")
	    {
	    // alert("hi..222.")
	    // alert(acccode.value.indexOf("CASH"))
		    if(acccode.value.indexOf("BANK")<=0)
		    {
			    alert("Please select Bank Account!!!")
			   acccode.focus()
			     return false;
		    }
		    if(chqno.value=="")
		    {
			    alert("Please enter Cheque No/DD No ")
			   chqno.focus();
			    return false;
		    }
		    if(chqdate.value=="")
		    {
			    alert("Please enter Cheque /DD Date")
			   chqdate.focus();
			     return false;
		    }
		    if(chqdate.value!="")
		    {
		       if(!isValidDate(chqdate.value,"Chq Date"))
                     return false;
		    }
		    
		    
		   chequeamt.value=colamt.value
		 // alert("hiijj " + colamt.value)
		    if(chequeamt.value=="")
		    {
				    alert("Please enter Collection Amount")
				   chequeamt.focus();
				     return false;
		    }
		    if(parseFloat(chequeamt.value)<=0)
		    {
    			   
				    alert("Please enter cheque  Amount")
				   chequeamt.focus();
				    return false;
		    }
		    if(parseFloat(chequeamt.value)!=parseFloat(colamt.value))
		    {
    			   
				    alert("Cheque  Amount should be equal to collection amount!!!")
				   chequeamt.focus();
				    return false;
		    }
	    }
	                        
          //click_count=parseFloat(document.frm.click_count.value)    
  click_count=parseFloat(document.getElementById("ctl00_MyCPH1_click_count").value);
  //alert(click_count)
  document.getElementById("ctl00_MyCPH1_tds_chrg").disabled=false
  
  //alert("Success.....")
	    //return false;
	    
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
	            
	    
	    
	}
	
	
    </script>
    
    
<asp:HiddenField  ID="click_count" Value="0" runat="server"/>
   <table width="80%" border="0" align="left" cellpadding="0" cellspacing="0">
    	<tr> 
          <td height="30"><font class="blklnkund"><strong> Module</strong></font>
          
		<strong> &gt; </strong><font class="blklnkund"><strong> </strong></font>

<strong> &gt; </strong> <font class="blklnkund"><strong>Finance </strong></font>

<strong> &gt; </strong> <font class="blklnkund"><strong>BA Payment </strong></font>

<font class="bluefnt"><strong> &gt; </strong>
		  <strong>- Direct   </strong> </font></td>
        </tr>
        <tr> 
          <td class="horzblue"></td>
        </tr>
        <tr> 
          <td></td>
        </tr>

   
        
        <tr> 
          <td align="right"></td>
        </tr>
                   <tr> 
                      <td  valign="top">
				
<br />
<br />
    <table id="Table1" align="left" runat="server" cellpadding="3" cellspacing="1"
        style="width: 5.5in;" class="boxbg">
        <tr style="background-color: #FFFFFF">
            <td class="blackfnt" style="height: 10px">
                <font class="balckfnt">Vendor</font></td>
            <td>
                <asp:Label ID="lblVend" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #FFFFFF">
            <td class="blackfnt" style="height: 10px">
                <font class="balckfnt">Docket Date </font>
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
    </table>
    
    </td>
    </tr>
    <tr> 
          <td>
    <br />
  <table id="Table3" align="left" runat="server" cellpadding="3" cellspacing="1"
        style="width: 5.5in;" class="boxbg">
        <tr class="bgbluegrey">
            <td align="center">
                <asp:Label ID="Label1" Text="BA Payment Summary" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
    </table>
     </td>
    </tr>
    <tr> 
          <td>
    <br />
      
         <table id="Table5" align="letf" runat="server" cellpadding="3" cellspacing="1"
        style="width: 9.0in;" class="boxbg">
        <tr style="background-color: #FFFFFF">
            <td>
                <asp:Label ID="Label2" Text="Voucher Number" runat="server" CssClass="blackfnt"></asp:Label></td>
            <td>
                <asp:Label ID="Label18" Text="System Generated..." ForeColor="red" runat="server"
                    CssClass="blackfnt"></asp:Label></td>
            <td>
                <asp:Label ID="Label3" Text="Voucher Date" runat="server" CssClass="blackfnt"></asp:Label></td>
            <td>
                <asp:TextBox ID="transdate" CssClass="input" runat="server" Width="60" MaxLength="10"></asp:TextBox>
                <a href="#" onclick="cal.select(ctl00$MyCPH1$transdate,'anchor1','dd/MM/yyyy'); return false;"
                    name="anchor1" id="anchor1">
                    <img src="../../../images/calendar.jpg" border="0"></img>
                </a>
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
                <asp:TextBox ID="txtNetCommission" Text="0" CssClass="input" ReadOnly="true" onBlur="javascript:Check_num(this)"
                    runat="server" Width="60" MaxLength="10"></asp:TextBox></td>
            <td>
                <asp:Label ID="Label7" Text="TDS Type" runat="server" CssClass="blackfnt"></asp:Label></td>
            <td>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:DropDownList CssClass="input" ID="tdsacccode" runat="server" >
                        </asp:DropDownList></ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr style="background-color: #FFFFFF">
            <td>
                <asp:Label ID="Label8" Text="Service Tax rate (%)" runat="server" CssClass="blackfnt"></asp:Label></td>
            <td>
                <asp:TextBox ID="svtax_rate" Text="0.00" runat="server" Width="60" MaxLength="10"
                    onBlur="javascript:Check_num(this)"></asp:TextBox></td>
            <td>
                <asp:Label ID="Label9" Text="TDS Deducted For" runat="server" CssClass="blackfnt"></asp:Label></td>
            <td>
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <asp:DropDownList CssClass="input" ID="tdsfor" runat="server" >
                            <asp:ListItem Text="-- Select --" Value=""></asp:ListItem>
                            <asp:ListItem Text="Corporate" Value="C"></asp:ListItem>
                            <asp:ListItem Text="Non Corporate" Value="NC"></asp:ListItem>
                        </asp:DropDownList></ContentTemplate>
                </asp:UpdatePanel>
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
                <asp:TextBox ID="tds_rate" Text="0"   
                    runat="server" Width="60" MaxLength="10" onBlur="javascript:Check_num(this);fnetcalc();"></asp:TextBox></td>
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
                <asp:TextBox ID="tds_chrg" Text="0.00"   Enabled="false" runat="server" Width="60"
                    MaxLength="10" onBlur="javascript:Check_num(this)"></asp:TextBox></td>
            <td>
                <asp:Label ID="Label17" Text="Net Amount " runat="server" CssClass="blackboldfnt"></asp:Label></td>
            <td>
                <asp:TextBox ID="TotalNetpayable" ReadOnly="true" CssClass="input" Text="0.00" runat="server"
                    Width="60" MaxLength="10" onBlur="javascript:Check_num(this)"></asp:TextBox></td>
        </tr>
        
    </table>
     </td>
    </tr>
    <tr> 
          <td>
    <br />
    <%--<asp:UpdatePanel ID="UpdatePanel4" RenderMode="Inline"    UpdateMode="Conditional" runat="server">
        <ContentTemplate>--%>
            <asp:GridView align="left" ID="dgDocket" runat="server" CellSpacing="1" CellPadding="2"
                HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true" PageSize="200"
                PagerStyle-HorizontalAlign="left" CssClass="boxbg" FooterStyle-CssClass="boxbg"
                PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                PagerSettings-LastPageText="[Last]" OnRowDataBound="dgDocket_RowDataBound" EmptyDataText="No Records Found..."
                OnPageIndexChanging="pgChange" OnSelectedIndexChanged="dgDocket_SelectedIndexChanged">
                <Columns>
                    <asp:TemplateField HeaderText="SR.NO.">
                        <ItemTemplate>
                            <%-- <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>--%>
                                 
                            <asp:CheckBox ID="chkOrderNo" runat="server" class="input"   onclick="javascript:fnetCommission(this.getAttribute('id'))" />
                           <%-- <asp:HiddenField ID="hdncomm" runat="server" />--%>
                            <asp:HiddenField ID="hdncomm" runat="server" Value='<% #DataBinder.Eval(Container.DataItem, "commission")%>' />
                        </ItemTemplate>
                        <HeaderStyle CssClass="blackfnt" />
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="SR.NO.">
                                     <HeaderTemplate>
                                      <asp:Label CssClass="blackfnt" ID="lblColname"    runat="server"> </asp:Label>
                                     </HeaderTemplate>
                                        <ItemTemplate>
                                        
                                            <asp:Label CssClass="blackfnt" ID="lbldockno"  Text='<% #DataBinder.Eval(Container.DataItem, "docket")%>'        runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="blackfnt" />
                                    </asp:TemplateField>
                    <%--<asp:BoundField DataField="docket" HeaderText="Docket No">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>--%>
                    <asp:BoundField DataField="PAYBASIS" HeaderText="Pay Basis">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DOCKETDT" HeaderText=" Date">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ORGNCD" HeaderText="Origin ">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DESTCD" HeaderText="Destination ">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Cnor" HeaderText="Consignor  ">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Cnee" HeaderText="Consignee   ">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Cnor" HeaderText=" Billing Party  ">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="MR_BILL" HeaderText=" Bill No / MR No  ">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="MR_BILL_Status" HeaderText=" MR Status  ">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TRNMOD" HeaderText="Transport Mod">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>
                    <%--<asp:BoundField Visible="false" DataField="paybas" HeaderText="paybas">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField Visible="false" DataField="dely_door_yn" HeaderText="dely_door_yn">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField Visible="false" DataField="dely_godown_yn" HeaderText="dely_godown_yn">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" />
                    </asp:BoundField>--%>
                    <asp:BoundField DataField="pkgsno" HeaderText=" Package      ">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="actwt" HeaderText=" ActualWt   ">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="subtotal" HeaderText=" Sub Total   ">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Stax_cess_Hcess" HeaderText=" S.Tax+cess   ">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dkttot" HeaderText=" Total Amount  ">
                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="fREIGHT" HeaderText=" Freight Amount  ">
                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="deduction" HeaderText=" Deduction ">
                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="slabrate" HeaderText=" SlabRate ">
                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="commission" HeaderText=" Booking & Delivery Exp. ">
                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                    </asp:BoundField>
                     <asp:TemplateField Visible="false" HeaderText="">
                        <ItemTemplate>
                        
                        
                        <asp:Label  ID="dktval" Text='<%# DataBinder.Eval(Container.DataItem,"docket") %>'  runat="server"></asp:Label>
                        
                         <asp:Label  ID="lbldktno" Text='<%# DataBinder.Eval(Container.DataItem,"dockno") %>'  runat="server"></asp:Label>
                          <asp:Label  ID="lbldktsf" Text='<%# DataBinder.Eval(Container.DataItem,"docksf") %>'  runat="server"></asp:Label>
                         <asp:Label  ID="lblPaybas" Text='<%# DataBinder.Eval(Container.DataItem,"paybas") %>'  runat="server"></asp:Label>
                          <asp:Label  ID="lbltrnmod" Text='<%# DataBinder.Eval(Container.DataItem,"trn_mod") %>'  runat="server"></asp:Label>
                           <asp:Label  ID="lblorigin" Text='<%# DataBinder.Eval(Container.DataItem,"orgncd") %>'  runat="server"></asp:Label>
                            <asp:Label  ID="lbldestcd" Text='<%# DataBinder.Eval(Container.DataItem,"destcd") %>'  runat="server"></asp:Label>
                             <asp:Label  ID="lblpkgsno" Text='<%# DataBinder.Eval(Container.DataItem,"pkgsno") %>'  runat="server"></asp:Label>
                              <asp:Label  ID="lblactuwt" Text='<%# DataBinder.Eval(Container.DataItem,"actwt") %>'  runat="server"></asp:Label>
                               <asp:Label  ID="lblchrgwt" Text='<%# DataBinder.Eval(Container.DataItem,"chrgwt") %>'  runat="server"></asp:Label>
                        <asp:Label  ID="lbldkttot" Text='<%# DataBinder.Eval(Container.DataItem,"dkttot") %>'  runat="server"></asp:Label>
                             <asp:Label  ID="lblfreight" Text='<%# DataBinder.Eval(Container.DataItem,"freight") %>'  runat="server"></asp:Label>
                              <asp:Label  ID="lblcess" Text='<%# DataBinder.Eval(Container.DataItem,"cess") %>'  runat="server"></asp:Label>
                              <asp:Label  ID="lblsvctax" Text='<%# DataBinder.Eval(Container.DataItem,"svctax") %>'  runat="server"></asp:Label>
                               <asp:Label  ID="lblMR_BILL_Status" Text='<%# DataBinder.Eval(Container.DataItem,"MR_BILL_Status") %>'  runat="server"></asp:Label>
                               <asp:Label  ID="lblcommision" Text='<%# DataBinder.Eval(Container.DataItem,"commission") %>'  runat="server"></asp:Label>
                                 <asp:Label  ID="lblslabrate" Text='<%# DataBinder.Eval(Container.DataItem,"slabrate") %>'  runat="server"></asp:Label>
                                 <asp:Label  ID="lbldiplomatchg" Text='<%# DataBinder.Eval(Container.DataItem,"slabrate") %>'  runat="server"></asp:Label>
                                 <%--
                                 <asp:Label  ID="lbldely_door_yn" Text='<%# DataBinder.Eval(Container.DataItem,"dely_door_yn") %>'  runat="server"></asp:Label>
                                 <asp:Label  ID="lbldely_godown_yn" Text='<%# DataBinder.Eval(Container.DataItem,"dely_godown_yn") %>'  runat="server"></asp:Label>--%>
                        
                        </ItemTemplate></asp:TemplateField>
                </Columns>
                <RowStyle />
                <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                <FooterStyle CssClass="boxbg" />
            </asp:GridView>
            
             </td>
    </tr>
    <tr> 
          <td>
         <br />
<table border="0" cellspacing="1" cellpadding="4" style="width:9.5in" class="boxbg">
						<tr class="bgbluegrey"> 
          <td colspan="4" align="center"><font class="blackfnt">
           Payment Details</font>
          </td>
          </tr>
						<tr bgcolor="#FFFFFF">
						<td align="left"> <font class="blackfnt">Mode Of Transaction  </font></td>
				        <td align="left"> <font class="blackfnt">
				        <asp:UpdatePanel ID="u1" runat="server">
				        <ContentTemplate>
				        <asp:DropDownList ID="cboModeOfTransaction" runat="server"  AutoPostBack="true" OnSelectedIndexChanged="cboModeOfTransaction_SelectedIndexChanged"  Mode="Conditional" RenderMode="Inline" Width="60px" onchange="javascript:cahs_N_bank(this)">
				        <asp:ListItem Text="Select" Value=""></asp:ListItem>
				        <asp:ListItem Text="Cash" Value="Cash"></asp:ListItem>
				        <asp:ListItem Text="Cheque" Value="Cheque"></asp:ListItem>
				       
						</asp:DropDownList>
				        </font>
				        </ContentTemplate>
						</asp:UpdatePanel> 
                        </font></ContentTemplate> </asp:UpdatePanel>
				        </td>
				         <td align="left"> 
         
              <font class="blackfnt">Payment Account</font> 
         
          </td>
         
          <td align="left">
			<font class="blackfnt">
			<asp:UpdatePanel ID="UpdatePanel3" runat="server">
				        <ContentTemplate>
				        <asp:DropDownList ID="cboPaymentAccount"  AutoPostBack="true"  runat="server" Width="152px">
				        <asp:ListItem>--Select--</asp:ListItem>
						</asp:DropDownList>
						</ContentTemplate>
						<Triggers>
						<asp:AsyncPostBackTrigger ControlID="cboModeOfTransaction" EventName="SelectedIndexChanged" />
						</Triggers>
						</asp:UpdatePanel>
				        </font> 				
          </td>
				        </tr>
								 <tr bgcolor="#FFFFFF">
								  <td align="left"> 
           
              <font class="blackfnt">Cheque No </font> 
       
          </td>
         
          <td align="left"> 
            
              <font class="blackfnt"><asp:TextBox id="txtChequeNo" runat="server" Width="70px" MaxLength="6"></asp:TextBox></font> 
          
          </td>
           <td align="left"><font class="blackfnt">Cheque Date
            </font></td>
          <td align="left"> 
         
              <font class="blackfnt"><asp:TextBox id="txtChequeDate" runat="server" Width="70px" onblur="javascript:ValidateForm(this)"></asp:TextBox><a href="#"  onclick="cal.select(ctl00$MyCPH1$txtChequeDate,'anchor3','dd/MM/yyyy'); return false;"  name="anchor2" id="anchor3" ><img src="./../../../images/calendar.jpg" border="0" /> 
                                        </a>dd/mm/yyyy 
             </font> 
         
          </td>	 </tr>
          
          <tr bgcolor="#ffffff"> 
         <td align="left"><font class="blackfnt">Payment Amount</font></td>
          <td align="left"> 
          
              <font class="blackfnt"><asp:TextBox id="txtPaymentAmt" runat="server"  Enabled="false" Width="70px"></asp:TextBox></font> 
          
          </td>
          <td align="left"><font class="blackfnt">Cash Amount</font></td>
          <td align="left"> 
              <font class="blackfnt"><asp:TextBox id="txtCashAmount" runat="server" Width="70px" Enabled="false"></asp:TextBox></font>
          </td>
          </tr>
						 </table>
						 <br />
       <%-- </ContentTemplate>
    </asp:UpdatePanel>--%>
    <table id="Table4" align="center" runat="server" cellpadding="3" cellspacing="1"
        style="width: 5.5in;" >
        <tr style="background-color: #FFFFFF">
            
               <td bgcolor="#ffffff" align="center" colspan="4">
            <asp:Button ID="btnShow" runat="server" Text="Submit" Width="75px"  OnClientClick= "javascript:return fsubmit()"  OnClick="btnShow_Click"  /></td>
            
        </tr>
    </table>
    </td>
                    </tr>
                  <tr>
                      <td></td>
                    </tr>
                  </table>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
