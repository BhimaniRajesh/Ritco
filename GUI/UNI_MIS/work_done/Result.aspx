<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result.aspx.cs" Inherits="GUI_UNI_MIS_work_done_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <p align="center">
        <label class="blackfnt">
            <b>You Selected </b>
        </label>
    </p>
    <%--<center>--%>
    <table border="0" cellpadding="3" width="565" cellspacing="1" align="center" class="boxbg">
        <tr style="background-color: #ffffff">
            <td style="height: 10px">
                <label class="blackfnt">
                    Date :</label></td>
            <td style="height: 10px">
                <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #FFFFFF">
            <td style="width: 205; height: 15px;">
                <label class="blackfnt">
                    RO :</label></td>
            <td style="width: 343; height: 15px;">
                &nbsp;
                <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        <tr style="background-color: #FFFFFF">
            <td style="width: 205">
                <label class="blackfnt">
                    Location :</label></td>
            <td style="width: 343">
                &nbsp;
                <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        <tr style="background-color: #FFFFFF">
                <td style="width: 205; height: 6px;">
                    <label class="blackfnt">
                        Customer Code :</label></td>
                <td style="width: 343; height: 6px;">
                    &nbsp;
                    <asp:Label ID="lblcust" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
         <tr style="background-color: #ffffff">
                <td style="height: 6px">
                    <label class="blackfnt">
                        Report Type :
                    </label>
                </td>
                <td style="height: 6px">
                    <asp:Label ID="lblflow" runat="server" CssClass="blackfnt"> 
                    </asp:Label></td>
            </tr>
    </table>
    <br />
    <asp:Table id="TBL_MonthlySales" border="0" HorizontalAlign="center" runat="server" CellPadding="3" CellSpacing="1" style="width:8.5in;" CssClass="boxbg"></asp:Table>
    <%--<br />
    <asp:GridView Visible="false" ShowFooter="true" align="center" ID="dgDocket" runat="server" BorderWidth="0"
        CellPadding="2" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
        AllowPaging="false" PageSize="25" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
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
                    <asp:Label CssClass="blackfnt" ID="lblColname123" Text="Location" runat="server"> </asp:Label>
                </HeaderTemplate>
                <ItemTemplate>
                <asp:HiddenField ID="hidro" runat="server"  Value='<% #DataBinder.Eval(Container.DataItem, "report_loc")%>' />
                 <asp:HiddenField ID="hidroname" runat="server" Value='<% #DataBinder.Eval(Container.DataItem, "report_name")%>' />
                    <asp:Label CssClass="blackfnt" ID="lbldockfrom" Text='<% #DataBinder.Eval(Container.DataItem, "loccode")+" - " +DataBinder.Eval(Container.DataItem, "locname")%>'
                        runat="server">
                    </asp:Label>
                </ItemTemplate>
                <HeaderStyle CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="left" />
                
            </asp:TemplateField>
            <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                <HeaderTemplate>
                    <asp:Label CssClass="blackfnt" ID="lblColname" runat="server"> </asp:Label>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label CssClass="blackfnt" ID="lbldockno" Text='<% #DataBinder.Eval(Container.DataItem, "tot_dockets")%>'
                        runat="server">
                    </asp:Label>
                </ItemTemplate>
                <HeaderStyle CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                <FooterTemplate>
                    <asp:Label CssClass="blackfnt" Font-Bold="true" ID="lbltotnodocks" runat="server" Text="0"></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                <HeaderTemplate>
                    <asp:Label CssClass="blackfnt" ID="lblCol11" Text="Total LS Booked" runat="server"> </asp:Label>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label CssClass="blackfnt" ID="lblls" Text='<% #DataBinder.Eval(Container.DataItem, "tot_ls")%>'
                        runat="server">
                    </asp:Label>
                </ItemTemplate>
                <HeaderStyle CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                 <FooterTemplate>
                    <asp:Label CssClass="blackfnt" Font-Bold="true" ID="lbltotnols" runat="server" Text="0"></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                <HeaderTemplate>
                    <asp:Label CssClass="blackfnt" ID="lblCol22" Text="Total MF Booked" runat="server"> </asp:Label>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label CssClass="blackfnt" ID="lblmf" Text='<% #DataBinder.Eval(Container.DataItem, "tot_mf")%>'
                        runat="server">
                    </asp:Label>
                </ItemTemplate>
                <HeaderStyle CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                 <FooterTemplate>
                    <asp:Label CssClass="blackfnt" Font-Bold="true" ID="lbltotnomf" runat="server" Text="0"></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                <HeaderTemplate>
                    <asp:Label CssClass="blackfnt" ID="lblColthc" runat="server"> </asp:Label>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label CssClass="blackfnt" ID="lblthc" Text='<% #DataBinder.Eval(Container.DataItem, "tot_thc")%>'
                        runat="server">
                    </asp:Label>
                </ItemTemplate>
                <HeaderStyle CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                  <FooterTemplate>
                    <asp:Label CssClass="blackfnt" Font-Bold="true" ID="lbltotnothc" runat="server" Text="0"></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                <HeaderTemplate>
                    <asp:Label CssClass="blackfnt" ID="lblCol23" Text="Total PRS Booked" runat="server"> </asp:Label>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label CssClass="blackfnt" ID="lblprs" Text='<% #DataBinder.Eval(Container.DataItem, "tot_PRS")%>'
                        runat="server">
                    </asp:Label>
                </ItemTemplate>
                <HeaderStyle CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                  <FooterTemplate>
                    <asp:Label CssClass="blackfnt" Font-Bold="true" ID="lbltotnoprs" runat="server" Text="0"></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                <HeaderTemplate>
                    <asp:Label CssClass="blackfnt" ID="lblCol24" Text="Total DRS Booked" runat="server"> </asp:Label>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label CssClass="blackfnt" ID="lbldrs" Text='<% #DataBinder.Eval(Container.DataItem, "tot_DRS")%>'
                        runat="server">
                    </asp:Label>
                </ItemTemplate>
                <HeaderStyle CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                  <FooterTemplate>
                    <asp:Label CssClass="blackfnt" Font-Bold="true" ID="lbltotnodrs" runat="server" Text="0"></asp:Label>
                </FooterTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle />
        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
        <FooterStyle HorizontalAlign="center" CssClass="bgbluegrey" />
    </asp:GridView>
    <br />--%>
    <br />
    <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="center">
        <tr bgcolor="white">
            <td colspan="2" align="center">
                <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
