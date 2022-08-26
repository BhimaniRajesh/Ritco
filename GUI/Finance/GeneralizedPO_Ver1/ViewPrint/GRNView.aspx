<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GRNView.aspx.cs" Inherits="GUI_Finance_Fix_Asset_ViewPrint_GRNView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>GRN View</title>
    <link href="../../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <% string strDRSNo = Request.QueryString.Get("GRNNO");
               string[] Split = strDRSNo.Split(new Char[] { ',' });
               string DRSNo = Convert.ToString(Split[0]);
               string print_yn = Convert.ToString(Split[1]);
               string boxbg = "boxbg";
               string bgbluegrey = "bgbluegrey";
               string strborder = "0";
               string strspace = "1";
               if (print_yn == "1")
               {
                   boxbg = "";
                   bgbluegrey = "bgwhite";
                   strborder = "1";
                   strspace = "1";
               }

            %>
            <table border='<%=strborder %>' cellspacing='<%=strspace %>' cellpadding="0" class='<%=boxbg %>'
                style="width: 6.7in">
                <tr bgcolor="white">
                    <td colspan="4" valign="top">
                        <asp:Image Height="50" ID="imgLogo" runat="server" />
                    </td>
                </tr>
                <tr bgcolor="white" align="center">
                    <td colspan="4" valign="top" align="left">
                        <font class="blackfnt"><b><asp:Label ID="lblGRNView" runat="server" Text="Goods Receipt Note Detail"></asp:Label></b></font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td valign="top" align="left">
                        <font class="blackfnt"><b><asp:Label ID="Label1" runat="server" Text="GRN NO :"></asp:Label></b></font>
                    </td>
                    <td valign="top" align="left" >
                        <font class="blackfnt"><asp:Label ID="lblGRNNo" runat="server"></asp:Label></font>
                    </td> 
                    <td valign="top" align="left">
                        <font class="blackfnt"><b><asp:Label ID="Label3" runat="server" Text="VENDOR NAME :"></asp:Label></b></font>
                    </td>
                    <td valign="top" align="left" >
                        <font class="blackfnt"><asp:Label ID="lblVendor" runat="server"></asp:Label></font>
                    </td>                    
                </tr>
                <tr bgcolor="white">
                    <td valign="top" align="left">
                        <font class="blackfnt"><b><asp:Label ID="lblGDate" runat="server" Text="GRN DATE :"></asp:Label></b></font>
                    </td>
                    <td valign="top" align="left">
                        <font class="blackfnt"><asp:Label ID="lblGRNDATE" runat="server"></asp:Label></font>
                    </td>
                    <td valign="top" align="left">
                        <font class="blackfnt"><b><asp:Label ID="lblRDate" runat="server" Text="RECEVIED DATE :"></asp:Label></b></font>
                    </td>
                    <td valign="top" align="left">
                        <font class="blackfnt"><asp:Label ID="lblReceviedDate" runat="server"></asp:Label></font>
                    </td>                    
                </tr>
                <tr bgcolor="white">
                    <td valign="top" align="left">
                        <font class="blackfnt"><b><asp:Label ID="lblBR" runat="server" Text="GRN LOCATION :"></asp:Label></b></font>
                    </td>
                    <td valign="top" align="left">
                        <font class="blackfnt"><asp:Label ID="lblBBRCD" runat="server"></asp:Label></font>
                    </td>
                    <td valign="top" align="left">
                        <font class="blackfnt"><b><asp:Label ID="Label4" runat="server" Text="PAYMENT LOCATION :"></asp:Label></b></font>
                    </td>
                    <td valign="top" align="left">
                        <font class="blackfnt"><asp:Label ID="lblPAY_LOC" runat="server"></asp:Label></font>
                    </td>                    
                </tr>
                <tr bgcolor="white">
                    <td valign="top" align="left">
                        <font class="blackfnt"><b><asp:Label ID="Label2" runat="server" Text="Manual GRN No :"></asp:Label></b></font>
                    </td>
                    <td valign="top" align="left">
                        <font class="blackfnt"><asp:Label ID="lblManualGRNNo" runat="server"></asp:Label></font>
                    </td>
                    <td valign="top" align="left">
                        <font class="blackfnt"><b><asp:Label ID="Label5" runat="server" Text="REMARK :"></asp:Label></b></font>
                    </td>
                    <td valign="top" align="left">
                        <font class="blackfnt"><asp:Label ID="lblRemark" runat="server"></asp:Label></font>
                    </td>                    
                </tr>
                <tr bgcolor="white">
                    <td valign="top" align="left">
                        <font class="blackfnt"><b><asp:Label ID="Label6" runat="server" Text="GRN Status :"></asp:Label></b></font>
                    </td>
                    <td colspan="3" valign="top" align="left">
                        <font class="blackfnt"><asp:Label ID="LblGRNStatus" runat="server"></asp:Label></font>
                    </td>                    
                </tr>
                <tr bgcolor="white" id="Cancelled" runat="server" style="display:none">
                    <td valign="top" align="left">
                        <font class="blackfnt"><b><asp:Label ID="Label7" runat="server" Text="Cancelled By :"></asp:Label></b></font>
                    </td>
                    <td valign="top" align="left">
                        <font class="blackfnt"><asp:Label ID="LblCancelledBy" runat="server"></asp:Label></font>
                    </td>
                    <td valign="top" align="left">
                        <font class="blackfnt"><b><asp:Label ID="Label9" runat="server" Text="Cancelled Date :"></asp:Label></b></font>
                    </td>
                    <td valign="top" align="left">
                        <font class="blackfnt"><asp:Label ID="LblCancelledDate" runat="server"></asp:Label></font>
                    </td>                    
                </tr>
            </table>
            <asp:GridView ID="GV_Booking" runat="server" align="left" BorderWidth="1" CellPadding="2"
                HeaderStyle-CssClass='<%=bgbluegrey %>' CssClass='<%=boxbg %>'
                BackColor="white" FooterStyle-CssClass='<%=boxbg %>' AllowPaging="true" PageSize="1000"
                AllowSorting="false" AutoGenerateColumns="false" ShowFooter="false" 
                EmptyDataText="No Records Found..." Width="6.7in">
                <PagerStyle VerticalAlign="Bottom" />
                <Columns>
                    <asp:TemplateField HeaderText="SR.NO.">
                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                        <ItemStyle CssClass="blackfnt" Width="50" HorizontalAlign="Center" />
                        <ItemTemplate>
                            <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="POCode" ItemStyle-Wrap="true" HeaderText="PO Code" HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="POdate" ItemStyle-Wrap="true" HeaderText="PO Date" HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>                    
                    <asp:BoundField DataField="Item_Desc" ItemStyle-Wrap="true" HeaderText="Asset Name"
                        HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="left" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Qty" ItemStyle-Wrap="true" HeaderText="Total PO Qty" HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="right" CssClass="blackfnt" />
                    </asp:BoundField>                    
                    <asp:BoundField DataField="REceivedQty" ItemStyle-Wrap="true" HeaderText="Received Qty" HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="right" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="BalanceQty" ItemStyle-Wrap="true" HeaderText="Balance Qty" HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="right" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Rate" ItemStyle-Wrap="true" HeaderText="Rate" HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="right" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TOTALAMT" ItemStyle-Wrap="true" HeaderText="Total" HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="right" CssClass="blackfnt" />
                    </asp:BoundField>
                </Columns>
            </asp:GridView>
        </div>
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
