<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="FuelRateUpdation_AddContract.aspx.cs" Inherits="GUI_Fleet_Webadmin_FuelRateMaster_FuelRateUpdation_AddContract" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:UpdatePanel ID="upDCRReDeAllot" UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>

            <script language="javascript" type="text/javascript" src="VendorPayment.js"></script>
            <script language="javascript" type="text/javascript" src="../../../GUI/images/CommonJS.js"></script>
            <script language="javascript" type="text/javascript" src="../../../admin/FuelSlipMaster/FuelSlipMaster_JS.js"></script>
            <script language="javascript" type="text/javascript" src="FuelRateMaster.js?V1"></script>
            <script type="text/javascript">
			
                function validateonSubmit() {
                    var txtFromDate = $('#'<%= txtFromDate.ClientID.ToString()%>);
                    var txtToDate = $('#'<%= txtToDate.ClientID.ToString()%>);

                    if (txtFromDate.val() != "" && txtToDate.val() != "") {

                        var startArr = txtFromDate.split("/");
                        var endArr = txtToDate.split("/");
                        var startdt = new Date(startArr[1] + "/" + startArr[0] + "/" + startArr[2]);
                        var enddt = new Date(endArr[1] + "/" + endArr[0] + "/" + endArr[2]);

                        if (((enddt - startdt) / (1000 * 60 * 60 * 24)) > 60) {
                            alert("Start date and End date difference can not be more than 60 days !!");
                            return false;
                        }

                    }
                    return true;
                }
            </script>
            <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" id="tblDCRCriteria"
                runat="server" visible="true">
                <tr class="bgbluegrey">
                    <td colspan="5" style="text-align: left" align="center">
                        <asp:Label ID="lblTblHeader" runat="server" CssClass="blackfnt" Text="Update Rate" Font-Bold="true"></asp:Label>
                    </td>
                </tr>

                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Select Vendor</font>&nbsp;&nbsp;
                    </td>

                    <td align="left" style="width: 150px">
                        <asp:TextBox ID="txtVendor" Width="150px" CssClass="input" BorderStyle="Groove" runat="server" onblur="javascript:VenDor_Vechicle_Blur(this,'Vendor')" TabIndex="1"></asp:TextBox>

                        <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server"
                            Enabled="True"
                            CompletionListItemCssClass="autocomplete_listItem"
                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                            ServiceMethod="GetVendorFuel" ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtVendor">
                        </ajaxToolkit:AutoCompleteExtender>
                    </td>

                    <td align="left">
                        <font class="blackfnt">Product</font>&nbsp;&nbsp;
                    </td>

                    <td align="left">
                        <asp:DropDownList ID="ddProduct" Width="70px" runat="server" TabIndex="2">
                            <asp:ListItem Selected="True" Value="Diesel">Diesel</asp:ListItem>
                            <asp:ListItem Value="CNG">CNG</asp:ListItem>
                            <asp:ListItem Value="AddBlue">Add Blue</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>

                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Date From</font>&nbsp;&nbsp;
                    </td>
                    <td>
                        <font class="blackfnt">
                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="input" BorderStyle="Groove" onblur="return ValidateDate(this)" Width="80px" TabIndex="3"></asp:TextBox></font>
                        <ajaxToolkit:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" TargetControlID="txtFromDate" runat="server" />
                    </td>

                    <td align="left">
                        <font class="blackfnt">Date To</font>&nbsp;&nbsp;
                    </td>
                    <td>
                        <font class="blackfnt">
                            <asp:TextBox ID="txtToDate" runat="server" CssClass="input" BorderStyle="Groove" onblur="return ValidateDate(this)" Width="80px" TabIndex="4"></asp:TextBox></font>
                        <ajaxToolkit:CalendarExtender ID="calExtendertxtToDate" Format="dd/MM/yyyy" TargetControlID="txtToDate" runat="server" />
                    </td>
                </tr>

                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Rate</font>&nbsp;&nbsp;
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtRate" CssClass="input" BorderStyle="Groove" Width="80px" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" TabIndex="5"></asp:TextBox>
                    </td>

                    <td align="left" id="tdVendorlbl">
                        <font class="blackfnt">Confirm Rate</font>&nbsp;&nbsp;
                    </td>
                    <td align="left" id="tdVendortxt">
                        <asp:TextBox ID="txtConfirmRate" CssClass="input" BorderStyle="Groove" Width="80px" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" TabIndex="6"></asp:TextBox>
                    </td>
                </tr>

                <tr bgcolor="white">
                    <td align="right" colspan="3">
                        <div id='myDiv'>
						<a id="lnkPopUp" style="text-decoration:underline;" onclick="openPopUp();">Rate History</a>
						</div>
                    </td>
                    <td align="right" colspan="3">
                        <asp:Button ID="btnAddContract" runat="server" Text="Update Rate" onClientClick="AddValidation();"  OnClick="btnAddContract_Click" TabIndex="7" />
                    </td>
                </tr>

                <tr bgcolor="white">
                    <td align="left" colspan="4">
                        <asp:Label runat="server" ID="lblConfirm"></asp:Label>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>

    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
    </div>
</asp:Content>


