<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="GUI_UNI_MIS_UnUsed_missing_Result" %>

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
            <%--<tr style="background-color: #FFFFFF">
                <td style="width: 205; height: 6px;">
                    <label class="blackfnt">
                        Customer Code :</label></td>
                <td style="width: 343; height: 6px;">
                    &nbsp;
                    <asp:Label ID="lblcust" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
            </tr>--%>
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
            CellPadding="2"  CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="false"
            PageSize="25" PagerStyle-HorizontalAlign="left" CssClass="boxbg" 
           
            FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" OnRowDataBound="dgDocket_RowDataBound"
            EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange">
            <Columns>
               
                <asp:BoundField   DataField="Book_Code" HeaderText="Book Code">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt"  BackColor="white"/>
                </asp:BoundField>
                 <asp:TemplateField HeaderText="SR.NO."  ItemStyle-BackColor="white">
                                     <HeaderTemplate>
                                      <asp:Label CssClass="blackfnt" ID="lblColname12" Text="From - To"    runat="server"> </asp:Label>
                                     </HeaderTemplate>
                                        <ItemTemplate>
                                        
                                            <asp:Label CssClass="blackfnt" ID="lbldockfrom"  Text='<% #DataBinder.Eval(Container.DataItem, "Series_From")+" - " +DataBinder.Eval(Container.DataItem, "Series_To")%>'        runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="blackfnt" />
                                         <ItemStyle CssClass="blackfnt" Wrap="false" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    
                                     <asp:BoundField  Visible="false" DataField="Book_Code" HeaderText="Bokk No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt"  BackColor="white"/>
                </asp:BoundField>
                                    <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                     <HeaderTemplate>
                                      <asp:Label CssClass="blackfnt" ID="lblColname123" Text="Location"     runat="server"> </asp:Label>
                                     </HeaderTemplate>
                                        <ItemTemplate>
                                        
                                            <asp:Label CssClass="blackfnt" ID="lbldockfrom"  Text='<% #DataBinder.Eval(Container.DataItem, "loccode")+" - " +DataBinder.Eval(Container.DataItem, "locname")%>'       runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="blackfnt" />
                                         <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                <asp:BoundField  Visible="false" DataField="allocated_date" HeaderText="Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt"  BackColor="white"/>
                </asp:BoundField>
                 
                <asp:BoundField DataField="BA_Employee_name" HeaderText="Name">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="BA_Employee" HeaderText="BA/Employee">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="total_leafs" HeaderText="Total Pages (Used+UnUsed)">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
               
                 <asp:BoundField DataField="used" HeaderText="Missing No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                    
                </asp:BoundField>
                 <asp:BoundField DataField="used" HeaderText="Missing List">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                    
                </asp:BoundField>
                 <asp:BoundField DataField="used" HeaderText="Used No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="used" HeaderText="Used List">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="used" HeaderText="UnUsed No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="used" HeaderText="UnUsed List">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                
               
                
            </Columns>
           
            <RowStyle />
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        <br /><br />
        <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="center">
            
           
            <tr bgcolor="white">
                <td colspan="2" align="center">
                    <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                </td>
            </tr>
        </table>

</asp:Content>
