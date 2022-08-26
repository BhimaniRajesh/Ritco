<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ExecutionIndentViewQuery.aspx.cs"
    Inherits="GUI_Operations_Indent_ViewPrint_ExecutionIndentViewQuery" %>

<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagPrefix="PgBar" TagName="ProgressBar" %>
<%@ Register Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" TagPrefix="LH" TagName="Location" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_DateWithYesterDay.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" type="text/javascript" src="../../../Images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>
    <script type="text/javascript" language="javascript" src="Indent.js"></script>
    <script language="javascript" type="text/javascript">
        function printPage() {
            var prtContent = document.getElementById("ctl00_MyCPH1_divExecutionIndentDetails");
            var btnPrint = document.getElementById("ctl00_MyCPH1_btnPrint")
            btnPrint.style.display = 'none';
            var WinPrint = window.open('', '', 'letf=0,top=05,width=1500,height=600,toolbar=0,scrollbars=0,status=0,dir=ltr');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            //WinPrint.close();
        }
    </script>
    <script type="text/javascript" language="JavaScript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>

            <div id="divExecutionIndentHdr" runat="server">
                <table cellspacing="1" style="width: 100%">
                    <tr style="background-color: white">
                        <td align="left">
                            <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server" Text="Exception >> Operation > Execution Indent View"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divExecutionIndentCriteria" runat="server">
                <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="50%">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="2">
                            <asp:Label ID="lblHeader" runat="server" Font-Bold="true" Text="Execution Indent View" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td align="left">Select Date
                        </td>
                        <td>
                            <Date:DT ID="DT" runat="server" />
                        </td>
                    </tr>
                    <tr class="bgwhite">
                <td></td>
                <td align="left">
                    <asp:RadioButtonList ID="rblAllDeliveredPending" runat="server" >
                        <asp:ListItem Text="All" Value="rbAll" Selected="True" />
                        <asp:ListItem Text="Delivered" Value="rbDelivered" />
                        <asp:ListItem Text="Pending" Value="rbPending" />
                    </asp:RadioButtonList>
                </td>
            </tr>
                    <tr class="bgwhite">
                        <td align="center" colspan="2">OR
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td align="left">Enter Indent Number
                        </td>
                        <td>
                            <asp:TextBox ID="txtIndentNumber" runat="server"
                                CssClass="ltxt" autocomplete="off"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td align="center" colspan="2">OR
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td align="left">Enter Docket Number
                        </td>
                        <td>
                            <asp:TextBox ID="txtDocketNo" runat="server"
                                CssClass="ltxt" autocomplete="off"></asp:TextBox>
                            <font color="red" >Insert upto ten Gr separated by comma</font>
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td align="center" colspan="2">OR
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td align="left">Enter Deliver Party Name
                        </td>
                        <td>
                            <asp:TextBox ID="txtDiliverPartyname" runat="server"
                                CssClass="ltxt" autocomplete="off"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td align="center" colspan="2">OR
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td align="left">Enter Billing Party Name
                        </td>
                        <td>
                            <asp:TextBox ID="txtBillingPartyname" runat="server"
                                CssClass="ltxt" autocomplete="off"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td align="center" colspan="2">
                            <asp:Button runat="server" ID="btnSubmit" Text="Submit" Width="100px" OnClick="btnSubmit_Click" />
                        </td>
                    </tr>
                </table>
            </div>
            <PgBar:ProgressBar runat="server" ID="ProgressBar" />

    <asp:HiddenField ID="hdnflagprint" runat="server" />
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;"></div>
</asp:Content>
