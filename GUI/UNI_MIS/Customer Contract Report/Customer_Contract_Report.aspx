<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Customer_Contract_Report.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_view" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
    </script>

    <table cellspacing="1" style="width: 11.5in;" align="left" border="0">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Operation.aspx"><font class="blklnkund">
                        <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Customer Contract
                            Report </b></font>
            </td>
                
        </tr>
    </table>
    <br />
    <br />
    <br />
    <div style="width: 9.5in">
        <asp:UpdatePanel ID="UP1" runat="Server">
            <ContentTemplate>
                <table cellspacing="1" style="width: 90%" class="boxbg" border="0">
                    <tr class="bgbluegrey">
                        <td colspan="3" align="center" style="height: 21px">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                        Select Criteria
                            </asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" style="height: 24px; width: 150px;">
                            <asp:Label ID="lbl" CssClass="blackfnt" Text="Select RO" runat="server" Width="102px"></asp:Label>
                        </td>
                        <td align="left" colspan="2" valign="top" style="height: 25px">
                            <asp:UpdatePanel ID="up3" runat="server">
                                <ContentTemplate>
                                    <%--<asp:Button ID="btnBranchPopup" runat="server" Text="..." OnClick="BranchPopup(this)" PopupURL="../../mis/popup-cust.asp?13" />--%>
                                   &nbsp;<asp:DropDownList ID="ddlro" Width="250" runat="server" OnSelectedIndexChanged="ddlro_SelectedIndexChanged"
                                        AutoPostBack="True">
                                    </asp:DropDownList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" style="height: 24px; width: 100px;">
                            <asp:Label ID="Label4" CssClass="blackfnt" Text="Select Location" runat="server"
                                Width="113px"></asp:Label>
                        </td>
                        <td align="left" colspan="2" valign="top" style="height: 24px;">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    &nbsp;<asp:DropDownList ID="ddlloc" Width="250" runat="server" AutoPostBack="True">
                                        <asp:ListItem Value="All">All</asp:ListItem>
                                    </asp:DropDownList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" style="height: 24px; width: 100px;">
                            <asp:Label ID="Label1" CssClass="blackfnt" Text="Select Contract Type" runat="server"
                                Width="173px"></asp:Label>
                        </td>
                        <td align="left" colspan="2" valign="top" style="height: 24px;">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    &nbsp;<asp:DropDownList ID="ddlcon_type" runat="server" AutoPostBack="True">
                                        <asp:ListItem>All</asp:ListItem>
                                        <asp:ListItem Value="P01">PAID</asp:ListItem>
                                        <asp:ListItem Value="P02">TBB</asp:ListItem>
                                        <asp:ListItem Value="P08">BOD</asp:ListItem>
                                        <asp:ListItem Value="P03">To Pay</asp:ListItem>
                                        <asp:ListItem Value="P09">NATIONAL</asp:ListItem>
                                    </asp:DropDownList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" style="height: 24px; width: 100px;">
                            <asp:Label ID="Label2" CssClass="blackfnt" Text="Select Active/Deactive" runat="server"
                                Width="173px"></asp:Label>
                        </td>
                        <td align="left" colspan="2" valign="top" style="height: 24px;">
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                <ContentTemplate>
                                    &nbsp;<asp:DropDownList ID="ddlact_dact" runat="server" AutoPostBack="True">
                                        <asp:ListItem>ALL</asp:ListItem>
                                        <asp:ListItem Value="Y">ACTIVE</asp:ListItem>
                                        <asp:ListItem Value="N">DEACTIVE</asp:ListItem>
                                    </asp:DropDownList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                        <td valign="top" align="left">
                            <asp:Label ID="Label3" CssClass="blackfnt" Text="Select Date" runat="server"
                                Width="145px"></asp:Label>
                        </td>
                        <td align="left" style="width: 359px" valign="top">
                            <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                AutoPostBack="true" OnSelectedIndexChanged="radDate_SelectedIndexChanged" RepeatColumns="1"
                                Width="244px">
                                <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                                <asp:ListItem Value="3" Text=" Till Date:"></asp:ListItem>
                            </asp:RadioButtonList></td>
                        <td valign="top" align="left" style="width: 359px">
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
                            <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="Date Range Must Be 1 month Only"
                                OnServerValidate="daterange"></asp:CustomValidator>
                            <asp:RequiredFieldValidator ID="RFVFromDate" runat="server" ControlToValidate="txtDateFrom"
                                ErrorMessage="Date From cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Date From  :("
                                ControlToValidate="txtDateFrom" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                            <asp:RequiredFieldValidator ID="RFVToDate" runat="server" ControlToValidate="txtDateTo"
                                ErrorMessage="Date To cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid Date To  :("
                                ControlToValidate="txtDateTo" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                            <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Date Range Must Be 1 month Only"
                                OnServerValidate="daterange"></asp:CustomValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDateFrom"
                                ErrorMessage="Date From Can Not Be Blank"></asp:RequiredFieldValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDateTo"
                                ErrorMessage="Date To Can Not Be Blank"></asp:RequiredFieldValidator></td>
                    </tr>
                </table>
                <br />
                <center>
                    <asp:Label ID="Label7" CssClass="blackfnt" Font-Bold="true" runat="server">
                                       Or
                                       
                    </asp:Label>
                </center>
                <br />
                <table cellspacing="1" style="width: 90%" class="boxbg" border="0">
                    <tr class="bgbluegrey">
                        <td colspan="3" align="center" style="height: 21px">
                            <asp:Label ID="Label5" CssClass="blackfnt" Font-Bold="true" runat="server">
                                        Select Contract Criteria 
                            </asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" style="height: 24px; width: 200px;">
                            <asp:Label ID="Label6" CssClass="blackfnt" Text="Enter Customer Code" runat="server"
                                Width="213px"></asp:Label>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtcust" runat="server">
                            </asp:TextBox>&nbsp;
                            <input id="btnColLoc" runat="server" name="..." type="button" /></td>
                    </tr>
                </table>
                <br />
                <br />
                <center>
                    <asp:Button ID="Button3" runat="server" Width="150" OnClick="Button3_Click" Text="Show" />
                </center>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
