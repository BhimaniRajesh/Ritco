<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="finance_accounts.aspx.cs" Inherits="GUI_admin_finance_accounts" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">   
    <asp:Panel runat="server" HorizontalAlign="left" Style="width: 10in" ID="pnlMain">
        <br />
        <br />
        <asp:Table CssClass="boxbg" CellPadding="1" ID="tblMain" runat="server" CellSpacing="1"
            Width="70%">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="center" Font-Bold="true" ColumnSpan="3">
                    <b>Finance &amp; Accounts Masters</b>
                </asp:TableCell>
            </asp:TableRow>           
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="center" VerticalAlign="Middle">
                    <asp:Image ID="Image2" runat="server" ImageAlign="Middle" ImageUrl="~/GUI/images/band_strip3.gif" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left" ColumnSpan="2">
                    <asp:LinkButton ID="lblCustomerContract" CssClass="bluefnt" runat="server" Font-Bold="false"
                        Text="Customer Contract" PostBackUrl="./CustomerContractMaster/MainCustomerContractMaster.aspx?Flag=" />
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="center" VerticalAlign="Middle">
                    <asp:Image ID="Image3" runat="server" ImageAlign="Middle" ImageUrl="~/GUI/images/band_strip3.gif" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left" ColumnSpan="2">
                    <asp:LinkButton ID="lblVendorContract" CssClass="bluefnt" runat="server" Font-Bold="false"
                        Text="Vendor Contract" PostBackUrl="./Vendor_contract/vendorContract_Step1.aspx" />
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="center" VerticalAlign="Middle">
                    <asp:Image ID="Image1" runat="server" ImageAlign="Middle" ImageUrl="~/GUI/images/band_strip3.gif" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left" ColumnSpan="2">
                    <asp:LinkButton ID="LinkButton1" CssClass="bluefnt" runat="server" Font-Bold="false"
                        Text="Vendor Crossing Contract" PostBackUrl="./CrossingVendorMaster/vendorContract_Step1.aspx" />
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="center" VerticalAlign="Middle">
                    <asp:Image ID="Image4" runat="server" ImageAlign="Middle" ImageUrl="~/GUI/images/band_strip3.gif" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left" Width="70%">
                   Accounts                  
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="center">
                    <asp:LinkButton ID="lblAddAccounts" CssClass="bluefnt" runat="server" Font-Bold="false"
                        Text="Add" PostBackUrl="~/GUI/admin/Accounts_masters/Accounts/Add_Accounts.aspx?Data=new" />
                    <font class="blackfnt">|</font>
                    <asp:LinkButton ID="lblEditAccounts" CssClass="bluefnt" runat="server" Font-Bold="false"
                        Text="Edit" PostBackUrl="~/GUI/admin/Accounts_masters/Accounts/Edit_Accounts.aspx" />
                      <font class="blackfnt">|</font>
                    <asp:LinkButton ID="lblDownloadXLS" CssClass="bluefnt" runat="server" Font-Bold="false"
                        Text="Download XLS" PostBackUrl="~/GUI/admin/Accounts_masters/Accounts/ListAll.aspx" />    
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="center" VerticalAlign="Middle">
                    <asp:Image ID="Image5" runat="server" ImageAlign="Middle" ImageUrl="~/GUI/images/band_strip3.gif" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left" Width="70%">
                   Account Groups                  
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="center">
                    <asp:LinkButton ID="lblAddAccountsGroups" CssClass="bluefnt" runat="server" Font-Bold="false"
                        Text="Add" PostBackUrl="~/GUI/admin/Accounts_masters/Acctgroup/Add_acctGroups.aspx?Data=new" />
                    <font class="blackfnt">|</font>
                    <asp:LinkButton ID="lblEditAccountsGroups" CssClass="bluefnt" runat="server" Font-Bold="false"
                        Text="Edit" PostBackUrl="~/GUI/admin/Accounts_masters/Acctgroup/Edit_acctGroups.aspx" />
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="center" VerticalAlign="Middle">
                    <asp:Image ID="Image6" runat="server" ImageAlign="Middle" ImageUrl="~/GUI/images/band_strip3.gif" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left" ColumnSpan="2">
                    <asp:LinkButton ID="lblOpeningBalance" CssClass="bluefnt" runat="server" Font-Bold="false"
                        Text="Set Opening Balance" PostBackUrl="./OpeningBalance/SelectBranch.aspx" />
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="center" VerticalAlign="Middle">
                    <asp:Image ID="Image7" runat="server" ImageAlign="Middle" ImageUrl="~/GUI/images/band_strip3.gif" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left" ColumnSpan="2">
                    <asp:LinkButton ID="lblEmpOpeningBalance" CssClass="bluefnt" runat="server" Font-Bold="false"
                        Text="Set Customer/Vendor/DriverEmployee Wise Opening Balance" PostBackUrl="./setting_cust_opn_bal/sel_brnch.aspx" />
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="center" VerticalAlign="Middle">
                    <asp:Image ID="Image8" runat="server" ImageAlign="Middle" ImageUrl="~/GUI/images/band_strip3.gif" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left" ColumnSpan="2">
                    <asp:LinkButton ID="lblViewChart" CssClass="bluefnt" runat="server" Font-Bold="false"
                        Text="View Chart of Accounts" PostBackUrl="~/GUI/Finance/Accounts/ChartOfAccount/ChartOfAccount.aspx" />
                </asp:TableCell>
            </asp:TableRow>          
        </asp:Table>
    </asp:Panel>
</asp:Content>
