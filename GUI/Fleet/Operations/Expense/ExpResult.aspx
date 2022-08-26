<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="ExpResult.aspx.cs" Inherits="GUI_Fleet_Operations_Expense_ExpResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script language="javascript">
 
 function ViewPrint(mVoucherNo,mExpType,tPrintMode)
 {
    var strurl="";
    if(mExpType=="Fixed")
    {
	    strurl="ExpenseVoucherFixedAddPrint.aspx?VNo=" + mVoucherNo + "&PrintMode=" + tPrintMode  
	}
	else
	{
        strurl="VariableExpenseVoucherPrint.aspx?VNo=" + mVoucherNo + "&PrintMode=" + tPrintMode  	
	}
     popup = window.open(strurl,"pbr","menubar=no,toolbar=no,resizable=yes,scrollbars=yes");
 }
 

</script>


<%
   string VoucherNo = "";

   VoucherNo = Request.QueryString["DocNo"];
   lblDocNoVal.Text = VoucherNo;

   string mExpType = "";
   mExpType = Request.QueryString["ExpType"];
   
 %>

<table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Expense Voucher</asp:Label>
              
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
                
                
                <a href="javascript:ViewPrint('<%=VoucherNo%>','<%=mExpType%>','0')"><font class="blackfnt">View</font></a>
                <asp:Label ID="lblSep1" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                 <a href="javascript:ViewPrint('<%=VoucherNo%>','<%=mExpType%>','1')"><font class="blackfnt">Print</font></a>

             
            </td>
        </tr>

        <tr style="background-color:White">
            <td align="left"> 
                <asp:Label ID="lblDocNameVal" runat="server" Text="Fixed Expense Voucher" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="left"  colspan="2"> 
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
                <asp:LinkButton ID="lnkStep1" runat="server" Text="Generate More Expense Voucher" CssClass="blackfnt" PostBackUrl="ExpenseVoucher.aspx"/>
            </td>
        </tr>
        
         <tr style="background-color:White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="LinkButton1" runat="server" Text="View/Print Expense Voucher" CssClass="blackfnt" PostBackUrl="ExpenseVoucherQyery.aspx"/>
            </td>
        </tr>
      
        
        
    </table>
    </center>
</asp:Content>