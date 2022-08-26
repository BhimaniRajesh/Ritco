<%@ Page Language="C#" AutoEventWireup="true"   MasterPageFile="~/GUI/MasterPage.master"  CodeFile="VariableExpResult.aspx.cs" Inherits="GUI_Fleet_Operations_Expense_VariableExpResult" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">


<script language="javascript">
 
 function ViewPrint(mVoucherNo,tPrintMode)
 {
    
	var strurl="VariableExpenseVoucherPrint.aspx?VNo=" + mVoucherNo + "&PrintMode=" + tPrintMode  
     popup = window.open(strurl,"pbr","menubar=no,toolbar=no,resizable=yes,scrollbars=yes");
 }
 

</script>


<%
   //string VNo = "";
   string VoucherNo = "";
   //string mTripSheetType = "";

   VoucherNo = Request.QueryString["DocNo"];

 
   lblDocNoVal.Text = VoucherNo;
 %>









<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Variable Expense Voucher</asp:Label>
              
                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
<br>
    <center>
    <table border="0" class="boxbg" cellpadding="2" cellspacing="1" width="50%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <asp:Label ID="lblHeader" runat="server"  Font-Bold="true" Text="Following document is generated" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        
        <tr style="background-color:White">
            <td align="left"> 
                <asp:Label ID="lblDocType" runat="server" Text="Document Name" Font-Bold="true"    CssClass="blackfnt"></asp:Label>
            </td>
            <td align="left"> 
                <asp:Label ID="lblDocNo" runat="server" Text="Document No." Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
           <td align="center"> 
                
                
                <a href="javascript:ViewPrint('<%=VoucherNo%>','0')"><font class="blackfnt">View</font></a>
                <asp:Label ID="lblSep1" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                 <a href="javascript:ViewPrint('<%=VoucherNo%>','1')"><font class="blackfnt">Print</font></a>

            </td>
        </tr>

        <tr style="background-color:White">
            <td align="left"> 
                <asp:Label ID="lblDocNameVal" runat="server" Text="Variable Expense Voucher" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="left" colspan="2"> 
                <asp:Label ID="lblDocNoVal" runat="server" Text="" CssClass="blackfnt"></asp:Label>
            </td>
            
        </tr>

        <tr class="bgbluegrey">
            <td align="left" colspan="3">
                <asp:Label ID="lblNextStep" runat="server" Text="Your Next Step"  Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>

        <tr style="background-color:White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="lnkStep1" runat="server" Text="Generate Variable Expense Voucher" CssClass="blackfnt" PostBackUrl="VariableExpenseVoucherAdd.aspx"/>
            </td>
        </tr>
      
        

       
        
    </table>
    </center>
</asp:Content>
