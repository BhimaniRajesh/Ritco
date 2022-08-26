<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="BillDone.aspx.cs" Inherits="GUI_Finance_VendorCPKMBilling_BillApproval_BillDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
     <div style="width: 10in">
        <UserControl:ProgressBar runat="server" ID="ProgressBar" />
        <asp:UpdatePanel runat="server">
            <ContentTemplate>

                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td height="30">
                                        <font class="bluefnt">
                                            <strong>Bill Approval of CPKM</strong> </font>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="horzblue">
                                        <img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
                                </tr>
                                <tr>
                                    <td>
                                        <img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
                                </tr>

                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table cellpadding="1" cellspacing="1" border="0" style="width: 80%" class="boxbg">
                                <thead>
                                    <tr class="bgbluegrey">
                                        <td colspan="4" align="center">
                                            <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Bill Approved Successfully"></asp:Label></td>
                                    </tr>
                                   
                                    <tr class="nrow">

                                        <td colspan="4">
                                            <asp:GridView runat="server" CssClass="boxbg" ID="gvCPKMBillDT" AutoGenerateColumns="False" CellSpacing="1"
                                                HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" PagerStyle-CssClass="bgwhite" Width="100%" RowStyle-CssClass="bgwhite" BorderWidth="0">

                                                <Columns>
                                                    <asp:TemplateField HeaderText="Vendor Name">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblVendorName" Text='<%# Eval("VendorName") %>'></asp:Label>
                                                            <asp:HiddenField runat="server" ID="hdnVendorCode" Value='<%# Eval("VendorCode") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Month">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblMonth" Text='<%# Eval("Month") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                     <%--  <asp:TemplateField HeaderText="Bill No.">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblBillNo" Text='<%# Eval("BillNo") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>--%>
                                                    <asp:HyperLinkField DataTextField="BillNo" ItemStyle-HorizontalAlign="Left" DataNavigateUrlFields="BillNo" DataNavigateUrlFormatString="ViewCPKMBillApproval.aspx?BillNo={0}" InsertVisible="false" Target="_blank" HeaderText="Bill No" HeaderStyle-HorizontalAlign="Left" />
                                                    <asp:TemplateField HeaderText="Bill Date">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblBillDate" Text='<%# Eval("BillDate") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="No. Of Vehicle Approve">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblNoOfVehicleapprove" Text='<%# Eval("NoOfVehicleapprove") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                     <asp:TemplateField HeaderText="Rejected No. of Vehicles">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblCNTReject" Text='<%# Eval("CNTReject") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                     <asp:TemplateField HeaderText="Total  Rejected Vehicle Amount">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblRejectAmount" Text='<%# Eval("RejectAmount") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Bill Amount">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="lblBillAmount" Text='<%# Eval("BillAmount") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>

                                </thead>
                            </table>

                        </td>
                    </tr>

                </table>

            </ContentTemplate>
        </asp:UpdatePanel>
        
    </div>
</asp:Content>

