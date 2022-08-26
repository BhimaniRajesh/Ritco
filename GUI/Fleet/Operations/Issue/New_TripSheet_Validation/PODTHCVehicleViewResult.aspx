<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="PODTHCVehicleViewResult.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_PODTHCVehicleViewResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript">

        function ValidateOnUpload(ctrl) {

            var btnUpload = $(ctrl);
            var fldUpload = $("#" + $(ctrl).attr("id").replace("btnUpload", "fldUpload"));
            if (fldUpload.val() == "") {
                alert("Please select file !!");
                return false;
            }
            return true;
        }
    </script>
    <div class="blackfnt">
        <table border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module </strong></font><strong>&gt; </strong><font
                        class="blklnkund"><strong>Fleet </strong></font><strong>&gt; </strong>
                    <font class="blklnkund"><strong>View & Print </strong></font><strong>&gt; </strong>
                    <font class="blklnkund"><strong>THC Details Of Owned Vehicle</strong></font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td>
                    <img src="../../../../images/clear.gif" width="15" height="10" /></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="dgExternalThc" runat="server" CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                        CssClass="dgRowStyle" Width="100%" PagerStyle-CssClass="pager" AllowSorting="true" AllowPaging="true"
                        PageSize="25" AutoGenerateColumns="false" OnRowCommand="dgExternalThc_RowCommand" EnableViewState="false"
                        EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange" OnRowDataBound="dgExternalThc_RowDataBound" >
                        <Columns>
                            <asp:BoundField DataField="ExternalTHCNo" HeaderText="THC No./ETHC No.">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="EntryDate" HeaderText="THC Date">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="VSlipNo" HeaderText="TripSheet No.">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vslipdt" HeaderText="TripSheet Date">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="FromCity" HeaderText="From">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ToCity" HeaderText="To">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="FleetCenter" HeaderText="Fleet Center/Loading Branch">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="LoadingDate" HeaderText="Loaded Date">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ChallanDate" HeaderText="Unloaded Date">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Weight" HeaderText="Weight">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>

                            <asp:BoundField DataField="CustomerType" HeaderText="Transporter Name">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TransporterChallanNo" HeaderText="Transporter Challan No.">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>

                            <asp:BoundField DataField="Commodity" HeaderText="Product">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Nug" HeaderText="Nug">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ContractAmount" HeaderText="Freight">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="AdvanceAmount" HeaderText="Advance">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CustomerType" HeaderText="Customer">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Remarks" HeaderText="Remark">
                                <ItemStyle HorizontalAlign="Left" />
                                <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                            </asp:BoundField>
                            <asp:TemplateField ItemStyle-BackColor="white"  HeaderText="Status">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkDownload" Text="Download" CommandArgument='<%# Eval("UploadFileName") %>' runat="server" OnClick="DownloadFile"></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-BackColor="white" HeaderText="File Upload">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hdnTripType" runat="server" Value='<%# Eval("TripType") %>' />
                                    <asp:HiddenField ID="hdnExternalTHCNo" runat="server" Value='<%# Eval("ExternalTHCNo") %>' />
                                    <asp:HiddenField ID="hdnUploadFileName" runat="server" Value='<%# Eval("UploadFileName") %>' />
                                    <asp:FileUpload ID="fldUpload" runat="server" />
                                    <asp:Button ID="btnUpload" runat="server" Text="Upload File" CommandArgument="UploadButton"  OnClientClick="return ValidateOnUpload(this);"  />
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle />
                        <PagerStyle HorizontalAlign="Left" CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="bgbluegrey" Font-Bold="true" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" Position="TopAndBottom" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
