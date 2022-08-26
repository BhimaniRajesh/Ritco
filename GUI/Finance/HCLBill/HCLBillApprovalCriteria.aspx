<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="HCLBillApprovalCriteria.aspx.cs" Inherits="GUI_Finance_HCLBill_HCLBillApprovalCriteria" %>

<%@ Register TagPrefix="UserControl" TagName="DateRange" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
 
 <script src="../../images/commonJs.js" type="text/javascript"></script>
 <script src="../../admin/HCLMaster/JS/HCLMaster.js?V1" type="text/javascript"></script>
 <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("divDate");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        var serviceUrl = '<%=ResolveClientUrl("~/RestService/HCLMasterService.svc")%>';
         var empCode = '<%= SessionUtilities.CurrentEmployeeID %>';
        var currentDate = '<%=SessionUtilities.Now.ToString("dd/MM/yyyy")%>';
        var currentTime = '<%=SessionUtilities.Now.ToString("HH:mm")%>';
        var companyCode = '<%= SessionUtilities.DefaultCompanyCode %>';
    </script>

    <div style="width: 800px;">
        <table class="stbl" cellspacing="1" cellpadding="3" style="width: 900px" id="tblCriteria" runat="server">
            <tr class="hrow">
                <td colspan="2" align="center">
                    <b>HCL Bill Pending Approval</b>
                    <UserControl:UserMessage runat="server" ID="UserMessage" />
                </td>
            </tr>
            
            <tr class="nrow">
                <td>
                    <b>Branch Name</b>
                </td>
                <td>
                    <asp:TextBox runat="server" ID="txtBranchcode" onblur="javascript:return IsBranchExist(this);" MaxLength="10" ></asp:TextBox>
                    <asp:HiddenField id="hdnBranch" runat="server" />
                </td>
            </tr>
            <tr class="nrow" id="trDate">
                <td><b>Select Date Range</b></td>
                <td align="left">
                    <UserControl:DateRange ID="dtBookingDate" runat="server" />
                </td>
            </tr>
            <tr class="nrow" >
                <td colspan="2"  align="center">Or</td>
            </tr>
            <tr class="nrow">
              <td><b>Bill Number</b></td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtBillNo"></asp:TextBox>
                </td>
            </tr>

            <tr class="hrow" id="trSubmit">
                <td align="center" colspan="3">
                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                </td>
            </tr>
        </table>
    </div>
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99; left: -74px; top: 1px;">
    </div>
</asp:Content>

