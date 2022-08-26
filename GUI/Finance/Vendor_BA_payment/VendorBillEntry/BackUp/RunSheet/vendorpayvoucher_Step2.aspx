<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="vendorpayvoucher_Step2.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_VendorBillEntry_RunSheet_vendorpayvoucher_Step2" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
 <script language="javascript" type="text/javascript" src="../../../../images/commonJs.js"></script>
 <script language="javascript" type="text/javascript" src="../../../../images/CalendarPopup.js"></script>
<script language="javascript" type="text/javascript" >
    var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
    </script>
<script language="javascript" type="text/javascript">

var Form_name="ctl00$MyCPH1$"
var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");

function calculation(a,b,c,d)
{
if(document.getElementById(d).checked  == false)
{
document.getElementById(c).disabled = true

var rows1 = document.getElementById("ctl00_MyCPH1_BillDetail").rows.length;
 if(rows1<9)
    {
    var id1 = "ctl00_MyCPH1_BillDetail_ctl0" + rows1 + "_txtTotal"
    }
    else
    {
    var id1 = "ctl00_MyCPH1_BillDetail_ctl" + rows1 + "_txtTotal"
    }


document.getElementById(id1).value = parseFloat(document.getElementById(id1).value) - document.getElementById(c).value
document.getElementById('ctl00_MyCPH1_colamt').value =document.getElementById(id1).value
document.getElementById('ctl00_MyCPH1_netamt').value =parseFloat(document.getElementById('ctl00_MyCPH1_netamt').value) - parseFloat(document.getElementById(a).innerText)
document.getElementById(c).value = 0

}
else
{
document.getElementById(c).disabled = false
var tot
var varnetamt =document.getElementById(a).innerText
var varpendamt =document.getElementById(b).innerText
if(varpendamt == "")
{
 varpendamt = 0;
 tot = parseFloat(varnetamt) - parseFloat(varpendamt)

}
 tot = parseFloat(varnetamt) - parseFloat(varpendamt)
 
 document.getElementById(c).value = tot

 var rows = document.getElementById("ctl00_MyCPH1_BillDetail").rows.length;
 
 if(rows<9)
    {
    var id = "ctl00_MyCPH1_BillDetail_ctl0" + rows + "_txtTotal"
    }
    else
    {
    var id = "ctl00_MyCPH1_BillDetail_ctl" + rows + "_txtTotal"
    }
    if(document.getElementById('ctl00_MyCPH1_netamt').value=="")
    {
    document.getElementById('ctl00_MyCPH1_netamt').value=0.00
    }
 document.getElementById(id).value = parseFloat(tot)+ parseFloat(document.getElementById(id).value)
 document.getElementById('ctl00_MyCPH1_colamt').value =document.getElementById(id).value
 document.getElementById('ctl00_MyCPH1_netamt').value =parseFloat(tot)+ parseFloat(document.getElementById('ctl00_MyCPH1_netamt').value)
}

}

function total_colam(netamt)
{
	var collamount=0
	var netpayamt=0
	var currpayamt=0
	
	if (reccount>2)
	{
			for(i=0;i<reccount-1;i++)
			{
					
					if(chkDoc[i+1].checked==true)
					{ 
						collamount=Number(collamount)+Number(OCTOTALDUE[i].value)
						issueamt[i].value=issueamt_ori[i].value
						netpayamt=Number(netpayamt)+Number(OCTOTALDUE[i].value)
						currpayamt=Number(currpayamt)+Number(issueamt[i].value)
					}
					else
					{
						issueamt[i].value=0
					}
			}
	}
	else
	{
		for(i=0;i<reccount-1;i++)
			{
					
					if(chkDoc[i+1].checked==true)
					{ 
						collamount=netamt
						issueamt.value=issueamt_ori.value
						netpayamt=+Number(OCTOTALDUE.value)
						currpayamt=Number(currpayamt)+Number(issueamt.value)
					}
					else
					{
						issueamt.value=0
					}
			}
	}
	colamt.value=roundit(currpayamt)
	nettot.value=roundit(currpayamt)
	totissueamt.value=roundit(currpayamt)
	
}
function fvalidatePayAmt(a,maxVal,obj,d)
{
	maxVal = parseFloat(document.getElementById(a).innerText)
	CurrVal = parseFloat(document.getElementById(obj).value)
	
	if (CurrVal>maxVal)
	{
		alert("Maximum amount pending for payment is " + Math.round(maxVal))
		document.getElementById(obj).focus();
		return false;
	}
	var reccount= "<%=intTotalRecords%>"
	var currpayamt=0
	for(i=0;i<reccount;i++)
	{
	    j=i+2
	            if(j < 10)
                {
                                       
                    frm3=Form_name+"BillDetail$ctl"+"0"+j+"$"
                }
                else
                {
                    frm3=Form_name+"BillDetail$ctl"+j+"$"
                   
                }
               k=j+1
	        if(document.getElementById(d).checked  == true)
            {
            currpayamt=Number(currpayamt)+Number(document.getElementById(frm3+"txtCurrPayment").value)
            
            }
            else
            {
            document.getElementById(frm3+"txtCurrPayment").value=0;
            }
    }
            if(k < 10)
                {
                                       
                    frm3=Form_name+"BillDetail$ctl"+"0"+k+"$"
                }
                else
                {
                    frm3=Form_name+"BillDetail$ctl"+k+"$"
                   
                }        
   
   
     document.getElementById(frm3+"txtTotal").value=currpayamt;
     document.getElementById(Form_name+"colamt").value=currpayamt;
     //netamt.value = colamt.value
     //netamt.value = document.getElementById(Form_name+"colamt").value;
    
}

function fsubmit()
{
	 var mTotalRecords = "<%=intTotalRecords %>"
		 var mDerivedControlName = "";
            var mSelection = 0;
            var j = 0;
            var mSelectedDockets = "";
		for (var i=0; i < mTotalRecords; i++)
            {
                j = i + 2;
                if(i < 10)
                {
                    mDerivedControlName = "ctl00$MyCPH1$BillDetail$ctl" + "0" + j + "$chkBill"
                }
                else
                {
                    mDerivedControlName = "ctl00$MyCPH1$BillDetail$ctl" + j + "$chkBill"
                }
                
                //Populate Docket No.s for Preaparing Loading Sheet
                if(document.getElementById(mDerivedControlName))
                {
                    if(document.getElementById(mDerivedControlName).checked == true)
                    {
                        if(mSelection == 0)
                        {
                           mSelection=1 ;
                        }
                        else
                        {
                         mSelection = mSelection + 1
                        }
                        mSelectedDockets = (mSelectedDockets == "" ? document.getElementById(mDerivedControlName).value : mSelectedDockets + "," + document.getElementById(mDerivedControlName).value);
                       
                    }
                }
            }
            
            if(mSelection == 0)
            {
                alert("Select atleast one Bill to prepare payment voucher!");
                return false;
            }
	if(document.getElementById(Form_name+"txtVoucherDt").value=="")
	{
		alert("Please enter Voucher Date!!!")
		document.getElementById(Form_name+"txtVoucherDt").focus();
		return false;
	}
	
	if (ValidateForm(document.getElementById(Form_name+"txtVoucherDt"))==false)
	{
		return  false;
	}
	
	// Validation of enter date with System Date
	var dockdt=document.getElementById(Form_name+"txtVoucherDt").value
	
	
	dockdt_dd=dockdt.substring(0,2)
	dockdt_mm=dockdt.substring(3,5)
	dockdt_yy=dockdt.substring(6,10)
	
	
	var dockdt_user=new Date(months[parseFloat(dockdt_mm)] + " " + parseFloat(dockdt_dd) + ", " + parseFloat(dockdt_yy))

	var dockdt_sys=new Date()
	
	var d=new Date()
	d.setTime(dockdt_sys-dockdt_user)
	var tm=d.getTime()
	
	
	if (parseFloat(tm)<0)
	{
		alert("Voucher Date cannot be greater than System date !!!")
		document.getElementById(Form_name+"txtVoucherDt").focus();
		return  false;
	}
	
	transtype=document.getElementById(Form_name+"transtype").value
	
	if(transtype=="")
	{
		alert("Please Select Mode of transaction !!! ")
		document.getElementById(Form_name+"transtype").focus();
		return false;
	}
	
	if(document.getElementById(Form_name+"acccode").value=="")
	{
		alert("Please Select Cash / Bank Account !!! ")
		document.getElementById(Form_name+"acccode").focus();
		return false;
	}
		
	if(transtype=="Cash")
	{
		document.getElementById(Form_name+"chqno").value=""
		document.getElementById(Form_name+"chqdate").value=""
		
		if (document.getElementById(Form_name+"acccode").value.indexOf("CASH")<=0)
		{
			alert("Please select Cash Account!!!")
			document.getElementById(Form_name+"acccode").focus()
			return false;
		}
		
	} 
	if(transtype=="Cheque"||transtype=="DD")
	{
		if(document.getElementById(Form_name+"acccode").value.indexOf("BANK")<=0)
		{
			alert("Please select Bank Account!!!")
			document.getElementById(Form_name+"acccode").focus()
			return false;
		}
		if(document.getElementById(Form_name+"chqno").value=="")
		{
			alert("Please enter Cheque No/DD No ")
			document.getElementById(Form_name+"chqno").focus();
			return false;
		}
		if(document.getElementById(Form_name+"chqdate").value=="")
		{
			alert("Please enter Cheque /DD Date")
			document.getElementById(Form_name+"chqdate").focus();
			return false;
		}
		if(document.getElementById(Form_name+"chqdate").value!="")
		{
		   if (ValidateForm(document.getElementById(Form_name+"chqdate"))==false)
		   {
		   	 return false;
		   }
		}
		
	}
}

function ValidateForm(obj){

  if (obj.value!="")
  {
    
	if (isDate(obj.value)==false){
	
		obj.focus()
		return false
	}
    return true
  }  
 }
 var dtCh= "/";
 var minYear=1900;
 var maxYear=2100;
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
//	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
//		alert("Please enter a valid date")
//		return false
//	}
//	return true
}
</script>



<br />
<div align="left">
  <p align="left"><font class="blackfnt"><b>You Selected</b></font></p>
 
<table border="0" cellpadding="3" cols="1" style="width:9.5in" bgcolor="#808080" cellspacing="1" align="left" class="boxbg">
                              
                                <tr bgcolor="#FFFFFF"> 
                                  <td  width="205"> <font class="blackfnt">Agent Bill Date </font> </td>
                                  <td  width="343" align="center"> <div align="left"><font class="blackfnt">
                                  <asp:Label ID="lblAgentBillDate" runat="server"></asp:Label> 
                                  </font></div></td>
                                </tr>
                                <tr bgcolor="#FFFFFF"> 
                                  <td  width="205"> <font class="blackfnt">Vendor</font> 
                                  </td>
                                  <td  id="vendor11" width="343" align="center" visible="false"> <div align="left"><font class="blackfnt">
                                  <asp:Label ID="lblVendor1" runat="server"></asp:Label> 
                                  </font></div></td>
                                </tr>
                              
                            </table>
                            
                            <br />
                            <br />
                            <br />
                            <br />
                             <table cellspacing="1" cellpadding="3" border="0" bgcolor="#808080" style="width:9.5in" align="left" class="boxbg">
                              <tr class="bgbluegrey"> 
                                <td valign="top" height="18" colspan="4" align="center"><b><font class="blackfnt"><b>Vendor Payment Voucher Summary</b></font></b></td>
                              </tr>
                            </table>
                            
                            <br />
                            <br />
                            <br />
                            
                            <table cellspacing="1" cellpadding="3" border="0" bgcolor="#808080" style="width:9.5in"  align="left" class="boxbg">
                              <tr> 
                                <td valign="top"  bgcolor="#FFFFFF" width="25%"><font class="blackfnt"> 
                                  Payment Voucher No.</font></td>
                                <td valign="top"  bgcolor="#FFFFFF" align="center" width="20%"> 
                                  <div align="left"><font class="blackfnt" color="red">System generated... </font></div></td>
                                <td valign="top"  bgcolor="#FFFFFF" align="left" width="25%"><font class="blackfnt">Voucher Date</font></td>
                                <td valign="top"  bgcolor="#FFFFFF" align="left" width="20%"><font class="blackfnt">
                                  
                                  <asp:TextBox id="txtVoucherDt" runat="server" Width="60px"></asp:TextBox>
                                  <a href="#" onclick="cal.select(ctl00$MyCPH1$txtVoucherDt,'anchor1','dd/MM/yyyy'); return false;"  name="anchor1" id="a1" ><img src="../../../../images/calendar.jpg" border="0" /> 
                                        </a>
                                  </font></td>
                              </tr>
                              <tr> 
                                <td valign="top"  bgcolor="#FFFFFF" width="25%"><font class="blackfnt">Vendor</font></td>
                                <td valign="top"  bgcolor="#FFFFFF" align="left" width="20%" colspan="3"> 
                                  <div align="left"><font class="blackfnt"><asp:Label ID="lblVendor" runat="server"></asp:Label> 
                                    </font></div>
                                  
                                </td>
                              </tr>
                              <tr> 
                                <td valign="top"  bgcolor="#FFFFFF" width="25%"><font class="blackfnt"> 
                                  Vendor Service Tax no.</font></td>
                                <td valign="top"  bgcolor="#FFFFFF" align="left" width="20%"><asp:Label ID="lblServiceTaxNo" runat="server"></asp:Label> 
                                  </td>
                                <td valign="top"  bgcolor="#FFFFFF" align="left" width="25%"><font class="blackfnt">Vendor 
                                  PAN number</font></td>
                                <td valign="top"  bgcolor="#FFFFFF" align="left" width="20%"><font class="blackfnt">
                                <asp:Label ID="lblPANNo" runat="server"></asp:Label>
                                  </font></td>
                              </tr>
                              <tr> 
                                <td valign="top"  bgcolor="#FFFFFF" width="25%"><font class="blackfnt">&nbsp; 
                                  </font></td>
                                <td valign="top"  bgcolor="#FFFFFF" align="center" width="20%"> 
                                  <div align="left"><font class="blackfnt" > </font></div></td>
                                <td valign="top"  bgcolor="#FFFFFF" align="left" width="25%"><font class="blackfnt"><b>Net 
                                  Payable</b></font></td>
                                <td valign="top"  bgcolor="#FFFFFF" align="left" width="20%">
                                <asp:TextBox id="netamt" runat="server" Width="70px"></asp:TextBox>
                                </td>
                                
                              </tr>
                            </table>
                            <br />
                            <br /><br /><br /><br /><br /><br />
                            <table border="0" cellspacing="1" cellpadding="4" style="width:9.5in" align="left" class="boxbg">
                              <tr class="bgbluegrey"> 
                                <td colspan="4" align="center"><font class="blackfnt"><b> 
                                  Vendor Bill Details</b> </font></td>
                              </tr>
                            </table>
                            <br />
                            <br /><br />
                            
                            <!-- DataGrid -->
                            
<asp:GridView ID="BillDetail" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
AllowSorting="true" AllowPaging="true" PageSize="1000" PagerStyle-HorizontalAlign="left"
CssClass="boxbg" BackColor="white" FooterStyle-CssClass="bgbluegrey"
PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" ShowFooter="true"

EmptyDataText="No Records Found..." style="width:9.5in" OnRowCreated="BillDetail_RowCreated">
<Columns >
<asp:TemplateField FooterStyle-CssClass="bgbluegrey">

  
           <%-- <HeaderTemplate>
                <center>
                <asp:CheckBox runat="server" ID="HeaderLevelCheckBox" OnCheckedChanged="HeaderChecked" />
                </center>
            </HeaderTemplate>--%>
                <ItemTemplate>
                    <center>
                    <asp:CheckBox ID="chkBill" runat="server" AutoPostBack="true" /> 
                    <%--<input type="checkbox" id="chkDock" runat="server" class="input" value='<%# DataBinder.Eval(Container.DataItem,"BILLNO") %>' onclick="javascript:total_colam('<%# DataBinder.Eval(Container.DataItem,"netamt") %>')" />--%>
                    </center>
                </ItemTemplate>
                
     </asp:TemplateField>


<asp:TemplateField HeaderText="Bill Entry Number" HeaderStyle-CssClass="blackfnt"  FooterStyle-CssClass="bgbluegrey">
                <ItemTemplate>
                    <center>
                    <font class="blackfnt">
                    <asp:Label ID="BILLNO" Text='<%# DataBinder.Eval(Container.DataItem,"BILLNO") %>'  runat="server" ></asp:Label>
                    </font>
                    </center>
                </ItemTemplate>
                
     </asp:TemplateField>

<%--<asp:BoundField DataField="BILLNO" HeaderText="Bill entry number" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>--%>

<asp:BoundField DataField="vendorBILLNO" HeaderText="Vendor Bill Number "  FooterStyle-CssClass="bgbluegrey">
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>


<asp:BoundField DataField="VendorBill_DT" HeaderText="Vendor Bill date" FooterStyle-CssClass="bgbluegrey" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
</asp:BoundField>

<asp:BoundField DataField="Due_DT" HeaderText="Due Date"   FooterStyle-CssClass="bgbluegrey">
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
</asp:BoundField>

<asp:TemplateField HeaderText="Net Payable" HeaderStyle-CssClass="blackfnt"  FooterStyle-CssClass="bgbluegrey">
                <ItemTemplate>
                    <center>
                    <%--<input type="checkbox" id="chkDock" runat="server" class="input" value='<%# DataBinder.Eval(Container.DataItem,"BILLNO") %>' />--%>
                    <font class="blackfnt">
                    <asp:Label ID="netamt" Text='<%# DataBinder.Eval(Container.DataItem,"netamt") %>'  runat="server" ></asp:Label>
                    </font>
                    </center>
                </ItemTemplate>
                
     </asp:TemplateField>

<%--<asp:BoundField DataField="netamt" HeaderText="Net Payable" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>--%>

<asp:TemplateField HeaderText="Amount Paid" HeaderStyle-CssClass="blackfnt"  FooterStyle-CssClass="bgbluegrey">
                <ItemTemplate>
                    <center>
                    <%--<input type="checkbox" id="chkDock" runat="server" class="input" value='<%# DataBinder.Eval(Container.DataItem,"BILLNO") %>' />--%>
                    <font class="blackfnt">
                    <asp:Label ID="pendamt" Text='<%# DataBinder.Eval(Container.DataItem,"Advpaid") %>'  runat="server" ></asp:Label>
                    </font>
                    </center>
                </ItemTemplate>
                
     </asp:TemplateField>

<%--<asp:BoundField DataField="pendamt" HeaderText="Amount Paid" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>--%>

<asp:TemplateField HeaderText="Current Payment" HeaderStyle-CssClass="blackfnt" FooterStyle-CssClass="bgbluegrey">
                <ItemTemplate>
                    <center>
                    <asp:TextBox ID="txtCurrPayment" runat="server" Text="" Width="50px"></asp:TextBox>
                    </center>
                </ItemTemplate>
                <FooterTemplate  >
                <center>
                    <asp:TextBox ID="txtTotal" runat="server" Text="0" Width="50px"></asp:TextBox>
                    </center>
                </FooterTemplate>
</asp:TemplateField>

</Columns>
<PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
<HeaderStyle CssClass="bgbluegrey" />
<PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
/>
<FooterStyle CssClass="boxbg" />
</asp:GridView>
 
<br />

<table border="0" cellspacing="1" cellpadding="4" style="width:9.5in" align="left" class="boxbg">
                              <tr class="bgbluegrey"> 
                                <td colspan="4" align="center"><font class="blackfnt"> 
                                  <b>Payment Summary</b> </font></td>
                              </tr>
                            </table>
                            <br /><br />
                            <table border="0" cellspacing="1" cellpadding="4" style="width:9.5in" align="left" class="boxbg">
                              <tr bgcolor="#FFFFFF"> 
                                <td> <font class="blackfnt">Mode Of Transaction 
                                  </font></td>
                                <td> <font class="blackfnt">
                               <asp:DropDownList ID="transtype" runat="server">
                               <asp:ListItem Text="Select" Value=""></asp:ListItem>
                               <asp:ListItem Text="Cash" Value="Cash"></asp:ListItem>
                               <asp:ListItem Text="Cheque" Value="Cheque"></asp:ListItem>
                               <asp:ListItem Text="DD" Value="DD"></asp:ListItem>
                               </asp:DropDownList>
                                  
                                  </font> </td>
                                <td  > <font class="blackfnt">Issued From Account</font> 
                                </td>
                                <td>
                                <asp:DropDownList ID="acccode" runat="server">
                               </asp:DropDownList>
                               </td>
                              </tr>
                              <tr bgcolor="#FFFFFF"> 
                                <td> <font class="blackfnt">Cheque No </font> </td>
                                <td> <font class="blackfnt">
                                <asp:TextBox ID="chqno" runat="server" Text="" Width="50px" MaxLength="6"></asp:TextBox></font>
                                </td>
                                <td><font class="blackfnt">Cheque Date </font></td>
                                <td> <font class="blackfnt">
                                <asp:TextBox ID="chqdate" runat="server" Text="" Width="60px"></asp:TextBox>
                                <a href="#" onclick="cal.select(ctl00$MyCPH1$chqdate,'anchor2','dd/MM/yyyy'); return false;"  name="anchor2" id="a2" ><img src="../../../../images/calendar.jpg" border="0" /> 
                                        </a>
                                  dd/mm/yyyy </font> </td>
                              </tr>
                              
                              <tr bgcolor="#ffffff"> 
                                <td ><font class="blackfnt">Payment Amount</font></td>
                                <td> <font class="blackfnt">
                                  <asp:TextBox ID="colamt" runat="server" Text="" Width="50px"></asp:TextBox>
                                  </font> </td>
                                <td><font class="blackfnt">&nbsp;</font></td>
                                <td> </td>
                              </tr>
                            </table>
                            <br />
                            <div align="left">
                            <br /><br /><br /><br /><br />
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                            </div>
                            <div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></div>
</div>
</asp:Content>
