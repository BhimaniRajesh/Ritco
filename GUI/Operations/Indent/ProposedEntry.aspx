<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ProposedEntry.aspx.cs"
    Inherits="GUI_Operations_Indent_ProposedEntry" %>

<%@ Register TagName="ProgressBar" Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagPrefix="probar" %>
<%@ Register Src="~/GUI/Common_UserControls/UserMessage.ascx" TagName="UserMessage" TagPrefix="UserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
     <script src="../../Js/Webx.Common.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript" src="Indent.js"></script>
    <script src="../../Js/querystring.js" type='text/javascript'></script>
    <script>
        function GetRemarks(id)
        {
            document.getElementById("<%=btnRemarks.ClientID %>").click();
        }
	function InitAutoComplete() {
            $("input[id*='txtWarehouse']").each(function () {
                var txtWarehouse = $(this);
                var hdnWarehouse = $("#" + txtWarehouse.attr('id').replace('txtWarehouse', 'hdnWarehouse'));
                AutoCompleteByAjax(txtWarehouse, "../../../RestService/MasterService.svc/GetLocationList", "POST", "application/json; charset=utf-8", "json", "prefixText", 3, 'v', 'v', 'l', 'v', hdnWarehouse, 'Invalid Location');
            });
        }
       
        $(document).ready(function () {
            InitAutoComplete();
        });

	//Check Location exist or not
        var txtWarehouse;
        function IsExistLocation(obj) {
            if (obj.value != "") {
                txtWarehouse = obj;
                AjaxRequestWithPostAndJson("../../../RestService/MasterService.svc/IsExistLocation", JSON.stringify(obj.value), checkLocationSuccess, errorFunction, false);
            }
            else {
                return true;
            }
        }

        //get Location code
        function checkLocationSuccess(data) {
            if (data != '') {
                hdnWarehouse.val(data);
            }
            else {
                txtWarehouse.value = "";
                txtWarehouse.focus();
                alert("Invalid Location");
                return false;
            }
        }
    </script>
    <UserControl:UserMessage ID="msgBox" runat="server" />
    <b>Operation >> Booking > Indent</b>
    <br />
    <br />
    <asp:UpdatePanel ID="updone" runat="server" UpdateMode="Conditional" RenderMode="Inline">
        <ContentTemplate>
            <div id="divProposedEntry" runat="server">
                <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="800px">
                    <tr class="bgbluegrey">
                        <td colspan="8" align="center">
                            <font class="blackfnt"><b>Proposed Indent</b></font>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td>
                            <b>Branch</b>
                        </td>
                        <td>
                            <asp:Label ID="lblBranch" runat="server" CssClass="blackfnt" />
                        </td>
                        <td>
                            <b>Warehouse</b>
                        </td>
                        <td>
                            <asp:TextBox ID="txtWarehouse" runat="server" MaxLength="50"
                                CssClass="ltxt" onblur="javascript:return IsExistLocation(this)"></asp:TextBox>
			      <asp:HiddenField ID="hdnWarehouse" runat="server" />
                        </td>
                        <td>
                            <b>Date</b>
                        </td>
                        <td colspan="3">
                            <asp:Label ID="lblDate" runat="server" CssClass="blackfnt" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8">
                            <table id="tblProposedEntry" border="0" cellpadding="1" cellspacing="1" width="900px">
                                <tr class="bgbluegrey">
                                    <td>Sl. No.
                                    </td>
                                    <td>
                                        <span class="redfnt">*</span> Docket Number
                                    </td>
                                    <td>Location
                                    </td>
                                    <td>Delivery Party Name
                                    </td>
                                    <td>Billing Party Name
                                    </td>
                                    <td>Mobile Number
                                    </td>
                                    <td>Remarks
                                    </td>
                                    <td>Delete
                                    </td>
                                </tr>
                                <asp:Repeater ID="rptProposed" runat="server" OnItemCommand="rptProposed_ItemCommand" OnItemDataBound="rptProposed_ItemDataBound">
                                    <ItemTemplate>
                                        <tr class="bgwhite">
                                            <td>
                                                <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.ItemIndex+1 %>"
                                                    runat="server" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDocketNumber" runat="server" Text='<%# Eval("DocketNumber")%>' MaxLength="35"
                                                    CssClass="ltxt" onchange="CheckDocketNumber(this)" autocomplete="off"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtLocation" runat="server" Text='<%# Eval("Location")%>' MaxLength="35"
                                                    CssClass="ltxt"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDeliveryPartyName" runat="server" Text='<%# Eval("DeliveryPartyName")%>' MaxLength="100"
                                                    CssClass="ltxt"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtBillingPartyName" runat="server" Text='<%# Eval("BillingPartyName")%>' MaxLength="100"
                                                    CssClass="ltxt"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtMobileNumber" runat="server" CssClass="blackfnt" Width="80px" onkeypress="javascript:return numberonly(event,this.getAttribute('id'))"
                                                    Text='<%# DataBinder.Eval( Container.DataItem,"MobileNumber") %>' MaxLength="10" onblur="javascript:return CheckMobileNumber(this)"> </asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtRemarks" runat="server" CssClass="blackfnt" Width="120px"
                                                    Text='<%# DataBinder.Eval( Container.DataItem,"Remarks") %>'
                                                    MaxLength="200" OnTextChanged="txtRemarks_TextChanged" AutoPostBack="true" onblur="GetRemarks(this)" autocomplete="off"> </asp:TextBox>
                                               
                                            </td>
                                            <td align="center">
                                                <asp:ImageButton ToolTip="Delete a record." OnClientClick="javascript:return confirm('Are you sure to delete record?')"
                                                    ID="imgBtnDelete" CommandName="Delete" CommandArgument='<%#Container.ItemIndex%>'
                                                    runat="server" ImageUrl="~/GUI/images/delete.gif"></asp:ImageButton>
                                                <asp:HiddenField ID="hdnPPackates" runat="server" Value='<%# Eval("hdnPPackates")%>' />
                                                <asp:HiddenField ID="hdnPPPackates" runat="server" Value='<%# Eval("hdnPPPackates")%>' />
                                                <asp:HiddenField ID="hdnPPackatess" runat="server" Value='<%# Eval("hdnPPackatess")%>' />
                                                <asp:HiddenField ID="hdnHHPackates" runat="server" Value='<%# Eval("hdnHHPackates")%>' />
                                                <asp:HiddenField ID="hdnPDelPackates" runat="server" Value='<%# Eval("hdnPDelPackates")%>' />
                                                <asp:HiddenField ID="hdnPMaterial" runat="server" Value='<%# Eval("hdnPMaterial")%>' />
                                                <asp:HiddenField ID="hdnPFromCity" runat="server" Value='<%# Eval("hdnPFromCity")%>' />
                                                <asp:HiddenField ID="hdnPToCity" runat="server" Value='<%# Eval("hdnPToCity")%>' />
                                                <asp:HiddenField ID="hdnPBookingStation" runat="server" Value='<%# Eval("hdnPBookingStation")%>' />
                                                <asp:HiddenField ID="hdnPCustomerRefrence" runat="server" Value='<%# Eval("hdnPCustomerRefrence")%>' />
                                                <asp:HiddenField ID="hdnPConsignor" runat="server" Value='<%# Eval("hdnPConsignor")%>' />
                                                <asp:HiddenField ID="hdnPConsignee" runat="server" Value='<%# Eval("hdnPConsignee")%>' />
                                                <asp:HiddenField ID="hdnPWeight" runat="server" Value='<%# Eval("hdnPWeight")%>' />
                                                <asp:HiddenField ID="hdnPDeliveryLocation" runat="server" Value='<%# Eval("hdnPDeliveryLocation")%>' />
                                                <asp:HiddenField ID="hdnIsSystemDocket" runat="server" Value='<%# Eval("hdnIsSystemDocket")%>' />
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                                 <asp:Button ID="btnRemarks" Text="test" CssClass="btnRemarks" OnClick="txtRemarks_TextChanged" runat="server" Style="display: none" />
                            </table>
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td colspan="8" align="center">
                            <asp:Button ID="btnSubmit" runat="server" CssClass="fbtn" Text="Submit" Width="100"
                                OnClientClick="javascript:return Validation();" OnClick="btnSubmit_Click" />
                            <asp:Button ID="btnIndentFinaliaztion" runat="server" CssClass="fbtn" Text="Indent Finalization" Width="150"
                                OnClientClick="javascript:return ValidationWithFinalization();" OnClick="btnIndentFinaliaztion_Click" />
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divIndentFinalizationSelect" runat="server" visible="false">
                <table id="tblIndentFinalizationSelect" border="0" cellpadding="1" cellspacing="1" class="boxbg" width="600px">
                    <tr class="bgbluegrey">
                        <td colspan="8" align="center">
                            <font class="blackfnt"><b>Indent Finalization Screen Criteria</b></font>
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td colspan="2">Enter Proposed Indent No.
                        </td>
                        <td colspan="2">
                            <asp:TextBox ID="txtIndentNumber" runat="server" MaxLength="50"
                                CssClass="ltxt"></asp:TextBox>
                        </td>
                        <td align="center">
                            <asp:Button ID="btnIndentSearch" runat="server" CssClass="fbtn" Text="Submit" Width="100"
                                OnClientClick="javascript:return ValidationOnSearch();" OnClick="btnIndentSearch_Click" />
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divIndentFinalization" runat="server">
                <table id="tblIndentFinalization" border="0" cellpadding="1" cellspacing="1" class="boxbg" width="1000px">
                    <tr class="bgbluegrey">
                        <td colspan="17" align="center">
                            <font class="blackfnt"><b>Indent Finalization Screen</b></font>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td colspan="2">
                            <b>Issuing Branch</b>
                        </td>
                        <td>
                            <asp:Label ID="lblFIssuingBranch" runat="server" CssClass="blackfnt" />
                        </td>
                        <td>
                            <b>Warehouse</b>
                        </td>
                        <td>
                            <asp:Label ID="lblFWarehouse" runat="server" CssClass="blackfnt" />
                        </td>
                        <td>
                            <b>Date & Time</b>
                        </td>
                        <td colspan="3">
                            <asp:Label ID="lblFDate" runat="server" CssClass="blackfnt" />
                        </td>
                        <td colspan="4">
                            <b>Proposed Indent No.</b>
                        </td>
                        <td colspan="5">
                            <asp:Label ID="lblFProposedIndentNumber" runat="server" CssClass="blackfnt" />
                        </td>
                    </tr>
                    <tr align="center" class="bgbluegrey">
                        <td>Sl. No.
                        </td>
                        <td>
                            <span class="redfnt">*</span> Docket Number
                        </td>
                        <td>Location
                        </td>
                        <td>Delivery Party Name
                        </td>
                        <td>Billing Party Name
                        </td>
                        <td>Mobile Number
                        </td>
                        <td>Remarks
                        </td>
                        <td>Number of Pkts.
                        </td>
                        <td>Material
                        </td>
                        <td>From City
                        </td>
                        <td>To City
                        </td>
                        <td>Booking Station
                        </td>
                        <td>Cust. Ref.
                        </td>
                        <td>Consignor
                        </td>
                        <td>Consignee
                        </td>
                        <td>Weight
                        </td>
                        <td>Delivery Location
                        </td>
                    </tr>
                    <asp:Repeater ID="rptIndentFinalization" runat="server">
                        <ItemTemplate>
                            <tr class="bgwhite">
                                <td>
                                    <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.ItemIndex+1 %>"
                                        runat="server" />
                                </td>
                                <td>
                                    <asp:TextBox ID="txtFDocketNumber" runat="server" MaxLength="50"
                                        CssClass="ltxt" onchange="CheckDocketNumberFinalization(this)" Width="90" Text='<%# Eval("DocketNumber")%>' autocomplete="off"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtFLocation" runat="server" MaxLength="100"
                                        CssClass="ltxt" Width="90" Text='<%# Eval("Location")%>'></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtFDeliveryPartyName" runat="server" MaxLength="100"
                                        CssClass="ltxt" Width="110" Text='<%# Eval("DeliveryPartyName")%>'></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtFBillingPartyName" runat="server" MaxLength="100"
                                        CssClass="ltxt" Width="110" Text='<%# Eval("BillingPartyName")%>'></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtFMobileNumber" runat="server" CssClass="blackfnt" Width="90px" onkeypress="javascript:return numberonly(event,this.getAttribute('id'))"
                                        MaxLength="10" Text='<%# Eval("MobileNumber")%>' onblur="javascript:return CheckMobileNumber(this)"> </asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtFRemarks" runat="server" CssClass="blackfnt" Width="120px"
                                        MaxLength="200" Text='<%# Eval("Remarks")%>'> </asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtFPackates" runat="server" CssClass="blackfnt" Width="40px" onkeypress="javascript:return numberonly(event,this.getAttribute('id'))"
                                        MaxLength="10" onblur="DefinePackages(this)" Text='<%# Eval("hdnPPackates")%>'> </asp:TextBox>
                                    <asp:Label CssClass="blackfnt" ID="lblFPackates" runat="server" Text='<%# Eval("hdnPPPackates")%>' />
                                    <asp:HiddenField ID="hdnFPackates" runat="server" Value='<%# Eval("hdnPPackatess")%>' />
                                    <asp:HiddenField ID="hdnFDelPackates" runat="server" Value='<%# Eval("hdnPDelPackates")%>' />
                                    <asp:HiddenField ID="hdnHHPackates" runat="server" Value='<%# Eval("hdnHHPackates")%>' />
                                </td>
                                <td>
                                    <asp:Label CssClass="blackfnt" ID="lblFMaterial" runat="server" Text='<%# Eval("hdnPMaterial")%>' />
                                </td>
                                <td>
                                    <asp:Label CssClass="blackfnt" ID="lblFFromCity" runat="server" Text='<%# Eval("hdnPFromCity")%>' />
                                </td>
                                <td>
                                    <asp:Label CssClass="blackfnt" ID="lblFToCity" runat="server" Text='<%# Eval("hdnPToCity")%>' />
                                </td>
                                <td>
                                    <asp:Label CssClass="blackfnt" ID="lblFBookingStation" runat="server" Text='<%# Eval("hdnPBookingStation")%>' />
                                </td>
                                <td>
                                    <asp:Label CssClass="blackfnt" ID="lblFCustomerRefrence" runat="server" Text='<%# Eval("hdnPCustomerRefrence")%>' />
                                </td>
                                <td>
                                    <asp:Label CssClass="blackfnt" ID="lblFConsignor" runat="server" Text='<%# Eval("hdnPConsignor")%>' />
                                </td>
                                <td>
                                    <asp:Label CssClass="blackfnt" ID="lblFConsignee" runat="server" Text='<%# Eval("hdnPConsignee")%>' />
                                </td>
                                <td align="right">
                                    <asp:Label CssClass="blackfnt" ID="lblFWeight" runat="server" Text='<%# Eval("hdnPWeight")%>' />
                                </td>
                                <td>
                                    <asp:Label CssClass="blackfnt" ID="lblFDeliveryLocation" runat="server" Text='<%# Eval("hdnPDeliveryLocation")%>' />
                                    <asp:HiddenField ID="hdnFIsSystemDocket" runat="server" Value='<%# Eval("hdnIsSystemDocket")%>' />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                    <tr class="bgbluegrey">
                        <td colspan="17" align="center">
                            <asp:Button ID="btnFinalizationSubmit" runat="server" CssClass="fbtn" Text="Submit" Width="100"
                                OnClientClick="javascript:return ValidationFinalization();" OnClick="btnIndentFinaliaztionSubmit_Click" />
                        </td>
                    </tr>
                </table>
            </div>
            <probar:ProgressBar ID="ProgressBar" runat="server" />
            <asp:HiddenField ID="hdnDocketNo" runat="server" />
            <asp:HiddenField ID="hdnClickCount" runat="server" Value="0" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

