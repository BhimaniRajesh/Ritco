<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="FrmVendorOutstanding.aspx.cs" Inherits="FrmPaidFollowUp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
   <script language="javascript" type="text/jscript">
//    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
   </script>  

    <br />
    <div align="center">
     <table style="width: 1008px">
        <tr>
        <td  align="left" >  
        <a><font class="blklnkund"><b>Module</b></font></a>
							<b> &gt; </b>
							<a><font class="blklnkund"><b>Reports</b></font></a>
							<b> &gt; </b>
							<a href="../rpt_finance.aspx"><font class="blklnkund"><b>Finance & Accounts</b></font></a>
							<b> &gt; </b>
							<font class="bluefnt"><b>Vendor Outstanding Report</b></font>
	    </td>
	        <td align="right">
	            <a href="javascript:window.history.go(-1)"  title="back"><img src="../../images/back.gif" border="0" alt="" /></a>
	        </td>
        </tr>
    </table>
    </div>  
        
        <br />
    <table align="center" border="0" cellpadding="0" cellspacing="1" class="boxbg" style="width: 398px;
        height: 1px">
        <tr class="bgbluegrey">
            <td align="center" class="blackfnt" colspan="3" style="height: 23px">
                Your Query 
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" class="blackfnt" style="width: 94px">
                    Date Range</td>
            <td style="width: 136px">
                <div align="left">
                    <asp:Label ID="lbldaterange" runat="server" CssClass="blackfnt" Text="Label" Width="267px"></asp:Label></div>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" class="blackfnt" style="width: 94px; height: 16px">
                    Vendor Type</td>
            <td style="width: 136px; height: 16px">
                <div align="left">
                    <asp:Label ID="lblRO" runat="server" CssClass="blackfnt" Text="Label" Width="267px"></asp:Label></div>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" class="blackfnt" style="width: 94px">
                    Vendor</td>
            <td style="width: 136px">
                <div align="left">
                    <asp:Label ID="lblLocation" runat="server" align="left" CssClass="blackfnt" Text="Label"
                        Width="267px"></asp:Label></div>
            </td>
        </tr>
    </table>
        <br />
        <asp:TextBox ID="TxtRO" runat="server" Width="66px" ReadOnly="True" Visible="False"></asp:TextBox><asp:TextBox ID="txtLocation" runat="server" Width="168px" ReadOnly="True" Visible="False"></asp:TextBox><asp:TextBox ID="TxtCCode" runat="server" Width="168px" ReadOnly="True" Visible="False"></asp:TextBox><asp:TextBox ID="TxtDateRange" runat="server" Width="237px" ReadOnly="True" Visible="False"></asp:TextBox><asp:TextBox ID="TxtFDt" runat="server" Visible="False"></asp:TextBox>
        <asp:TextBox ID="TxtTDt" runat="server" Visible="False"></asp:TextBox><br />
        <div align="center">
        <asp:GridView ID="GrdPaidFollow" EmptyDataText="No Data Found........" EmptyDataRowStyle-CssClass="blackfnt" AllowPaging="true" OnRowDataBound="GrdToPayFollow_RowDataBound1" OnPageIndexChanging="PageIndexChanged_Click"  PagerStyle-Mode="NumericPages" CssClass="boxbg" PageSize="10" AutoGenerateColumns="true" HeaderStyle-CssClass="bgbluegrey"  BackColor="white" runat="server" SelectedIndex="1" OnRowCreated="GrdToPayFollow_RowCreated">
        <Columns>
        <asp:TemplateField HeaderText="SR.NO." >
                <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                <asp:Label ID="LblSrNo" CssClass="blackfnt" runat="server"></asp:Label>
                <%--<asp:TemplateField HeaderText= "Sr.No" ><ItemTemplate> <asp:Label ID="LblSrNo" runat="server" Text="Sr.No"></asp:Label></ItemTemplate> </asp:TemplateField> --%>
                </ItemTemplate>
        </asp:TemplateField> 
        </Columns> 
        <RowStyle  />
        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
        <HeaderStyle CssClass="bgbluegrey" />
        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"/>
        <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        </div>
        <br />
        <br />
        <div align ="center">
        <asp:Button ID="cmdexcel" runat="server" OnClick="cmdexcel_Click" Text="Excel" Width="54px" />
        </div>
   </asp:Content>
