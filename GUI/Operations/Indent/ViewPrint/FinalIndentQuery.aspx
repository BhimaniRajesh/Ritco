<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="FinalIndentQuery.aspx.cs" Inherits="GUI_Operations_Indent_IndentView_FinalIndentQuery" %>

<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagPrefix="PgBar" TagName="ProgressBar" %>
<%@ Register Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" TagPrefix="Location" TagName="LH" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_DateWithYesterDay.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" type="text/javascript" src="../../../Images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript">
        function ViewPrint(IndNo) {
            window.open("FinalIndentDetails.aspx?IndentNo=" + IndNo, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
        function ViewPrintGrWise(GrNo,IndNo) {
            window.open("FinalGrDetails.aspx?GrNumber=" + GrNo + "&IndentNo=" + IndNo, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
    </script>
    <script type="text/javascript" language="JavaScript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>
    <table cellspacing="1" style="width: 50%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server" Text="Final Indent"></asp:Label>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <div>
        <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="50%">
            <tr class="bgbluegrey">
                <td align="center" colspan="2">
                    <asp:Label ID="lblHeader" runat="server" Font-Bold="true" Text="Final Indent" CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            <tr class="bgwhite">
                <td align="left">Select Location
                </td>
                <td>
                    <Location:LH ID="Fromlc" runat="server" />
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
                    <asp:RadioButtonList ID="rblIndentGrWise" runat="server" >
                        <asp:ListItem Text="Indent Wise" Value="rbIndentWise" Selected="True" />
                        <asp:ListItem Text="GR Wise" Value="rbGrWise" />
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr class="bgwhite blackboldfnt">
                <td align="center" colspan="2">OR
                </td>
            </tr>
            <tr class="bgwhite">
                <td align="left">
                    <asp:Label runat="server" ID="lblIndentNo" Text="Select IndentNumber"></asp:Label>
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtIndentNo" Width="300px"></asp:TextBox>
                </td>
            </tr>

            <tr class="bgwhite blackboldfnt">
                <td align="center" colspan="2">OR
                </td>
            </tr>
            <tr class="bgwhite">
                <td align="left">
                    Select Gr Number
                </td>
                <td align="left">
                    <asp:TextBox runat="server" ID="txtGrNo" Width="300px"></asp:TextBox>
                    <font color="red" >Insert upto ten Gr separated by comma</font>
                </td>
            </tr>

            <tr class="bgbluegrey">
                <td align="center" colspan="2">
                    <asp:Button runat="server" ID="btnSubmit" Text="Submit" Width="100px" OnClick="btnSubmit_Click" />
                </td>
            </tr>

            <tr bgcolor="white">
                <td id="trrepeter" runat="server" class="blackfnt" colspan="3" style="display: none">
                    <table class="boxbg" border="0" cellpadding="3" cellspacing="1" style="width: 100%;">
                        <tr align="center" class="bgbluegrey blackboldfnt">
                            <td>Sl.No</td>
                            <td>Date</td>
                            <td>Indent Number</td>
                            <td></td>
                        </tr>
                        <asp:Repeater ID="rptFinnalIndentList" runat="server">
                            <ItemTemplate>
                                <tr class="bgwhite">

                                    <td align="center">
                                        <%#Container.ItemIndex+1 %> 
                                    </td>
                                    <td align="center">
                                        <asp:Label ID="lblDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"IndentDate")%>'></asp:Label>
                                    </td>
                                    <td align="center">
                                        <asp:Label ID="lblIndentNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"IndentNumber")%>'></asp:Label>
                                    </td>
                                    <td align="center">
                                        <a href="Javascript:ViewPrint('<%# DataBinder.Eval(Container.DataItem,"IndentNumber")%>',0)"><b>View</b></a>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                </td>
            </tr>


            <tr bgcolor="white">
                <td id="trrepeterGr" runat="server" class="blackfnt" colspan="3" style="display: none">
                    <table class="boxbg" border="0" cellpadding="3" cellspacing="1" style="width: 100%;">
                        <tr align="center" class="bgbluegrey blackboldfnt">
                            <td>Sl.No</td>
                            <td>Date</td>
                            <td>Gr No</td>
                            <td>Indent Number</td>
                            <td></td>
                        </tr>
                        <asp:Repeater ID="rptFinnalGrList" runat="server">
                            <ItemTemplate>
                                <tr class="bgwhite">

                                    <td align="center">
                                        <%#Container.ItemIndex+1 %> 
                                    </td>
                                    <td align="center">
                                        <asp:Label ID="lblDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"IndentDate")%>'></asp:Label>
                                    </td>
                                    <td align="center">
                                        <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DocketNumber")%>'></asp:Label>
                                    </td>
                                    <td align="center">
                                        <asp:Label ID="lblIndentNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"IndentNumber")%>'></asp:Label>
                                    </td>
                                    <td align="center">
                                        <a href="Javascript:ViewPrintGrWise('<%# DataBinder.Eval(Container.DataItem,"DocketNumber")%>','<%# DataBinder.Eval(Container.DataItem,"IndentNumber")%>',0)"><b>View</b></a>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <PgBar:ProgressBar runat="server" ID="ProgressBar" />
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;"></div>
</asp:Content>
