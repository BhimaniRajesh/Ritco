<%@ Page Language="C#" AutoEventWireup="true"   MasterPageFile="~/GUI/MasterPage.master"     CodeFile="TripsheetReport.aspx.cs" Inherits="GUI_Fleet_Reports_Tripsheet" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<%@ Register Assembly="AtlasControlToolkit" Namespace="AtlasControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

  <script language="javascript" type="text/javascript">
    function nwOpen1(mNo)
        {
            window.open("Popup-Vehicle.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
              function nwOpen3(mNo)
        {
            window.open("Popup-Driver1.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
              function nwOpen4(mNo)
        {
            window.open("Popup_ManualNo.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
        
              function nwOpen5(mNo)
        {
            window.open("Popup_TripsheetNo.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
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
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fleet Module  > Reports >Diesel Card Transaction Register</asp:Label>
            </td> 
            
             <td align="right">

          </td>      
        </tr>
    </table>
    
    <hr align="center" size="1" color="#8ba0e5">
      <br> 
      <table cellspacing="1" style="width: 700px">
            <tr >
                <td>  
                    <table cellpadding="2" cellspacing="1" class="boxbg">
                        <tr class="bgbluegrey">
                            <td align="left" colspan="3">
                                <asp:Label ID="Label3" runat="server" CssClass="blackfnt" Font-Bold="true">Search Criteria</asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="right" style="width: 250px" valign="left">
                                <asp:Label ID="Label6" runat="server" CssClass="blackfnt" Font-Bold="True">Tripsheet </asp:Label><asp:DropDownList
                                    ID="ddlDate" runat="server" OnSelectedIndexChanged="ddlro_SelectedIndexChanged"
                                    Width="80px">
                                </asp:DropDownList><asp:Label ID="Label14" runat="server" CssClass="blackfnt" Font-Bold="True">Date Range</asp:Label></td>
                            <td align="left">
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                    <ContentTemplate>
                                        <asp:RadioButtonList ID="radDate" runat="server" AutoPostBack="true" CssClass="blackfnt"
                                            OnSelectedIndexChanged="radDate_OnSelectedIndexChange" ValidationGroup="VGDtFromTo">
                                            <asp:ListItem Selected="True" Text=" Date Range [DD/MM/YYYY]" Value="0"></asp:ListItem>
                                            <asp:ListItem Selected="false" Text=" Last Week (Including Today)" Value="1"></asp:ListItem>
                                            <asp:ListItem Selected="false" Text=" Today" Value="2"></asp:ListItem>
                                            <asp:ListItem Selected="false" Text=" Till Date" Value="3"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                            <td align="left" style="width: 292px" valign="top">
                                <asp:UpdatePanel ID="UpdatePanel7" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                                    <ContentTemplate>
                                        <asp:Label ID="Label7" runat="server" CssClass="blackfnt" Text=" From: "></asp:Label>
                                        <asp:TextBox ID="txtDateFrom" runat="Server" BorderStyle="Groove" CssClass="input"
                                            ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                        <asp:Label ID="Label8" runat="server" CssClass="blackfnt" Text=" To: "></asp:Label>
                                        <asp:TextBox ID="txtDateTo" runat="Server" BorderStyle="Groove" CssClass="input"
                                            ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                        <br />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDateFrom"
                                            CssClass="redfnt" ErrorMessage="Date From cannot be blank" ValidationGroup="VGDtFromTo"></asp:RequiredFieldValidator>
                                        <br />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="txtDateFrom"
                                            CssClass="redfnt" ErrorMessage="Invalid Date From" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                            ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator>
                                        <br />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDateTo"
                                            CssClass="redfnt" ErrorMessage="Date To cannot be blank" ValidationGroup="VGDtFromTo"></asp:RequiredFieldValidator>
                                        <br />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ControlToValidate="txtDateTo"
                                            CssClass="redfnt" ErrorMessage="Invalid Date To" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                            ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator>
                                    </ContentTemplate>
                                    <Triggers>
                                        <atlas:ControlEventTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr class="bgbluegrey">
                            <td align="center" colspan="4">
                                <asp:Label ID="lblheading2" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Select Request Status"></asp:Label>
                            </td>
                        </tr>
                        <tr align="center" style="background-color: white">
                            <td align="right" colspan="1" style="width: 250px">
                                <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Font-Bold="true">
                                        Select Branch   

                                    </asp:Label>
                            </td>
                            <td align="left" colspan="3">
                                &nbsp;&nbsp;
                                <asp:DropDownList ID="ddlro" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlro_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="center" style="background-color: white">
                            <td align="right" colspan="1" style="width: 250px">
                                <asp:Label ID="lblStatus" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Status"></asp:Label>&nbsp;
                            </td>
                            <td align="left" colspan="3">
                                &nbsp;
                                <asp:DropDownList ID="ddlStatus" runat="server">
                                    <asp:ListItem Selected="true">Both</asp:ListItem>
                                    <asp:ListItem>Pending</asp:ListItem>
                                    <asp:ListItem>Completed</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="center" style="background-color: white">
                            <td align="right" colspan="1" style="width: 250px">
                                <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Driverwise"></asp:Label>&nbsp;
                            </td>
                            <td align="left" colspan="3">
                                &nbsp;
                                <asp:TextBox ID="txtDriver1" runat="server" AutoPostBack="true" CssClass="input"
                                    OnTextChanged="RetrieveDriverDataInfo1"></asp:TextBox>
                                <asp:Label ID="Label9" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen3(1)">...</a>'
                                    Width="14px"></asp:Label>
                                <asp:Label ID="lblD1Error" runat="server" CssClass="redfnt" Visible="false"></asp:Label>
                            </td>
                        </tr>
                        <tr align="center" style="background-color: white">
                            <td align="right" colspan="1" style="width: 250px">
                                <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Vehiclewise"></asp:Label>&nbsp;
                            </td>
                            <td align="left" colspan="3">
                                &nbsp;
                                <asp:TextBox ID="txtVehNo" runat="server" CssClass="input"></asp:TextBox>
                                <asp:Label ID="Label10" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen1(1)">...</a>'
                                    Width="14px"></asp:Label>
                            </td>
                        </tr>
                        <tr align="center" style="background-color: white">
                            <td align="right" colspan="1" style="width: 250px">
                                <asp:Label ID="Label5" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Manual Tripsheet No."></asp:Label>&nbsp;
                            </td>
                            <td align="left" colspan="3">
                                &nbsp;
                                <asp:TextBox ID="txtManual" runat="server" CssClass="input"></asp:TextBox>
                                <asp:Label ID="Label12" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen4(1)">...</a>'
                                    Width="14px"></asp:Label>
                            </td>
                        </tr>
                        <tr align="center" style="background-color: white">
                            <td align="right" colspan="1" style="width: 250px">
                                <asp:Label ID="Label11" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Tripsheet No."></asp:Label>&nbsp;
                            </td>
                            <td align="left" colspan="3">
                                &nbsp;
                                <asp:TextBox ID="txtTripsheetNo" runat="server" CssClass="input"></asp:TextBox>
                                <asp:Label ID="Label13" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen5(1)">...</a>'
                                    Width="14px"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    
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
           
          <cc1:CollapsiblePanelExtender ID="cpe" runat="Server">
                <cc1:CollapsiblePanelProperties TargetControlID="pnlTyreSummary1"
                    ExpandControlID="pnlTyreSummary" CollapseControlID="pnlTyreSummary" Collapsed="True"
                     TextLabelID="lblTyreSH" ExpandedText="Hide..." CollapsedText="Show..."
                     SuppressPostBack="true"/>
            </cc1:CollapsiblePanelExtender>
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
           
          <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="Server">
                <cc1:CollapsiblePanelProperties TargetControlID="pnlTreadDet1"
                    ExpandControlID="pnlTreadDet" CollapseControlID="pnlTreadDet" Collapsed="True"
                    TextLabelID="lblTreadSH" ExpandedText="Hide..." CollapsedText="Show..."
                    SuppressPostBack="true"/>
            </cc1:CollapsiblePanelExtender>
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
           
          <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtender2" runat="Server">
                <cc1:CollapsiblePanelProperties TargetControlID="pnlVehDet1"
                    ExpandControlID="pnlVehDet" CollapseControlID="pnlVehDet" Collapsed="True"
                    TextLabelID="lblVehDetSH" ExpandedText="Hide..." CollapsedText="Show..."
                    SuppressPostBack="true"/>
            </cc1:CollapsiblePanelExtender>
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
           
          <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtender3" runat="Server">
                <cc1:CollapsiblePanelProperties TargetControlID="pnlRemould1"
                    ExpandControlID="pnlRemould" CollapseControlID="pnlRemould" Collapsed="True"
                    TextLabelID="lblRemouldSH" ExpandedText="Hide..." CollapsedText="Show..."
                    SuppressPostBack="true"/>
            </cc1:CollapsiblePanelExtender>
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
           
          <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtender4" runat="Server">
                <cc1:CollapsiblePanelProperties TargetControlID="pnlCost1"
                    ExpandControlID="pnlCost" CollapseControlID="pnlCost" Collapsed="True"
                    TextLabelID="lblCostingSH" ExpandedText="Hide..." CollapsedText="Show..."
                    SuppressPostBack="true"/>
            </cc1:CollapsiblePanelExtender>
                                    </td>
           </tr>
           
           
           </table>
    <br />
    
    
  <table cellspacing="1" cellpadding="2" style="width: 700px" class="boxbg">
    <tr class="bgbluegrey">
        <td colspan="3" align="center" style="vertical-align: middle; width: 30%; text-align: center">
            <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <asp:Button ID="btnShow" runat="server" Text="Submit" OnClientClick="javascript:return Validation()"  OnClick="btnShow_Click" /> 
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
    <br />
    
                     <asp:Panel ID="Panel1" runat="server" Height="500px" Style="vertical-align: top; text-align: left"
                    Width="670px" ScrollBars="Vertical" BackColor="White" Font-Names="Verdana" Font-Size="10pt">
                    <table cellpadding="0" cellspacing="0" style="width: 90%">
                        <tr>
                            <td style="vertical-align: top; width: 100px; text-align: left">
                    <asp:CheckBoxList ID="chklstVehNo" runat="server" CellPadding="1" CellSpacing="0"
                        DataSourceID="SqlDataSource1" DataTextField="VEHNO" DataValueField="VEH_INTERNAL_NO"
                        Font-Names="Verdana" Font-Size="8pt" RepeatColumns="5" RepeatDirection="Horizontal"
                        Width="650px">
                    </asp:CheckBoxList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AgilityERP_TestConnectionString %>"
                        SelectCommand="SELECT [VEH_INTERNAL_NO], [VEHNO] FROM [webx_VEHICLE_HDR] ORDER BY [VEH_INTERNAL_NO]">
                    </asp:SqlDataSource>
                    </td>
                        </tr>
                        <tr>
                            <td style="width: 100%; text-align: center; height: 24px;">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" />
                                <asp:Button ID="btnCancle" runat="server" Text="Cancle" /></td>
                        </tr>
                    </table>
                </asp:Panel>
                <br />
                <br />
                <asp:Panel ID="Panel2" runat="server" Height="100px" Style="vertical-align: top; text-align: left"
                    Width="120px" BackColor="White" Font-Names="Verdana" Font-Size="10pt">
                    <table cellpadding="0" cellspacing="0" style="width: 90%">
                        <tr>
                            <td style="vertical-align: top; width: 151px; text-align: left">
                                <asp:CheckBoxList ID="chklstCate" runat="server" CellPadding="1" CellSpacing="0"
                        DataSourceID="SqlDataSource2" DataTextField="CODEDESC" DataValueField="CODEDESC"
                        Font-Names="Verdana" Font-Size="8pt" RepeatColumns="1" RepeatDirection="VERTICAL"
                        Width="90px">
                                </asp:CheckBoxList>
                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:AgilityERP_TestConnectionString %>"
                        SelectCommand="SELECT CODEID,CODEDESC FROM Webx_Master_General WHERE CODETYPE='TYCAT'">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%; text-align: center; height: 24px;">
                                <asp:Button ID="btnCateSubmit" runat="server" Text="Ok" Height="21px" Width="40px" />
                                <asp:Button ID="bntCateCancel" runat="server" Text="Cancle" Height="21px" Width="47px" /></td>
                        </tr>
                    </table>
                </asp:Panel>
   
            <asp:Panel ID="pnlMfg" runat="server" Height="100px" Style="vertical-align: top; text-align: left"
                    Width="120px" BackColor="White" Font-Names="Verdana" Font-Size="10pt">
                    <table cellpadding="0" cellspacing="0" style="width: 90%">
                        <tr>
                            <td style="vertical-align: top; width: 151px; text-align: left">
                                <asp:CheckBoxList ID="chkMfg" runat="server" CellPadding="1" CellSpacing="0"
                        DataSourceID="sqldsMFG" DataTextField="MFG_NAME" DataValueField="MFG_ID"
                        Font-Names="Verdana" Font-Size="8pt" RepeatColumns="1" RepeatDirection="VERTICAL"
                        Width="90px">
                                </asp:CheckBoxList>
                                <asp:SqlDataSource ID="sqldsMFG" runat="server" ConnectionString="<%$ ConnectionStrings:AgilityERP_TestConnectionString %>"
                        SelectCommand="SELECT MFG_ID,MFG_NAME FROM WEBX_FLEET_TYREMFG">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%; text-align: center; height: 24px;">
                                <asp:Button ID="btnMFGok" runat="server" Text="Ok" Height="21px" Width="40px" />
                                <asp:Button ID="btnMFGcancle" runat="server" Text="Cancle" Height="21px" Width="47px" /></td>
                        </tr>
                    </table>
                </asp:Panel>
   
    <asp:Panel ID="pnlModel" runat="server" Height="100px" Style="vertical-align: top; text-align: left"
                    Width="250px" BackColor="White" Font-Names="Verdana" Font-Size="10pt" ScrollBars ="Vertical">
                    <table cellpadding="0" cellspacing="0" style="width: 90%">
                        <tr>
                            <td style="vertical-align: top; width: 151px; text-align: left">
                                <asp:CheckBoxList ID="chkModel" runat="server" CellPadding="1" CellSpacing="0"
                        DataSourceID="sqldsModel" DataTextField="MODEL_NO" DataValueField="TYRE_MODEL_ID"
                        Font-Names="Verdana" Font-Size="8pt" RepeatColumns="2" RepeatDirection="horizontal"
                        Width="230px">
                                </asp:CheckBoxList>
                                <asp:SqlDataSource ID="sqldsModel" runat="server" ConnectionString="<%$ ConnectionStrings:AgilityERP_TestConnectionString %>"
                        SelectCommand="SELECT TYRE_MODEL_ID,MODEL_NO FROM WEBX_FLEET_TYREMODELMST WHERE ACTIVE_FLAG='Y'">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%; text-align: center; height: 24px;">
                                <asp:Button ID="btnModelOk" runat="server" Text="Ok" Height="21px" Width="40px" />
                                <asp:Button ID="btnModelCancle" runat="server" Text="Cancle" Height="21px" Width="47px" /></td>
                        </tr>
                    </table>
                </asp:Panel>
                
                 <asp:Panel ID="pnlSize" runat="server" Height="250px" Style="vertical-align: top; text-align: left"
                    Width="400px" BackColor="White" Font-Names="Verdana" Font-Size="10pt" ScrollBars="Vertical">
                    <table cellpadding="0" cellspacing="0" style="width: 90%">
                        <tr>
                            <td style="vertical-align: top; width: 151px; text-align: left">
                                <asp:CheckBoxList ID="chkSize" runat="server" CellPadding="1" CellSpacing="0"
                        DataSourceID="sqldsSize" DataTextField="TYRE_SIZENAME" DataValueField="TYRE_SIZEID"
                        Font-Names="Verdana" Font-Size="8pt" RepeatColumns="2" RepeatDirection="Horizontal"
                        Width="380px">
                                </asp:CheckBoxList>
                                <asp:SqlDataSource ID="sqldsSize" runat="server" ConnectionString="<%$ ConnectionStrings:AgilityERP_TestConnectionString %>"
                        SelectCommand="SELECT TYRE_SIZEID,TYRE_SIZENAME FROM WEBX_FLEET_TYRESIZEMST WHERE SIZE_ACTIVEFLAG='Y'">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%; text-align: center; height: 24px;">
                                <asp:Button ID="bntSizeOk" runat="server" Text="Ok" Height="21px" Width="40px" />
                                <asp:Button ID="btnSizeCancle" runat="server" Text="Cancle" Height="21px" Width="47px" /></td>
                        </tr>
                    </table>
                </asp:Panel>
                
                    <asp:Panel ID="pnlPattern" runat="server" Height="100px" Style="vertical-align: top; text-align: left"
                    Width="120px" BackColor="White" Font-Names="Verdana" Font-Size="10pt">
                    <table cellpadding="0" cellspacing="0" style="width: 90%">
                        <tr>
                            <td style="vertical-align: top; width: 151px; text-align: left">
                                <asp:CheckBoxList ID="chkPattern" runat="server" CellPadding="1" CellSpacing="0"
                        DataSourceID="sqldsPattern" DataTextField="TYRE_PATTERN_DESC" DataValueField="TYRE_PATTERNID"
                        Font-Names="Verdana" Font-Size="8pt" RepeatColumns="1" RepeatDirection="VERTICAL"
                        Width="90px">
                                </asp:CheckBoxList>
                                <asp:SqlDataSource ID="sqldsPattern" runat="server" ConnectionString="<%$ ConnectionStrings:AgilityERP_TestConnectionString %>"
                        SelectCommand="SELECT TYRE_PATTERNID,TYRE_PATTERN_DESC FROM WEBX_FLEET_TYREPATTERN WHERE ACTIVE_FLAG='Y'">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%; text-align: center; height: 24px;">
                                <asp:Button ID="btnPatOk" runat="server" Text="Ok" Height="21px" Width="40px" />
                                <asp:Button ID="btnPatCancel" runat="server" Text="Cancle" Height="21px" Width="47px" /></td>
                        </tr>
                    </table>
                </asp:Panel>
                
                   <asp:Panel ID="pnlType" runat="server" Height="100px" Style="vertical-align: top; text-align: left"
                    Width="120px" BackColor="White" Font-Names="Verdana" Font-Size="10pt">
                    <table cellpadding="0" cellspacing="0" style="width: 90%">
                        <tr>
                            <td style="vertical-align: top; width: 151px; text-align: left">
                                <asp:CheckBoxList ID="chkType" runat="server" CellPadding="1" CellSpacing="0"
                        DataSourceID="sqldsType" DataTextField="CODEDESC" DataValueField="CODEDESC"
                        Font-Names="Verdana" Font-Size="8pt" RepeatColumns="1" RepeatDirection="VERTICAL"
                        Width="90px">
                                </asp:CheckBoxList>
                                <asp:SqlDataSource ID="sqldsType" runat="server" ConnectionString="<%$ ConnectionStrings:AgilityERP_TestConnectionString %>"
                        SelectCommand="SELECT CODEID,CODEDESC FROM Webx_Master_General WHERE CODETYPE='TYTYP'">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%; text-align: center; height: 24px;">
                                <asp:Button ID="btnTypeOk" runat="server" Text="Ok" Height="21px" Width="40px" />
                                <asp:Button ID="btnTypeCancle" runat="server" Text="Cancle" Height="21px" Width="47px" /></td>
                        </tr>
                    </table>
                </asp:Panel>
                
                
                 <asp:Panel ID="pnlTyre" runat="server" Height="250px" Style="vertical-align: top; text-align: left"
                    Width="500px" BackColor="White" Font-Names="Verdana" Font-Size="10pt" ScrollBars="Vertical">
                    <table cellpadding="0" cellspacing="0" style="width: 90%">
                        <tr>
                            <td style="vertical-align: top; width: 151px; text-align: left">
                                <asp:CheckBoxList ID="chkTyre" runat="server" CellPadding="1" CellSpacing="0"
                        DataSourceID="sqldsTyre" DataTextField="TYRE_NO" DataValueField="TYRE_NO"
                        Font-Names="Verdana" Font-Size="8pt" RepeatColumns="4" RepeatDirection="Horizontal"
                        Width="480px">
                                </asp:CheckBoxList>
                                <asp:SqlDataSource ID="sqldsTyre" runat="server" ConnectionString="<%$ ConnectionStrings:AgilityERP_TestConnectionString %>"
                        SelectCommand="SELECT TYRE_ID,TYRE_NO FROM WEBX_FLEET_TYREMST WHERE TYRE_ACTIVEFLAG='Y'">
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100%; text-align: center; height: 24px;">
                                <asp:Button ID="btnTyreOk" runat="server" Text="Ok" Height="21px" Width="40px" />
                                <asp:Button ID="btnTyreCancel" runat="server" Text="Cancle" Height="21px" Width="47px" /></td>
                        </tr>
                    </table>
                </asp:Panel>
   
</asp:Content> 