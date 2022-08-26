<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="JobOrderCloseApprove.aspx.cs" Inherits="GUI_Fleet_JobOrderClosure" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script src="../../images/CalendarPopup.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
        function ApproveCheck(chkApprove,ckhReject){ckhReject.checked = false;}
        function RejectCheck(chkApprove,ckhReject){chkApprove.checked = false;}
    </script>

    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Closed Jobsheet Approval</asp:Label>
            </td>
            <td align="right">
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                        <font class="blackfnt" color="red"><b>Please wait...</b></font>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </td>
        </tr>
    </table>
    <hr align="center" size="1" color="#8ba0e5">
    <br>
    <table cellspacing="1" style="width: 100%">
        <tr align="center">
            <td>
                <table cellspacing="1" cellpadding="2" style="width: 70%" class="boxbg">
                    <tr class="bgbluegrey">
                        <td colspan="2" align="center">
                            <asp:HiddenField ID="hfSMTPSrv" runat="server" />
                            <asp:HiddenField ID="hfFrom" runat="server" />
                            <asp:HiddenField ID="hfFromName" runat="server" />
                            <asp:HiddenField ID="hfFromContact" runat="server" />
                            <asp:HiddenField ID="hfTo" runat="server" />
                            <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <asp:Label ID="Label4" CssClass="blackfnt" runat="server" Font-Bold="True">Enter Job Order No.:</asp:Label>
                        </td>
                        <td align="left">
                            <asp:UpdatePanel ID="UpdatePanel4" RenderMode="Inline" UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:TextBox CssClass="input" ID="txtJobOrderNo" runat="Server" ValidationGroup="VGRequestID"
                                        BorderStyle="Groove"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtJobOrderNo"
                                        ErrorMessage="*" ValidationGroup="VGRequestID" />
                                </ContentTemplate>
                                <%--     <Triggers>
                                        <atlas:ControlEventTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                    </Triggers>--%>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td colspan="2" align="right">
                            <asp:UpdatePanel ID="UpdatePanel5" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btnShowSingleRequest" runat="server" Text="Submit" ValidationGroup="VGRequestID"
                                        OnClick="btnShowMultipleRequest_Click" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="center" colspan="2">
                            <asp:Label ID="Label5" CssClass="blackfnt" runat="server" Font-Bold="true">
                                OR
                            </asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" valign="top">
                            <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">Job Order Date Range:</asp:Label>
                        </td>
                        <td align="left">
                            <Date:DT ID="DT" EnableTillDate="true" runat="server" />
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <asp:Label ID="Label1" CssClass="blackfnt" runat="server" Font-Bold="True">Select Job Card Type:</asp:Label>
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="cboJobCardType" runat="server">
                            </asp:DropDownList>
                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="cboJobCardType"
                                    ErrorMessage="!" ValidationGroup="VGDtFromTo" CssClass="redfnt" />--%>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td colspan="2" align="right">
                            <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btnShowMultipleRequest" runat="server" Text="Submit" ValidationGroup="VGDtFromTo"
                                        OnClick="btnShowMultipleRequest_Click" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <br />
    <asp:UpdatePanel ID="u1" UpdateMode="Conditional" runat="server">
        <ContentTemplate>
            <table cellspacing="1" style="width: 85%" align="center">
                <tr>
                    <td>
                        <asp:GridView ID="gvJobOrder" runat="server" PageSize="1000" AutoGenerateColumns="False"
                            CellPadding="2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px"
                            CssClass="Styles.css" CellSpacing="1" Width="100%" Height="1px" ItemStyle-HorizontalAlign="Left"
                            OnRowDataBound="gvJobOrder_RowDataBound">
                            <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                            <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <PagerStyle HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5"
                                ForeColor="White" Wrap="False" CssClass="whitefnt"></PagerStyle>
                            <PagerSettings NextPageText="Next" PreviousPageText="Previous" Mode="Numeric" />
                            <RowStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                            <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False"
                                Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                            <Columns>
                                <asp:TemplateField HeaderText="Job Order No">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("JOB_ORDER_NO", "UpdateJob.aspx?OrderNo={0}") %>'
                                            Text='<%# Eval("JOB_ORDER_NO") %>'></asp:HyperLink>
                                        <asp:HiddenField ID="hf_EmailID_To" Value='<%# Eval("Email_To") %>' runat="server" />
                                        <asp:HiddenField ID="hf_EmailID_CC" Value='<%# Eval("Emaol_CC") %>' runat="server" />
                                    </ItemTemplate>
                                    <ControlStyle ForeColor="Blue" />
                                    <HeaderStyle HorizontalAlign="Left" Width="50px" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="JOB_ORDER_DT" HeaderText="Job Order date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="VEHNO" HeaderText="Vehicle No.">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ORDER_TYPE" HeaderText="Job Card Type">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="SERVICE_CENTER_TYPE" HeaderText="Service Type">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ORDER_STATUS" HeaderText="Job Order Status">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Tot_Estimated_Cost" HeaderText="Estimated Amount">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="TOT_ACTUAL_COST" HeaderText="Actual Amount">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Approve">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkApprove" onClick="DoTheCheck()" runat="server" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Reject">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="ckhReject" onClick="DoTheCheck()" runat="server" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Remarks">
                                    <ItemTemplate>
                                        <asp:TextBox ID="tb_Remarks" Text='<%# Eval("JS_Approval_Close_Remarks") %>' CssClass="input"
                                            BorderStyle="Groove" runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr style="background-color: white" align="center">
                    <td align="center" colspan="2">
                        <br />
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                    </td>
                </tr>
                <tr style="background-color: white" align="center">
                    <td align="center" colspan="2">
                        <br />
                        <center>
                            <font class="blackfnt" style="color: Red;"><b>
                                <asp:Label ID="lbl_Page_Error" runat="server" Font-Size="Small" Text=""></asp:Label></b>
                            </font><font class="blackfnt" style="color: greeen;"><b>
                                <asp:Label ID="lblStatus" runat="server" Font-Size="Small" Text=""></asp:Label></b>
                            </font>
                        </center>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnShowMultipleRequest" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnShowSingleRequest" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
