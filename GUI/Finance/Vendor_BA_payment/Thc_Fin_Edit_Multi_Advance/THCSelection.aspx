<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="THCSelection.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_THC_FIN_Edit_THCSelection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <table border="0" cellpadding="3" width="950px" cellspacing="1" align="left" class="boxbg">
        <tr class="bgbluegrey">
				<th align="center"><font class="blackfnt"><b>THC Financial Edit Multiple Advance
				</b></font></th>
			</tr>
        <tr class="bgbluegrey">
            <th>
                <font class="blackfnt"><b>You Selected</b></font>
            </th>
        </tr>
        <tr class="bgwhite">
            <td>
                <table border="0" cellpadding="3" width="950px" cellspacing="1" align="left" class="boxbg">
                    <tr class="bgwhite">
                        <td>
                            <div align="left"><font class="blackfnt">Document Date</font></div>
                        </td>
                        <td>
                            <div align="left">
                                <font class="blackfnt">
                                    <asp:Label ID="lblDocDate" runat="server" Text="Label"></asp:Label></font>
                            </div>
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td>
                            <div align="left">
                                <font class="blackfnt">Document Type</font>
                            </div>
                        </td>
                        <td>
                            <div align="left">
                                <font class="blackfnt">
                                    <asp:Label ID="lblDocType" runat="server" Text="Label"></asp:Label></font>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="bgbluegrey">
            <th>
                <b>Select THC for prepare Payment</b>
            </th>
        </tr>
        <tr class="bgwhite">
            <td>
                <asp:GridView ID="GridTHCList" runat="server" CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" BorderWidth="0"
                    AllowSorting="true" CssClass="boxbg" FooterStyle-CssClass="boxbg" RowStyle-CssClass="bgwhite"
                    AutoGenerateColumns="false" EmptyDataText="No Records Found..." Width="950px">
                    <Columns>
                        <asp:BoundField DataField="thcno" HeaderText="THC Number ">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="bgwhite" />
                        </asp:BoundField>

                        <asp:BoundField DataField="vehno" HeaderText="Vehicle Number ">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="bgwhite" />
                        </asp:BoundField>


                        <asp:BoundField DataField="thcdt" HeaderText="THC Date">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="bgwhite" />
                        </asp:BoundField>

                        <asp:BoundField DataField="thcbr" HeaderText="Start Branch">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="bgwhite" />
                        </asp:BoundField>

                        <asp:BoundField DataField="routecd" HeaderText="Route Code">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="bgwhite" />
                        </asp:BoundField>

                        <asp:BoundField DataField="routename" HeaderText="Route Name">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="bgwhite" />
                        </asp:BoundField>

                        <asp:BoundField DataField="VendorCode" HeaderText="Vendor Code">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="bgwhite" />
                        </asp:BoundField>

                        <asp:BoundField DataField="VendorName" HeaderText="Vendor Name">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle CssClass="bgwhite" />
                        </asp:BoundField>

                        <asp:TemplateField HeaderStyle-CssClass="blackfnt" HeaderText="Edit">
                            <ItemTemplate>
                                <center>
                                    <a href="THC_FIN_Updates.aspx?<%# DataBinder.Eval(Container.DataItem,"THCNO") %>" class="Bluefnt"><b>Edit</b></a>
                                </center>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                    <HeaderStyle CssClass="bgbluegrey" />
                    <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                    <FooterStyle CssClass="boxbg" />
                </asp:GridView>

            </td>
        </tr>
    </table>
</asp:Content>
