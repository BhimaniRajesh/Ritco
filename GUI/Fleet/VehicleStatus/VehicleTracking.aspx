<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="VehicleTracking.aspx.cs" Inherits="GUI_Fleet_VehicleStatus_VehicleTracking" Title="Untitled Page" %>

<%@ Register
    Assembly="AjaxControlToolkit"
    Namespace="AjaxControlToolkit"
    TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script type="text/javascript" language="javascript" src="../../Js/Date.js"></script>
<script type="text/javascript" language="javascript" src="AJAX_Validator/JScript.js"></script>
    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"> </script>
    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript" src="../../images/DateControl.js"></script>
    
    <br />
    <br />
    <br />
    
     <asp:Table ID="tblMain" runat="server" HorizontalAlign="left" CssClass="boxbg"
            CellSpacing="1" BorderWidth="0" Width="50%" BorderStyle="Groove">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="center" ColumnSpan="2" CssClass="blackfnt" Style="height: 20px;">
                    <b>Vehicle Tracking</b></asp:TableCell>
                </asp:TableRow>
            
            <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                <asp:TableCell HorizontalAlign="left">
                  Enter Vehicle Number
                </asp:TableCell> 
                <asp:TableCell Style="height: 24px;" HorizontalAlign="left" >
                    <asp:TextBox ID="txtVehNo" CssClass="input" runat="server" Width="140px" AutoCompleteType="Notes"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfv_txtVehNo" runat="server" ControlToValidate="txtVehNo"  ErrorMessage="!!!" />
                    <asp:Button ID="btnPopupVehno" runat="server" Text="..." Width="21px" />
                    <asp:Label ID="lblVehNoErr" CssClass="redfnt"  runat="server" Text=""></asp:Label>
                    <asp:HiddenField ID="hfVehIntId" runat="server" />
                    <asp:HiddenField ID="hfKm" runat="server" />
                      <asp:Panel ID="Panel1" runat="server" Height="1px" ScrollBars="Both" Width="1px">
                        <asp:Panel ID="pnlDropdown" Height="200px" ScrollBars="Vertical" BackColor="transparent" runat="server" BorderStyle="Inset" BorderWidth="1px" Direction="LeftToRight" Font-Names="Verdana" Font-Overline="False" Font-Size="8pt" Font-Underline="False" HorizontalAlign="Left"></asp:Panel>
                    </asp:Panel>
  
           <%--<ajaxToolkit:AutoCompleteExtender
                runat="server" 
                BehaviorID="AutoCompleteEx"
                ID="autoComplete1" 
                TargetControlID="txtVehNo"
                ServicePath="../../../services/FleetAutoComplet.asmx" 
                ServiceMethod="GetCompletionList"
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
            </ajaxToolkit:AutoCompleteExtender>--%>
                
                </asp:TableCell>
            
            </asp:TableRow>
            
            
         
            
            <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                <asp:TableCell HorizontalAlign="left">
                  Tripsheet Number
                </asp:TableCell> 
                <asp:TableCell Style="height: 24px;" HorizontalAlign="left" >
                    <a runat="server" id="TripsheeNo" target="_blank" ></a>
                    <asp:TextBox ID="tb_Tripsheet_No" CssClass="input" runat="server" Width="140px" AutoCompleteType="Notes"></asp:TextBox>
                    <asp:Button ID="btnPopupTSNo" Visible="false"  OnClientClick="javascript:return OpenPopupTS()"  runat="server" Text="..." Width="21px" />
                    <asp:Label ID="lbl_TripSheet_Err" CssClass="redfnt"  runat="server" Text=""></asp:Label>
                     
                </asp:TableCell>
            </asp:TableRow>
            
              <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                <asp:TableCell HorizontalAlign="left">
                  Enter Location
                </asp:TableCell> 
                <asp:TableCell Style="height: 24px;" HorizontalAlign="left" >
                    <asp:TextBox ID="tb_Location" CssClass="input" runat="server" Width="140px" AutoCompleteType="Notes"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfv_tb_Location" runat="server" ControlToValidate="tb_Location"  ErrorMessage="!!!" />
                    <asp:Label ID="lbl_Location_Err" CssClass="redfnt"  runat="server" Text=""></asp:Label>
                                    
                   
                </asp:TableCell>
                </asp:TableRow>
                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                <asp:TableCell HorizontalAlign="left">
                  Tracking Date
                </asp:TableCell> 
                <asp:TableCell Style="height: 24px;" HorizontalAlign="left" >
                    
                      
                     <asp:TextBox ID="txtDate"  runat="server" 
                                BorderStyle="Groove" CssClass="input" MaxLength="10" Width="80px"></asp:TextBox>
                               <asp:Image
                        ID="img_Calendar" runat="server" BackColor="White" BorderColor="White" ForeColor="White"
                        ImageUrl="~/cal/cal.gif" /> 
                        
                        <asp:RequiredFieldValidator ID="rfv_txtDate" runat="server" ControlToValidate="txtDate"  ErrorMessage="!!!" />
                </asp:TableCell>
                
            
            </asp:TableRow>
            
            
                 <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                <asp:TableCell HorizontalAlign="left">
                  Tracking Time
                </asp:TableCell> 
                <asp:TableCell Style="height: 24px;" HorizontalAlign="left" >
                
                           <asp:TextBox Style="text-align: right" ID="tb_HH" MaxLength="2" onblur="checkDecimal(this.getAttribute('id'), 'TRUE')"
                        BorderStyle="Groove" CssClass="input" onkeypress="javascript:return validInt(event);"
                        runat="server" Width="20px"></asp:TextBox>&nbsp; :
                    <asp:TextBox Style="text-align: right" ID="tb_MM" MaxLength="2"  onblur="checkDecimal(this.getAttribute('id'), 'TRUE');CheckValidMin(this.getAttribute('id'), 'TRUE')"
                        CssClass="input" BorderStyle="Groove" onkeypress="javascript:return validInt(event);"
                        runat="server" Width="20px" />&nbsp;(HH:MM)
                        
                </asp:TableCell>
                
            
            </asp:TableRow>
            
               <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                <asp:TableCell HorizontalAlign="left">
                  Remarks
                </asp:TableCell> 
                <asp:TableCell Style="height: 24px;" HorizontalAlign="left" >
                    
                   <asp:TextBox ID="tb_Remarks" TextMode="MultiLine" Height="50px" runat="server"
                                BorderStyle="Groove" CssClass="input" MaxLength="10" Width="250px"></asp:TextBox>
                                
                                
                        
                </asp:TableCell>
                
            
            </asp:TableRow>
            
             <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="center" ColumnSpan="2" CssClass="blackfnt" Style="height: 20px;">
                    <asp:Button ID="btn_Submit" runat="server" OnClick="btnSubmit_Click"  Text="Submit" />
                    </asp:TableCell>
                </asp:TableRow>
                
                <asp:TableRow BackColor="White">
                <asp:TableCell HorizontalAlign="center" ColumnSpan="2" CssClass="blackfnt">
                     <center>
        <font class="blackfnt" style="color:Red;">
            <b><asp:Label ID="lbl_Page_Error" runat="server" Font-Size="Small" Text=""></asp:Label></b>
        </font>
    </center>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
       
             
            
</asp:Content>

