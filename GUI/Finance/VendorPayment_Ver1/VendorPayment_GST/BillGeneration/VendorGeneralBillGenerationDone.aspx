<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="VendorGeneralBillGenerationDone.aspx.cs" 
    Inherits="GUI_Finance_VendorPayment_GST_BillGeneration_VendorGeneralBillGenerationDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <font class="blackfnt"><b>Transaction Completed</b></font>
                <hr align="center" size="1" color="blue">
            </td>
        </tr>
    </table>
    <div align="center">
        <asp:Table runat="server" CssClass="boxbg" CellPadding="3" CellSpacing="1" HorizontalAlign="Left" Width="800px">
            <asp:TableRow CssClass="bgwhite" Width="800px">
                <asp:TableCell ColumnSpan="2" Width="800px">
                    <table class="boxbg" width="795px">
                        <tr>
                            <th class="hrow align-center">Document Type</th>
                            <th class="hrow align-center">Bill Number</th>
                            <th class="hrow align-center">View | Print</th>
                        </tr>
                        <tr class="bgwhite">
                            <td style="text-align: center">
                                <asp:Label runat="server" ID="lblTitle" Text="Freight Bill"></asp:Label>
                            </td>
                            <td style="text-align: center">
                                <asp:Label runat="server" ID="lblBillNo" Text=""></asp:Label>
                            </td>
                            <td style="text-align: center">
                                <a href="#">View</a> | <a href="#">Print</a>
                            </td>
                        </tr>
                        <tr class="boxbg">
                            <td class="bgwhite" align="left" colspan="3"><strong>Below Step for More Billing</strong></td>
                        </tr>
                        <tr class="bgwhite">
                            <td class="blackfnt" align="left" colspan="3">
                                <a href="BillGenerationCriteria.aspx">Bill Generation</a>
                            </td>
                        </tr>
                    </table>
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </div>
</asp:Content>