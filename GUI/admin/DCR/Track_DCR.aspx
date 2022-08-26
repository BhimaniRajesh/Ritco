<%@ Page  Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Track_DCR.aspx.cs" Inherits="GUI_admin_DCR_Track_DCR" %>

<%@ Register Src="../../Common_UserControls/MyMessageBox.ascx" TagName="MyMessageBox"
    TagPrefix="uc1" %>
<%@ Register Src="../../Common_UserControls/ProgressBar.ascx" TagName="ProgressBar"
    TagPrefix="uc2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div class="blackfnt">
        <table cellspacing="1" style="width: 100%">
            <tr style="background-color: white">
                <td align="left">
                    <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Track Series</asp:Label>
                    <hr align="center" size="1" color="#8ba0e5" />
                </td>
            </tr>
        </table>
        <br />
        <uc2:ProgressBar ID="ProgressBar1" runat="server" />
        <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <div id="dvFilter" runat="server">
                    <table cellspacing="1" cellpadding="2" class="boxbg" border="0" width="500">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center">
                                <b>Select Series to be managed</b>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td width="150">
                                Select Document Type:
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlDocType" runat="server" CssClass="blackfnt">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                Document Number:
                            </td>
                            <td>
                                <asp:TextBox ID="txtDocNo" runat="server" MaxLength="50" Width="200"></asp:TextBox>
                                <ajaxToolkit:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server"
                                    TargetControlID="txtDocNo" WatermarkCssClass="Watermark" WatermarkText="Please enter document number here..." />
                            </td>
                        </tr>
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" BorderStyle="Groove" Width="85"
                                    OnClick="btnSubmit_Click" />
                            </td>
                        </tr>
                    </table>
                    <br />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="updtDetail" runat="server" UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <div id="dvDetails" runat="server">
                    <table cellspacing="1" cellpadding="2" class="boxbg" border="0" width="500">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center">
                                <b>Series Summary</b>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td style="width: 100px">
                                Document type:
                            </td>
                            <td>
                                <asp:Label ID="lblDocType" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                Query number:
                            </td>
                            <td>
                                <asp:Label ID="lblQNo" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                Book number:
                            </td>
                            <td>
                                <asp:Label ID="lblBookCode" runat="server"></asp:Label>
                                <asp:HiddenField ID="hidDocKey" runat="server" />
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                Series start-end:
                            </td>
                            <td nowrap>
                                <asp:Label ID="lblFromTo" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                Total leaves:
                            </td>
                            <td>
                                <asp:Label ID="lblTotLeaves" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                Used leaves:
                            </td>
                            <td>
                                <asp:Label ID="lblUsedLeaves" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                Allocated to location:
                            </td>
                            <td>
                                <asp:Label ID="lblAllotedToLoc" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                Allocated to person:
                            </td>
                            <td>
                                <asp:Label ID="lblAllotedToPer" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                Allocated person category:
                            </td>
                            <td>
                                <asp:Label ID="lblAllotedType" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                Hierarchy of that location:
                            </td>
                            <td>
                                <asp:Label ID="lblLocHierarchy" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                Status:
                            </td>
                            <td>
                                <asp:Label ID="lblStatus" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table cellspacing="0" cellpadding="0" border="0">
                        <tr class="bgbluegrey" height="21px">
                            <td colspan="2" align="center" valign=middle>
                                <b>Series Management History</b>
                                <hr align="center" size="1" style="color:#FFFFFF;" />
                            </td>
                        </tr>
                        <tr class="bgwhite">
                            <td>
                                <asp:GridView ID="gvResult" runat="server" AutoGenerateColumns="false" AllowPaging="false"
                                    BorderWidth="0" AllowSorting="false" CssClass="boxbg" HeaderStyle-CssClass="dgHeaderStyle"
                                    RowStyle-CssClass="dgRowStyle" CellPadding="2" CellSpacing="1" GridLines="None">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sr.No.">
                                            <ItemTemplate>
                                                <font class="blackfnt">
                                                    <%# Container.DataItemIndex + 1%></font>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField HeaderText="Action" DataField="Action_Desc" />
                                        <asp:BoundField HeaderText="Date" DataField="Action_Date" />
                                        <asp:BoundField HeaderText="Book Number" DataField="Book_Number" />
                                        <asp:BoundField HeaderText="Series Start-End" DataField="FROM_TO" />
                                        <asp:BoundField HeaderText="Allocation Location" DataField="Alloted_Loc" />
                                        <asp:BoundField HeaderText="Allocation Category" DataField="Alloted_Type_Desc" />
                                        <asp:BoundField HeaderText="Person" DataField="Alloted_To" />
                                    </Columns>
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <RowStyle HorizontalAlign="Center" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <table border="0" width="500">
                    <tr>
                        <td>
                            <uc1:MyMessageBox ID="msgBox" runat="server" ShowCloseButton="true" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSubmit" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>
