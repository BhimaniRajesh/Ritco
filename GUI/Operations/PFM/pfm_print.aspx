<%@ Page Language="C#" AutoEventWireup="true" CodeFile="pfm_print.aspx.cs" Inherits="GUI_Operations_PFM_pfm_print" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>PFM View</title>
    <link href="../../images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <% 
           string boxbg = "boxbg";
           string bgbluegrey = "bgbluegrey";
           string bluefnt = "bluefnt";
           string strborder = "0";
           string cellSpacing = "1";
           if (print_yn == "1")
           {
               boxbg = "";
               bgbluegrey = "bgwhite";
               bluefnt = "blackfnt";
               strborder = "1";
               cellSpacing = "0";
           }
        %>
        <br />        
        <table class="<%=boxbg %>" cellpadding="2" cellspacing="<%=cellSpacing %>" border="<%=strborder %>" style="width: 9.0in">
            <tr bgcolor="#FFFFFF">
                <td width="60%" >
                </td>
                <td valign="top">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr bgcolor="#FFFFFF">
                            <td >
                                <font class="blackfnt">&nbsp;PFM Number&nbsp;</font></td>
                            <td>
                                <div align="left">
                                    <font class="blackfnt">
                                        <%=PFMNO%>
                                    </font>
                                </div>
                            </td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                            <td bgcolor="#FFFFFF">
                                <font class="blackfnt">&nbsp;PFM Date&nbsp;</font></td>
                            <td>
                                <font class="<%=bluefnt %>">&nbsp;<asp:Label ID="lblPFMDt" runat="server"></asp:Label></font></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <br />
        <table border="<%=strborder %>" class="<%=boxbg %>" cellspacing="<%=cellSpacing %>" width="100%" cellpadding="2" style="width: 9.0in">
            <tr bgcolor="#FFFFFF">
                <td align="left" width="50%">
                    <font class="blackfnt"><b>Document Forwarding Summary</b></font></td>
                <td align="center">
                    <font class="<%=bluefnt %>">Preapared at :
                        <asp:Label ID="lblPrepareAt" runat="server"></asp:Label></font></td>
            </tr>
        </table>
        <br />
        <table border="<%=strborder %>" class="<%=boxbg %>" cellspacing="<%=cellSpacing %>" width="100%" cellpadding="2" style="width: 9.0in">
            <tr class="<%=bgbluegrey %>" >
                <td align="center">
                    <font class="blackfnt"><b>Document Summary</b></font></td>
            </tr>
        </table>
        <br />
        <table border="<%=strborder %>" class="<%=boxbg %>" cellspacing="<%=cellSpacing %>" cellpadding="4" width="100%" style="width: 9.0in"> 
            <tr bgcolor="#FFFFFF">
                <td width="15%">
                    <font class="blackfnt">Document From</font></td>
                <td width="35%">
                    <font class="<%=bluefnt %>">
                        <asp:Label ID="lblPFMFrom" runat="server"></asp:Label></font></td>
                <td width="15%">
                    <font class="blackfnt">Courier Name</font></td>
                <td width="35%">
                    <font class="blackfnt">
                        <asp:Label ID="lblCourierName" runat="server"></asp:Label></font></td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td>
                    <font class="blackfnt">Forwarded To</font></td>
                <td>
                    <font class="<%=bluefnt %>">
                        <asp:Label ID="lblForwardedTo" runat="server"></asp:Label></font></td>
                <td>
                    <font class="blackfnt">WayBill Number</font></td>
                <td>
                    <font class="<%=bluefnt %>">
                        <asp:Label ID="lblWayBillNo" runat="server"></asp:Label></font></td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td>
                    <font class="blackfnt">Total CN</font></td>
                <td>
                    <font class="<%=bluefnt %>">
                        <asp:Label ID="lblTotalCN" runat="server"></asp:Label></font></td>
                <td>
                    <font class="blackfnt">WayBill Date</font></td>
                <td>
                    <font class="<%=bluefnt %>">
                        <asp:Label ID="lblWayBillDt" runat="server"></asp:Label></font></td>
            </tr>
        </table>
        <br />
       <table border="<%=strborder %>" class="<%=boxbg %>" cellspacing="<%=cellSpacing %>" width="100%" cellpadding="2" style="width: 9.0in">
            <tr class="<%=bgbluegrey %>">
                <td align="center">
                    <font class="blackfnt"><b>PFM Details</b></font></td>
            </tr>
        </table>
        <br />
        <asp:GridView ID="gvpdclist" runat="server" CellSpacing="1"  GridLines="none"
            HeaderStyle-CssClass="bgbluegrey" AllowPaging="false" PagerStyle-HorizontalAlign="left" CssClass="boxbg" 
            FooterStyle-CssClass="boxbg" HeaderStyle-Height="24px" AutoGenerateColumns="false" 
            EmptyDataText="No Records Found..." style="width: 9.0in">
            <Columns>
                <asp:TemplateField HeaderText="SRNo." ControlStyle-CssClass="blackfnt">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Width="30" />
                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />                    
                    <ItemTemplate>
                        <asp:Label ID="lblSRNo" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="DockNo" HeaderText="POD No">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="bookdate" HeaderText="Booking Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Orgn_Dest" HeaderText="CN Origin-CN Delivery">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="deldt" HeaderText="CN Delivery Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Scan_Status" HeaderText="Scan Status">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Doc_Recieved" HeaderText="Recieved">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
            <HeaderStyle CssClass="bgbluegrey" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        <asp:GridView ID="gv_bill" runat="server" CellSpacing="1"  GridLines="none"
            HeaderStyle-CssClass="bgbluegrey" AllowPaging="false" PagerStyle-HorizontalAlign="left" CssClass="boxbg" 
            FooterStyle-CssClass="boxbg" HeaderStyle-Height="24px" AutoGenerateColumns="false" 
            EmptyDataText="No Records Found..." style="width: 9.0in" >
            <Columns>
                <asp:TemplateField HeaderText="SRNo." ControlStyle-CssClass="blackfnt">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Width="30" />
                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                    
                    <ItemTemplate>
                        <asp:Label ID="lblSRNo" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Bill_No" HeaderText="Bill No">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Manual_Bill_No" HeaderText="Manual Bill No">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Bill_Date" HeaderText="Bill Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Billing_Party" HeaderText="Billing Party">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Bill_Amount" HeaderText="Bill Amount">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Scan_Status" HeaderText="Scan Status">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Doc_Recieved" HeaderText="Recieved">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
            <HeaderStyle CssClass="bgbluegrey" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        <asp:GridView ID="gv_CODDOD" runat="server" CellSpacing="1" GridLines="none"
            HeaderStyle-CssClass="bgbluegrey" AllowPaging="false" PagerStyle-HorizontalAlign="left" CssClass="boxbg" 
            FooterStyle-CssClass="boxbg" HeaderStyle-Height="24px" AutoGenerateColumns="false" 
            EmptyDataText="No Records Found..." style="width: 9.0in">
            <Columns>
                <asp:TemplateField HeaderText="SRNo." ControlStyle-CssClass="blackfnt">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Width="30" />
                    <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />                    
                    <ItemTemplate>
                        <asp:Label ID="lblSRNo" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="DockNo" HeaderText="Docket No">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="DocumentNo" HeaderText="COD/DOD No">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                 <asp:BoundField DataField="DocumentDate" HeaderText="COD/DOD Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="bookdate" HeaderText="Booking Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Orgn_Dest" HeaderText="CN Origin-CN Delivery">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="deldt" HeaderText="CN Delivery Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Scan_Status" HeaderText="Scan Status">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Doc_Recieved" HeaderText="Recieved">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
            <HeaderStyle CssClass="bgbluegrey" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        <br />
        <table width="100%" visible="false" runat="server" border="1" cellspacing="1" cellpadding="0">
            <tr>
                <td width="28%" align="center">
                    <font class="blackfnt">&nbsp;Prepared by</font></td>
                <td width="27%" align="center">
                    <font class="blackfnt">Staff Signature </font>
                </td>
                <td width="27%" align="center">
                    <font class="blackfnt">Checked By</font></td>
                <td width="27%" align="center">
                    <font class="blackfnt">Entry Date &amp; Time</font></td>
            </tr>
            <tr>
                <td align="left">
                    <div align="center">
                        <font class="blackfnt">
                            <asp:Label ID="lblPrepareBy" runat="server"></asp:Label>&nbsp;</font>&nbsp;</div>
                </td>
                <td align="center">
                    &nbsp;<asp:Label ID="lblStaff" runat="server"></asp:Label></td>
                <td align="center">
                    &nbsp;<asp:Label ID="lblCheckedBy" runat="server"></asp:Label></td>
                <td align="center">
                    <div align="center">
                        <font class="blackfnt">
                            <asp:Label ID="lblEntryDt" runat="server"></asp:Label>&nbsp;</font>&nbsp;</div>
                </td>
            </tr>
        </table>
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
    </form>
</body>
</html>
