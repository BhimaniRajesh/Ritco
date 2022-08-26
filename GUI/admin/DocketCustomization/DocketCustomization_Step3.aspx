<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="DocketCustomization_Step3.aspx.cs" Inherits="GUI_admin_DocketCustomization_DocketCustomization_Step2"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <br />
    <br />

    <script type="text/javascript" src="../../images/commonJs.js" language="javascript"></script>

    <asp:UpdatePanel runat="server" ID="updone">
        <ContentTemplate>
            <asp:Panel runat="server" Width="9in">
                <asp:Table runat="server" Width="100%">
                    <asp:TableRow>
                        <asp:TableCell Font-Bold="true">
                            <asp:Table ID="Table4" runat="server" CellSpacing="1" Width="100%" BorderWidth="0"
                                CssClass="boxbg">
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell Font-Bold="true">Docket Entry Cutomization Form - 3
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow BackColor="White">
                        <asp:TableCell>
                        &nbsp;
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow BackColor="white">
                        <asp:TableCell>
                            <asp:Table ID="Table14" runat="server" CellSpacing="1" Width="100%" CssClass="boxbg">
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell Font-Bold="true">
                               Payment Basis
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow BackColor="white">
                                    <asp:TableCell>
                                        <asp:DropDownList ID="ddlpaybas" AutoPostBack="true" OnSelectedIndexChanged="ddlpaybas_SelectedIndexChanged"
                                            runat="server" CssClass="blackfnt">
                                            <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Paid" Value="P01"></asp:ListItem>
                                            <asp:ListItem Text="TBB" Value="P02"></asp:ListItem>
                                            <asp:ListItem Text="ToPay" Value="P03"></asp:ListItem>
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                            <br />
                            <br />
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow BackColor="white">
                        <asp:TableCell>
                            <asp:Table ID="Table1" runat="server" CellSpacing="1" Width="100%" CssClass="boxbg">
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell Font-Bold="true">
                                        Service Tax Paid By
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow BackColor="white">
                                    <asp:TableCell>
                                        <asp:Table runat="server" CellSpacing="1" Width="70%" CssClass="boxbg">
                                            <asp:TableRow CssClass="bgbluegrey">
                                                <asp:TableCell Width="100px"></asp:TableCell>
                                                <asp:TableCell>Consignor</asp:TableCell>
                                                <asp:TableCell>Consingee</asp:TableCell>
                                                <asp:TableCell>Billing Party</asp:TableCell>
                                                <asp:TableCell>Trasporter</asp:TableCell>
                                                <asp:TableCell>Default</asp:TableCell>
                                                <asp:TableCell>Enabled</asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow CssClass="bgwhite">
                                                <asp:TableCell CssClass="bgbluegrey">
                                                    <asp:Label ID="lblairname" CssClass="blackfnt" runat="server">Air</asp:Label>
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:CheckBox ID="chkairco" runat="server" CssClass="blackfnt" />
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:CheckBox ID="chkairce" runat="server" CssClass="blackfnt" /></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:CheckBox ID="chkairp" runat="server" CssClass="blackfnt" /></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:CheckBox ID="chkairt" runat="server" CssClass="blackfnt" /></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:DropDownList ID="ddlair" runat="server" CssClass="blackfnt">
                                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                                        <asp:ListItem Text="Consignor" Value="CO"></asp:ListItem>
                                                        <asp:ListItem Text="Consignee" Value="CE"></asp:ListItem>
                                                        <asp:ListItem Text="Billing Party" Value="P"></asp:ListItem>
                                                        <asp:ListItem Text="Transporter" Value="T"></asp:ListItem>
                                                    </asp:DropDownList></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:CheckBox ID="chkairenabled" runat="server" CssClass="blackfnt" />
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow CssClass="bgwhite">
                                                <asp:TableCell CssClass="bgbluegrey">
                                                    <asp:Label ID="lblroadname" CssClass="blackfnt" runat="server">Road</asp:Label></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:CheckBox ID="chkroadco" runat="server" CssClass="blackfnt" />
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:CheckBox ID="chkroadce" runat="server" CssClass="blackfnt" /></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:CheckBox ID="chkroadp" runat="server" CssClass="blackfnt" /></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:CheckBox ID="chkroadt" runat="server" CssClass="blackfnt" /></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:DropDownList ID="ddlroad" runat="server" CssClass="blackfnt">
                                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                                        <asp:ListItem Text="Consignor" Value="CO"></asp:ListItem>
                                                        <asp:ListItem Text="Consignee" Value="CE"></asp:ListItem>
                                                        <asp:ListItem Text="Billing Party" Value="P"></asp:ListItem>
                                                        <asp:ListItem Text="Transporter" Value="T"></asp:ListItem>
                                                    </asp:DropDownList></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:CheckBox ID="chkroadenabled" runat="server" CssClass="blackfnt" />
                                                </asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow CssClass="bgwhite">
                                                <asp:TableCell CssClass="bgbluegrey">
                                                    <asp:Label ID="lbltrainname" CssClass="blackfnt" runat="server">Train</asp:Label></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:CheckBox ID="chktrainco" runat="server" CssClass="blackfnt" />
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:CheckBox ID="chktraince" runat="server" CssClass="blackfnt" /></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:CheckBox ID="chktrainp" runat="server" CssClass="blackfnt" /></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:CheckBox ID="chktraint" runat="server" CssClass="blackfnt" /></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:DropDownList ID="ddltrain" runat="server" CssClass="blackfnt">
                                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                                        <asp:ListItem Text="Consignor" Value="CO"></asp:ListItem>
                                                        <asp:ListItem Text="Consignee" Value="CE"></asp:ListItem>
                                                        <asp:ListItem Text="Billing Party" Value="P"></asp:ListItem>
                                                        <asp:ListItem Text="Transporter" Value="T"></asp:ListItem>
                                                    </asp:DropDownList></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:CheckBox ID="chktrainenabled" runat="server" CssClass="blackfnt" /></asp:TableCell>
                                            </asp:TableRow>
                                            <asp:TableRow CssClass="bgwhite">
                                                <asp:TableCell CssClass="bgbluegrey">
                                                    <asp:Label ID="lblexpressname" CssClass="blackfnt" runat="server">Express</asp:Label></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:CheckBox ID="chkexpressco" runat="server" CssClass="blackfnt" />
                                                </asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:CheckBox ID="chkexpressce" runat="server" CssClass="blackfnt" /></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:CheckBox ID="chkexpressp" runat="server" CssClass="blackfnt" /></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:CheckBox ID="chkexpresst" runat="server" CssClass="blackfnt" /></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:DropDownList ID="ddlexpress" runat="server" CssClass="blackfnt">
                                                        <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                                        <asp:ListItem Text="Consignor" Value="CO"></asp:ListItem>
                                                        <asp:ListItem Text="Consignee" Value="CE"></asp:ListItem>
                                                        <asp:ListItem Text="Billing Party" Value="P"></asp:ListItem>
                                                        <asp:ListItem Text="Transporter" Value="T"></asp:ListItem>
                                                    </asp:DropDownList></asp:TableCell>
                                                <asp:TableCell>
                                                    <asp:CheckBox ID="chkexpressenabled" runat="server" CssClass="blackfnt" />
                                                </asp:TableCell>
                                            </asp:TableRow>
                                        </asp:Table>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <br />
                            <asp:Table ID="Table2" runat="server" CellSpacing="1" Width="100%" CssClass="boxbg">
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell Font-Bold="true" ColumnSpan="8">
                                        Manual Entry Settings
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell>Field Name</asp:TableCell>
                                    <asp:TableCell>Disabled</asp:TableCell>
                                    <asp:TableCell>Enabled(When not Found)</asp:TableCell>
                                    <asp:TableCell>Enabled</asp:TableCell>
                                    <asp:TableCell>Field Name</asp:TableCell>
                                    <asp:TableCell>Disabled</asp:TableCell>
                                    <asp:TableCell>Enabled(When not Found)</asp:TableCell>
                                    <asp:TableCell>Enabled</asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell>
                                            Freight Charge
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:RadioButton ID="optfchrgd" runat="server" GroupName="fchrg" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                                            <asp:RadioButton ID="optfchrgne" runat="server" GroupName="fchrg" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:RadioButton ID="optfchrge" runat="server" GroupName="fchrg" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                                            Freight Rate
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:RadioButton ID="optfrated" runat="server" GroupName="frate" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                                            <asp:RadioButton ID="optfratene" runat="server" GroupName="frate" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:RadioButton ID="optfratee" runat="server" GroupName="frate" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell>
                                            Freight Rate Type
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:RadioButton ID="optftyped" runat="server" GroupName="ftype" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                                            <asp:RadioButton ID="optftypene" runat="server" GroupName="ftype" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:RadioButton ID="optftypee" runat="server" GroupName="ftype" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                                            EDD
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:RadioButton ID="opteddd" runat="server" GroupName="edd" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                                            <asp:RadioButton ID="opteddne" runat="server" GroupName="edd" />
                                    </asp:TableCell>
                                    <asp:TableCell>
                                        <asp:RadioButton ID="optedde" runat="server" GroupName="edd" />
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell>Charge Basis</asp:TableCell>
                                    <asp:TableCell ColumnSpan="8">
                                        <asp:DropDownList runat="server" ID="ddlbasedon" AutoPostBack="true" OnSelectedIndexChanged="ddlbasedon_SelectedIndexChanged" DataTextField="codedesc" DataValueField="codeid"
                                            CssClass="blackfnt">
                                        </asp:DropDownList>
                                    </asp:TableCell>
                                </asp:TableRow>
                                <asp:TableRow CssClass="bgwhite">
                                    <asp:TableCell ColumnSpan="8">
                                        <asp:GridView HorizontalAlign="left" ID="grvcharges" runat="server" BorderWidth="0"
                                            CellSpacing="1" CssClass="boxbg" RowStyle-CssClass="bgwhite" HeaderStyle-CssClass="bgbluegrey" AutoGenerateColumns="false"
                                            EmptyDataText="No Records Found..." OnRowDataBound="grvcharges_RowDataBound"
                                            Style="width: 70%;">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Charge Name"  HeaderStyle-HorizontalAlign="Center">
                                                    <ItemTemplate>
                                                        <asp:Label CssClass="blackfnt" ID="txtchargename1" Text='<%# DataBinder.Eval(Container.DataItem,"chargename1") %>'
                                                            runat="server"></asp:Label>
                                                        <asp:HiddenField ID="hdnchargecode1" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"chargecode1") %>' />
                                                        <asp:HiddenField ID="hdnenabled1" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"enabled1") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Enabled">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkenabled1" runat="server" CssClass="blackfnt" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Charge Name">
                                                    <ItemTemplate>
                                                        <asp:Label CssClass="blackfnt" ID="txtchargename2" Text='<%# DataBinder.Eval(Container.DataItem,"chargename2") %>'
                                                            runat="server"></asp:Label>
                                                        <asp:HiddenField ID="hdnchargecode2" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"chargecode2") %>' />
                                                        <asp:HiddenField ID="hdnenabled2" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"enabled2") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Enabled">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkenabled2" runat="server" CssClass="blackfnt" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <br />
                            <br />
                            <asp:Table ID="Table5" runat="server" CellSpacing="1" Width="100%" CssClass="boxbg">
                                <asp:TableRow CssClass="bgbluegrey">
                                    <asp:TableCell Font-Bold="true" HorizontalAlign="Center">
                                        <asp:Button ID="btnsubmit" runat="server" OnClick="btnsubmit_Click" Text="Submit"
                                            CssClass="blackfnt" />
                                    </asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                <br />
                <asp:HiddenField ID="hdnchargerule" runat="server" />
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../images/loading.gif" alt="" />
                    </td>
                    <td>
                        <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                opacity: .50; -moz-opacity: .50;" runat="server">
                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                    left: 50%;" ID="Panel2" runat="server">
                </asp:Panel>
            </asp:Panel>
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Content>
