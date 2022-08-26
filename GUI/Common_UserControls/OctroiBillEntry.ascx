<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OctroiBillEntry.ascx.cs"
    Inherits="GUI_Common_UserControls_OctroiBillEntry" %>

<script type="text/javascript" language="JavaScript" src="../images/CalendarPopup.js"></script>

<script language="javascript" type="text/javascript" src="../images/DateControl.js"></script>

<script type="text/javascript" language="javascript" src="../images/commonJs.js"></script>

<script language="javascript" type="text/javascript" src="../Finance/Billing_Ver1/Billing.js"></script>

<asp:UpdatePanel ID="UpGrid" runat="server" UpdateMode="Always" RenderMode="Inline">
    <ContentTemplate>
        <table border="0">
            <tr>
                <td>
                    <table border="0" cellpadding="3" cellspacing="1" class="boxbg" align="left" width="800">
                        <tr class="bgbluegrey" >
                            <td nowrap colspan="2">
                                <font class="bluefnt"><b>Enter Row No *</b></font> &nbsp;&nbsp;&nbsp; 
                                <asp:TextBox ID="txtRow" runat="server" Width="40px" BorderStyle="Groove" AutoPostBack="True"
                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'));" CssClass="blackfnt" MaxLength="3">5</asp:TextBox>
                            &nbsp;&nbsp;&nbsp; 
                                <asp:Button ID="btnAdd" CssClass="blackfnt" runat="server" Text="Add Row" CausesValidation="false" OnClick="btnAdd_Click">
                                </asp:Button>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="left" colspan="2">
                                <br />
                                <asp:GridView ID="gvBillEntry" runat="server" align="center" HeaderStyle-CssClass="bgbluegrey"
                                    Width="100%" PagerStyle-HorizontalAlign="left" ShowFooter="True" CssClass="boxbg"
                                    CellSpacing="1" CellPadding="3" BorderWidth="0" FooterStyle-CssClass="boxbg"
                                    AutoGenerateColumns="False" OnRowDataBound="gvBillEntry_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField HeaderText="SR.NO.">
                                            <HeaderStyle HorizontalAlign="Left" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle BackColor="White" CssClass="blackfnt" />
                                            <ItemTemplate>
                                                <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Docket Number  ">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="True" Width="100px" CssClass="blackfnt" />
                                            <ItemStyle BackColor="White" CssClass="blackfnt" Width="150px" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtdockno" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "DOCKNO")%>'
                                                    OnTextChanged="txtdockno_TextChanged" BorderStyle="Groove" onblur="javascript:return getDockData(this.getAttribute('id'))"
                                                    CssClass="blackfnt"></asp:TextBox>
                                                <asp:HiddenField ID="hidStatus" runat="server" />
                                                <asp:HiddenField ID="hidDockDate" runat="server" />
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="lblttt" CssClass="blackfnt" runat="server">Total : </asp:Label>
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Octroi Amount  ">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center"/>
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtoctamt" Width="120" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "OCTAMT")%>'
                                                    BorderStyle="Groove" CssClass="blackfnt" Columns="8" onblur="javascript:return Add_Value()" style="text-align:right" MaxLength="9"></asp:TextBox>
                                                <asp:HiddenField ID="hidoctamt" runat="server" />
                                            </ItemTemplate>
                                            <FooterTemplate>                                            
                                                <asp:TextBox ID="txttot" Width="120" runat="server" BorderStyle="Groove" CssClass="blackfnt"
                                                     Columns="8" style="text-align:right" Enabled ="true"></asp:TextBox>
                                                <asp:HiddenField ID="hidtot" runat="server" />
                                            </FooterTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Octroi receipt no.">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtrcpno" Width="120" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "RECPTNO")%>'
                                                    BorderStyle="Groove" CssClass="blackfnt" Columns="8" style="text-align:right"   onblur="javascript:return Add_Value()" MaxLength="15"></asp:TextBox>
                                                <asp:HiddenField ID="hidrcpno" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Receipt date">
                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                            <ItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtrcpdt" Width="65px" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "RECPTDT")%>'
                                                                BorderStyle="Groove" CssClass="blackfnt" style="text-align:right"  onchange="javascript:return validGridDate(this.getAttribute('id'));"></asp:TextBox>
                                                            <asp:HiddenField ID="hidrcpdt" runat="server" />
                                                        </td>
                                                        <td>
                                                            <asp:LinkButton ID="lnkBtnIssueDate" runat="server">
                                                            <img src="../../images/calendar.jpg" border="0" alt="" /></a></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle CssClass="bgbluegrey" HorizontalAlign="Center"/>
                                    <HeaderStyle CssClass="bgbluegrey" />
                                    <PagerStyle HorizontalAlign="Left" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="left">
                                <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Text="Remark"></asp:Label>&nbsp;
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtremarks" runat="server" Height="49px" TextMode="MultiLine" Width="381px" MaxLength="200"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </ContentTemplate>
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="txtRow" EventName="TextChanged" />
    </Triggers>
</asp:UpdatePanel>
