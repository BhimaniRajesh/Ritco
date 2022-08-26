<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Result_Sub_Page.aspx.cs" Inherits="Octroi_Agent_Voucher_Result_Sub_Page" %>

<%@ Register TagPrefix="DateCalendar" TagName="Header" Src="~/DateCalendar.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="./../../images/commonJs.js"></script>

    <script type="text/javascript" language="javascript">
     var cal = new CalendarPopup("testdiv1"); 
	    cal.setCssPrefix("TEST");
	    cal.showNavigationDropdowns();
	    
    function check(cboBankAcc,cboTDSType,cboTDSDedu)
    {

        if(cboBankAcc.value=='- Select One -')
        {
            alert("Please Select Account Name")
            cboBankAcc.focus()
            return false
        }

if(parseFloat(document.getElementById(ctl00_MyCPH1_txtTDSAmt).value) > 0)
{

        if(cboTDSType.value=='- Select One -')
        {
            alert("Please Select The TDS Type")
            cboTDSType.focus()
            return false
        }
        if(cboTDSDedu.value=='Select')
        {
            alert("Please Select TDS Deducted Fro!!!")
            cboTDSDedu.focus()
            return false
        }
}
    }
    function checked(AgeChecked,gvAgentBill,txtNetPay)
    {
       // alert("Hello") 
        txtNetPay.value = gvAgentBill.value
    }
    function total()
    {
        
//        frmnme="ctl00$MyCPH1$gvAgentBill$ctl"
//        j=0
//        totalamt=0
//        for(i=0;i<3;i++)
//        {
//            j=i+2
//            alert(i)
//            if(i<10)
//            {
//            Formname=frmnme+"0"+j+"$"
//            }
//            else
//            {
//            Formname=frmnme+j+"$"
//            }
//            alert(document.getElementById(Formname+"txtCurrAmt").value)
//            
//            if(document.getElementById(Formname+"RowLevelCheckBox").checked)
//            {
//             //document.getElementById("ctl00_MyCPH1_txtNetPay").value=document.getElementById("ctl00$MyCPH1$gvAgentBill$ctl05$txtSubTot").value
//             alert(document.getElementById(Formname+"txtCurrAmt").value)
//             totalamt=parseFloat(totalamt)+parseFloat(document.getElementById(Formname+"txtCurrAmt").value)
//             alert(totalamt)
//             document.getElementById("ctl00_MyCPH1_txtNetPay").value=totalamt
//             }
//        }
//        return false;
    }
    function validmrdate(id)
{

    var txtdate=document.getElementById(id);
    
        if(!isValidDate(txtdate.value,"Date"))
        txtdate.focus();
            return false;
}
    </script>

    <br />
    <center>
        <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="True" Text="You Selected"></asp:Label>&nbsp;</center>
    <center>
        &nbsp;</center>
    <table align="center" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="background-color: #808080">
        <tr style="background-color: #ffffff" class="bgbluegrey">
            <td style="width: 211px; height: 10px">
                <label class="blackfnt">
                    &nbsp;Agent Bill Date</label></td>
            <td style="height: 10px">
                <asp:Label ID="lblDtFrom" runat="server" CssClass="blackfnt"></asp:Label>
                -
                <asp:Label ID="lblDtTo" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px; height: 15px">
                <label class="blackfnt">
                    &nbsp;<asp:Label ID="lblBillType" runat="server" CssClass="blackfnt"></asp:Label></label></td>
            <td style="width: 343px; height: 15px">
                <asp:Label ID="lblAgeType" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
    </table>
    <br />
    <center>
        <table style="width: 80%" cellpadding="1" cellspacing="1" class="boxbg">
            <tr class="bgbluegrey">
                <td colspan="3" rowspan="2" style="height: 21px" class="blackfnt">
                    <strong>Octroi Payment Voucher Summary</strong></td>
            </tr>
            <tr>
            </tr>
        </table>
    </center>
    <center>
        &nbsp;</center>
    <center>
        <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 80%;"
            align="center">
            <tr bgcolor="white">
                <td style="width: 20px">
                </td>
                <td class="blackfnt" align="left">
                    &nbsp;Payment Voucher No.</td>
                <td class="blackfnt" align="left">
                    <span style="color: #ff0000">&nbsp;System Generated...</span></td>
                <td class="blackfnt" align="left">
                </td>
                <td class="blackfnt" align="left">
                    &nbsp;Voucher Date</td>
                <td class="blackfnt" align="left">
                    <%--<DateCalendar:Header ID="EntryDt" runat="server"></DateCalendar:Header>--%>
                       <asp:TextBox ID="EntryDt" onblur="javascript:return validmrdate(this.getAttribute('id'));" Width="91px"
                                runat="server"></asp:TextBox><a href="#" onclick="cal.select(ctl00$MyCPH1$EntryDt,'anchor5','dd/MM/yyyy'); return false;"
                                    name="anchor5" id="a3">
                                    <img src="./../../images/calendar.jpg" border="0"></img>
                                </a><font class="blackfnt">dd/mm/yyyy</font>
                </td>
            </tr>
        </table>
        <%--<asp:UpdatePanel ID="UpdatePanel3" runat="server"           UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>--%>
        <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 80%;"
            align="center">
            <tr bgcolor="white">
                <td style="width: 20px" class="blackfnt" align="left">
                </td>
                <td class="blackfnt" align="left">
                    &nbsp;Octroi Agent</td>
                <td class="blackfnt" align="left" colspan="4">
                </td>
            </tr>
            <tr bgcolor="white">
                <td style="width: 20px" class="blackfnt" align="left">
                </td>
                <td class="blackfnt" align="left">
                    &nbsp;Agent Service Tax no.</td>
                <td class="blackfnt" align="left">
                </td>
                <td class="blackfnt" align="left">
                </td>
                <td class="blackfnt" align="left">
                    &nbsp;Agent PAN number</td>
                <td class="blackfnt" align="left">
                </td>
            </tr>
            <tr bgcolor="white">
                <td style="width: 20px;" class="blackfnt" align="left">
                    &nbsp;A</td>
                <td class="blackfnt" align="left">
                    &nbsp;Octroi paid (+)</td>
                <td class="blackfnt" align="left">
                    &nbsp;<asp:TextBox ID="txtOctAmt" runat="server" Width="92px" ReadOnly="True"></asp:TextBox></td>
                <td class="blackfnt" align="left">
                    &nbsp;G</td>
                <td class="blackfnt" align="left">
                    &nbsp;Deductions (-)</td>
                <td class="blackfnt" align="left">
                    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                        <ContentTemplate>
                            &nbsp;<asp:TextBox ID="txtDedu" runat="server" CssClass="blackfnt" Width="92px" AutoPostBack="true"
                                OnTextChanged="TextBox13_TextChanged1" TabIndex="1">0</asp:TextBox>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr bgcolor="white">
                <td style="width: 20px;" class="blackfnt" align="left">
                    &nbsp;B</td>
                <td class="blackfnt" align="left">
                    &nbsp;Agent service charge (+)</td>
                <td class="blackfnt" align="left">
                    &nbsp;<asp:TextBox ID="txtAgentChrg" runat="server" Width="92px" ReadOnly="True"></asp:TextBox>
                </td>
                <td class="blackfnt" align="left">
                    &nbsp;H</td>
                <td class="blackfnt" align="left">
                    &nbsp;TDS rate on (B+C)</td>
                <td class="blackfnt" align="left">
                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                        <ContentTemplate>
                            &nbsp;<asp:TextBox ID="txtTDSRate" runat="server" CssClass="blackfnt" Width="92px"
                                AutoPostBack="true" OnTextChanged="TextBox13_TextChanged1" TabIndex="2">0</asp:TextBox>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr bgcolor="white">
                <td style="width: 20px" class="blackfnt" align="left">
                    &nbsp;C</td>
                <td class="blackfnt" align="left">
                    &nbsp;Other charges (+)</td>
                <td class="blackfnt" align="left">
                    <strong>&nbsp;</strong><asp:TextBox ID="txtOtherChrg" runat="server" CssClass="blackfnt"
                        Width="92px" ReadOnly="True"></asp:TextBox></td>
                <td class="blackfnt" align="left">
                    &nbsp;I</td>
                <td class="blackfnt" align="left">
                    &nbsp;TDS amount (-)</td>
                <td class="blackfnt" align="left" style="font-weight: bold">
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            &nbsp;<asp:TextBox ID="txtTDSAmt" runat="server" CssClass="blackfnt" Width="92px"
                                AutoPostBack="true" OnTextChanged="TextBox13_TextChanged1" TabIndex="3" ReadOnly="True">0</asp:TextBox>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr bgcolor="white">
                <td style="width: 20px" class="blackfnt" align="left">
                    &nbsp;D</td>
                <td class="blackfnt" align="left">
                    &nbsp;Service tax charged (+)</td>
                <td class="blackfnt" align="left">
                    &nbsp;<asp:TextBox ID="txtSvcTax" runat="server" CssClass="blackfnt" Width="92px"
                        ReadOnly="True"></asp:TextBox></td>
                <td class="blackfnt" align="left">
                    &nbsp;J</td>
                <td class="blackfnt" align="left">
                    &nbsp;Service Tax Deduction</td>
                <td class="blackfnt" align="left">
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                        <ContentTemplate>
                            &nbsp;<asp:TextBox ID="txtSerTaxDedu" runat="server" CssClass="blackfnt" Width="92px"
                                AutoPostBack="true" OnTextChanged="TextBox13_TextChanged1" TabIndex="4">0</asp:TextBox>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr bgcolor="white">
                <td style="width: 20px; height: 26px;" class="blackfnt" align="left">
                    &nbsp;E</td>
                <td class="blackfnt" align="left" style="height: 26px">
                    &nbsp;Clearance charges (+)</td>
                <td class="blackfnt" align="left" style="height: 26px">
                    &nbsp;<asp:TextBox ID="txtClearChrg" runat="server" CssClass="blackfnt" Width="92px"
                        ReadOnly="True"></asp:TextBox></td>
                <td class="blackfnt" align="left" style="height: 26px">
                    &nbsp;K</td>
                <td class="blackfnt" align="left" style="height: 26px">
                    &nbsp;Form charges(+)</td>
                <td class="blackfnt" align="left" style="height: 26px">
                    &nbsp;<asp:TextBox ID="txtFromChrg" runat="server" CssClass="blackfnt" Width="92px"
                        ReadOnly="True"></asp:TextBox></td>
            </tr>
            <tr bgcolor="white">
                <td style="width: 20px; height: 21px;" class="blackfnt" align="left">
                    &nbsp;F&nbsp;</td>
                <td style="height: 21px" class="blackfnt" align="left">
                    &nbsp;Sundry charges (+)</td>
                <td style="height: 21px" class="blackfnt" align="left">
                    &nbsp;<asp:TextBox ID="txtSundryChrg" runat="server" CssClass="blackfnt" Width="92px"
                        ReadOnly="True"></asp:TextBox></td>
                <td style="height: 21px" class="blackfnt" align="left">
                    &nbsp;L</td>
                <td style="height: 21px" class="blackfnt" align="left">
                </td>
                <td style="height: 21px" class="blackfnt" align="left">
                </td>
            </tr>
            <tr bgcolor="white">
                <td style="width: 20px">
                </td>
                <td class="blackfnt" align="left">
                    <strong>&nbsp;Total charges</strong></td>
                <td class="blackfnt" align="left">
                    &nbsp;<asp:TextBox ID="txtTotChrg" runat="server" CssClass="blackfnt" Width="92px"
                        ReadOnly="True"></asp:TextBox></td>
                <td class="blackfnt" align="left">
                </td>
                <td class="blackfnt" align="left">
                    <strong>&nbsp;Total deduction</strong></td>
                <td class="blackfnt" align="left">
                    <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                        <ContentTemplate>
                            &nbsp;<asp:TextBox ID="TextBox13" runat="server" CssClass="blackfnt" Width="92px"
                                ReadOnly="True" OnTextChanged="TextBox13_TextChanged1"></asp:TextBox>&nbsp;
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr bgcolor="white">
                <td style="width: 20px" class="blackfnt" align="left">
                </td>
                <td class="blackfnt" align="left">
                </td>
                <td class="blackfnt" align="left">
                </td>
                <td class="blackfnt" align="left">
                </td>
                <td class="blackfnt" align="left">
                    <strong>&nbsp;Net Payable</strong></td>
                <td class="blackfnt" align="left">
                    &nbsp;<asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            &nbsp;<asp:TextBox ID="txtNetPay" runat="server" CssClass="blackfnt" Width="92px"
                                ReadOnly="True"></asp:TextBox>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
        &nbsp;&nbsp;</center>
    <center>
        &nbsp;</center>
    <br />
    <table style="width: 80%" cellpadding="1" cellspacing="1" class="boxbg" align="center">
        <tr class="bgbluegrey">
            <td colspan="3" rowspan="2" style="height: 21px" class="blackfnt" align="center">
                <strong>Agent Bill Details</strong></td>
        </tr>
        <tr>
        </tr>
    </table>
    <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server"    UpdateMode="Conditional" RenderMode="Inline">
        <ContentTemplate>
            <asp:GridView ID="gvAgentBill" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5" CellSpacing="1" CssClass="dgRowStyle"
                EmptyDataText="No Records Found..." HeaderStyle-CssClass="dgHeaderStyle" PagerStyle-HorizontalAlign="left"
                ShowFooter="True" OnRowDataBound="gvAgentBill_RowDataBound">
                <Columns>
                    <asp:TemplateField Visible="false">
                        <HeaderTemplate>
                            <asp:CheckBox Checked="true" Enabled="false" ID="HeaderLevelCheckBox" runat="server"
                                AutoPostBack="true" OnCheckedChanged="HeaderChecked" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox Checked="true" Enabled="false" ID="RowLevelCheckBox" runat="server"
                                AutoPostBack="true" OnCheckedChanged="RowChecked" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="ocbillno" HeaderText="Bill entry number" />
                    <asp:BoundField DataField="ocagbillno" HeaderText="Agent Bill Number">
                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ocagbilldt" HeaderText="Agent Bill date">
                        <ItemStyle HorizontalAlign="Center" />
                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ocagoctamt" HeaderText="Octroi paid by agent Rs." />
                    <asp:BoundField DataField="ocagserchrg" HeaderText="Agent service charge ">
                        <ItemStyle HorizontalAlign="Center" />
                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ocagothchrg" HeaderText="Other charges">
                        <ItemStyle HorizontalAlign="Center" />
                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    </asp:BoundField>
                    <asp:BoundField DataField="clearchrg" HeaderText="Clearance charges">
                        <ItemStyle HorizontalAlign="Center" />
                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    </asp:BoundField>
                    <asp:BoundField DataField="formchrg" HeaderText="Form charges">
                        <ItemStyle HorizontalAlign="Center" />
                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    </asp:BoundField>
                    <asp:BoundField DataField="sundrychrg" HeaderText="Sundry charges">
                        <ItemStyle HorizontalAlign="Center" />
                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    </asp:BoundField>
                    <asp:BoundField DataField="actserchrg" HeaderText="Service Tax charged">
                        <ItemStyle HorizontalAlign="Center" />
                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="Total">
                        <ItemTemplate>
                            <asp:Label Text='<%# DataBinder.Eval(Container.DataItem,"octotaldue") %>' runat="server"
                                ID="lblTotal"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="servchargeper" HeaderText="Amount Paid" />
                    <asp:TemplateField HeaderText="Current Payment">
                        <ItemTemplate>
                            <asp:TextBox ID="txtCurrAmt" BorderWidth="0" BorderStyle="none" Text='<%# DataBinder.Eval(Container.DataItem,"octotaldue") %>'
                                runat="server" Width="90%" Enabled="false"></asp:TextBox>
                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtSubTot" runat="server" Width="90%" Enabled="false"></asp:TextBox>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="ocduedt" HeaderText="Due date" />
                </Columns>
                <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                <PagerStyle HorizontalAlign="Left" />
                <HeaderStyle CssClass="dgHeaderStyle" />
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <br />
    <table style="width: 80%" cellpadding="1" cellspacing="1" class="boxbg" align="center">
        <tr class="bgbluegrey">
            <td colspan="3" rowspan="2" style="height: 21px" class="blackfnt" align="center">
                <strong>Payment summary</strong></td>
        </tr>
        <tr>
        </tr>
    </table>
    <br />
    <asp:UpdatePanel ID="UpdatePanel9" runat="server">
        <ContentTemplate>
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 80%;"
                align="center">
                <tr bgcolor="white">
                    <td class="blackfnt" align="left">
                        &nbsp;Mode Of Transaction</td>
                    <td class="blackfnt" align="left" style="width: 201px">
                        &nbsp;<asp:DropDownList ID="DropDownList1" OnSelectedIndexChanged="cboModeOfTransaction_SelectedIndexChanged"
                            AutoPostBack="true" runat="server">
                            <asp:ListItem>Cash</asp:ListItem>
                            <asp:ListItem>Cheque</asp:ListItem>
                            <asp:ListItem>DD</asp:ListItem>
                        </asp:DropDownList></td>
                    <td class="blackfnt" align="left">
                        &nbsp;Issued from Account
                    </td>
                    <td class="blackfnt" align="left">
                        &nbsp;<asp:DropDownList ID="cboBankAcc" runat="server">
                        </asp:DropDownList></td>
                </tr>
                <tr class="blackfnt" align="left" bgcolor="white">
                    <td class="blackfnt" align="left">
                        &nbsp;Cheque No</td>
                    <td class="blackfnt" align="left" style="width: 201px">
                        &nbsp;<asp:TextBox ID="txtChequeNo"  MaxLength="6" runat="server" Width="115px"></asp:TextBox></td>
                    <td class="blackfnt" align="left">
                        &nbsp;Cheque Date</td>
                    <td class="blackfnt" align="left">
                        &nbsp;<asp:TextBox ID="txtChequeDt" runat="server" Width="94px"></asp:TextBox>
                        <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="[dd/mm/yyyy]"></asp:Label>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtChequeDt"
                            ErrorMessage="Invalid Date" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                            ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator><br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtChequeDt"
                            ErrorMessage="Enter Date"></asp:RequiredFieldValidator></td>
                </tr>
                <tr bgcolor="white">
                    <td class="blackfnt" align="left">
                        &nbsp;Payment Amount</td>
                    <td class="blackfnt" align="left">
                        <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                            <ContentTemplate>
                                &nbsp;<asp:TextBox ID="txtPayAmt" runat="server" Width="72px" Enabled="False"></asp:TextBox></td>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <td class="blackfnt" align="left">
                            &nbsp;TDS Type</td>
                        <td class="blackfnt" align="left">
                            &nbsp;<asp:DropDownList ID="cboTDSType" runat="server">
                            </asp:DropDownList></td>
                </tr>
                <tr bgcolor="white">
                    <td style="height: 20px" class="blackfnt" align="left">
                        &nbsp;TDS Deducted For</td>
                    <td style="height: 20px; width: 201px;" class="blackfnt" align="left">
                        &nbsp;<asp:DropDownList ID="cboTDSDedu" runat="server">
                            <asp:ListItem>Select</asp:ListItem>
                            <asp:ListItem Value="C">Corporate</asp:ListItem>
                            <asp:ListItem Value="NC">Non Corporate</asp:ListItem>
                        </asp:DropDownList></td>
                    <td style="height: 20px" class="blackfnt" align="left">
                    </td>
                    <td style="height: 20px" class="blackfnt" align="left">
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <center>
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" /></center>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
