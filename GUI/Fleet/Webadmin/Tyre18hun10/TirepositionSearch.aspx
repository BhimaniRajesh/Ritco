<%@ Page Language="C#" Title="Tyre Position"  AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"  CodeFile="TirepositionSearch.aspx.cs" Inherits="admin_TyreSize" %>


    
 <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 3px; font-weight: bold; vertical-align: top; color: #006633; text-align: left;">
                <br />TYRE POSITION MASTER<br />
                <br />  
                <hr />  
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="left" style="vertical-align: top; text-align: left">
             <table cellspacing="1" style="width: 75%" class="boxbg">
                 <tr style="background-color: white">
                     <td align="right" colspan="3" style="text-align: left">
                <table cellspacing="1" style="width: 100%">
                    <tr style="background-color: white">
                        <td align="left" style="height: 26px">
                            <asp:Label ID="lblNew" runat="server" CssClass="blackfnt" Font-Bold="true" Text="New ?? "></asp:Label>
                            <asp:LinkButton ID="lnkCreateTirePos" runat="server" Text="Create Tyre Position Entry" CssClass="bluefnt" Font-Bold="true" PostBackUrl="~/GUI/Fleet/Webadmin/Tyre/TyrePosition.aspx"  ValidationGroup="VGCreate"></asp:LinkButton></td>
                        <td align="left" style="width: 7px; height: 26px;"><asp:UpdatePanel runat="server" ID="UpdatePanel2">
                            <ContentTemplate>
                             <asp:LinkButton ID="lnkbtnView" runat="server" CssClass="bluefnt" Font-Bold="True">View</asp:LinkButton>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        </td>
                        <td align="left" style="width: 7px; height: 26px">
                            <asp:Label ID="Label2" runat="server" Text="|"></asp:Label></td>
                                
                        <td align="left" style="width: 7px; height: 26px;">
                            <asp:LinkButton ID="lnkbtnPrint" runat="server" CssClass="bluefnt" Font-Bold="True">Print</asp:LinkButton></td>
                        <td align="left" style="width: 7px; height: 26px">
                            <asp:Label ID="Label3" runat="server" Text="|"></asp:Label></td>
                        <td align="left" style="width: 7px; height: 26px;">
                            <asp:LinkButton ID="lnkbtnXLS" runat="server" OnClick="lnkbtnXLS_Click" CssClass="bluefnt" Font-Bold="True">XLS</asp:LinkButton></td>
                    
                    </tr>
                </table>
                     </td>
                 </tr>
                       <tr style="background-color: white">
                        <td align="right" style="width: 25%; text-align: left">
                  
                            <asp:Label ID="lblTyrePos" runat="server" Text="Enter Tyre Position Code:"  Font-Bold="True" CssClass="blackfnt"></asp:Label>
                  
                    </td>
                            <td align="left" colspan="2" style="width: 75%">
                                <asp:TextBox ID="txtPosition" runat="server" CssClass="blackfnt"></asp:TextBox>
                                <asp:Button ID="btnPopupTyrePos" runat="server" Text="..." Width="21px" />
               
                 <ajaxToolkit:AutoCompleteExtender
                runat="server" 
                BehaviorID="AutoCompleteEx"
                ID="autoComplete1" 
                TargetControlID="txtPosition"
                ServicePath="../../../../services/FleetAutoComplet.asmx" 
                ServiceMethod="GetTyrePosCode"
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
                       
                                </td>
                  </tr>
                 <tr style="background-color: white">
                     <td align="right" style="width: 25%; text-align: left">
                         <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Select Tyre Position:"></asp:Label></td>
                     <td align="left" colspan="2" style="width: 75%">
                         <asp:DropDownList ID="ddlTyrePosition" runat="server" Width="113px">
                         </asp:DropDownList></td>
                 </tr>
                 <tr style="background-color: white">
                     <td align="right" style="width: 25%; text-align: left">
                         <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Select Vehicle Category:"></asp:Label></td>
                     <td align="left" colspan="2" style="width: 75%">
                         <asp:DropDownList ID="ddlVehCategory" runat="server" Width="113px">
                         </asp:DropDownList></td>
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
                        <asp:GridView ID="GridView1" runat="server" BorderWidth="1px" CellSpacing="1" CellPadding="5" HeaderStyle-CssClass="dgHeaderStyle" 
                             AllowPaging="True" PageSize="50" PagerStyle-HorizontalAlign="left"               
                            PagerSettings-Mode="Numeric" AutoGenerateColumns="False"  
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8BA0E5" DataKeyNames="TYREPOS_ID" Width="100%">
                            <Columns>
                               
                                <asp:BoundField DataField="TYREPOS_CODE" HeaderText="Tyre Position Code"> 
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                      <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:BoundField DataField="TYREPOS_DESC" HeaderText="Tyre Position Description" >
                                    <ItemStyle HorizontalAlign="Left" Width="35%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                    <asp:BoundField DataField="TYREPOSITION" HeaderText="Tyre Position Allowed" >
                                    <ItemStyle HorizontalAlign="Left" Width="10%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                    <asp:BoundField DataField="VEHCATEGORY" HeaderText="Vehicle Type Category" >
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                               
                               
                                <asp:BoundField DataField="ACTIVE_FLAG" HeaderText="Active Flag">
                                    <ItemStyle HorizontalAlign="Left" Width="10%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:HyperLinkField DataTextFormatString="--Select--" DataTextField="TYREPOS_ID" DataNavigateUrlFields="TYREPOS_ID"
                                    DataNavigateUrlFormatString="TyrePosition.aspx?TyrePosId={0}" >
                                    <ItemStyle CssClass="bluelink" ForeColor="Blue" HorizontalAlign="Center" Width="20%" />
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