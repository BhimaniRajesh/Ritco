<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ProposedIndentCancel.aspx.cs" Inherits="GUI_Exception_Indent_ProposedIndentCancel" %>

<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagPrefix="PgBar" TagName="ProgressBar" %>
<%@ Register Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" TagPrefix="LH" TagName="Location" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script type="text/javascript" language="javascript" src="Indent.js"></script>
<script language="JavaScript"  type="text/javascript" src="../../images/CalendarPopup.js"></script>
<script language="javascript"  type="text/javascript" src="../../images/commonJs.js"></script>
<script type="text/javascript" language="JavaScript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
</script>
    
    <asp:UpdatePanel ID="updone" runat="server" UpdateMode="Conditional" RenderMode="Inline">
        <ContentTemplate>
            <table cellspacing="1" style="width: 100%">
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server" Text="Exception >> Operation > Indent Cancellation"></asp:Label>
                    </td>
                </tr>
            </table>
            <div id="divIndentCancelCriteria" runat="server">
                <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="50%">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="2">
                            <asp:Label ID="lblHeader" runat="server" Font-Bold="true" Text="Cancellation of Indent" CssClass="blackfnt"></asp:Label>
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
                    <tr class="bgbluegrey">
                        <td align="center" colspan="2">
                            <asp:Button runat="server" ID="btnSubmit" Text="Submit" Width="100px" OnClick="btnSubmit_Click" OnClientClick="SubmitOnCancellationListing()" />
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divIndentCancelResult" runat="server" visible="false">
                <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="50%">
                    <tr bgcolor="white">
                        <td class="blackfnt" colspan="3">
                            <table class="boxbg" border="0" cellpadding="3" cellspacing="1" style="width: 100%;">
                                <tr align="center" class="bgbluegrey blackboldfnt">
                                    <td>Sl.No</td>
                                    <td>Indent Number</td>
                                    <td>Action</td>
                                </tr>
                                <asp:Repeater ID="rptFinnalIndentDktPendingList" runat="server">
                                    <ItemTemplate>
                                        <tr class="bgwhite">
                                            <td align="center">
                                                <%#Container.ItemIndex+1 %> 
                                            </td>
                                            <td align="center">
                                                <asp:Label ID="lblIndentNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"IndentNumber")%>'></asp:Label>
                                            </td>
                                            <td align="center">
                                                <asp:LinkButton ID="lnkbtnCancelIndent" runat="server" OnCommand="lnkbtnCancelIndent_Command" CommandName="CancelIndent" CommandArgument='<%# Eval("IndentNumber") %>'>Cancel</asp:LinkButton>
                                                <asp:HiddenField ID="hdnIndentNumber" runat="server" Value='<%# Eval("IndentNumber") %>' />
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divIndentCancelUpdate" runat="server" visible="false">
                <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="50%">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="2">
                            <asp:Label ID="lblHeaderCancellation" runat="server" Font-Bold="true" Text="Cancellation of Indent" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td align="left">Indent Number
                        </td>
                        <td>
                            <asp:Label ID="lblIndentNumber" runat="server" Font-Bold="true" Text="Cancellation of Indent" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td align="left">Enter the Date of Cancellation 

                        </td>
                        <td>
                            <asp:TextBox ID="txtCanceldate" runat="server" MaxLength="10" Width="65" BorderStyle="Groove"
                                CssClass="blackfnt"></asp:TextBox>
                            <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtCanceldate,'anchor1','dd/MM/yyyy'); return false;"
                                name="anchor1" id="anchor1">
                                <img src="../../images/calendar.jpg" border="0" />
                            </a>
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td align="left">Enter the reason of cancellation of Indent
                        </td>
                        <td>
                            <asp:TextBox ID="txtCancelReason" runat="server"
                                CssClass="ltxt" autocomplete="off" Width="200px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td align="center" colspan="2">
                            <asp:Button runat="server" ID="btnSubmitCancel" Text="Submit" Width="100px" OnClick="btnSubmitCancel_Click" OnClientClick="SubmitOnCancellation()" />
                        </td>
                    </tr>
                </table>
            </div>
            <PgBar:ProgressBar runat="server" ID="ProgressBar" />
        </ContentTemplate>
    </asp:UpdatePanel>
<div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;layer-background-color: white; z-index: 99;"></div>   
</asp:Content>
