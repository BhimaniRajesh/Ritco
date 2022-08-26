<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Location_Stock.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_view" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
    </script>

    <asp:UpdatePanel ID="UP1" runat="Server">
        <ContentTemplate>
            <br />
            <table style="width: 1100px">
                <tr>
                    <td align="left">
                        <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                            <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Operation.aspx"><font class="blklnkund">
                                <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Location Stock Report</b></font>
                    </td>
                    <td align="right">
                        <a href="javascript:window.history.go(-1)" title="back">
                            <img src="../../images/back.gif" border="0" alt="" /></a>
                    </td>
                </tr>
            </table>
            <br />
            <%--<table cellspacing="1" style="background-color: #FFFFFF;width: 9.5in;" align="left" class="boxbg"  border="0">--%>
            <table border="0" style="width: 9.5in;" align="left" cellspacing="1" cellpadding="5"
                runat="server" id="newtab" class="boxbg">
                <tr class="bgbluegrey">
                    <td colspan="4" align="center" style="height: 21px">
                        <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                        Select Criteria
                        </asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="center" colspan="4" style="height: 21px">
                        <table cellpadding="5" class="boxbg" cellspacing="1" border="0">
                            <tr style="background-color: white">
                                <td align="center" colspan="4" style="width: 5025px">
                                    <asp:Label ID="Label7" runat="server" Font-Bold="true" CssClass="blackfnt" Text="From"
                                        Width="102px"></asp:Label></td>
                                <td align="center" colspan="2" style="width: 651px">
                                    <asp:Label ID="Label8" runat="server" Font-Bold="true" CssClass="blackfnt" Text="To"
                                        Width="102px"></asp:Label></td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left" colspan="3" style="width: 5025px">
                                    <asp:Label ID="lbl" runat="server" CssClass="blackfnt" Text="Select RO" Width="102px"></asp:Label></td>
                                <td align="left" style="width: 1365px">
                                    <asp:UpdatePanel ID="up3" runat="server">
                                        <ContentTemplate>
                                            <%--<asp:Button ID="btnBranchPopup" runat="server" Text="..." OnClick="BranchPopup(this)" PopupURL="../../mis/popup-cust.asp?13" />--%>
                                            &nbsp;<asp:DropDownList ID="ddlro" Width="250" runat="server" OnSelectedIndexChanged="ddlro_SelectedIndexChanged"
                                                AutoPostBack="True">
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                                <td align="left" style="width: 651px">
                                    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Select RO" Width="102px"></asp:Label></td>
                                <td align="left" style="width: 2299px">
                                    <asp:UpdatePanel ID="UpdatePanel20" runat="server"    UpdateMode="Conditional" RenderMode="inline">
                                        <ContentTemplate>
                                            <asp:Panel ID="pnlventype" runat="server">
                                                &nbsp;
                                                <asp:DropDownList ID="ddlro2" runat="server" Width="250" OnSelectedIndexChanged="ddlro2_SelectedIndexChanged"
                                                    AutoPostBack="True">
                                                </asp:DropDownList></asp:Panel>
                                        </ContentTemplate>
                                        <%--<Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="ddldelby" EventName="SelectedIndexChanged" />
                                                    </Triggers>--%>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left" colspan="3" style="width: 325px">
                                    <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Text="Select Location"
                                        Width="113px"></asp:Label></td>
                                <td align="left" style="width: 1365px">
                                    &nbsp;<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                            &nbsp;<asp:DropDownList ID="ddlloc" Width="250" runat="server" AutoPostBack="True">
                                                <asp:ListItem Text="-All-"></asp:ListItem>
                                            </asp:DropDownList>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                                <td align="left" style="width: 651px">
                                    <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Text="Select Location"
                                        Width="113px"></asp:Label></td>
                                <td align="left" style="width: 299px">
                                    <asp:UpdatePanel ID="UpdatePanel22" runat="server">
                                        <ContentTemplate>
                                            <asp:Panel ID="pnlstaff" runat="server">
                                                &nbsp;
                                                <asp:DropDownList ID="ddlloc2" Width="250" runat="server" AutoPostBack="True">
                                                </asp:DropDownList></asp:Panel>
                                        </ContentTemplate>
                                        <%-- <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="ddldelby" EventName="SelectedIndexChanged" />
                                                    </Triggers>--%>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                    <td valign="top" align="left" width="25%">
                        <asp:Label ID="Label3" CssClass="blackfnt" Text="Select Date" runat="server" Width="145px"></asp:Label>
                    </td>
                    <td align="left" width="10%" valign="top">
                        <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                            AutoPostBack="true" OnSelectedIndexChanged="radDate_SelectedIndexChanged" RepeatColumns="1"
                            Width="244px">
                            <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                            <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                            <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                        </asp:RadioButtonList></td>
                    <td valign="top" align="left" width="30%" colspan="2">
                        <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                        <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"
                            name="anchor1" id="anchor1">
                            <img src="./../../images/calendar.jpg" border="0"></img>
                        </a>
                        <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                        <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor2','dd/MM/yyyy'); return false;"
                            name="anchor2" id="a1">
                            <img src="./../../images/calendar.jpg" border="0"></img>
                        </a>
                        <asp:RequiredFieldValidator ID="RFVFromDate" runat="server" ControlToValidate="txtDateFrom"
                            ErrorMessage="Date From cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                        <br />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Date From  :("
                            ControlToValidate="txtDateFrom" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                        <br />
                        <asp:RequiredFieldValidator ID="RFVToDate" runat="server" ControlToValidate="txtDateTo"
                            ErrorMessage="Date To cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                        <br />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid Date To  :("
                            ControlToValidate="txtDateTo" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Date Range Must Be 1 month Only"
                            OnServerValidate="daterange"></asp:CustomValidator>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td align="left" style="height: 25px; width: 100px;">
                        &nbsp;<asp:Label ID="Label5" runat="server" CssClass="blackfnt" Text="Stock As On"
                            Width="113px"></asp:Label></td>
                    <td align="left" style="height: 24px; width: 25px;">
                        <asp:RadioButtonList ID="RadioButtonList1" runat="server" CssClass="blackfnt" RepeatDirection="Horizontal"
                            Enabled="false">
                            <asp:ListItem>Today</asp:ListItem>
                            <asp:ListItem>Specific</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    <td align="left" colspan="2" valign="top" style="height: 25px; width: 800px;">
                        &nbsp;&nbsp;
                        <asp:TextBox ID="TextBox1" runat="server" Enabled="false"></asp:TextBox></td>
                </tr>
                <tr style="background-color: white">
                    <td align="left" style="height: 24px;">
                        &nbsp;<asp:Label ID="Label6" CssClass="blackfnt" Text="Select Report Type" runat="server"
                            Width="140px"></asp:Label></td>
                    <td align="left" colspan="3" valign="top" style="height: 24px;">
                        &nbsp;<asp:RadioButtonList ID="rdreptype" runat="server" CssClass="blackfnt" RepeatDirection="Horizontal">
                            <asp:ListItem Value="S">Summary</asp:ListItem>
                            <asp:ListItem Value="X">Detail Download</asp:ListItem>
                            <asp:ListItem Value="D">Detail Page Wise</asp:ListItem>
                        </asp:RadioButtonList></td>
                </tr>
                <tr style="background-color: white">
                    <td align="center" colspan="4" style="height: 24px;">
                        <asp:Button ID="Submit" runat="server" OnClick="Button3_Click" Text="Button" />
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
