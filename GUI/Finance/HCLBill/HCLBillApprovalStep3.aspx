<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="HCLBillApprovalStep3.aspx.cs" Inherits="GUI_Finance_HCLBill_HCLBillApprovalStep3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script>

        function CalulateDiscount() {
            var lblNetamount = $('#<%= lblNetamount.ClientID%>');
            var hdnApprovedAmount = $('#<%= hdnApprovedAmount.ClientID%>');
            var txtDiscount = $('#<%= txtDiscount.ClientID%>');
            var lblApprovedamount = $("span[id$=lblApprovedamount]");
            var total = 0;
            total = lblNetamount.text();

            if (parseFloat(total) < parseFloat(txtDiscount.val())) {
                alert("You can not enter discount more than netamount");
                txtDiscount.val(0.00);
                return false;
            }
            else {
                lblApprovedamount.html(parseFloat(total) - parseFloat(txtDiscount.val()));
                hdnApprovedAmount.val(parseFloat(total) - parseFloat(txtDiscount.val()));
            }
        }
    </script>
    <UserControl:UserMessage runat="server" ID="UserMessage" />
    <table class="stbl" cellspacing="1" cellpadding="3" style="width: 900px" id="Table5" runat="server">
        <tr class="hrow">
            <td colspan="2" align="center">
                <b>HCL Bill Pending Approval Step 3</b>
            </td>
        </tr>
    </table>

    <table class="stbl" cellspacing="1" cellpadding="3" style="width: 900px" id="tblCriteria" runat="server">
        <tr class="hrow">
            <td colspan="3" align="center">
                <b>From Bill Generation</b>
            </td>
            <td style="width: 25px;background-color:white" rowspan="6"></td>
            <td colspan="5" align="center">
                <b>From Master</b>
            </td>
        </tr>
        <tr class="nrow">
            <td><b>Document Name</b></td>
            <td><b>Type</b></td>
            <td><b>Rate</b></td>
            <td><b>Document Name</b></td>
            <td><b>Type</b></td>
            <td><b>Rate</b></td>
            <td><b>From date</b></td>
            <td><b>To Date</b></td>
        </tr>
        <tr class="nrow">
            <td>Outgoing THC</td>
            <td>
                <asp:Label runat="server" ID="lblOutgoingTHCType"></asp:Label></td>
            <td>
                <asp:Label runat="server" ID="lblOutgoingTHCRate"></asp:Label></td>
            <td>Outgoing THC</td>
            <td>
                <asp:Label runat="server" ID="lblOutgoingTHCTypeMaster"></asp:Label></td>
            <td>
                <asp:Label runat="server" ID="lblOutgoingTHCRateMaster"></asp:Label></td>
            <td>
                <asp:Label runat="server" ID="lblOutgoingTHCFromDateMaster"></asp:Label></td>
            <td>
                <asp:Label runat="server" ID="lblOutgoingTHCToDateMaster"></asp:Label></td>
        </tr>
        <tr class="nrow">
            <td>Incoming THC</td>
            <td>
                <asp:Label runat="server" ID="lblIncomingTHCType"></asp:Label></td>
            <td>
                <asp:Label runat="server" ID="lblIncomingTHCRate"></asp:Label></td>
            <td>Incoming THC</td>
            <td>
                <asp:Label runat="server" ID="lblIncomingTHCTypeMaster"></asp:Label></td>
            <td>
                <asp:Label runat="server" ID="lblIncomingTHCRateMaster"></asp:Label></td>
            <td>
                <asp:Label runat="server" ID="lblIncomingTHCFromDateMaster"></asp:Label></td>
            <td>
                <asp:Label runat="server" ID="lblIncomingTHCToDateMaster"></asp:Label></td>
        </tr>
        <tr class="nrow">
            <td>DDMR</td>
            <td>
                <asp:Label runat="server" ID="lblDDMRType"></asp:Label></td>
            <td>
                <asp:Label runat="server" ID="lblDDMRRate"></asp:Label></td>
            <td>DDMR</td>
            <td>
                <asp:Label runat="server" ID="lblDDMRTypeMaster"></asp:Label></td>
            <td>
                <asp:Label runat="server" ID="lblDDMRRateMaster"></asp:Label></td>
            <td>
                <asp:Label runat="server" ID="lblDDMRFromDateMaster"></asp:Label></td>
            <td>
                <asp:Label runat="server" ID="lblDDMRToDateMaster"></asp:Label></td>
        </tr>
        <tr class="nrow">
            <td>MR</td>
            <td>
                <asp:Label runat="server" ID="lblMRType"></asp:Label></td>
            <td>
                <asp:Label runat="server" ID="lblMRRate"></asp:Label></td>
            <td>MR</td>
            <td>
                <asp:Label runat="server" ID="lblMRTypeMaster"></asp:Label></td>
            <td>
                <asp:Label runat="server" ID="lblMRRateMaster"></asp:Label></td>
            <td>
                <asp:Label runat="server" ID="lblMRFromDateMaster"></asp:Label></td>
            <td>
                <asp:Label runat="server" ID="lblMRToDateMaster"></asp:Label></td>
        </tr>
    </table>
    <br />
    <table class="stbl" cellspacing="1" cellpadding="3" style="width: 900px" id="Table1" runat="server">
        <tr class="hrow">
            <td align="center">
                <b>Vendor Name</b>
            </td>
            <td>
                <asp:Label runat="server" ID="lblVendorName"></asp:Label></td>

            <td align="center">
                <b>Bill Number</b>
            </td>
            <td>
                <asp:Label runat="server" ID="lblBillNo"></asp:Label></td>

            <td><b>Bill Date</b></td>
            <td>
                <asp:Label runat="server" ID="lblBillDate"></asp:Label></td>
        </tr>
    </table>
    <br />
    <table id="tblDownload" border="0" cellpadding="1" style="margin-left: 795px;" cellspacing="1" width="100px">
        <tr>
            <td>
                <asp:Button ID="Button1" runat="server" Text="Download List" OnClick="ExportToExcel" /></td>
        </tr>
    </table>
    <br />
    <asp:Repeater ID="RptBillApprovalDetails" runat="server">
        <HeaderTemplate>
            <table id="Dochead" border="1" class="boxbg" cellpadding="1" cellspacing="1" width="900px">
                <thead>
                    <tr class="hrow">
                        <th><b>Sr No</b></th>
                        <th><b>Document Number</b></th>
                        <th><b>Actual Total Weight</b></th>
                        <th><b>Total Pkgs</b></th>
                        <th><b>Type</b></th>
                        <th><b>Rate</b></th>
                        <th><b>Amount</b></th>
                        <th><b>Remarks</b></th>
                        <th><b>Edited</b></th>
                    </tr>
                </thead>
        </HeaderTemplate>
        <ItemTemplate>
            <tbody>
                <tr class="nrow">
                    <td>
                        <asp:Label ID="lblsrNo" runat="server" Text='<%# Eval("SrNo") %>'></asp:Label></td>
                    <td>
                        <asp:Label ID="lbldocumentNo" runat="server" Text='<%# Eval("DocumentNo") %>'></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblActualTotalWeight" runat="server" Text='<%# Eval("TOTWT") %>'></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblTotalPkg" runat="server" Text='<%# Eval("TOTPKGS") %>'></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblType" runat="server" Text='<%# Eval("RAteType") %>'></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblRate" runat="server" Text='<%# Eval("Rate") %>'></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblAmount" runat="server" Text='<%# Eval("TotalAmount") %>'></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblRemarks" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblEdited" runat="server" Text='<%# Eval("Edited") %>'></asp:Label>
                    </td>
                </tr>
            </tbody>
        </ItemTemplate>
        <FooterTemplate>
            </table>
        </FooterTemplate>
    </asp:Repeater>
    <br />
    <br />
    <%--<asp:UpdatePanel runat="server" UpdateMode="Conditional" ID="up1">
        <ContentTemplate>--%>
    <table class="stbl" cellspacing="1" cellpadding="3" style="width: 300px; margin-left: 600px;" id="Table2" runat="server">
        <tr class="nrow">
            <td align="center">
                <b>Total Amount</b>
            </td>
            <td>
                <asp:Label runat="server" ID="lblTotalAmount"></asp:Label></td>
        </tr>
        <tr class="nrow">
            <td align="center">
                <b>Rebate</b>
            </td>
            <td>
                <asp:Label runat="server" ID="lblRebateAmount"></asp:Label></td>
        </tr>
        <tr class="nrow">
            <td align="center">
                <b>Net Amount</b>
            </td>
            <td>
                <asp:Label runat="server" ID="lblNetamount"></asp:Label></td>
        </tr>

        <tr class="nrow">
            <td align="center">
                <b>Discount</b>
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtDiscount" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Text="0.00" TabIndex="1" Style="text-align: right" OnBlur="javascript:return CalulateDiscount()"></asp:TextBox></td>
        </tr>
        <tr class="nrow">
            <td align="center">
                <b>Approved Amount</b>
            </td>
            <td>
                <asp:Label runat="server" ID="lblApprovedamount"></asp:Label>
                <asp:HiddenField ID="hdnApprovedAmount" runat="server" Value="0.00" />
            </td>
        </tr>
    </table>
    <%--</ContentTemplate>
        <Triggers>
        </Triggers>
    </asp:UpdatePanel>--%>
    <br />
    <br />
    <table class="stbl" cellspacing="1" cellpadding="3" style="width: 300px; margin-left: 300px;" id="Table3" runat="server">
        <tr class="nrow">
            <td align="center">
                <b>Reject Remark</b>
            </td>
            <td>
                <asp:TextBox runat="server" ID="txtRejectRemark" MaxLength="500" Rows="2"></asp:TextBox></td>
        </tr>
    </table>
    <br />
    <br />
    <table cellspacing="1" cellpadding="3" style="width: 300px; margin-left: 400px;" id="Table4" runat="server">
        <tr>
            <td>
                <asp:Button runat="server" ID="btnReject" Text="Reject" align="right" OnClick="btnReject_Click" />
            </td>
            <td>
                <asp:Button runat="server" ID="btnApprove" Text="Approve" align="right" OnClick="btnApprove_Click" />
            </td>
        </tr>
    </table>
</asp:Content>

