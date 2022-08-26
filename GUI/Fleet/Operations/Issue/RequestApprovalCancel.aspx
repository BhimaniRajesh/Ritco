<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="RequestApprovalCancel.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_RequestApprovalCancel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <b>Fleet >> New Trip Operations > Request Approval</b>
    <br />
    <br />
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="50%">
        <tr class="bgbluegrey">
            <td align="center" colspan="2">
                <asp:Label ID="lblHeader" runat="server" Font-Bold="true" Text="Trip Sheet Successfully Validated" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" colspan="3">
                <table class="boxbg" border="0" cellpadding="3" cellspacing="1" style="width: 100%;">
                    <tr align="center" class="bgbluegrey blackboldfnt">
                        <td>Sl.No</td>
                        <td>Vehicle No.</td>
                        <td>Driver Name.</td>
                        <td>Validate Up to (Date) Auto</td>
                    </tr>
                    <asp:Repeater ID="rptFinnalIndentDktPendingList" runat="server">
                        <ItemTemplate>
                            <tr class="bgwhite">
                                <td align="center">
                                    <%#Container.ItemIndex+1 %> 
                                </td>
                                <td align="center">
                                    <asp:Label ID="lblVehicleNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"VehicleID")%>'></asp:Label>
                                </td>
                                <td align="center">
                                    <asp:Label ID="lblDriverName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DriverName")%>'></asp:Label>
                                    <asp:Label ID="lblDriverNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DriverNo")%>'></asp:Label>
                                </td>
                                <td align="center">
                                    <asp:Label ID="lblValidUpTo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ValidUpTo")%>'></asp:Label>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" colspan="2">
                <asp:LinkButton ID="lnkBtnProposedIndentEntry" CssClass="bluefnt" runat="server" Font-Bold="false"
                    PostBackUrl="~/GUI/Fleet/Operations/Issue/RequestApproval.aspx"> Click Here for Request Approval</asp:LinkButton>
            </td>
        </tr>
    </table>
</asp:Content>

