<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="CallSummary_Locationwise3.aspx.cs" Inherits="REPORT_CallSummary_Locationwise3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript">

function OpenWindow(prospectcode)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
            var strURL = "pros_reg_detail.aspx?prospectcode="+prospectcode    
            winNew = window.open(strURL,"_blank",strWinFeature)
        }
</script>

<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="VistSummary-Location Wise Report" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        </table>
        <br />
        
        
        <asp:GridView ID="dgCallSummary" runat="server" BorderWidth="1" CellSpacing="1" CellPadding="5" HeaderStyle-CssClass="bgbluegrey"
                            AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"                             
                            PagerSettings-Mode="Numeric" AutoGenerateColumns="false" ShowFooter="true" FooterStyle-CssClass="bgbluegrey"
                            CssClass="blackfnt" EmptyDataText="No Records Found..." BorderColor="#8ba0e5" OnPageIndexChanging="pgChange" Width="100%">
                            <Columns>
                                
                                 <asp:TemplateField HeaderText="SRNo." >
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" />
                                <ItemStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                <asp:Label ID="lblSRNo" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                </asp:Label>
                                </ItemTemplate>
                                </asp:TemplateField>   
                              
                                <asp:BoundField DataField="callCode" HeaderText="CallCode" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="callDt" HeaderText="CallDate" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CallTime" HeaderText="CallTime" HeaderStyle-CssClass ="bgbluegrey" HeaderStyle-Width="10px" > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  Width="10px"/>
                                </asp:BoundField>
                                    
                                <asp:BoundField DataField="PersonCalled" HeaderText="Person Met" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:TemplateField HeaderText="ProspectId">
                                     <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="bgbluegrey" Width="300px"/>
                                     <ItemStyle CssClass="blackfnt" Font-Bold="true" />
                                     <ItemTemplate>
                                        <a href="JavaScript:OpenWindow('<%#DataBinder.Eval(Container.DataItem, "prospectcode") %>')">                                   
                                            <%#DataBinder.Eval(Container.DataItem, "prospectcode") + ":" + DataBinder.Eval(Container.DataItem, "prospectname")%>
                                            
                                        </a>
                                    </ItemTemplate>
                                    </asp:TemplateField>
                                
                                <%--<asp:BoundField DataField="prospectcode" HeaderText="ProspectId" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>--%>
                                
                                <asp:BoundField DataField="callduration" HeaderText="Duration in Min" HeaderStyle-CssClass ="bgbluegrey" HeaderStyle-Width = "10px"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:BoundField DataField="discPoint" HeaderText="DiscPoint" HeaderStyle-CssClass ="bgbluegrey"> 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="AcctCategory" HeaderText="AccCategory" HeaderStyle-CssClass ="bgbluegrey" HeaderStyle-Width="10px"> 
                                    <HeaderStyle HorizontalAlign="Center" Width="5px" />
                                </asp:BoundField>
                                
                                 <asp:BoundField DataField="entryby" HeaderText="Sales Person" HeaderStyle-CssClass ="bgbluegrey" HeaderStyle-Width="10px"> 
                                    <HeaderStyle HorizontalAlign="Center" Width="10px" />
                                </asp:BoundField>
                                
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
        
        </asp:Content>
