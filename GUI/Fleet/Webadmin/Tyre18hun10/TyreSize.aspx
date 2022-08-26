<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"  CodeFile="TyreSize.aspx.cs" Inherits="admin_TyreSize" %>


 <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 3px; font-weight: bold; vertical-align: top; color: #006633; text-align: left;">
               <br /> TYRE SIZE MASTER<br />
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
                            <asp:LinkButton ID="lnkCreateDriver" runat="server" Text="Create Tyre Size Entry" CssClass="bluefnt" Font-Bold="true" PostBackUrl="~/GUI/Fleet/Webadmin/Tyre/TyreSizeDet.aspx"  ValidationGroup="VGCreate"></asp:LinkButton></td>
                        <td align="left" colspan="3" style="height: 26px; text-align: right">
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
                        <td align="right" style="width: 25%; text-align: left">
                  
                            <asp:Label ID="lblTyreSize" runat="server" Text="Enter Size Name:"  Font-Bold="True" CssClass="blackfnt"></asp:Label>
                  
                    </td>
                            <td align="left" colspan="2" style="width: 75%">
                            
                            
                                <asp:TextBox ID="txtSizeName" runat="server" CssClass="blackfnt"></asp:TextBox>
                                <asp:Button ID="btnPopupTyreSize" runat="server" Text="..." Width="21px" />
               
                 <ajaxToolkit:AutoCompleteExtender
                runat="server" 
                BehaviorID="AutoCompleteEx"
                ID="autoComplete1" 
                TargetControlID="txtSizeName"
                ServicePath="../../../../services/FleetAutoComplet.asmx" 
                ServiceMethod="GetTyreSize"
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
                         <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Tyre Type Category:"></asp:Label></td>
                     <td align="left" colspan="2" style="width: 75%">
                         <asp:DropDownList ID="ddlTyreCategory" runat="server" Width="113px">
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
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8BA0E5" DataKeyNames="TYRE_SIZEID" Width="100%">
                            <Columns>
                               
                                <asp:BoundField DataField="Tyre_SizeName" HeaderText="Size Name"> 
                                    <ItemStyle HorizontalAlign="Left" Width="40%" />    
                                      <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:BoundField DataField="TYRETYPE" HeaderText="Tyre Type" >
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                               
                               
                                <asp:BoundField DataField="Size_ACTIVEFLAG" HeaderText="Active Flag">
                                    <ItemStyle HorizontalAlign="Left" Width="10%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:HyperLinkField DataTextFormatString="--Select--" DataTextField="TYRE_SIZEID" DataNavigateUrlFields="TYRE_SIZEID"
                                    DataNavigateUrlFormatString="TyreSizeDet.aspx?id={0}" >
                                    <ItemStyle CssClass="bluelink" ForeColor="Blue" HorizontalAlign="Center" Width="10%" />
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