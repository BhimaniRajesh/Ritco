<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="results_det.aspx.cs" Inherits="GUI_UNI_Net_MIS_OUT_AR_results_det" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;
                        <strong>Finance </strong></font><font class="bluefnt"><strong></strong>&gt;<strong>OutStanding A/R Report
                            </strong> </font>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="./../../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img alt="Back" src="./../../images/back.gif" border="0">
                </a>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <p align="left">
                    <label class="blackfnt">
                        <b>You Selected </b>
                    </label>
                </p>
                <table runat="server" id="TBL_CRI" border="0" cellpadding="3" width="400" cellspacing="1"
                    align="left" class="boxbg">
                    <tr style="background-color: #ffffff">
                        <td style="height: 10px">
                            <label class="blackfnt">
                                Date</label></td>
                        <td style="height: 10px">
                            <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
                    </tr>
                    <tr style="background-color: #FFFFFF">
                        <td style="width: 205">
                            <label class="blackfnt">
                                Location</label></td>
                        <td style="width: 343">
                            <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: #FFFFFF">
                        <td style="width: 205; height: 6px;">
                            <label class="blackfnt">
                                Customer Code</label></td>
                        <td style="width: 343; height: 6px;">
                            <asp:Label ID="lblcust" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: #ffffff">
                        <td style="height: 6px">
                            <label class="blackfnt">
                                Report Type
                            </label>
                        </td>
                        <td style="height: 6px">
                            <asp:Label ID="lblflow" runat="server" CssClass="blackfnt"> 
                            </asp:Label></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="background-color: #ffffff">
            <td align="left" colspan="2">
                <asp:Button ID="btn_csv1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv1_Click" />
            </td>
        </tr>
        <tr style="background-color: #ffffff">
            <td colspan="2">
                <asp:GridView Visible="false" align="left" ID="dgDocket" runat="server" BorderWidth="0"
                    CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                    AllowPaging="true" PageSize="25" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                    FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                    PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..."
                    OnPageIndexChanging="pgChange">
                    <Columns>
                        <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white" HeaderStyle-Font-Bold="true">
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="blackfnt" Font-Bold="true"/>
                        </asp:TemplateField>
                        <asp:BoundField DataField="docno" HeaderText="Bill No">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Font-Bold="true" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="docdt" HeaderText="Bill Date">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="doctype_name" HeaderText="Bill Type">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="loccode" HeaderText="Generated At">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="billsubbrcd" HeaderText="Sub. Loc">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="doc_subdt" HeaderText="Sub. Date ">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="billcolbrcd" HeaderText="Coll. Loc">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="doc_colldt" HeaderText="Coll. Date ">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="docamt" HeaderText="Bill Amt.">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="right" BackColor="white" />
                        </asp:BoundField>
                    </Columns>
                    <RowStyle />
                    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                    <HeaderStyle CssClass="bgbluegrey" Font-Bold="true" />
                    <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                    <FooterStyle CssClass="boxbg" />
                </asp:GridView>
                <br />
                <asp:GridView Visible="false" align="left" ID="dgMR" runat="server" BorderWidth="0"
                    CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                    AllowPaging="true" PageSize="25" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                    FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                    PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..."
                    OnPageIndexChanging="pgChange">
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
                        <asp:BoundField DataField="docno" HeaderText="MR No">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="docdt" HeaderText="MR Date">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="doctype_name" HeaderText="Type">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="loccode" HeaderText="Generated At">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="docamt" HeaderText="Bill Amt.">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Font-Bold="true"/>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="right" BackColor="white" />
                        </asp:BoundField>
                    </Columns>
                    <RowStyle />
                    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                    <HeaderStyle CssClass="bgbluegrey" Font-Bold="true"/>
                    <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                    <FooterStyle CssClass="boxbg" />
                </asp:GridView>
            </td>
        </tr>
        <tr style="background-color: #ffffff">
            <td align="left" colspan="2">
                <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
