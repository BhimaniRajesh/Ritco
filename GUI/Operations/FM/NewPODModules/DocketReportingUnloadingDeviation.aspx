<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="DocketReportingUnloadingDeviation.aspx.cs" Inherits="GUI_Operations_FM_NewPODModules_DocketReportingUnloadingDeviation"
    Title="Untitled Page" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="JavaScript" src="../../../Images/CalendarPopup.js"></script>
    <script language="javascript" src="../../../images/commonJs.js"></script>
    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function ValidateData() {
            return DateCheck();
        }

        function ViewPOD(ctrl) {

            var lnkPODLink = $(ctrl);
            var hdnPOD = $("#" + $(ctrl).attr('id').replace("lnkPODLink", "hdnPOD"));

            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50";
            var strPopupURL = "./../ViewFMScannedDocument.aspx?DocName=" + hdnPOD.val();
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
		
		   function OnReportingUnloadingDateChange(ctrl, type) {
            if (type == "R") {
                var id = $(ctrl).attr("id");
                var txtReportingDate = $(ctrl);
                var txtReportingDateHrs = $("#" + id.replace("txtReportingDate", "txtReportingDateHrs"));
                var txtReportingDateMin = $("#" + id.replace("txtReportingDate", "txtReportingDateMin"));
                var txtUnloadingDate = $("#" + id.replace("txtReportingDate", "txtUnloadingDate"));
                var txtUnloadingDateHrs = $("#" + id.replace("txtReportingDate", "txtUnloadingDateHrs"));
                var txtUnloadingDateMin = $("#" + id.replace("txtReportingDate", "txtUnloadingDateMin"));
                var lnkDocketDate = $("#" + id.replace("txtReportingDate", "lnkDocketDate"));
                if (txtUnloadingDate.val() != "" && txtReportingDate.val() != "") {
                    
                    if (new Date(getDateStringFrom_ddmmyyy(txtReportingDate.val())) < new Date(getDateStringFrom_ddmmyyy(lnkDocketDate.text()))) {
                        alert("Reporting Date can not be less then Booking Date !!");
                        txtReportingDate.val("");
                        txtReportingDate.focus();
                        return false;
                    }
                    
                    if (new Date(getDateStringFrom_ddmmyyy(txtReportingDate.val())) > new Date(getDateStringFrom_ddmmyyy(txtUnloadingDate.val()))) {
                        alert("Unloading Date can not be less then Reporting Date");
                        txtUnloadingDate.val("");
                        txtUnloadingDate.focus();
                        return false;
                    }
                }

            } else if (type == "U") {
                var id = $(ctrl).attr("id");
                var txtReportingDate = $("#" + id.replace("txtUnloadingDate", "txtReportingDate"));
                var txtReportingDateHrs = $("#" + id.replace("txtUnloadingDate", "txtReportingDateHrs"));
                var txtReportingDateMin = $("#" + id.replace("txtUnloadingDate", "txtReportingDateMin"));
                var txtUnloadingDate = $(ctrl);
                var txtUnloadingDateHrs = $("#" + id.replace("txtUnloadingDate", "txtUnloadingDateHrs"));
                var txtUnloadingDateMin = $("#" + id.replace("txtUnloadingDate", "txtUnloadingDateMin"));
                var lnkDocketDate = $("#" + id.replace("txtReportingDate", "lnkDocketDate"));

                if (txtUnloadingDate.val() != "" && txtReportingDate.val() != "") {
                    if (new Date(getDateStringFrom_ddmmyyy(txtReportingDate.val())) < new Date(getDateStringFrom_ddmmyyy(lnkDocketDate.text()))) {
                        alert("Reporting Date can not be less then Booking Date !!");
                        txtReportingDate.val("");
                        txtReportingDate.focus();
                        return false;
                    }

                    if (new Date(getDateStringFrom_ddmmyyy(txtReportingDate.val())) > new Date(getDateStringFrom_ddmmyyy(txtUnloadingDate.val()))) {
                        alert("Unloading Date can not be less then Reporting Date");
                        txtUnloadingDate.val("");
                        txtUnloadingDate.focus();
                        return false;
                    }
                }

            }
            //else if (type == "H") { }
            //else if (type == "M") { }

        }
        function getDateStringFrom_ddmmyyy(strDate) {
            var arr = strDate.split("/");
            return (arr[1] + "/" + arr[0] + "/" + arr[3])
        }
    </script>

    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <iframe frameborder="0" src="about:blank" style="border: 0px; position: absolute; z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth); height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
            <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft); top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                <img src="../../../images/loading.gif" /><font face="verdana" color="blue" size="4">&nbsp;<b>Please
                    Wait...</b></font>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div align="left">
        <UserControl:UserMessage ID="msgBox" runat="server" />
        <table border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module </strong></font><strong>&gt; </strong><font
                        class="blklnkund"><strong>Administrator </strong></font><strong>&gt; </strong>
                    <font class="blklnkund"><strong>Operations </strong></font><strong>&gt; </strong>
                    <font class="blklnkund"><strong>DFM </strong></font><strong>&gt; </strong><font class="bluefnt">
                        <strong>Docket Reporting Unloading Deviation Module</strong></font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td>
                    <img src="../../../images/clear.gif" width="15" height="10" /></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <table cellspacing="1" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Docket Reporting Unloading Deviation Module </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="2">
                                <asp:GridView ID="dgDockets" runat="server" CellSpacing="1" CellPadding="3"
                                    AllowSorting="true" AutoGenerateColumns="false" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                                    Width="100%">
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:CheckBox runat="server" ID="SelectAllCheckBox" Text="" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox runat="server" ID="chkDocket" Text="" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Sr No" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnkSrNo" runat="server" Text='<%#Container.DataItemIndex+1%>' CssClass="bluefnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Docket No" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnDocketNo" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "DocketNo")%>' />
                                                <asp:Label ID="lnkDocketNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocketNo")%>'
                                                    CssClass="bluefnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="From" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnkFrom" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FromModule")%>' CssClass="blackfnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Edited By" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnkFromModuleEditedBy" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FromModuleEditedBy")%>' CssClass="blackfnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Docket Date" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnkDocketDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocketDate")%>' CssClass="blackfnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="THC No" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnkTHCNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "THCNo")%>' CssClass="bluefnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Manual THC No." ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnkManualTHCNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ManualTHCNo")%>' CssClass="blackfnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Vehicle No" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnkVehicleNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "VehicleNo")%>' CssClass="blackfnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="From Location" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnkFromLocation" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "from_loc")%>' CssClass="blackfnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="To Location" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnkToLocation" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "to_loc")%>' CssClass="blackfnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Freight" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnkFreight" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FREIGHT")%>' CssClass="blackfnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Consignor" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnkConsignor" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Consignor")%>' CssClass="blackfnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Reporting Date Time" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnktReportingDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ReportingDate")%>' CssClass="blackfnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Unloading Date Time" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnktUnloadingDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "UnloadingDate")%>' CssClass="blackfnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="POD Receiving Date" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnktPODReceivingDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PODReceivingDate")%>' CssClass="blackfnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Handover Date" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnktHandoverDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "HandoverDate")%>' CssClass="blackfnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Remark" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtRemark" runat="server" Text=""></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="User Name" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnkUser" runat="server" Width="65" Text='<%# SessionUtilities.CurrentEmployeeID.ToString() +" : "+empnm %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Daviation Remark" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnkDaviationRemark" runat="server" Width="65" Text='<%# DataBinder.Eval(Container.DataItem, "DeviationRemark")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Daviation By" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnkDaviationBy" runat="server" Width="65" Text='<%# DataBinder.Eval(Container.DataItem, "DeviationBy")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>

                        <tr class="bgbluegrey">
                            <td align="center">
                                <asp:Button ID="btnClear" runat="server" Text="Clear" Width="100" OnClick="btnClear_Click" /></td>
                            <td align="center">
                                <asp:Button ID="btnPending" runat="server" Text="Pending" Width="100" OnClick="btnPending_Click" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
