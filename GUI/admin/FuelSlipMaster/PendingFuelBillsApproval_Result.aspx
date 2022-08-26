<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PendingFuelBillsApproval_Result.aspx.cs" MasterPageFile="~/GUI/MasterPage.master" Inherits="GUI_admin_FuelSlipMaster_PendingFuelBillsApproval_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 26px">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Pending Fuel Bills Approved</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
        </tr>
    </table>

    <table border="0" class="boxbg" cellpadding="2" cellspacing="1" width="50%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">

                <asp:Label ID="lblHeader" runat="server" Font-Bold="true" Text="Pending Fuel Bills Approved Successfully" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
		<tr style="background-color: White">
			 <td align="center" width="100%">
                    <asp:UpdatePanel ID="u1" UpdateMode="Conditional" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="dgGeneral" runat="server" AutoGenerateColumns="False"
                                CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                                CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                                PagerSettings-Mode="NumericFirstLast">

                                <Columns>
                                    <asp:TemplateField HeaderText="Sr No.">
                                        <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="Bill_No" HeaderText="Bill No" ReadOnly="true" />
									<asp:BoundField DataField="ApprovalVoucher" HeaderText="Voucher No" ReadOnly="true" />
									<asp:BoundField DataField="BillDate" HeaderText="Bill Date" ReadOnly="true" />
                                    <asp:BoundField DataField="VendorName" HeaderText="Vendor Name" ReadOnly="true" />
                                    <asp:BoundField DataField="TotalLtr" HeaderText="Total Litres" ReadOnly="true" />
                                    <asp:BoundField DataField="TotalSlips" HeaderText="Total Slips" ReadOnly="true" />
                                    <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" ReadOnly="true" />

                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                </td>
		</tr>
        <tr style="background-color: White">
            <td align="center">
                <asp:HyperLink ID="hyper" NavigateUrl="PendingFuelBillsApproval.aspx" Text="Click here to another Pending Fuel Bills Approval" runat="server"></asp:HyperLink>
            </td>
        </tr>
		
    </table>
	
</asp:Content>
