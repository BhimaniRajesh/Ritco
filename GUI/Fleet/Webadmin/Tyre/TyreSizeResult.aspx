<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master" CodeFile="TyreSizeResult.aspx.cs" Inherits="admin_TyreSizeResult" %>

 

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >

<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 26px">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Tyre Size Entry</asp:Label>
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
                <asp:Label ID="lblHeader" runat="server"  Font-Bold="true" Text="Following Size Entry Has been Created" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        
        <tr style="background-color:White">
            <td align="left"> 
                <asp:Label ID="lblDocType" runat="server" Text="Tyre Size Id/Name: "   CssClass="blackfnt"></asp:Label>
            </td>
            <td align="left"> 
                <asp:Label ID="lblDocNo" runat="server"  CssClass="blackfnt"></asp:Label>
            </td>
           
            
            
        </tr>

    

        <tr class="bgbluegrey">
            <td align="left" colspan="3">
                <asp:Label ID="lblNextStep" runat="server" Text="Your Next Step"  Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>

        <tr style="background-color:White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="lnkStep1" runat="server" Text="Enter More Tyre Size Entry" CssClass="blackfnt" PostBackUrl="TyreSizeDet.aspx"/>&nbsp;&nbsp;&nbsp;&nbsp&nbsp;<asp:LinkButton ID="LinkButton1" runat="server" Text="Return To Browse Page" CssClass="blackfnt" PostBackUrl="TyreSize.aspx"/>
            </td>
        </tr>
       
        
    </table>
    </center>
 
  </asp:Content>
