<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TabsView.ascx.cs" Inherits="TabsView" %>
<link href="Tabs.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="javascript">
        // Var to store active tab...set to first tab on page load.
        var activetab;
       
//         this.onload = function() {
//        
//            activetab = "tab1";
//            //alert(activetab);
//        }
        function tab_OnMouseOver(tab)
        {
            // Only use hover effect if tab is not active
            if(tab.className != "tabactive"){
                tab.className = "tabover";
            }
            return false;
        }
        function tab_OnMouseOut(tab)
        {
            if(tab.className != "tabactive") {
                tab.className = "tabs";
            }
            return false;
        }
        function tab_activate(tab)
        {
            //alert(tab);
             activetab = tab;
            // Set current active tab to normal
            $(activetab).className = "tabs";
            // Set tab class to active
            $(tab).className = "tabactive";
            // Set activetab var to this tab
           
             activetab = tab;
            // return true so the control will still postback
            return true;
        }
        
       
function checkEvent(tmpObj)
  {	
        
        //alert("tmpObj : " + tmpObj);
        if (window.event.keyCode==13)
        {
             eval("document.getElementById('" + tmpObj + "')").focus();
          
        }
   }
</script>

<div>
    <div id="tabs" style="text-align: left; padding: 0px 0px 0px 0px; color: Black; border-bottom-color : DarkGray">
      <table cellspacing="0"  border="1" bordercolor="DarkGray" style="width: 90%">
            <tr>
               
                <td class="tabactive" id="tab1" onmouseover="return tab_OnMouseOver(this)" onmouseout="return tab_OnMouseOut(this);">
            
                   
                    <asp:LinkButton CssClass="tabbtn" runat="server" ID="btnTab1"  Width="80" OnClientClick="return tab_activate('tab1');"
                        CommandArgument="0" OnCommand="btnTabs_Command" CausesValidation="false"></asp:LinkButton>
                             </td>
                
             <td class="tabs" id="tab2" onmouseover="return tab_OnMouseOver(this)" onmouseout="return tab_OnMouseOut(this);" style="width: 100px">
                    <asp:LinkButton CssClass="tabbtn" runat="server" ID="btnTab2"  OnClientClick="return tab_activate('tab2');"
                        CommandArgument="1"  OnCommand="btnTabs_Command" CausesValidation="false"></asp:LinkButton>
                </td>
                
                <td class="tabs" id="tab3" onmouseover="return tab_OnMouseOver(this)" onmouseout="return tab_OnMouseOut(this);">
                   
                    <asp:LinkButton CssClass="tabbtn" runat="server" ID="btnTab3"  OnClientClick="return tab_activate('tab3');"
                        CommandArgument="2" OnCommand="btnTabs_Command" CausesValidation="false"></asp:LinkButton>
                </td>
               
               <%-- <td class="tabs" id="tab4" onmouseover="return tab_OnMouseOver(this)" onmouseout="return tab_OnMouseOut(this);">
                    
                    <asp:LinkButton CssClass="tabbtn" runat="server" ID="btnTab4"  OnClientClick="return tab_activate('tab4');"
                        CommandArgument="3" OnCommand="btnTabs_Command" CausesValidation="false"></asp:LinkButton>
                </td>--%>
                <%--<td class="tabs" id="tab5" onmouseover="return tab_OnMouseOver(this)" onmouseout="return tab_OnMouseOut(this);">
                   
                    <asp:LinkButton CssClass="tabbtn" runat="server" ID="btnTab5" OnClientClick="return tab_activate('tab5');"
                        CommandArgument="4" OnCommand="btnTabs_Command" CausesValidation="false"></asp:LinkButton>
                </td>--%>
               <%-- <td class="tabs" id="tab6" onmouseover="return tab_OnMouseOver(this)" onmouseout="return tab_OnMouseOut(this);">
                    
                    <asp:LinkButton CssClass="tabbtn" runat="server" ID="btnTab6"  OnClientClick="return tab_activate('tab6');"
                        CommandArgument="5" OnCommand="btnTabs_Command" CausesValidation="false"></asp:LinkButton>
                </td>--%>
                <%--<td class="spacer">
                    &nbsp;</td>
                <td class="tabs" id="tab5" onmouseover="return tab_OnMouseOver(this)" onmouseout="return tab_OnMouseOut(this);">
                    &nbsp;
                    <asp:LinkButton CssClass="tabbtn" runat="server" ID="btnTab5" Width="90" OnClientClick="return tab_activate('tab5');"
                        CommandArgument="4" OnCommand="btnTabs_Command" CausesValidation="false"></asp:LinkButton>
                </td>--%>
                
            </tr>
            
           
           
          
       
    
       <tr>
            
            <td colspan="6"><font class=blackfnt> <asp:UpdatePanel ID="UpdatePanelContent" runat="server" Mode="conditional">
            <ContentTemplate>
                <asp:MultiView ID="MultiViewContent" runat="server" ActiveViewIndex="0" Visible="true">
                    <asp:View ID="View1" runat="server">
                        <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                    </asp:View>
                   <asp:View ID="View2" runat="server">
                        <asp:PlaceHolder ID="PlaceHolder2" runat="server"></asp:PlaceHolder>
                    </asp:View>
                    <asp:View ID="View3" runat="server">
                        <asp:PlaceHolder ID="PlaceHolder3" runat="server"></asp:PlaceHolder>
                    </asp:View>
                    <%--<asp:View ID="View4" runat="server">
                        <asp:PlaceHolder ID="PlaceHolder4" runat="server"></asp:PlaceHolder>
                    </asp:View>--%>
                    <%--<asp:View ID="View5" runat="server">
                        <asp:PlaceHolder ID="PlaceHolder5" runat="server"></asp:PlaceHolder>
                    </asp:View>--%>
                     <%--<asp:View ID="View6" runat="server">
                        <asp:PlaceHolder ID="PlaceHolder6" runat="server"></asp:PlaceHolder>
                    </asp:View>--%>
                </asp:MultiView>
            </ContentTemplate>
            <%--<Triggers>
               <asp:ControlEventTrigger ControlID="btnTab1" EventName="Command" />
               <asp:ControlEventTrigger ControlID="btnTab2" EventName="Command" />
                <asp:ControlEventTrigger ControlID="btnTab3" EventName="Command" />
            </Triggers>--%>
        </asp:UpdatePanel></font></td></tr>
         </table>
    </div>
</div>
