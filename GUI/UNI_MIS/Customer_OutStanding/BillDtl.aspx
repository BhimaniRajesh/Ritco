<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" EnableEventValidation="false"
    CodeFile="BillDtl.aspx.cs" Inherits="OutStanding_BillDtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div style="width: 9.5in" runat="server">
        <table cellspacing="1" style="width: 9.5in;" align="left" border="0">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_finance.aspx"><font class="blklnkund">
                            <b>Finance</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Customer Outstanding
                                Report </b></font>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <br />
        <%--<center>--%>
        <asp:Panel ID="sasa" runat="server" align="center">
            <table border="0" cellpadding="3" width="50%" cellspacing="1" align="center" class="boxbg">
                <tr class="bgbluegrey">
                    <td colspan="2" align="center">
                        <label class="bluefnt">
                            <b>You Selected </b>
                        </label>
                    </td>
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td align="left">
                        <label class="blackfnt">
                            Bill Party
                        </label>
                    </td>
                    <td align="left">
                        &nbsp;
                        <asp:Label ID="lblBillingParty" Width="50" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td align="left">
                        <label class="blackfnt">
                            Bill Type
                        </label>
                    </td>
                    <td align="left">
                        &nbsp;
                        <asp:Label ID="lblBillingType" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td align="left">
                        <label class="blackfnt">
                            Age Of O/s</label></td>
                    <td align="left">
                        &nbsp;
                        <asp:Label ID="lblageos" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: #FFFFFF">
                    <td align="left">
                        <label class="blackfnt">
                            Date By</label></td>
                    <td align="left">
                        &nbsp;
                        <asp:Label ID="lbldatetype" runat="server" CssClass="blackfnt"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <br />
            <br />
            <br />
            <asp:GridView align="center" ID="GridView1" runat="server" BorderWidth="0" CellPadding="1"
                Width="9in" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
                CssClass="boxbg" FooterStyle-CssClass="blackfnt" FooterStyle-BackColor="white"
                FooterStyle-Font-Bold="true" AutoGenerateColumns="false" OnPageIndexChanging="pgChange"
                AllowPaging="true" PageSize="25" AllowSorting="False" ShowFooter="true" PagerSettings-FirstPageText="[First]"
                PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                <PagerStyle HorizontalAlign="center" />
                <Columns>
                    <asp:TemplateField HeaderText="SR.NO.">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" CssClass="blackfnt" />
                        <ItemTemplate>
                            <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="BILLNO" HeaderText="Bill Number">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="BILLTYPE" HeaderText=" Bill type ">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="PTMSCD" HeaderText="Billing Party">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="BILLCOLBRCD" HeaderText="Collection at">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="BILLSUBBRCD" HeaderText="Submitted at">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="BGNDT" HeaderText="Bill date">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="BSBDT" HeaderText="Submission date ">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="BDUEDT" HeaderText="Due date ">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="OVERDAYS" HeaderText="Overdue days ">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="BCLDT" HeaderText=" Collection date  ">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="SERVICETAXPAYABLE" HeaderText=" Service Tax + Cess ">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="BILLAMT" HeaderText="Bill Amount ">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CLAMT" HeaderText=" Collection amount  ">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="pendamt" HeaderText=" Pending Amount   ">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" CssClass="blackfnt" />
                    </asp:BoundField>
                </Columns>
            </asp:GridView>
            &nbsp;
            <br />
            <center>
                <%--Table for displaying no records found message--%>
                <table id="tblNoRecords" runat="server" border="0" style="width: 98%; background-color: #808080"
                    align="center" cellspacing="1" cellpadding="2" class="boxbg" visible="false">
                    <tr style="background-color: #FFFFFF">
                        <td colspan="22" align="right">
                            <div align="center">
                                <label style="color: #FF0000;" class="blackfnt">
                                    No Record Found
                                </label>
                            </div>
                        </td>
                    </tr>
                </table>
            </center>
        </asp:Panel>
        <br />
        <br />
        <center>
            <table width="25%" border="0" cellspacing="1" cellpadding="3" align="center" id="tblButtons"
                runat="server">
                <tr style="background-color: #ffffff">
                    <td>
                        <div align="center">
                            <asp:Button ID="brngr2" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click2" />
                        </div>
                    </td>
                </tr>
            </table>
        </center>
    </div>
</asp:Content>
