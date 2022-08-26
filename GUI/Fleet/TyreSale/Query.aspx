<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="GUI_Fleet_Reports_TyreSale_Query" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <script src="../../../images/commonJs.js" language="javascript" type="text/javascript"></script>
    <script src="../../../images/CalendarPopup.js" language="javascript" type="text/javascript"></script>
    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
        
    </script>
            <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
            layer-background-color: white; z-index: 99;">
        </div>
    <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" Font-Bold="true" Text="Tyre Sale Register"></asp:Label>
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
                <tr class="bgbluegrey">
                <td align="center" colspan="2">
                 <asp:Label ID="Label3" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Search Criteria"
                                Width="102px"></asp:Label>
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
                    <tr class="bgbluegrey">
                        <td colspan="2" align="center">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" 
                                onclick="btnSubmit_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

    </table>
</asp:Content>

