<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_Fleet_Reports_Tyre_ExceptionReport_Query" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script src="../../../images/commonJs.js" language="javascript" type="text/javascript"></script>
    <script src="../../../images/CalendarPopup.js" language="javascript" type="text/javascript"></script>
    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        //        function nwOpen1(mNo) {
        //            window.open("./PopupSKU.aspx?" + mNo, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        //        }
        
    </script>
    <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" Font-Bold="true" Text="Tyre Exception Report"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <hr align="left" size="1" color="#8ba0e5">
            </td>
        </tr>
        <tr>
            <td>
                <table width="700px" border="1" align="left" cellpadding="0" cellspacing="0" class="boxbg">
                    <tr style="background-color: white">
                        <td>
                            <asp:Label ID="Label6" runat="server" Font-Bold="true" Text="Select Location :"></asp:Label>
                        </td>
                        <td align="left">
                            <Location:LH ID="Fromlc" runat="server" />
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" valign="top">
                            <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Select Date :"
                                Width="102px"></asp:Label>
                        </td>
                        <td valign="top">
                            <Date:DT ID="DT" runat="server" EnableTillDate="true" />
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td>
                            <asp:Label ID="Label3" runat="server" CssClass="blackfnt" Font-Bold="true" Text=" Select Vehicle"
                                Width="102px"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlVEHNO" runat="server" Width="150px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td colspan="2" align="center">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
            layer-background-color: white; z-index: 99;">
        </div>
    </table>
</asp:Content>
