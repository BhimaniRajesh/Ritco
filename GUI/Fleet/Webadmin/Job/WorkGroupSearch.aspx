<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"  CodeFile="WorkGroupSearch.aspx.cs" Inherits="WorkGroupSearch" %>
<%@ Register
    Assembly="AjaxControlToolkit"
    Namespace="AjaxControlToolkit"
    TagPrefix="ajaxToolkit" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
 
 
    <table cellspacing="1" style="width: 800px">
        <tr style="background-color: white">
            <td align="left" >
                
                <font class="blklnkund"><strong>Fleet</strong></font> <strong>&gt; </strong>
                <font class="blklnkund"><strong>Jobsheet Master</strong></font><strong>&gt; </strong>
                <font class="bluefnt"><strong>Work Group Master</strong></font>&nbsp;</td><br />
               
                <br>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="left" style="vertical-align: top; text-align: left">
             <hr size=-1>  
             <table cellspacing="1" style="width: 100%" class="boxbg">
                 <tr style="background-color: white">
                     <td align="right" colspan="3" style="text-align: left">
                <table cellspacing="1" style="width: 100%">
                    <tr style="background-color: white">
                        <td align="left" style="height: 26px">
                            <asp:Label ID="lblNew" runat="server" CssClass="blackfnt" Font-Bold="true" Text="New ?? "></asp:Label>
                            <asp:LinkButton ID="lnkCreateDriver" runat="server" Text="Create Group" CssClass="bluefnt" Font-Bold="true" PostBackUrl="~/GUI/Fleet/Webadmin/Job/WorkGroup.aspx"  ValidationGroup="VGCreate"></asp:LinkButton></td>
                        <td align="left" style="width: 7px; height: 26px;">
                            &nbsp;</td>
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
                        <td colspan="3" align="right">
                            <asp:UpdatePanel ID="UPShowTyre" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btnShow" runat="server" Text="Show >>" ValidationGroup="VGDtFromTo" 
                                        OnClick="btnShow_OnClick" />
                                    <asp:UpdateProgress runat="server" ID="Prog1">
                                        <ProgressTemplate>
                                            <asp:Image ID="imgWait" ImageUrl="~/GUI/images/indicator.gif" runat="server" BorderStyle="none" />
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                      
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                 <tr style="background-color: white">
                     <td align="right" colspan="3" style="width: 100%; text-align: left">
                        <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                         <ContentTemplate>
                        <asp:GridView ID="GridView1" runat="server" BorderWidth="1px" CellSpacing="1" CellPadding="5" HeaderStyle-CssClass="dgHeaderStyle" 
                             AllowPaging="True" PageSize="50" PagerStyle-HorizontalAlign="left"               
                            PagerSettings-Mode="Numeric" AutoGenerateColumns="False"  
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8BA0E5" DataKeyNames="W_GRPCD" Width="100%">
                            <Columns>
                               
                                <asp:BoundField DataField="W_GRPCD" Visible="false" HeaderText="Work Group Code" >
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>                               
                               
                                <asp:BoundField DataField="W_GRPDESC" HeaderText="Work Group Description"> 
                                    <ItemStyle HorizontalAlign="Left" Width="25%" />    
                                      <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                
                                <%--<asp:BoundField DataField="AccDesc" HeaderText="Expense Ledger Code"> 
                                    <ItemStyle HorizontalAlign="Left" Width="55%" />    
                                      <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>--%>
                                
                                <asp:BoundField DataField="ACTIVE_FLAG" HeaderText="Active Flag">
                                    <ItemStyle HorizontalAlign="Left" Width="10%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:HyperLinkField DataTextFormatString="--Edit--" DataTextField="W_GRPCD" DataNavigateUrlFields="W_GRPCD"
                                    DataNavigateUrlFormatString="WorkGroup.aspx?WorkGroupCode={0}" >
                                    <ItemStyle CssClass="bluelink" ForeColor="Blue" HorizontalAlign="Center" Width="15%" />
                                </asp:HyperLinkField>
                                
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
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
                &nbsp;</td>
        </tr>
    </table>

 
 </asp:Content>
