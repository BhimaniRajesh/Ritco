<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FrmAreaBillView.aspx.cs" Inherits="GUI_Tracking_FrmMenifestView" Title="Untitled Page" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
<table bgcolor="#ffffff"  width="100%"  border="0" cellpadding="3" cellspacing="1" class="boxbg">
<tr bgcolor="white">
    <td align="left" valign="baseline" >
        &nbsp;<br />
    <div align = "right">
    <table bgcolor="#ffffff" border="0" cellpadding="3" cellspacing="1" class="boxbg"
        colspan="2" style="width: 100%">
        <tr bgcolor="#ffffff" >
            <td align="center" class = "bgbluegrey" rowspan="2" colspan="3">
                <font class="blackfnt"><b>Bill Number :
                    <asp:Label ID="lblbillnumber" runat="server" Width="90px"></asp:Label></b></font></td>
        </tr>
        <tr bgcolor="#ffffff">
        </tr>
    </table>
    <br />
    <table bgcolor="#ffffff" border="0" cellpadding="3" cellspacing="1" class="boxbg"
        colspan="2" style="width: 100%">
        <tr bgcolor="#ffffff">
            <td align="left" style="width: 16%; height: 25px">
                <font class="blackfnt"><b>Bill Generation Date</b></font></td>
            <td align="left" style="width: 224px; height: 25px">
                <font class="blackfnt">
                    <asp:Label ID="lblbillgendate" runat="server" Width="97%" CssClass="blackfnt" ></asp:Label></font></td>
            <td align="left" class="blackfnt" style="width: 149px; height: 25px"><b>Billing Branch</b></td>
            <td align="left" style="width: 162px; height: 25px">
                <font class="blackfnt">
                    <asp:Label ID="lblbillbranch" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></font></td>
        </tr>
        <tr bgcolor="#ffffff">
            <td align="left" style="width: 16%; height: 25px;">
                <font class="blackfnt"><b>Bill Submission Date</b></font></td>
            <td align="left" style="width: 224px; height: 25px">
                <asp:Label ID="lblbillsubdt" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></td>
            <td align="left" class="blackfnt" style="width: 149px; height: 25px"><b>Bill Type</b></td>
            <td align="left" style="width: 162px; height: 25px">
                <asp:Label ID="lblbilltype" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></td>
        </tr>
        <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt" style="width: 16%; height: 25px">
                <strong>Bill Due Date</strong></td>
            <td align="left" style="width: 224px; height: 25px">
                <asp:Label ID="lblbillduedt" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></td>
            <td align="left" class="blackfnt" style="width: 149px; height: 25px">
                <strong>Party Code &amp; Name</strong></td>
            <td align="left" style="width: 162px; height: 25px">
                <asp:Label ID="lblpartyname" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></td>
        </tr>
        <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt" style="width: 16%; height: 25px">
                <strong>Bill Collection Date</strong></td>
            <td align="left" style="width: 224px; height: 25px">
                <asp:Label ID="lblbillcollectdt" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></td>
            <td align="left" class="blackfnt" style="width: 149px; height: 25px">
                <strong>Party Address</strong></td>
            <td align="left" style="width: 162px; height: 25px">
                <asp:Label ID="lblpaddress" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></td>
        </tr>
        <tr bgcolor="#ffffff">
            <td align="left" style="width: 16%; height: 25px">
            </td>
            <td align="left" style="width: 224px; height: 25px">
            </td>
            <td align="left" class="blackfnt" style="width: 149px; height: 25px">
                <strong>Party Phone</strong></td>
            <td align="left" style="width: 162px; height: 25px">
                <asp:Label ID="lblpphone" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></td>
        </tr>
        <tr bgcolor="#ffffff">
            <td align="left" style="width: 16%; height: 25px">
            </td>
            <td align="left" style="width: 224px; height: 25px">
            </td>
            <td align="left" class="blackfnt" style="width: 149px; height: 25px">
                <strong>Party Email</strong></td>
            <td align="left" style="width: 162px; height: 25px">
                <asp:Label ID="lblpemail" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width: 16%; height: 25px">
                <strong>Bill Generated By</strong></td>
            <td align="left" style="width: 224px; height: 25px">
                <asp:Label ID="lblbillgeneratedby" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></td>
            <td align="left" class="blackfnt" style="width: 149px; height: 25px">
                <strong>Bill Submitted By</strong></td>
            <td align="left" style="width: 162px; height: 25px">
                <asp:Label ID="lblbillsubmittedby" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></td>
        </tr>
        <tr bgcolor="#ffffff">
            <td class="blackfnt" align="left" style="width: 16%; height: 25px">
                <strong>Bill Collected By</strong></td>
            <td align="left" style="width: 224px; height: 25px">
                <asp:Label ID="lblbillcollectedby" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></td>
            <td align="left" class="blackfnt" style="width: 149px; height: 25px">
                <strong>Bill Closed By</strong></td>
            <td align="left" style="width: 162px; height: 25px">
                <asp:Label ID="lblbillclosedby" runat="server" CssClass="blackfnt" Width="97%"></asp:Label></td>
        </tr>
    </table>
    <br />
    <div align="center" >
    <asp:GridView ID="GrdPaidFollow" style="width: 100%" ShowFooter="true" EmptyDataText="No Records Found For Docket Detail....!!"  AllowPaging="false" PagerStyle-Mode="NumericPages" CssClass="boxbg" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"  BackColor="white" runat="server" SelectedIndex="1" OnRowDataBound="GrdPaidFollow_RowDataBound" EmptyDataRowStyle-CssClass="blackfnt"> 
    <Columns>
    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderText="Docket No./Pay Basis" Visible="true">
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                <asp:Label ID="lbldktno" CssClass="blackfnt" Text='<%# Convert.ToString(DataBinder.Eval( Container.DataItem,"dockno"))%>' runat="server"></asp:Label>
                </ItemTemplate> 
    </asp:TemplateField> 
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Booking Branch" DataField="bookingbranch" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Delivery Branch" DataField="deliverybranch" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt"  DataFormatString="{0:dd-MMM-yy}" HeaderText="Docket Date" DataField="bookdate" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt"  DataFormatString="{0:dd-MMM-yy}" HeaderText="Commited Delivery Date" DataField="commiteddeldt" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt"  DataFormatString="{0:dd-MMM-yy}" HeaderText="Actual Delivery Date" DataField="actualdeldate" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Charged Weight" DataField="chargewt" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    <asp:TemplateField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderText="Docket Amount" Visible="true">
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                <asp:Label ID="lbldktamt" CssClass="blackfnt" Text='<%# Convert.ToDecimal(DataBinder.Eval(Container.DataItem,"dkttot") == System.DBNull.Value ? 0.00 : DataBinder.Eval(Container.DataItem, "dkttot")) - Convert.ToDecimal(DataBinder.Eval(Container.DataItem,"svctax") == System.DBNull.Value ? 0.00 : DataBinder.Eval(Container.DataItem, "svctax"))  - Convert.ToDecimal(DataBinder.Eval( Container.DataItem,"Tot_cess") == System.DBNull.Value ? 0.00 : DataBinder.Eval(Container.DataItem, "Tot_cess"))%>' runat="server"></asp:Label>
                </ItemTemplate> 
    </asp:TemplateField> 
    
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Service Tax" DataField="svctax" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
     <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Cess + H.Cess + SB.Cess + KK.Cess" DataField="Tot_cess" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
   
    <asp:BoundField HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center" HeaderStyle-CssClass="blackfnt" HeaderText="Docket Total" DataField="dkttot" ItemStyle-Font-Size="11 px" ItemStyle-CssClass="blackfnt"/>
    
    </Columns> 
    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
        <HeaderStyle CssClass="bgbluegrey" />
        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"/>
        <FooterStyle CssClass="boxbg" />
    </asp:GridView> 
    <div style="width:10.5 in">
    <table align="right">
    <tr>
    <td align="right" class="blackfnt">
    <asp:Label ID="lbltotalinword" runat="server"></asp:Label>
    </td>
    </tr>
    </table> 
    </div>
    <br />
    </div>
   
    </td>
    </tr>
</table> 
  </form>
</body>
</html>

