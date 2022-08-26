<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="FrmSalesDocketDetail.aspx.cs" Inherits="FrmDocketDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<div align="center">
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
    <br />
    <table style="width: 326px;
        height: 19px" border="0" class="boxbg" cellpadding="0" cellspacing ="1" id="TABLE1">
        <tr class="bgbluegrey" > <td colspan="3" align="center" class="blackfnt"  style="height: 23px">  Your Query Here
     </td></tr>
     
     <%--<table align="center" style="width: 282px;
        height: 19px" border="0" class="boxbg" cellpadding="0" cellspacing="1">
        <tr class="bgbluegrey" > <td colspan="3"  align="center" style="height: 23px">  Your Query Here
     </td></tr>--%>   
     
        <tr bgcolor="white">
            <td class="blackfnt" style="width: 24px; height: 23px;">
                Vendor</td>
            <td style="width: 150px; height: 23px;">
                <div align="left"><asp:Label ID="lblLocation" CssClass ="blackfnt" runat="server" Text="Label" Width="233px"></asp:Label></div> 
            </td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" style="width: 24px; height: 20px">
                Date
            </td>
            <td class="blackfnt" style="width: 150px; height: 20px">
                <div align="left"><asp:Label ID="lblDateRange" CssClass ="blackfnt" runat="server" Text="Label" Width="233px"></asp:Label></div> 
            </td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" style="width: 24px; height: 20px">
                Status
            </td>
            <td class="blackfnt" style="width: 150px; height: 20px">
                <div align="left"><asp:Label ID="lblStatus" CssClass ="blackfnt" runat="server" Text="Label" Width="233px"></asp:Label></div> 
            </td>
        </tr>
    </table>
    <br />
    <br />    
        <asp:GridView ID="GrdToPayFollow" OnPageIndexChanging="PageIndexChanged_Click" AllowPaging="true"  PagerStyle-Mode="NumericPages" PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"  BackColor="white" runat="server" Width="762px" OnRowDataBound="GrdToPayFollow_RowDataBound1">
        <HeaderStyle CssClass="bgbluegrey" />
        <Columns>
        <asp:TemplateField HeaderText= "Sr.No" HeaderStyle-CssClass = "blackfnt" ><ItemTemplate> <asp:Label ID="LblSrNo" CssClass="blackfnt" runat="server" Text="Sr.No"></asp:Label></ItemTemplate> </asp:TemplateField> 
        </Columns>
    </asp:GridView>  
     <br /> 
    <div align="center"><asp:Button id="cmdexcel" onclick="cmdexcel_Click" runat="server" Text="Excel" Width="54px"></asp:Button></div> 
    </div> 
          
    &nbsp; &nbsp;
&nbsp; &nbsp;&nbsp; &nbsp;
</asp:Content> 
