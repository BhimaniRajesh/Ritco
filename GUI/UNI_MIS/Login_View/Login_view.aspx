<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Login_view.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_view" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>

    <%-- <script language="javascript" type="text/javascript" src="docket_javascript.js"></script>--%>

    <script language="javascript" type="text/javascript">
var cal = new CalendarPopup("testdiv1");
cal.setCssPrefix("TEST");
cal.showNavigationDropdowns();
    </script>

    <table style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Reports</b></font></a> <b>&gt; </b><font class="blklnkund"><b>Special Reports</b></font>
                <b>&gt; </b><font class="bluefnt"><b>Login View Report</b></font>
            </td>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img src="../../images/back.gif" border="0" alt="" /></a>
            </td>
        </tr>
    </table>
    <br /><br />
    <asp:UpdatePanel ID="UP1" runat="Server">
        <ContentTemplate>
            <div align="left" style="width: 9in">
                <table cellspacing="1" style="width: 90%" class="boxbg" border="0">
                    <tr class="bgbluegrey">
                        <td colspan="3" align="center" style="height: 21px">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                        Select Criteria
                            </asp:Label>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                        <td valign="top" align="left">
                            <asp:Label ID="Label3" CssClass="blackfnt" Text="Select Login Date" runat="server"
                                Width="145px"></asp:Label>
                        </td>
                        <td align="left" style="width: 259px" valign="top">
                            <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                AutoPostBack="true" OnSelectedIndexChanged="radDate_SelectedIndexChanged" RepeatColumns="1"
                                Width="244px">
                                <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                            </asp:RadioButtonList></td>
                        <td valign="top" align="left" style="width: 359px">
                            <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label><asp:TextBox
                                ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"
                                name="anchor1" id="anchor1">
                                <img src="./../../images/calendar.jpg" border="0"></img>
                            </a>
                            <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label><asp:TextBox
                                ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor2','dd/MM/yyyy'); return false;"
                                name="anchor2" id="a1">
                                <img src="./../../images/calendar.jpg" border="0"></img>
                            </a>
                            <br />
                            <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Date Range Must Be 1 month Only"
                                OnServerValidate="daterange"></asp:CustomValidator>
                            <asp:RequiredFieldValidator ID="RFVFromDate" runat="server" ControlToValidate="txtDateFrom"
                                ErrorMessage="Date From cannot be blank dsdsdsd :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                            <br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Date From  :("
                                ControlToValidate="txtDateFrom" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                            <br />
                            <asp:RequiredFieldValidator ID="RFVToDate" runat="server" ControlToValidate="txtDateTo"
                                ErrorMessage="Date To cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                            <br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid Date To  :("
                                ControlToValidate="txtDateTo" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                        <td align="left" valign="top" style="height: 21px">
                            <asp:Label ID="Label1" CssClass="blackfnt" Text="Location" runat="server" Width="102px"></asp:Label>
                        </td>
                        <td align="left" style="font-size: 12pt; font-family: Times New Roman; height: 21px;"
                            valign="top" colspan="2">
                            <asp:TextBox ID="txtloc" runat="server"></asp:TextBox>
                            <input id="btnSubLoc" type="button" name="..." runat="server" /></td>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                        <td align="left" valign="top">
                            <asp:Label ID="Label2" CssClass="blackfnt" Text="Employee ID" runat="server" Width="102px"></asp:Label>
                        </td>
                        <td align="left" colspan="2" valign="top">
                            <asp:TextBox ID="txtemp" runat="server"></asp:TextBox>
                            <input id="btnColLoc" type="button" name="..." runat="server" />
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                        <td align="left" valign="top">
                            <asp:Label ID="Label4" CssClass="blackfnt" Text="Login Instance " runat="server"
                                Width="102px"></asp:Label>
                        </td>
                        <td align="left" colspan="2" valign="top">
                            <asp:TextBox ID="txtli" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                        <td align="left" valign="top">
                            <asp:Label ID="Label5" CssClass="blackfnt" Text="Select Report Type" runat="server"
                                Width="202px"></asp:Label>
                        </td>
                        <td align="left" colspan="2" valign="top">
                            <asp:RadioButtonList ID="rdtreptype" CssClass="blackfnt" runat="server" AutoPostBack="True"
                                RepeatDirection="Horizontal">
                                <asp:ListItem Value="S">Summary</asp:ListItem>
                                <asp:ListItem Value="A">All Employee</asp:ListItem>
                                <asp:ListItem Value="D">Detail Download</asp:ListItem>
                            </asp:RadioButtonList>
                            </td>
                    </tr>
                    <tr align="center" bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                        <td colspan="3">
                            <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Submit" />
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
