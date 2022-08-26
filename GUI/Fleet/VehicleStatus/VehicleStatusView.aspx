<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="VehicleStatusView.aspx.cs" Inherits="GUI_Fleet_VehicleStatus_VehicleStatusView" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script type="text/javascript" language="javascript" src="AJAX_Validator/JScript.js"></script>
 <br />
 <br />
    <asp:HyperLink ID="HyperLink1" Font-Size="12px" Font-Bold="true" ForeColor="blue" Font-Underline="true"    runat="server" NavigateUrl="VehicleTracking.aspx" >Add New</asp:HyperLink>
 <asp:Table ID="tblMain" runat="server" HorizontalAlign="left" CssClass="boxbg"
            CellSpacing="1" BorderWidth="0" Width="80%" BorderStyle="Groove">
            
            <asp:TableRow CssClass="bgbluegrey" runat="server">
                <asp:TableCell HorizontalAlign="Center" ColumnSpan="2" CssClass="blackfnt" Style="height: 20px;" runat="server">
                    <b>Vehicle Tracking</b></asp:TableCell>
                </asp:TableRow>
            
            <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle" runat="server">
                <asp:TableCell HorizontalAlign="Left" runat="server">
                  Enter Vehicle Number
                </asp:TableCell> 
                <asp:TableCell Style="height: 24px;" HorizontalAlign="Left" runat="server" >
                
                    <asp:TextBox ID="txtVehNo" CssClass="input" runat="server" Width="140px" AutoCompleteType="Notes"></asp:TextBox>
                    <asp:Button ID="btnPopupVehno" runat="server" Text="..." Width="21px" />
                    <asp:Label ID="lblVehNoErr" CssClass="redfnt"  runat="server"></asp:Label>
                    <asp:Panel ID="Panel1" runat="server" Height="1px" ScrollBars="Both" Width="1px">
                        <asp:Panel ID="pnlDropdown" Height="200px" ScrollBars="Vertical" BackColor="Transparent" runat="server" BorderStyle="Inset" BorderWidth="1px" Direction="LeftToRight" Font-Names="Verdana" Font-Overline="False" Font-Size="8pt" Font-Underline="False" HorizontalAlign="Left"></asp:Panel>
                    </asp:Panel>
                    
                
                  <ajaxToolkit:AutoCompleteExtender
                runat="server" 
                BehaviorID="AutoCompleteEx"
                ID="autoComplete1" 
                TargetControlID="txtVehNo"
                ServicePath="../../../services/FleetAutoComplet.asmx" 
                ServiceMethod="GetVehNo"
                MinimumPrefixLength="1" 
                CompletionInterval="1000"
                EnableCaching="true"
                CompletionSetCount="20"
                CompletionListCssClass="autocomplete_completionListElement" 
                CompletionListItemCssClass="autocomplete_listItem" 
                CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                DelimiterCharacters=";, :"
                ShowOnlyCurrentWordInCompletionListItem="true" >
                <Animations>
                    <OnShow>
                        <Sequence>
                            <%-- Make the completion list transparent and then show it --%>
                            <OpacityAction Opacity="0" />
                            <HideAction Visible="true" />
                            
                            <%--Cache the original size of the completion list the first time
                                the animation is played and then set it to zero --%>
                            <ScriptAction Script="
                                // Cache the size and setup the initial size
                                var behavior = $find('AutoCompleteEx');
                                if (!behavior._height) {
                                    var target = behavior.get_completionList();
                                    behavior._height = target.offsetHeight - 2;
                                    target.style.height = '0px';
                                }" />
                            
                            <%-- Expand from 0px to the appropriate size while fading in --%>
                            <Parallel Duration=".4">
                                <FadeIn />
                                <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx')._height" />
                            </Parallel>
                        </Sequence>
                    </OnShow>
                    <OnHide>
                        <%-- Collapse down to 0px and fade out --%>
                        <Parallel Duration=".4">
                            <FadeOut />
                            <Length PropertyKey="height" StartValueScript="$find('AutoCompleteEx')._height" EndValue="0" />
                        </Parallel>
                    </OnHide>
                </Animations>
            </ajaxToolkit:AutoCompleteExtender>
                    <asp:HiddenField ID="hfVehIntId" runat="server" />
                    <asp:HiddenField ID="hfKm" runat="server" />
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgbluegrey">
              <asp:TableCell ColumnSpan="2" CssClass="blackfnt" Style="height: 20px;" HorizontalAlign="Right"  runat="server">
                  <asp:Button runat="server" OnClick="btn_Submit_Click"  ID="btn_Submit" Text="Submit" />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                <asp:TableCell  ColumnSpan="2">
                  <asp:GridView ID="gvVehicleStatus" runat="server" BorderWidth="1px" CellSpacing="1" CellPadding="5" HeaderStyle-CssClass="dgHeaderStyle" 
                             AllowPaging="True" PageSize="50" PagerStyle-HorizontalAlign="left"               
                            PagerSettings-Mode="Numeric" AutoGenerateColumns="False"  
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8BA0E5" DataKeyNames="ID" Width="100%"  OnPageIndexChanging="GridView1_PageIndexChanging">
                            <Columns>
                               
                                <asp:BoundField DataField="Vehicle_No" HeaderText="Vehicle Number"> 
                                    <ItemStyle HorizontalAlign="Left" Width="10%" />    
                                      <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Tripsheet_No" HeaderText="Tripsheet Number" >
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Locaiton" HeaderText="Locaiton">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Tracking_Date" HeaderText="Tracking Date">
                                    <ItemStyle HorizontalAlign="Left" Width="13%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Tracking_Time" HeaderText="Time (HH:MM)">
                                    <ItemStyle HorizontalAlign="Left" Width="12%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Remarks" HeaderText="Remarks">
                                    <ItemStyle HorizontalAlign="Left" Width="30%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                        </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            
            <table>
            <tr>
            <td>
             
            </td>
            </tr>
            </table>
</asp:Content>

