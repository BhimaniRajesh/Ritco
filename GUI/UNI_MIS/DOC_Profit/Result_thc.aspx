<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Result_thc.aspx.cs" Inherits="GUI_UNI_MIS_DOC_Profit_Result_thc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table width="80%" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30"> 
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong>
                <font class="blklnkund"><strong>Reports </strong></font><strong>&gt; </strong><font class="blklnkund"><strong>Operation </strong></font>
                <strong>&gt; </strong>
                <font class="bluefnt">
                    <strong>&gt; </strong><strong>Document Profitability</strong></font>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="../../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr>
            <td>
                <img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>
        <tr>
            <td align="right">
            <a href="javascript:window.history.go(-1)" title="back">
                <img src="./../../images/back.gif" border="0"></a>
                </td>
        </tr>
        <tr>
            <td height="300" valign="top">
                <br />
                <br />
    <br />
    <asp:GridView Visible="false" align="left" ID="dgDocket" runat="server" BorderWidth="0"
        CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
        AllowPaging="true" PageSize="25" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
        FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
        OnRowDataBound="dgDocket_RowDataBound" PagerSettings-FirstPageText="[First]"
        PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange">
        <Columns>
            <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                <ItemTemplate>
                    <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                        runat="server">
                    </asp:Label>
                </ItemTemplate>
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                <HeaderStyle CssClass="blackfnt" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                <HeaderTemplate>
                    <asp:Label CssClass="blackfnt" ID="lblColname" runat="server"> </asp:Label>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label CssClass="blackfnt" ID="lbldockno" Text='<% #DataBinder.Eval(Container.DataItem, "thcno")%>'
                        runat="server">
                    </asp:Label>
                </ItemTemplate>
                <HeaderStyle CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:BoundField DataField="thcdt" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="sourcehb" HeaderText="Origin">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="tobh_code" HeaderText="Destination">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="route" HeaderText="Route">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="vendor" HeaderText="Vendor ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="total_dockets" HeaderText="Total Dockets">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="Total_freight" HeaderText="Total Freight">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="THCcost" HeaderText="THC Cost">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="profit" HeaderText="profit">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="profit_per" HeaderText="Profit %">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
           
            <asp:TemplateField Visible="false" HeaderText="">
                <ItemTemplate>
                    <asp:Label ID="p_l" Text='<%# DataBinder.Eval(Container.DataItem,"p_l") %>'
                        runat="server"></asp:Label>
                         <asp:Label ID="Profit_per" Text='<%# DataBinder.Eval(Container.DataItem,"Profit_per") %>'
                        runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle />
        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
        <HeaderStyle CssClass="bgbluegrey" />
        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
        <FooterStyle CssClass="boxbg" />
    </asp:GridView>
    
    <asp:Table id="TBLDKTProf" Visible="false" border="0" HorizontalAlign="center" runat="server" CellPadding="3" CellSpacing="1" style="width:8.5in;" CssClass="boxbg"></asp:Table>
    <br />
    </td>
                    </tr>
                    <tr> 
                      <td><table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="left">
        <tr bgcolor="white">
            <td colspan="2" align="center">
                <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
    </table></td>
                    </tr>
                    <tr>
                      <td></td>
                    </tr>
                  </table>

</asp:Content>
