<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="PODUploadMain.aspx.cs" Inherits="GUI_Operations_FM_NewPODModules_PODUploadMain"
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
			
		function SelectAll(ctrl) {
			//	alert("ok");
            $("input[type=checkbox][id*=chkDocket]").each(function () {
                $(this).prop("checked", $(ctrl).prop("checked"));
            });
			}	
		
        function ValidateData() {
            return DateCheck();
        }
		function OnPODReceivingDate(ctrl) 
		{
			var txtPODReceivingDate = $(ctrl);
			if(txtPODReceivingDate.val() != ""){
				
				if (new Date(getDateStringFrom_ddmmyyy(txtPODReceivingDate.val())) > new Date()) {
                        alert("POD Receiving Date can not be future Date !!");
                        PODReceivingDate.val("");
                        PODReceivingDate.focus();
                        return false;
                    }
			}
		}
		
		function OnReportingUnloadingDateChange(ctrl, type) 
		{
		    
            if (type == "R") {
			
                var id = $(ctrl).attr("id");
                var txtReportingDate = $(ctrl);
                var txtReportingDateHrs = $("#" + id.replace("txtReportingDate", "txtReportingDateHrs"));
                var txtReportingDateMin = $("#" + id.replace("txtReportingDate", "txtReportingDateMin"));
                var txtUnloadingDate = $("#" + id.replace("txtReportingDate", "txtUnloadingDate"));
                var txtUnloadingDateHrs = $("#" + id.replace("txtReportingDate", "txtUnloadingDateHrs"));
                var txtUnloadingDateMin = $("#" + id.replace("txtReportingDate", "txtUnloadingDateMin"));
                var lnkDocketDate = $("#" + id.replace("txtReportingDate", "lnkDocketDate"));
				
				
                if (txtReportingDate.val() != "" ) {
                    
                    if (new Date(getDateStringFrom_ddmmyyy(txtReportingDate.val())) < new Date(getDateStringFrom_ddmmyyy(lnkDocketDate.text()))) {
                        alert("Reporting Date can not be less then Booking Date !!");
                        txtReportingDate.val("");
                        txtReportingDate.focus();
                        return false;
                    }
					
					if (new Date(getDateStringFrom_ddmmyyy(txtReportingDate.val())) > new Date()) {
                        alert("Reporting Date can not be future Date !!");
                        txtReportingDate.val("");
                        txtReportingDate.focus();
                        return false;
                    }
					
                    if( txtUnloadingDate.val() != ""){
                    if (new Date(getDateStringFrom_ddmmyyy(txtReportingDate.val())) > new Date(getDateStringFrom_ddmmyyy(txtUnloadingDate.val()))) {
                        alert("Unloading Date can not be less then Reporting Date");
                        txtUnloadingDate.val("");
                        txtUnloadingDate.focus();
                        return false;
                    }
					
					if (new Date(getDateStringFrom_ddmmyyy(txtUnloadingDate.val())) > new Date()) {
                        alert("Unloading Date can not be future Date !!");
                        txtUnloadingDate.val("");
                        txtUnloadingDate.focus();
                        return false;
                    }
					
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
					
					if (new Date(getDateStringFrom_ddmmyyy(txtUnloadingDate.val())) > new Date()) {
                        alert("Unloading Date can not be future Date !!");
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
            return (arr[1] + "/" + arr[0] + "/" + arr[2])
        }

        /*Start-Changed By : Juhi Patel (P008303)- To View POD*/
        function ViewPOD(ctrl) {
			
			var SOPContainar = '<%=ConfigurationManager.AppSettings["SOPContainerName"].ToString()%>';	
			
            var lnkPODLink = $(ctrl);
            var hdnPOD = $("#" + $(ctrl).attr('id').replace("lblPOD", "hdnArrivalUpdatePODFile"));

            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50";
            
			var strPopupURL = "https://ritcoblob.blob.core.windows.net/"+SOPContainar+"/" + hdnPOD.val();
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        /*END*/
		
		function openTHCViewPrint(ctrl) {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50";
            var strPopupURL = './../../../Operations/THC/ViewPrint/THCViewPrint.aspx';
            var strPopupURL = strPopupURL + "?tcno=" + $(ctrl).text() + ".,0";
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
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
                        <strong>POD Upload Module</strong></font>
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
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">POD Upload Module </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="2">
                                <asp:GridView ID="dgDockets" runat="server" CellSpacing="1" CellPadding="3"
                                    AllowSorting="true" AutoGenerateColumns="false" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                                    Width="100%"  OnRowDataBound="dgDockets_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:CheckBox runat="server" ID="SelectAllCheckBox" Text="" Onclick="Javascript:return SelectAll(this);" />
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
                                        <asp:TemplateField HeaderText="POD Rejected" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnkPODRejected" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "IsRejected")%>' CssClass="bluefnt" Font-Underline="false" />
                                                <asp:HiddenField ID="hdnPODRejected" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "IsRejected")%>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Docket No" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hdnDocketNo" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "DocketNo")%>' />
                                                <asp:Label ID="lnkDocketNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocketNo")%>'
                                                    CssClass="bluefnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Docket Date" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnkDocketDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocketDate")%>' CssClass="blackfnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="THC No" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnkTHCNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "THCNo")%>' CssClass="bluefnt" Font-Underline="true" onclick="openTHCViewPrint(this);" />
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
                                                <asp:TextBox ID="txtReportingDate" runat="server" MaxLength="10" Width="65" BorderStyle="groove" onblur="OnReportingUnloadingDateChange(this, 'R')"  
                                                    CssClass="input" Text='<%# DataBinder.Eval(Container.DataItem, "ReportingDate")%>'></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender ID="calExtenderReportingDate" Format="dd/MM/yyyy" TargetControlID="txtReportingDate"
                                                    runat="server" />
                                                <asp:TextBox ID="txtReportingDateHrs" runat="server" Width="20" BorderStyle="groove" MaxLength="2"
                                                    CssClass="input" Text='<%# DataBinder.Eval(Container.DataItem, "ReportingDateHrs")%>'></asp:TextBox>
                                                :
                                        <asp:TextBox ID="txtReportingDateMin" runat="server" Width="20" BorderStyle="groove" MaxLength="2"
                                            CssClass="input" Text='<%# DataBinder.Eval(Container.DataItem, "ReportingDateMin")%>'></asp:TextBox>
                                                <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Invalid Hours !!" ControlToValidate="txtReportingDateHrs" MinimumValue="0" MaximumValue="23"></asp:RangeValidator>
                                                <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="Invalid Minute !!" ControlToValidate="txtReportingDateMin" MinimumValue="0" MaximumValue="59"></asp:RangeValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Unloading Date Time" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtUnloadingDate" runat="server" MaxLength="10" Width="65" BorderStyle="groove" onblur="OnReportingUnloadingDateChange(this, 'U')" 
                                                    CssClass="input" Text='<%# DataBinder.Eval(Container.DataItem, "UnloadingDate")%>'></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender ID="calExtenderUnloadingDate" Format="dd/MM/yyyy" TargetControlID="txtUnloadingDate"
                                                    runat="server" />
                                                <asp:TextBox ID="txtUnloadingDateHrs" runat="server" Width="20" BorderStyle="groove" MaxLength="2"
                                                    CssClass="input" Text='<%# DataBinder.Eval(Container.DataItem, "UnloadingDateHrs")%>'></asp:TextBox>
                                                :
                                        <asp:TextBox ID="txtUnloadingDateMin" runat="server" Width="20" BorderStyle="groove" MaxLength="2"
                                            CssClass="input" Text='<%# DataBinder.Eval(Container.DataItem, "UnloadingDateMin")%>'></asp:TextBox>
                                                <asp:RangeValidator ID="RangeValidator3" runat="server" ErrorMessage="Invalid Hours !!" ControlToValidate="txtUnloadingDateHrs" MinimumValue="0" MaximumValue="23"></asp:RangeValidator>
                                                <asp:RangeValidator ID="RangeValidator4" runat="server" ErrorMessage="Invalid Minute !!" ControlToValidate="txtUnloadingDateMin" MinimumValue="0" MaximumValue="59"></asp:RangeValidator>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="POD Receiving Date" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtPODReceivingDate" runat="server" MaxLength="10" Width="65" BorderStyle="groove" onblur="OnPODReceivingDate(this)"
                                                    CssClass="input" Text=''></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender ID="calExtenderPODReceivingDate" Format="dd/MM/yyyy" TargetControlID="txtPODReceivingDate"
                                                    runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Remark" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txtRemark" runat="server" Text=""></asp:TextBox>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Uploaded By" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lnkUser" runat="server" Width="65" Text='<%# SessionUtilities.CurrentEmployeeID.ToString()+" : "+empnm.ToString()  %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="POD Upload" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:FileUpload ID="fileUploadPOD" EnableViewState="true" CssClass="input" runat="server" />
                                                <asp:HiddenField ID="hdnArrivalUpdatePODFile" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "ArrivalUpdatePODFile")%>' />
                                                <asp:Label runat="server" ID="lblPOD" Text="View" onclick="ViewPOD(this)" style="cursor:pointer"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Rejected Remark" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRejectedRemark" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "RejectRemarks")%>' CssClass="bluefnt" Font-Underline="false" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>

                        <tr class="bgbluegrey">
                            <td colspan="2" align="center">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" Width="100" OnClick="btnSubmit_Click" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
