<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="JobOrderTracker.aspx.cs" Inherits="GUI_Fleet_Reports_JobOrderTrackerReport_JobOrderTracker" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
     <script language="javascript" type="text/javascript">
         function OpenPopupWindow()
         {
             //alert('Test');
             //var txt = document.getElementById("ctl00_MyCPH1_txtJONumber");
             var JONo = document.getElementById("ctl00_MyCPH1_txtJONumber").value;
             //alert(JONo);
             var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
             var strPopupURL = "JobOrderTrackerView.aspx?JONO=" + JONo;
             winNew = window.open(strPopupURL, "_blank", strWinFeature)
         }
         
    </script>
     <table style="width: 9.5in" border="0" align="left" cellpadding="3" cellspacing="1"
        bgcolor="#808080" class="boxbg">
        <tr class="bgbluegrey">
            <td colspan="3" align="center"><b>Job Order Tracker</b>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td valign="top">
                <font class="blackfnt">
                    <asp:Label ID="lbljONumber" CssClass="blackfnt" runat="server" Text="JobSheet Number"></asp:Label>
                </font>
            </td>
            <td valign="top" align="left">
                <asp:TextBox ID="txtJONumber" runat="server" Width="180px" MaxLength="50" CssClass="ltxtm" Enabled="true" >
                </asp:TextBox>
            </td>
            <td align="center">
                <%--<asp:Button ID="btnsubmit" CssClass="fbtn" runat="server" Text="Submit" OnClientClick="Javascript: return OpenPopupWindow();"/>--%>
                <asp:Button ID="btnsubmit" CssClass="fbtn" runat="server" Text="Submit" OnClick="btnShow_Click"/>
            </td>
        </tr>
    </table>
</asp:Content>

