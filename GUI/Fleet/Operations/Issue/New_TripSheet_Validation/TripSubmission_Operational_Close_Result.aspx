<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TripSubmission_Operational_Close_Result.aspx.cs" MasterPageFile="~/GUI/MasterPage.master" Inherits="GUI_Fleet_Operations_Issue_New_TripSheet_Validation_TripSubmission_Operational_Close_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript">

        function ViewPrint(tTripSheetNo, tPrintMode) {

            var strurl = "frmViewPrintVehicleIssueSlipV2.aspx?VSlipNO=" + tTripSheetNo + "&PrintMode=" + tPrintMode
            popup = window.open(strurl, "", "height=475,width=850,scrollbars=yes,left=100,top=125");
        }

        function ViewPrintPay(tVSlipId, tPrintMode) {
            //alert("advance");
            var strurl = "DebitVoucherView.aspx?voucherno=" + tVSlipId + "&PrintMode=" + tPrintMode
            popup = window.open(strurl, "", "height=475,width=850,scrollbars=yes,left=100,top=125");
        }

    </script>

    
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Trip Submission >> Send for Approval </asp:Label>
                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server">Submitted</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br>

    <table border="0" class="boxbg" cellpadding="2" cellspacing="1" width="50%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <asp:Label ID="lblHeader" runat="server" Font-Bold="true" Text="Send for Approval is Done Successfully..…" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        <tr style="background-color:White">
            <td align="center"> 
                <asp:Label ID="lblmsg" runat="server"  CssClass="blackfnt"></asp:Label>
            </td>
            
        </tr>

     

    </table>

</asp:Content>