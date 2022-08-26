<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Query.aspx.cs" Inherits="GUI_Operations_Enroute_Status_Update_Vehicle_Movement_Report_Query" %>

<%@ Register Src="~/GUI/Common_UserControls/WebxComplete/XAC.ascx" TagName="webxcomplete"
    TagPrefix="xac" %>
<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagName="ProgressBar"
    TagPrefix="pgb" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="../../images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function optselect() {
            var optdockno = document.getElementById("ctl00_MyCPH1_optselect_0");
            var optmanualdockno = document.getElementById("ctl00_MyCPH1_optselect_1");

            if (optdockno.checked) {
                document.getElementById("ctl00_MyCPH1_trDocket_1").style.display = 'block';
                document.getElementById("ctl00_MyCPH1_trDocket_2").style.display = 'block';
                document.getElementById("ctl00_MyCPH1_trPL_1").style.display = 'none';
                document.getElementById("ctl00_MyCPH1_trPL_2").style.display = 'none';
            }
            else {
                document.getElementById("ctl00_MyCPH1_trDocket_1").style.display = 'none';
                document.getElementById("ctl00_MyCPH1_trDocket_2").style.display = 'none';
                document.getElementById("ctl00_MyCPH1_trPL_1").style.display = 'block';
                document.getElementById("ctl00_MyCPH1_trPL_2").style.display = 'block';
            }
        }             
        
    </script>
<input type="hidden" id="hdnRptId" runat="server" /> <%-- added by Manisha 26/5/2014 --%>

    <asp:UpdatePanel ID="updone" runat="server">
        <ContentTemplate>
            <div align="left">
                <table>
                    <tr>
                        <td>
                            <table style="width: 8in" border="0" align="left" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td align="left" colspan="3">
                                        <font class="blklnkund"><strong>Module </strong></font><strong>&gt; </strong><font
                                            class="blklnkund"><strong>Enroute Status Update</strong></font><strong> &gt;
                                        </strong><font class="bluefnt"><strong>
                                            <%=SessionUtilities.DocketCalledAs.ToString() %>
                                            Movement Report</strong></font>
                                        <hr align="center" size="1" color="#8ba0e5">
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table cellspacing="1" style="width: 8in" class="boxbg" align="left">
                                <tr class="bgbluegrey">
                                    <td colspan="7" align="center" class="hrow">
                                        <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Selection Criteria </asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="white">
                                    <td align="left">
                                        <font class="blackfnt">Select Date &nbsp;</font>&nbsp;
                                    </td>
                                    <td align="left" colspan="3">
                                        <Date:DT ID="DT" runat="server" />
                                    </td>
                                </tr>
                                <tr bgcolor="white">
                                    <td align="left">
                                        <font class="blackfnt">Select Type</font>
                                    </td>
                                    <td align="left" colspan="3">
                                        <asp:RadioButtonList ID="optselect" onclick="javascript:return optselect();" RepeatDirection="Horizontal"
                                            runat="server">
                                            <asp:ListItem Selected="True" Value="CN" Text="Docket Number"></asp:ListItem>
                                            <asp:ListItem Value="MN" Text="3PL Number"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr bgcolor="white" id="trDocket_1" runat="server" style="display: block">
                                    <td align="left">
                                        <font class="blackfnt">Customer</font>
                                    </td>
                                    <td align="left" colspan="3">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtCustCode" runat="server" MaxLength="10" Width="100px" CssClass="ltxtm"
                                                        autocomplete="off"></asp:TextBox><asp:TextBox ID="txtCustName" Width="250px" Enabled="false"
                                                            CssClass="ltxtm" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <xac:webxcomplete ID="xacCustomer" NameTarget="txtCustName" MinPrefixLength="2" WebxEntity="Customer"
                                                        runat="server" CodeTarget="txtCustCode" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr bgcolor="white" id="trDocket_2" runat="server" style="display: block">
                                    <td align="left">
                                        <font class="blackfnt">
                                            <%=SessionUtilities.DocketCalledAs.ToString() %>
                                            No</font>
                                    </td>
                                    <td align="left" colspan="3">
                                        <asp:TextBox runat="server" Text="" ID="txtDocketNo" Width="350px" />
                                        <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                                    </td>
                                </tr>
                                <tr bgcolor="white" id="trPL_1" runat="server" style="display: none">
                                    <td align="left">
                                        <font class="blackfnt">Vendor</font>
                                    </td>
                                    <td align="left" colspan="3">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txtPLPartner" runat="server" MaxLength="10" Width="100px" CssClass="ltxtm"
                                                        TabIndex="3" autocomplete="off"></asp:TextBox><asp:TextBox ID="txtPLPartnernm" Width="250px"
                                                            CssClass="ltxtm" runat="server" Enabled="false"></asp:TextBox><br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <xac:webxcomplete ID="xacPLPartner" runat="server" CodeTarget="txtPLPartner" MinPrefixLength="2"
                                                        NameTarget="txtPLPartnernm" FilterString="03" WebxEntity="Vendor" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr bgcolor="white" id="trPL_2" runat="server" style="display: none">
                                    <td align="left">
                                        <font class="blackfnt">3PL No</font>
                                    </td>
                                    <td align="left" colspan="3">
                                        <asp:TextBox runat="server" Text="" ID="txtPLNo" Width="350px" />
                                        <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                                    </td>
                                </tr>
                                <tr align="center" class="bgbluegrey">
                                    <td colspan="7">
                                        <asp:Button ID="btnShow" OnClick="btnShow_Click" runat="server" Text="Submit" Width="75px"
                                            CssClass="fbtn" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
