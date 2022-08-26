<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"   CodeFile="JobOrderResult.aspx.cs" Inherits="GUI_Fleet_Job_JobOrderResult" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >


<script language="javascript">
 
 function ViewPrint(mOrderNo,tPrintMode)
 {
    
	var strurl="JobOrderView.aspx?ONo=" + mOrderNo + "&PrintMode=" + tPrintMode  
     popup = window.open(strurl,"pbr","menubar=no,toolbar=no,resizable=yes,scrollbars=yes");
 }
 

</script>


<%
   //string VNo = "";
    string OrderNo = "";
   //string mTripSheetType = "";

   OrderNo = Request.QueryString["OrderNo"];


   lblDocNo.Text = OrderNo;
 %>












<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 26px">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Job Order</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
        </tr>
    </table>

    <center>
    <br><br>
    <table border="0" class="boxbg" cellpadding="2" cellspacing="1" width="75%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <asp:Label ID="lblHeader" runat="server" Visible="false"    Font-Bold="true" Text="Following Job Order is created" CssClass="blackfnt"></asp:Label>
                        <asp:Label ID="lblHeader1" runat="server"  Visible="false"  Font-Bold="true" Text="Following Job Order is Closed" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        
        
        
                <tr style="background-color:White">
            <td align="left"> 
                <asp:Label ID="Label1" runat="server" Text="Document Name" Font-Bold="true"    CssClass="blackfnt"></asp:Label>
            </td>
            <td align="left"> 
                <asp:Label ID="Label2" runat="server" Text="Document No." Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
           <td   align="center"> 
                
                
                <a href="javascript:ViewPrint('<%=OrderNo%>','0')"><font class="blackfnt">View</font></a>
                <asp:Label ID="lblSep1" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                 <a href="javascript:ViewPrint('<%=OrderNo%>','1')"><font class="blackfnt">Print</font></a>

            </td>
        </tr>
        
        
        
        
       <tr style="background-color:White">
            <td align="left"> 
                <asp:Label ID="lblDocType" runat="server" Text="Job Order No"   CssClass="blackfnt"></asp:Label>
            </td>
            <td align="left" colspan="2"> 
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
                <asp:LinkButton ID="lnkStep1" runat="server" Text="Prepare More Job Order" CssClass="blackfnt" PostBackUrl="PrepareJob.aspx"/>&nbsp;&nbsp;&nbsp;&nbsp&nbsp;
            </td>
        </tr>
        
         <tr style="background-color:White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="lnkStep3" runat="server" Text="View/Print Job Orders" CssClass="blackfnt" PostBackUrl="JobOrderQuery.aspx"/>&nbsp;&nbsp;&nbsp;&nbsp&nbsp;
            </td>
        </tr>
       
        
    </table>
    </center>
 
  </asp:Content>
