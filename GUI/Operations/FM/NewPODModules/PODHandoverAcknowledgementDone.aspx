<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="PODHandoverAcknowledgementDone.aspx.cs" Inherits="GUI_Operations_FM_NewPODModules_PODHandoverAcknowledgementDone" %>
<%@ Register Src="~/GUI/Common_UserControls/UserMessage.ascx" TagPrefix="xac" TagName="UserMessage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="JavaScript" type="text/javascript">
        
        function ViewPrint() {
            var PDHNo = '<%= poCode%>';
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50";
            var strPopupURL = "PODHandover_ViewPrint.aspx?PDHNo=" + PDHNo;
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
    </script>
    <xac:UserMessage runat="server" ID="UserMessage" />
    <table cellspacing="2" style="width: 900px">
        <tr style="background-color: white">
            <td align="left" style="width: 50%">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">POD Handover Result:</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
            <td align="left">
                <font class="blackfnt">&nbsp;</font>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="left">
                <table cellspacing="2" cellpadding="3" class="boxbg" style="width: 900px">
                    <tr class="bgbluegrey">
                        <td align="left" style="width: 50%" colspan="2">
                            <font class="blackfnt"><b><asp:Label ID="lblTitle" runat="server" Text=""></asp:Label></b></font>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <font class="blackfnt"><b><asp:Label ID="lblPODNo" runat="server" ></asp:Label></b></font>
                        </td>
                        <td align="left">
                            <asp:Label ID="lblview" runat="server" Text="View & Print" Font-Underline="true" onclick="ViewPrint()" style="cursor:pointer"></asp:Label>
                        </td>
                    </tr>
                    <%--<tr style="background-color: white">
                        <td align="left" colspan="2">
                            <font class="blackfnt"><a href="./PODHandoverCriteria.aspx"><u>Click here to go to Handover  POD module</u></a></font>
                        </td>
                    </tr>--%>
                </table>
            </td>
        </tr>

    </table>
</asp:Content>


