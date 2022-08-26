<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TripFinanceMst.aspx.cs" Inherits="GUI_Fleet_TripRuleMaster_TripFinanceMst" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
    <link id="Link3" href="~/GUI/images/TabStyleSheet.css" rel="Stylesheet" type="text/css"
        runat="server" />

    <script type="text/javascript" language="javascript" src="../../Js/querystring.js"></script>

    <script type="text/javascript" language="javascript" src="TripExpenseMst/AJAX_Validator/TripExpense.js"></script>

    <script type="text/javascript" language="javascript">
        function SubmitData() {
            var tb_AccCode1 = document.getElementById("tabExpenseMaster$TabPanel2$tb_AccCode1");
            var tb_AccCode2 = document.getElementById("tabExpenseMaster$TabPanel2$tb_AccCode2");

            if (tb_AccCode1.value == "") {
                alert("Please Enter No. of Trip Sheet");
                tb_AccCode1.value = "";
                tb_AccCode1.focus();
                return false;
            }
            if (tb_AccCode2.value == "") {
                alert("Please Enter No. of Trip Sheet");
                tb_AccCode2.value = "";
                tb_AccCode2.focus();
                return false;
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
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
        <br />
        <br />
        <br />
        <asp:UpdatePanel runat="server" ID="UpPanel">
            <ContentTemplate>
                <ajaxToolkit:TabContainer runat="server" ID="tabExpHdr" Height="400px" ActiveTabIndex="0"
                    CssClass="ajax__tab_technorati-theme" Width="100%">
                    <ajaxToolkit:TabPanel runat="server" ID="Panel1" HeaderText="Trip Expense Header">
                        <ContentTemplate>
                            <asp:GridView ID="gvExpFinance" runat="server" BorderWidth="1px" CellSpacing="1"
                                CellPadding="5" HeaderStyle-CssClass="dgHeaderStyle" AllowPaging="True" PageSize="50"
                                PagerStyle-HorizontalAlign="left" PagerSettings-Mode="Numeric" AutoGenerateColumns="False"
                                CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8BA0E5"
                                Width="300px">
                                <Columns>
                                    <asp:BoundField DataField="Trip_Exp_Header" HeaderText="Tripsheet Expense">
                                        <ItemStyle HorizontalAlign="Left" Width="100px" />
                                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="Polarity">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtPolarity" runat="server" Text='<%# Bind("Polarity") %>'></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle Width="10%" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Account Code">
                                        <ItemStyle Width="100px" HorizontalAlign="Left" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="tb_AccCode" runat="server" BorderStyle="Groove" CssClass="input"
                                                Enabled="true" Width="100px"></asp:TextBox>
                                            <asp:Button ID="btnAccCode" runat="server" Text="..." />
                                            <asp:TextBox ID="tb_Description" runat="server" BorderStyle="None" Width="200px"
                                                ReadOnly="true"></asp:TextBox>
                                            <asp:Label ID="lbl_Err_AccCode" runat="server" Text="" Style="font-size: 8pt; color: red;
                                                font-family: Verdana"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </ajaxToolkit:TabPanel>
                </ajaxToolkit:TabContainer>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    </form>
</body>
</html>
