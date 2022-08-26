<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="FrmTrucksNotYetUnloaded.aspx.cs" Inherits="FrmPaidFollowUp" EnableEventValidation="false"%>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
   <script language="javascript" type="text/jscript">
//    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
   </script>  
 <br />
    <div align="left" style="width:10in">
     <table style="width: 1008px">
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
        <div align="left" >
            &nbsp;<table border="0" cellpadding="0" cellspacing="1" class="boxbg" style="width: 398px;
                height: 1px">
                <tr class="bgbluegrey">
                    <td align="center" colspan="3" style="height: 23px" class="blackfnt">
                        Your Query
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" style="width: 60px;" class="blackfnt">
                        Date</td>
                    <td style="width: 136px; ">
                    <div align="left">
                        <asp:Label ID="lblDate" align="left" runat="server" Text="Label" CssClass="blackfnt" Width="267px"></asp:Label></div></td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" style="width: 60px;" class="blackfnt">
                        RO</td>
                    <td style="width: 136px;">
                        <div align="left">
                            <asp:Label ID="lblStatus" runat="server" CssClass="blackfnt" Text="Label" Width="267px"></asp:Label></div>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" style="width: 60px;" class="blackfnt">
                        Location</td>
                    <td style="width: 136px;">
                            <div align="left"><asp:Label ID="lbllocation" CssClass="blackfnt"  runat="server" Text="Label" Width="267px"></asp:Label></div> 
                    </td>
                </tr>
            </table>
        </div>
        <asp:TextBox ID="txtfdate" runat="server" Visible="false"></asp:TextBox>  
        <asp:TextBox ID="txttdate" runat="server" Visible="false"></asp:TextBox>  
    &nbsp;<br />
    <br />
    <div><asp:GridView ID="GrdPaidFollow" EmptyDataText="No Records Found...!!!!" EmptyDataRowStyle-CssClass="blackfnt" AllowPaging="true" OnPageIndexChanging="PageIndexChanged_Click"  PagerStyle-Mode="NumericPages" CssClass="boxbg" PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"  BackColor="white" runat="server" SelectedIndex="1" OnRowDataBound="GrdPaidFollow_RowDataBound"> 
    <Columns>
        <asp:TemplateField HeaderText="SR.NO." >
                <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                <asp:Label ID="lblsrnocomplainlist" CssClass="blackfnt" text ="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                </ItemTemplate>
        </asp:TemplateField> 
        <asp:TemplateField HeaderText="Location">
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                <asp:Label ID="lbllocation" CssClass="blackfnt"  text = "label1" runat="server"></asp:Label>
                </ItemTemplate>
        </asp:TemplateField>   
        <asp:TemplateField HeaderText="LocCode" Visible="false">
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                <asp:Label ID="lblloccode" Font-Underline="true" ForeColor="black" CssClass="blackfnt" text ='<%# DataBinder.Eval( Container.DataItem,"sourcehb") %>' runat="server"></asp:Label>
                </ItemTemplate>
        </asp:TemplateField>   
        <asp:TemplateField HeaderText="LocName" Visible="false">
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                <asp:Label ID="lbllocname" Font-Underline="true" ForeColor="black" CssClass="blackfnt" text ='<%# DataBinder.Eval( Container.DataItem,"locName") %>' runat="server"></asp:Label>
                </ItemTemplate>
        </asp:TemplateField>   
        <%--<asp:BoundField DataField="op_dly" HeaderText="Function" />  --%>
        <asp:TemplateField HeaderText="Function" Visible="true">
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                <asp:Label ID="lblfunction1" CssClass="blackfnt" Text='<%#DataBinder.Eval( Container.DataItem,"op_Tranship") %>' runat="server"></asp:Label>                
                <asp:Label ID="lblfunction2" CssClass="blackfnt" Text='<%#DataBinder.Eval( Container.DataItem,"op_dly") %>' runat="server"></asp:Label>
                </ItemTemplate>
        </asp:TemplateField>
        <%--<asp:TemplateField HeaderText="Expected Arrivals">
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                   <asp:LinkButton ID="lbltot1" ForeColor="black"  Font-Underline=true CssClass="blackfnt"  text ='<%# DataBinder.Eval( Container.DataItem,"tot1") %>' runat="server"></asp:LinkButton>
                   <%--PostBackUrl='<%#"~/GUI/UNI_MIS/DocketsNotYetDelivered/FrmSalesDocketDetail.aspx?fromdate=" + txtfdate.Text + "&todate=" + txttdate.Text + "&loccode=" + DataBinder.Eval(Container.DataItem, "loccode") + "&location=" + DataBinder.Eval(Container.DataItem, "locname") + "&mode=Total GCNs for Delivery&val=delivery"%>'--%>
                <%--</ItemTemplate>
        </asp:TemplateField>--%>
        <asp:HyperLinkField ItemStyle-CssClass="blackfnt" ControlStyle-Font-Underline="true" ItemStyle-Font-Underline="true" ItemStyle-ForeColor="black" DataTextField ="tot1" DataNavigateUrlFields="sourcehb,frmdate,todate" DataNavigateUrlFormatString="FrmSalesDocketDetail.aspx?loccode={0}&fromdate={1}&todate={2}&val=expected&mode=Expected Arrivals"  HeaderStyle-CssClass="blackfnt" HeaderText="Expected Arrivals" />
        <%--<asp:TemplateField HeaderText="Total THCs Unloaded">
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                   <asp:LinkButton ID="lbltot2" ForeColor="black"  Font-Underline=true  CssClass="blackfnt"  text ='<%# DataBinder.Eval( Container.DataItem,"tot2") %>' runat="server"></asp:LinkButton>--%>
                   <%--PostBackUrl='<%#"~/GUI/UNI_MIS/DocketsNotYetDelivered/FrmSalesDocketDetail.aspx?fromdate=" + txtfdate.Text + "&todate=" + txttdate.Text + "&loccode=" + DataBinder.Eval(Container.DataItem, "loccode") + "&location=" + DataBinder.Eval(Container.DataItem, "locname") + "&mode=GCN awaiting DRS&val=drs"%>'--%>
<%--                </ItemTemplate>
        </asp:TemplateField>
--%>        <asp:HyperLinkField ItemStyle-CssClass="blackfnt" ControlStyle-Font-Underline="true" ItemStyle-Font-Underline="true" ItemStyle-ForeColor="black" DataTextField ="tot2" DataNavigateUrlFields="sourcehb,frmdate,todate" DataNavigateUrlFormatString="FrmSalesDocketDetail.aspx?loccode={0}&fromdate={1}&todate={2}&val=unloadedTHC&mode=Total THCs Unloaded" HeaderStyle-CssClass="blackfnt" HeaderText="Total THCs Unloaded" />        
        <%--<asp:TemplateField HeaderText="Balance THCs To Be Unloaded">
        <HeaderStyle CssClass="blackfnt" /> 
                <ItemTemplate>
                   <asp:LinkButton ID="lblsubtract" ForeColor="black" CssClass="blackfnt"  Font-Underline=true  text ='a'  runat="server"></asp:LinkButton>--%>
                   <%--PostBackUrl='<%#"~/GUI/UNI_MIS/DocketsNotYetDelivered/FrmSalesDocketDetail.aspx?fromdate=" + txtfdate.Text + "&todate=" + txttdate.Text + "&loccode=" + DataBinder.Eval(Container.DataItem, "loccode") + "&location=" + DataBinder.Eval(Container.DataItem, "locname") + "&mode=GCNs gone for delivery&val=gonedelivery"%>'--%>
                <%--</ItemTemplate>
        </asp:TemplateField>--%>
        <asp:HyperLinkField ItemStyle-CssClass="blackfnt" ControlStyle-Font-Underline="true" ItemStyle-Font-Underline="true" ItemStyle-ForeColor="black" DataTextField ="subtract" DataNavigateUrlFields="sourcehb,frmdate,todate" DataNavigateUrlFormatString="FrmSalesDocketDetail.aspx?loccode={0}&fromdate={1}&todate={2}&val=unloadedTHCbal&modes=Balance THCs to be Unloaded" HeaderStyle-CssClass="blackfnt" HeaderText="Balance THCs to be Unloaded" />        
        <asp:BoundField DataField="report_loc" HeaderText="report_loc" Visible="false" /> 
        <asp:BoundField DataField="frmdate" HeaderText="from date" Visible="false" /> 
        <asp:BoundField DataField="todate" HeaderText="to date" Visible="false" /> 
        </Columns>
        <RowStyle  />
        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
        <HeaderStyle CssClass="bgbluegrey" />
        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
                />
        <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        </div>
        <div align="center" style="width:7.9in">
            <br />
            <asp:Button ID="Button1" runat="server" OnClick="cmdexcel_Click" Text="Excel" Width="54px" /><br />
            &nbsp;</div>

   </asp:Content>
