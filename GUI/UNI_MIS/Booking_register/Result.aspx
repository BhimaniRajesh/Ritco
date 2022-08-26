<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="GUI_UNI_MIS_Booking_register_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<p align="center">
            <label class="blackfnt">
                <b>You Selected </b>
            </label>
        </p>
        <%--<center>--%>
        <table border="0" cellpadding="3" width="565" 
            cellspacing="1" align="center" class="boxbg">
            <tr style="background-color: #ffffff">
                <td style="height: 10px">
                    <label class="blackfnt">
                        Date :</label></td>
                <td style="height: 10px">
                    <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
            </tr>
            <tr style="background-color: #FFFFFF">
                <td style="width: 205; height: 15px;">
                    <label class="blackfnt">
                        RO :</label></td>
                <td style="width: 343; height: 15px;">
                    &nbsp;
                    <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF">
                <td style="width: 205">
                    <label class="blackfnt">
                        Location :</label></td>
                <td style="width: 343">
                    &nbsp;
                    <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
            <tr style="background-color: #FFFFFF">
                <td style="width: 205; height: 6px;">
                    <label class="blackfnt">
                        Customer Code :</label></td>
                <td style="width: 343; height: 6px;">
                    &nbsp;
                    <asp:Label ID="lblcust" runat="server" CssClass="blackfnt"></asp:Label>
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
        <asp:GridView Visible="false" align="center" ID="dgDocket" runat="server"  BorderWidth="0"
            CellPadding="2"  CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true"
            PageSize="15" PagerStyle-HorizontalAlign="left" CssClass="boxbg" 
           
            FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" OnRowDataBound="dgDocket_RowDataBound"
            EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange">
            <Columns>
                <asp:TemplateField HeaderText="SR.NO."  ItemStyle-BackColor="white">
                    <ItemTemplate>
                        <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                            runat="server">
                        </asp:Label>
                    </ItemTemplate>
                     <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                     <HeaderTemplate>
                                      <asp:Label CssClass="blackfnt" ID="lblColname"    runat="server"> </asp:Label>
                                     </HeaderTemplate>
                                        <ItemTemplate>
                                        
                                            <asp:Label CssClass="blackfnt" ID="lbldockno"  Text='<% #DataBinder.Eval(Container.DataItem, "docket")%>'        runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="blackfnt" />
                                         <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                <asp:BoundField  Visible="false" DataField="docket" HeaderText="Docket No">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt"  BackColor="white"/>
                </asp:BoundField>
                 <asp:TemplateField HeaderText="SR.NO.">
                                     <HeaderTemplate>
                                      <asp:Label CssClass="blackfnt" ID="lblColDockdt"    runat="server"> </asp:Label>
                                     </HeaderTemplate>
                                        <ItemTemplate>
                                        
                                            <asp:Label CssClass="blackfnt"  ID="lblDockdt"  Text='<% #DataBinder.Eval(Container.DataItem, "docketdate")%>'        runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                                        <HeaderStyle CssClass="blackfnt" />
                                    </asp:TemplateField>
              
                <asp:BoundField DataField="cnor" HeaderText="Consignor">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="cnoee" HeaderText="Consignee">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="Destination" HeaderText="Destination">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="Truck_No" HeaderText="Truck No. ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="pkgsno" HeaderText="No. of Pkgs">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="PKGSTY" HeaderText="Pkgs Type">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="PRODCD" HeaderText="Said to Content">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="Actuwt" HeaderText="Act. Weight">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="dockno" HeaderText="Inv No">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="dockno" HeaderText="Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="paybas" HeaderText="Payment Basis">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="billno" HeaderText="Bill/MR No. No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                  <asp:BoundField DataField="billdate" HeaderText="Bill/MR Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                 <asp:BoundField DataField="billamt" HeaderText="Bill/MR Amt.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
            </Columns>
           
            <RowStyle />
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        
        <asp:GridView Visible="false" align="center" ID="dgBill" runat="server"  BorderWidth="0"
            CellPadding="2"  CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true"
            PageSize="15" PagerStyle-HorizontalAlign="left" CssClass="boxbg" 
           
            FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" OnRowDataBound="dgDocket_RowDataBound"
            EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange">
            <Columns>
                <asp:TemplateField HeaderText="SR.NO."  ItemStyle-BackColor="white">
                    <ItemTemplate>
                        <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                            runat="server">
                        </asp:Label>
                    </ItemTemplate>
                     <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                     <HeaderTemplate>
                                      <asp:Label CssClass="blackfnt" ID="lblColname"    runat="server"> </asp:Label>
                                     </HeaderTemplate>
                                        <ItemTemplate>
                                        
                                            <asp:Label CssClass="blackfnt" ID="lbldockno"  Text='<% #DataBinder.Eval(Container.DataItem, "docket")%>'        runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="blackfnt" />
                                         <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                <asp:BoundField  Visible="false" DataField="docket" HeaderText="Docket No">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt"  BackColor="white"/>
                </asp:BoundField>
                 <asp:TemplateField HeaderText="SR.NO.">
                                     <HeaderTemplate>
                                      <asp:Label CssClass="blackfnt" ID="lblColDockdt"    runat="server"> </asp:Label>
                                     </HeaderTemplate>
                                        <ItemTemplate>
                                        
                                            <asp:Label CssClass="blackfnt"  ID="lblDockdt"  Text='<% #DataBinder.Eval(Container.DataItem, "dockdt_date")%>'        runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                                        <HeaderStyle CssClass="blackfnt" />
                                    </asp:TemplateField>
              
                <asp:BoundField DataField="Destination" HeaderText="Destination">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="Bill_Type" HeaderText="Bill Type">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                 <asp:BoundField DataField="Billing_Party" HeaderText="Billing Party">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                 <asp:BoundField DataField="billno" HeaderText="Bill No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                 <asp:BoundField DataField="billdate" HeaderText="Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                 <asp:BoundField DataField="billamt" HeaderText="Amount">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                 <asp:BoundField DataField="billsubbrcd" HeaderText="Submitted at">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="billcolbrcd" HeaderText="Collection at">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="billno" HeaderText="Mr No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="billno" HeaderText="Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="Collection_amt" HeaderText="Collection Amount">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="deduction" HeaderText="Deduction">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
            </Columns>
           
            <RowStyle />
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        
        <asp:GridView Visible="false" align="center" ID="dgthc" runat="server"  BorderWidth="0"
            CellPadding="2"  CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true"
            PageSize="15" PagerStyle-HorizontalAlign="left" CssClass="boxbg" 
           
            FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" OnRowDataBound="dgDocket_RowDataBound"
            EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange">
            <Columns>
                <asp:TemplateField HeaderText="SR.NO."  ItemStyle-BackColor="white">
                    <ItemTemplate>
                        <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                            runat="server">
                        </asp:Label>
                    </ItemTemplate>
                     <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
                
                <asp:BoundField DataField="thcno" HeaderText="Challan No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                
                 <asp:BoundField DataField="thcdate" HeaderText="Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="false" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                 
                
                 <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                     <HeaderTemplate>
                                      <asp:Label CssClass="blackfnt" ID="lblColname"  Text="Docket No."   runat="server"> </asp:Label>
                                     </HeaderTemplate>
                                        <ItemTemplate>
                                        
                                            <asp:Label CssClass="blackfnt" ID="lbldockno"  Text='<% #DataBinder.Eval(Container.DataItem, "docket")%>'        runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="blackfnt" />
                                         <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                <asp:BoundField  Visible="false" DataField="docket" HeaderText="Docket No">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt"  BackColor="white"/>
                </asp:BoundField>
                 <asp:TemplateField HeaderText="SR.NO.">
                                     <HeaderTemplate>
                                      <asp:Label CssClass="blackfnt" ID="lblColDockdt"    runat="server"> </asp:Label>
                                     </HeaderTemplate>
                                        <ItemTemplate>
                                        
                                            <asp:Label CssClass="blackfnt"  ID="lblDockdt"  Text='<% #DataBinder.Eval(Container.DataItem, "dock_date")%>'        runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                                        <HeaderStyle CssClass="blackfnt" />
                                    </asp:TemplateField>
              
                <asp:BoundField DataField="Truck_No" HeaderText="Truck No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="vendor_name" HeaderText="Broker">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="pcamt" HeaderText="Lorry Hire Amount">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                 <asp:BoundField DataField="advamt" HeaderText="Adv Amt">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                 <asp:BoundField DataField="advpaiddt" HeaderText="Adv Paid Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="false" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="advpaidat" HeaderText="Adv Paid At">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="false" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="netbalamt" HeaderText="Bal Amt.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="BALAMTBRCD" HeaderText="Bal At">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="Detention" HeaderText="Detention">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
               <%-- <asp:BoundField DataField="Detention" HeaderText="Loading/Un Loading Charge">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>--%>
                
                <asp:TemplateField HeaderText="SR.NO.">
                                     <HeaderTemplate>
                                      <asp:Label CssClass="blackfnt" ID="lblColDockdt22"  Text="Loading/Un Loading Charge"   runat="server"> </asp:Label>
                                     </HeaderTemplate>
                                        <ItemTemplate>
                                        
                                            <asp:Label CssClass="blackfnt"  ID="lblDockdt11"  Text='<% #DataBinder.Eval(Container.DataItem, "load_chrg")+"/"+DataBinder.Eval(Container.DataItem, "unload_chrg")%>'        runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                                        <HeaderStyle CssClass="blackfnt" />
                                    </asp:TemplateField>
              
                
                <asp:BoundField DataField="penalty" HeaderText="Late Penalty">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="doth" HeaderText="Damage">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="dshort" HeaderText="Shortage">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="doth" HeaderText="Others">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
            </Columns>
           
            <RowStyle />
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>
 <br />
        <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="center">
            
           
            <tr bgcolor="white">
                <td colspan="2" align="center">
                    <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                </td>
            </tr>
        </table>

</asp:Content>
