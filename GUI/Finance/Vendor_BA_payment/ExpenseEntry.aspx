<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ExpenseEntry.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_ExpenseEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript">
    var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
    </script>

<script language="javascript" type="text/javascript">
var months = new Array("","January", "February", "March", "April", "May", "June",
	"July", "August", "September", "October", "November", "December");
// this function assignment in keypress doesn't allow any character other than number.
frm_name = "ctl00_MyCPH1_"

function fsubmit(cboVendorType,cboVendor,txtBillNumber,txtNetPayableAmt,cboTDS,cboCorporate)
	 	{
	 	    if(cboVendorType.value=="Select")
	 	    {
	 	        alert("Please select vendor type")
	 	        cboVendorType.focus();
	 	        return false;
	 	    }
	 	
	 	    if(cboVendor.value=="" || cboVendor.value=="-Select-")
	 	    {
	 	        alert("Please select vendor")
	 	        cboVendor.focus();
	 	        return false;
	 	    }
	 	
	 	    if(txtBillNumber.value=="")
	 	    {
	 	        alert("Please Enter the Vendor Bill Number")
	 	        txtBillNumber.focus()
	 	        return false;
	 	    }
	 	    varNetAmt = txtNetPayableAmt.value
	 	    if (parseFloat(varNetAmt)<=0.00)
	        {
		        alert("Bill Amount should be greater that zero , please specify expense details")
		        
		        return false;
	        }
	        
	        if(cboTDS.value=="Select")
	 	    {
	 	        alert("Please Select TDS")
	 	        cboTDS.focus();
	 	        return false;
	 	    }
	 	    
	 	    if(cboCorporate.value=="Select")
	 	    {
	 	        alert("Please Select TDS Type")
	 	        cboCorporate.focus();
	 	        return false;
	 	    }
	 	    
	 	    
	 	    
	 	    //var rows = document.getElementById("ctl00_MyCPH1_Grid1").rows.length;
	 	    
	 	    var grid=document.getElementById("ctl00_MyCPH1_Grid1");
            var rows=grid.rows.length;
            
            for(var i=2;i<rows;i++)
                {
                var pref="";
                if(i<10)
                    pref = "ctl00_MyCPH1_Grid1" + "_ctl0" + i + "_";
               else
                  pref = "ctl00_MyCPH1_Grid1" + "_ctl" + i + "_";

                 var cboAccGroupCode=document.getElementById(pref+"cboAccGroupCode");
                
                  if (document.getElementById("ctl00_MyCPH1_Grid1_ctl02_cboAccGroupCode").value=="")
                  {
                  alert("Plz select One Group code")
                  cboAccGroupCode.focus()
                  return false;
                  }
                if (cboAccGroupCode.value!="")
                {
                
                    if(document.getElementById(pref+"cboAccHeads").value=="")
                    
                     {
                     alert("Plz Select Account Code")
                     document.getElementById(pref+"cboAccHeads").focus()
                     return false;
                     }
                     
                }
            } //i LOOP ENDS HERE

 document.getElementById(frm_name+"txtBillAmt").disabled=false
  document.getElementById(frm_name+"txtNetAmt").disabled=false
   document.getElementById(frm_name+"txtDueDate").disabled=false
    document.getElementById(frm_name+"txtServiceTaxValue").disabled=false
     document.getElementById(frm_name+"txtEduCessValue").disabled=false
      document.getElementById(frm_name+"txt_H_EduCessValue").disabled=false
       document.getElementById(frm_name+"txtTDSValue").disabled=false
        document.getElementById(frm_name+"txtNetPayableAmt").disabled=false
      //  document.getElementById(frm_name+"cboAccHeads").disabled=false
      
        return true;
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
function AddNo(txt,tot,net,billamt)
{
var bl = new Boolean()
bl = false
var rows = document.getElementById("ctl00_MyCPH1_Grid1").rows.length;
var sum = 0;

tot="ctl00_MyCPH1_Grid1_ctl0" + rows + tot;

for(i=0 ;i<rows-2;i++)
{		
j = i+2

var id = "ctl00_MyCPH1_Grid1_ctl0" + j + txt

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

var id = "ctl00_MyCPH1_Grid1_ctl0" + j + txt

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
    net.value = sum; 
    document.getElementById("ctl00_MyCPH1_txtNetPayableAmt").value= sum; 
    billamt.value = sum;

if(val == "") return false 
 
 if(isNaN(val))
 {
 alert("Please Enter Only Number")
 document.getElementById(id).focus();
 return false;
 }
 if(Number(val) < 0 )
 {
    alert("Please Enter Positive Value")
    document.getElementById(id).focus();
    return false;
  }
  }
function AddRowNo(a,c)
{

}
function ratecalculation(rate,valu,net,cessrate,cessamt,tdsrate,tdsamt,hedurate,heduamt,othded,dicount)
{
    if(net.value !="")
    {
       
        net.value=parseFloat(document.getElementById("ctl00_MyCPH1_txtBillAmt").value)-parseFloat(othded.value)
        var appl_netamt =parseFloat(net.value)-parseFloat(othded.value)
       
        varrate = parseFloat(rate.value)
        varvalu = parseFloat(valu.value)
        varnet = parseFloat(net.value)

        varvalu = ((varnet * varrate)/100)
        valu.value = varvalu
        //alert(valu.value)
           if(valu.value!=0)
           {
            var cessamount = ((cessrate.value * parseFloat(valu.value))/100)
         //   alert(cessamount)
             cessamt.value = cessamount
                var H_cessamount = ((hedurate.value * parseFloat(valu.value))/100)
         //   alert(cessamount)
             heduamt.value = H_cessamount
           }
    
             var tdsamount = ((tdsrate.value * parseFloat(net.value))/100)
          
          tdsrate.value =rounditn(tdsrate.value ,3)
             tdsamt.value = tdsamount
     net.value=parseFloat(net.value)-parseFloat(dicount.value)
     document.getElementById("ctl00_MyCPH1_txtNetPayableAmt").value=parseFloat(net.value)+ parseFloat(valu.value)+ parseFloat(cessamt.value)+parseFloat(heduamt.value)-parseFloat(tdsamt.value)
    
    
    }
}

function TDScalculation(rate1,valu1,net1)
{
    if(rate1.value==0)
    {
      document.getElementById("ctl00_MyCPH1_txtNetPayableAmt").value=parseFloat(document.getElementById("ctl00_MyCPH1_txtNetPayableAmt").value)+ parseFloat(valu1.value)
    }
    
    if(net1.value !="")
    {
        varrate1 = parseFloat(rate1.value)
        varvalu1 = parseFloat(valu1.value)
        varnet1 = parseFloat(net1.value)

        varvalu1 = ((varnet1 * varrate1)/100)
        valu1.value = varvalu1
        net1.value =parseFloat(net1.value)- parseFloat(valu1.value)
        document.getElementById("ctl00_MyCPH1_txtNetPayableAmt").value=parseFloat(document.getElementById("ctl00_MyCPH1_txtNetPayableAmt").value)- parseFloat(valu1.value)
    }
  
    
}
function check()
{
		var dockdta=document.getElementById("ctl00_MyCPH1_txtBillDt").value
		
		dockdta_dd=dockdta.substring(0,2)
		dockdta_mm=dockdta.substring(3,5)
		dockdta_yy=dockdta.substring(6,10)
			
		var dockdt_billdt=new Date(months[parseFloat(dockdta_mm)] + " " + parseFloat(dockdta_dd) + ", " + parseFloat(dockdta_yy))
		var days=parseInt(document.getElementById("ctl00_MyCPH1_txtDueAfter").value)
      //  alert(days)
		dues=dateAdd('D',days,dockdt_billdt)
	
		document.getElementById("ctl00_MyCPH1_txtDueDate").value=Datadate1(dues)
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

</script>
    <br />
    <table border="0" cellspacing="1" cellpadding="4" style="width: 9.5in" align="left"
        >
        <tr  class="bgbluegrey">
            <td align="center">
                <font class="blackfnt"><b>Enter Supplier Details</b></font></td>
        </tr>
   
   <tr><td>
    <table border="0" cellspacing="1" cellpadding="4" style="width: 9.5in" align="left"
        class="boxbg">
        <tr bgcolor="#FFFFFF">
            <td align="left">
                <div align="left">
                    <font class="blackfnt">Bill Entry No</font>
                </div>
            </td>
            <td>
                <font class="blackfnt" color="red">System Generated...</font></td>
            <td align="left">
                <div align="left">
                    <font class="blackfnt">Bill Entry Date</font>
                </div>
            </td>
            <td>
                <font class="blackfnt">
                    <asp:TextBox ID="txtBillEntryDate" runat="server" Width="60px"></asp:TextBox>
                    <a href="#" onclick="cal.select(ctl00$MyCPH1$txtBillEntryDate,'anchor1','dd/MM/yyyy'); return false;"
                        name="anchor1" id="a1">
                        <img src="../../images/calendar.jpg" border="0" />
                    </a>(e.g. dd/mm/yyyy) </font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td>
                <font class="blackfnt">Select Vendor Type</font>
            </td>
            <td>
                <asp:UpdatePanel ID="updatepanel10" runat="server">
                    <ContentTemplate>
                        <asp:DropDownList ID="cboVendorType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboVendorType_SelectedIndexChanged">
                            <asp:ListItem Text="--All--" Value=""></asp:ListItem>
                        </asp:DropDownList>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
            <td align="left">
                <div align="left">
                    <font class="blackfnt">Vendor </font>
                </div>
            </td>
            <td colspan="1">
                <font class="blackfnt" color="red">
                    <asp:UpdatePanel ID="updatepanel11" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="cboVendor" runat="server" AutoPostBack="true">
                            </asp:DropDownList>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td height="21" bgcolor="#FFFFFF" align="left" width="166">
                <div align="left">
                    <font class="blackfnt">Bill Number</font></div>
            </td>
            <td height="21" bgcolor="#FFFFFF" align="left" width="222">
                <font class="blackfnt">
                    <asp:TextBox ID="txtBillNumber" runat="server" Width="60px"></asp:TextBox>
                </font>
            </td>
            <td>
                <div align="left">
                    <font class="blackfnt">Credit Account</font>
                </div>
                
            </td>
            <td>
             <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                <font class="blackfnt"><asp:Label  Font-Bold="true" ID="crediit_account" runat="server" Text="" ></asp:Label> </font>
                </ContentTemplate>
                    </asp:UpdatePanel>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td height="21" bgcolor="#FFFFFF" align="left" width="166">
                <div align="left">
                    <font class="blackfnt">Bill Amount</font>
                </div>
            </td>
            <td height="21" bgcolor="#FFFFFF" align="left" width="222">
                <font class="blackfnt">
                    <asp:TextBox ID="txtBillAmt" Enabled="false"  Font-Bold="true" runat="server" Width="60px" Text="0.00"></asp:TextBox>
                </font>
            </td>
            <td height="21" bgcolor="#FFFFFF" align="left" width="166">
                <div align="left">
                    <font class="blackfnt">Bill Date</font>
                </div>
            </td>
            <td height="21" bgcolor="#FFFFFF" align="left" width="222">
                <font class="blackfnt">
                    <asp:TextBox ID="txtBillDt" runat="server" Width="60px"></asp:TextBox>
                    <a href="#" onclick="cal.select(ctl00$MyCPH1$txtBillDt,'anchor2','dd/MM/yyyy'); return false;"
                        name="anchor2" id="a2">
                        <img src="../../images/calendar.jpg" border="0" />
                    </a>(e.g. dd/mm/yyyy) </font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td height="21" bgcolor="#FFFFFF" align="left" width="166">
                <div align="left">
                    <font class="blackfnt">Due after</font>
                </div>
            </td>
            <td height="21" bgcolor="#FFFFFF" align="left" width="222">
                <font class="blackfnt">
                    <asp:TextBox ID="txtDueAfter" onblur="javascript:check()" runat="server" Width="60px" Text="15"></asp:TextBox>(Days)
                </font>
            </td>
            <td height="21" bgcolor="#FFFFFF" align="left" width="166">
                <div align="left">
                    <font class="blackfnt">Due Date</font>
                </div>
            </td>
            <td height="21" bgcolor="#FFFFFF" align="left" width="222">
                <font class="blackfnt">
                    <asp:TextBox ID="txtDueDate" Enabled="false" runat="server" Width="60px"></asp:TextBox>
                </font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td>
                <div align="left">
                    <font class="blackfnt">Ref. No.</font>
                </div>
            </td>
            <td>
                <font class="blackfnt">
                    <asp:TextBox ID="txtRefNo" runat="server" Width="60px"></asp:TextBox>
                </font>
            </td>
            <td>
                <div align="left">
                    <font class="blackfnt">Remark</font>
                </div>
            </td>
            <td>
                <font class="blackfnt">
                    <asp:TextBox ID="txtRemarks" runat="server" Width="100px" TextMode="MultiLine" Height="20px"></asp:TextBox>
                </font>
            </td>
        </tr>
        
        <tr bgcolor="#FFFFFF">
            <td>
                <div align="left">
                    <font class="blackfnt"></font>
                </div>
            </td>
            <td>
                <font class="blackfnt">&nbsp; </font>
            </td>
            <td>
                <div align="left">
                    <font class="blackfnt"><strong>Net Amount</strong></font>
                </div>
            </td>
            <td>
                <font class="blackfnt">
                    <asp:TextBox ID="txtNetAmt"   Font-Bold="true"  Enabled="false" runat="server" Width="60px" Text="0.00"></asp:TextBox>
                </font>
            </td>
        </tr>
    </table>
   </td></tr>
   <tr><td>
    <table border="0" cellspacing="1" cellpadding="4" align="left" style="width: 9.5in"
        class="boxbg">
        <tr bgcolor="#FFFFFF">
            <td align="center">
                <font class="blackfnt"><b>Select the Account Head </b></font>
            </td>
        </tr>
    </table>
    </td></tr>
   <tr><td>
   
    <asp:UpdatePanel ID="u1" runat="server"            UpdateMode="Conditional">
        <ContentTemplate>
            <asp:GridView ID="Grid1" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                AllowSorting="true" AllowPaging="true" PageSize="5" PagerStyle-HorizontalAlign="left"
                CssClass="boxbg" BackColor="white" FooterStyle-CssClass="bgbluegrey" PagerSettings-Mode="NumericFirstLast"
                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                ShowFooter="true" EmptyDataText="No Records Found..." Style="width: 9.5in" OnRowDataBound="Grid1_RowDataBound" OnRowCreated="Grid1_RowCreated">
                <Columns>
                    <asp:TemplateField HeaderText="SRNo." HeaderStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" />
                        <ItemStyle CssClass="blackfnt" />
                        <ItemTemplate>
                            <font class="blackfnt">
                                <asp:Label ID="lblSRNo" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                </asp:Label>
                            </font>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Account Group" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                        HeaderStyle-Font-Bold="true">
                        <ItemTemplate>
                            <font class="blackfnt">
                                <asp:DropDownList ID="cboAccGroupCode" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboGroup">
                               <asp:ListItem Value="">Select</asp:ListItem>
                                </asp:DropDownList>
                            </font>
                        </ItemTemplate>
                        <FooterTemplate>
                            <center>
                                <font class="blackfnt">
                                    <asp:Label ID="lblnet" Text="Net Amount" runat="server" Font-Bold="true"></asp:Label>
                                </font>
                            </center>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Account Heads" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                        HeaderStyle-Font-Bold="true">
                        <ItemTemplate>
                            <font class="blackfnt">
                                <asp:DropDownList ID="cboAccHeads" EnableViewState="true" runat="server">
                                 <asp:ListItem Value="">Select</asp:ListItem>
                                </asp:DropDownList>
                            </font>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Debit" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                        HeaderStyle-Font-Bold="true">
                        <ItemTemplate>
                            <center>
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtDebit" onkeypress="javascript:return validFloat(event)" runat="server" Text="0.00" Width="60px"></asp:TextBox>
                                </font>
                            </center>
                        </ItemTemplate>
                        <FooterTemplate>
                            <center>
                                <font class="blackfnt">
                                    <asp:TextBox ID="txttotalDebit"   Enabled="false"  Font-Bold="true" runat="server" Text="0.00" Width="60px"></asp:TextBox>
                                </font>
                            </center>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Narration" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey"
                        HeaderStyle-Font-Bold="true">
                        <ItemTemplate>
                            <center>
                                <font class="blackfnt">
                                    <asp:TextBox ID="txtNarration" runat="server" Width="200px"></asp:TextBox>
                                </font>
                            </center>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
     </td></tr>
   <tr><td>
    <%--<table border="0" cellspacing="1" cellpadding="4" style="width:9.5in" align="left" class="boxbg">
								<tr class="bgbluegrey">
								  <td align="center"><font class="blackfnt"><b>Sr No</font></td>
								  <td align="center"><font class="blackfnt"><b>Account Group</font></td>
								  <td align="center"><font class="blackfnt"><b>Account Heads</font></td>
								  <td align="center" width="30px"><font class="blackfnt"><b>Debit</font></td>
								  <td align="center" style="width: 289px"><font class="blackfnt"><b>Narration</font></td>
								</tr>
								 <!-- first -->
								<tr bgcolor="#FFFFFF">
										  <td align="left"><font class="blackfnt">1</font></td>
										  <td  align="left" bgcolor="#FFFFFF"><font class="blackfnt">
												<asp:UpdatePanel ID="u1" runat="server">
												<ContentTemplate>
												<asp:DropDownList ID="cboGroup1" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboGroup1_SelectedIndexChanged">
												<%--<asp:ListItem Text="Select" Value=""></asp:ListItem>
												</asp:DropDownList>
												</ContentTemplate>
												</asp:UpdatePanel>
										  </font></td>
										  
										   <td  align="left" bgcolor="#FFFFFF" > 
												<asp:UpdatePanel ID="UpdatePanel5" runat="server">
												<ContentTemplate>
												<asp:DropDownList ID="cboHeads1" runat="server" AutoPostBack="true"></asp:DropDownList>
												</ContentTemplate>
												</asp:UpdatePanel>	
										   </td>
										
										  <td align="left"><font class="blackfnt">
										  <asp:TextBox ID="txtdebit1" runat="server" Width="60px"></asp:TextBox>
										  </font></td>
										  <td align="center" style="width: 289px"><font class="blackfnt">
										  <asp:TextBox ID="txtNarration1" runat="server" Width="200px"></asp:TextBox>
										  </font></td>
										  </tr>
										  
										 <!-- second -->
										 
										 <tr bgcolor="#FFFFFF">
										  <td align="left"><font class="blackfnt">2</font></td>
										  <td  align="left" bgcolor="#FFFFFF"><font class="blackfnt">
												<asp:UpdatePanel ID="UpdatePanel1" runat="server">
												<ContentTemplate>
												<asp:DropDownList ID="cboGroup2" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboGroup2_SelectedIndexChanged"></asp:DropDownList>
												</ContentTemplate>
												</asp:UpdatePanel>
										  </font></td>
										  
										   <td  align="left" bgcolor="#FFFFFF" > 
													<asp:UpdatePanel ID="UpdatePanel6" runat="server">
												<ContentTemplate>
												<asp:DropDownList ID="cboHeads2" runat="server" AutoPostBack="true"></asp:DropDownList>
												</ContentTemplate>
												</asp:UpdatePanel>
										   </td>
										
										  <td align="left"><font class="blackfnt">
										  <asp:TextBox ID="txtdebit2" runat="server" Width="60px"></asp:TextBox>
										  </font></td>
										  <td align="center" style="width: 289px"><font class="blackfnt">
										  <asp:TextBox ID="txtNarration2" runat="server" Width="200px"></asp:TextBox>
										  </font></td>
										  </tr>
										  
										   <!-- third -->
										   
										 <tr bgcolor="#FFFFFF">
										  <td align="left"><font class="blackfnt">3</font></td>
										  <td  align="left" bgcolor="#FFFFFF"><font class="blackfnt">
												<asp:UpdatePanel ID="UpdatePanel2" runat="server">
												<ContentTemplate>
												<asp:DropDownList ID="cboGroup3" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboGroup3_SelectedIndexChanged"></asp:DropDownList>
												</ContentTemplate>
												</asp:UpdatePanel>
										  </font></td>
										  
										   <td  align="left" bgcolor="#FFFFFF" > 
													<asp:UpdatePanel ID="UpdatePanel7" runat="server">
												<ContentTemplate>
												<asp:DropDownList ID="cboHeads3" runat="server" AutoPostBack="true"></asp:DropDownList>
												</ContentTemplate>
												</asp:UpdatePanel>
										   </td>
										
										  <td align="left"><font class="blackfnt">
										  <asp:TextBox ID="txtdebit3" runat="server" Width="60px"></asp:TextBox>
										  </font></td>
										  <td align="center" style="width: 289px"><font class="blackfnt">
										  <asp:TextBox ID="txtNarration3" runat="server" Width="200px"></asp:TextBox>
										  </font></td>
										  </tr>
										  
										  <!-- fourth -->
										  
										  <tr bgcolor="#FFFFFF">
										  <td align="left"><font class="blackfnt">4</font></td>
										  <td  align="left" bgcolor="#FFFFFF"><font class="blackfnt">
												<asp:UpdatePanel ID="UpdatePanel3" runat="server">
												<ContentTemplate>
												<asp:DropDownList ID="cboGroup4" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboGroup4_SelectedIndexChanged"></asp:DropDownList>
												</ContentTemplate>
												</asp:UpdatePanel>
										  </font></td>
										  
										   <td  align="left" bgcolor="#FFFFFF" > 
													<asp:UpdatePanel ID="UpdatePanel8" runat="server">
												<ContentTemplate>
												<asp:DropDownList ID="cboHeads4" runat="server" AutoPostBack="true"></asp:DropDownList>
												</ContentTemplate>
												</asp:UpdatePanel>
										   </td>
										
										  <td align="left"><font class="blackfnt">
										  <asp:TextBox ID="txtdebit4" runat="server" Width="60px"></asp:TextBox>
										  </font></td>
										  <td align="center" style="width: 289px"><font class="blackfnt">
										  <asp:TextBox ID="txtNarration4" runat="server" Width="200px"></asp:TextBox>
										  </font></td>
										  </tr>
										  
										   <!-- fifth -->
										  <tr bgcolor="#FFFFFF">
										  <td align="left"><font class="blackfnt">5</font></td>
										  <td  align="left" bgcolor="#FFFFFF"><font class="blackfnt">
												<asp:UpdatePanel ID="UpdatePanel4" runat="server">
												<ContentTemplate>
												<asp:DropDownList ID="cboGroup5" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboGroup5_SelectedIndexChanged"></asp:DropDownList>
												</ContentTemplate>
												</asp:UpdatePanel>
										  </font></td>
										  
										   <td  align="left" bgcolor="#FFFFFF" > 
													<asp:UpdatePanel ID="UpdatePanel9" runat="server">
												<ContentTemplate>
												<asp:DropDownList ID="cboHeads5" runat="server" AutoPostBack="true"></asp:DropDownList>
												</ContentTemplate>
												</asp:UpdatePanel>
										   </td>
										
										  <td align="left"><font class="blackfnt">
										  <asp:TextBox ID="txtdebit5" runat="server" Width="60px"></asp:TextBox>
										  </font></td>
										  <td align="center" style="width: 289px"><font class="blackfnt">
										  <asp:TextBox ID="txtNarration5" runat="server" Width="200px"></asp:TextBox>
										  </font></td>
										  
										  
										  
										</tr>
										
										 <tr bgcolor="#FFFFFF">
								 <td align="center" colspan="3"><font class="blackfnt"><b>Total</font></td>
								 						 
								 
								 <td><font class="blackfnt">
								 <asp:TextBox ID="txtTotalDebit" runat="server" Width="60px"></asp:TextBox>
								 </font></td>
								  <td style="width: 289px" ><font class="blackfnt">
								  
								  </font></td>
								  
								</tr>
								</table>--%>
     </td></tr>
   <tr><td>
    <%--<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />--%>
    <table border="0" cellspacing="1" cellpadding="4" style="width: 9.5in" align="left"
        class="boxbg">
        <tr bgcolor="#FFFFFF">
            <td align="center">
                <font class="blackfnt"><b>Tax Details</b></font></td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <table border="0" cellspacing="1" cellpadding="4" style="width: 9.5in" align="left"
        class="boxbg">
        <tr class="bgbluegrey">
            <td align="center">
                <font class="blackfnt"><b>Tax</font></td>
            <td align="center">
                <font class="blackfnt"><b>Account Head</font></td>
            <td align="center">
                <font class="blackfnt"><b>Approved Rate</font></td>
            <td align="center">
                <font class="blackfnt"><b>Value</font></td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td>
                <font class="blackfnt">Service Tax</font></td>
            <td>
                <font class="blackfnt">
                    <asp:Label ID="lblServiceTax1" runat="server" Text=""></asp:Label>
                </font>
            </td>
            <td>
                <font class="blackfnt"></font>
                <asp:TextBox ID="txtServiceTaxRate"  onkeypress="javascript:return validFloat(event)" runat="server" Width="60px" Text="0.00"></asp:TextBox>
            </td>
            <td>
                <font class="blackfnt"></font>
                <asp:TextBox ID="txtServiceTaxValue"   Enabled="false"  runat="server" Width="80px" Text="0.00"></asp:TextBox>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td>
                <font class="blackfnt">Education Cess</font></td>
            <td>
                <font class="blackfnt">
                    <asp:Label ID="lblEducationCess" runat="server"></asp:Label>
                </font>
            </td>
            <td>
                <font class="blackfnt"></font>
                <asp:TextBox ID="txtEduCessRate"  onkeypress="javascript:return validFloat(event)" runat="server" Width="60px" Text="0.00"></asp:TextBox>
            </td>
            <td>
                <font class="blackfnt"></font>
                <asp:TextBox ID="txtEduCessValue"  Enabled="false"   runat="server" Width="80px" Text="0.00"></asp:TextBox>
            </td>
        </tr>
          <tr bgcolor="#FFFFFF">
            <td>
                <font class="blackfnt">Higher Education Cess</font></td>
            <td>
                <font class="blackfnt">
                    <asp:Label ID="lbl_H_EducationCess" runat="server"></asp:Label>
                </font>
            </td>
            <td>
                <font class="blackfnt"></font>
                <asp:TextBox ID="txt_H_EduCessRate" onkeypress="javascript:return validFloat(event)" runat="server" Width="60px" Text="0.00"></asp:TextBox>
            </td>
            <td>
                <font class="blackfnt"></font>
                <asp:TextBox ID="txt_H_EduCessValue"   Enabled="false"  runat="server" Width="80px" Text="0.00"></asp:TextBox>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td>
                <font class="blackfnt">TDS</font></td>
            <td>
                <asp:DropDownList ID="cboTDS" runat="server">
                    <asp:ListItem Text="Select" Value=""></asp:ListItem>
                    <asp:ListItem Text="TDS PAYABLE CONTRACT" Value="P"></asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="cboCorporate" runat="server">
                    <asp:ListItem Text="Select" Value=""></asp:ListItem>
                    <asp:ListItem Text="Corporate" Value="C"></asp:ListItem>
                    <asp:ListItem Text="Non Corporate" Value="N"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <font class="blackfnt">
                    <asp:TextBox ID="txtTDSRate"  onkeypress="javascript:return validFloat(event)" runat="server" Width="60px" Text="0.0"></asp:TextBox>
                </font>
            </td>
            <td>
                <font class="blackfnt"></font>
                <asp:TextBox ID="txtTDSValue"  Enabled="false" runat="server" Width="80px" Text="0.00"></asp:TextBox>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td>
                <div align="left">
                    <font class="blackfnt">Other Deduction</font>
                </div>
            </td>
            <td>
                <font class="blackfnt">
                    <asp:TextBox ID="txtOtherDedudction"   onkeypress="javascript:return validFloat(event)"    runat="server" Width="60px" Text="0"></asp:TextBox>
                </font>
            </td>
            <td>
                <div align="left">
                    <font class="blackfnt">Discount Received</font>
                </div>
            </td>
            <td>
                <font class="blackfnt">
                    <asp:TextBox ID="txtDiscRecvd"   onkeypress="javascript:return validFloat(event)"  runat="server" Width="60px" Text="0"></asp:TextBox>
                </font>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td colspan="3">
                <font class="blackfnt"><b>Net Payable Amount</b></font></td>
            <td>
                <font class="blackfnt"></font>
                <asp:TextBox ID="txtNetPayableAmt" Font-Bold="true"  Enabled="false"  runat="server" Width="80px" Text="0.00"></asp:TextBox>
            </td>
        </tr>
    </table>
    </td></tr>
   <tr><td>
    <table border="0" cellspacing="1" cellpadding="4" style="width: 9.5in" align="left"
        class="boxbg">
        <tr bgcolor="#FFFFFF">
            <td colspan="4" align="center">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
            </td>
        </tr>
    </table>
     </td></tr>
   <tr><td>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
    </td></tr>
    </table>
    <script>
 function loadme()
 {
  
   check()
 }
 window.onload=loadme
</script>
</asp:Content>
