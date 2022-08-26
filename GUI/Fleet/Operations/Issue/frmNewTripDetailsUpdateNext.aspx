<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="frmNewTripDetailsUpdateNext.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_frmNewTripDetailsUpdateNext" %>

<%@ Register Src="~/GUI/Fleet/Operations/Issue/AutoComplete2/AMAC.ascx" TagName="AutoComplete"
    TagPrefix="auc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="../../../cal/popcalendar.js"></script>

    <script type="text/javascript" language="javascript" src="../../../images/commonJs.js"></script>

    <script type="text/javascript" language="javascript" src="../../../cal/popcalendar.js"></script>

    <script type="text/javascript" language="javascript" src="AJAX_Validator/NewTripClosureV2.js"></script>

    <script type="text/javascript" language="javascript" src="AJAX_Validator/NewTripGenerate.js"></script>

    <script type="text/javascript" language="javascript" src="AJAX_Validator/NewTripDetailsUpdate.js"></script>

    <script src="../../../JS/dw_lib.js" type="text/javascript"></script>

    <script src="../../../JS/dw_glider.js" type="text/javascript"></script>

    <script src="../../../JS/dw_glide.js" type="text/javascript"></script>

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
    <table cellspacing="1" style="width: 800px">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Trip Sheet >> Update Trip Details Leg Wise </asp:Label>
                <%-- <hr align="center" size="1" color="#8ba0e5">--%>
            </td>
            <td align="right">
                <%--  <asp:UpdateProgress ID="UpdateProgress2" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color="red"><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  --%>
            </td>
        </tr>
    </table>
    <br />
    <table cellspacing="1" cellpadding="3" style="width: 95%" align="left" class="boxbg"
        border="0">
        <tr class="bgbluegrey" runat="server" id="rowVehicleLogHdr">
            <td colspan="4" align="left">
                <font class="blackfnt"><b>External Customer Details </b></font>
                <asp:HiddenField ID="hdnTotalEnrouteStandard" runat="server" />
                <asp:HiddenField ID="hdnTotalEnrouteActual" runat="server" />
                <asp:HiddenField ID="hdnDeviationEnroute" runat="server" />
                <asp:HiddenField ID="hdnDeviationEnroutePerc" runat="server" />
            </td>
        </tr>
        <tr style="background-color: white">
            <td colspan="4" align="center">
                <table border="0" width="100%">
                    <tr>
                        <td style="text-align: left">
                            <asp:DataGrid ID="dgLegDet" runat="server" CellPadding="2" CellSpacing="1" AutoGenerateColumns="False"
                                SelectedIndex="1" ShowFooter="false" Width="700px" BorderColor="#006699" BorderStyle="None"
                                BorderWidth="3px" CssClass="blackfnt" OnItemDataBound="dgLegDet_ItemDataBound">
                                <Columns>
                                    <asp:TemplateColumn HeaderText="Sr.No.">
                                        <ItemTemplate>
                                            <center>
                                                <%# Container.ItemIndex+1 %>.
                                                <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                            </center>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="Leg">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtLeg" runat="server" Style="text-align: left" CssClass="input"
                                                Width="150px" BorderStyle="Groove" onfocus="this.blur()" Text='<%# DataBinder.Eval(Container.DataItem,"Leg") %>'></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="Customer Code And Name">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtCustCodeName" Text='<%# DataBinder.Eval(Container.DataItem,"CustCode") %>'
                                                CssClass="input" runat="server" Style="text-align: left" Width="90px" BorderStyle="Groove"></asp:TextBox>
                                            <asp:TextBox ID="txtCustName" runat="server" CssClass="bgwhite" onfocus="this.blur()"
                                                Text='<%# DataBinder.Eval(Container.DataItem,"CustName") %>' Width="180px" BorderStyle="Groove"></asp:TextBox><br />
                                            <auc:AutoComplete ID="aucCustomer" MinPrefixLength="1" runat="server" webxentity="CUSTOMER"
                                                CodeTarget="txtCustCodeName" NameTarget="txtCustName" />
                                            <%--<asp:HiddenField ID="hdnCustCode" runat="server" />--%>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="Challan Details">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtChallan" Style="text-align: left" runat="server" Width="100px"
                                                Text='<%# DataBinder.Eval(Container.DataItem,"ChallanDetails") %>' BorderStyle="Groove"
                                                CssClass="input"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="Broker Details">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtBrokerDetails" runat="server" CssClass="input" Width="100px"
                                                BorderStyle="Groove" Style="text-align: left" Text='<%# DataBinder.Eval(Container.DataItem,"BrokerDetails") %>'></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="Bill Freight Amount">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtBillFreightAmt" runat="server" CssClass="input" Width="100px"
                                                BorderStyle="Groove" Text='<%# DataBinder.Eval(Container.DataItem,"BillFreight") %>'
                                                onkeypress="javascript:validFloat(event,this.getAttribute('id'))" Style="text-align: right"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="Freight Advance">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtFreightAdvance" runat="server" CssClass="input" Style="text-align: right"
                                                Width="100px" Text='<%# DataBinder.Eval(Container.DataItem,"FreightAdv") %>'
                                                BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="Freight Balance">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtFreightBalance" runat="server" Width="100px" onfocus="this.blur()"
                                                Style="text-align: right" Text='<%# DataBinder.Eval(Container.DataItem,"Freightbal") %>'
                                                BorderStyle="None" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="Remarks">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtRemarks" runat="server" CssClass="input" Width="200px" Text='<%# DataBinder.Eval(Container.DataItem,"Remarks") %>'
                                                BorderStyle="Groove" Style="text-align: left"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                        <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                            Font-Underline="False" Wrap="False" />
                                    </asp:TemplateColumn>
                                </Columns>
                                <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Left" BackColor="White"
                                    ForeColor="#000066" Wrap="False" Mode="NumericPages"></PagerStyle>
                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                <ItemStyle ForeColor="#000066" />
                                <HeaderStyle Font-Bold="False" ForeColor="Black" CssClass="bgbluegrey" Font-Italic="False"
                                    Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                            </asp:DataGrid>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="bgbluegrey" runat="server" id="Tr2">
            <td colspan="4" align="left">
                <font class="blackfnt"><b>Enroute Expense Details </b></font>
                <asp:HiddenField ID="hdnVehno" runat="server" />
                <asp:HiddenField ID="hdnStartKM" runat="server" />
            </td>
        </tr>
        <tr style="background-color: white">
            <td width="5%" nowrap>
                <font class="blackfnt">Enter no. of rows</font>
            </td>
            <td colspan="3" align="left">
                <asp:HiddenField ID="hfRouteDesc" runat="server" />
                <asp:HiddenField ID="hfRouteCode" runat="server" />
                <asp:UpdatePanel ID="u1" runat="server" UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                        <asp:TextBox ID="tb_Row_No" runat="server" Text="0" MaxLength="2" Width="20px" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                            AutoPostBack="true" BorderStyle="Groove" OnTextChanged="tb_Row_No_TextChanged"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_tb_Row_No" runat="server" ControlToValidate="tb_Row_No"
                            ErrorMessage="Required Field!"></asp:RequiredFieldValidator>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr style="background-color: white">
            <td colspan="4" align="center">
                <table border="0" width="100%">
                    <tr>
                        <td style="text-align: left">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always" RenderMode="Inline">
                                <ContentTemplate>
                                    <font class="redfnt">
                                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label></font>
                                    <asp:GridView ID="GridView1" runat="server" CellPadding="2" CellSpacing="1" AutoGenerateColumns="False"
                                        Width="1208px" BorderColor="#006699" BorderStyle="None" BorderWidth="3px" CssClass="blackfnt"
                                        ShowFooter="false" ShowHeader="false">
                                        <Columns>
                                            <asp:TemplateField HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lbl123" CssClass="bgbluegrey" runat="server" Width="200px" Text=""></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="200px" VerticalAlign="Top" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblLegname1" Text='<%# DataBinder.Eval(Container.DataItem,"LEGNAME1") %>'
                                                        runat="server" Width="168px" CssClass="bgbluegrey"></asp:Label>
                                                    <asp:HiddenField ID="hdnLegname1_From" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME1_From_Code") %>' />
                                                    <asp:HiddenField ID="hdnLegname1_To" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME1_To_Code") %>' />
                                                </ItemTemplate>
                                                <ItemStyle Width="168px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterStyle Width="168px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblLegname2" Text='<%# DataBinder.Eval(Container.DataItem,"LEGNAME2") %>'
                                                        runat="server" Width="168px" CssClass="bgbluegrey"></asp:Label>
                                                    <asp:HiddenField ID="hdnLegname2_From" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME2_From_Code") %>' />
                                                    <asp:HiddenField ID="hdnLegname2_To" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME2_To_Code") %>' />
                                                </ItemTemplate>
                                                <ItemStyle Width="168px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterStyle Width="168px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblLegname3" Text='<%# DataBinder.Eval(Container.DataItem,"LEGNAME3") %>'
                                                        runat="server" Width="168px" CssClass="bgbluegrey"></asp:Label>
                                                    <asp:HiddenField ID="hdnLegname3_From" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME3_From_Code") %>' />
                                                    <asp:HiddenField ID="hdnLegname3_To" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME3_To_Code") %>' />
                                                </ItemTemplate>
                                                <ItemStyle Width="168px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterStyle Width="168px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblLegname4" Text='<%# DataBinder.Eval(Container.DataItem,"LEGNAME4") %>'
                                                        runat="server" Width="168px" CssClass="bgbluegrey"></asp:Label>
                                                    <asp:HiddenField ID="hdnLegname4_From" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME4_From_Code") %>' />
                                                    <asp:HiddenField ID="hdnLegname4_To" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME4_To_Code") %>' />
                                                </ItemTemplate>
                                                <ItemStyle Width="168px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterStyle Width="168px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblLegname5" Text='<%# DataBinder.Eval(Container.DataItem,"LEGNAME5") %>'
                                                        runat="server" Width="168px" CssClass="bgbluegrey"></asp:Label>
                                                    <asp:HiddenField ID="hdnLegname5_From" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME5_From_Code") %>' />
                                                    <asp:HiddenField ID="hdnLegname5_To" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME5_To_Code") %>' />
                                                </ItemTemplate>
                                                <ItemStyle Width="168px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterStyle Width="168px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblLegname6" Text='<%# DataBinder.Eval(Container.DataItem,"LEGNAME6") %>'
                                                        runat="server" Width="168px" CssClass="bgbluegrey"></asp:Label>
                                                    <asp:HiddenField ID="hdnLegname6_From" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME6_From_Code") %>' />
                                                    <asp:HiddenField ID="hdnLegname6_To" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME6_To_Code") %>' />
                                                </ItemTemplate>
                                                <ItemStyle Width="168px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterStyle Width="168px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle ForeColor="Black" Font-Bold="False" Font-Italic="False" Font-Size="8pt"
                                            CssClass="bgbluegrey" />
                                    </asp:GridView>
                                    <%--<asp:HiddenField ID="hdnLegname1_From" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME1_From_Code") %>' />
                                    <asp:HiddenField ID="hdnLegname1_To" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME1_To_Code") %>' />
                                    <asp:HiddenField ID="hdnLegname2_From" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME2_From_Code") %>' />
                                    <asp:HiddenField ID="hdnLegname2_To" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME2_To_Code") %>' />
                                    <asp:HiddenField ID="hdnLegname3_From" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME3_From_Code") %>' />
                                    <asp:HiddenField ID="hdnLegname3_To" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME3_To_Code") %>' />
                                    <asp:HiddenField ID="hdnLegname4_From" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME4_From_Code") %>' />
                                    <asp:HiddenField ID="hdnLegname4_To" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME4_To_Code") %>' />
                                    <asp:HiddenField ID="hdnLegname5_From" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME5_From_Code") %>' />
                                    <asp:HiddenField ID="hdnLegname5_To" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME5_To_Code") %>' />
                                    <asp:HiddenField ID="hdnLegname6_From" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME6_From_Code") %>' />
                                    <asp:HiddenField ID="hdnLegname6_To" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"LEGNAME6_To_Code") %>' />--%>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="background-color: white">
            <td colspan="4" align="center">
                <table border="0" width="100%">
                    <tr>
                        <td style="text-align: left">
                            <asp:UpdatePanel ID="u2" runat="server" UpdateMode="Always" RenderMode="Inline">
                                <ContentTemplate>
                                    <font class="redfnt">
                                        <asp:Label ID="lbl_Enroute_Err" runat="server" Text=""></asp:Label></font>
                                    <asp:GridView ID="gvEnroute" runat="server" CellPadding="2" CellSpacing="1" AutoGenerateColumns="False"
                                        OnRowDataBound="gvEnroute_RowDataBound" Width="1100px" BorderColor="#006699"
                                        BorderStyle="None" BorderWidth="3px" CssClass="blackfnt" ShowFooter="True">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Expense">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ddlNExpense" runat="server" Width="200px">
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="200px" VerticalAlign="Top" />
                                                <FooterTemplate>
                                                    <asp:Label ID="lblTotal11" runat="server" Font-Bold="true" ReadOnly="true" Text="Total"></asp:Label>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Standard">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtEAmt" runat="server" Style="text-align: right" CssClass="input"
                                                        Width="75px" onblur="javascript:return calculateBalance()" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        Text='<%# DataBinder.Eval(Container.DataItem,"Standard1") %>' BorderStyle="Groove"
                                                        MaxLength="50"></asp:TextBox>
                                                    <asp:HiddenField ID="hfEAmt" Value='<%# DataBinder.Eval(Container.DataItem,"Standard1") %>'
                                                        runat="server" />
                                                    <asp:HiddenField ID="hfPolarity" runat="server" />
                                                </ItemTemplate>
                                                <ItemStyle Width="75px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterStyle Width="75px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtETotalAmt" Width="75px" Style="text-align: right" runat="server"
                                                        Font-Bold="true" BorderStyle="None"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Actual">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtAmount" CssClass="input" Width="75px" Style="text-align: right"
                                                        runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Actual1") %>' onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        BorderStyle="Groove"></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtEnAmtTotal" runat="server" Width="75px" Font-Bold="true" Style="text-align: right"
                                                        BorderStyle="NONE"></asp:TextBox>
                                                </FooterTemplate>
                                                <ItemStyle Width="75px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterStyle Width="75px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Standard">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtEAmt2" runat="server" Style="text-align: right" CssClass="input"
                                                        Width="75px" onblur="javascript:return calculateBalance()" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        Text='<%# DataBinder.Eval(Container.DataItem,"Standard2") %>' BorderStyle="Groove"
                                                        MaxLength="50"></asp:TextBox>
                                                    <asp:HiddenField ID="hfEAmt2" Value='<%# DataBinder.Eval(Container.DataItem,"Standard2") %>'
                                                        runat="server" />
                                                    <asp:HiddenField ID="hfPolarity2" runat="server" />
                                                </ItemTemplate>
                                                <ItemStyle Width="75px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterStyle Width="75px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtETotalAmt2" Width="75px" Style="text-align: right" runat="server"
                                                        Font-Bold="true" BorderStyle="None"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Actual">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtAmount2" CssClass="input" Width="75px" Style="text-align: right"
                                                        runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Actual2") %>' onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        BorderStyle="Groove"></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtEnAmtTotal2" runat="server" Width="75px" Font-Bold="true" Style="text-align: right"
                                                        BorderStyle="NONE"></asp:TextBox>
                                                </FooterTemplate>
                                                <ItemStyle Width="75px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterStyle Width="75px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Standard">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtEAmt3" runat="server" Style="text-align: right" CssClass="input"
                                                        Width="75px" onblur="javascript:return calculateBalance()" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        Text='<%# DataBinder.Eval(Container.DataItem,"Standard3") %>' BorderStyle="Groove"
                                                        MaxLength="50"></asp:TextBox>
                                                    <asp:HiddenField ID="hfEAmt3" Value='<%# DataBinder.Eval(Container.DataItem,"Standard3") %>'
                                                        runat="server" />
                                                    <asp:HiddenField ID="hfPolarity3" runat="server" />
                                                </ItemTemplate>
                                                <ItemStyle Width="75px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterStyle Width="75px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtETotalAmt3" Width="75px" Style="text-align: right" runat="server"
                                                        Font-Bold="true" BorderStyle="None"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Actual">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtAmount3" CssClass="input" Width="75px" Style="text-align: right"
                                                        runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Actual3") %>' onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        BorderStyle="Groove"></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtEnAmtTotal3" runat="server" Width="75px" Font-Bold="true" Style="text-align: right"
                                                        BorderStyle="NONE"></asp:TextBox>
                                                </FooterTemplate>
                                                <ItemStyle Width="75px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterStyle Width="75px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Standard">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtEAmt4" runat="server" Style="text-align: right" CssClass="input"
                                                        Width="75px" onblur="javascript:return calculateBalance()" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        Text='<%# DataBinder.Eval(Container.DataItem,"Standard4") %>' BorderStyle="Groove"
                                                        MaxLength="50"></asp:TextBox>
                                                    <asp:HiddenField ID="hfEAmt4" Value='<%# DataBinder.Eval(Container.DataItem,"Standard4") %>'
                                                        runat="server" />
                                                    <asp:HiddenField ID="hfPolarity4" runat="server" />
                                                </ItemTemplate>
                                                <ItemStyle Width="75px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterStyle Width="75px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtETotalAmt4" Width="75px" Style="text-align: right" runat="server"
                                                        Font-Bold="true" BorderStyle="None"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Actual">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtAmount4" CssClass="input" Width="75px" Style="text-align: right"
                                                        runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Actual4") %>' onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        BorderStyle="Groove"></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtEnAmtTotal4" runat="server" Width="75px" Font-Bold="true" Style="text-align: right"
                                                        BorderStyle="NONE"></asp:TextBox>
                                                </FooterTemplate>
                                                <ItemStyle Width="75px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterStyle Width="75px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Standard">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtEAmt5" runat="server" Style="text-align: right" CssClass="input"
                                                        Width="75px" onblur="javascript:return calculateBalance()" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        Text='<%# DataBinder.Eval(Container.DataItem,"Standard5") %>' BorderStyle="Groove"
                                                        MaxLength="50"></asp:TextBox>
                                                    <asp:HiddenField ID="hfEAmt5" Value='<%# DataBinder.Eval(Container.DataItem,"Standard5") %>'
                                                        runat="server" />
                                                    <asp:HiddenField ID="hfPolarity5" runat="server" />
                                                </ItemTemplate>
                                                <ItemStyle Width="75px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterStyle Width="75px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtETotalAmt5" Width="75px" Style="text-align: right" runat="server"
                                                        Font-Bold="true" BorderStyle="None"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Actual">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtAmount5" CssClass="input" Width="75px" Style="text-align: right"
                                                        runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Actual5") %>' onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        BorderStyle="Groove"></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtEnAmtTotal5" runat="server" Width="75px" Font-Bold="true" Style="text-align: right"
                                                        BorderStyle="NONE"></asp:TextBox>
                                                </FooterTemplate>
                                                <ItemStyle Width="75px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterStyle Width="75px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Standard">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtEAmt6" runat="server" Style="text-align: right" CssClass="input"
                                                        Width="75px" onblur="javascript:return calculateBalance()" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        Text='<%# DataBinder.Eval(Container.DataItem,"Standard6") %>' BorderStyle="Groove"
                                                        MaxLength="50"></asp:TextBox>
                                                    <asp:HiddenField ID="hfEAmt6" Value='<%# DataBinder.Eval(Container.DataItem,"Standard6") %>'
                                                        runat="server" />
                                                    <asp:HiddenField ID="hfPolarity6" runat="server" />
                                                </ItemTemplate>
                                                <ItemStyle Width="75px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterStyle Width="75px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtETotalAmt6" Width="75px" Style="text-align: right" runat="server"
                                                        Font-Bold="true" BorderStyle="None"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Actual">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtAmount6" CssClass="input" Width="75px" Style="text-align: right"
                                                        runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Actual6") %>' onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        BorderStyle="Groove"></asp:TextBox>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtEnAmtTotal6" runat="server" Width="75px" Font-Bold="true" Style="text-align: right"
                                                        BorderStyle="NONE"></asp:TextBox>
                                                </FooterTemplate>
                                                <ItemStyle Width="75px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                                <FooterStyle Width="75px" HorizontalAlign="Left" VerticalAlign="Top" Font-Bold="False" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle ForeColor="Black" Font-Bold="False" Font-Italic="False" Font-Size="8pt"
                                            CssClass="bgbluegrey" />
                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <asp:HiddenField ID="hfEnAmtTotal" runat="server" Value="0" />
                            <asp:HiddenField ID="hfETotalAmt" runat="server" Value="0" />
                            <asp:HiddenField ID="hfEnAmtTotal2" runat="server" Value="0" />
                            <asp:HiddenField ID="hfETotalAmt2" runat="server" Value="0" />
                            <asp:HiddenField ID="hfEnAmtTotal3" runat="server" Value="0" />
                            <asp:HiddenField ID="hfETotalAmt3" runat="server" Value="0" />
                            <asp:HiddenField ID="hfEnAmtTotal4" runat="server" Value="0" />
                            <asp:HiddenField ID="hfETotalAmt4" runat="server" Value="0" />
                            <asp:HiddenField ID="hfEnAmtTotal5" runat="server" Value="0" />
                            <asp:HiddenField ID="hfETotalAmt5" runat="server" Value="0" />
                            <asp:HiddenField ID="hfEnAmtTotal6" runat="server" Value="0" />
                            <asp:HiddenField ID="hfETotalAmt6" runat="server" Value="0" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="bgbluegrey" runat="server" id="Tr1">
            <td colspan="4" align="left">
                <font class="blackfnt"><b>CNOTE Details </b></font>
                <asp:HiddenField ID="HiddenField1" runat="server" />
                <asp:HiddenField ID="HiddenField2" runat="server" />
            </td>
        </tr>
        <tr style="background-color: white" id="trgvCnoterowdetails" runat="server">
            <td width="5%" nowrap>
                <font class="blackfnt">Enter no. of rows</font>
            </td>
            <td colspan="3" align="left">
                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                        <asp:TextBox ID="txtAddCnoterow" runat="server" Text="0" MaxLength="2" Width="20px"
                            onkeypress="javascript:validFloat(event,this.getAttribute('id'))" AutoPostBack="true"
                            BorderStyle="Groove" OnTextChanged="add_rowCnote"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtAddCnoterow"
                            ErrorMessage="Required Field!"></asp:RequiredFieldValidator>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr style="background-color: white" id="trgvCnotedetails" runat="server">
            <td colspan="4" align="left">
                <table border="0" width="100%">
                    <tr>
                        <td style="text-align: left">
                            <asp:UpdatePanel ID="UpdatePanel6" runat="server" UpdateMode="Always" RenderMode="Inline">
                                <ContentTemplate>
                                    <asp:GridView ID="gvCnote" runat="server" CellPadding="2" CellSpacing="1" AutoGenerateColumns="False"
                                        SelectedIndex="1" ShowFooter="false" OnRowDataBound="gvCnote_RowDataBound" Width="700px"
                                        BorderColor="#006699" BorderStyle="None" BorderWidth="3px" CssClass="blackfnt">
                                        <Columns>
                                            <asp:TemplateField HeaderText="SR.NO.">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server"></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Leg">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:DropDownList ID="ddlLegID" Width="150px" runat="server">
                                                    </asp:DropDownList>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="20%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Cnote No.">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtCnoteNo" CssClass="input" Width="80px" runat="server" BorderStyle="Groove"
                                                        Style="text-align: left" Text='<%# DataBinder.Eval(Container.DataItem,"FROM") %>'></asp:TextBox>
                                                    <asp:HiddenField ID="hfDriverId" runat="server" />
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Left" Width="20%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Bkg. Date">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtBkgDate" runat="server" BorderStyle="None" Width="70px" onfocus="this.blur()"
                                                        Style="text-align: left"  Text='<%# DataBinder.Eval(Container.DataItem,"TO") %>'>
                                                    </asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Origin Destination">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtOriginDestination" runat="server" BorderStyle="None" Width="70px"
                                                        Style="text-align: right" onfocus="this.blur()" Text='<%# DataBinder.Eval(Container.DataItem,"THCNO") %>'>
                                                    </asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="No. of Packages">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtPackage" runat="server" BorderStyle="None" Width="70px" onfocus="this.blur()"
                                                        Style="text-align: right" Text='<%# DataBinder.Eval(Container.DataItem,"THCDT") %>'>
                                                    </asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Actual Weight">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtActualWeight" runat="server" BorderStyle="None" Width="70px"
                                                        Style="text-align: right" onfocus="this.blur()" Text='<%# DataBinder.Eval(Container.DataItem,"FreightAmt") %>'>
                                                    </asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Charged Weight">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtChargedWeight" runat="server" BorderStyle="None" Width="70px"
                                                        Style="text-align: right" onfocus="this.blur()" Text='<%# DataBinder.Eval(Container.DataItem,"LabourChrg") %>'>
                                                    </asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Sub Total">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtSubTotal" runat="server" BorderStyle="None" Width="70px" onfocus="this.blur()"
                                                        Style="text-align: right" Text='<%# DataBinder.Eval(Container.DataItem,"OtherChrg") %>'>
                                                    </asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Cnote Total">
                                                <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="False" />
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtCnoteTotal" runat="server" BorderStyle="None" Width="70px" onfocus="this.blur()"
                                                        Style="text-align: right" Text='<%# DataBinder.Eval(Container.DataItem,"THCTotalAmt") %>'>>
                                                    </asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle Width="10%" HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle ForeColor="Black" Font-Bold="False" Font-Italic="False" Font-Size="8pt"
                                            CssClass="bgbluegrey" />
                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr bgcolor="white" style="width: 100%">
            <td class="blackfnt" colspan="5" style="vertical-align: middle; text-align: left;
                width: 100%; height: 25px;">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit >>" OnClientClick="javascript:return CheckValidation123555()"
                    OnClick="SubmitData" Visible="true" />
            </td>
        </tr>
    </table>
</asp:Content>
