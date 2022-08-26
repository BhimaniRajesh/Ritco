<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="sfm_funnel_report_Sale_wise1.aspx.cs" Inherits="REPORT_sfm_funnel_report_Sale_wise1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Funnel-SalesPerson Wise Report" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        </table>
        
        <br />
        
        <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td align="right">
                        <a href="javascript:window.history.go(-1)" title="back">
                        <img border="0" src="../images/back.gif" /></a>
                    </td>
                </tr>
            </table>
            <br />
            
<table border="0"  cellpadding="3"  colspan="2"  width="45%" bgcolor="#ffffff" cellspacing="1" class="boxbg">
					<tr bgcolor="#ffffff">
						<td  align="left" width="30%">
							<font class="blackfnt"><b>Region</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt">
                                <asp:Label ID="lblRegion" runat="server" Text=""></asp:Label></font></td>
					</tr>
					<tr bgcolor="#ffffff">
						<td  align="left" width="30%">
							<font class="blackfnt"><b>Location</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt"><asp:Label ID="lblLocation" runat="server" Text=""></asp:Label></font>
						</td>
					</tr>

					<tr bgcolor="#ffffff">
						<td  align="left" width="30%">
							<font class="blackfnt"><b>Sales Person</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt"><asp:Label ID="lblSalesPerson" runat="server" Text=""></asp:Label></font>
						</td>
					</tr>
					<tr bgcolor="#ffffff">
						<td  align="left" width="42%">
							<font class="blackfnt"><b>Date Selection</b></font>
						</td>
						<td  align="left">
							<font class="blackfnt"><asp:Label ID="lblDateRange" runat="server" Text=""></asp:Label></font>
						</td>
					</tr>
				</table>
				
				<br />
				
                    <table id="headingtable" 
    style="FONT-WEIGHT: bold; COLOR: #244668" borderColor="#000033"
    height="100%" cellspacing="0" 
    cellpadding="0" border="0" runat="server">
    <tr>
    <td>
                    
                        <asp:DataGrid ID="dgfunnel" runat="server" BorderWidth="1" CellSpacing="1" CellPadding="5" HeaderStyle-CssClass="bgbluegrey" HeaderStyle-Font-Bold="true"
                                BorderColor="#8ba0e5" AllowPaging="true" CssClass="blackfnt"   AutoGenerateColumns="false" OnPageIndexChanged="pgChange">
                             <ItemStyle Height="30px" VerticalAlign="Top"/>
                             <AlternatingItemStyle Height="30px"/>
                             <PagerStyle Mode="NumericPages" />
                             <HeaderStyle />
                             <Columns>
                        
                        
                        
                        
                        
                        <asp:TemplateColumn ItemStyle-BorderColor="#000033" 
            ItemStyle-Width="25Px" ItemStyle-Wrap="True" 
            HeaderStyle-CssClass="bgbluegrey">
        <HeaderTemplate>Employee
    </td>
    <td width="500"  colspan="2" 
           align="center">HOT</td>
    <td width="500"  colspan="2" 
           align="center">WARM</td>
    <td width="500"  colspan="2" 
           align="center">COLD</td>
    <td width="500"  colspan="2" 
           align="center">ALL</td>
</tr><td Align="Center" Height="25px" 
       class="GrdHeaderStyle" ></td>
</HeaderTemplate>
<ItemTemplate>
    <asp:Label ID="location" Text='<%# DataBinder.Eval(Container.DataItem,"UserID")+ ":" + DataBinder.Eval(Container.DataItem,"Name") %> ' runat="server" Width="150px"></asp:Label>
</ItemTemplate>
</asp:TemplateColumn>
<asp:TemplateColumn HeaderText="Prospects" HeaderStyle-CssClass="GrdHeaderStyle" HeaderStyle-Font-Bold="true"
       ItemStyle-Width="75Px" ItemStyle-Wrap="True" 
       ItemStyle-CssClass="GrdItemStyle">
    <ItemTemplate>
        <%--<asp:Label ID="lblCompanyName"  Width="75Px" 
             Runat="server" 
             text='<%# DataBinder.Eval(Container.DataItem,"HotKount") %>'>
        </asp:Label>--%>
        
   <label class="blackfnt">
    <asp:HyperLink  Runat="server" Font-Underline="True" CssClass="blackfnt"  NavigateUrl='<%#"sfm_funnel_report_sales_person_wise2.aspx?pro=" +DataBinder.Eval(Container.DataItem, "HotKount")+"&entryby="+DataBinder.Eval(Container.DataItem, "UserId") +"&calltype="+"HOT"+"&value="+DataBinder.Eval(Container.DataItem, "HotWalue") + "&location=" + Request.QueryString["location"].ToString() + "&fromdt=" +strActualFromDate + "&todt=" +strActualToDate %>' Text= '<%#DataBinder.Eval(Container.DataItem, "HotKount")%>' ID="Hyperlink1">
    </asp:HyperLink>
   </label>
        </ItemTemplate>
    </asp:TemplateColumn>
    <asp:TemplateColumn HeaderText="Value" HeaderStyle-Font-Bold="true"
            HeaderStyle-CssClass="GrdHeaderStyle" 
            ItemStyle-Width="75Px" ItemStyle-Wrap="True" 
            ItemStyle-CssClass="GrdItemStyle">
        <ItemTemplate>
            <asp:Label ID="lblWebSiteName" Width="75Px" 
                  Runat="server" 
                  text='<%# DataBinder.Eval(Container.DataItem,"HotWalue") %>'>
            </asp:Label>
        </ItemTemplate>
    </asp:TemplateColumn>
    <asp:TemplateColumn HeaderText="Prospects" HeaderStyle-Font-Bold="true"
                HeaderStyle-CssClass="GrdHeaderStyle" 
                ItemStyle-Width="75Px" ItemStyle-Wrap="True" 
                ItemStyle-CssClass="GrdItemStyle">
        <ItemTemplate>
            <%--<asp:Label ID="lblContactPersonName" Width="75Px" 
                Runat="server" 
                text='<%# DataBinder.Eval(Container.DataItem,"WarmKount") %>'>
            </asp:Label>--%>
            <label class="blackfnt">
    <asp:HyperLink  Runat="server" Font-Underline="True" CssClass="blackfnt"  NavigateUrl='<%#"sfm_funnel_report_sales_person_wise2.aspx?pro=" +DataBinder.Eval(Container.DataItem, "WarmKount")+"&entryby="+DataBinder.Eval(Container.DataItem, "UserId") +"&calltype="+"WARM"+"&value="+DataBinder.Eval(Container.DataItem, "WarmWalue") + "&location=" + Request.QueryString["location"].ToString() + "&fromdt=" +strActualFromDate + "&todt=" +strActualToDate %>' Text= '<%#DataBinder.Eval(Container.DataItem, "WarmKount")%>' ID="Hyperlink1">
    </asp:HyperLink>
    </label>
        </ItemTemplate>
    </asp:TemplateColumn>
    <asp:TemplateColumn HeaderText="Value" HeaderStyle-Font-Bold="true"
            HeaderStyle-CssClass="GrdHeaderStyle" 
            ItemStyle-Width="75Px"
            ItemStyle-Wrap="True" 
            ItemStyle-CssClass="GrdItemStyle">
        <ItemTemplate>
            <asp:Label ID="lblBillno" Width="75px" 
                Runat="server" 
                text='<%# DataBinder.Eval(Container.DataItem,"WarmWalue") %>'>
            </asp:Label>
        </ItemTemplate>
    </asp:TemplateColumn>
    <asp:TemplateColumn HeaderText="Prospects" HeaderStyle-Font-Bold="true"
          HeaderStyle-CssClass="GrdHeaderStyle" 
          ItemStyle-Width="75Px" ItemStyle-Wrap="True" 
          ItemStyle-CssClass="GrdItemStyle">
        <ItemTemplate>
            <%--<asp:Label ID="lblBillDate" Width="75Px" 
               Runat="server" 
               text='<%# DataBinder.Eval(Container.DataItem,"ColdKount") %>'>
            </asp:Label>--%>
            
            <label class="blackfnt">
    <asp:HyperLink  Runat="server" Font-Underline="True" CssClass="blackfnt"  NavigateUrl='<%#"sfm_funnel_report_sales_person_wise2.aspx?pro=" +DataBinder.Eval(Container.DataItem, "ColdKount") +"&entryby="+DataBinder.Eval(Container.DataItem, "UserId")+"&calltype="+"COLD"+"&value="+DataBinder.Eval(Container.DataItem, "ColdWalue") + "&location=" + Request.QueryString["location"].ToString() + "&fromdt=" +strActualFromDate + "&todt=" +strActualToDate %>' Text= '<%#DataBinder.Eval(Container.DataItem, "ColdKount")%>' ID="Hyperlink1">
    </asp:HyperLink>
    </label>
        </ItemTemplate>
    </asp:TemplateColumn>
    <asp:TemplateColumn HeaderText="Value" HeaderStyle-Font-Bold="true"
          HeaderStyle-CssClass="GrdHeaderStyle" 
          ItemStyle-Width="75Px"
          ItemStyle-Wrap="True" ItemStyle-CssClass="GrdItemStyle">
        <ItemTemplate>
            <asp:Label ID="lblamount" Width="75px" 
                 Runat="server" 
                 text='<%# DataBinder.Eval(Container.DataItem,"ColdWalue") %>'>
            </asp:Label>
        </ItemTemplate>
    </asp:TemplateColumn>
    <asp:TemplateColumn HeaderText="Prospects" HeaderStyle-Font-Bold="true"
               HeaderStyle-CssClass="GrdHeaderStyle" 
               ItemStyle-CssClass="GrdItemStyle">
        <ItemTemplate>
           <%-- <asp:Label ID="lblPayout" Width="75px" Runat="server" 
               text='<%# DataBinder.Eval(Container.DataItem,"AllKount") %>'>
            </asp:Label>--%>
             <label class="blackfnt">
    <asp:HyperLink  Runat="server" Font-Underline="True" CssClass="blackfnt"  NavigateUrl='<%#"sfm_funnel_report_sales_person_wise2.aspx?pro=" +DataBinder.Eval(Container.DataItem, "AllKount")+"&entryby="+DataBinder.Eval(Container.DataItem, "UserId") +"&calltype="+""+"&value="+DataBinder.Eval(Container.DataItem, "AllWalue") + "&location=" + Request.QueryString["location"].ToString() + "&fromdt=" +strActualFromDate + "&todt=" +strActualToDate %>' Text= '<%#DataBinder.Eval(Container.DataItem, "AllKount")%>' ID="Hyperlink1">
    </asp:HyperLink>
    </label>
        </ItemTemplate>
    </asp:TemplateColumn>
    <asp:TemplateColumn HeaderText="Value" HeaderStyle-Font-Bold="true"
               HeaderStyle-CssClass="GrdHeaderStyle" 
               ItemStyle-CssClass="GrdItemStyle">
        <ItemTemplate>
            <asp:Label ID="lblPayout" Width="75px" Runat="server" 
               text='<%# DataBinder.Eval(Container.DataItem,"AllWalue") %>'>
            </asp:Label>
        </ItemTemplate>
    </asp:TemplateColumn>
    
           </Columns>             
                        
                       
                                
                  </asp:DataGrid>
                  </td></tr>
</table>
                       
                   

</asp:Content>
