<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="LSCreateMain.aspx.cs" Inherits="GUI_Operations_LS_ver2_LSCreateMain" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:SqlDataSource ID="MySQLDataSource_TransModes" runat="server" SelectCommand="usp_TransMode"
        SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_Cities" runat="server" SelectCommand="usp_Cities"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="-" Name="brcd" Type="String" />
            <asp:Parameter DefaultValue="-" Name="book_dely" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_Regions" runat="server" SelectCommand="usp_Regions"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="xxx" Name="brcd" SessionField="brcd" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <table cellspacing="1" style="width: 700px">
        <tr style="background-color: white">
            <td align="left" width="75%">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Generate <%=strDocumentLS%>:</asp:Label>
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

<script type="text/javascript">
function SelectAll(CheckBoxControl) 
{
if (CheckBoxControl.checked == true) 
{
var i;
for (i=0; i < document.forms[0].elements.length; i++) 
{
if ((document.forms[0].elements[i].type == 'checkbox') && 
(document.forms[0].elements[i].name.indexOf('dgDockets') > -1)) 
{
document.forms[0].elements[i].checked = true;
}
}
} 
else 
{
var i;
for (i=0; i < document.forms[0].elements.length; i++) 
{
if ((document.forms[0].elements[i].type == 'checkbox') && 
(document.forms[0].elements[i].name.indexOf('dgDockets') > -1)) 
{
document.forms[0].elements[i].checked = false;
}
}
}
}
</script>


    <script src="../../Js/CalendarPopup.js" language="javascript" type="text/javascript"></script>

    <script src="../../Js/AssignValue.js" language="javascript" type="text/javascript"></script>

    <asp:UpdatePanel ID="upTHCCreate"  UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" id="Table1"
                runat="server" visible="true">
                <tr class="bgbluegrey">
                    <td colspan="4" align="left">
                        <font class="blackfnt"><b>Selecte criteria for preparing <%=strDocumentLS%></b></font></td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" width="10%">
                        <font class="blackfnt">Manual LS #:</font>
                    </td>
                    <td align="left" width="40%">
                        <asp:TextBox ID="txtManualNo" CssClass="input" runat="server" Text="" MaxLength="25"
                            Width="200"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="grpQuery" ID="RFVtxtManualNo" runat="server" ErrorMessage="*" ControlToValidate="txtManualNo"
                            SetFocusOnError="true"></asp:RequiredFieldValidator>
                        <font class="bluefnt">NA <i>if not applicable</i></font>
                    </td>
                    <td align="left" width="10%">
                        <font class="blackfnt">LS Date:</font>
                    </td>
                    <td align="left" width="40%">
                        <asp:TextBox ID="txtDocumentDate" CssClass="input" runat="server" Text="" MaxLength="10"
                            Width="70"></asp:TextBox>
                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtDocumentDate,'a','dd/MM/yyyy'); return false;"
                            id="a">
                            <img src="./../../images/calendar.jpg" border="0" />
                        </a>
                        <asp:RequiredFieldValidator ValidationGroup="grpQuery" SetFocusOnError="true" ID="RFVtxtDocumentDate" runat="server"
                            ErrorMessage="*" ControlToValidate="txtDocumentDate"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ValidationGroup="grpQuery" SetFocusOnError="true" ID="REVtxtDocumentDate" runat="server"
                            ErrorMessage="!" ToolTip="Invalid Date/Date Format" ControlToValidate="txtDocumentDate"
                            ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                        <asp:Label ID="lblddmmyy1" runat="server" CssClass="bluefnt" Text=" [dd/mm/yyyy] " />
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Next Stop:</font></td>
                    <td align="left" colspan="3">
                        <asp:TextBox ID="txtNextStop" runat="server" CssClass="input" Text="" MaxLength="25"
                            Width="50" AutoPostBack="true" OnPreRender="NextStop_TextChanged" OnTextChanged="NextStop_TextChanged"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="grpQuery" ID="RFVtxtNextStop" runat="server" ErrorMessage="*" ControlToValidate="txtNextStop"
                            SetFocusOnError="true"></asp:RequiredFieldValidator>
                        <asp:Label ID="lblError1" runat="server" Text="Invalid Next Location" Visible="false"
                            CssClass="redfnt"></asp:Label>
                    </td>
                </tr>
            </table>
            <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" id="tblDocketCreteria"
                runat="server" visible="true">
                <tr class="bgbluegrey">
                    <td colspan="2" style="text-align: left">
                        <asp:Label ID="lblTblHeader" runat="server" CssClass="blackfnt" Text="Select Docket Criteria"
                            Font-Bold="true"></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" rowspan="4" valign="Top">
                        <asp:Label ID="lblDate" runat="server" CssClass="blackfnt" Text="Docket Date :">
                        </asp:Label>
                    </td>
                    <td align="left">
                        <input type="radio" id="radFromToDate" runat="server" checked onclick="javascript:document.aspnetForm.ctl00_MyCPH1_txtFrom.disabled=false;document.aspnetForm.ctl00_MyCPH1_txtTo.disabled=false;document.aspnetForm.ctl00_MyCPH1_txtFrom.focus();" />
                        <asp:Label ID="lblFromDate" runat="server" CssClass="blackfnt" Text="From :" />
                        <asp:TextBox ID="txtFrom" runat="server" MaxLength="10" Width="70" EnableViewState="true"></asp:TextBox>
                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtFrom,'a1','dd/MM/yyyy'); return false;"
                            id="a1">
                            <img src="./../../images/calendar.jpg" border="0" />
                        </a>
                        <%--<asp:RequiredFieldValidator SetFocusOnError="true" ID="RFVDtFrom" runat="server"
                    ErrorMessage="*" ControlToValidate="txtFrom"></asp:RequiredFieldValidator>--%>
                        <asp:RegularExpressionValidator ValidationGroup="grpQuery" SetFocusOnError="true" ID="REVDtFrom" runat="server"
                            ErrorMessage="!" ToolTip="Invalid Date/Date Format" ControlToValidate="txtFrom"
                            ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                        &nbsp;
                        <asp:Label ID="lblToDate" runat="server" CssClass="blackfnt" Text=" To " />
                        &nbsp;
                        <asp:TextBox ID="txtTo" runat="server" MaxLength="10" Width="70" EnableViewState="true"></asp:TextBox>
                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtTo,'a2','dd/MM/yyyy'); return false;"
                            id="a2">
                            <img src="./../../images/calendar.jpg" border="0" />
                        </a>
                        <%--<asp:RequiredFieldValidator SetFocusOnError="true" ID="RFVDtTo" runat="server" ErrorMessage="*"
                    ControlToValidate="txtTo"></asp:RequiredFieldValidator>--%>
                        <asp:RegularExpressionValidator ValidationGroup="grpQuery" SetFocusOnError="true" ID="REVDtTo" runat="server"
                            ErrorMessage="!" ToolTip="Invalid Date/Date Format" ControlToValidate="txtTo"
                            ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                        <%--                <asp:CompareValidator runat="server" ControlToCompare="txtFrom" ControlToValidate="txtTo" Type="Date" Operator="GreaterThan" SetFocusOnError="true" ErrorMessage="#"></asp:CompareValidator>
--%>
                        <asp:Label ID="lblddmmyyyy" runat="server" CssClass="bluefnt" Text=" [dd/mm/yyyy] " />
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <input type="hidden" id="hdtToday" runat="server" />
                        <input type="hidden" id="hdt2" runat="server" />
                        <input type="hidden" id="hdt1" runat="server" />
                        <input type="hidden" id="hdt" runat="server" />
                        <input type="radio" id="radToday" runat="server" onclick="Javascript:AssignValue(document.aspnetForm.ctl00_MyCPH1_txtFrom,document.aspnetForm.ctl00_MyCPH1_hdtToday);AssignValue(document.aspnetForm.ctl00_MyCPH1_txtTo,document.aspnetForm.ctl00_MyCPH1_hdtToday);document.aspnetForm.ctl00_MyCPH1_txtFrom.disabled=true;document.aspnetForm.ctl00_MyCPH1_txtTo.disabled=true;" />
                        <asp:Label ID="lblToday" runat="server" CssClass="blackfnt">Today's - </asp:Label>
                        <asp:Label ID="lblTodayVal" runat="server" CssClass="bluefnt"><%=dtToday%></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <input type="radio" id="radLastWeek" runat="server" onclick="Javascript:AssignValue(document.aspnetForm.ctl00_MyCPH1_txtFrom,document.aspnetForm.ctl00_MyCPH1_hdt2);AssignValue(document.aspnetForm.ctl00_MyCPH1_txtTo,document.aspnetForm.ctl00_MyCPH1_hdt1);document.aspnetForm.ctl00_MyCPH1_txtFrom.disabled=true;document.aspnetForm.ctl00_MyCPH1_txtTo.disabled=true;" />
                        <asp:Label ID="lblLastWeek" runat="server" CssClass="blackfnt">Last Week's - </asp:Label>
                        <asp:Label ID="lblLastWeekVal" runat="server" CssClass="bluefnt"><%=dtLastWeek%></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <input type="radio" id="radTillDate" runat="server" onclick="Javascript:AssignValue(document.aspnetForm.ctl00_MyCPH1_txtFrom,document.aspnetForm.ctl00_MyCPH1_hdt);AssignValue(document.aspnetForm.ctl00_MyCPH1_txtTo,document.aspnetForm.ctl00_MyCPH1_hdt1);document.aspnetForm.ctl00_MyCPH1_txtFrom.disabled=true;document.aspnetForm.ctl00_MyCPH1_txtTo.disabled=true;" />
                        <asp:Label ID="lblTillDate" runat="server" CssClass="blackfnt">Till Date</asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Transition Mode:</font>
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="cboTransMode" runat="server" EnableViewState="true" DataSourceID="MySQLDataSource_TransModes"
                            DataTextField="CodeDesc" DataValueField="CodeID">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Destination:</font>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtDestination" runat="server" Text="" MaxLength="500" Width="300"></asp:TextBox>
                        <font class="bluefnt">[Seperated by <i>Comma</i> if multiple]</font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Region:</font>
                    </td>
                    <td align="left">
                        <asp:ListBox Rows="4" SelectionMode="Multiple" ID="lstRegion" runat="server" Width="300"
                            DataSourceID="MySQLDataSource_Regions" DataTextField="LocName" DataValueField="LocCode">
                        </asp:ListBox>
                        <font class="bluefnt">Press Ctrl Key to Select/Deselect 1 or more rows</font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">City From:</font>
                    </td>
                    <td align="left">
                        <%--                <asp:TextBox ID="txtCityFrom" runat="server" Text="" Width="70"></asp:TextBox>
--%>
                        <asp:DropDownList ID="cboCityFrom" runat="server" EnableViewState="true" DataSourceID="MySQLDataSource_Cities"
                            DataTextField="City" DataValueField="CityVal">
                        </asp:DropDownList>
                        &nbsp; <font class="blackfnt">To:</font> &nbsp;
                        <asp:DropDownList ID="cboCityTo" runat="server" EnableViewState="true" DataSourceID="MySQLDataSource_Cities"
                            DataTextField="City" DataValueField="CityVal">
                        </asp:DropDownList>
                        <%--                <asp:TextBox ID="txtCityTo" runat="server" Text="" Width="70"></asp:TextBox>
--%>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="center" colspan="2">
                        <font class="blackfnt"><b>- OR -</b></font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt"><%=strDocumentDKT%> No(s).:</font>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDocketList" runat="server" Text="" Width="300" AutoPostBack="true"></asp:TextBox>
                        <font class="bluefnt">[Seperated by <i>Comma</i> if multiple]</font>
                    </td>
                </tr>
            </table>
            
            <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" id="tblDocPreparedBy"
                runat="server" visible="true">
                <tr class="bgbluegrey">
                    <td align="left">
                        <font class="blackfnt"><b>Document Prepared By</b></font></td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <asp:TextBox CssClass="input" ID="txtPreparedBy" runat="server" AutoPostBack="true" MaxLength="15" Width="50" OnTextChanged="PreparedBy_TextChanged"></asp:TextBox>
                        <asp:RequiredFieldValidator ValidationGroup="grpQuery" ID="RFVtxtPreparedBy" runat="server" ErrorMessage="*" ControlToValidate="txtPreparedBy" SetFocusOnError="true"></asp:RequiredFieldValidator>
                        <asp:Label ID="lblError2" runat="server" Text="Invalid User Code" Visible="false"
                            CssClass="redfnt"></asp:Label>
                    </td>
                </tr>
            </table>
            
            <table border="0" cellspacing="1" cellpadding="3" width="900px" runat="server" id="trSubmit"
                visible="true">
                <tr>
                    <td align="left">
                        <asp:Button ID="btnSubmit" ValidationGroup="grpQuery" runat="server" Text="Show Docket List >>" OnClick="ShowDocketsForMF" />
                    </td>
                </tr>
            </table>
            
            <table cellpadding="3" cellspacing="1" border="0" id="tblNoDocketsSelected" runat="server" width="900px" visible="false">
                <tr bgcolor="white">
                    <td align="left">
                        <font class="redfnt"><b>Alert: </b>No <%=strDocumentDKT%>s Were Selected</font>
                    </td>
                </tr>
            </table>

            <table cellpadding="3" cellspacing="1" border="0" class="boxbg" id="tblDocketList" runat="server" width="950px" visible="false">
                <tr style="background-color:White">
                    <td align="center">
                        <font class="blackfnt"><b><%=strDocumentDKT%>s  available for <%=strDocumentLS%> Generation</b></font>
                    </td>
                </tr>
                
                <tr style="background-color:White">
                    <td align="left">
                        <asp:GridView ID="dgDockets" runat="server" CellSpacing="1"
                            CellPadding="3" HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="true" AutoGenerateColumns="false"
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." Width="100%" DataKeyNames="DOCKNO,DOCKSF,PackagesLB,WeightLB">
                       

                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                    <input type="CheckBox" name="SelectAllCheckBox" onclick="SelectAll(this)">
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chkDocket" EnableViewState="true" Text="" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField  HeaderText="Docket #" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocketNo")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                

                                <asp:TemplateField  HeaderText="Bkg. Date" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk4" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocketDate")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField  HeaderText="Trans. Mode" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnkTransMode" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "TransMode")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField  HeaderText="Bkg. Loc." ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk3" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "OrgCode")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField  HeaderText="Dely. Loc." ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ReDestCode")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField  HeaderText="City From-To" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnkFromTo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FromTo")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>


<%--                                <asp:TemplateField  HeaderText="Arrv. Date" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk6" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ArrivalDate")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>
--%>
                                <asp:TemplateField  HeaderText="Comm. Dely Date" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk7" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Commited_DelyDate")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>


                                <asp:TemplateField  HeaderText="Pkgs.[L/B]" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                       <%-- <asp:RequiredFieldValidator ValidationGroup="grpResult" ID="RFVtxtPkgs" runat="server" ErrorMessage="*" ControlToValidate="txtPkgs" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                        <asp:TextBox runat="server" ID="txtPkgs" Width="30" EnableViewState="true" Text='<%# DataBinder.Eval(Container.DataItem, "PackagesLB")%>' />
                                        <asp:RegularExpressionValidator ValidationGroup="grpResult" ID="REVtxtPkgs" runat="server" ControlToValidate="txtPkgs" ValidationExpression="^\d+$" ErrorMessage="!" ToolTip="Invalid Value" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                        <asp:CompareValidator ValidationGroup="grpResult" runat="server" ValueToCompare='<%# DataBinder.Eval(Container.DataItem, "PackagesLB")%>' ID="CVtxtPkgs"  ControlToValidate="txtPkgs" Operator="LessThanEqual" Type="Integer" ErrorMessage="#"  ToolTip="Loaded Pkgs. cannot be greater than Booked" SetFocusOnError="true"></asp:CompareValidator>
                                        <asp:RangeValidator ValidationGroup="grpResult" runat="server" MinimumValue="1" Type="Integer" MaximumValue="999999999" ID="RVtxtPkgs" ControlToValidate="txtPkgs" ErrorMessage="~" ToolTip="Cannot be less than 1"></asp:RangeValidator>
                                      --%>  
<asp:Label ID="txtPkgs" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PackagesLB")%>'
CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>"  />
                                      <font class="blackfnt">/</font>
                                        <asp:Label ID="lnk8" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PackagesLB")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField  HeaderText="Wt.[L/B]" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                       <%-- <asp:RequiredFieldValidator ValidationGroup="grpResult" ID="RFVtxtWt" runat="server" ErrorMessage="*" ControlToValidate="txtWt" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                        <asp:TextBox runat="server" ID="txtWt" Width="30" EnableViewState="true" Text='<%# DataBinder.Eval(Container.DataItem, "WeightLB")%>' />
                                        <asp:RegularExpressionValidator ValidationGroup="grpResult" ID="REVtxtWt" runat="server" ControlToValidate="txtWt" ValidationExpression="^\d+$" ErrorMessage="!" ToolTip="Invalid Value" SetFocusOnError="true"></asp:RegularExpressionValidator>
                                        <asp:CompareValidator ValidationGroup="grpResult" runat="server" ValueToCompare='<%# DataBinder.Eval(Container.DataItem, "WeightLB")%>' ID="CVtxtWt"  ControlToValidate="txtWt" ToolTip="Loaded Wt. cannot be greater than Booked" Operator="LessThanEqual" Type="Double" ErrorMessage="#" SetFocusOnError="true"></asp:CompareValidator>--%>
                                      <asp:Label ID="txtWt" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "WeightLB")%>'
                                      CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                        <font class="blackfnt">/</font>
                                        
                                        <asp:Label ID="lnk9" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "WeightLB")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>


                            </Columns>

                        </asp:GridView>                
                    </td>
                </tr>
            </table>

            <table border="0" cellspacing="1" cellpadding="3" width="900px" runat="server" id="tblSubmitBtn"
                visible="false">
                <tr>
                    <td align="left">
                        <asp:Button ValidationGroup="grpResult" ID="btnPrepareManifest" runat="server" Text="Prepare <%=strDocumentLS%> >>" OnClick="PrepareManifest"/>
                    </td>
                </tr>
            </table>

        
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
