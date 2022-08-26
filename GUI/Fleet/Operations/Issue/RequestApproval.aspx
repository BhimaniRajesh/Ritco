<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="RequestApproval.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_RequestApproval" %>

<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagPrefix="PgBar" TagName="ProgressBar" %>
<%@ Register Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" TagPrefix="LH" TagName="Location" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" language="javascript" src="Indent.js"></script>
    <script language="JavaScript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
    <script type="text/javascript" language="javascript" src="AJAX_Validator/NewTripGenerate_New.js?vs=126"></script>
    <script type="text/javascript" language="JavaScript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>


    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server" Text="Fleet >> New Trip Operations > Request Approval"></asp:Label>
            </td>
        </tr>
    </table>
    <div id="divIndentCancelCriteria" runat="server">
        <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="50%">
            <tr class="bgbluegrey">
                <td align="center" colspan="2">
                    <asp:Label ID="lblHeader" runat="server" Font-Bold="true" Text="Request Approval" CssClass="blackfnt"></asp:Label>
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
                <td align="left">Select Branch
                </td>
                <td>
                    <asp:DropDownList ID="ddlro" runat="server">
                    </asp:DropDownList>
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
                            <td>Request Date</td>
                            <td>Time</td>
                            <td>Controlling Branch</td>
                            <td>Vehicle No.</td>
                            <td>Driver Name.</td>
                            <td>Action</td>
                        </tr>
                        <asp:Repeater ID="rptFinnalIndentDktPendingList" runat="server" OnItemCommand="rptFinnalIndentDktPendingList_ItemCommand">
                            <ItemTemplate>
                                <tr class="bgwhite">
                                    <td align="center">
                                        <%#Container.ItemIndex+1 %> 
                                    </td>
                                    <td align="center">
                                        <asp:Label ID="lblRequestDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"RequestDate")%>'></asp:Label>
                                    </td>
                                     <td align="center">
                                        <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"RequestTime")%>'></asp:Label>
                                    </td>
                                    
                                    <td align="center">
                                        <asp:Label ID="lblControlingBranch" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Location")%>'></asp:Label>
                                    </td>
                                    <td align="center" >
                                        <asp:Label ID="lblVehicleNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"VehicleID")%>'></asp:Label>
                                    </td>
                                    <td align="center">
                                        <asp:Label ID="lblDriverName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DriverName")%>'></asp:Label>
                                        <asp:Label ID="lblDriverNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DriverNo")%>'></asp:Label>
                                    </td>
                                    <td align="center">
                                        <asp:LinkButton ID="lnkbtnRequestNo" runat="server" OnCommand="lnkbtnRequestNo_Command" CommandName="Edit" CommandArgument='<%# Eval("RequestID") %>'>Select</asp:LinkButton>
                                        <asp:HiddenField ID="hdnRequestNo" runat="server" Value='<%# Eval("RequestID") %>' />
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
        <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="70%">
            <tr class="bgbluegrey">
                <td align="center" colspan="8">
                    <asp:Label ID="lblHeaderCancellation" runat="server" Font-Bold="true" Text="Request Approval" CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            <tr class="bgwhite">
                <td align="left"><b>Vehicle No</b>
                </td>
                <td>
                    <asp:Label ID="lblVehicleNoHdr" runat="server" Text="" CssClass="blackfnt" Width="100px"></asp:Label>
                    <asp:HiddenField ID="hdnRequestNumber" runat="server" />
                </td>
                <td align="left"><b>Driver Name</b>
                </td>
                <td>
                    <asp:Label ID="lblDriverNameHdr" runat="server" Text="" CssClass="blackfnt" Width="100px"></asp:Label>
                    <asp:HiddenField ID="hdnDriverNumber" runat="server" />
                </td>
                <td align="left"><b>Request No</b>
                </td>
                <td colspan="3">
                    <asp:Label ID="lblRequest" runat="server" Text="" CssClass="blackfnt" Width="100px"></asp:Label>
                </td>
            </tr>
        </table>
        <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="70%">
            <tr bgcolor="white">
                <td class="blackfnt" colspan="8">
                    <table class="boxbg" border="0" cellpadding="3" cellspacing="1" style="width: 100%;">
                        <tr align="center" class="bgbluegrey blackboldfnt">
                            <td>Sl.No</td>
                            <td>System Date</td>
                            <td>Document Name</td>
                            <td>Expiry Date</td>
                            <td style="display: none;">Master Expiry Date</td>
                            <td>Grace Period</td>
                            <td style="display: none;">Entered Value</td>
                            <td style="display: none;">Master Value</td>
                            <td style="display: none;">Grace/Allowed</td>
                            <td style="display: none;">IsValidate</td>
                            <td >Remarks</td>
                        </tr>
                        <asp:Repeater ID="rptRequestPendingList" runat="server" OnItemDataBound="rptRequestPendingList_ItemDataBound">
                            <ItemTemplate>
                                <tr class="bgwhite">
                                    <td align="center">
                                        <%#Container.ItemIndex+1 %> 
                                    </td>
                                    <td align="center">
                                        <asp:Label ID="lblRequestDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"RequestDate")%>'></asp:Label>
                                        <asp:HiddenField ID="hdnRequestOrder" runat="server" Value='<%# Eval("RequestOrder") %>' />
                                    </td>
                                    <td align="center">
                                        <asp:Label ID="lblDocumentName" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DocumentName")%>'></asp:Label>
                                    </td>
                                    <td align="center">
                                        <asp:Label ID="lblExpiryDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"ExpiryDate")%>'></asp:Label>
                                    </td>
                                    <td align="center" style="display: none;">
                                        <asp:Label ID="lblMasterExpiryDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"MasterExpiryDate")%>'></asp:Label>
                                        <asp:HiddenField ID="hdnMasterExpiryDate" runat="server" Value='<%# Eval("MasterExpiryDateTime") %>' />
                                    </td>
                                    <td align="center">
                                        <asp:Label ID="lblGracePeriod" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Grace")%>'></asp:Label>
                                    </td>
                                    <td align="center" style="display: none;">
                                        <asp:Label ID="lblValue" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Value")%>'></asp:Label>
                                    </td>
                                    <td align="center" style="display: none;">
                                        <asp:Label ID="lblMasterValue" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"MasterValue")%>'></asp:Label>
                                    </td>
                                    <td align="center" style="display: none;">
                                        <asp:Label ID="lblValueGrace" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"GraceValue")%>'></asp:Label>
                                    </td>
                                    <td align="center">
                                        <asp:Label ID="lblRemarks" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Remarks")%>'></asp:Label>
                                    </td>
                                    <td align="center" style="display: none;">
                                        <asp:CheckBox ID="chkRequest" runat="server" Checked="true" />
                                        <asp:HiddenField ID="hdnRequestNo" runat="server" Value='<%# Eval("RequestID") %>' />
                                        <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
                                        <asp:HiddenField ID="hdnForcedYN" runat="server" />
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                </td>
            </tr>
            <tr class="bgbluegrey">

                <td align="center">
                    <asp:Button runat="server" ID="btnSubmitValidate" Text="Validate" Width="100px" OnClick="btnSubmitValidate_Click" />
                </td>
                <td align="center" colspan="4">
                    <asp:Button runat="server" ID="btnSubmitCancel" Text="Reject" Width="100px" OnClick="btnSubmitCancel_Click" />
                </td>
            </tr>
        </table>
    </div>
    <asp:UpdatePanel ID="updone" runat="server" UpdateMode="Conditional" RenderMode="Inline">
        <ContentTemplate>
            <PgBar:ProgressBar runat="server" ID="ProgressBar" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;"></div>
</asp:Content>
