<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Query.aspx.cs" Inherits="Octroi_Octroi_Bill_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <br />
    <table align="center" border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 50%">
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 209px">
                <font class="blackfnt">Customer</font>
            </td>
            <td>
                <font class="blackfnt">
                    <asp:Label ID="Label1" runat="server" Text="Label" Width="237px"></asp:Label></font></td>
        </tr>
    </table>
    <br />
    <br />
    <table align="center" border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 80%">
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 111px">
                <font class="blackfnt">Bill Nu<span style="color: #ff0000">mber</span></font>
            </td>
            <td style="width: 195px">
                <font class="blackfnt" color="red"><span style="color: #000000">System Generated...</span></font></td>
            <td style="width: 188px; color: #000000">
                <font class="blackfnt">Bill Date</font></td>
            <td>
                <asp:TextBox ID="txtbgndt" runat="server" Width="94px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtbgndt"
                    ErrorMessage="*"></asp:RequiredFieldValidator></td>
        </tr>
        <tr bgcolor="white" style="color: #000000; height: 25px">
            <td>
                <font class="blackfnt">Party name</font></td>
            <td>
                <font class="blackfnt">
                    <asp:Label ID="LblPTMSCD" runat="server" Text="Label" Width="191px"></asp:Label></font></td>
            <td>
                <font class="blackfnt">Billing Party Address</font></td>
            <td>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td>
                <font class="blackfnt">Generated at location</font></td>
            <td>
                <font class="blackfnt">
                    <%=Session["brcd"].ToString() %>
                </font>
            </td>
            <td>
                <font class="blackfnt">Bill Submission at</font></td>
            <td>
                <asp:TextBox ID="txtbillsubloc" runat="server" Width="91px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtbillsubloc"
                    ErrorMessage="*"></asp:RequiredFieldValidator></td>
        </tr>
        <tr bgcolor="white" style="color: #000000; height: 25px">
            <td>
                <font class="blackfnt">Generated for location</font></td>
            <td>
                <font class="blackfnt">
                    <%=Session["brcd"].ToString() %>
                </font>
            </td>
            <td>
                <font class="blackfnt">Bill Collection at</font></td>
            <td>
                <asp:TextBox ID="txtbillcolloc" runat="server" Width="91px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtbillcolloc"
                    ErrorMessage="*"></asp:RequiredFieldValidator></td>
        </tr>
        <tr bgcolor="white" style="color: #000000; height: 25px">
            <td style="height: 25px">
                <font class="blackfnt">Bill Amount</font></td>
            <td style="height: 25px">
                <asp:TextBox ID="txtbillamt" runat="server" Columns="10" MaxLength="10"></asp:TextBox></td>
            <td style="height: 25px">
                <font class="blackfnt">Due Date</font></td>
            <td style="height: 25px">
                <asp:TextBox ID="txtduedate" runat="server" Width="99px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtduedate"
                    ErrorMessage="*"></asp:RequiredFieldValidator></td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="height: 25px">
            </td>
            <td style="height: 25px">
            </td>
            <td style="height: 25px">
            </td>
            <td style="height: 25px">
            </td>
        </tr>
    </table>
    <br />
    &nbsp;<table align="center" border="0" cellpadding="1" cellspacing="1" class="boxbg">
        <tr bgcolor="white">
            <td align="left" style="width: 91px; height: 40px">
                <font class="bluefnt">Enter Row No *</font></td>
            <td style="height: 40px">
                <asp:TextBox ID="roww" runat="server" BorderStyle="Groove" Width="40px"></asp:TextBox></td>
            <td style="width: 63px; height: 40px">
                <asp:LinkButton ID="btnAdd" runat="server" CausesValidation="false" OnClick="btnAdd_Grid"
                    Text="Add Row">
                        </asp:LinkButton>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <asp:UpdatePanel ID="DataGrid2_Update" runat="server"  UpdateMode="Always" RenderMode="Inline">
        <ContentTemplate>
            <center>
                <asp:DataGrid ID="DataGrid1" runat="server" AllowPaging="false" AutoGenerateColumns="False"
                    BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px"
                    CellPadding="1" CellSpacing="1" CssClass="Styles.css" PageSize="1000" Width="90%" OnItemDataBound="DataGrid1_ItemDataBound">
                    <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                    <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                    <PagerStyle BackColor="#8BA0E5" CssClass="whitefnt" Font-Bold="True" Font-Underline="True"
                        ForeColor="White" HorizontalAlign="Center" Mode="NumericPages" NextPageText="Next"
                        PrevPageText="Previous" Wrap="False" />
                    <ItemStyle BackColor="White" CssClass="blackfnt" ForeColor="#003399" />
                    <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" />
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
                        <asp:TemplateColumn HeaderText="Dock NO">
                            <ItemTemplate>
                                <asp:TextBox ID="txtdockno" runat="server" AutoPostBack="true" BorderStyle="Groove"
                                    OnTextChanged="OnDocketNOChange" Text='<%# DataBinder.Eval(Container.DataItem, "dockno")%>'></asp:TextBox>
                                <asp:AutoCompleteExtender ID="Extender1" runat="server">
                                    <%-- <atlas:AutoCompleteProperties Enabled="true"
                                   TargetControlID="txtdockno"
                                    ServiceMethod="GetOctroi_dockno_AutoComplete"
                                    ServicePath="../Services/AutoComplete.asmx" 
                                         MinimumPrefixLength="1"
                                         
                                    />--%>
                                </asp:AutoCompleteExtender>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Declared Value">
                            <ItemTemplate>
                                <asp:TextBox ID="txtdeclval" runat="server" AutoPostBack="true" BorderStyle="Groove"
                                    Columns="8"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Octroi AMt.">
                            <ItemTemplate>
                                <asp:TextBox ID="txtoctamt" runat="server" AutoPostBack="true" BorderStyle="Groove"
                                    Columns="8" OnTextChanged="Onoctdatacal"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Octroi(%)">
                            <ItemTemplate>
                                <asp:TextBox ID="txtoctper" runat="server" BorderStyle="Groove" Columns="8"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Clearance Charges">
                            <ItemTemplate>
                                <asp:TextBox ID="txtclearchrg" runat="server" AutoPostBack="true" BorderStyle="Groove"
                                    Columns="8" OnTextChanged="Onoctdatacal"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Processing Charges(%)">
                            <ItemTemplate>
                                <asp:TextBox ID="txtprochrg_per" runat="server" AutoPostBack="true" BorderStyle="Groove"
                                    Columns="8" OnTextChanged="Onoctdatacal"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Processing Charges">
                            <ItemTemplate>
                                <asp:TextBox ID="txtprochrg" runat="server" AutoPostBack="true" BorderStyle="Groove"
                                    Columns="8" OnTextChanged="Onoctdatacal"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Other Charges">
                            <ItemTemplate>
                                <asp:TextBox ID="txtotchg" runat="server" AutoPostBack="true" BorderStyle="Groove"
                                    Columns="8" OnTextChanged="Onoctdatacal"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Total">
                            <ItemTemplate>
                                <asp:TextBox ID="txttotalamt" runat="server" BorderStyle="Groove" Columns="8"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Reciept NO">
                            <ItemTemplate>
                                <asp:TextBox ID="txtrcptno" runat="server" BorderStyle="Groove" Columns="10"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Reciept Date ">
                            <ItemTemplate>
                                <asp:TextBox ID="txtrcptdate" runat="server" BorderStyle="Groove" Columns="12"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid>&nbsp;</center>
            <center>
                &nbsp;</center>
            <center>
                <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Text="Remark"></asp:Label>&nbsp;
                &nbsp;<asp:TextBox ID="TextBox1" runat="server" Height="49px" TextMode="MultiLine"
                    Width="381px"></asp:TextBox>
            </center>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
    <br />
    <center>
        <asp:Button ID="Button11" runat="server" OnClick="Button11_Click" Text="Submit" /></center>
</asp:Content>
