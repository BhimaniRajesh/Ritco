<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="finance_accounts1.aspx.cs" Inherits="GUI_admin_finance_accounts" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Finance &amp; Accounts</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="60%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <font class="blackfnt"><b>Finance &amp; Accounts Masters</b> </font>
            </td>
        </tr>

        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%" colspan="2">
                <asp:LinkButton ID="LinkButton21" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Company Master" PostBackUrl="~/GUI/admin/CompanyMasterTest/CompanyMasterMain.aspx" />
            </td>
        </tr>

        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%" colspan="2">
                <asp:LinkButton ID="LinkButton1" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Customer Contract" PostBackUrl="~/GUI/admin/CustomerContractMasterTest/MainCustomerContractMaster.aspx" />
            </td>
        </tr>

         <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td bgcolor="#FFFFFF" class="blklnkund" colspan="2" ><a href="Vendor_contract/vendorContract_Step1.aspx">Vendor Contract Master</a></td>
        </tr>

         <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%">
                <font class="blackfnt">Accounts Group Master</font>
            </td>

            <td align="center">
                <asp:LinkButton ID="LinkButton5" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add" PostBackUrl="Accounts_masters/Acctgroup/Add_acctGroups.aspx?Data=new" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton6" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="Accounts_masters/Acctgroup/Edit_acctGroups.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton7" CssClass="bluefnt" runat="server" Font-Bold="false" Text="XLS" PostBackUrl="#" />
            </td>
        </tr>
        
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%">
                <font class="blackfnt">Accounts Master</font>
            </td>

            <td align="center">
                <asp:LinkButton ID="lnkAdd" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add" PostBackUrl="Accounts_masters/Accounts/Add_Accounts.aspx?Data=new" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="lnkEdit" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="Accounts_masters/Accounts/Edit_Accounts.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton3" CssClass="bluefnt" runat="server" Font-Bold="false" Text="XLS" PostBackUrl="#" />
            </td>
        </tr>

                <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%" colspan="2">
                <asp:LinkButton ID="LinkButton4" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Set Opening Balance" PostBackUrl="./OpeningBalance/SelectBranch.aspx" />
            </td>
        </tr>

        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%" colspan="2">
                <asp:LinkButton ID="LinkButton8" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Set Employeewise Opening Balance" PostBackUrl="./setting_emp_opn_bal/SelectBranch.aspx" />
            </td>
        </tr>

 <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%" colspan="2">
                <asp:LinkButton ID="LinkButton2" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Setting Customer/Vendor Opening Balance" PostBackUrl="./setting_cust_opn_bal/sel_brnch.aspx" />
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%" colspan="2">
                <asp:LinkButton ID="LinkButton9" CssClass="bluefnt" runat="server" Font-Bold="false" Text="View Chart of Accounts" PostBackUrl="~/GUI/Finance/Accounts/ChartOfAccount/ChartOfAccount.aspx" />
            </td>
        </tr>

        <tr bgcolor="#FFFFFF">
            <td align="center" valign="middle">
               <font class="bluefnt" size="25"><b>.</b></font>
             </td>
            <td align="left" width="80%" colspan="2">
                <asp:LinkButton ID="LinkButton10" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Download Chart of Accounts" PostBackUrl="~/GUI/Finance/Accounts/ChartOfAccount/ChartOfAccount.aspx" />
            </td>
        </tr>
    
    </table>

</asp:Content>

