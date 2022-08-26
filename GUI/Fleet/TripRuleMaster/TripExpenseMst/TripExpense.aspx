<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TripExpense.aspx.cs" Inherits="GUI_Admin_TripExpense"
    Title="Average Diesel Rate" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
    <link id="Link3" href="~/GUI/images/TabStyleSheet.css" rel="Stylesheet" type="text/css"
        runat="server" />

    <script type="text/javascript" language="javascript" src="../../../Js/querystring.js"></script>

    <script type="text/javascript" language="javascript" src="AJAX_Validator/TripExpense.js"></script>

    <script type="text/javascript" language="javascript">
function SubmitData()
{
    var tb_AccCode1 = document.getElementById("tabExpenseMaster$TabPanel2$tb_AccCode1");
    var tb_AccCode2 = document.getElementById("tabExpenseMaster$TabPanel2$tb_AccCode2");

    if(tb_AccCode1.value == "")
    { 
        alert("Please Enter No. of Trip Sheet");
        tb_AccCode1.value="";
        tb_AccCode1.focus();
        return false;
    }
    if(tb_AccCode2.value == "")
    { 
        alert("Please Enter No. of Trip Sheet");
        tb_AccCode2.value="";
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
                            <img src="../../../images/loading.gif" alt="" />
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
        <asp:UpdatePanel runat="server" ID="UpPanel">
            <ContentTemplate>
                <ajaxToolkit:TabContainer runat="server" ID="tabExpenseMaster" Height="400px" ActiveTabIndex="0"
                    CssClass="ajax__tab_technorati-theme" Width="100%">
                    <ajaxToolkit:TabPanel runat="server" ID="Panel1" HeaderText="Trip Expense Master">
                        <ContentTemplate>
                            <asp:UpdatePanel ID="u1" runat="server" UpdateMode="Always" RenderMode="Inline">
                                <ContentTemplate>
                                    <table id="tb_add" border="0" class="boxbg" cellpadding="1" cellspacing="1" border="1"
                                        width="800px">
                                        
                                        <tr id="Tr1" runat="server" class="bgbluegrey" >
                                            <td align="left" style="font-size: 8pt; width: 15%;
                                                color: white; font-family: Verdana; height: 17px;">
                                                <asp:LinkButton ID="lnk_btn_Add" runat="server" CausesValidation="False" ForeColor="black"
                                                    OnClick="lnk_btn_Add_Click" Text="Add New" Visible="true"></asp:LinkButton>
                                            </td>
                                            <td align="left"  style="font-size: 8pt; width: 20%;
                                                color: black; font-family: Verdana; height: 17px;">
                                                Trip Expense
                                            </td>
                                            <td  style="font-size: 8pt; width: 10%; color: black;
                                                font-family: Verdana; height: 17px;">
                                                Polarity
                                            </td>
                                            <td style="font-size: 8pt; width: 10%; color: black;
                                                font-family: Verdana; height: 17px;">
                                                Active Flag
                                            </td>
                                            <td style="font-size: 8pt; width: 45%; color: black;
                                                font-family: Verdana; height: 17px;">
                                                Account Code
                                            </td>
                                        </tr>
                                        <tr id="RowNo" runat="server" bgcolor="white">
                                            <td align="left" class="blackfnt" style="width: 15%">
                                                <asp:LinkButton ID="btn_Submit" runat="server" OnClientClick="javascript:return CheckValidataion()"
                                                    OnClick="btn_Submit_Click">Save</asp:LinkButton>
                                                ||
                                                <asp:LinkButton ID="btn_Cancel" runat="server" OnClick="btn_Cencel_Click">Cancel</asp:LinkButton>
                                            </td>
                                            <td align="left" class="blackfnt" style="width: 20%">
                                                <asp:TextBox CssClass="input" ID="tb_Trip_Exp" runat="server" onblur="CheckValidExp(this)"
                                                    BorderStyle="Groove" />
                                                <asp:Label ID="lbl_Trip_Exp_Err" runat="server" Text="" Style="font-size: 8pt; color: red;
                                                    font-family: Verdana"></asp:Label>
                                                <asp:HiddenField ID="hfId" runat="server" />
                                            </td>
                                            <td class="blackfnt" style="width: 10%">
                                                <asp:TextBox CssClass="input" ID="tb_Polarity" Width="50px" MaxLength="1" runat="server"
                                                    onblur="PlusMinus(this,event)" BorderStyle="Groove"></asp:TextBox>
                                                <asp:Label ID="lbl_Polarity_Err" runat="server" Text="" Style="font-size: 8pt; color: red;
                                                    font-family: Verdana"></asp:Label>
                                            </td>
                                            <td class="blackfnt" style="width: 10%">
                                                <asp:CheckBox ID="chk_Active_Flag" runat="server" />
                                            </td>
                                            <td class="blackfnt" style="width: 45%">
                                                <asp:TextBox ID="tb_AccCode" runat="server" BorderStyle="Groove" CssClass="input"
                                                    Enabled="true" Width="100px"></asp:TextBox>
                                                <asp:Button ID="btnAccCode" runat="server" Text="..." />
                                                <asp:TextBox ID="tb_Description" runat="server" BorderStyle="None" Width="200px"
                                                    ReadOnly="true"></asp:TextBox>
                                                <asp:Label ID="lbl_Err_AccCode" runat="server" Text="" Style="font-size: 8pt; color: red;
                                                    font-family: Verdana"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always" RenderMode="Inline">
                                <ContentTemplate>
                                    <table id="Table1" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="800">
                                        <tr id="Tr2" runat="server" bgcolor="white">
                                            <td class="blackfnt" colspan="2">
                                                <asp:GridView ID="gv_Trip_Expense" runat="server" OnSelectedIndexChanged="gv_Trip_Expense_SelectedIndexChanged"
                                                    OnPageIndexChanged="gv_Trip_Expense_PageIndexChanged" OnPageIndexChanging="gv_Trip_Expense_PageIndexChanging"
                                                    PageSize="15" ShowHeader="False" OnRowDataBound="gv_Trip_Expense_RowDataBound"
                                                    AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" 
                                                    CssClass="dgRowStyle" AllowPaging="true" HeaderStyle-CssClass="dgHeaderStyle"
                                                    PagerStyle-HorizontalAlign="left" Width="100%">
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <Columns>
                                                        <asp:TemplateField>
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                                                    Text="Edit"></asp:LinkButton>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="15%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Trip Expense">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbl_TripExpHdr" runat="server" Text='<%# Bind("Trip_Exp_Header") %>'></asp:Label>
                                                                <asp:HiddenField ID="hfId" runat="server" Value='<%# Bind("ID") %>' />
                                                            </ItemTemplate>
                                                            <ItemStyle Width="20%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Polarity">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbl_Polarity" runat="server" Text='<%# Bind("Polarity") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Active Flag">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbl_Active_Flag" runat="server" Text='<%# Bind("Active_Flag") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="10%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Account Code">
                                                            <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                                            <ItemTemplate>
                                                                <asp:HiddenField ID="hf_AccCode" Value='<%# Bind("AccCode") %>' runat="server" />
                                                                <asp:Label ID="lbl_Account_Code" runat="server" Text='<%# Bind("AccDesc") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle Width="45%" HorizontalAlign="Left" VerticalAlign="Top" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                    <left>
                                    <font class="blackfnt" style="color:Red;">
                                        <b><asp:Label ID="lbl_Page_Error" runat="server" Font-Size="Small" Text=""></asp:Label></b>
                                    </font>
                                </left>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </ContentTemplate>
                    </ajaxToolkit:TabPanel>
                </ajaxToolkit:TabContainer>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    </form>
</body>
</html>
