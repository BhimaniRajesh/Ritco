<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="saleCallReg_operations.aspx.cs" Inherits="SFM_saleCallReg_operations" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Sales Visit Register" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        </table>
        <br />

    <div>
        <table  bgcolor="#000000" border="0" cellpadding="4" cellspacing="1"
            class="boxbg" style="font-size: 12pt; font-family: Times New Roman" width="85%">
            
            <tr bgcolor="#ffffff">
                <td bgcolor="#ffffff" width="2%" style="height: 25px">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="bullet">
                                <img height="4" src="../images/clear.gif" width="4" /></td>
                        </tr>
                    </table>
                </td>
                <td align="left" bgcolor="#ffffff" colspan="3" width="100%" style="height: 25px">
                    <font class="blackfnt" color="#0000ff"><font class="blklnkund"><a href="../REPORT/CallRegister_CompanywiseReport.aspx">
                        View Company Wise Register</a></font></td>
            </tr>
            <tr bgcolor="#ffffff" style="font-weight: bold; color: #0000ff">
                <td bgcolor="#ffffff" height="25" width="2%">
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="bullet">
                                <img height="4" src="../images/clear.gif" width="4" /></td>
                        </tr>
                    </table>
                </td>
                <td align="left" bgcolor="#ffffff" colspan="3" height="18" width="100%">
                    <font class="blackfnt" color="#0000ff"><font class="blklnkund"><a href="../REPORT/CallRegister_SalesPersonwiseReport.aspx">
                    View Employee Wise Register</a></font></td>
            </tr>
            
           
        </table>
    </div>
    </asp:Content>
