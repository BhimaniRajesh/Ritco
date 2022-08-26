<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="HCLMasterEdit.aspx.cs" Inherits="GUI_admin_HCLMaster_HCLMasterEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
 
    <script src="../../images/commonJs.js" type="text/javascript"></script>
    <script src="JS/HCLMaster.js?V11" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("divDate");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        var serviceUrl = '<%=ResolveClientUrl("~/RestService/HCLMasterService.svc")%>';
        var empCode = '<%= SessionUtilities.CurrentEmployeeID %>';
        var currentDate = '<%=SessionUtilities.Now.ToString("dd/MM/yyyy")%>';
        var currentTime = '<%=SessionUtilities.Now.ToString("HH:mm")%>';
        var companyCode = '<%= SessionUtilities.DefaultCompanyCode %>';

        //function Validate() {
        //    if (txtBranchcode.val() == "") {
        //        alert("Please Enter Branch.");
        //        txtBranchcode.focus();
        //        return false;
        //    }
        //    return true;
        //}
     
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
        <asp:UpdatePanel runat="server" UpdateMode="Conditional" ID="up1">
            <ContentTemplate>
                 <UserControl:UserMessage runat="server" ID="UserMessage" />
                <table border="0" width="100%" cellpadding="1" cellspacing="1" class="boxbg">
                    <tr class="bgbluegrey">
                        <td align="center" style="height: 21px">
                            <font class="blackfnt"><b>HCL MASTER</b></font>
                        </td>
                    </tr>
                </table>

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
                            <asp:Button runat="server" ID="btnGetData" Text="Get Data" OnClick="btnGetData_Click" />
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
                                <asp:DropDownList runat="server" ID="ddlOutgoingTHCType"></asp:DropDownList>
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="txtOutgoingTHCRate" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Text="0.00" Style="text-align: right"></asp:TextBox>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtOutgoingTHCFromDate" runat="Server" Width="100"></asp:TextBox>&nbsp;
                    <a href="#" onclick="cal.select(ctl00_MyCPH1_txtOutgoingTHCFromDate, 'CaltxtOutgoingTHCFromDate', 'dd/MM/yyyy'); return false;"
                        id="CaltxtOutgoingTHCFromDate">
                        <img src="../../images/calendar.jpg" border="0" />
                    </a>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtOutgoingTHCToDate" runat="Server" Width="100" onblur="javascript:return IscheckDate(this);"></asp:TextBox>&nbsp;
                    <a href="#" onclick="cal.select(ctl00_MyCPH1_txtOutgoingTHCToDate, 'CaltxtOutgoingTHCToDate', 'dd/MM/yyyy'); return false;"
                        id="CaltxtOutgoingTHCToDate">
                        <img src="../../images/calendar.jpg" border="0" />
                    </a>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">Incoming THC
                            </td>
                            <td align="left">

                                <asp:DropDownList runat="server" ID="ddlIncomingTHCType"></asp:DropDownList>
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="txtIncomingTHCRate" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Text="0.00" Style="text-align: right"></asp:TextBox>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtIncomingTHCFromDate" runat="Server" Width="100"></asp:TextBox>&nbsp;
                                <a href="#" onclick="cal.select(ctl00_MyCPH1_txtIncomingTHCFromDate, 'CaltxtIncomingTHCFromDate', 'dd/MM/yyyy'); return false;"
                                    id="CaltxtIncomingTHCFromDate">
                                    <img src="../../images/calendar.jpg" border="0" />
                                </a>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtIncomingTHCToDate" runat="Server" Width="100" onblur="javascript:return IscheckDate(this);"></asp:TextBox>&nbsp;
                                <a href="#" onclick="cal.select(ctl00_MyCPH1_txtIncomingTHCToDate, 'CaltxtIncomingTHCToDate', 'dd/MM/yyyy'); return false;"
                                    id="CaltxtIncomingTHCToDate">
                                    <img src="../../images/calendar.jpg" border="0" />
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">DDMR
                            </td>
                            <td align="left">

                                <asp:DropDownList runat="server" ID="ddlDDMRType"></asp:DropDownList>
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="txtDDMRRate" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Text="0.00" Style="text-align: right"></asp:TextBox>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtDDMRFromDate" runat="Server" Width="100"></asp:TextBox>&nbsp;
                                <a href="#" onclick="cal.select(ctl00_MyCPH1_txtDDMRFromDate, 'CaltxtDDMRFromDate', 'dd/MM/yyyy'); return false;"
                                    id="CaltxtDDMRFromDate">
                                    <img src="../../images/calendar.jpg" border="0" />
                                </a>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtDDMRToDate" runat="Server" Width="100" onblur="javascript:return IscheckDate(this);"></asp:TextBox>&nbsp;
                                <a href="#" onclick="cal.select(ctl00_MyCPH1_txtDDMRToDate, 'CaltxtDDMRToDate', 'dd/MM/yyyy'); return false;"
                                    id="CaltxtDDMRToDate">
                                    <img src="../../images/calendar.jpg" border="0" />
                                </a>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">MR
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="ddlMRType"></asp:DropDownList>
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="txtMRRate" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))" Text="0.00" Style="text-align: right"></asp:TextBox>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtMRFromDate" runat="Server" Width="100"></asp:TextBox>&nbsp;
                                <a href="#" onclick="cal.select(ctl00_MyCPH1_txtMRFromDate, 'CaltxtMRFromDate', 'dd/MM/yyyy'); return false;"
                                    id="CaltxtMRFromDate">
                                    <img src="../../images/calendar.jpg" border="0" />
                                </a>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtMRToDate" runat="Server" Width="100" onblur="javascript:return IscheckDate(this);"></asp:TextBox>&nbsp;
                                <a href="#" onclick="cal.select(ctl00_MyCPH1_txtMRToDate, 'CaltxtMRToDate', 'dd/MM/yyyy'); return false;"
                                    id="CaltxtMRToDate">
                                    <img src="../../images/calendar.jpg" border="0" />
                                </a>
                            </td>
                        </tr>
                        <tr align="center" class="hrow">
                            <td colspan="5">
                                <asp:Button runat="server" ID="btnUpdate" Text="Update" OnClick="btnUpdate_Click" OnClientClick="javascript:return IscheckDate(this);" />
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

