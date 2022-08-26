<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="THCDeparturesMain.aspx.cs" Inherits="GUI_Operations_THC_THCDeparturesMain" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">


    <script src="../../images/commonJs.js" language="javascript" type="text/javascript"></script>

    <script src="./Js/THC.js" language="javascript" type="text/javascript"></script>

    <script src="../../Js/CalendarPopup.js" language="javascript" type="text/javascript"></script>

    <script src="../../Js/AssignValue.js" language="javascript" type="text/javascript"></script>
    
    <asp:UpdatePanel ID="upDepartures"  UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <table cellspacing="1" style="width: 900px">
                <tr style="background-color: white">
                    <td align="left" style="width: 50%">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">THC Departures:</asp:Label>
                        <hr align="center" size="1" color="#8ba0e5">
                    </td>
                    <td align="left">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
            </table>
            <br />
            <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" id="tblSUCreteria"
                runat="server" visible="true">
                <tr class="bgbluegrey">
                    <td colspan="2" style="text-align: left">
                        <asp:Label ID="lblTblHeader" runat="server" CssClass="blackfnt" Text="Select THC Departure Criteria"
                            Font-Bold="true"></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" rowspan="4" valign="Top">
                        <asp:Label ID="lblDate" runat="server" CssClass="blackfnt" Text="THC Arrival Date :">
                        </asp:Label>
                    </td>
                    <td align="left">
                        <asp:HiddenField ID="hDateRange" runat="server" Value="2" />
                        <asp:HiddenField ID="hTHCSelected" runat="server" />
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
                        <input type="radio" name="radDate" />
                        <asp:Label ID="lblToday" runat="server" CssClass="blackfnt">Today's - <%=dtToday%></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <input type="radio" name="radDate" />
                        <asp:Label ID="lblLastWeek" runat="server" CssClass="blackfnt">Last Week's - <%=dtLastWeek%></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <input type="radio" name="radDate" />
                        <asp:Label ID="lblTillDate" runat="server" CssClass="blackfnt">Till Date</asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">THC No(s).:</font>
                    </td>
                    <td>
                        <asp:TextBox ID="txtTHCList" runat="server" Text="" Width="300"></asp:TextBox>
                        <font class="blackfnt">[Seperated by <i>Comma</i> if multiple]</font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">MF No(s).:</font>
                    </td>
                    <td>
                        <asp:TextBox ID="txtMFList" runat="server" Text="" Width="300"></asp:TextBox>
                        <font class="blackfnt">[Seperated by <i>Comma</i> if multiple]</font>
                    </td>
                </tr>

                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Docket No(s).:</font>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDocketList" runat="server" Text="" Width="300"></asp:TextBox>
                        <font class="blackfnt">[Seperated by <i>Comma</i> if multiple]</font>
                    </td>
                </tr>


                <tr bgcolor="white">
                    <td align="right" colspan="2">
                        <asp:Button ID="btnShowTHC" Text="Show THCs for Departures >>" runat="server" OnClientClick="return ValidateData()"
                            OnClick="ShowTHCForDeparture" />
                    </td>
                </tr>
            </table>
            <br />
            <table cellpadding="3" cellspacing="1" border="0" class="boxbg" id="tblTHCList" runat="server"
                width="900" visible="false">
                <tr style="background-color: White">
                    <td align="center">
                        <font class="blackfnt"><b>THCs available for Departures</b></font>
                        
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left">
                        <asp:GridView ID="dgTHC" EnableViewState="true" runat="server" CellSpacing="1" CellPadding="3"
                            HeaderStyle-CssClass="StaticColumn" AllowSorting="true" AutoGenerateColumns="false"
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." Width="100%" OnRowDataBound="GVRowDB">
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <input type="radio" runat="server" id="rdo" onclick="SelectOne(this,'dgTHC')" 
                                        value='<%#DataBinder.Eval(Container.DataItem, "THCNO")%>'
                                        />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField  HeaderText="Sr. #" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <font class="blackfnt"><%# Container.DataItemIndex + 1%></font>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="THC Branch" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk0" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "THCBR")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="THC #" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "THCNO")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="THC Date" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk2" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "THC_Date")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText='THC Arrival Date' ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk3" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Arrival_Date")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText='THC ETD' ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk4" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ETD")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                           </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left">
                        <asp:Button ID="btnUpdateDRS" runat="server" Text="Proceed to depart selected THC >>"
                            OnClientClick="return PassSelectedTHCForDeparture()" OnClick="PassSelectedTHCForDeparture"/>
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

