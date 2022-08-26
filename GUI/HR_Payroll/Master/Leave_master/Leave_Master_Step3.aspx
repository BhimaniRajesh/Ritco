<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Leave_Master_Step3.aspx.cs" Inherits="GUI_HR_Payroll_Master_Leave_master_Leave_Master_Step3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <font class="blackfnt"><b>HR & Payroll :- </b></font><font class="bluefnt"><b>Leave
                    Masters</b> </font>
                <hr align="center" size="1" color="#8ba0e5">
                <div align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img src="../../../images/back.gif" border="0" alt="" /></a></div>
            </td>
        </tr>
    </table>
    <table border="0" cellpadding="3" width="66%" bgcolor="#808080" cellspacing="1" align="left"
        class="boxbg">
        <tr bgcolor="white">
            <td align="center" colspan="2">
                <asp:GridView Visible="false" ShowFooter="true" align="center" ID="dgDocket" runat="server"
                    BorderWidth="0" CellPadding="2" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey"
                    AllowSorting="true" AllowPaging="false" PageSize="25" PagerStyle-HorizontalAlign="left"
                    CssClass="boxbg" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                    AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                    EmptyDataText="No Records Found...">
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
                        <asp:BoundField DataField="LEAVE_NAME" HeaderText="LEAVE NAME">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="LEAVE_DESC" HeaderText="LEAVE DESC">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="AFFECT_SALARY" HeaderText="AFFECT SALARY">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CARRY_OVER" HeaderText="CARRY OVER">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CARRY_OVER_LIMIT" HeaderText="CARRY OVER LIMIT">
                            <HeaderStyle HorizontalAlign="right" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ACTIVEFLAG" HeaderText="ACTIVE">
                            <HeaderStyle HorizontalAlign="right" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                    <RowStyle />
                    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                    <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                    <FooterStyle HorizontalAlign="center" CssClass="bgbluegrey" />
                </asp:GridView>
            </td>
        </tr>
    </table>
</asp:Content>
