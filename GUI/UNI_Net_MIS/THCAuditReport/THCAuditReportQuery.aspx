<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="THCAuditReportQuery.aspx.cs" Inherits="GUI_Operations_THCAudit_THCAuditReportQuery" %>


<%@ Register TagName="HR" TagPrefix="Location" Src="~/GUI/Common_UserControls/LOC_HRCHY.ascx" %>
<%@ Register TagName="HR_To" TagPrefix="Location_To" Src="~/GUI/Common_UserControls/LOC_HRCHY_TO.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" language="JavaScript" src="../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

    </script>

    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Oprations</strong></font><font class="bluefnt"><strong>
                            &gt; </strong><strong>THC Audit Module</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../images/clear.gif" alt="" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                    <div align="center">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>

                </td>
            </tr>
            <tr>
                <td height="300" valign="top">
                    <table cellspacing="1" style="width: 9.5in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="2">
                                <font class="blackfnt"></font>
                            </td>
                            <td colspan="2">
                                <font class="blackfnt"><b>Select Criteria</b></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="2">
                                <font class="blackfnt">Branch Name</font>
                            </td>
                            <td align="left" colspan="2">
                <asp:DropDownList ID="cboLoc" runat="server" AutoPostBack="false" EnableViewState="true"
                    DataTextField="LocName" DataValueField="LocCode" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="2">
                                <font class="blackfnt">Select Date</font>
                            </td>
                            <td align="left" colspan="2">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center" colspan="4">
                                <font class="blackfnt">OR</font>
                            </td>
                           
                        </tr>
                        <tr style="background-color: white; ">
                            <td align="left" colspan="2">
                                <font class="blackfnt">THC No.</font>
                            </td>
                            <td align="left" colspan="2">
                                <asp:TextBox runat="server" Text="" ID="txtTHCno" Width="250"> </asp:TextBox>
                            </td>
                        </tr>
                         <tr style="background-color: white; ">
                            <td align="left" colspan="2">
                                <font class="blackfnt">Status</font>
                            </td>
                            <td align="left" colspan="2">
                                <asp:DropDownList runat="server" ID="ddlStatus">
                                    <asp:ListItem Text="--All--" Value="0"/>
                                    <asp:ListItem Text="Audited" Value="Audited"/>
                                    <asp:ListItem Text="Pending" Value="Pending"/>
                                       <asp:ListItem Text="Pending In Deviation" Value="InDeviation"/>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="4"></td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="4">
                                <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" runat="server" Text="Submit" Width="100px" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
