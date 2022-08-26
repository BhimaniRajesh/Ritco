<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_Fleet_Reports_TyreSale_Query" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script src="../../../images/commonJs.js" language="javascript" type="text/javascript"></script>
    <script src="../../../images/CalendarPopup.js" language="javascript" type="text/javascript"></script>
    <%--    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        //        function nwOpen1(mNo) {
        //            window.open("./PopupSKU.aspx?" + mNo, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        //        }
        
    </script>--%>
    <script language="javascript" type="text/javascript">
        function OnSubmit() {
            //debugger;
            var ddlVhno = document.getElementById("ctl00$MyCPH1$ddlVhno");

            if (ddlVhno.value == "0") {
                alert("select Vehicle No.");
                ddlVhno.focus();
                return false;
            }
        }
    </script>
    <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" Font-Bold="true" Text="Individual Tyre Register"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <hr align="left" size="1" color="#8ba0e5" />
            </td>
        </tr>
        <tr>
            <td>
                <table width="700px" border="1" align="left" cellpadding="0" cellspacing="0" class="boxbg">
                    <tr class="bgbluegrey">
                        <td colspan="2" align="center">
                            <asp:Label ID="Label4" runat="server" Font-Bold="true" Text="Search Criteria"></asp:Label>
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td>
                            <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Select Location :"></asp:Label>
                        </td>
                        <td>
                            <Location:LH ID="Fromlc" runat="server" />
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td>
                            <asp:Label ID="Label3" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Select Vehicle No. :"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlVhno" runat="server" Width="200px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" valign="top">
                            <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Select Type :"></asp:Label>
                        </td>
                        <td valign="top">
                            <asp:DropDownList ID="ddlTyreType" runat="server" Width="200px">
                                <asp:ListItem Selected="True" Text="Current Tyres" Value="C"></asp:ListItem>
                                <asp:ListItem Text="All" Value="All"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td colspan="2" align="center">
                            <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                                OnClientClick="javascript:return OnSubmit()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <%--        <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
            layer-background-color: white; z-index: 99;">
        </div>--%>
</asp:Content>
