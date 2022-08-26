<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="GUI_UNI_MIS_Route_summary_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<table id="Table1" HorizontalAlign="left" runat="server" CellPadding="3" CellSpacing="1" style="width:8.5in;" CssClass="boxbg">
 <tr>
 <td>

    <br />
    <br />
    <table border="0" HorizontalAlign="left" id="Cri" runat="server"  CellPadding="3" CellSpacing="1" style="width:5.5in;" Class="boxbg">
    <tr bgcolor="white" class="blackfnt"><td>Date</td><td><asp:Label  runat="server" ID="LBLDATE"></asp:Label></td></tr>
    <tr bgcolor="white" class="blackfnt"><td>Route</td><td><asp:Label  runat="server" ID="LBLBRANCH"></asp:Label></td></tr>
    <tr bgcolor="white" class="blackfnt"><td>Report Type</td><td><asp:Label  runat="server" ID="LBLRPT"></asp:Label></td></tr>
        <tr bgcolor="white" class="blackfnt">
            <td>
                Vendor</td>
            <td>
                <asp:Label ID="lblVendor" runat="server"></asp:Label></td>
        </tr>
  </table><br /><br />
    <br />
    <asp:GridView Visible="false" align="left" ID="dgROute" runat="server"  BorderWidth="0"
            CellPadding="3"  CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="false" 
             CssClass="boxbg" 
              AutoGenerateColumns="false"   OnRowDataBound="dgROute_RowDataBound"         
            FooterStyle-CssClass="boxbg" 
            EmptyDataText="No Records Found..."  >
            <Columns>
            <asp:BoundField DataField="main_thcno" HeaderText="DOC No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  Font-Bold="true" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" Font-Bold="true" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="Vehno" HeaderText="Veh No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" Font-Bold="true" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="route" HeaderText="Route">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white"  Wrap="False"  Font-Bold="true" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="Vendorcd" HeaderText="Vendor Name">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white"  Wrap="False"  Font-Bold="true" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="srno" HeaderText="srno">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False"  CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                  <asp:BoundField DataField="source" HeaderText="Source">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" HorizontalAlign="Right"  Wrap="False" CssClass="blackfnt"  />
                </asp:BoundField>
                <asp:BoundField DataField="destination" HeaderText="Destination">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" HorizontalAlign="Right"  Wrap="False" CssClass="blackfnt" />
                </asp:BoundField>
                
                <asp:BoundField DataField="ADT" HeaderText="ADT">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="DDT" HeaderText="DDT">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="THC_Status" HeaderText="DOC Status">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="MF_Status" HeaderText="MF Status">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="Docket" HeaderText="Docket">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="Docket_Orgin" HeaderText="Origin">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="Docket_Destination" HeaderText="Destination">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                    
                </asp:BoundField>
                 <asp:BoundField DataField="Docket_Currently_At" HeaderText="Current Location">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="Subtotal" HeaderText="Sub Total">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="right" />
                </asp:BoundField>
                 <asp:BoundField DataField="pkgsno" HeaderText="PKGs">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="right" />
                </asp:BoundField>
                 <asp:BoundField DataField="actuwt" HeaderText="Act. Wt.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="right" />
                </asp:BoundField>
                 <asp:BoundField DataField="chrgwt" HeaderText="Chrg. Wt">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="right" />
                </asp:BoundField>
                 <asp:BoundField DataField="Yield" HeaderText="Yield">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="right" />
                </asp:BoundField>
                
            </Columns>
            </asp:GridView>
            <asp:GridView Visible="false" align="left" ID="dg_LOC" runat="server"  BorderWidth="0"
            CellPadding="3"  CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="false" 
             CssClass="boxbg" 
              AutoGenerateColumns="false"           
            FooterStyle-CssClass="boxbg" 
            EmptyDataText="No Records Found..." >
            <Columns>
             <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
             <asp:BoundField DataField="VEHno" HeaderText="Vehicle NO">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  Font-Bold="true" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" Font-Bold="true" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
            <asp:BoundField DataField="Docket_orgin" HeaderText="Location">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  Font-Bold="true" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" Font-Bold="true" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="tot_dkt" HeaderText="Total DOC.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="Subtotal" HeaderText="Subtotal">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white"  Wrap="False" CssClass="blackfnt" HorizontalAlign="right" />
                </asp:BoundField>
                 <asp:BoundField DataField="pkgsno" HeaderText="PKGS">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="right" />
                </asp:BoundField>
                
                  <asp:BoundField DataField="actuwt" HeaderText="ACT. Wt.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" HorizontalAlign="Right"  Wrap="False" CssClass="blackfnt"  />
                </asp:BoundField>
                <asp:BoundField DataField="chrgwt" HeaderText="Chrg. Wt.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" HorizontalAlign="Right"  Wrap="False" CssClass="blackfnt" />
                </asp:BoundField>
                
                <asp:BoundField DataField="Yield" HeaderText="Yield">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="right" />
                </asp:BoundField>
               
                
            </Columns>
            </asp:GridView>
            
              <asp:GridView Visible="false" align="left" ID="dg_CUST" runat="server"  BorderWidth="0"
            CellPadding="3"  CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="false" 
             CssClass="boxbg" 
              AutoGenerateColumns="false"           
            FooterStyle-CssClass="boxbg" 
            EmptyDataText="No Records Found..." >
            <Columns>
             <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
            <asp:BoundField DataField="VEHno" HeaderText="Vehicle NO">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  Font-Bold="true" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" Font-Bold="true" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
             <asp:BoundField DataField="Party" HeaderText="Party">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  Font-Bold="true" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" Font-Bold="true" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="tot_dkt" HeaderText="Total DOC.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="Subtotal" HeaderText="Subtotal">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white"  Wrap="False" CssClass="blackfnt" HorizontalAlign="right" />
                </asp:BoundField>
                 <asp:BoundField DataField="pkgsno" HeaderText="PKGS">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="right" />
                </asp:BoundField>
                
                  <asp:BoundField DataField="actuwt" HeaderText="ACT. Wt.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" HorizontalAlign="Right"  Wrap="False" CssClass="blackfnt"  />
                </asp:BoundField>
                <asp:BoundField DataField="chrgwt" HeaderText="Chrg. Wt.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" HorizontalAlign="Right"  Wrap="False" CssClass="blackfnt" />
                </asp:BoundField>
                
                <asp:BoundField DataField="Yield" HeaderText="Yield">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="right" />
                </asp:BoundField>
            </Columns>
            </asp:GridView>
    <br />
    </td>
 </tr>
 



</table>


</asp:Content>
