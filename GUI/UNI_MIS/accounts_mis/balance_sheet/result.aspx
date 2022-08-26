<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="result.aspx.cs" Inherits="GUI_UNI_MIS_accounts_mis_balance_sheet_result" %>

<asp:Content ContentPlaceHolderID="MyCPH1" ID="bal_sheet" runat="server">
    <div align="left">
    <table border="0" cellpadding="1" cellspacing="1" width="90%">
        <tr bgcolor="white" >
            <td width="5%"></td>
            <td width="95%" align="left">
                
                <br />
                    <table border="0" width="80%" cellpadding="7" cellspacing="1" class="boxbg"> 
                        <tr class="bgbluegrey">
                        <%
                            DateFunction Daccess = new DateFunction();
                            DataAccess Dsql = new DataAccess();
                            string AsOnDate = Request.QueryString["asOnDate"];
                            string convDate = Daccess.return_date(AsOnDate);
                            string strTranType = Request.QueryString["strTranType"];
                            string branch = Request.QueryString["branch"];
                        %>
                            <td style="width: 33%"><font class="blackfnt"><b>Liabilities</b></font></td>
                            <td colspan="2">
                                <font class="blackfnt"><b>Figure for the C.Y(Rs)</b></font></td>
                            <td style="width: 24%">
                                <font class="blackfnt"><b>Assets</b></font></td>
                            <td colspan="2"><font class="blackfnt"><b>
                                Figure for the C.Y(Rs)</b></font></td>
                        </tr>
                        <%
                                                        
                        %>
                        <tr bgcolor="white">
                            <td align="left" style="width: 33%"><font class="blackfnt">Share Capital</font></td>
                            <td align="right" style="width: 12%"><font class="blackfnt">
                                <asp:Label ID="lblSC" runat="server" CssClass="blackfnt" Text="0.00"></asp:Label></font></td>
                            <td align="right" style="width: 10%" class="blackfnt"><font class="blackfnt">
                                <asp:Label ID="lblSC2" runat="server" CssClass="blackfnt" Text="0.00"></asp:Label></font></td>
                            <td align="left" style="width: 24%"><font class="blackfnt">Fixed Assets</font></td>
                            <td width="16%" align="right"><font class="blackfnt">
                                <asp:Label ID="lblFA1" runat="server" CssClass="blackfnt" Text="0.00"></asp:Label></font></td>
                            <td align="right" style="width: 555%"><font class="blackfnt">
                                <asp:Label ID="lblFA2" runat="server" CssClass="blackfnt" Text="0.00"></asp:Label></font></td>
                        </tr>
                        <%
                            string Reservplus = Daccess.calPFAmt();                     
                        %>
                         <tr bgcolor="white">
                            <td align="left" style="width: 33%"><font class="blackfnt">Reservs and Surplus</font></td>
                            <td align="right" style="width: 12%"><font class="blackfnt">
                                <asp:Label ID="lblRS1" runat="server" CssClass="blackfnt" Text="0.00"></asp:Label></font></td>
                             <td align="right" style="width: 10%"><font class="blackfnt">
                                 <asp:Label ID="lblRS2" runat="server" CssClass="blackfnt" Text="0.00"></asp:Label></font></td>
                            <td align="left" style="width: 24%"><font class="blackfnt">Investments</font></td>
                            <td width="16%" align="right"><font class="blackfnt">
                                <asp:Label ID="lblI1" runat="server" CssClass="blackfnt" Text="0.00"></asp:Label></font></td>
                             <td align="right" style="width: 555%"><font class="blackfnt">
                                 <asp:Label ID="lblI2" runat="server" CssClass="blackfnt" Text="0.00"></asp:Label></font></td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="left" style="width: 33%"><font class="blackfnt">Secured Loans</font></td>
                            <td align="right" style="width: 12%"><font class="blackfnt">
                                <asp:Label ID="lblSL1" runat="server" CssClass="blackfnt" Text="0.00"></asp:Label></font></td>
                            <td align="right" style="width: 10%"><font class="blackfnt">
                                <asp:Label ID="lblSL2" runat="server" CssClass="blackfnt" Text="0.00"></asp:Label></font></td>
                            <td align="left" style="width: 24%"><font class="blackfnt">Current Assets, Loans & Advance</font></td>
                            <td width="16%" align="right"><font class="blackfnt">
                                <asp:Label ID="lblCALA1" runat="server" CssClass="blackfnt" Text="0.00"></asp:Label></font></td>
                            <td align="right" style="width: 555%"><font class="blackfnt">
                                <asp:Label ID="lblCALA2" runat="server" CssClass="blackfnt" Text="0.00"></asp:Label></font></td>
                        </tr>
                         <tr bgcolor="white">
                            <td align="left" style="width: 33%"><font class="blackfnt">Unsecured Loans</font></td>
                            <td align="right" style="width: 12%"><font class="blackfnt">
                                <asp:Label ID="lblUL1" runat="server" CssClass="blackfnt" Text="0.00"></asp:Label></font></td>
                             <td align="right" style="width: 10%"><font class="blackfnt">
                                 <asp:Label ID="lblUL2" runat="server" CssClass="blackfnt" Text="0.00"></asp:Label></font></td>
                            <td align="left" style="width: 24%"><font class="blackfnt">Miscellaneous Expenditure</font></td>
                            <td width="16%" align="right"><font class="blackfnt">
                                <asp:Label ID="lblME1" runat="server" CssClass="blackfnt" Text="0.00"></asp:Label></font></td>
                             <td align="right" style="width: 555%"><font class="blackfnt">
                                 <asp:Label ID="lblME2" runat="server" CssClass="blackfnt" Text="0.00"></asp:Label></font></td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="left" style="width: 33%"><font class="blackfnt">Current Liabilities & Provisions</font></td>
                            <td align="right" style="width: 12%"><font class="blackfnt">
                                <asp:Label ID="lblCLP1" runat="server" CssClass="blackfnt" Text="0.00"></asp:Label></font></td>
                            <td align="right" style="width: 10%"><font class="blackfnt">
                                <asp:Label ID="lblCLP2" runat="server" CssClass="blackfnt" Text="0.00"></asp:Label></font></td>
                            <td align="left" style="width: 24%">
                                <asp:Label ID="lblBalDef" runat="server" CssClass="blackfnt" Text="Label"></asp:Label></td>
                            <td width="16%" align="right"><font class="blackfnt">
                                <asp:Label ID="lblPL1" runat="server" CssClass="blackfnt" Text="0.00"></asp:Label></font></td>
                            <td align="right" style="width: 555%"><font class="blackfnt">
                                <asp:Label ID="lblPL2" runat="server" CssClass="blackfnt" Text="0.00"></asp:Label></font></td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="left" style="width: 33%"><font class="blackfnt"><b>Total</b></font></td>
                            <td align="right" style="width: 12%"></td>
                            <td align="right" style="width: 10%"><font class="blackfnt"><b>
                                <asp:Label ID="lblTotalL" runat="server" Text="0.00"></asp:Label></b></font></td>
                            <td align="left" style="width: 24%"><font class="blackfnt"><b>Total</b></font></td>
                            <td width="16%" align="right"><font class="blackfnt"><b></b></font></td>
                            <td align="right" style="width: 555%"><font class="blackfnt"><b>
                                <asp:Label ID="lblTotalA" runat="server" Text="0.00"></asp:Label></b></font></td>
                        </tr>
                    </table>
               
            </td>
        </tr>
        
    </table>
    </div>
</asp:Content>
