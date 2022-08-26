<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="FuelRateUpdation.aspx.cs" Inherits="GUI_Fleet_Webadmin_FuelRateMaster_FuelRateUpdation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:UpdatePanel ID="upDCRReDeAllot" UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <script language="javascript" type="text/javascript" src="VendorPayment.js"></script>
             <script language="javascript" type="text/javascript" src="FuelRateMaster.js"></script>

            <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" id="tblDCRCriteria"
                runat="server" visible="true">
                <tr class="bgbluegrey">
                    <td colspan="6" style="text-align: left" align="center">
                        <asp:Label ID="lblTblHeader" runat="server" CssClass="blackfnt" Text="Fuel Rate Updation"
                            Font-Bold="true"></asp:Label>
                    </td>
                </tr>

                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Select</font>&nbsp;&nbsp;
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlSelectType" Width="90px" OnSelectedIndexChanged="ddlSelectType_SelectedIndexChanged" AutoPostBack="true" runat="server" TabIndex="1">
                            <asp:ListItem Value="All">All</asp:ListItem>
                            <asp:ListItem Value="Active">Active</asp:ListItem>
                            <asp:ListItem Value="Deactive">Deactive</asp:ListItem>
                            <asp:ListItem Value="Vendor">Vendor</asp:ListItem>
                        </asp:DropDownList>
                    </td>

                    <td align="left" id="tdVendorlbl" runat="server" width="25%">
                        <font class="blackfnt">Select Vendor:(Smart Search)</font>&nbsp;&nbsp;
                    </td>
                    <td align="left" runat="server" id="tdVendortxt">
                        <asp:TextBox ID="txtVendor" Width="180px" runat="server" onblur="javascript:VenDor_Vechicle_Blur(this,'Vendor')" TabIndex="1"></asp:TextBox>

                        <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server"
                            Enabled="True"
                            CompletionListItemCssClass="autocomplete_listItem"
                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                            ServiceMethod="GetVendorFuel" ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtVendor">
                        </ajaxToolkit:AutoCompleteExtender>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td colspan="4" align="right">
                        <asp:Button ID="btnSubmit" ValidationGroup="grpQuery" Width="45px" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                        &nbsp;&nbsp;&nbsp;&nbsp;
                         <asp:Button ID="btnAddContract" ValidationGroup="grpQuery" Width="45px" runat="server" Text="Add" OnClick="Redirect_AddContract" />
                    </td> 
                </tr>
                 <tr bgcolor="white">
                    <td align="left" colspan="4">
                        <asp:Label runat="server" ID="lblErrorMsg" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <table border="0" cellspacing="1" cellpadding="3" width="900px">
                <tr>
                    <td align="center">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
            </table>

            <table border="0" cellspacing="1" cellpadding="3" width="900px" runat="server" id="tblDCR">
                <tr style="background-color: white">
                    <td align="center" width="100%">
                        <asp:UpdatePanel ID="u1" UpdateMode="Conditional" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="dgGeneral" runat="server" AutoGenerateColumns="False"
                                    CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                                    CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                                    PagerSettings-Mode="NumericFirstLast" EmptyDataText="No Records Found">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Sr No.">
                                            <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="VendorName" ItemStyle-HorizontalAlign="Left" HeaderText="Vendor Name" InsertVisible="false"
                                            ReadOnly="True" HeaderStyle-HorizontalAlign="Left" SortExpression="VendorName" />

                                        <asp:BoundField DataField="VendorCode" HeaderText="Vendor Code" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="Vendor Code" />
                                        <asp:BoundField DataField="VendorCity" HeaderText="Vendor City" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="City" />
                                        <asp:BoundField DataField="UpdationDate" HeaderText="Updation Date" HeaderStyle-HorizontalAlign="Left" 
                                            ItemStyle-HorizontalAlign="Left" ReadOnly="True" />
                                        <asp:BoundField DataField="DateFrom" HeaderText="Period From" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True"  />
                                        <asp:BoundField DataField="DateTo" HeaderText="Period To" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="false" />
                                        <asp:BoundField DataField="Product" HeaderText="Product" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="true" />
                                        <asp:BoundField DataField="Rate" HeaderText="Rate" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" ReadOnly="true" />
                                        <asp:BoundField DataField="ValidatedDate" HeaderText="Validated Date" HeaderStyle-HorizontalAlign="Left" 
                                            ItemStyle-HorizontalAlign="Left" ReadOnly="True" />
                                        <asp:TemplateField HeaderText="View History">
                                            <ItemTemplate>
                                                <asp:HyperLink runat="server" Target="_blank" NavigateUrl='<%# string.Format("~/GUI/Fleet/Webadmin/FuelRateMaster/FuelRateUpdation_SubmitForValidation.aspx?VendorCode={0}", HttpUtility.UrlEncode(Eval("VendorCode").ToString())) %>' Text="View Details" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>

                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"></asp:SqlDataSource>

        </ContentTemplate>
    </asp:UpdatePanel>

    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
    </div>
</asp:Content>

