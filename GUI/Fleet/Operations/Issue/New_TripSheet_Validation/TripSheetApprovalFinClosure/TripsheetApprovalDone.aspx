<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TripsheetApprovalDone.aspx.cs" MasterPageFile="~/GUI/MasterPage.master" Inherits="Issue_New_TripSheet_Validation_TripSheetApprovalFinClosure_TripsheetApprovalDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Trip Submission >> Send for Approval </asp:Label>
                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server">Submitted</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br>
    <table border="0" class="boxbg" cellpadding="2" cellspacing="1" width="50%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <asp:Label ID="lblHeader" runat="server" Font-Bold="true" Text="Trip Approval is Done Successfully..…" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        <tr style="background-color:White">
            <td align="center"> 
                <asp:Label ID="lblmsg" runat="server"  CssClass="blackfnt"></asp:Label>
            </td>
            
        </tr>

    </table>

</asp:Content>