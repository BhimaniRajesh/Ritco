<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Tyre_Tracking.aspx.cs" Inherits="GUI_Fleet_Tyre_Tyre_Tracking_Tyre_Tracking" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script type="text/javascript" language="javascript">
    function createXMLHttpRequest()
    {
        // Mozilla, Safari,...
        if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
        // IE
        else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
    }
    function checkTyreNo(mtyreno)
    {
    
        var currentTime = new Date()
        var tyre=document.getElementById("ctl00_MyCPH1_txtTyreNo").value;
        
        if (mtyreno.value == "")
        {
            return true;    
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
                        alert("Invalid Tyre Number");
                        document.getElementById("ctl00_MyCPH1_txtTyreNo").value="";
                        document.getElementById("ctl00_MyCPH1_txtTyreNo").focus();
                        return false;
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=GetTyreNo&datetime="+currentTime+"&TYRE_NO=" + tyre, false);
            xmlHttpRequest.send(null);
        }	
    } 
    function checkVehNo(mvehno)
    {
        var currentTime = new Date()
        var vehno=document.getElementById("ctl00_MyCPH1_txtVehNo").value;
        
        if (mvehno.value == "")
        {
            return true;    
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
                        document.getElementById("ctl00_MyCPH1_txtVehNo").value="";
                        document.getElementById("ctl00_MyCPH1_txtVehNo").focus();
                        return false;
                        
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=GetVehNo&datetime="+currentTime+"&TYRE_VEHNO=" + vehno, false);
            xmlHttpRequest.send(null);
        }	
    }   
</script>
 <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="true" runat="server">Tyre Tracking</asp:Label>
             
            </td>
            
             <td align=left>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color=red><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  
         
          </td>    
           
        </tr>
    </table>
    
    <hr align="center" size="1" color="#8ba0e5">
 <br> 

<table>
<tr><td>
    <table cellspacing="1" style="width: 7.5in" class="boxbg" align="left">
            <tr class="bgbluegrey">
                <td colspan="7" align="center" style="height: 21px">
                    <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Tyre Tracking Criteria </asp:Label>
                </td>
            </tr>
            
              <tr valign="center" style="background-color: white">  
                         <td width="10%">
                            <asp:Label ID="Label10" CssClass="blackfnt" runat="server" Font-Bold="True">Enter Tyre No</asp:Label>
                            </td>
                            <td align="left" colspan="2" width="50%"> 
                            <asp:TextBox ID="txtTyreNo" runat="server" BorderStyle="Groove" CssClass="input" Width="100px" style="font-size: 8pt; font-family: Verdana" ></asp:TextBox> 
                                    <asp:Button ID="btnPopupTyreNo" runat="server" Text="..." Width="21px" />
                                    <ajaxToolkit:AutoCompleteExtender
                                    runat="server" 
                                    BehaviorID="AutoCompleteEx4"
                                    ID="AutoCompleteExtender15" 
                                    TargetControlID="txtTyreNo"
                                    ServicePath="~/GUI/services/WebService.asmx" 
                                    ServiceMethod="GetTyreNo"
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
                                            <Length PropertyKey="height" StartValueScript="$find('AutoCompleteEx4')._height" EndValue="0" />
                                            </Parallel>
                                            </OnHide>
                                    </Animations>
                                    </ajaxToolkit:AutoCompleteExtender>    
                            </td>
               </tr>
                    
           <tr style="background-color: white">
               <td align="centre" colspan="3" style="font-weight: bold" height="20%">
                   OR</td>
           </tr>        
            
             <tr style="background-color: white">
                        <td width="40%">
                          <asp:Label ID="Label5" CssClass="blackfnt" runat="server" Font-Bold="True">Enter Vehicle No</asp:Label>
                        </td>
                            <td align="left" colspan="2" width="50%"> 
                            <asp:TextBox ID="txtVehNo" runat="server" BorderStyle="Groove" CssClass="input" Width="100px" style="font-size: 8pt; font-family: Verdana" ></asp:TextBox>
                                    <asp:Button id="btnPopupVehno" runat="server" Text="..." Width="21px"></asp:Button>
                                    <ajaxToolkit:AutoCompleteExtender
                                    runat="server" 
                                    BehaviorID="AutoCompleteEx5"
                                    ID="AutoCompleteExtender1" 
                                    TargetControlID="txtVehNo"
                                    ServicePath="~/GUI/services/WebService.asmx" 
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
                                            var behavior = $find('AutoCompleteEx5');
                                            if (!behavior._height) {
                                            var target = behavior.get_completionList();
                                            behavior._height = target.offsetHeight - 2;
                                            target.style.height = '0px';
                                            }" />

                                            <%-- Expand from 0px to the appropriate size while fading in --%>
                                            <Parallel Duration=".4">
                                            <FadeIn />
                                            <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx5')._height" />
                                            </Parallel>
                                            </Sequence>
                                            </OnShow>
                                            <OnHide>
                                            <%-- Collapse down to 0px and fade out --%>
                                            <Parallel Duration=".4">
                                            <FadeOut />
                                            <Length PropertyKey="height" StartValueScript="$find('AutoCompleteEx5')._height" EndValue="0" />
                                            </Parallel>
                                            </OnHide>
                                    </Animations>
                                    </ajaxToolkit:AutoCompleteExtender> 
                             </td>
               </tr>
                    
          <tr style="background-color: white">
               <td align="right"  colspan="3" style="text-align: Right; width: 3%; height: 17px;">
               <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <asp:Button ID="btnShow" runat="server" Text="Submit" OnClick="btnShow_Click" /> 
                   </ContentTemplate>
                </asp:UpdatePanel>
               </td>
           </tr>
                    
                    
</table>

</td></tr>
</table>
 <br />
 
                <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                         <ContentTemplate>
                        <asp:GridView ID="gvTyreTracking" runat="server" BorderWidth="1px" CellSpacing="1" CellPadding="5" HeaderStyle-CssClass="dgHeaderStyle" 
                             AllowPaging="True" PageSize="50" PagerStyle-HorizontalAlign="left"               
                            PagerSettings-Mode="Numeric" AutoGenerateColumns="False"  
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8BA0E5" Width="100%"  OnPageIndexChanging="gvTyreTracking_PageIndexChanging">
                            <Columns>
                               
                                <asp:BoundField DataField="Tyre_VehNo" HeaderText="Vehicle No."> 
                                    <ItemStyle HorizontalAlign="Left" Width="10%" />    
                                      <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Tyre_No" HeaderText="Tyre No." >
                                    <ItemStyle HorizontalAlign="Left" Width="20%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="MFG_NAME" HeaderText="Tyre Manufacturer Name">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Model_Desc" HeaderText="Tyre Model">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="tyre_sizename" HeaderText="Tyre Size">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                  <asp:BoundField DataField="Tyre_Pattern_Desc" HeaderText="Tyre Pattern">
                                    <ItemStyle HorizontalAlign="Left" Width="10%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Tyre_Typename" HeaderText="Tyre Type Category">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="tyrepos_desc" HeaderText="Tyre Position">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="tyre_status" HeaderText="Mount/Dismount Status">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Putaway_Location" HeaderText="Tyre PutAway">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Tyre_TotKM_Run" HeaderText="Total KM Run">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Tyre_Cost" HeaderText="Tyre Cost">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                               <asp:BoundField DataField="tyre_activeflag" HeaderText="Active/In-Active">
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                         
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                         </ContentTemplate>
                     </asp:UpdatePanel>
     
</asp:Content>

