<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="InsuramceReportResult.aspx.cs" Inherits="GUI_UNI_MIS_DOC_Profit_InsuramceReportResult" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <strong><span style="font-size: 8pt"></span></strong>
    <br />
    <br />
    <table align="center" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="565">
        <tr style="background-color: #ffffff">
            <td colspan="2" style="height: 10px; text-align: center">
                <strong><span style="font-size: 8pt">You Selected</span></strong></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="height: 10px">
                <label class="blackfnt">
                    Date :</label></td>
            <td style="height: 10px">
                <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 205px; height: 15px">
                <label class="blackfnt">
                    RO :</label></td>
            <td style="font-weight: bold; width: 343px; height: 15px">
                <asp:Label ID="lblro" runat="server" CssClass="blackfnt" Font-Bold="False"></asp:Label>
            </td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 205px">
                <label class="blackfnt">
                    Location :</label></td>
            <td style="width: 343px">
                <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        <%-- <tr style="background-color: #ffffff">
                <td style="height: 6px">
                    <label class="blackfnt">
                        Document Type :
                    </label>
                </td>
                <td style="height: 6px">
                    <asp:Label ID="lblflow" runat="server" CssClass="blackfnt"> 
                    </asp:Label></td>
            </tr>--%>
    </table>
    <br />
    <br />
    <asp:GridView ID="dgDocket" runat="server" align="left" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" BorderWidth="0px" CellPadding="2" CellSpacing="1"
        CssClass="boxbg" EmptyDataText="No Records Found..." FooterStyle-CssClass="boxbg"
        HeaderStyle-CssClass="bgbluegrey" OnPageIndexChanging="pgChange" 
        PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" PagerSettings-Mode="NumericFirstLast"
        PagerStyle-HorizontalAlign="left" PageSize="25" Visible="False" OnSelectedIndexChanged="dgDocket_SelectedIndexChanged">
        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
        <FooterStyle CssClass="boxbg" />
        <Columns>
            <asp:TemplateField HeaderText="SR.NO.">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                <HeaderStyle CssClass="blackfnt" />
                <ItemTemplate>
                    <asp:Label ID="lblsrno" runat="server" CssClass="blackfnt" Text="<%# Container.DataItemIndex+1 %>">
                        </asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:BoundField DataField="dockno" HeaderText="GR NO" >
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="dock_dt" HeaderText="GR DATE" >
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="ManualTHCNo" HeaderText="THC NO/MANUAL">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="ULoadingDate" HeaderText="U/LOADING DATE">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
             <asp:BoundField DataField="vehno" HeaderText="VEHICLE NO" >
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
             <asp:BoundField DataField="From_loc" HeaderText="FROM">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="to_loc" HeaderText="TO">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Freight" HeaderText="FREIGHT">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="thcdat" HeaderText="POSTED DATE">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="orgncd" HeaderText="BKG STN" >
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="destcd" HeaderText="DLY STN" >
                <ItemStyle BackColor="White" CssClass="blackfnt"  HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="truckno" HeaderText="THC NO">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="invno" HeaderText="INVOICE NO" >
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Right" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="invdt" HeaderText="INVOICE DATE" >
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
             <asp:BoundField DataField="invamt" HeaderText="INVOICE VALUE" >
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Right" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="pkgsty" HeaderText="MATERIAL CONTENT" >
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="cnorname" HeaderText="BILLING PARTY">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            
            
           
            
           <%-- <asp:BoundField DataField="insupl" HeaderText="RISK TYPE" >
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>--%>
            
        </Columns>
        <PagerStyle CssClass="bgbluegrey" HorizontalAlign="Center" />
        <HeaderStyle CssClass="bgbluegrey" />
    </asp:GridView>
    &nbsp;<br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
     <br />
      <br />
       <br />
        <br />
       <br />
    <table cellspacing="0" cellpadding="0"  align="Center" bgColor="white" border="0"><tbody>
    <tr bgColor="white"><td align="center" colspan="2"><asp:Button id="btn_csv" onclick="btn_csv_Click" runat="server" Text="DownLoad XLS" Width="170"></asp:Button> 
    </td></tr></tbody></table>
    
</asp:Content>

