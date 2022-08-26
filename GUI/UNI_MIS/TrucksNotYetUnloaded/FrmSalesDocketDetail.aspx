<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="FrmSalesDocketDetail.aspx.cs" Inherits="FrmDocketDetail" EnableEventValidation="false"%>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<br />
    <div align="left" style="width:10in">
     <table style="width: 1000px">
        <tr>
        <td  align="left" >  
        <a><font class="blklnkund"><b>Module</b></font></a>
							<b> &gt; </b>
							<a><font class="blklnkund"><b>Reports</b></font></a>
							<b> &gt; </b>
							<a href="../rpt_operation.aspx"><font class="blklnkund"><b>Operations</b></font></a>
							<b> &gt; </b>
							<font class="bluefnt"><b>Trucks Not Yet Unloaded Report</b></font>
	    </td>
	        <td align="right">
	            <a href="javascript:window.history.go(-1)"  title="back"><img src="../../images/back.gif" border="0" alt="" /></a>
	        </td>
        </tr>
    </table>
    </div>  
    <br />
<div align="left">
    <table border="0" class="boxbg" cellpadding="0" cellspacing ="1" id="TABLE1">
        <tr class="bgbluegrey" > <td class="blackfnt" colspan="3" align="center" style="height: 23px">  Your Query Here
     </td></tr>
     
     <%--<table align="center" style="width: 282px;
        height: 19px" border="0" class="boxbg" cellpadding="0" cellspacing="1">
        <tr class="bgbluegrey" > <td colspan="3"  align="center" style="height: 23px">  Your Query Here
     </td></tr>--%>   
     
        <tr bgcolor="white">
            <td class="blackfnt" align="left">
                Location</td>
            <td class="blackfnt" align="left">
                <div align="left"><asp:Label ID="lblLocation" runat="server" Text="Label" Width="233px"></asp:Label></div> 
            </td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" align="left">
                Date Range
            </td>
            <td class="blackfnt" align="left">
                <div align="left"><asp:Label ID="lblDateRange" runat="server" Text="Label" Width="233px"></asp:Label></div> 
            </td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" align="left" >
                Report Type
            </td>
            <td class="blackfnt" align="left" >
                <div align="left"><asp:Label ID="lblrpttype" runat="server" Text="Label" Width="233px"></asp:Label></div> 
            </td>
        </tr>
    </table>
    <br />    
        <asp:GridView ID="GrdToPayFollow" EmptyDataText="No Records Found...!!!!" EmptyDataRowStyle-CssClass="blackfnt"  OnPageIndexChanging="PageIndexChanged_Click" AllowPaging="true"  PagerStyle-Mode="NumericPages" PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"  BackColor="white" runat="server" Width="762px" OnRowDataBound="GrdToPayFollow_RowDataBound" >
        <HeaderStyle CssClass="bgbluegrey" />
        <Columns>
        <asp:TemplateField HeaderText="SR.NO." >
        <HeaderStyle CssClass = "blackfnt" />
                <ItemTemplate>
                <asp:Label ID="lblsrno" CssClass="blackfnt" text ="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                </ItemTemplate>
        </asp:TemplateField> 
        <%--<asp:BoundField HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" HeaderText = "THC No." DataField="thcno"/>--%>
        <asp:TemplateField HeaderText="SR.NO." >
        <HeaderStyle CssClass = "blackfnt" />
                <ItemTemplate>
                <asp:Label ID="lblthcno" CssClass="blackfnt" text ='<%#DataBinder.Eval( Container.DataItem,"thcno") %>' runat="server"></asp:Label>
                <asp:LinkButton ID="lnkTrack" Text="Track" Font-Underline="true" runat="server"></asp:LinkButton> 
                <asp:LinkButton ID="lnkView" Text="View" Font-Underline="true" runat="server"></asp:LinkButton> 
                </ItemTemplate>
        </asp:TemplateField> 
        
        <asp:TemplateField Visible="false" HeaderText="SR.NO." >
        <HeaderStyle CssClass = "blackfnt" />
                <ItemTemplate>
                <asp:Label ID="lblthcsf" CssClass="blackfnt" text ='<%#DataBinder.Eval( Container.DataItem,"thcsf") %>' runat="server"></asp:Label>
                </ItemTemplate>
        </asp:TemplateField>  
        
        <asp:BoundField HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" HeaderText = "THC Date" DataField="thcdtD"/>
        <asp:BoundField HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" HeaderText = "Origin Code" DataField = "thcbr" />
        <asp:BoundField HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt" HeaderText = "Origin"  DataField = "location" />
        </Columns>
    </asp:GridView>  
    <br />
    <div style="width:762px" align="center"><asp:Button id="cmdexcel" onclick="cmdexcel_Click" runat="server" Text="Excel" Width="54px"></asp:Button></div> 
    </div> 
          
    &nbsp; &nbsp;
&nbsp; &nbsp;&nbsp; &nbsp;
</asp:Content> 
