<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="CIRSuccess.aspx.cs" Inherits="GUI_CIR_CIRSuccess" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 26px">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">CIR>CIR Entry>>CIR Added</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
        </tr>
    </table>
<br><br>
    <center>
    <br><br>
    <table border="0" class="boxbg" cellpadding="2" cellspacing="1" width="70%">
      
        
        <tr style="background-color:White">
            <td align="center"> 
                <asp:Label ID="lblDocType" runat="server" Text="CIR/COF Successfully Added!" Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
        
            
            
        </tr>

       

        <tr class="bgbluegrey">
            <td align="left" colspan="3">
                <asp:Label ID="lblNextStep" runat="server" Text="Your Next Step"  Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>

        <tr style="background-color:White">
            <td align="left" colspan="3" style="height: 20px">
                <asp:LinkButton ID="lnkStep1" runat="server" Text="Enter More Claims" CssClass="blackfnt" PostBackUrl="Prepareclaims.aspx"/>&nbsp;&nbsp&nbsp;&nbsp;<asp:LinkButton ID="LinkButton1" runat="server" Text="Return To View Page  " CssClass="blackfnt" PostBackUrl="Viewclaims.aspx"/>
            </td>
        </tr>
       
        
    </table>
    </center>
  </asp:Content>
