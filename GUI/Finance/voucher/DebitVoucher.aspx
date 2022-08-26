<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="DebitVoucher.aspx.cs" Inherits="GUI_finance_voucher_DebitVoucher" Title="Untitled Page" EnableViewState="true" %>
<%@ Register TagPrefix="UC1" TagName="UCAccount" Src="~/UserControls/UCAccount.ascx" %>
<%@ Register TagPrefix="UC2" TagName="UCPaymentControl" Src="~/UserControls/PaymentControl.ascx" %>
<%@ Register TagPrefix="UC3" TagName="UCTDSPaymentControl" Src="~/UserControls/TDSPayment.ascx" %>
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
        function openCust()
        {
            window.open('popup-cust.aspx' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
        }
        function openVend()
        {
            window.open('popup-vendor.aspx' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
        }
        function valid(obj,tran,chqno,chqdate,txtAmount)
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
						                alert( "Debit Voucher Date should not be greater than today's date !!!")
						                document.getElementById(Frmnae+"txtVoucherDate").focus();
						                return false;
				                }
//	            if (dt>MIn_dt1)
//				{
//						alert( "Debit Voucher  should  be less than 31 Mar 08 For Temorary Basis !!!");
//						document.getElementById(Frmnae+"txtVoucherDate").focus();
//						return false;
//				}
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
                else if (document.getElementById('ctl00$MyCPH1$UCPayment$dlstAcccode').value == '')
                {
                     alert("Please Select Bank Name !!")
                    return false;
                }
                else if (document.getElementById('ctl00$MyCPH1$UCPayment$txtAmount').value == '0.00')
                {
                     alert("Please Enter Amount !!")
                    return false;
                }
                else if(txtAmount.value == "0.00")
                {
                    alert("Please Enter Amount !!")
                    return false;
                }
            }
            else
            {
                var totalValue =parseInt(document.getElementById('ctl00$MyCPH1$dgGeneral$ctl04$txtTotalDebit').value);
                if (totalValue >=20000)
                {
                    alert("Total Voucher Amount should not be more than 19999");
                    return false;
                }
                if(document.getElementById('ctl00$MyCPH1$UCPayment$txtAmount').value == '0.00')
                {
                    alert("Please Enter Amount !!")
                    return false;
                }
                else if(txtAmount.value == "0.00")
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
        //alert(txt1.value)
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
	    function changePayment(obj)
	    {
	        alert("OK");
	    }
    </script>
         <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Debit Voucher</asp:Label>
                <hr align="center" size="1" color="#8ba0e5" />
            </td>
        </tr>
    </table>
     <table border="0" width="100%">
        <tr>
            <td width="10%">
            </td>
            <td width="90%" align="left">
            
<br />
<br />
    <table border="0" cellpadding="1" cellspacing="1" class="boxbg"
         width="786px">
        <tr bgcolor="white">
            <td align="left" class="blackfnt" width="20%">
                <font class="blackfnt">Voucher No </font>
            </td>
            <td align="left" class="blackfnt" width="20%">
                <font class="blackfnt" color="red">System Generated...</font>
            </td>
            <td align="left" class="blackfnt" width="20%">
                <font class="blackfnt">Voucher Date </font><font class="blackfnt" color="red">*</font></td>
            <td align="left" class="blackfnt" width="40%">
                <asp:TextBox ID="txtVoucherDate" runat="server" BorderStyle="Groove" CssClass="input"
                    MaxLength="10" Width="60px"></asp:TextBox><font class="blackfnt">dd/mm/yyyy</font>&nbsp;
            <asp:RequiredFieldValidator ID="RequiredFieldVoucherDate" runat="server" ErrorMessage="Please Enter Voucher Date!!!" ControlToValidate="txtVoucherDate" ></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionVoucherDate" runat="server" ControlToValidate="txtVoucherDate"
                            ErrorMessage="Please Enter Valid Date!!!" Display="Dynamic" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                     
               
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" class="blackfnt">
                <font class="blackfnt">Manual No</font></td>
            <td align="left" class="blackfnt">
                <asp:TextBox ID="txtManualNo" runat="server" BorderStyle="Groove" CssClass="input"
                    MaxLength="25"  Width="111px"></asp:TextBox></td>
            <td align="left" class="blackfnt">
                <font class="blackfnt">Ref. No</font></td>
            <td align="left" class="blackfnt">
                <font class="redfnt">
                    <asp:TextBox ID="txtRefNo" runat="server" BorderStyle="Groove" CssClass="input" MaxLength="50"
                        Width="76px"></asp:TextBox></font></td>
        </tr>
        <tr bgcolor="white">
            <td align="left" class="blackfnt">
                Prepared by</td>
            <td align="left" class="blackfnt">
                <asp:Label ID="lblPrepareBy" CssClass="blackfnt" Font-Bold="true" runat="server"></asp:Label>
            </td>
            <td align="left" class="blackfnt">
                Preapare At</td>
            <td align="left" class="blackfnt">
                <asp:Label ID="lblPrepareAt" CssClass="blackfnt" Font-Bold="true" runat="server"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" class="blackfnt" valign="top">
                Prepare for</td>
            <td align="left" class="blackfnt" valign="top">
            <asp:UpdatePanel ID="up1" runat="server"      UpdateMode="Conditional" RenderMode="Inline">
                <ContentTemplate>
                    <asp:TextBox ID="txtPrepareFor" runat="server" BorderStyle="Groove" CssClass="input"
                    Width="76px" AutoPostBack="true" OnTextChanged="emp_check"></asp:TextBox>
                    <asp:Label ID="error" runat="server" CssClass="redfnt"></asp:Label>
                </ContentTemplate>
            </asp:UpdatePanel>
                
            </td>
            <td align="left" class="blackfnt" valign="top">
                Party
            </td>
            <td align="left" class="blackfnt">
                <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 37%"
                    align="center">
                    <tr bgcolor="white">
                        <td align="left" class="blackfnt">
                            <font class="blackfnt">Customer </font>
                        </td>
                        <td align="left" class="blackfnt" style="width: 36px">
                            <asp:TextBox ID="txtCustCode" runat="server" BorderStyle="Groove" CssClass="input"
                                MaxLength="15" Width="136px"></asp:TextBox><input type="button" onclick="openCust()" value="..." /></td>
                        <td align="left" class="blackfnt">
                            <font class="blackfnt">8888 : </font><font class="redfnt">*</font></td>
                        <td align="left" class="blackfnt" style="width: 176px">
                            <asp:TextBox ID="txtCustName" runat="server" BorderStyle="Groove" CssClass="input"
                                MaxLength="50"></asp:TextBox>
                        </td>
                    </tr>
                    <tr bgcolor="white">
                        <td align="left" class="blackfnt">
                            <font class="blackfnt">Vendor </font>
                        </td>
                        <td align="left" class="blackfnt" style="width: 36px">
                            <asp:TextBox ID="txtVendCode" runat="server" BorderStyle="Groove" CssClass="input"
                                MaxLength="15" Width="137px"></asp:TextBox>
                            <input type="button" onclick="openVend()" value="..." /><%-- <asp:Button  runat = "server" ID="cmdctrpopup1" Text="..." />--%></td>
                        <td align="left" class="blackfnt">
                            <font class="blackfnt">8888 : </font><font class="redfnt">*</font></td>
                        <td align="left" class="blackfnt" style="width: 176px">
                            <asp:TextBox ID="txtVendName" runat="server" BorderStyle="Groove" CssClass="input"
                                MaxLength="50"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" class="blackfnt" valign="top">
                Pay To</td>
            <td align="left" class="blackfnt" colspan="3">
                <asp:TextBox ID="txtNarration" runat="server" BorderStyle="Groove" CssClass="input"
                    Width="150px" TextMode="MultiLine" Rows="3" Columns="25"></asp:TextBox>
            </td>
        </tr>
    </table>
    <br />
    <table cellspacing="1" class="boxbg" width="786" >
        <tr style="background-color: white">
            <td align="center">
                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server">Debit Voucher Detail</asp:Label>
            </td>
        </tr>
    </table>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
        <asp:Table ID="Table1" runat="server">
        <asp:TableRow>
        <asp:TableCell><asp:Image ID="imgwaiting" runat="server" ImageUrl="~/GUI/images/loading.gif" /></asp:TableCell>
        <asp:TableCell CssClass="blackfnt" Font-Bold="true">&nbsp; Please Wait</asp:TableCell>
        </asp:TableRow>
        </asp:Table>
        </ProgressTemplate>
        </asp:UpdateProgress>
    <table cellspacing="1"  width="786" >
        <tr bgcolor="white">
            <td align="center">
                <asp:Label ID="lblAddRec" runat="server" Text="No of Rows" CssClass="bluefnt"></asp:Label>
                <asp:TextBox ID="txtNoOfRows" MaxLength="2" runat="server" Text="2" Width="25" BorderStyle="Groove"></asp:TextBox>
                <asp:UpdatePanel ID="UPAddRow" runat="server"     UpdateMode="Conditional" RenderMode="Inline">
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
                <asp:UpdatePanel ID="UpdatePanel1"    UpdateMode="Conditional" RenderMode="Inline" runat="server" >
                    <ContentTemplate>
                        <asp:GridView EnableViewState="true" ID="dgGeneral" runat="server" BorderWidth="1" ShowFooter="true"
                            HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="true" AutoGenerateColumns="false"
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8ba0e5"
                            CellSpacing="2" CellPadding="2" OnRowDataBound="dg_RowDataBound" OnRowCommand="dg_RowCommand" Width="100%">
                          
                            <Columns>
                                <asp:TemplateField HeaderText="Particulars" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <UC1:UCAccount ID="txtAcccode" runat="server"></UC1:UCAccount>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:TextBox EnableViewState="true" ID="txtDebit" runat="server" Text="0" Width="80" AutoPostBack="true"
                                            MaxLength="10" CssClass="input" OnTextChanged="dg_totalDebit" BorderStyle="Groove"></asp:TextBox>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                    <asp:TextBox EnableViewState="true" ID="txtTotalDebit" runat="server" Text="0" Width="80" ReadOnly ="true"
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
                <UC3:UCTDSPaymentControl ID="UCTDSPayment" runat="server" TdsType="P" ></UC3:UCTDSPaymentControl>
                <br />
                <asp:UpdatePanel ID="UpdatePanePayment"   UpdateMode="Conditional" RenderMode="Inline" runat="server" >
                    <ContentTemplate>
                <UC2:UCPaymentControl ID="UCPayment" runat="server" ></UC2:UCPaymentControl>
                </ContentTemplate> 
                </asp:UpdatePanel> 
                 <br />
                 <asp:UpdatePanel ID="upSubmit"  UpdateMode="Always" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <asp:Button ID="cmdSubmit" runat="server" Text="Submit" ValidationGroup="SYS" OnClick="cmdSubmit_Click" />    
                    </ContentTemplate>
                 </asp:UpdatePanel>
                
                <br />
                
            </td>
        </tr>
    </table>
            </td>
        </tr>
     </table>
   
</asp:Content>


