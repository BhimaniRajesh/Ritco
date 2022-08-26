<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OctroiBillDetails.ascx.cs"
    Inherits="GUI_Common_UserControls_OctroiBillDetails" %>

<script type="text/javascript" language="JavaScript" src="../images/CalendarPopup.js"></script>

<script language="javascript" type="text/javascript" src="../images/DateControl.js"></script>

<script type="text/javascript" language="javascript" src="../images/commonJs.js"></script>

<script language="javascript" type="text/javascript" src="../Finance/Billing_Ver1/Billing.js"></script>

<asp:UpdatePanel ID="DataGrid2_Update" runat="server" UpdateMode="Always" RenderMode="Inline">
    <ContentTemplate>
        <table border="0">
            <tr>
                <td>
                    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" align="left">
                    <tr bgcolor="white">
                    <td colspan="2">
                    <font class="blackfnt"><b>* For Walk-In Customer please select Party</b></font>
                    </td>
                    </tr>
                        <tr class="bgbluegrey">
                            <td nowrap colspan="2">
                                <font class="blackfnt">Enter Row No *</font> &nbsp;&nbsp;&nbsp;
                                <asp:TextBox ID="roww" runat="server" Text="5" Width="40px" BorderStyle="Groove"
                                    CssClass="blackfnt" MaxLength="3"></asp:TextBox>&nbsp;&nbsp;&nbsp;
                                <asp:Button ID="btnAdd" runat="server" CssClass="blackfnt" Text="Add Row" CausesValidation="false"
                                    OnClick="btnAdd_Click"></asp:Button>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="left" colspan="2">
                                <br />
                                <asp:DataGrid ID="DataGrid1" runat="server" AutoGenerateColumns="False" CellPadding="1"
                                    Width="900px" CssClass="boxbg" BorderWidth="0" CellSpacing="1" OnItemDataBound="DataGrid1_ItemDataBound">
                                    <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                                    <HeaderStyle CssClass="bgbluegrey" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="Sr. No.">
                                            <ItemTemplate>
                                                <center>
                                                    <font class="blackfnt">
                                                        <%# Container.ItemIndex+1 %>
                                                    </font>
                                                </center>
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Select Party">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rdbParty" runat="server"/> 
                                            </ItemTemplate>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn>
                                            <HeaderTemplate>
                                                <center>
                                                    <asp:Label ID="l1" runat="server" Text='<%#Session["DocketCalledAs"]+" No."%>'></asp:Label>
                                                </center>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtdockno" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "DOCKNO")%>'
                                                    BorderStyle="Groove" CssClass="blackfnt" Width="80px" Style="text-align: right"
                                                    OnTextChanged="txtdockno_TextChanged" onblur="javascript:return getDockData(this.getAttribute('id'))"></asp:TextBox>
                                                <asp:HiddenField ID="hidStatus" runat="server" />
                                                <asp:HiddenField ID="hidDockDate" runat="server" />
                                                <asp:HiddenField ID="hidPartyName" runat="server" />
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="blackfnt" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Decl. Value">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtdeclval" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "DECLVAL")%>'
                                                    BorderStyle="Groove" CssClass="blackfnt" Width="60px" Style="text-align: right"
                                                    Enabled="false" Wrap="true"></asp:TextBox>
                                                <asp:HiddenField ID="hiddeclval" runat="server" />
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Octroi Amt.">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtoctamt" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "OCT_AMT")%>'
                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'));" onblur="javascript:return calc()"
                                                    BorderStyle="Groove" CssClass="blackfnt" Width="60px" Style="text-align: right"></asp:TextBox>
                                                <asp:HiddenField ID="hidoctamt" runat="server" />
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Octroi(%)">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtoctper" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "oct_percentage")%>'
                                                    BorderStyle="Groove" CssClass="blackfnt" Width="60px" Style="text-align: right"
                                                    Enabled="false" Wrap="true"></asp:TextBox>
                                                <asp:HiddenField ID="hidoctper" runat="server" />
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Clearance Charges">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtclearchrg" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "clearance_chrg")%>'
                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'));" onblur="javascript:return calc()"
                                                    BorderStyle="Groove" CssClass="blackfnt" Width="60px" Style="text-align: right"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Processing Charges(%)">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtprochrg_per" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "processing_per")%>'
                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'));" onblur="javascript:return calc()"
                                                    BorderStyle="Groove" CssClass="blackfnt" Width="60px" Style="text-align: right"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="true" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Processing Charges">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtprochrg" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "process_chrg")%>'
                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'));" BorderStyle="Groove"
                                                    CssClass="blackfnt" Width="50px" Style="text-align: right"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="true" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Other Charges">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtotchg" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "OTCHG")%>'
                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'));" onblur="javascript:return calc()"
                                                    BorderStyle="Groove" CssClass="blackfnt" Width="50px" Style="text-align: right"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="true" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="S.Tax">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtstax" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "SVRCAMT")%>'
                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'));" onblur="javascript:return calc()"
                                                    BorderStyle="Groove" CssClass="blackfnt" Width="60px" Style="text-align: right"
                                                    Enabled="false"></asp:TextBox>
                                                <asp:HiddenField ID="hidstax" runat="server" />
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Cess">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtcess" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "CESSAMT")%>'
                                                    onblur="javascript:return calc()" BorderStyle="Groove" CssClass="blackfnt" Width="60px"
                                                    Style="text-align: right" Enabled="false"></asp:TextBox>
                                                <asp:HiddenField ID="hidcess" runat="server" />
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Higher Edu. Cess">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txthcess" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Hedu_Cess")%>'
                                                    onkeypress="javascript:return validFloat(event,this.getAttribute('id'));" onblur="javascript:return calc()"
                                                    BorderStyle="Groove" CssClass="blackfnt" Width="60px" Style="text-align: right"
                                                    Enabled="false"></asp:TextBox>
                                                <asp:HiddenField ID="hidhcess" runat="server" />
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Total">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txttotalamt" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "DKTTOT")%>'
                                                    onkeypress="javascript:return nonnon(event,this.getAttribute('id'));" onblur="javascript:return calc()"
                                                    BorderStyle="Groove" CssClass="blackfnt" Width="60px" Style="text-align: right"
                                                    Enabled="false"></asp:TextBox>
                                                <asp:HiddenField ID="hidtotalamt" runat="server" />
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Reciept No.">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtrcptno" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "OCT_RECEIPTNO")%>'
                                                    BorderStyle="Groove" CssClass="blackfnt" Width="70px" MaxLength="15"></asp:TextBox>
                                                <asp:HiddenField ID="hidrcptno" runat="server" />
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="Receipt Date ">
                                            <ItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtrcptdate" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "recptdt")%>'
                                                                BorderStyle="Groove" CssClass="blackfnt" onchange="javascript:return validGridDate(this.getAttribute('id'));"
                                                                Width="65px" MaxLength="10"></asp:TextBox>
                                                            <asp:HiddenField ID="hidrcptdate" runat="server" />
                                                        </td>
                                                        <td>
                                                            <asp:LinkButton ID="lnkBtnIssueDate" runat="server">
                                                            <img src="../../images/calendar.jpg" border="0" alt="" /></a></asp:LinkButton>                                                           
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        </asp:TemplateColumn>
                                    </Columns>
                                </asp:DataGrid>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="left">
                                <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Text="Remark"></asp:Label>&nbsp;
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtRemark" runat="server" Height="49px" TextMode="MultiLine" Width="381px" MaxLength="200"></asp:TextBox>
                                <asp:HiddenField ID="hidStaxRule" runat="server" />
                                <asp:HiddenField ID="hidRate" runat="server" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </ContentTemplate>
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
    </Triggers>
</asp:UpdatePanel>
