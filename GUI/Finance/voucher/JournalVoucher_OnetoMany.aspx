<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="JournalVoucher_OnetoMany.aspx.cs" Inherits="GUI_finance_voucher_JournalVoucher_OnetoMany" Title="Untitled Page" %>
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
				//alert("hi...")
                // alert(dt)
                //  alert(FinYear_todate1)
                //   alert(FinYear_fromdate1)
           // return false;
				if (dt>server_dt)
				                {
						                alert( "JOurnal Voucher Date should not be greater than today's date !!!")
						                document.getElementById(Frmnae+"txtVoucherDate").focus();
						                return false;
				                }

            
        }
        </script>
 <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Journal Voucher</asp:Label>
                
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
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 700px"
        >
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
                <asp:TextBox ID="txtPrepareFor" runat="server" BorderStyle="Groove" CssClass="input"
                    MaxLength="5" Width="76px"></asp:TextBox>
            </td>
            <td align="left" class="blackfnt" valign="top">
                Party
            </td>
            <td align="left" class="blackfnt">
                <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 85%"
                    align="center">
                    <tr bgcolor="white">
                        <td align="left" class="blackfnt">
                            <font class="blackfnt">Customer </font>
                        </td>
                        <td align="left" class="blackfnt">
                            <asp:TextBox ID="txtCustCode" runat="server" BorderStyle="Groove" CssClass="input"
                                MaxLength="15"></asp:TextBox><asp:Button  runat = "server" ID="cmdctrpopup" Text="..." />
                        </td>
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
                        <td align="left" class="blackfnt">
                            <asp:TextBox ID="txtVendCode" runat="server" BorderStyle="Groove" CssClass="input"
                                MaxLength="15"></asp:TextBox><asp:Button  runat = "server" ID="cmdctrpopup1" Text="..." />
                        </td>
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
    </table>
    <br />
    <br />
    <table cellspacing="1"  class="boxbg" width="700" >
        <tr style="background-color: white">
            <td align="center">
                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server">Journal Voucher Detail</asp:Label>
            </td>
        </tr>
    </table>
    <br />
    <table cellspacing="1"  width="700" >
        <tr bgcolor="white">
            <td align="center">
                <asp:Label ID="lblAddRec" runat="server" Text="No of Rows" CssClass="bluefnt"></asp:Label>
                <asp:TextBox ID="txtNoOfRows" MaxLength="2" runat="server" Text="2" Width="25" BorderStyle="Groove"></asp:TextBox>
                <asp:UpdatePanel ID="UPAddRow" runat="server"   UpdateMode="Conditional" RenderMode="Inline">
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
                <asp:UpdatePanel ID="UpdatePanel1"  UpdateMode="Conditional" RenderMode="Inline" runat="server" >
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
                                <asp:TemplateField HeaderText="Debit" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:TextBox EnableViewState="true" ID="txtDebit" runat="server" Text="0" Width="80" AutoPostBack="true"
                                            MaxLength="10" CssClass="input" OnTextChanged="dg_totalDebit" BorderStyle="Groove"></asp:TextBox>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:TextBox ID="txtTotalDebit" EnableViewState="true" CssClass="input" runat="server" BorderStyle="groove" Width="74px" Text="0" ReadOnly ="true" > </asp:TextBox>
                                        <asp:CompareValidator ID="CompareValidator1" ControlToValidate="txtTotalDebit"  type="Double" ValueToCompare="0" Display="Dynamic"  runat="server" ErrorMessage="Total Debit should be greater than zero!!!" ValidationGroup="SYS" Operator="GreaterThan"></asp:CompareValidator>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Credit" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:TextBox EnableViewState="true" ID="txtCredit" runat="server" Text="0" Width="80" AutoPostBack="true" 
                                            MaxLength="10" CssClass="input" OnTextChanged="dg_totalCredit" BorderStyle="Groove"></asp:TextBox>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                    <asp:TextBox ID="txtTotalCredit"   EnableViewState="true" CssClass="input" runat="server" BorderStyle="groove" Width="75px" Text="0" ReadOnly ="true" ></asp:TextBox>
                                    <asp:CompareValidator ID="CompareValidator2" ControlToValidate="txtTotalCredit"  type =Double ControlToCompare="txtTotalDebit" Display="Dynamic"  runat="server" ErrorMessage="Total Debit should be equal to total Credit!!!" ValidationGroup="SYS" Operator="Equal" ></asp:CompareValidator>
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
                
                <asp:Button ID="cmdSubmit" runat="server" Text="Submit" ValidationGroup="SYS" OnClick="cmdSubmit_Click" />
                <br />
                
            </td>
        </tr>
    </table>
            </td>
         </tr>
 </table>
    
</asp:Content>

