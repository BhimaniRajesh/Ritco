<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="dtl_outstanding.aspx.cs" Inherits="OutStanding_dtl_outstanding" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 11.5in;" align="left" border="0">
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
    <br />
    <div style="width: 10in" align="center">
        <table border="0" cellspacing="1" cols="1" width="35%" align="center" class="boxbg">
            <tr style="background-color: #FFFFFF" class="bgbluegrey">
                <td colspan="2" class="bgbluegrey" style="width: 205">
                    <p align="center">
                        <label class="blackfnt">
                            <b>You Selected </b>
                        </label>
                    </p>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF">
                <td align="left" style="width: 205">
                    <label class="blackfnt">
                        Bill Type
                    </label>
                </td>
                <td align="left" style="width: 343">
                    &nbsp;
                    <asp:Label ID="lblBillingType" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            <tr align="left" style="background-color: #FFFFFF">
                <td style="width: 205">
                    <label class="blackfnt">
                        Age Of O/s</label></td>
                <td style="width: 343">
                    &nbsp;
                    <asp:Label ID="lblageos" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            <tr align="left" style="background-color: #FFFFFF">
                <td style="width: 205; height: 25px;">
                    <label class="blackfnt">
                        Date By</label></td>
                <td style="width: 343; height: 25px;">
                    &nbsp;
                    <asp:Label ID="lbldatetype" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            <tr align="left" style="background-color: #FFFFFF">
                <td style="width: 205">
                    <label class="blackfnt">
                        Date Of Outstanding</label></td>
                <td style="width: 343">
                    &nbsp;
                    <asp:Label ID="lbldtout" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
        </table>
        <%--</center>--%>
        <br />
        <%-- <table id="tblBillDetails" runat="server" border="0" cellspacing="1" cellpadding="4" style="width: 100%" align="center" class="boxbg">
                                                                <tr class="bgbluegrey"> 
                                                                    <td colspan="4" align="center">
                                                                        <label class="blackfnt">
                                                                            <b>
                                                                 Customer Outstanding 
                                                                            </b>    
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                </tr>
                                                            </table>--%>
        <%-- <asp:GridView align="center" ID="GridView1" runat="server" BorderWidth="1" CellPadding="2" Width="8in"
            HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
            BackColor="white" FooterStyle-CssClass="boxbg" AutoGenerateColumns="false" OnPageIndexChanging="pgChange"
            AllowSorting="False" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
            EmptyDataText="No Records Found...">
            <PagerStyle HorizontalAlign="center" />
            <Columns>
                <asp:TemplateField HeaderText="SR.NO.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                        </asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="On Acc. Balance">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField HeaderText=" Ladger Balance">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="ptmscd" HeaderText="Billing Party">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="Undue" HeaderText="Undue Amt.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="First_amt" HeaderText="0-30">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="Second_amt" HeaderText="30-60">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="Third_amt" HeaderText="61-90">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="Fifth_amt" HeaderText=">181">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="Total_amt" HeaderText=" Total ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>--%>
        <asp:GridView align="center" ID="GridView3" runat="server" BorderWidth="0" CellPadding="2"
            CellSpacing="1" Width="8in" HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
            CssClass="boxbg" FooterStyle-CssClass="boxbg" AutoGenerateColumns="false" OnPageIndexChanging="pgChange"
            AllowSorting="False" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
            EmptyDataText="No Records Found...">
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
                <asp:BoundField DataField="ptmscd" HeaderText="Party ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="Undue" HeaderText="Undue ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="First_amt" HeaderText="0-30 ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="second_amt" HeaderText=" 31-60 ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="third_amt" HeaderText=" 61-90 ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="forth_amt" HeaderText=" 91-180 ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="fifth_amt" HeaderText=" >180 ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                </asp:BoundField>
                <asp:BoundField DataField="total_amt" HeaderText=" Total  ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
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
        <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
    </div>
</asp:Content>
