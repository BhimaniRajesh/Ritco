<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="frmAddJourneyVehicleIssueSlip_result.aspx.cs" Inherits="Issue_frmAddJourneyVehicleIssueSlip_result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<%
  
    

   string ReqId ="";
   string VSlipId = "";
   //ReqId = Request.QueryString["ReqId"];
   VSlipId = Request.QueryString["VSlipId"];
   lblDocNoVal.Text = VSlipId;
    
    ReqId= Request.QueryString["ReqId"];
    lblReqId.Text = ReqId;
 %>

<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Vehicle Isssue >> New</asp:Label>
                >>
                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server">Submitted</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
<br>
    <center>
    <table border="0" class="boxbg" cellpadding="2" cellspacing="1" width="70%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <asp:Label ID="lblHeader" runat="server"  Font-Bold="True" Text="Following document is updated" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        
        <tr style="background-color:White">
            <td align="center"> 
                <asp:Label ID="lblDocType" runat="server" Text="Document Name" Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:Label ID="lblDocNo" runat="server" Text="Document No." Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> &nbsp;</td>
        </tr>

        <tr style="background-color:White">
            <td align="center"> 
                <asp:Label ID="lblDocNameVal" runat="server" Text="Vehicle Issue" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:Label ID="lblDocNoVal" runat="server" Text="" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:LinkButton ID="lnkView" runat="server" Text="View" CausesValidation="true" CssClass="blackfnt"></asp:LinkButton>
                <asp:Label ID="lblSep1" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                <asp:LinkButton ID="LinkPrint" runat="server" Text="Print" CausesValidation="true" CssClass="blackfnt"></asp:LinkButton>
                <asp:Label ID="lblSep2" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                <asp:LinkButton ID="LinkXLS" runat="server" Text="XLS" CausesValidation="true" CssClass="blackfnt"></asp:LinkButton>
            </td>
        </tr>
        
        
        <tr style="background-color:White">
            <td align="center"> 
                <asp:Label ID="Label2" runat="server" Text="Journey Request" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:Label ID="lblReqId" runat="server" Text="" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:LinkButton ID="LinkButton1" runat="server" Text="View" CausesValidation="true" CssClass="blackfnt"></asp:LinkButton>
                <asp:Label ID="Label4" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                <asp:LinkButton ID="LinkButton3" runat="server" Text="Print" CausesValidation="true" CssClass="blackfnt"></asp:LinkButton>
                <asp:Label ID="Label5" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                <asp:LinkButton ID="LinkButton4" runat="server" Text="XLS" CausesValidation="true" CssClass="blackfnt"></asp:LinkButton>
            </td>
        </tr>

        <tr class="bgbluegrey">
            <td align="left" colspan="3">
                <asp:Label ID="lblNextStep" runat="server" Text="Your Next Step"  Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>

        <tr style="background-color:White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="lnkStep1" runat="server" Text="Add More Journey" CssClass="blackfnt" PostBackUrl="frmAddJourneyQuery.aspx"/>
            </td>
        </tr>
       
        
         <tr style="background-color:White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="LinkButton2" runat="server" Text="View & Print Journey Slips" CssClass="blackfnt" PostBackUrl="#"/>
            </td>
        </tr>
       
        
    </table>
    </center>
</asp:Content>
