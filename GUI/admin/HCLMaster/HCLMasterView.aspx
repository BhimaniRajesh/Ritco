<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="HCLMasterView.aspx.cs" Inherits="GUI_admin_HCLMaster_HCLMasterView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script src="../../images/commonJs.js" type="text/javascript"></script>
    <script src="JS/HCLMaster.js?V011" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("divDate");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

       <%-- var serviceUrl = '<%=ResolveClientUrl("../../../RestService/HCLMaster.svc")%>';--%>
        var serviceUrl = '<%=ResolveClientUrl("~/RestService/HCLMasterService.svc")%>';
        var empCode = '<%= SessionUtilities.CurrentEmployeeID %>';
        var currentDate = '<%=SessionUtilities.Now.ToString("dd/MM/yyyy")%>';
        var currentTime = '<%=SessionUtilities.Now.ToString("HH:mm")%>';
        var companyCode = '<%= SessionUtilities.DefaultCompanyCode %>';
     
    </script>


    <div style="width: 10in">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 50px">
            <tr>
                <td>
                    <font class="blackfnt"><a href=""><b><u>Module </u></b></a>&gt; <a href="../../welcome.aspx">
                        <b><u>Administrator </u></b></a>&gt; <a href="../company_structure.aspx"><b><u>Company
                            Structure </u></b></a>&gt; <b><u>HCL Master </u></b></font>
                    <td>
                        <a href="javascript:window.history.go(-1)" title="back">
                            <img src="../../images/back.gif" border="0" alt="" /></a>
                    </td>
            </tr>
        </table>
        <table border="0" width="100%" cellpadding="1" cellspacing="1" class="boxbg">
            <tr class="bgbluegrey">
                <td align="center" style="height: 21px">
                    <font class="blackfnt"><b>HCL MASTER</b></font>
                </td>
            </tr>
        </table>
        <asp:UpdatePanel runat="server" UpdateMode="Conditional" ID="up1">
            <ContentTemplate>
                  <UserControl:UserMessage runat="server" ID="UserMessage" />
                <table border="1" width="100%">
                    <!--Row 1-->
                    <tr bgcolor="#ffffff">
                        <td align="left" colspan="2">
                            <font class="blackfnt">Select Branch</font>
                        </td>
                        <td align="left" colspan="3" style="display: inline">
                            <asp:TextBox runat="server" ID="txtBranchcode" onblur="javascript:return IsBranchExist(this);" MaxLength="10"></asp:TextBox>
                            <asp:HiddenField ID="hdnBranch" runat="server" />
                        </td>
                    </tr>
                    <tr class="hrow">
                        <td align="center" colspan="5">
                            <asp:Button runat="server" ID="btnGetData" Text="View" OnClick="btnGetData_Click" />
                            <%-- <input type="button" value="View Data" class="btn btn-primary" id="btnViewData" onclick="javascript: ViewData();" />--%>
                        </td>
                    </tr>
                    <!--Row 2-->


                    <table border="1" width="100%" runat="server" id="tblMain">
                         <tr class="hrow">
                            <td>
                                <font class="blackfnt"><b>Document Type</b></font>
                            </td>
                            <td>
                                <font class="blackfnt"><b>Type</b></font>
                            </td>
                            <td>
                                <font class="blackfnt"><b>Rate</b></font>
                            </td>
                            <td>
                                <font class="blackfnt"><b>From Date</b></font>
                            </td>
                            <td>
                                <font class="blackfnt"><b>To Date</b></font>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">Outgoing THC
                            </td>
                            <td align="left">
                                <asp:Label runat="server" ID="lblOutgoingTHCType"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:Label runat="server" ID="lblOutgoingTHCRate"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:Label runat="server" ID="lblOutgoingTHCFromDate"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:Label runat="server" ID="lblOutgoingTHCToDate"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">Incoming THC
                            </td>
                            <td align="left">
                                <asp:Label runat="server" ID="lblIncomingTHCType"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:Label runat="server" ID="lblIncomingTHCRate"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:Label runat="server" ID="lblIncomingTHCFromDate"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:Label runat="server" ID="lblIncomingTHCToDate"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">DDMR
                            </td>
                            <td align="left">
                                <asp:Label runat="server" ID="lblDDMRType"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:Label runat="server" ID="lblDDMRRate"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:Label runat="server" ID="lblDDMRFromDate"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:Label runat="server" ID="lblDDMRToDate"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">MR
                            </td>
                            <td align="left">
                                <asp:Label runat="server" ID="lblMRType"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:Label runat="server" ID="lblMRRate"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:Label runat="server" ID="lblMRFromDate"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:Label runat="server" ID="lblMRToDate"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </table>
            </ContentTemplate>
            <Triggers>
            </Triggers>
        </asp:UpdatePanel>
    </div>
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
    </div>

</asp:Content>

