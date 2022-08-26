<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="FixedExpenseView.aspx.cs" Inherits="GUI_admin_FixedExpense_FixedExpenseView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script src="JS/FixedExpense.js?V1" type="text/javascript"></script>
    <div style="width: 8in">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 50px">
            <tr>
                <td>
                    <font class="blackfnt"><a href=""><b><u>Module </u></b></a>&gt; <a href="../../welcome.aspx">
                        <b><u>Administrator </u></b></a>&gt; <a href="../company_structure.aspx"><b><u>Company
                            Structure </u></b></a>&gt; <b><u>Fixed Expense</u></b></font>
                </td>
                <td>
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img src="../../images/back.gif" border="0" alt="" /></a>
                </td>
            </tr>
        </table>
        <table border="0" width="100%" cellpadding="1" cellspacing="1" class="boxbg">
            <tr class="bgbluegrey">
                <td align="center" style="height: 21px">
                    <font class="blackfnt"><b>Fixed Expense</b></font>
                </td>
            </tr>
        </table>
        <table border="1" width="100%">
            <tr bgcolor="#ffffff">
                <td align="left">
                    <font class="blackfnt">Select Branch</font>
                </td>
                <td align="left" style="display: inline">
                    <asp:DropDownList runat="server" ID="ddlBranch" DataTextField="LocName" DataValueField="LocCode"></asp:DropDownList>
                </td>
            </tr>
            <tr class="bgbluegrey">
                <td align="center" colspan="2">
                    <font class="blackfnt"><b>OR</b></font>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left">
                    <font class="blackfnt">Select Vehicle No.</font>
                </td>
                <td align="left" style="display: inline">
                    <asp:DropDownList runat="server" ID="ddlVehicle"></asp:DropDownList>
                </td>
            </tr>
            <tr class="bgbluegrey">
                <td align="center" colspan="2">
                    <font class="blackfnt"><b>OR</b></font>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left">
                    <font class="blackfnt">Select Option</font>
                </td>
                <td align="left" style="display: inline">
                    <asp:DropDownList runat="server" ID="ddlOption"></asp:DropDownList>
                </td>
            </tr>
            <tr class="hrow">
                <td align="center" colspan="2">
                    <asp:Button Text="View" runat="server" Visible="true" class="btn btn-primary" OnClick="btnStep1_Click" ID="btnStep1" />
                </td>
            </tr>
            <tr id="trxsl" runat="server" visible="false">
                <td align="right" colspan="2">
                    <asp:LinkButton ID="XlSDownload" runat="server" OnClick="XlSDownload_Click" Visible="false">Download XLS</asp:LinkButton>
                </td>
            </tr>
            <tr id="view" runat="server" visible="false">
                <td colspan="2">
                    <table width="100%" id="tblstep2" class="stbl">
                        <tr class="bgbluegrey">
                            <td align="center"><b>Sr. No.</b></td>
                            <td align="center"><b>Option</b></td>
                            <td align="center"><b>Vehicle No.</b></td>
                            <td align="center"><b>Tyre Exp. Per KM</b></td>
                            <td align="center"><b>AMC Per KM</b></td>
                            <td align="center"><b>Document (30 Days)</b></td>
                            <td align="center"><b>Others I (30 Days)</b></td>
                            <td align="center"><b>Others II (30 Days)</b></td>
                        </tr>
                        <asp:Repeater ID="BindFixedExpenseDetails" runat="server">
                            <ItemTemplate>
                                <tr class="bgwhite">
                                    <td align="center">
                                        <asp:Label ID="lblSrNo" runat="server" Text='<%# Eval("SrNo") %>'></asp:Label></td>
                                    <td align="center">
                                        <asp:Label ID="lblOption" runat="server" Text='<%# Eval("Opt") %>'></asp:Label></td>
                                    <td align="center">
                                        <asp:Label ID="lblVehicleNo" runat="server" Text='<%# Eval("VehicleNo") %>'></asp:Label></td>
                                    <td align="right">
                                        <asp:Label ID="lblTyreExp" runat="server" Text='<%# Eval("TyreExp") %>'></asp:Label></td>
                                    <td align="right">
                                        <asp:Label ID="lblAMC" runat="server" Text='<%# Eval("AMC") %>'></asp:Label></td>
                                    <td align="right">
                                        <asp:Label ID="lblDocument" runat="server" Text='<%# Eval("Document") %>'></asp:Label></td>
                                    <td align="right">
                                        <asp:Label ID="lblOtherI" runat="server" Text='<%# Eval("OtherI") %>'></asp:Label></td>
                                    <td align="right">
                                        <asp:Label ID="lblOtherII" runat="server" Text='<%# Eval("OtherII") %>'></asp:Label></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

