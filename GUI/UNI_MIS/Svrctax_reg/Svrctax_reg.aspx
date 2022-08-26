<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Svrctax_reg.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_view" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>

    <%-- <script language="javascript" type="text/javascript" src="docket_javascript.js"></script>--%>

    <script language="javascript" type="text/javascript">
var cal = new CalendarPopup("testdiv1");
cal.setCssPrefix("TEST");
cal.showNavigationDropdowns();
    </script>

    <script language="javascript" type="text/javascript">

      
      function nwOpen(mNo)
        {
            window.open("popup-cust.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
   
    </script>

    <br />
    <table style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Finance.aspx"><font class="blklnkund">
                        <b>Finance</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Service Tax Regester
                            Report</b></font>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <div align="left" style="width: 9.5in;">
      
                <table cellspacing="1" style="width: 90%" class="boxbg" border="0">
                    <tr class="bgbluegrey">
                        <td colspan="3" align="center" style="height: 21px">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                        Select Criteria
                            </asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" style="width: 348px">
                            <asp:UpdatePanel ID="UpdatePanel2"     UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        AutoPostBack="true" OnSelectedIndexChanged="radDate_SelectedIndexChanged" Width="210px">
                                        <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                        <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                                        <asp:ListItem Value="3" Enabled="false" Text=" Till Date:"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                        <td valign="top" colspan="2" align="left" nowrap style="width: 300px">
                            <asp:UpdatePanel ID="UpdatePanel3" RenderMode="Inline"    UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
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
                                    <br />
                                     <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Date Range Must Be 1 month Only"
                                OnServerValidate="daterange"></asp:CustomValidator>
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
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                     <tr id="ROWLO" visible="true" runat="server" style="background-color: white">
                        <td align="left">
                            <asp:Label ID="Label8" CssClass="blackfnt" Text="Select RO" runat="server" Width="100%"></asp:Label>
                        </td>
                        <td align="left" colspan="2" valign="top">
                            <asp:UpdatePanel ID="UP" runat="server">
                                <ContentTemplate>
                                    <asp:DropDownList ID="cboRO" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboRO_SelectedIndexChanged">
                                        <%--<asp:ListItem Value="All" Text="All"></asp:ListItem>--%>
                                    </asp:DropDownList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <asp:Label ID="Label4" CssClass="blackfnt" Text="Select Location" runat="server"
                                Width="102px"></asp:Label>
                        </td>
                        <td align="left" colspan="2" valign="top">
                            <asp:UpdatePanel ID="updatepanel8" runat="server">
                                <ContentTemplate>
                                    <asp:DropDownList ID="cboRO_Lo" runat="server" Mode="Conditional" RenderMode="Inline"
                                        Width="102px">
                                        <%-- <asp:ListItem Text="All" Value=""></asp:ListItem>--%>
                                    </asp:DropDownList>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="cboRO" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" style="height: 24px; width: 100px;">
                            <asp:Label ID="Label5" CssClass="blackfnt" Text="MR Party " runat="server" Width="113px"></asp:Label>
                        </td>
                        <td align="left" colspan="2" valign="top" style="height: 24px;">
                            <asp:TextBox ID="txtparty" runat="server" Width="100px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                            <asp:Label ID="Label6" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen(1)">...</a>'
                                Width="14px"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" style="height: 24px; width: 100px;">
                            <asp:Label ID="Label1" CssClass="blackfnt" Text="MR Type  : " runat="server" Width="113px"></asp:Label>
                        </td>
                        <td align="left" colspan="2" valign="top" style="height: 24px;">
                            &nbsp;<asp:DropDownList ID="ddlmrtype" runat="server">
                                <asp:ListItem Text="-- All --" Value=""></asp:ListItem>
                                <asp:ListItem Text="Paid" Value=""></asp:ListItem>
                                <asp:ListItem Text="TBB" Value=""></asp:ListItem>
                                <asp:ListItem Text="To Pay" Value=""></asp:ListItem>
                                <asp:ListItem Text="Octroi" Value=""></asp:ListItem>
                                <asp:ListItem Text="Misc. MR" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" style="height: 24px; width: 150px;">
                            
                               <font class="blackfnt">(Amount Grater Than)</font>
                        </td>
                        <td align="left" colspan="2" valign="top" style="height: 24px;">
                            <asp:TextBox ID="txtamt" runat="server" Width="100px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" style="height: 24px; width: 100px;">
                            <asp:Label ID="Label7"  CssClass="blackfnt" Text="Enter MR No. " runat="server" Width="113px"></asp:Label>
                        </td>
                        <td align="left" colspan="2" valign="top" style="height: 24px;">
                            <asp:TextBox ID="txtmrno" runat="server" Width="400px"></asp:TextBox>
                            <font class="blackfnt">(Separated by comma if Multiple)</font>
                        </td>
                    </tr>
                </table>
                <br />
                <div style="width: 9.5in" align="center">
                    <asp:Button ID="Button3" runat="server" Text="Show" Width="150" OnClick="Button3_Click" />
                </div>
           
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
