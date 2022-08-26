<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"  CodeFile="TripRouteExpSearch.aspx.cs" Inherits="TyrePatternSearch" %>


<%@ Register
    Assembly="AjaxControlToolkit"
    Namespace="AjaxControlToolkit"
    TagPrefix="ajaxToolkit" %>
    
 <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 3px; font-weight: bold; vertical-align: top; color: #006633; text-align: left;">
                <br />Trip Route Expense Master<br />
                <br />
                <hr />  
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="left" style="vertical-align: top; text-align: left">
             <table cellspacing="1" width="900" class="boxbg">
                 <tr style="background-color: white">
                     <td align="right" colspan="3" style="text-align: left">
                <table cellspacing="1" style="width: 100%">
                    <tr style="background-color: white">
                        <td align="left" style="height: 26px">
                            <asp:Label ID="lblNew" runat="server" CssClass="blackfnt" Font-Bold="true" Text="New ?? "></asp:Label>
                            <asp:LinkButton ID="lnkCreateDriver" runat="server" Text="New Trip Route Expense" CssClass="bluefnt" Font-Bold="true" PostBackUrl="~/GUI/Fleet/TripRouteExpense/TripRouteExpMst.aspx"  ValidationGroup="VGCreate"></asp:LinkButton></td>
                        <td align="left" style="width: 7px; height: 26px;">
                            </td>
                        <td align="left" colspan="2" style="height: 26px; text-align: right">
                            <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                            <ContentTemplate>
                      
                            <asp:LinkButton ID="lnkbtnView" runat="server" CssClass="bluefnt" Font-Bold="True">View</asp:LinkButton>
                                <asp:Label ID="Label2" runat="server" Text="|"></asp:Label>
                                <asp:LinkButton ID="lnkbtnPrint" runat="server" CssClass="bluefnt" Font-Bold="True">Print</asp:LinkButton>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        </td>
                        <td align="left" style="width: 7px; height: 26px">
                            <asp:Label ID="Label3" runat="server" Text="|"></asp:Label></td>
                        <td align="left" style="width: 7px; height: 26px;">
                            <asp:LinkButton ID="lnkbtnXLS" runat="server" OnClick="lnkbtnXLS_Click" CssClass="bluefnt" Font-Bold="True">XLS</asp:LinkButton></td>
                    
                    </tr>
                </table>
                     </td>
                 </tr>
                       <tr style="background-color: white">
                        <td align="right" style="width: 25%; text-align: left; height: 18px;">
                            Select Route :</td>
                            <td align="left" colspan="2" style="width: 75%; height: 18px;">
                                <asp:DropDownList ID="ddlRoute" runat="server" Width="343px">
                                </asp:DropDownList></td>
                  </tr>
                  
                 <tr style="background-color: white">
                     <td align="right" style="width: 25%; text-align: left; height: 15px;">
                         </td>
                     <td align="left" colspan="2" style="width: 75%; height: 15px;">
                         </td>
                 </tr>
                    <tr style="background-color: white">
                        <td colspan="3" align="right">
                            <asp:UpdatePanel ID="UPShowTyre" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btnShowTyre" runat="server" Text="Show >>" ValidationGroup="VGDtFromTo" 
                                        OnClick="btnShowTyre_OnClick" />
                                    <asp:UpdateProgress runat="server" ID="Prog1">
                                        <ProgressTemplate>
                                            <asp:Image ID="imgWait" ImageUrl="~/GUI/images/indicator.gif" runat="server" BorderStyle="none" />
                                            <%--                                            <asp:Label ID="lblProgress" CssClass="blackfnt" Text="Wait.." runat="server" ForeColor="Red"></asp:Label>
--%>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                      
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                 <tr style="background-color: white">
                     <td align="right" colspan="3" style="width: 100%; text-align: left"><asp:UpdatePanel runat="server" ID="UpdatePanel1">
                         <ContentTemplate>
                        <asp:GridView ID="GridView1" runat="server" BorderWidth="1px" CellPadding="3" HeaderStyle-CssClass="dgHeaderStyle" 
                             AllowPaging="True" PageSize="50" PagerStyle-HorizontalAlign="left"               
                            PagerSettings-Mode="Numeric" AutoGenerateColumns="False"  
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#CCCCCC" DataKeyNames="ID" Width="100%" BackColor="White" BorderStyle="None">
                            <Columns>
                               
                                <asp:BoundField DataField="route_exp_code" HeaderText="Route Expense" >
                                    <ItemStyle HorizontalAlign="Left" Width="10%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>                               
                               
                                <asp:BoundField DataField="rutdesc" HeaderText="Route Description"> 
                                    <ItemStyle HorizontalAlign="Left" Width="25%" />    
                                      <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                 <asp:BoundField DataField="VEHICLE_TYPE" HeaderText="Vehicle Type" >
                                    <ItemStyle HorizontalAlign="Left" Width="20%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="fulexp_code" HeaderText="Trip Expense" >
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="standard_rate" HeaderText="Standard Rate" >
                                    <ItemStyle HorizontalAlign="Right"  Width="10%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                                              
                               
                                <asp:BoundField DataField="ACTIVE_FLAG" HeaderText="Active">
                                    <ItemStyle HorizontalAlign="Center"  Width="10%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:HyperLinkField  DataTextFormatString="--Select--" DataTextField="ID" DataNavigateUrlFields="ID"
                                    DataNavigateUrlFormatString="TripRouteExpMst.aspx?Id={0}" >
                                    <ItemStyle CssClass="bluelink" ForeColor="Blue" HorizontalAlign="Center" Width="15%" />
                                </asp:HyperLinkField>
                                
                            </Columns>
                            <RowStyle ForeColor="#000066" />
                            <PagerStyle HorizontalAlign="Left" BackColor="White" ForeColor="#000066" />
                            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" CssClass="dgHeaderStyle" />
                            <FooterStyle BackColor="White" ForeColor="#000066" />
                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        </asp:GridView>
                         </ContentTemplate>
                     </asp:UpdatePanel>
                     </td>
                 </tr>
                
                </table>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="left">
               </td>
        </tr>
    </table>

 
 </asp:Content>