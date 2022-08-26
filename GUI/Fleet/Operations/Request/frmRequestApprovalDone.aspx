<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="frmRequestApprovalDone.aspx.cs" Inherits="Request_frmRequestApprovalDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<%
    string Request_Mode = Request.QueryString["Request_Mode"];
    if (Request_Mode == "C")
    {
        lblHeader.Text = "The requests have been confirmed successfully";
    }
    else
    {
        lblHeader.Text = "The requests have been rejected successfully";
    }
 %>

<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
<asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Vehicle Requests >> Approval/Confirmation >> List</asp:Label>                >>
                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server">Confirmation/Rejection Submitted</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
<br>
    <center>
    <table border="0" class="boxbg" cellpadding="2" cellspacing="1" width="70%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <asp:Label ID="lblHeader" runat="server"  Font-Bold="true" Text="" CssClass="blackfnt" ></asp:Label>
            </td>
        </tr>
        
        

        <tr class="bgbluegrey">
            <td align="left" colspan="3">
                <asp:Label ID="lblNextStep" runat="server" Text="Your Next Step"  Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>

        <tr style="background-color:White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="lnkStep1" runat="server" Text="Confirm/Reject More Vehicle Requests" CssClass="blackfnt" PostBackUrl="frmRequestApprovalQuery.aspx"/>
            </td>
        </tr>
        <tr style="background-color:White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="LinkButton1" runat="server" Text="Enter a New Requests" CssClass="blackfnt" PostBackUrl="frmNewRequest.aspx"/>
            </td>
        </tr>
        
         <tr style="background-color:White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="LinkButton2" runat="server" Text="View & Print Requests" CssClass="blackfnt" PostBackUrl="frmViewPrintRequestQuery.aspx"/>
            </td>
        </tr>
       
        
    </table>
    </center>
</asp:Content>
