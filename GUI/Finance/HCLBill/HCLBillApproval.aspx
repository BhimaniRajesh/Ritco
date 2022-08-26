<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="HCLBillApproval.aspx.cs" Inherits="GUI_Finance_HCLBill_HCLBillApproval" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript">
        $(document).ready(function () {
            $("[id*='RdHCLApproval']").click(function () {
                //set name for all to name of clicked 
                $("[id*='RdHCLApproval']").not(this).attr("checked", false);
            });
        });
    </script>
    <UserControl:UserMessage runat="server" ID="UserMessage" />
    <table class="stbl" cellspacing="1" cellpadding="3" style="width: 50%" id="tblCriteria" runat="server">
        <tr class="hrow">
            <td colspan="2" align="center">
                <b>HCL Bill Pending Approval Step 2</b>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <asp:Repeater ID="RptBillApproval" runat="server">
        <HeaderTemplate>
            <table id="Dochead" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="50%">
                <thead>
                    <tr class="hrow">
                        <th><b>Select</b></th>
                        <th><b>Bill Number</b></th>
                        <th><b>Bill Date</b></th>
                        <th><b>Vendor Name</b></th>
                        <th><b>Amount</b></th>
                    </tr>
                </thead>
        </HeaderTemplate>
        <ItemTemplate>
            <tbody>
                <tr class="nrow">
                    <td>
                        <asp:RadioButton runat="server" ID="RdHCLApproval" />
                        <%--<a href="HCLBillApprovalStep3.aspx?BillNo=('<%#DataBinder.Eval(Container.DataItem, "BillNo") %>')">
                                         <font cssclass="Blackfnt">
                                             <%#DataBinder.Eval(Container.DataItem, "BillNo")%></a>--%>
                    </td>
                    <td>
                        <asp:Label ID="lblBillNo" runat="server" Text='<%# Eval("BillNo") %>'></asp:Label>
                        <asp:HiddenField runat="server" ID="hdnBillNo" Value='<%# Eval("BillNo") %>' />

                    </td>
                    <td>
                        <asp:Label ID="lblBillDate" runat="server" Text='<%# Eval("BillDate") %>'></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblVendorName" runat="server" Text='<%# Eval("VendorName") %>'></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblAmount" runat="server" Text='<%# Eval("Amount") %>'></asp:Label>
                        
                    </td>

                </tr>

            </tbody>
        </ItemTemplate>
        <FooterTemplate>
            <tr class="nrow">
                <td align="center" colspan="5">
                    <asp:Button ID="btnNext" runat="server" Text="Next" OnClick="btnNext_Click" />
                </td>
            </tr>
            </table>
        </FooterTemplate>
    </asp:Repeater>

</asp:Content>

