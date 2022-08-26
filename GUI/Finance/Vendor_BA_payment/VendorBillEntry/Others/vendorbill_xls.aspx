<%@ Page Language="C#" AutoEventWireup="true" CodeFile="vendorbill_xls.aspx.cs" Inherits="VendorPayment_new_vendorbill_xls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Vendor Bill View</title>
    <link href="../../images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
     <% string strGenerateBillNo = Request.QueryString.Get("strGenerateBillNo");
        string[] Split = strGenerateBillNo.Split(new Char[] { ',' });
        string GenerateBillNo = Convert.ToString(Split[0]);
        string print_yn = Convert.ToString(Split[1]);
        string boxbg = "boxbg";
        string bgbluegrey = "bgbluegrey";
        string strborder = "border='0'";
              if (print_yn == "1")
              {
                   boxbg = "";
                   bgbluegrey = "bgwhite";
                   strborder = "border='1'";
              }

      %>
    
    <table width="95%"  cellspacing="1" cellpadding="3" align="center" bgcolor="#808080" class='<%=boxbg%>'>
    <tr class='<%=bgbluegrey%>'> 
      <td valign="top" height="18"  colspan="4" align="center"><font class="blackfnt"><b>Vendor Bill Summary</b>
       </td>
    </tr>
    </table>
    
    <br />
    
    <table width="95%" cellspacing="1" cellpadding="3" align="center" bgcolor="#808080" class='<%=boxbg%>'>
    <tr> 
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="166"> 
        <p align="left"><font class="blackfnt">Bill Entry Number</font> 
      </td>
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="222"><font class="blackfnt">
          <%=GenerateBillNo%></font></td>
      <td valign="top" height="18" bgcolor="#FFFFFF" width="129"><font class="blackfnt">Bill entry date</font></td>
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="222"><font class="blackfnt">
          <asp:Label ID="lblbillentrydt" runat="server" Text="Label"></asp:Label></font></td>
     
      
    </tr>
    <tr> 
      <td valign="top" height="18" bgcolor="#FFFFFF" width="129"><font class="blackfnt">Vendor name</font></td>
      <td valign="top" height="18" bgcolor="#FFFFFF" align="center"> 
        <div align="left"><font class="blackfnt">
           <asp:Label ID="lblvendorname" runat="server" Text="Label"></asp:Label></font></div>
      </td>
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="166"><font class="blackfnt">Vendor Bill number</font></td>
      <td valign="top" height="18" bgcolor="#FFFFFF" align="left" width="222"><font class="blackfnt">
           <asp:Label ID="lblvendorbillnumber" runat="server" Text="Label"></asp:Label></font></td>
    </tr>
    
    <tr> 
      <td valign="top" height="19" bgcolor="#FFFFFF" width="129"><font class="blackfnt">Vendor Bill date</font></td>
      <td valign="top" height="19" bgcolor="#FFFFFF" width="102"> 
      <font class="blackfnt"> <asp:Label ID="lblvendorbilldt" runat="server" Text="Label"></asp:Label></font></td>
      <td valign="top" height="19" bgcolor="#FFFFFF" align="left" width="166"><font class="blackfnt">Due date</font></td>
      <td valign="top" height="19" bgcolor="#FFFFFF" align="left" width="222">
       <font class="blackfnt"><asp:Label ID="lblduedt" runat="server" Text="Label"></asp:Label>
      </font></td>
    </tr>
    <tr> 
      <td valign="top" height="21" bgcolor="#FFFFFF" width="129"><font class="blackfnt">Contract Amount (+)</font></td>
      <td valign="top" height="21" bgcolor="#FFFFFF"  width="102">
       <font class="blackfnt">  <asp:Label ID="lblcontractamt" runat="server" Text="Label"></asp:Label>
          </font></td>
      <td valign="top" height="21" bgcolor="#FFFFFF" align="left" width="166"><font class="blackfnt">Advance Paid (-)</font></td>
      <td valign="top" height="21" bgcolor="#FFFFFF" align="left" width="222"> 
      <font class="blackfnt"> <asp:Label ID="lbladvancepaid" runat="server" Text="Label"></asp:Label>
          </font></td>
    </tr>
    <tr> 
       <td valign="top" height="26" bgcolor="#FFFFFF" width="129"><font class="blackfnt">Other Amount (+)</font></td>
      <td valign="top" height="26" bgcolor="#FFFFFF"  width="102">  
      <font class="blackfnt"> <asp:Label ID="lblotheramount" runat="server" Text="Label"></asp:Label>
          </font></td>
      <td valign="top" height="26" bgcolor="#FFFFFF" align="left" width="166"><font class="blackfnt">Deductions (-)</font></td>
      <td valign="top" height="26" bgcolor="#FFFFFF" align="left" width="222"> 
      <font class="blackfnt"> <asp:Label ID="lbldeduction" runat="server" Text="Label"></asp:Label>
          </font></td>
    </tr>
    <tr> 
       <td valign="top" height="26" bgcolor="#FFFFFF" width="129"><font class="blackfnt">Service Tax Charged (+)</font></td>
      <td valign="top" height="26" bgcolor="#FFFFFF" align="left" width="102"> 
        <font class="blackfnt"><font class="blackfnt"> 
        <font class="blackfnt">  <asp:Label ID="lblservicetaxcharged" runat="server" Text="Label"></asp:Label>
            </font></td>
      <td valign="top" height="26" bgcolor="#FFFFFF" align="left" width="166"><font class="blackfnt">Service Tax Deduction (-)</font></td>
      <td valign="top" height="26" bgcolor="#FFFFFF" align="left" width="222"> 
      <font class="blackfnt"> <asp:Label ID="lblsvctaxdeduction" runat="server" Text="Label"></asp:Label>
          </font></td>
    </tr>
    
     <tr> 
       <td valign="top" height="26" bgcolor="#FFFFFF" width="129"><font class="blackfnt">Cess (+)</font></td>
      <td valign="top" height="26" bgcolor="#FFFFFF" align="left" width="102"> 
        <font class="blackfnt">  <asp:Label ID="lblcess" runat="server" Text="Label"></asp:Label>
            </font></td>
       <td valign="top"  bgcolor="#FFFFFF" align="left" width="25%"><font class="blackfnt">TDS Deduction </font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="20%">
      <font class="blackfnt"> <asp:Label ID="lblTDSdeduction" runat="server" Text="Label"></asp:Label>
          </font></td>
	</tr>
     <tr> 
        <td bgcolor="#FFFFFF"><font class="blackfnt">&nbsp;</font></td>
						<td bgcolor="#FFFFFF"><font class="blackfnt"></td>
       <td valign="top" height="26" bgcolor="#FFFFFF" width="129"><font class="blackfnt">Net Payable</font></td>
      <td valign="top" height="26" bgcolor="#FFFFFF" align="left" width="102">
          <font class="blackfnt"> <asp:Label ID="lblnetpayable" runat="server" Text="Label"></asp:Label></font></td>
        </tr>
       
    
    </table>
    
    <br />
    
     <table width="95%"  cellspacing="1" cellpadding="3" align="center" bgcolor="#808080" class='<%=boxbg%>'>
    <tr class='<%=bgbluegrey%>'> 
      <td valign="top" height="18"  colspan="4" align="center"><b><font class="blackfnt"><b>Vendor Bill Details</b>
       </td>
    </tr>
    </table>
    <br />
        
        <asp:GridView ID="GridView1" runat="server" align="center" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey" 
                                                         PagerStyle-HorizontalAlign="left" 
                                                             CssClass="blackfnt" BackColor="white" FooterStyle-CssClass="boxbg"   
                                                             AllowPaging="true" PageSize="25" 
                                                       
                                                            OnPageIndexChanging="pgChange" AllowSorting="False"  RowStyle-HorizontalAlign="Right"
                                                            AutoGenerateColumns="false" 
                                                              
                                                            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." >
                                                                <PagerStyle VerticalAlign="Bottom" />
                                                                <Columns>
                                                                <asp:BoundField DataField="DOCNO" HeaderText="Document No." />
                                                                <asp:BoundField DataField="PCAMT" HeaderText="Contract Amount(+)" />
                                                                <asp:BoundField DataField="OTHAMT" HeaderText="Other Amount(+)" />
                                                                <asp:BoundField DataField="SVCTAX" HeaderText="Service Tax(+)" />
                                                                <asp:BoundField DataField="CESS" HeaderText="Cess(+)" />
                                                                <asp:BoundField DataField="ADVPAID" HeaderText="Advance Paid(-)" />
                                                                <asp:BoundField DataField="OTHDED" HeaderText="Other Ded.(-)" />
                                                                <asp:BoundField DataField="SVCTAXDED" HeaderText="Service Tax Ded.(-)" />
                                                                <asp:BoundField DataField="tds_rate" HeaderText="TDS Rate" />
                                                                <asp:BoundField DataField="tdsded" HeaderText="TDS Ded.(-)" />
                                                                <asp:BoundField DataField="netpay" HeaderText="Net Payable" />
                                                                </Columns>
                                                                
    </asp:GridView>
   <br />
   
   
    <%
         if (print_yn == "1")
       {
         
       %>
        <script language="javascript" type="text/javascript">
       
        function loadme()
        {
        
            window.print();
        }
       window.load =loadme()
        </script>
       <%} %>  
   
    </div>
    </form>
</body>
</html>
