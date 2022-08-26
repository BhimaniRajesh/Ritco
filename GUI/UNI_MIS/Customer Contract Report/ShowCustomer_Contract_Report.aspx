<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ShowCustomer_Contract_Report.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 11.5in;" align="left" border="0">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Operation.aspx"><font class="blklnkund">
                        <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Customer Contract
                            Report </b></font>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <div style="width: 10in">
        <table width="100%" border="0">
            <tr>
                <td>
                    <br />
                    <p align="center">
                        <label class="blackfnt">
                            <b>You Selected
                                <asp:Label ID="Label1" runat="server" Text="Label" Visible="false"></asp:Label></b></label></p>
                    <table border="0" width="400" cellspacing="1" cellpadding="5" class="boxbg" align="center"
                        class="boxbg">
                        <tr style="background-color: #ffffff">
                            <td style="height: 10px">
                                <label class="blackfnt">
                                    Date :
                                </label>
                            </td>
                            <td style="height: 10px">
                                <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td style="width: 205; height: 6px;">
                                <label class="blackfnt">
                                    Ro :</label></td>
                            <td style="width: 343; height: 6px;">
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
                    </table>
                    <br />
                    <br />
                    <br />
                </td>
            </tr>
            <tr>
                <%--<asp:UpdatePanel ID="UP1" runat="Server">
                                                                    <ContentTemplate>--%>
                <asp:GridView ID="GV_Summ" runat="server" align="center" BorderWidth="0" CellPadding="5"
                    CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" HeaderStyle-Height="0.3in"
                    PagerStyle-HorizontalAlign="left" CssClass="boxbg" AllowPaging="true" PageSize="25"
                    FooterStyle-BackColor="white" FooterStyle-CssClass="boxbg" OnPageIndexChanging="pgChange"
                    AllowSorting="False" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                    PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                    <PagerStyle VerticalAlign="Bottom" BackColor="white" CssClass="blackfnt" />
                    <Columns>
                        <asp:TemplateField HeaderText="SR.NO.">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" BackColor="white" />
                            <ItemTemplate>
                                <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="contractid" ItemStyle-Wrap="true" HeaderText="ContractId">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="450" Wrap="False" BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                  
                         <asp:BoundField DataField="custcode_name" ItemStyle-Wrap="true" HeaderText="Cust. Name">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Wrap="False" HorizontalAlign="Center" BackColor="white" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="contract_sign_loccode" ItemStyle-Wrap="true" HeaderText="Contract Sign Location">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Wrap="False" HorizontalAlign="Center" BackColor="white" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="contract_type" ItemStyle-Wrap="true" HeaderText="Contract Type">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" BackColor="white" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="contract_stdate" ItemStyle-Wrap="true" HeaderText="Contract Start Dt">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Wrap="False" HorizontalAlign="Center" BackColor="white" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="contract_eddate" ItemStyle-Wrap="true" HeaderText="Contract End Dt">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Wrap="False" HorizontalAlign="Center" BackColor="white" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="contract_effectdate" ItemStyle-Wrap="true" HeaderText="Contract Effect Dt">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Wrap="False" HorizontalAlign="Center" BackColor="white" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="entrydt" ItemStyle-Wrap="true" HeaderText="Contract Entry Dt">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Wrap="False" HorizontalAlign="Center" BackColor="white" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="single_slab_yn" ItemStyle-Wrap="true" HeaderText="Sundry Matrix Type">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Wrap="False" HorizontalAlign="Center" BackColor="white" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField ItemStyle-Wrap="true" DataField="transport_mode" HeaderText="Transport Mode">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Wrap="False" HorizontalAlign="Center" BackColor="white" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField ItemStyle-Wrap="true" DataField="sundry_yn" HeaderText="Load Type">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Wrap="False" HorizontalAlign="Center" BackColor="white" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField ItemStyle-Wrap="true" DataField="cod_dod_yn" HeaderText="Mode of Service">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Wrap="False" HorizontalAlign="Center" BackColor="white" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField ItemStyle-Wrap="true" DataField="ACTIVE" HeaderText="Active">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Wrap="False" HorizontalAlign="Center" BackColor="white" CssClass="blackfnt" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
                <%-- </ContentTemplate>
                                                                </asp:UpdatePanel>--%>
            </tr>
            <tr>
                <asp:Label ID="lblnull" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Medium"
                    ForeColor="Red" Text="Label" Visible="False"></asp:Label></tr>
            <tr align="center">
            </tr>
        </table>
        <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="Server">
                                                                    <ContentTemplate>--%>
        <table border="0" cellpadding="0" width="565" style="background-color: #808080;"
            cellspacing="0" align="center" class="boxbg">
            <tr align="center">
                <td style="background-color: #ffffff">
                    <asp:LinkButton ID="LinkButton1" OnClick="fst" runat="server" Text="First">
                    </asp:LinkButton>
                </td>
                <td style="background-color: #ffffff">
                    <asp:LinkButton ID="LinkButton2" OnClick="lst" runat="server" Text="Last">
                    </asp:LinkButton>
                </td>
            </tr>
            <tr align="center">
                <td colspan="2" style="background-color: #ffffff" align="center">
                    <br />
                    <br />
                    <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
