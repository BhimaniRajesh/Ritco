<%@ Page Language="C#" AutoEventWireup="true"   MasterPageFile="~/GUI/MasterPage.master"     CodeFile="TyreRegister.aspx.cs" Inherits="GUI_Fleet_Reports_TyreRegister" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AtlasControlToolkit" Namespace="AtlasControlToolkit" TagPrefix="cc1" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagName="popUp" TagPrefix="popUp" Src="~/GUI/Common_UserControls/PopUpControl.ascx" %>
<%@ Register TagName="CMPFT" TagPrefix="Company" Src="~/GUI/Common_UserControls/CompayFilter.ascx" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MyCPH1" runat="Server">
<script src="../../images/commonJs.js"  language="javascript" type="text/javascript"></script>

<script src="../../images/CalendarPopup.js"  language="javascript" type="text/javascript"></script>

  <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>
    
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
    
    <script type="text/javascript">
    
        function numeric(e) { return ((e.keyCode == 8) || (e.keyCode > 47 && e.keyCode <58)); }
         
        function SelectAll(chk,chklist)
        {
            var checkBoxList = chklist;
            if(chk.checked == true)
            {
                if(checkBoxList !=null)
                {
                    var options = checkBoxList.getElementsByTagName('input');
                    var arrayOfCheckBoxLabels= checkBoxList.getElementsByTagName("label");
                    for(i=0;i<options.length;i++)
                    {
                        var opt = options[i];
                        opt.checked = true;
                    } 
                }
            }
            else
            {
                if(checkBoxList !=null)
                {
                    var options = checkBoxList.getElementsByTagName('input');
                    var arrayOfCheckBoxLabels= checkBoxList.getElementsByTagName("label");
                    for(i=0;i<options.length;i++)
                    {
                        var opt = options[i];
                        opt.checked = false;
                    } 
                }
            }
        }
          function cust(ID)
        {
         ///var FrmChild = window.open('../PopUp_Cust.aspx?ID="+ID' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
         var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
            var strPopupURL = "../PopUp_Cust.aspx?ID="+ID
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        } 
//          function OnSub_DATACHECK()
//    {
//        window.open("TyreRegister_Report.aspx","");
//        return false;
//    }
     
    </script> 

<asp:UpdateProgress ID="uppMain" runat="server">
<ProgressTemplate>
    <iframe frameborder="0" src="about:blank"
        style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);"><img src="../../images/loading.gif" /><font face=verdana color=blue size=4>&nbsp;<b>Please Wait...</b></font></div>
</ProgressTemplate>
</asp:UpdateProgress>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
    <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fleet Module  > Reports >Tyre Register</asp:Label>
            </td> 
            
             <td align="right">

          </td>      
        </tr>
    </table>
    
    <hr align="center" size="1" color="#8ba0e5">
      <br> 

       <table cellspacing="1" cellpadding="2" style="width: 26%" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center" style="vertical-align: top; width: 20%; ">
                                <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                            </td>
                        </tr>
                         <tr id="Tr1" visible="true" runat="server" style="background-color: white">
                        <td   align="left" style="width:  23%"  >
                            <asp:Label ID="Label1"  Font-Bold="True" CssClass="blackfnt" Text="Select Company Type" runat="server"></asp:Label>
                        </td>
                        <td align="left" valign="top"  colspan="1" >
                           <Company:CMPFT ID="CMPFT1" runat="server" />
                       </td>
                    </tr> 
           <tr style="background-color: white">
            <td align="left"  valign="center" width="23%">
                <asp:Label ID="Label4" CssClass="blackfnt" runat="server" Font-Bold="True">Purchase Date Range :</asp:Label></td>
            <td align="left" colspan="1" width="77%">
                <Date:DT ID="DT" EnableTillDate="false" runat="server" />
            </td>
        </tr>

        <tr style="background-color: white">
            <td colspan="2" align="right" valign="center" style="width: 100%; text-align: left;">
            <popUp:popUp ID="popUpTyreCat" runat="server"
            ReadOnly="false"
            Header_Text="Tyre Category :"
            Table_Name="Webx_Master_General"
            Value_Field="CODEID"
            Text_Field="CODEDESC"
            Active_Flag_Field="STATUSCODE"
            CodeType = "TYCAT"
            Width="500" Height="300" />       
            </td>
          </tr>                  

                        
                    

        <tr style="background-color: white">
            <td colspan="2" align="right" valign="center" style="width: 100%; text-align: left;">
            <popUp:popUp ID="popUpTyreMfg" runat="server"
            ReadOnly="false"
            Header_Text="Tyre Manufacturer :"
            Table_Name="WEBX_FLEET_TYREMFG"
            Value_Field="MFG_ID"
            Text_Field="MFG_NAME"
            Active_Flag_Field="MFG_ACTIVEFLAG"
            Width="600" Height="300" />       
            </td>
          </tr>                  

     
        <tr style="background-color: white">
            <td colspan="2" align="right" valign="center" style="width: 100%; text-align: left;">
            <popUp:popUp ID="popUpTyreModelNo" runat="server"
            ReadOnly="false"
            Header_Text="Tyre Model No :"
            Table_Name="WEBX_FLEET_TYREMODELMST"
            Value_Field="TYRE_MODEL_ID"
            Text_Field="MODEL_NO"
            Active_Flag_Field="ACTIVE_FLAG"
            Width="800" Height="300" />       
            </td>
          </tr>                  
       
        <tr style="background-color: white">
            <td colspan="2" align="right" valign="center" style="width: 100%; text-align: left;">
            <popUp:popUp ID="popUpTyreSize" runat="server"
            ReadOnly="false"
            Header_Text="Tyre Size :"
            Table_Name="WEBX_FLEET_TYRESIZEMST"
            Value_Field="TYRE_SIZEID"
            Text_Field="TYRE_SIZENAME"
            Active_Flag_Field="SIZE_ACTIVEFLAG"
            Width="400" Height="300" />       
            </td>
          </tr>                  

        <tr style="background-color: white">
            <td colspan="2" align="right" valign="center" style="width: 100%; text-align: left;">
            <popUp:popUp ID="popUpTyrePattern" runat="server"
            ReadOnly="false"
            Header_Text="Tyre Pattern :"
            Table_Name="WEBX_FLEET_TYREPATTERN"
            Value_Field="TYRE_PATTERNID"
            Text_Field="TYRE_PATTERN_DESC"
            Active_Flag_Field="ACTIVE_FLAG"
            Width="400" Height="300" />       
            </td>
          </tr>                  

        <tr style="background-color: white">
            <td colspan="2" align="right" valign="center" style="width: 100%; text-align: left;">
            <popUp:popUp ID="popUpTyreType" runat="server"
            ReadOnly="false"
            Header_Text="Tyre Type :"
            Table_Name="Webx_Master_General"
            Value_Field="CODEID"
            Text_Field="CODEDESC"
            Active_Flag_Field="STATUSCODE"
            CodeType="TYTYP"
            Width="400" Height="300" />       
            </td>
          </tr>                  

       <tr style="background-color: white">
           <td align="right" style="vertical-align: top; width: 20%; text-align: left">
               <asp:Label ID="Label12" runat="server" CssClass="blackfnt" Font-Bold="True" Text="NSD Range :"></asp:Label></td>
           <td align="left"  style="width: 527px">
               <asp:Label ID="Label15" runat="server" CssClass="blackfnt" Text=" From: "></asp:Label><asp:TextBox
                   ID="txtNSDRangeF" runat="server" BorderStyle="Groove" CssClass="input" ValidationGroup="VGDtFromTo"
                   Width="80"  onkeydown="return numeric(event)" ></asp:TextBox>
               <asp:Label ID="Label16" runat="server" CssClass="blackfnt" Text=" To: "></asp:Label><asp:TextBox
                   ID="txtNSDTo" runat="server" BorderStyle="Groove" CssClass="input" ValidationGroup="VGDtFromTo"
                   Width="80" onkeydown="return numeric(event)" ></asp:TextBox></td>
           
       </tr>
           
       <tr style="background-color: white">
           <td align="right" style="vertical-align: top; width: 20%; height: 18px; text-align: left">
               <asp:Label ID="Label13" runat="server" CssClass="blackfnt" Font-Bold="True" Text="KM run range :"></asp:Label></td>
           <td align="left"  style="width: 527px; height: 18px">
               <asp:Label ID="Label17" runat="server" CssClass="blackfnt" Text=" From: "></asp:Label><asp:TextBox
                   ID="txtKMF" runat="server" BorderStyle="Groove" CssClass="input" ValidationGroup="VGDtFromTo"
                   Width="80" onkeydown="return numeric(event)" ></asp:TextBox>
               <asp:Label ID="Label18" runat="server" CssClass="blackfnt" Text=" To: "></asp:Label><asp:TextBox
                   ID="txtKMT" runat="server" BorderStyle="Groove" CssClass="input" ValidationGroup="VGDtFromTo"
                   Width="80" onkeydown="return numeric(event)" ></asp:TextBox></td>
          
       </tr>
           
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 20%; text-align: left">
                   <asp:Label ID="Label14" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Tyre Status :"></asp:Label></td>
               <td align="left"  style="width: 527px">
                   <asp:DropDownList ID="ddlTyreStatus" runat="server">
                   </asp:DropDownList>
               </td>
             
           </tr>
           
           <tr style="background-color: white">
               <td align="right" colspan="4" style="font-weight: bold; vertical-align: top; text-align: center; width: 100%;">
                   OR</td>
           </tr>

                    <tr style="background-color: white">
                        <td colspan="2" align="right" valign="center" style="width: 100%; text-align: left;">
                        <popUp:popUp ID="popUpVehicle" runat="server"
                        ReadOnly="false"
                        Header_Text="Select Vehicle :"
                        Table_Name="webx_vehicle_hdr"
                        Value_Field="Veh_Internal_No"
                        Text_Field="VehNo"
                        Active_Flag_Field="ActiveFlag"
                        Width="800" Height="300" />
                        </td>
                      </tr>                  
                    
           <tr style="background-color: white">
               <td align="left" colspan="2" style="font-weight: bold; text-transform: uppercase;
                   width: 100%; text-align: center">
                   or</td>
           </tr>
           
         
                    <tr style="background-color: white">
                        <td colspan="2" align="right" valign="center" style="width: 100%; text-align: left;">
                        <popUp:popUp ID="popUpTyreNo" runat="server"
                        ReadOnly="false"
                        Header_Text="Select Tyre No :"
                        Table_Name="WEBX_FLEET_TYREMST"
                        Value_Field="TYRE_ID"
                        Text_Field="TYRE_NO"
                        Active_Flag_Field="TYRE_ACTIVEFLAG"
                        Width="800" Height="300" />
                        </td>
                      </tr>    
          

                       </table>
  
    <br />
    
        <table cellspacing="1" cellpadding="2" style="width: 700px" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="3" align="center" style="vertical-align: top; width: 30%; text-align: left">
                                <asp:Label ID="Label20" CssClass="blackfnt" Font-Bold="True" runat="server">Report Columns</asp:Label>
                            </td>
                        </tr>
           <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 30%; text-align: left">
                     <asp:Panel ID="pnlTyreSummary" runat="server" CssClass="collapsePanelHeader" Width="100%" > 
                    <div style="padding:5px; cursor: pointer; vertical-align: middle;">
                            <div style="float: left;">Tyre Summary</div>
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        <asp:Label ID="lblTyreSH" runat="server" Font-Bold="True">Show...</asp:Label>
                    </div>
    </asp:Panel>
                   </td>
               <td align="left" colspan="2" style="width: 70%">
                
                 <asp:Panel ID="pnlTyreSummary1" runat="server" CssClass="collapsePanel" Height="0">
                <asp:CheckBox ID="chkSelAllTyreSummary"  Text="Select All" runat="server" Font-Italic="True" />
                   <asp:CheckBoxList ID="chkTyreSummary" runat="server" RepeatColumns="3" RepeatDirection="Horizontal" Width="400px">
                       <asp:ListItem Value="0">Tyre Number</asp:ListItem>
                       <asp:ListItem Value="1">Tyre category</asp:ListItem>
                       <asp:ListItem Value="2">Manufacturer</asp:ListItem>
                       <asp:ListItem Value="3">Model</asp:ListItem>
                       <asp:ListItem Value="4">Size</asp:ListItem>
                       <asp:ListItem Value="5">Pattern</asp:ListItem>
                       <asp:ListItem Value="6">Type</asp:ListItem>
                       <asp:ListItem Value="7">Purchase Date</asp:ListItem>
                       <asp:ListItem Value="8">Purchased as </asp:ListItem>
                       <asp:ListItem Value="9">Purchase Km.</asp:ListItem>
                       <asp:ListItem Value="10">Purchase Cost</asp:ListItem>
                       <asp:ListItem Value="11">Status</asp:ListItem>
                   
                   </asp:CheckBoxList>
                    </asp:Panel>
           
          <ajaxToolkit:CollapsiblePanelExtender ID="cpe" runat="Server"
                TargetControlID="pnlTyreSummary1"
                    ExpandControlID="pnlTyreSummary" CollapseControlID="pnlTyreSummary" Collapsed="True"
                     TextLabelID="lblTyreSH" ExpandedText="Hide..." CollapsedText="Show..."
                     SuppressPostBack="true">
            </ajaxToolkit:CollapsiblePanelExtender>
                                    </td>
           </tr>
           
           
             <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 30%; text-align: left; ">
                     <asp:Panel ID="pnlTreadDet" runat="server" Width="100%" > 
                    <div style="padding:5px; cursor: pointer; vertical-align: middle;">
                            <div style="float: left;">Tread Depth Details</div>
                        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Label ID="lblTreadSH" runat="server" Font-Bold="True">Show...</asp:Label></div>
                    </asp:Panel>
                   </td>
               <td align="left" colspan="2" style="width: 70%;">
                   
                 <asp:Panel ID="pnlTreadDet1" runat="server" CssClass="collapsePanel" Height="0">
                   <asp:CheckBox ID="chkSelAllTreadDepth"   Text="Select All" runat="server" Font-Italic="True" />
                   <asp:CheckBoxList ID="chkTreadDepthDet" runat="server" RepeatColumns="3" RepeatDirection="Horizontal" Width="400px">
                       <asp:ListItem>Last Reading Date</asp:ListItem>
                       <asp:ListItem>TWI 1</asp:ListItem>
                       <asp:ListItem>TWI 2</asp:ListItem>
                       <asp:ListItem>TWI 3</asp:ListItem>
                       <asp:ListItem>Average TWI</asp:ListItem>
                   </asp:CheckBoxList>
                    </asp:Panel>
           
          <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="Server"
                TargetControlID="pnlTreadDet1"
                    ExpandControlID="pnlTreadDet" CollapseControlID="pnlTreadDet" Collapsed="True"
                    TextLabelID="lblTreadSH" ExpandedText="Hide..." CollapsedText="Show..."
                    SuppressPostBack="true">
            </ajaxToolkit:CollapsiblePanelExtender>
                                    </td>
           </tr>
           
           
           
             <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 30%; text-align: left; ">
                     <asp:Panel ID="pnlVehDet" runat="server" Width="100%" > 
                    <div style="padding:5px; cursor: pointer; vertical-align: middle;">
                            <div style="float: left;">Vehicle Details</div>
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;
                        <asp:Label ID="lblVehDetSH" runat="server" Font-Bold="True">Show...</asp:Label></div>
                    </asp:Panel>
                   </td>
               <td align="left" colspan="2" style="width: 70%;">
                
                 <asp:Panel ID="pnlVehDet1" runat="server" CssClass="collapsePanel" Height="0">
                <asp:CheckBox ID="ckhSelAllVehDet"  Text="Select All" runat="server" Font-Italic="True" />
                   <asp:CheckBoxList ID="chkVehDetails" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" Width="400px">
                       <asp:ListItem Value="0">Vehicle Number</asp:ListItem>
                       <asp:ListItem Value="1">Position Category</asp:ListItem>
                       <asp:ListItem Value="2">Position Code</asp:ListItem>
                       <asp:ListItem Value="3">Position</asp:ListItem>
                   </asp:CheckBoxList>
                    </asp:Panel>
           
          <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender2" runat="Server"
                TargetControlID="pnlVehDet1"
                    ExpandControlID="pnlVehDet" CollapseControlID="pnlVehDet" Collapsed="True"
                    TextLabelID="lblVehDetSH" ExpandedText="Hide..." CollapsedText="Show..."
                    SuppressPostBack="true">
            </ajaxToolkit:CollapsiblePanelExtender>
                                    </td>
           </tr>
           
            <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 30%; text-align: left; ">
                     <asp:Panel ID="pnlRemould" runat="server" Width="100%" > 
                    <div style="padding:5px; cursor: pointer; vertical-align: middle;">
                            <div style="float: left;">Remould Information</div>
                        &nbsp;&nbsp;&nbsp; &nbsp;
                        <asp:Label ID="lblRemouldSH" runat="server" Font-Bold="True">Show...</asp:Label></div>
                    </asp:Panel>
                   </td>
               <td align="left" colspan="2" style="width: 70%;">
                
                 <asp:Panel ID="pnlRemould1" runat="server" CssClass="collapsePanel" Height="0">
                 <asp:CheckBox ID="chkSelAllRemould"  Text="Select All" runat="server" Font-Italic="True" />
                   <asp:CheckBoxList ID="chkRemouldDet" runat="server" RepeatColumns="1" RepeatDirection="Horizontal" Width="400px">
                       <asp:ListItem>Remoulded</asp:ListItem>
                       <asp:ListItem>No. of time remoulded</asp:ListItem>
                       <asp:ListItem>Remould Cost</asp:ListItem>
                   </asp:CheckBoxList>
                    </asp:Panel>
           
          <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender3" runat="Server"
                TargetControlID="pnlRemould1"
                    ExpandControlID="pnlRemould" CollapseControlID="pnlRemould" Collapsed="True"
                    TextLabelID="lblRemouldSH" ExpandedText="Hide..." CollapsedText="Show..."
                    SuppressPostBack="true">
            </ajaxToolkit:CollapsiblePanelExtender>
                                    </td>
           </tr>
            <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 30%; text-align: left; ">
                    
                     <asp:Panel ID="pnlCost" runat="server" Width="100%" > 
                    <div style="padding:5px; cursor: pointer; vertical-align: middle;">
                            <div style="float: left;">Costing</div>
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<asp:Label
                            ID="lblCostingSH" runat="server" Font-Bold="True">Show...</asp:Label></div>
                    </asp:Panel>
                   </td>
               <td align="left" colspan="2" style="width: 70%;">
               
                 <asp:Panel ID="pnlCost1" runat="server" CssClass="collapsePanel" Height="0">
                    <asp:CheckBox ID="chkSelAllCost" Text="Select All" runat="server" Font-Italic="True" />
                   <asp:CheckBoxList ID="chkCostingDet" runat="server" RepeatColumns="1" RepeatDirection="Horizontal" Width="400px">
                       <asp:ListItem Value="0">KM. Run Count</asp:ListItem>
                       <asp:ListItem Value="1">Total Cost</asp:ListItem>
                       <asp:ListItem Value="2">Cost/KM.</asp:ListItem>
                   </asp:CheckBoxList>
                    </asp:Panel>
           
          <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender4" runat="Server"
                 TargetControlID="pnlCost1"
                    ExpandControlID="pnlCost" CollapseControlID="pnlCost" Collapsed="True"
                    TextLabelID="lblCostingSH" ExpandedText="Hide..." CollapsedText="Show..."
                    SuppressPostBack="true">
            </ajaxToolkit:CollapsiblePanelExtender>
                                    </td>
           </tr>
           
           
           </table>
    <br />
    
    
  <table cellspacing="1" cellpadding="2" style="width: 700px" class="boxbg">
    <tr class="bgbluegrey">
        <td colspan="3" align="center" style="vertical-align: middle; width: 30%; text-align: center">
            <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <asp:Button ID="btnShow" runat="server" Text="Submit" OnClick="btnShow_Click" OnClientClick="Javascript: return OnSub_DATACHECK();"  /> 
                    </ContentTemplate>
                </asp:UpdatePanel>  
        </td>
    </tr>
   </table>
    
    
    <table cellspacing="1" style="width: 100%" align="center">
        <tr style="background-color: white">
            <td colspan="3" align="center" style="vertical-align: top; text-align: left">
                <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                       <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:reportviewer id="ReportViewer1" runat="server" processingmode="Remote" Height="1200px" Width="2680px">
                        </rsweb:reportviewer>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
   
</asp:Content> 