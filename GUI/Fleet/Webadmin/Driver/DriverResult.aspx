<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="DriverResult.aspx.cs" Inherits="admin_DriverResult" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >

<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 26px">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Driver Entry</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
        </tr>
    </table>
<br><br>
    <center>
    <br><br>
    <table border="0" class="boxbg" cellpadding="2" cellspacing="1" width="70%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <asp:Label ID="lblHeader" runat="server"  Font-Bold="true" Text="Following Driver Has been Created" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        
        <tr style="background-color:White">
            <td align="center"> 
                <asp:Label ID="lblDocType" runat="server" Text="Driver Name: "   CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:Label ID="lblDocNo" runat="server"  CssClass="blackfnt"></asp:Label>
            </td>
           
            
            
        </tr>

      <%--  <tr style="background-color:White">
            <td align="center"> 
                <asp:Label ID="lblDocNameVal" runat="server" Text="Retail Invoice" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:Label ID="lblDocNoVal" runat="server" Text="" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:LinkButton ID="lnkView" runat="server" Text="View" CausesValidation="true" CssClass="blackfnt" OnClick="btnPrint_Click"></asp:LinkButton>
                <asp:Label ID="lblSep1" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                <asp:LinkButton ID="LinkPrint" runat="server" Text="Print" CausesValidation="true" CssClass="blackfnt"></asp:LinkButton>
                <asp:Label ID="lblSep2" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                <asp:LinkButton ID="LinkXLS" runat="server" Text="XLS" CausesValidation="true" CssClass="blackfnt"></asp:LinkButton>
            </td>
        </tr>
--%>
        <tr class="bgbluegrey">
            <td align="left" colspan="3">
                <asp:Label ID="lblNextStep" runat="server" Text="Your Next Step"  Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>

        <tr style="background-color:White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="lnkStep1" runat="server" Text="Enter More Driver" CssClass="blackfnt" PostBackUrl="DriverDet.aspx"/>&nbsp;&nbsp;&nbsp;&nbsp&nbsp;<asp:LinkButton ID="LinkButton1" runat="server" Text="Return To Browse Page" CssClass="blackfnt" PostBackUrl="Driver.aspx"/>
            </td>
        </tr>
       
        
    </table>
    </center>
 
  </asp:Content>