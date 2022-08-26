<%@ Page Language="C#" AutoEventWireup="true"    MasterPageFile="~/GUI/MasterPage.master"   CodeFile="ExternalTripEditResult.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_ExternalTripEditResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">



<%
  
  
   string VSlipId = "",Flag="";
   VSlipId = Request.QueryString["VSlipId"];
     // Flag = Request.QueryString["mFlag"];
    
   lblDocNo.Text = VSlipId;
    
    
 %>


<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Vehicle Isssue >> New</asp:Label>
                >>
            
                
                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server">Updated</asp:Label>
              
               
                
              
                
                
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
<br>
    <center>
    <table border="0" class="boxbg" cellpadding="2" cellspacing="1" width="60%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
       
                <asp:Label ID="lblHeader" runat="server"  Font-Bold="true" Text="Following document is Updated" CssClass="blackfnt"></asp:Label>
            
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
            <td align="left" colspan="3">
                <asp:LinkButton ID="lnkStep1" runat="server" Text="Edit More External Tripsheet" CssClass="blackfnt" PostBackUrl="ExternalTripsheetEditQuery.aspx"/>
            </td>
        </tr>


   
  
       
        
    </table>
    </center>
</asp:Content>


