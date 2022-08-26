<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="CreditVoucher.aspx.cs" Inherits="GUI_finance_voucher_CreditVoucher" Title="Untitled Page" %>
<%@ Register TagPrefix="UC2" TagName="UCReceiptControl" Src="~/UserControls/ReceiptControl.ascx" %>
<%@ Register TagPrefix="UC3" TagName="UCTDSPaymentControl" Src="~/UserControls/TDSPayment.ascx" %>
<%@ Register TagPrefix="UC1" TagName="UCAccount" Src="~/UserControls/UCAccount.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
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
		Frmnae="ctl00$MyCPH1$"
        function valid(obj,txtAmount,tran,chqno,chqdate)
        {
            var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
            var dt =document.getElementById(Frmnae+"txtVoucherDate").value
				 var MIn_dt="31/03/2008"
				            var dt_dd=dt.substring(0,2)
				            var dt_mm=dt.substring(3,5)
				            var dt_yy=dt.substring(6,10)

		                    var sdt =server_dt
				            var sdt_dd=sdt.substring(0,2)
				            var sdt_mm=sdt.substring(3,5)
				            var sdt_yy=sdt.substring(6,10)
            				var MIn_dt1 =MIn_dt;
				var MIn_dt_dd=MIn_dt1.substring(0,2);
				var MIn_dt_mm=MIn_dt1.substring(3,5);
				var MIn_dt_yy=MIn_dt1.substring(6,10);
				MIn_dt1=new Date(months[parseFloat(MIn_dt_mm)] + " " + parseFloat(MIn_dt_dd) + ", " + parseFloat(MIn_dt_yy));
				
            				
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
						alert( "You have Selected Finacial Year as "+Sle_finyear +" , SO Financial Close Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
						document.getElementById(Frmnae+"txtVoucherDate").focus();
						return false;
				}
				
				if (dt>server_dt)
				                {
						                alert( "Credit Voucher Date should not be greater than today's date !!!")
						                document.getElementById(Frmnae+"txtVoucherDate").focus();
						                return false;
				                }
//	            if (dt>MIn_dt1)
//				{
//						alert( "Debit Voucher  should  be less than 31 Mar 08 For Temorary Basis !!!");
//						document.getElementById(Frmnae+"txtVoucherDate").focus();
//						return false;
//				}
//           
           
            if (tran.value == "BANK")
            {
                if (chqno.value == "")
                {
                    alert("Enter Cheque Number");
                    return false;
                }   
                else if (chqdate.value == "")
                {
                    alert("Enter Cheque Date");
                    return false;
                }
                else if (txtAmount.value == '0.00')
                {
                     alert("Please Enter Amount !!")
                    return false;
                }
            }
            if(tran.value == "")
            {
                    alert("Select Mode Of Transaction");
                    return false;
            }
            
        }
        function calcu(obj,dlstTdsAcccode,txt3,txt1,txt2,payamt)
       {
        if(txt2.value > 0.00 )
        {
            if (dlstTdsAcccode.value == "")
            {
                alert("Please Select TDS Account First");
                txt2.value = "0.00";
            }
        }
        txt3.value = roundit((parseFloat(txt1.value) * parseFloat(txt2.value))/100);
        payamt.value = roundit(parseFloat(txt1.value) - parseFloat(txt3.value));
       }
       function roundit(Num)
	    {
		    Places=2
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
	    
	    function changeFocus(obj)
	    {
			document.getElementById('ctl00$MyCPH1$cmdSubmit').focus()
	    }
    </script>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Credit Voucher</asp:Label>
                <hr align="center" size="1" color="#8ba0e5" />
            </td>
        </tr>
    </table>
<br />
<br />
<table border="0" width="100%">
        <tr>
            <td width="10%">
            </td>
            <td width="90%" align="left">
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg"
        >
        <tr bgcolor="white">
            <td align="left" class="blackfnt">
                <font class="blackfnt">&nbsp;Voucher No </font>
            </td>
            <td align="left" class="blackfnt">
                <font class="blackfnt" color="red">&nbsp;System Generated...</font>
            </td>
            <td align="left" class="blackfnt">
                <font class="blackfnt">&nbsp;Voucher Date </font><font class="blackfnt" color="red">*</font></td>
            <td align="left" class="blackfnt">
                &nbsp;<asp:TextBox ID="txtVoucherDate" runat="server" BorderStyle="Groove" CssClass="input"
                    MaxLength="10" Width="60px"></asp:TextBox><font class="blackfnt">dd/mm/yyyy</font>&nbsp;&nbsp;&nbsp;
                     
                <%--<asp:RangeValidator ID="RangeVoucherDate"  Type="Date" runat="server" ErrorMessage="Please Enter Valid Date!!!" ControlToValidate="txtVoucherDate" Display="Dynamic"></asp:RangeValidator>
            --%>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" class="blackfnt">
                <font class="blackfnt">&nbsp;Manual No</font></td>
            <td align="left" class="blackfnt">
                &nbsp;<asp:TextBox ID="txtManualNo" runat="server" BorderStyle="Groove" CssClass="input"
                    MaxLength="25"  Width="111px"></asp:TextBox></td>
            <td align="left" class="blackfnt">
                <font class="blackfnt">&nbsp;Ref. No</font></td>
            <td align="left" class="blackfnt">
                <font class="redfnt">&nbsp;<asp:TextBox ID="txtRefNo" runat="server" BorderStyle="Groove" CssClass="input" MaxLength="50"
                        Width="76px"></asp:TextBox></font></td>
        </tr>
        <tr bgcolor="white">
            <td align="left" class="blackfnt">
                &nbsp;Prepared by</td>
            <td align="left" class="blackfnt">
                &nbsp;<asp:Label ID="lblPrepareBy" CssClass="blackfnt" Font-Bold="true" runat="server"></asp:Label>
            </td>
            <td align="left" class="blackfnt">
                &nbsp;Preapare At</td>
            <td align="left" class="blackfnt">
                &nbsp;<asp:Label ID="lblPrepareAt" CssClass="blackfnt" Font-Bold="true" runat="server"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" class="blackfnt" valign="top">
                &nbsp;Prepare for</td>
            <td align="left" class="blackfnt" valign="top">
                &nbsp;
                <asp:UpdatePanel ID="UP1" runat="server"     UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                    <asp:TextBox ID="txtPrepareFor" runat="server" BorderStyle="Groove" CssClass="input"
                    Width="76px" AutoPostBack="true" OnTextChanged="emp_check"></asp:TextBox>&nbsp;
                    </ContentTemplate>
                </asp:UpdatePanel>
                
            </td>
            <td align="left" class="blackfnt" valign="top">
                &nbsp;Party
            </td>
            <td align="left" class="blackfnt">
                <table border="0" cellpadding="1" cellspacing="1" class="boxbg">
                    <tr bgcolor="white">
                        <td align="left" class="blackfnt">
                            <font class="blackfnt">Customer </font>
                        </td>
                        <td align="left" class="blackfnt">
                            &nbsp;<asp:TextBox ID="txtCustCode" runat="server" BorderStyle="Groove" CssClass="input"
                                MaxLength="15"></asp:TextBox><asp:Button  runat = "server" ID="cmdctrpopup" Text="..." />
                        </td>
                        <td align="left" class="blackfnt">
                            <font class="blackfnt">&nbsp;8888 : </font><font class="redfnt">*</font></td>
                        <td align="left" class="blackfnt" style="width: 176px">
                            &nbsp;<asp:TextBox ID="txtCustName" runat="server" BorderStyle="Groove" CssClass="input"
                                MaxLength="50"></asp:TextBox>
                        </td>
                    </tr>
                    <tr bgcolor="white">
                        <td align="left" class="blackfnt">
                            <font class="blackfnt">Vendor </font>
                        </td>
                        <td align="left" class="blackfnt">
                            &nbsp;<asp:TextBox ID="txtVendCode" runat="server" BorderStyle="Groove" CssClass="input"
                                MaxLength="15"></asp:TextBox><asp:Button  runat = "server" ID="cmdctrpopup1" Text="..." />
                        </td>
                        <td align="left" class="blackfnt">
                            <font class="blackfnt">&nbsp;8888 : </font><font class="redfnt">*</font></td>
                        <td align="left" class="blackfnt" style="width: 176px">
                            &nbsp;<asp:TextBox ID="txtVendName" runat="server" BorderStyle="Groove" CssClass="input"
                                MaxLength="50"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" class="blackfnt" valign="top">
                &nbsp;Received From</td>
            <td align="left" class="blackfnt" colspan="5">
                &nbsp;<asp:TextBox ID="txtNarration" runat="server" BorderStyle="Groove" CssClass="input"></asp:TextBox>&nbsp;
            </td>
        </tr>
    </table>
    <br />
    <table cellspacing="1"  class="boxbg" width="700" >
        <tr style="background-color: white">
            <td align="center" style="height: 16px">
                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server">Credit Voucher Detail</asp:Label>
            </td>
        </tr>
    </table>
    <table cellspacing="1" width="700" >
        <tr bgcolor="white">
            <td align="center">
                <asp:Label ID="lblAddRec" runat="server" Text="No of Rows" CssClass="bluefnt"></asp:Label>
                <asp:TextBox ID="txtNoOfRows" MaxLength="2" runat="server" Text="2" Width="25" BorderStyle="Groove"></asp:TextBox>
                <asp:UpdatePanel ID="UPAddRow" runat="server"    UpdateMode="Conditional" RenderMode="Inline">
                    <ContentTemplate>
                        <asp:LinkButton ID="AddRow" runat="server" Text=" Go " CssClass="blackfnt" Font-Bold="true"
                            CausesValidation="false" OnClick="AddNewRow">
                        </asp:LinkButton>&nbsp;
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>   
        </tr>
        
        <tr style="background-color: white">
            <td align="center" width="100%" >
                <asp:UpdatePanel ID="UpdatePanel1"   UpdateMode="Conditional" RenderMode="Inline" runat="server" >
                    <ContentTemplate>
                        <asp:GridView EnableViewState="true" ID="dgGeneral" runat="server" BorderWidth="1" ShowFooter="true"
                            HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="true" AutoGenerateColumns="false"
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8ba0e5"
                            CellSpacing="2" CellPadding="2" OnRowDataBound="dg_RowDataBound" OnRowCommand="dg_RowCommand" Width="100%">
                          
                            <Columns>
                                <asp:TemplateField HeaderText="Particulars" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <UC1:UCAccount ID="txtAcccode" runat="server"   ></UC1:UCAccount>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:TextBox EnableViewState="true" ID="txtCredit" runat="server" Text="0" Width="80" AutoPostBack="true"
                                            MaxLength="10" CssClass="input" OnTextChanged="dg_totalCredit" BorderStyle="Groove"></asp:TextBox>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                    <asp:TextBox EnableViewState="true" ID="txtTotalCredit" runat="server" Text="0" Width="80" ReadOnly ="true"
                                            MaxLength="10" CssClass="input" BorderStyle="Groove"></asp:TextBox>
                                    
                                        
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Narration" ItemStyle-HorizontalAlign="right" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:TextBox EnableViewState="true" ID="txtNarration" runat="server" Text="" Width="125"
                                            MaxLength="100" CssClass="input" BorderStyle="Groove"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                              
                                
                            </Columns>
                            
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                            
                        </asp:GridView>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="AddRow" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
                <br />
                <UC3:UCTDSPaymentControl ID="UCTDSPayment" runat="server" TdsType="R" ></UC3:UCTDSPaymentControl>
                <br />
                <asp:UpdatePanel ID="UpdatePanePayment"  UpdateMode="Conditional" RenderMode="Inline" runat="server" >
                    <ContentTemplate>
                <UC2:UCReceiptControl  ID="UCReceipt" runat="server"  ></UC2:UCReceiptControl>
                </ContentTemplate> 
                </asp:UpdatePanel> 
                 <br />
                <asp:Button ID="cmdSubmit" runat="server" Text="Submit" ValidationGroup="SYS" OnClick="cmdSubmit_Click" />
                <br />
                
            </td>
        </tr>
    </table>
            </td>
        </tr>
</table>        
    
</asp:Content>

