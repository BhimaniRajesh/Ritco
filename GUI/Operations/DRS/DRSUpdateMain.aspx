<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="DRSUpdateMain.aspx.cs" Inherits="GUI_Operations_DRS_DRSUpdateMain"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script src="../../images/commonJs.js" language="javascript" type="text/javascript"></script>

    <script src="./Js/DRS.js" language="javascript" type="text/javascript"></script>

    <script src="../../Js/CalendarPopup.js" language="javascript" type="text/javascript"></script>

    <script src="../../Js/AssignValue.js" language="javascript" type="text/javascript"></script>

    <asp:UpdatePanel ID="upDRSUpdate"  UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <table cellspacing="1" style="width: 900px">
                <tr style="background-color: white">
                    <td align="left" style="width: 50%">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Update DRS:</asp:Label>
                        <hr align="center" size="1" color="#8ba0e5">
                    </td>
                    <td align="left">
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
    &nbsp;&nbsp;&nbsp;
                    </td>
                </tr>
            </table>
            <br />
            <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" id="tblDocketCreteria"
                runat="server" visible="true">
                <tr class="bgbluegrey">
                    <td colspan="2" style="text-align: left">
                        <asp:Label ID="lblTblHeader" runat="server" CssClass="blackfnt" Text="Select DRS Criteria"
                            Font-Bold="true"></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" rowspan="4" valign="Top">
                        <asp:Label ID="lblDate" runat="server" CssClass="blackfnt" Text="DRS Date :">
                        </asp:Label>
                    </td>
                    <td align="left">
                        <asp:HiddenField ID="hDateRange" runat="server" Value="2" />
                        <asp:HiddenField ID="hDRSSelected" runat="server" />
                        <%--<asp:RadioButton ID="radFromToDate" GroupName="Dates" runat="server" Text=""/>--%>
                        <input type="radio" name="radDate"" />
                        <asp:Label ID="lblFromDate" runat="server" CssClass="blackfnt" Text="From :" />
                        <asp:TextBox ID="txtFrom" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtFrom,'a1','dd/MM/yyyy'); return false;"
                            id="a1">
                            <img src="./../../images/calendar.jpg" border="0" />
                        </a>&nbsp;
                        <asp:Label ID="lblToDate" runat="server" CssClass="blackfnt" Text=" To " />
                        &nbsp;
                        <asp:TextBox ID="txtTo" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtTo,'a2','dd/MM/yyyy'); return false;"
                            id="a2">
                            <img src="./../../images/calendar.jpg" border="0" />
                        </a>
                        <asp:Label ID="lblddmmyyyy" runat="server" CssClass="blackfnt" Text=" [dd/mm/yyyy] " />
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <%--<asp:RadioButton ID="radToday" GroupName="Dates" runat="server" Text=""/>--%>
                        <input type="radio" name="radDate" />
                        <asp:Label ID="lblToday" runat="server" CssClass="blackfnt">Today's - <%=dtToday%></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <%--<asp:RadioButton ID="radLastWeek" GroupName="Dates" runat="server" Text="" Checked="true"/>--%>
                        <input type="radio" name="radDate" />
                        <asp:Label ID="lblLastWeek" runat="server" CssClass="blackfnt">Last Week's - <%=dtLastWeek%></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <%--<asp:RadioButton ID="radTillDate" GroupName="Dates" runat="server" Text=""/>--%>
                        <input type="radio" name="radDate" disabled="disabled"/>
                        <asp:Label ID="lblTillDate" runat="server" CssClass="blackfnt">Till Date</asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">DRS No(s).:</font>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDRSList" runat="server" Text="" Width="300"></asp:TextBox>
                        <font class="blackfnt">[Seperated by <i>Comma</i> if multiple]</font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="right" colspan="2">
                        <asp:Button ID="btnShowDRS" Text="Show DRS >>" runat="server" OnClientClick="return ValidateData()"
                            OnClick="ShowDRSForUpdate" />
                    </td>
                </tr>
            </table>
            <br />
            <table cellpadding="3" cellspacing="1" border="0" class="boxbg" id="tblDRSList" runat="server"
                width="900" visible="false">
                <tr style="background-color: White">
                    <td align="center">
                        <font class="blackfnt"><b>DRS available for Update</b></font>
                        
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left">
                        <asp:GridView ID="dgDRS" EnableViewState="true" runat="server" CellSpacing="1" CellPadding="3"
                            HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="true" AutoGenerateColumns="false"
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." Width="100%">
                            <%--                            DataSourceID="MySQLDataSource_MFAvailable"
                            DataKeyNames="TCNO,TOT_DKT,TOT_LOAD_PKGS,TOT_LOAD_ACTWT">
--%>
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <%--<asp:RadioButton runat="server" ID="radDRS"  ValidationGroup="dgRad" EnableViewState="true" />--%>
                                        <input type="radio" runat="server" id="rdo" onclick="SelectOne(this,'dgDRS')" 
                                        value='<%#DataBinder.Eval(Container.DataItem, "pdcno")%>'
                                        />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField  HeaderText="Sr. #" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <font class="blackfnt"><%# Container.DataItemIndex + 1%></font>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="DRS #" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "pdcno")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="DRS Date" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk2" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "pdc_dt")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total Dkts. in DRS" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk3" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "tot_dkt")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left">
                        <asp:Button ID="btnUpdateDRS" runat="server" Text="Proceed to update selected DRS >>"
                            OnClientClick="return PassSelectedDRSForUpdate()" OnClick="PassSelectedDRSForUpdate"/>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 100;">
    </div>
</asp:Content>
