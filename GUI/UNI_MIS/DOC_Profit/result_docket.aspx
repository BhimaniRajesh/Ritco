<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="result_docket.aspx.cs" Inherits="GUI_UNI_MIS_DOC_Profit_result_docket" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <p align="center">
        <label class="blackfnt">
            <b>You Selected </b>
        </label>
    </p>
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
                <img src="./../../images/back.gif" border="0">
                </a></td>
        </tr>
        <tr>
            <td height="300" valign="top">
                <br />
                <br />
    <br />
    <asp:GridView Visible="false" align="center" ID="dgDocket" runat="server" BorderWidth="0"
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
                    <asp:Label CssClass="blackfnt" ID="lbldockno" Text='<% #DataBinder.Eval(Container.DataItem, "dockno")%>'
                        runat="server">
                    </asp:Label>
                </ItemTemplate>
                <HeaderStyle CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:BoundField DataField="dockdt" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="orgncd" HeaderText="Origin">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="destcd" HeaderText="Destination">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="pkgsno" HeaderText="Pkgs">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="actuwt" HeaderText="Actual Wt. ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="chrgwt" HeaderText="Chrg Wt.">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="dkttot" HeaderText="Docket Total">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="subtotal" HeaderText="SubTotal">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="yield" HeaderText="Yield">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="prsno" HeaderText="Prsno">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="Pick_up_cost" HeaderText="Pickup Cost ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="Ba_code" HeaderText="BA code">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="ba_comm_cost" HeaderText="BA COst">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="thcno_1" HeaderText="THC1 No.">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="Thccost_1" HeaderText="THC1 Cost">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="thcno_2" HeaderText="THC2 No. ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="Thccost_2" HeaderText="THC2 Cost">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="thcno_3" HeaderText="THC3 No. ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="Thccost_3" HeaderText="THC3 Cost">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="thcno_4" HeaderText="THC4 No.">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="Thccost_4" HeaderText="THC4 Cost">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="thcno_5" HeaderText="THC5 No.">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="Thccost_5" HeaderText="THC5 Cost">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="drsno" HeaderText="DRS No.">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="delivery_cost" HeaderText="Delivery Cost">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="tottal_cost" HeaderText="Total Cost">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="profit" HeaderText="Profit/Loss ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="Profit_per" HeaderText="Profit/Loss %">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="p_l" Visible="false" HeaderText="Profit/Loss ">
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
    <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="center">
        <tr bgcolor="white">
            <td colspan="2" align="center">
                <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
    </table></td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td></td>
                    </tr>
                  </table>

</asp:Content>
