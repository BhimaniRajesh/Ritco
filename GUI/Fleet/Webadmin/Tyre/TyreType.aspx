<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"   CodeFile="TyreType.aspx.cs" Inherits="admin_TyreType" %>

 
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
 
        <!--End of Atlas Script Manager -->
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Tyre Type Master</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
        </tr>
    </table>
             
   <p align="center">
   <table cellspacing="1" style="width: 100%">
     <tr align="center">
            <td>
                <table cellspacing="1" style="width: 70%">
                    <tr style="background-color: white">
                        <td align="left">
                            <asp:Label ID="lblNew" runat="server" CssClass="blackfnt" Font-Bold="true" Text="New ?? "></asp:Label>
                            <asp:LinkButton ID="lnkCreateDriver" runat="server" Text="Create Tyre Type Entry" CssClass="bluefnt" Font-Bold="true" PostBackUrl="~/GUI/Fleet/Webadmin/Tyre/TyreTypeDet.aspx"  ValidationGroup="VGCreate"></asp:LinkButton>    
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr align="center">
           <td>
             <table cellspacing="1" style="width: 70%" class="boxbg">
                    <tr class="bgbluegrey">
                        <td colspan="3" align="center">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                        </td>
                </tr>
                    
                    
                     <tr style="background-color: white">
                        <td align="right">
                            <asp:Label ID="lblDateRange1" CssClass="blackfnt" runat="server" Font-Bold="true">
                            Enter   Tyre Type Created Date Range:
                            </asp:Label>
                        </td>
                        <td align="left">
                            <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        AutoPostBack="true" OnSelectedIndexChanged="radDate_OnSelectedIndexChange">
                                        <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="2" Text=" Today:"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="3" Text=" Till Date:"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                        <td valign="top" align="left">
                            <asp:UpdatePanel ID="UpdatePanel2" RenderMode="Inline" UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                    <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                    </br>
                                    <asp:RequiredFieldValidator ID="RFVFromDate" runat="server" ControlToValidate="txtDateFrom"
                                        ErrorMessage="Date From cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                                    </br>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Date From  :("
                                        ControlToValidate="txtDateFrom" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                    </br>
                                    <asp:RequiredFieldValidator ID="RFVToDate" runat="server" ControlToValidate="txtDateTo"
                                        ErrorMessage="Date To cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                                    </br>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid Date To  :("
                                        ControlToValidate="txtDateTo" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                        </tr>
                       <tr style="background-color: white">
                        <td align="right">
                  
                            <asp:Label ID="lblMFGName" runat="server" Text="Enter Tyre Type Name"  Font-Bold="true" CssClass="blackfnt"></asp:Label>
                  
                    </td>
                            <td align="left" colspan="2">
                            
                            
                                <asp:TextBox ID="txtTypeName" runat="server" CssClass="blackfnt"></asp:TextBox>
                            
      
                         <ajaxToolkit:AutoCompleteExtender
                runat="server" 
                BehaviorID="AutoCompleteEx"
                ID="autoComplete1" 
                TargetControlID="txtTypeName"
                ServicePath="../../../../services/FleetAutoComplet.asmx" 
                ServiceMethod="GetBlogTYRETYPETitlesForAutoComplete"
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
                </table>
            </td>
        </tr>
       
    </table>
   <br />
 
 
   <table cellspacing="1" style="width: 80%">
        <tr align="center">
            <td align="center">
                <asp:UpdatePanel ID="u1" UpdateMode="Conditional" runat="server">
                    <ContentTemplate>
                   <%-- DataSourceID="ObjectDataSource1" EnableViewState="False"--%>
                        <asp:GridView ID="GridView1" runat="server" BorderWidth="1px" CellSpacing="1" CellPadding="5" HeaderStyle-CssClass="dgHeaderStyle" 
                             AllowPaging="True" PageSize="50" PagerStyle-HorizontalAlign="left"               
                            PagerSettings-Mode="Numeric" AutoGenerateColumns="False"  
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8BA0E5" OnPageIndexChanging="pgChange" OnRowCommand="dg_RowCommand" DataKeyNames="TYRE_TYPEID">
                            <Columns>
                                <asp:HyperLinkField DataTextFormatString="--Select--" DataTextField="TYRE_TYPEID" DataNavigateUrlFields="TYRE_TYPEID"
                                    DataNavigateUrlFormatString="TyreTypeDet.aspx?id={0}" >
                                    <ItemStyle CssClass="bluelink" ForeColor="Blue" />
                                </asp:HyperLinkField>
                               <asp:BoundField DataField="TYRE_TYPEID" HeaderText="Tyre Type Id" >
                                    <ItemStyle HorizontalAlign="Left" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                               
                                <asp:BoundField DataField="Tyre_TypeName" HeaderText="Type Name"> 
                                    <ItemStyle HorizontalAlign="Left" />    
                                      <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="TYPE_ACTIVEFLAG" HeaderText="Active Flag">
                                    <ItemStyle HorizontalAlign="Left" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                      
                                <asp:BoundField DataField="TYPE_ENTRYBY" HeaderText="Type.EntryBy" >
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>     
                               
                                <asp:BoundField DataField="TypeDate" HeaderText="Type Entry Date">
                                    <ItemStyle HorizontalAlign="Left" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                                            
                                <asp:BoundField DataField="CodeDesc" HeaderText="Type Description">
                                    <ItemStyle HorizontalAlign="Left" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>                         
                                                            
                                                            
                             </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                        <%--<asp:ObjectDataSource ID="ObjectDataSource1" runat="server"
            SelectMethod="GetBrandData" TypeName="BrandBLL" >
            
        </asp:ObjectDataSource>--%>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnShowTyre" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
                </td>
        </tr>
    </table>
   </p>
 
 
 </asp:Content>