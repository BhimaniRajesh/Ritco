<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"  CodeFile="MFG.aspx.cs" Inherits="admin_TyreSize" %>

   
 <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 3px; font-weight: bold; vertical-align: top; color: #006633; text-align: left;">
                <br />
                TYRE MANUFACTURER<br />
                <br />
                <hr />  
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="left" style="vertical-align: top; text-align: left">
             <table cellspacing="1" style="width: 60%" class="boxbg">
                 <tr style="background-color: white">
                     <td align="right" colspan="3" style="text-align: left">
                <table cellspacing="1" style="width: 100%">
                    <tr style="background-color: white">
                        <td align="left" style="height: 26px">
                            <asp:Label ID="lblNew" runat="server" CssClass="blackfnt" Font-Bold="true" Text="New ?? "></asp:Label>
                            <asp:LinkButton ID="lnkCreateDriver" runat="server" Text="Create Manufacturer" CssClass="bluefnt" Font-Bold="true" PostBackUrl="~/GUI/Fleet/Webadmin/Tyre/MFGDet.aspx"  ValidationGroup="VGCreate"></asp:LinkButton></td>
                        <td align="left" style="width: 7px; height: 26px;">
 <asp:UpdatePanel runat="server" ID="UpdatePanel1">
     <ContentTemplate>
     <asp:LinkButton ID="lnkbtnView" runat="server" CssClass="bluefnt" Font-Bold="True">View</asp:LinkButton>
     </ContentTemplate>
     <Triggers>
         <%--<asp:AsyncPostBackTrigger ControlID="UpdatePanel1" EventName="Load" />--%>
     </Triggers>
 </asp:UpdatePanel>

 
 </td>
                        <td align="left" style="width: 7px; height: 26px">
                            <asp:Label ID="Label2" runat="server" Text="|"></asp:Label></td>
                        <td align="left" style="width: 7px; height: 26px;">
                            <asp:LinkButton ID="lnkbtnPrint" runat="server" CssClass="bluefnt" Font-Bold="True">Print</asp:LinkButton></td>
                        <td align="left" style="width: 7px; height: 26px">
                            <asp:Label ID="Label3" runat="server" Text="|"></asp:Label></td>
                        <td align="left" style="width: 7px; height: 26px;">
                            <asp:LinkButton ID="lnkbtnXLS" runat="server" OnClick="lnkbtnXLS_Click" CssClass="bluefnt" Font-Bold="True" CausesValidation="False">XLS</asp:LinkButton></td>
                    
                    </tr>
                </table>
                     </td>
                 </tr>
                       <tr style="background-color: white">
                        <td align="right" style="width: 25%; text-align: left">
                  
                            <asp:Label ID="lblTyreSize" runat="server" Text="Enter Manufacturer Name:"  Font-Bold="True" CssClass="blackfnt"></asp:Label>
                  
                    </td>
                            <td align="left" colspan="2" style="width: 75%">
                            
                            
                                <asp:TextBox ID="txtManufacturerName" runat="server" CssClass="blackfnt"></asp:TextBox>
                                <asp:Button ID="btnPopupTyreMfg" runat="server" Text="..." Width="21px" />
                                
                 <ajaxToolkit:AutoCompleteExtender
                runat="server" 
                BehaviorID="AutoCompleteEx"
                ID="autoComplete1" 
                TargetControlID="txtManufacturerName"
                ServicePath="../../../../services/FleetAutoComplet.asmx" 
                ServiceMethod="GetTyreMfgName"
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
                        <td colspan="3" align="right">
                            <asp:UpdatePanel ID="UPShowTyre" runat="server" RenderMode="Inline">
                                <ContentTemplate>
                                    <asp:Button ID="btnShowTyreMfg" runat="server" Text="Show >>" 
                                        OnClick="btnShowTyre_OnClick" /><asp:UpdateProgress ID="Prog1" runat="server">
                                            <ProgressTemplate>
                                                <asp:Image ID="imgWait" runat="server" BorderStyle="none" ImageUrl="~/GUI/images/indicator.gif" />
                                            </ProgressTemplate>
                                        </asp:UpdateProgress>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                   
                        </td>
                    </tr>
                 <tr style="background-color: white">
                     <td align="right" colspan="3" style="width: 100%; text-align: left; "><asp:UpdatePanel runat="server" ID="UpdatePanel2">
                         <ContentTemplate>
                        <asp:GridView ID="GridView1" runat="server" BorderWidth="1px" CellSpacing="1" CellPadding="5" HeaderStyle-CssClass="dgHeaderStyle" 
                             AllowPaging="True" PageSize="50" PagerStyle-HorizontalAlign="left"               
                            PagerSettings-Mode="Numeric" AutoGenerateColumns="False"  
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8BA0E5" DataKeyNames="MFG_ID" Width="100%">
                            <Columns>
                               
                                <asp:BoundField DataField="MFG_NAME" HeaderText="Tyre Manufacturer Name"> 
                                    <ItemStyle HorizontalAlign="Left" Width="40%" />    
                                      <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:BoundField DataField="MFG_ADDR" HeaderText="Address" >
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                    <asp:BoundField DataField="MFG_TELNO" HeaderText="Contact Number" >
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:BoundField DataField="MFG_ACTIVEFLAG" HeaderText="Active Flag">
                                    <ItemStyle HorizontalAlign="Left" Width="10%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:HyperLinkField DataTextFormatString="--Select--" DataTextField="MFG_ID" DataNavigateUrlFields="MFG_ID"
                                    DataNavigateUrlFormatString="MFGDet.aspx?id={0}" >
                                    <ItemStyle CssClass="bluelink" ForeColor="Blue" HorizontalAlign="Center" Width="10%" />
                                </asp:HyperLinkField>
                               
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                        </ContentTemplate>
                         <Triggers>
                          <%--   <asp:AsyncPostBackTrigger ControlID="UpdatePanel1" EventName="Load" />--%>
                         </Triggers>
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