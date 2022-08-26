<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result.aspx.cs" Inherits="GUI_UNI_MIS_Account_Reports_CBS_ver1_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong>&gt;<font
                        class="blklnkund"><strong>Accounts </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>Cash & Bank Report</strong> </font>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="../../../images/clear.gif" width="2" height="1" /></td>
        </tr>
        <tr>
            <td align="right">
                <div align="center">
                    <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                        <ProgressTemplate>
                            <div id="progressArea">
                                <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </div>
                <a href="javascript:window.history.go(-1)" title="back">
                    <img alt="Back" src="../../../images/back.gif" border="0" />
                </a>
            </td>
        </tr>
        <tr>
            <td>
                <table border="0" runat="server" id="TBL_CRI"   horizontalalign="left" cellpadding="3" cellspacing="1" style="width: 5.5in;"
                    class="boxbg">
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Date</td>
                        <td>
                            <asp:Label runat="server" ID="LBLDATE"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            RO</td>
                        <td>
                            <asp:Label runat="server" ID="LBLBRANCH"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Location</td>
                        <td>
                            <asp:Label runat="server" ID="LBLRPT"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Accounts</td>
                        <td>
                            <asp:Label runat="server" ID="LBLSUBRPT"></asp:Label></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td  align="left"  valign="top"><br />
            
                            <asp:Button ID="Button1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                        
            </td>
        </tr>
        <tr>
            <td valign="top">
                <br /><asp:Table id="TBL_CBS" Visible="false" border="0" HorizontalAlign="left" runat="server" CellPadding="3" CellSpacing="1" style="width:8.5in;" CssClass="boxbg"></asp:Table>
                <asp:GridView Visible="false" align="left" ID="dgDocket" runat="server" BorderWidth="0"
                    CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="false"
                    CssClass="boxbg" AutoGenerateColumns="false" FooterStyle-CssClass="boxbg" OnRowDataBound="dgDocket_RowDataBound"
                    EmptyDataText="No Records Found...">
                    <Columns>
                        <asp:BoundField DataField="Heading" HeaderText="">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" Font-Bold="true" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Voucherno" HeaderText="Voucher No.">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="V_Date" HeaderText="Date">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="party" HeaderText="Party">
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Particulars" HeaderText="Particular">
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Location" HeaderText="Location">
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="BANK_NAME" HeaderText="Cash/Bank Name">
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CHQNo" HeaderText="Cheque No">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CHQDT" HeaderText="Cheque Date">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CASH_Debit" HeaderText="CASH">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CASH_Credit" HeaderText="CASH">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="BANK_Debit" HeaderText="BANK">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:BoundField DataField="BANK_Credit" HeaderText="BANK">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" CssClass="blackfnt" />
                            <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:TemplateField Visible="false" HeaderText="SR.NO.">
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblNarration" Text='<%# DataBinder.Eval(Container.DataItem,"Narration") %>'
                                    runat="server">
                                </asp:Label>
                                <asp:Label CssClass="blackfnt" ID="lbldocno" Text='<%# DataBinder.Eval(Container.DataItem,"docno") %>'
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="blackfnt" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td align="left" valign="top"><br />
                
                            <asp:Button ID="Button2" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                       
            </td>
        </tr>
    </table>
</asp:Content>
