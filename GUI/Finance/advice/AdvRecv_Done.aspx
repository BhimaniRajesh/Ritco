<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="AdvRecv_Done.aspx.cs" Inherits="GUI_finance_advice_AdvRecv_Done" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Advice Result</asp:Label>
                <hr align="center" size="1" color="#8ba0e5" />
            </td>
        </tr>
    </table>
<br/><br/>
    <center>
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="70%">
        <tr class="bgbluegrey">
            <td align="left" colspan="3">
                <asp:Label ID="lblHeader" runat="server"  Font-Bold="true" Text="Following document has been successfully Accepted :" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        
        <tr style="background-color:White">
            <td align="center"> 
                <asp:Label ID="lblDocType" runat="server" Text="Document Name" Font-Bold="True" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:Label ID="lblDocNo" runat="server" Text="Code" Font-Bold="True" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:Label ID="lblDocName" runat="server" Font-Bold="True" CssClass="blackfnt"></asp:Label>
            </td>
            
            
        </tr>

        <tr style="background-color:White">
            <td align="center"> 
                <asp:Label ID="lblDocNameVal" runat="server" Text="" CssClass="blackfnt"></asp:Label>
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

        <tr class="bgbluegrey">
            <td align="left" colspan="3">
                <asp:Label ID="lblNextStep" runat="server" Text="Your Next Step"  Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>

        <tr style="background-color:White">
            <td align="left" colspan="3" style="height: 21px">
                <asp:LinkButton ID="lnkStep1" runat="server" Text="Prepare More Advice" CssClass="blackfnt" PostBackUrl="~/GUI/finance/advice/advice.aspx"/>
            </td>
        </tr>
         <tr style="background-color:White">
            <td align="left" colspan="3" style="height: 21px"><asp:LinkButton ID="lnkStep2" runat="server" Text="Acknowledge Advices" CssClass="blackfnt" PostBackUrl="~/GUI/finance/advice/AdvRecv_step1.aspx" /></td>
        </tr>
        
        <tr style="background-color:White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="LinkButton2" runat="server" Text="View & Print Advices" CssClass="blackfnt" PostBackUrl="#" Visible="False" /></td>
        </tr>
       
    </table>
    </center>
</asp:Content>

