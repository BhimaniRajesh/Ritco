<%@ Control Language="C#" AutoEventWireup="true" CodeFile="StanderdCharge.ascx.cs" Inherits="StanderdCharge" %>

<%@ Register Src="~/GUI/admin/CustomerContractMaster/Views/LocWiseOtherCharges.ascx" TagName="ChargeMatrix" TagPrefix="UC" %>
<div class="blackfnt">
    <table border="0" cellpadding="0" cellspacing="1" class="boxbg">
        <tr class="bgbluegrey" align="center">
            <th><b>Booking Time</b></th>
            <th><b>Delivery Time</b></th>
        </tr>
        <tr class="bgwhite" align="center" valign="top">
            <td>
                <asp:GridView ID="gvBkgResult" runat="server" BorderWidth="0" AutoGenerateColumns="False"
                    CssClass="mGrid" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt"       
                    OnRowDataBound="gvBkgResult_RowDataBound" CellSpacing="1" Width="300">
                    <Columns>
                        <asp:TemplateField HeaderText="Charge" ItemStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:Label ID="lblChgName" runat="server" Text=""></asp:Label>
                                <asp:HiddenField ID="lblChgCode" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="75">
                            <ItemTemplate>
                                <asp:Label ID="lblChgAMT" runat="server" Text=""></asp:Label>
                                <asp:LinkButton ID="btnChgMatrix" runat="server" Text="Matrix" Visible="false"  OnClick="btnBkgMaxtrix_Click"/>
                            </ItemTemplate>
                       </asp:TemplateField>
                    </Columns>                    
                </asp:GridView>
            </td>
            <td>
                <asp:GridView ID="gvDelResult" runat="server" BorderWidth="0" AutoGenerateColumns="False" 
                    CssClass="mGrid" PagerStyle-CssClass="pgr" AlternatingRowStyle-CssClass="alt"
                    OnRowDataBound="gvDelResult_RowDataBound" CellSpacing="1" Width="300">
                    <Columns>
                        <asp:TemplateField HeaderText="Charge" ItemStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <asp:Label ID="lblChgName" runat="server" Text=""></asp:Label>
                                <asp:HiddenField ID="lblChgCode" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Amount" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="75">
                            <ItemTemplate>
                                <asp:Label ID="lblChgAMT" runat="server" Text=""></asp:Label>
                                <asp:LinkButton ID="btnChgMatrix" runat="server" Text="Matrix" Visible="false" OnClick="btnDelMaxtrix_Click" />
                            </ItemTemplate>
                       </asp:TemplateField>
                    </Columns>                    
                </asp:GridView>
            </td>
        </tr>
    </table>   
    <br />
    <table>
        <tr>
            <td>
                <UC:ChargeMatrix runat="server" ID="ucChgMatrix" Visible="false" />                
            </td>
        </tr>
    </table>
</div>