<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Account_Add_PopUp.aspx.cs" Inherits="GUI_admin_Accounts_masters_Accounts_Account_Add_PopUp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link id="Link1" href="../../../images/style.css" rel="Stylesheet" 
            type="text/css" runat="server" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <asp:ScriptManager EnablePartialRendering="true" ID="sc1" runat="server"></asp:ScriptManager>
     <table border="0" width="100%">
        <tr>
            <td style="width: 10%"></td>
            <td width="90%">
               
                <br />
                <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 720px; height: 200px;">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="2">
                            <font class="blackfnt"><b>Add Accounts Group </b></font>
                        </td>
                    </tr>
                    <tr bgcolor="white">
                        <td align="left" style="width: 284px">
                            <font class="blackfnt">&nbsp;Account Code</font></td>
                        <td align="left">
                             <font class="redfnt">&nbsp;System Generated</font>
                        </td>
                    </tr>
                    
                    <tr bgcolor="white">
                        <td align="left" style="width: 284px">
                            <font class="blackfnt">&nbsp;Select Main Category</font></td>
                        <td align="left">
                            
                            <font class="blackfnt">&nbsp;<asp:DropDownList ID="dlstCategory" runat="server">
                                <asp:ListItem Value="">Select</asp:ListItem>
                                    <asp:ListItem Value="ASS001">ASSET</asp:ListItem>
                                    <asp:ListItem Value="EXP001">EXPENSES</asp:ListItem>
                                    <asp:ListItem Value="INC001">INCOME</asp:ListItem>
                                    <asp:ListItem Value="LIA001">LIABILITY</asp:ListItem>
                                </asp:DropDownList>
                              
                                </font></td>
                    </tr>
                    <tr bgcolor="white">
                        <td align="left" style="width: 284px">
                            <font class="blackfnt">&nbsp;Manual Account Code</font></td>
                        <td align="left">
                            &nbsp;<asp:TextBox ID="txtManCode" runat="server" Width="50px" MaxLength="6"></asp:TextBox></td>
                    </tr>
                    <tr bgcolor="white">
                        <td align="left" style="width: 284px">
                            <font class="blackfnt">&nbsp;Account Description</font></td>
                        <td align="left">
                            <font class="blackfnt">&nbsp;<asp:TextBox ID="txtAcctDesc" runat="server" Width="269px" MaxLength="100"></asp:TextBox></font></td>
                    </tr>
                    <tr bgcolor="white">
                        <td align="left" style="width: 284px">
                            <font class="blackfnt">&nbsp;Account Category</font></td>
                        <td align="left">
                            <font class="blackfnt">&nbsp;<asp:DropDownList ID="dlstAcctCategory" runat="server">
                            <asp:ListItem Value="">Select</asp:ListItem>
                                    <asp:ListItem Value="ASSET">ASSET</asp:ListItem>
                                    <asp:ListItem Value="BANK">BANK</asp:ListItem>
                                    <asp:ListItem Value="CASH">CASH</asp:ListItem>
                                    <asp:ListItem Value="CREDITOR EXPENSES">CREDITOR EXPENSES</asp:ListItem>
                                    <asp:ListItem Value="CREDITOR">CREDITOR</asp:ListItem>
                                    <asp:ListItem Value="DEBTOR">DEBTOR</asp:ListItem>
                                    <asp:ListItem Value="DEBTOR & CREDITOR">DEBTOR & CREDITOR</asp:ListItem>
                                    <asp:ListItem Value="EXPORT SALE">EXPORT SALE</asp:ListItem>
                                    <asp:ListItem Value="EXPENSES">EXPENSES</asp:ListItem>
                                    <asp:ListItem Value="FIXED ASSETS">FIXED ASSETS</asp:ListItem>
                                    <asp:ListItem Value="INCOME">INCOME</asp:ListItem>
                                    <asp:ListItem Value="LIABILITIES">LIABILITIES</asp:ListItem>
                                    <asp:ListItem Value="PARTY">PARTY</asp:ListItem>
                                    <asp:ListItem Value="PURCHASE">PURCHASE</asp:ListItem>
                                    <asp:ListItem Value="P & L">P & L</asp:ListItem>
                                    <asp:ListItem Value="SALE">SALE</asp:ListItem>
                                    <asp:ListItem Value="TAX">TAX</asp:ListItem>
                                </asp:DropDownList></font></td>
                    </tr>
                    <tr bgcolor="white">
                        <td align="left" style="width: 284px">
                            <font class="blackfnt">&nbsp;Active</font></td>
                        <td align="left">
                            <asp:CheckBox ID="chkActive" runat="server" Checked="true"/></td>
                    </tr>
                    </table>
                    <br />
                    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 720px; height: 76px;">
                     <tr class="bgbluegrey">
                        <td align="center" colspan="2">
                            <font class="blackfnt"><b>Provide Location detail for a Bank account</b></font>
                        </td>
                    </tr>
                    <tr bgcolor="white">
                        <td align="left" style="width: 284px" >
                            <font class="blackfnt">&nbsp;Account Number</font></td>
                        <td align="left">
                            <font class="blackfnt">&nbsp;<asp:TextBox ID="txtAcctNumber" runat="server" MaxLength="25"></asp:TextBox>
                            </font>
                        </td>
                    </tr>
                    <tr bgcolor="white">
                        <td align="left" style="width: 284px" >
                            <font class="blackfnt">&nbsp;Applicable to Locations</font></td>
                        <td align="left">
                            <font class="blackfnt">&nbsp;<asp:TextBox ID="txtLocation" runat="server" MaxLength="500"></asp:TextBox></font></td>
                    </tr>
                </table>
                <br />
                <table border="0" cellpadding="0" cellspacing="0" class="boxbg" style="width: 607px">
                    <tr bgcolor="white">
                        <td align="center">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" /></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </div>
    </form>
</body>
</html>
