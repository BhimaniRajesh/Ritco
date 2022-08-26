<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="RouteMasterCriteria.aspx.cs" Inherits="GUI_admin_VendorMaster_RouteMasterCriteria" Title="Trip Route Master Criteria" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript" src="../../../GUI/images/CommonJS.js"></script>
<script language="javascript" type="text/javascript"> 
/*************************************************************************************************************
*   CHECK ROUTE CODE EXIST OR NOT
/*************************************************************************************************************/ 
function checkRouteCode(id)
{  
   var RouteCode = document.getElementById(id);
   RouteCode.value = RouteCode.value.toUpperCase();
   
   if(RouteCode.value != "")
    {           
        var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");
        hdnajaxstate.value = "1";   
              
        var objXMLHttpObject = false;
        objXMLHttpObject = GetXMLHttpObject();   
       
        if(objXMLHttpObject)
        {
           var boolCustomerCode = "AjaxResponse.aspx?mode=check&code1=routeCodeCityC&code2=" + RouteCode.value + "&sid=" + Math.random() + "&sid2" + Math.random();  
           objXMLHttpObject.open("GET", boolCustomerCode);
           
           objXMLHttpObject.onreadystatechange = function()
           {
                if((objXMLHttpObject.readyState == 4) && (objXMLHttpObject.status == 200))
                {                              
                      var result = objXMLHttpObject.responseText.split("|");                                             
                      
                      if(result[0] == "false")
                      { 
                          alert(result[1]);
                          RouteCode.value = "";
                          RouteCode.focus();  
                          hdnajaxstate.value = "0";                        
                          return false;  
                      }  
                      else
                      {
                        hdnajaxstate.value = "0";   
                      }                         
                }
           }                  
             objXMLHttpObject.send(null);
          }
    }
    else
    {
        return false;
    }
    return true;
}

function onSubmitCheckValue(Flag)
{
    var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
    var rdRouteType = document.getElementById("ctl00_MyCPH1_rdRouteType");     
    var ddlRouteMode = document.getElementById("ctl00_MyCPH1_ddlRouteMode"); 
    var ddlRoute = document.getElementById("ctl00_MyCPH1_ddlRoute");   
    var rdRouteCode = document.getElementById("ctl00_MyCPH1_rdRouteCode");
    var txtRouteCode = document.getElementById("ctl00_MyCPH1_txtRouteCode");  

    var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");            
    if(hdnajaxstate.value != "0")
    {
        alert("Let the Internal Processes Over. Please wait 5-10 seconds or LogOut.");
        return false;
    }    
   
    if(rdRouteType.checked)
    {
//       if(ddlRouteMode.value == "0")
//       {
//           alert("Please select Vendor Type.");
//           ddlRouteMode.focus();
//           return false; 
//       }
//       else 
//       {
             if(ddlRoute.value == "0")
             {
               alert("Please select Route.");
               ddlRoute.focus();
               return false; 
             }
             else
             {  
                if(Flag == "View")
                {             
                   window.open("RouteMasterView.aspx?routeCode="+ ddlRoute.value +"&print=N","", winOpts);         
                   return false;
                }
             }
//          }       
    }  
    else
    {                  
       if(txtRouteCode.value == "")
       {
           alert("Please enter Route Code.");
           txtRouteCode.value = "";
           txtRouteCode.focus();
           return false; 
       }
       else
       {  
            if(Flag == "View")
            {     
               window.open("RouteMasterView.aspx?routeCode="+ txtRouteCode.value +"&print=N","", winOpts);         
               return false;
            }
       }     
    }
    return true;
}
</script>
    <asp:Panel runat="server" HorizontalAlign="left" Style="width: 10in" ID="pnlMain">
        <br />
        <br />
        <asp:Table ID="tblMain" runat="server" HorizontalAlign="center" CssClass="boxbg"
            CellSpacing="1" BorderWidth="0" Width="60%" BorderStyle="Groove">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="center" ColumnSpan="3" Style="height: 20px;">
                  <b>Select Trip Route For Edit / View</b>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="center" RowSpan="2">
                    <asp:RadioButton ID="rdRouteType" runat="server" CssClass="blackfnt" GroupName="Customer" Checked="true" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left">                               
                          Select Route Mode                                       
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left">
                    <asp:DropDownList ID="ddlRouteMode" CssClass="blackfnt" runat="server" Width="275px" AutoPostBack="true" OnSelectedIndexChanged="ddlRouteMode_SelectedIndexChanged">
                     <asp:ListItem Value="0">All</asp:ListItem>
                                <asp:ListItem Value="A">Air</asp:ListItem>
                                <asp:ListItem Value="S">Road</asp:ListItem>
                                <asp:ListItem Value="R">Rail</asp:ListItem>
                    </asp:DropDownList>                     
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="left" VerticalAlign="top">                               
                                    Select Route                               
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="ddlRoute" runat="server" CssClass="blackfnt" Width="400px">
                            </asp:DropDownList>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlRouteMode" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="center">
                    <asp:RadioButton ID="rdRouteCode" CssClass="blackfnt" runat="server" GroupName="Customer" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left">                                
                                  Enter Route Code                               
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left">
                    <asp:TextBox ID="txtRouteCode" runat="server" BorderStyle="Groove" CssClass="blackfnt" onblur="Javascript:return checkRouteCode(this.getAttribute('id'));"
                        Width="125px"></asp:TextBox>
                    <div class="blackfnt">
                    
                      <ajaxToolkit:AutoCompleteExtender
                runat="server" 
                BehaviorID="AutoCompleteEx"
                ID="autoComplete1" 
                TargetControlID="txtRouteCode"
                ServicePath="../../../services/FleetAutoComplet.asmx" 
                ServiceMethod="GetTripRouteList"
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
                      
                      
                    </div>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="center" ColumnSpan="3">                   
                    <asp:Button ID="btnEdit" runat="server" CssClass="blackfnt" Text="Edit" OnClientClick="javascript:return onSubmitCheckValue('Edit')" 
                        OnClick="btnEdit_Click" Visible="false" /> 
                    <asp:Button ID="btnView" runat="server" CssClass="blackfnt" Text="View" OnClientClick="javascript:return onSubmitCheckValue('View')"
                        Visible="false" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../images/loading.gif" alt="" />
                    </td>
                    <td>
                        <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                opacity: .50; -moz-opacity: .50;" runat="server">
                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                    left: 50%;" ID="Panel2" runat="server">
                </asp:Panel>
            </asp:Panel>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
    <asp:HiddenField ID="hdnajaxstate" runat="server" Value="0" />
 </asp:Content>

