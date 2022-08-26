<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"  CodeFile="PickUp_step1.aspx.cs" Inherits="GUI_WebAdmin_PicKup_location_PickUp_step1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
function Chk(txtLocname,cboCity,btnSubmit)
        {

                if(txtLocname.value=="")
		        {
		        alert("Plz Enter Location Name")
			            txtLocname.focus()
		            return false;
		        }
		    
		        if(cboCity.value=="0")
		        {
		        alert("Select Atleast One City")
			            cboCity.focus()
		            return false;
		        }
	    }
</script>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	  <tr> 
		<td>&nbsp;</td>
	  </tr>
  <tr> 
    <td> 
      <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
						<tr> 
						  
            <td height="30"><font class="blackfnt"><strong>
              Masters Module</strong></font>
              <font class="bluefnt"><strong> &gt; Pickup location Master</strong> </font></td>
						</tr>
						<tr> 
						  <td class="horzblue"></td>
						</tr>
						<tr> 
							  <td>  </td>
							</tr>

        					<tr> 
         					 <td align="right"><a href="javascript:window.history.go(-1)" title="back"><img src="../../images/back.gif" border="0" alt="" /></a></td>
							 </tr>
        
      						 <tr> 
							  <td>  </td>
							</tr>
            </table></td>
        </tr>
      </table>
    <table align="center" border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 70%; height: 151px;">
        <tr class="bgbluegrey">
            <td align="center" colspan="4" class="blackfnt">
                PickUp Location  Master</td>
        </tr>
        <tr style="background-color: white" >
            <td colspan="1" >
                <font class="blackfnt">&nbsp;Pickup Location Code</font></td>
            <td class="blackfnt" style="color: #ff3366; width: 371px;" colspan="3">
                &nbsp;
                <asp:Label ID="lblloccode" runat="server" Text="System Generated..."></asp:Label></td>
        </tr>
        <tr style="background-color: white" >
            <td colspan="1">
                <font class="blackfnt">&nbsp;Pickup Location Name</font></td>
            <td class="blackfnt" colspan="3" style="width: 371px">
                &nbsp;<asp:TextBox ID="txtLocname"  runat="server" Width="272px"></asp:TextBox>
                
        <ajaxToolkit:AutoCompleteExtender
                runat="server" 
                BehaviorID="AutoCompleteEx"
                ID="autoComplete1" 
                TargetControlID="txtLocname"
                ServicePath="../../../../services/FleetAutoComplet.asmx" 
                ServiceMethod="GetPICKUPLocationList"
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
            <td class="blackfnt">
                &nbsp;City</td>
            <td class="blackfnt" colspan="3" style="width: 371px">
                &nbsp;<asp:DropDownList ID="cboCity" runat="server">
                    
                </asp:DropDownList>&nbsp;</td>
        </tr>
        <tr style="background-color: white">
            <td class="blackfnt"><font class="blackfnt">Active </font>
            </td>
            <td class="blackfnt" colspan="3" style="width: 371px">
            <font class="blackfnt"><asp:UpdatePanel ID="upChkActFlag" runat="server">
                                                    <ContentTemplate>
                                                        <asp:CheckBox ID="c1" runat="server" Checked="true" AutoPostBack="True" OnCheckedChanged="c1_CheckedChanged"
                                                            Width="10px" />
                                                        <asp:TextBox ID="txtActFlag" runat="server" ReadOnly="True" Width="40px">Y</asp:TextBox>&nbsp;
                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="c1" EventName="CheckedChanged" />
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                            </font></td>
        </tr>
         <tr style="background-color: white">
            <td align="right" colspan="5">
             
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                    <ContentTemplate>   <font class="blackfnt">
                <asp:Label ID="lbvalidate" Visible="false" runat="server" Text="Sorry Pickup Location Duplicate For this City !!!" CssClass="blackfnt" ForeColor="Red"></asp:Label>
                                                     <asp:Button ID="btnListing" runat="server" Text="Go To For Listing" OnClick="btnListing_Click" /><asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                    </font></ContentTemplate>
                                                  
                                                </asp:UpdatePanel></td>
        </tr>
    </table>
</asp:Content>
