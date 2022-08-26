<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="IssueSlip_Done.aspx.cs" Inherits="GUI_finance_voucher_voucher_done" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" src="../dropdowncontent.js"></script>

    <script language="javascript" type="text/javascript">
        function ViewPrint(arg1, arg2) {
            window.open("IssueSlip_ViewPrint.aspx?IssueSlipNo=" + arg1,"es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
    
    </script>

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Issue Slip Generation Result</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <table border="0" width="100%" style="text-align:left" >
        <tr>
            <td width="90%" align="left">
                <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="650">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="3">
                            <asp:Label ID="lblHeader" runat="server" Font-Bold="true" Text="Following document has been successfully Generated:"
                                CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td align="center">
                            <asp:Label ID="lblDocType" runat="server" Text="Document Name" Font-Bold="True" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="lblDocNo" runat="server" Text="Number" Font-Bold="True" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="lblDocName" runat="server" Font-Bold="True" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td align="center">
                            <asp:Label ID="Label1" runat="server" Text="Issue Slip" Font-Bold="True" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center">
                            <asp:Label ID="LblIssueSlipNo" runat="server" Text="" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center">
                            <font class="blackfnt"><font class="blklnkund"><a href="Javascript:ViewPrint('<%=Request.QueryString.Get("IssueSlipNo")%>',0)">
                                <font class="blklnkund">View</font></a> | <a href="Javascript:ViewPrint('<%=Request.QueryString.Get("IssueSlipNo")%>',1)">
                                    <font class="blklnkund">Print </font></a></font>
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td align="left" colspan="3">
                            <asp:Label ID="lblNextStep" runat="server" Text="Your Next Step" Font-Bold="true"
                                CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td align="left" colspan="3" style="height: 21px">
                            <a href="IssueSlip_Generation.aspx"><font class="blackfnt">Prepare New Issue Slip</font>
                            </a>
                        </td>
                    </tr>                    
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
