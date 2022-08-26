<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"     CodeFile="EditTripsheetResult.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_EditTripsheetResult" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<script language="javascript">
     function ViewPrintPay(tVSlipId,tPrintMode)
 {
 //alert("advance");
	var strurl="DebitVoucherView.aspx?voucherno=" + tVSlipId + "&PrintMode=" + tPrintMode  
     popup = window.open(strurl,"","height=475,width=850,scrollbars=yes,left=100,top=125");
 }
</script>

<%
  
  
   string VSlipId = "",Flag="";
   VSlipId = Request.QueryString["VSlipId"];
     // Flag = Request.QueryString["mFlag"];
    
   lblDocNo.Text = VSlipId;
    

    
 %>


<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Tripsheet >> Advance Edit</asp:Label>
                >>
            
                
                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server">Updated</asp:Label>
              
               
                
              
                
                
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
<br>
   
    <table border="0" class="boxbg" cellpadding="2" cellspacing="1" width="60%" align=left>
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
       
            
                <asp:Label ID="lblHeader" runat="server"  Font-Bold="true" Text="Following document is Updated" CssClass="blackfnt"></asp:Label>
            
            
              
            
            
            
            </td>
        </tr>
        
        <tr style="background-color:White">
            <td align="center"> 
                <asp:Label ID="Label2" runat="server" Text="Document Name" Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:Label ID="Label3" runat="server" Text="Document No." Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> &nbsp;</td>
        </tr>
        <tr style="background-color:White">
            <td align="center"> 
                <asp:Label ID="lblDocType" runat="server" Text="Tripsheet"  CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:Label ID="lblDocNo" runat="server" Text="Document No."  CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> &nbsp;</td>
        </tr>

    <%if (mvoucherno!="")
    {%>
    
    <tr style="background-color:White">
            <td align="center"> 
                <asp:Label ID="Label4" runat="server" Text="Advance Payment Voucher" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:Label ID="LblVoucherNo" runat="server" Text="" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <a href="javascript:ViewPrintPay('<%=mvoucherno%>','0')"><font class="blackfnt">View</font></a>
                <asp:Label ID="Label6" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                <a href="javascript:ViewPrintPay('<%=mvoucherno%>','1')"><font class="blackfnt">Print</font></a>
            </td>
        </tr>
    
     
     <%} %>  


          <tr style="background-color:White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="lnkStep1" runat="server" Text="Edit More Trip Advance" CssClass="blackfnt" PostBackUrl="TripsheetQuery.aspx"/>
            </td>
        </tr>

 
   
  
       
        
    </table>
    </center>
</asp:Content>


