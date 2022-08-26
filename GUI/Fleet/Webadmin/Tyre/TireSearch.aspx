<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"  CodeFile="TireSearch.aspx.cs" Inherits="TyreModelSearch" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >

<script language="javascript">
    
    function createXMLHttpRequest()
    {
        // Mozilla, Safari,...
	    if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
	    // IE
	    else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
    }
    function checkVehNo(txtVehNo,hfVehIntId)
    {
        var currentTime = new Date()
        var ConnStr="<%= Session["SqlProvider"] %>";
        var str_Index = "";
        if (txtVehNo.value == "")
        {
            txtVehNo.value="";
            hfVehIntId.value="";
            return;
        }

        createXMLHttpRequest();
        if (xmlHttpRequest)
        {
            xmlHttpRequest.onreadystatechange = function()
            {
                if (xmlHttpRequest.readyState == 4)
                {
                    var returnValue=xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "N") 
                    {
                        alert("Invalid Vehicle Number");
                        txtVehNo.value="";
                        hfVehIntId.value="";
                        txtVehNo.focus();
                    }
                    else
                    {
                        txtVehNo.value=returnValue[1];
                        hfVehIntId.value=returnValue[2];
                    }
                }
            }
            xmlHttpRequest.open("GET", "../../../Fleet/Tyre/wfrm_AJAX_Validator.aspx?Function=CheckValidVehNo&datetime="+currentTime+"&VehNo=" + txtVehNo.value+"&ConnStr="+ConnStr, false);
            xmlHttpRequest.send(null);
        }	
    }
 
   </script>
 
    <table cellspacing="1" style="width: 700px">
        <tr style="background-color: white">
            <td align="left" style="height: 3px; font-weight: bold; vertical-align: top; color: #006633; text-align: left;">
                <br />TYRE MASTER<br />
                <br />
                <hr />  
                <table cellspacing="1" style="width: 100%">
                    <tr style="background-color: white">
                        <td align="left" style="height: 26px">
                            <asp:Label ID="lblNew" runat="server" CssClass="blackfnt" Font-Bold="true" Text="New ?? "></asp:Label>
                            <asp:LinkButton ID="lnkCreateDriver" runat="server" Text="Create New Tyre" CssClass="bluefnt" Font-Bold="true" PostBackUrl="~/GUI/Fleet/Webadmin/Tyre/Tyre.aspx"  ValidationGroup="VGCreate"></asp:LinkButton></td>
                        <td align="left" style="width: 7px; height: 26px;"><asp:UpdatePanel runat="server" ID="UpdatePanel2">
                            <ContentTemplate>
                      
                            <asp:LinkButton ID="lnkbtnView" runat="server" CssClass="bluefnt" Font-Bold="True">View</asp:LinkButton><asp:Label ID="Label2" runat="server" Text="|"></asp:Label><asp:LinkButton ID="lnkbtnPrint" runat="server" CssClass="bluefnt" Font-Bold="True">Print</asp:LinkButton>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        </td>
                        <td align="left" style="width: 7px; height: 26px">
                            <asp:Label ID="Label3" runat="server" Text="|"></asp:Label></td>
                        <td align="left" style="width: 7px; height: 26px;">
                            <asp:LinkButton ID="lnkbtnXLS" runat="server" OnClick="lnkbtnXLS_Click" CssClass="bluefnt" Font-Bold="True">XLS</asp:LinkButton></td>
                    
                    </tr>
                </table><asp:UpdatePanel runat="server" ID="UpdatePanel3">
                    <ContentTemplate>
             <table cellspacing="1" style="width: 100%" class="boxbg">
                 <tr style="background-color: white">
                     <td align="right" style="width: 35%; text-align: left; color: #000000;">
                         <asp:Label ID="Label6" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Enter Tyre No"></asp:Label></td>
                     <td align="left" colspan="2" style="width: 75%">
                         <asp:TextBox ID="txtTyreNo" runat="server" CssClass="blackfnt"></asp:TextBox>
                          <asp:Button ID="btnPopupTyreNo" runat="server" Text="..." Width="21px" />
                          
                 <ajaxToolkit:AutoCompleteExtender
                runat="server" 
                BehaviorID="AutoCompleteEx"
                ID="autoComplete1" 
                TargetControlID="txtTyreNo"
                ServicePath="../../../../services/FleetAutoComplet.asmx" 
                ServiceMethod="GetTyreNumber"
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
                        <td align="right" style="width: 35%; text-align: left; color: #000000;">
                  
                            <asp:Label ID="lblTyreSize" runat="server" Text="Enter Tyre Model:"  Font-Bold="True" CssClass="blackfnt"></asp:Label>
                  
                    </td>
                            <td align="left" colspan="2" style="width: 75%">
                            
                            
                                <asp:TextBox ID="txtTyreModelNo" runat="server" CssClass="blackfnt"></asp:TextBox>
                                <asp:Button ID="btnPopupModelNo" runat="server" Text="..." Width="21px" />
             
                 <ajaxToolkit:AutoCompleteExtender
                runat="server" 
                BehaviorID="AutoCompleteEx1"
                ID="AutoCompleteExtender3" 
                TargetControlID="txtTyreModelNo"
                ServicePath="../../../../services/FleetAutoComplet.asmx" 
                ServiceMethod="GetTyreModelNo"
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
                                var behavior = $find('AutoCompleteEx1');
                                if (!behavior._height) {
                                    var target = behavior.get_completionList();
                                    behavior._height = target.offsetHeight - 2;
                                    target.style.height = '0px';
                                }" />
                            
                            <%-- Expand from 0px to the appropriate size while fading in --%>
                            <Parallel Duration=".4">
                                <FadeIn />
                                <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx1')._height" />
                            </Parallel>
                        </Sequence>
                    </OnShow>
                    <OnHide>
                        <%-- Collapse down to 0px and fade out --%>
                        <Parallel Duration=".4">
                            <FadeOut />
                            <Length PropertyKey="height" StartValueScript="$find('AutoCompleteEx1')._height" EndValue="0" />
                        </Parallel>
                    </OnHide>
                </Animations>
            </ajaxToolkit:AutoCompleteExtender>
                                </td>
                  </tr>
                 <tr style="background-color: white">
                     <td align="right" style="width: 35%; text-align: left; color: #000000;">
                         <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Enter Tyre Manufacturer:"></asp:Label></td>
                     <td align="left" colspan="2" style="width: 75%">
                          <asp:TextBox ID="txtManufacturerName" runat="server" CssClass="blackfnt"></asp:TextBox>
                                <asp:Button ID="btnPopupTyreMfg" runat="server" Text="..." Width="21px" />
                                
                <ajaxToolkit:AutoCompleteExtender
                runat="server" 
                BehaviorID="AutoCompleteEx2"
                ID="AutoCompleteExtender5" 
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
                                var behavior = $find('AutoCompleteEx2');
                                if (!behavior._height) {
                                    var target = behavior.get_completionList();
                                    behavior._height = target.offsetHeight - 2;
                                    target.style.height = '0px';
                                }" />
                            
                            <%-- Expand from 0px to the appropriate size while fading in --%>
                            <Parallel Duration=".4">
                                <FadeIn />
                                <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx2')._height" />
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
                     <td align="right" style="width: 35%; text-align: left; color: #000000;">
                         <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Select Tyre Category:"></asp:Label></td>
                     <td align="left" colspan="2" style="width: 75%">
                         <asp:DropDownList ID="ddlTyreCategory" runat="server" Width="113px">
                         </asp:DropDownList></td>
                 </tr>
                 <tr style="background-color: white">
                     <td align="right" style="width: 35%; text-align: left; color: #000000;">
                         <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Enter Tyre Size:"></asp:Label></td>
                     <td align="left" colspan="2" style="width: 75%">
                      <asp:TextBox ID="txtSizeName" runat="server" CssClass="blackfnt"></asp:TextBox>
                                <asp:Button ID="btnPopupTyreSize" runat="server" Text="..." Width="21px" />
                         <asp:HiddenField ID="hTyreSize" runat="server" />
               
                 <ajaxToolkit:AutoCompleteExtender
                runat="server" 
                BehaviorID="AutoCompleteEx3"
                ID="AutoCompleteExtender2" 
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
                                var behavior = $find('AutoCompleteEx3');
                                if (!behavior._height) {
                                    var target = behavior.get_completionList();
                                    behavior._height = target.offsetHeight - 2;
                                    target.style.height = '0px';
                                }" />
                            
                            <%-- Expand from 0px to the appropriate size while fading in --%>
                            <Parallel Duration=".4">
                                <FadeIn />
                                <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx3')._height" />
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
                     <td align="right" style="width: 35%; text-align: left; color: #000000;">
                         <asp:Label ID="Label7" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Tyre Type Category:"></asp:Label></td>
                     <td align="left" colspan="2" style="width: 75%">
                         <asp:DropDownList ID="ddlTyreTypeCategory" runat="server" Width="113px">
                         </asp:DropDownList></td>
                 </tr>
                 <tr style="background-color: white">
                     <td align="right" style="width: 35%; text-align: left; color: #000000;">
                         <asp:Label ID="Label8" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Enter Vehicle Number:"></asp:Label></td>
                     <td align="left" colspan="2" style="width: 75%;">
                     <asp:TextBox id="txtVehNo" runat="server" Width="130px" AutoCompleteType="Notes" ></asp:TextBox>
                     <asp:Button id="btnPopupVehno" runat="server" Text="..." Width="21px"></asp:Button>
        
                                  <ajaxToolkit:AutoCompleteExtender
                runat="server" 
                BehaviorID="AutoCompleteEx4"
                ID="AutoCompleteExtender1" 
                TargetControlID="txtVehNo"
                ServicePath="../../../../services/FleetAutoComplet.asmx" 
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
                                var behavior = $find('AutoCompleteEx4');
                                if (!behavior._height) {
                                    var target = behavior.get_completionList();
                                    behavior._height = target.offsetHeight - 2;
                                    target.style.height = '0px';
                                }" />
                            
                            <%-- Expand from 0px to the appropriate size while fading in --%>
                            <Parallel Duration=".4">
                                <FadeIn />
                                <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx4')._height" />
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
            
                                 <asp:HiddenField id="hfVehIntId" runat="server"></asp:HiddenField>
                         <asp:HiddenField ID="hfKm" runat="server" />
                     </td>
                 </tr>
                 <tr style="background-color: white">
                     <td align="right" style="width: 35%; text-align: left; color: #000000;">
                         <asp:Label ID="Label12" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Select Tyre Pattern:"></asp:Label></td>
                     <td align="left" colspan="2" style="width: 75%">
                         <asp:DropDownList ID="ddlTyrePattern" runat="server" Width="113px" >
                         </asp:DropDownList></td>
                 </tr>
                 <tr style="background-color: white">
                     <td align="right" style="width: 35%; text-align: left; color: #000000;">
                         <asp:Label ID="Label10" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Select Tyre Position Category:"></asp:Label></td>
                     <td align="left" colspan="2" style="width: 75%"><asp:DropDownList AutoPostBack="true"  ID="ddlTyrePosCategory" runat="server" Width="113px" OnSelectedIndexChanged="ddlTyrePosCategory_SelectedIndexChanged">
                     </asp:DropDownList></td>
                 </tr>
                 <tr style="background-color: white">
                     <td align="right" style="width: 35%; text-align: left; color: #000000;">
                         <asp:Label ID="Label11" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Select Tyre Position:"></asp:Label></td>
                     <td align="left" colspan="2" style="width: 75%"><asp:DropDownList ID="ddlTyrePosition" runat="server" Width="113px">
                     </asp:DropDownList></td>
                 </tr>
                 <tr style="background-color: white">
                     <td align="right" style="width: 35%; color: #000000; text-align: left">
                         <asp:Label ID="Label13" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Tyre Status:"></asp:Label></td>
                     <td align="left" colspan="2" style="width: 75%; height: 16px">
                         <asp:DropDownList ID="ddlTyreStatus" runat="server" Width="113px">
                         <asp:ListItem Text="All" Value="All"></asp:ListItem> 
                         <asp:ListItem Text="Available" Value="Available"></asp:ListItem> 
                         <asp:ListItem Text="Mounted" Value="Mounted"></asp:ListItem> 
                         <asp:ListItem Text="Dismounted" Value="Dismounted"></asp:ListItem> 
                         </asp:DropDownList></td>
                 </tr>
                 <tr style="background-color: white">
                     <td align="right" style="width: 35%; text-align: left; color: #000000;">
                         <asp:Label ID="Label9" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Active Flag:"></asp:Label></td>
                     <td align="left" colspan="2" style="width: 75%; height: 16px">
                         <asp:DropDownList ID="ddlStatus" runat="server">
                         <asp:ListItem Text="All" Value="0"> </asp:ListItem>
                         <asp:ListItem Text="Active" Value="Yes"> </asp:ListItem>
                         <asp:ListItem Text="Inactive" Value="No"> </asp:ListItem>
                         </asp:DropDownList>
                     </td>
                 </tr>
                    <tr style="background-color: white">
                        <td colspan="3" align="right" style="width: 25%; color: #000000; text-align: right">
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
                     <td align="right" colspan="3" style="width: 25%; text-align: left; color: #000000;">
                &nbsp;</td>
                 </tr>
                
                </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="left" style="vertical-align: top; text-align: left; width: 85%;">
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="left">
                </td>
        </tr>
    </table>
     <br />
     <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                         <ContentTemplate>
                        <asp:GridView ID="GridView1" runat="server" BorderWidth="1px" CellSpacing="1" CellPadding="5" HeaderStyle-CssClass="dgHeaderStyle" 
                             AllowPaging="True" PageSize="50" PagerStyle-HorizontalAlign="left"               
                            PagerSettings-Mode="Numeric" AutoGenerateColumns="False"  
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8BA0E5" DataKeyNames="Tyre_ID" Width="100%"  OnPageIndexChanging="GridView1_PageIndexChanging">
                            <Columns>
                               
                                <asp:BoundField DataField="TYRE_NO" HeaderText="Tyre No."> 
                                    <ItemStyle HorizontalAlign="Left" Width="10%" />    
                                      <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CATEGORY" HeaderText="Tyre Type Category" >
                                    <ItemStyle HorizontalAlign="Left" Width="20%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="MFG_NAME" HeaderText="Tyre Manufacturer Name">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="MODEL_NO" HeaderText="Tyre Model No">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="SIZE_NAME" HeaderText="Tyre Size">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                  <asp:BoundField DataField="TYRE_OE" HeaderText="Original Equipment">
                                    <ItemStyle HorizontalAlign="Left" Width="10%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="TYREPAT_CODE" HeaderText="Tyre Pattern">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="TYRE_TREAD_DEPTH_32NDS" HeaderText="Tyre Tread Depth">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="TYRE_PURDT" HeaderText="Tyre Purchase Date">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="TYRE_PUR_KMS" HeaderText="Tyre Purchase KM">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="TYRE_COST" HeaderText="Tyre Cost">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="VEHNO" HeaderText="Vehicle Number">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                               <asp:BoundField DataField="TRUCK_TRAILER" HeaderText="Vehicle Category">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                              
                                   <asp:BoundField DataField="TYRETYPE" HeaderText="Tyre Type Category">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                   <asp:BoundField DataField="POSCATEGORY" HeaderText="Tyre Position Category">
                                    <ItemStyle HorizontalAlign="Left" Width="25%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:BoundField DataField="TYREPOSCODE" HeaderText="Tyre Position Code">
                                    <ItemStyle HorizontalAlign="Left" Width="25%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:BoundField DataField="LOCATION" HeaderText="Tyre Location">
                                    <ItemStyle HorizontalAlign="Left" Width="25%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                 <asp:BoundField DataField="VENDOR" HeaderText="Tyre Vendor">
                                    <ItemStyle HorizontalAlign="Left" Width="25%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:BoundField DataField="TYRE_STATUS" HeaderText="Tyre Status">
                                    <ItemStyle HorizontalAlign="Left" Width="25%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:BoundField DataField="TYRE_ACTIVEFLAG" HeaderText="Active Flag">
                                    <ItemStyle HorizontalAlign="Left" Width="10%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                
                                <asp:HyperLinkField DataTextFormatString="--Select--" DataTextField="Tyre_ID" DataNavigateUrlFields="Tyre_ID"
                                    DataNavigateUrlFormatString="Tyre.aspx?Id={0}" >
                                    <ItemStyle CssClass="bluelink" ForeColor="Blue" HorizontalAlign="Center" Width="15%" />
                                </asp:HyperLinkField>
                               
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                         </ContentTemplate>
                     </asp:UpdatePanel>

 
 </asp:Content>