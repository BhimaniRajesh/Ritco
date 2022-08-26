<%@ Page Language="C#" AutoEventWireup="true"   MasterPageFile="~/GUI/MasterPage.master"     CodeFile="TripsheetQuery.aspx.cs" Inherits="GUI_Fleet_Reports_TripsheetQueryNew" %>

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
</script>
<asp:UpdateProgress  ID="uppMain" runat="server">
<%--<ProgressTemplate>
    <iframe frameborder="0" src="about:blank"
        style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);"><img src="../../images/loading.gif" /><font face=verdana color=blue size=4>&nbsp;<b>Please Wait...</b></font></div>
</ProgressTemplate>--%>
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
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
    <td align="left">
 
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Fleet Module  > Reports >Journey/Trip Register</asp:Label>
              <%--  <hr align="center" size="1" color="#8ba0e5"> --%>
            </td> 
            
             <td align="right">

         
          </td>      
        </tr>
    </table>

    <hr align="left" size="1" color="#8ba0e5">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
       <table cellspacing="1" cellpadding="2" class="boxbg" style="width: 800px">
                        <tr class="bgbluegrey">
                            <td colspan="3" align="left" style="height: 18px">
                                <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                            </td>
                        </tr>
                       
                      
                        <tr style="background-color: white">
                            <td align="right" valign="left" style="width: 250px">
                                <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">Tripsheet </asp:Label><asp:DropDownList ID="ddlDate"   runat="server" OnSelectedIndexChanged="ddlro_SelectedIndexChanged" Width="80px"    >
                                </asp:DropDownList><asp:Label ID="Label14" runat="server" CssClass="blackfnt" Font-Bold="True">Date Range</asp:Label></td>
                           <td align="left" style="vertical-align: top; text-align: left">
                                    <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        AutoPostBack="true" OnSelectedIndexChanged="radDate_OnSelectedIndexChange">
                                        <asp:ListItem Selected="True" Value="0" Text=" Date Range [DD/MM/YYYY]"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="2" Text=" Today"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="3" Text=" Till Date"></asp:ListItem>
                                    </asp:RadioButtonList></td>
                            <td valign="top" align="left" style="width: 292px; vertical-align: top; text-align: left;">
                            
                                        <asp:Label ID="Label7" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                        <asp:TextBox CssClass="input" ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo"
                                            Width="80" BorderStyle="Groove"></asp:TextBox>
                                        <asp:Label ID="Label8" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                        <asp:TextBox CssClass="input" ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo"
                                            Width="80" BorderStyle="Groove"></asp:TextBox>
                                        <br />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDateFrom"
                                            ErrorMessage="Date From cannot be blank" ValidationGroup="VGDtFromTo" CssClass="redfnt" />
                                        <br />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3"  runat="server" ErrorMessage="Invalid Date From"
                                            ControlToValidate="txtDateFrom" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                            CssClass="redfnt"></asp:RegularExpressionValidator>
                                        <br />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDateTo"
                                            ErrorMessage="Date To cannot be blank" ValidationGroup="VGDtFromTo" CssClass="redfnt" />
                                        <br />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="Invalid Date To"
                                            ControlToValidate="txtDateTo" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                            CssClass="redfnt"></asp:RegularExpressionValidator>
                        
                            </td>
                        </tr>
                        
                        <tr   class="bgbluegrey">
                            <td align="center"  colspan="4">
                                <asp:Label ID="lblheading2"  CssClass="blackfnt" Font-Bold="true"   runat="server" Text="Select Request Status" ></asp:Label>
                                
                     
                              </td>
                           
                        </tr>
                          <tr   style="background-color: white" align="center">
                                <td   align="right" colspan="1" style="width: 250px"  >
                                    <asp:Label ID="Label4" CssClass="blackfnt" 
                                        Font-Bold="true" runat="server">
                                        Select Branch   

                                    </asp:Label>
                                </td>
                                
                                <td align="left" colspan="3" >&nbsp;<asp:DropDownList ID="ddlro" AutoPostBack="true"   runat="server" OnSelectedIndexChanged="ddlro_SelectedIndexChanged"    >
                                      
                                     </asp:DropDownList></td>
                            </tr>
                        
                        
                        
                        
                        
                         <tr style="background-color: white" align="center">
                            
                            
                             <td align="right" colspan="1" style="width: 250px">
                                 <asp:Label ID="lblStatus" runat="server" Text="Status"  CssClass="blackfnt"  Font-Bold="True"></asp:Label>&nbsp;
                              
                                </td>
                            <td align="left" colspan="3">
                                &nbsp;<asp:DropDownList ID="ddlStatus" runat="server">
                                      <asp:ListItem Selected="true">Both</asp:ListItem>
                                    <asp:ListItem>Pending</asp:ListItem>
                                    <asp:ListItem>Completed</asp:ListItem>
                             </asp:DropDownList></td>
                             
                        </tr>
                        
                            <tr style="background-color: white" align="center">
                            
                            
                             <td align="right" colspan="1" style="width: 250px">
                                 <asp:Label ID="Label1" runat="server" Text="Driverwise"  CssClass="blackfnt"  Font-Bold="True"></asp:Label>&nbsp;
                              
                                </td>
                            <td align="left" colspan="3">
                                &nbsp;<asp:TextBox ID="txtDriver1"   AutoPostBack="true" CssClass="input"  runat="server"  OnTextChanged="RetrieveDriverDataInfo1"     ></asp:TextBox>
                    <asp:Label ID="Label9"      runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen3(1)">...</a>'
                                Width="14px"></asp:Label>
                                   <asp:Label ID="lblD1Error"  Visible="false"    runat="server"    CssClass="redfnt"></asp:Label>
                                <asp:HiddenField ID="hfDriverCode" runat="server" />
                            </td>
                             
                        </tr>
                        
                        
                            <tr style="background-color: white" align="center">
                            
                            
                             <td align="right" colspan="1" style="width: 250px; height: 29px;">
                                 <asp:Label ID="Label2" runat="server" Text="Vehiclewise"  CssClass="blackfnt"  Font-Bold="True"></asp:Label>&nbsp;
                              
                                </td>
                            <td align="left" colspan="3" style="height: 29px">
                                &nbsp;<asp:TextBox ID="txtVehNo" CssClass="input"  runat=server     ></asp:TextBox>
                    <asp:Label ID="Label10"      runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen1(1)">...</a>'
                                Width="14px"></asp:Label></td>
                             
                        </tr>
                        
                            <tr style="background-color: white" align="center">
                            
                            
                             <td align="right" colspan="1" style="width: 250px">
                                 <asp:Label ID="Label5" runat="server" Text="Manual Tripsheet No."  CssClass="blackfnt"  Font-Bold="True"></asp:Label>&nbsp;
                              
                                </td>
                            <td align="left" colspan="3">
                                &nbsp;<asp:TextBox ID="txtManual"     CssClass="input"  runat=server    ></asp:TextBox>
                                                  <asp:Label ID="Label12"      runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen4(1)">...</a>'
                                Width="14px"></asp:Label></td>
                             
                        </tr>
                        
                            <tr style="background-color: white" align="center">
                            
                            
                             <td align="right" colspan="1" style="width: 250px">
                                 <asp:Label ID="Label11" runat="server" Text="Tripsheet No."  CssClass="blackfnt"  Font-Bold="True"></asp:Label>&nbsp;
                              
                                </td>
                            <td align="left" colspan="3">
                                &nbsp;<asp:TextBox ID="txtTripsheetNo"    CssClass="input"  runat=server     ></asp:TextBox>
                                                   <asp:Label ID="Label13"      runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen5(1)">...</a>'
                                Width="14px"></asp:Label></td>
                             
                        </tr>
                        	   
                        
                   

                       </table>
     
      <br> 
                       
                     <table cellspacing="1" style="width: 800px"  >
                        <tr  style="background-color: white">
                            <td   colspan="4"  align="left" style="width: 100%; vertical-align: top; text-align: left;">
                
                 
                              <asp:Panel ID="pnlTripsheetDetails" runat="server" Width="100%" >      
                                   
                          <table cellspacing="1" style="width: 100%" class="boxbg"  border="0">
                        <tr class="bgbluegrey">
                            <td   colspan="4"  align="left" style="height: 20px">
                       
                             <font class="bluefnt"><b>Tripsheet Details</b></font>
                        <asp:Label ID="lblTDSH" runat="server" Font-Bold="True">Show...</asp:Label>
                            </td>
                            
                            </tr>
                               </table>
                        </asp:Panel>
                              <asp:Panel ID="pnlTripDt" runat="server" Width="800px" >      
                                   
                          <table cellspacing="1" style="width: 100%" class="boxbg"  border="0">
                          
                              <tr style="background-color: white">
                                     <td   colspan="4"  align="right">
                        
                 <asp:CheckBox ID ="chkTripAll"  runat="server"></asp:Checkbox>  <font class="blackfnt">Select All</font> &nbsp;&nbsp;
                         
                       
                       
                            </td>
                        </tr>
                              <tr style="background-color: white">
                                  <td align="right" colspan="4" style="vertical-align: top; text-align: left">
                                      <asp:CheckBoxList ID="chklstTripsheetDet" runat="server" RepeatColumns="4" RepeatDirection="Horizontal"
                                          Width="100%">
                                          <asp:ListItem Enabled="False" Selected="True">Tripsheet No.</asp:ListItem>
                                          <asp:ListItem>Tripsheet Start Date</asp:ListItem>
                                          <asp:ListItem>Tripsheet End Date</asp:ListItem>
                                          <asp:ListItem>Start Location</asp:ListItem>
                                          <asp:ListItem>End Location</asp:ListItem>
                                          <asp:ListItem>From City</asp:ListItem>
                                          <asp:ListItem>To City</asp:ListItem>
                                          <asp:ListItem>Category</asp:ListItem>
                                          <asp:ListItem>Total Kms</asp:ListItem>
                                          <asp:ListItem>Vehicle No</asp:ListItem>
                                          <asp:ListItem>Vehicle Category</asp:ListItem>
                                          <asp:ListItem>Driver Name</asp:ListItem>
                                          <asp:ListItem>Status</asp:ListItem>
                                          <asp:ListItem>Starting KM</asp:ListItem>
                                          <asp:ListItem>Closing KM</asp:ListItem>
                                          <asp:ListItem>Total KM</asp:ListItem>
                                          <asp:ListItem>Approved KMPL</asp:ListItem>
                                          <asp:ListItem>Actual KMPL</asp:ListItem>
                                          <asp:ListItem>Diesel Quantity</asp:ListItem>
                                          <asp:ListItem>Bill Prepared Y/N</asp:ListItem>
                                          <asp:ListItem>Bill No</asp:ListItem>
                                          <asp:ListItem>THC Attached Y/N</asp:ListItem>
                                          <asp:ListItem>Customer Name</asp:ListItem>
                                          <asp:ListItem>Total THC Amount</asp:ListItem>
                                      </asp:CheckBoxList></td>
                              </tr>
                        </table>
                        </asp:Panel>
                        
                              <cc1:CollapsiblePanelExtender ID="cpe" runat="Server">
                <cc1:CollapsiblePanelProperties TargetControlID="pnlTripDt"
                    ExpandControlID="pnlTripsheetDetails" CollapseControlID="pnlTripsheetDetails" Collapsed="True"
                     TextLabelID="lblTDSH" ExpandedText="Hide..." CollapsedText="Show..."
                     SuppressPostBack="true"/>
            </cc1:CollapsiblePanelExtender>
                        
                        
                        
                           <asp:Panel ID="pnlExpDet" runat="server" Width="800px" >      
                                   
                                                
                         <table cellspacing="1"  class="boxbg" style="width: 100%"  >
                         
                         
                         
                        
                        
                        
                                     <tr class="bgbluegrey">
                            <td  colspan="4"   align="left" style="height: 20px">
                   <font class="bluefnt"><b>Expense Details</b></font>
                    <asp:Label ID="Label15" runat="server" Font-Bold="True">Show...</asp:Label>
                       
                            </td>
                            
                            </tr>
                             
                        </table>
                        </asp:Panel>
                        <asp:Panel ID="pnlExpDet1" runat="server" Width="800px" >      
                            <table cellspacing="1"  class="boxbg" style="width: 100%"  >
                             <tr style="background-color: white">
                                     <td colspan="4"  align="right">
                                  
         <asp:CheckBox ID ="chkExpAll"  runat="server"></asp:Checkbox>  <font class="blackfnt">Select All</font>
 
                       
                            </td>
                        </tr>
                                <tr style="background-color: white">
                                    <td align="right" colspan="4" style="vertical-align: top; text-align: left">
                                        <asp:CheckBoxList ID="chklstExpDet" runat="server" RepeatColumns="4" RepeatDirection="Horizontal"
                                          Width="100%">
                                            <asp:ListItem>Advance</asp:ListItem>
                                            <asp:ListItem>Repair</asp:ListItem>
                                            <asp:ListItem>Claims</asp:ListItem>
                                            <asp:ListItem>Fuel</asp:ListItem>
                                            <asp:ListItem>Incded</asp:ListItem>
                                            <asp:ListItem>Spare</asp:ListItem>
                                        </asp:CheckBoxList></td>
                                </tr>
                        </table>
                        </asp:Panel>
                        
                                    
           <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="Server">
                <cc1:CollapsiblePanelProperties TargetControlID="pnlExpDet1"
                    ExpandControlID="pnlExpDet" CollapseControlID="pnlExpDet" Collapsed="True"
                     TextLabelID="Label15" ExpandedText="Hide..." CollapsedText="Show..."
                     SuppressPostBack="true"/>
            </cc1:CollapsiblePanelExtender>
                        
                        
                              
                           <asp:Panel ID="pnlEnroteExp" runat="server" Width="800px" >      
                                   
                                                
                         <table cellspacing="1"  class="boxbg" style="width: 100%"  >
                         
                         
                                    <tr class="bgbluegrey">
                            <td  colspan="4"   align="left" style="height: 20px">
                   <font class="bluefnt"><b>Enroute Expense Details</b></font>
                         <asp:Label ID="Label16" runat="server" Font-Bold="True">Show...</asp:Label>
                            </td>
                            
                            
                            </tr>
                            </table>
                            </asp:Panel>
                             <asp:Panel ID="pnlEnroteExp1" runat="server" Width="800px" >      
                                   
                                                
                         <table cellspacing="1"  class="boxbg" style="width: 100%"  >
                         
                              <tr style="background-color: white">
                                     <td   colspan="4"  align="right">
                        
                 <asp:CheckBox ID ="chkEnExp"  runat="server" ></asp:Checkbox>  <font class="blackfnt">Select All</font> &nbsp;&nbsp;
                         
                       
                       
                            </td>
                        </tr>
                             <tr style="background-color: white">
                                 <td align="right" colspan="4" style="vertical-align: top; text-align: left">
                                     <asp:CheckBoxList ID="chklstEnrouteExp" runat="server" RepeatColumns="4" RepeatDirection="Horizontal"
                                          Width="100%">
                                         <asp:ListItem>RTO</asp:ListItem>
                                         <asp:ListItem>Border/Check Post</asp:ListItem>
                                         <asp:ListItem>Toll</asp:ListItem>
                                         <asp:ListItem>Sales Tax Seal</asp:ListItem>
                                         <asp:ListItem>Escorts</asp:ListItem>
                                         <asp:ListItem>Octroi (if paid)</asp:ListItem>
                                         <asp:ListItem>Loading </asp:ListItem>
                                         <asp:ListItem>Unloading</asp:ListItem>
                                         <asp:ListItem>Enroute Repairs</asp:ListItem>
                                         <asp:ListItem>Panalty (if any)</asp:ListItem>
                                         <asp:ListItem>Tyre Puncture</asp:ListItem>
                                         <asp:ListItem>Weigh Bridge Expenses</asp:ListItem>
                                         <asp:ListItem>Parking</asp:ListItem>
                                         <asp:ListItem>Telephone</asp:ListItem>
                                         <asp:ListItem>Temporary Permit (if any)</asp:ListItem>
                                         <asp:ListItem>Driver Daily Allowance</asp:ListItem>
                                         <asp:ListItem>Incentive Payable</asp:ListItem>
                                         <asp:ListItem>Other Expense</asp:ListItem>
                                         <asp:ListItem>Broker Commission</asp:ListItem>
                                     </asp:CheckBoxList></td>
                             </tr>
                 
                    </table> 
                    
                    </asp:Panel>
                               
                              <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtender2" runat="Server">
                <cc1:CollapsiblePanelProperties TargetControlID="pnlEnroteExp1"
                    ExpandControlID="pnlEnroteExp" CollapseControlID="pnlEnroteExp" Collapsed="True"
                     TextLabelID="Label16" ExpandedText="Hide..." CollapsedText="Show..."
                     SuppressPostBack="true"/>
            </cc1:CollapsiblePanelExtender>
                        
                    


      
                           <asp:Panel ID="pnlActualExp" runat="server" Width="800px" >      
                                   
                                                
                         <table cellspacing="1"  class="boxbg" style="width: 100%"  >
                         
                         
                                    <tr class="bgbluegrey">
                            <td  colspan="4"   align="left" style="height: 20px">
                   <font class="bluefnt"><b>Income/Expense Details</b></font>
                         <asp:Label ID="Label17" runat="server" Font-Bold="True">Show...</asp:Label>
                            </td>
                            
                            
                            </tr>
                            </table>
                            </asp:Panel>
                             <asp:Panel ID="pnlActualExp1" runat="server" Width="800px" >      
                                   
                                                
                         <table cellspacing="1"  class="boxbg" style="width: 100%"  >
                         
                              <tr style="background-color: white">
                                     <td   colspan="4"  align="right">
                        
                 <asp:CheckBox ID ="chkAllActExp"  runat="server" ></asp:Checkbox>  <font class="blackfnt">Select All</font> &nbsp;&nbsp;
                         
                       
                       
                            </td>
                        </tr>
                             <tr style="background-color: white">
                                 <td align="right" colspan="4" style="vertical-align: top; text-align: left">
                                     <asp:CheckBoxList ID="chklstActExp" runat="server" RepeatColumns="1" RepeatDirection="Horizontal"
                                          Width="100%">
                                         <asp:ListItem>Tripsheet Income</asp:ListItem>
                                         <asp:ListItem>450041 Disb-Local (Actual) Toll/Escort/Othr Owned Vehicle</asp:ListItem>
                                         <asp:ListItem>450042 Disb-Local (Actual) Loading/Unloading Owned Vehicle</asp:ListItem>
                                         <asp:ListItem>450053 Disb-Local (Actual) Brokerage Owned Vehicle</asp:ListItem>
                                         <asp:ListItem>450047 Disb-Local (Actual) Repair And M Owned Vehicle</asp:ListItem>
                                         <asp:ListItem>450019 Disb-Local (Actual) Octroi/Duties WAndD</asp:ListItem>
                                         <asp:ListItem>450046 Disb-Local (Actual) Drivers Allowance Owned Vehicle</asp:ListItem>
                                         <asp:ListItem>450044 Disb-Local (Actual) Fuel Owned Vehicle</asp:ListItem>
                                         <asp:ListItem>Total Expense</asp:ListItem>
                                     </asp:CheckBoxList></td>
                             </tr>
                 
                    </table> 
                    
                    </asp:Panel>
                               
                              <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtender3" runat="Server">
                <cc1:CollapsiblePanelProperties TargetControlID="pnlActualExp1"
                    ExpandControlID="pnlActualExp" CollapseControlID="pnlActualExp" Collapsed="True"
                     TextLabelID="Label17" ExpandedText="Hide..." CollapsedText="Show..."
                     SuppressPostBack="true"/>
            </cc1:CollapsiblePanelExtender>
                        
                    



                                <br />
          
                    </td>
                    </tr>
                                                <br />
                                                <tr  class="bgbluegrey">
                                                    <td align="left" colspan="4" style="width: 100%; text-align: center;">
                   
                                        <asp:Button ID="btnShow" runat="server" Text="Submit"  ValidationGroup="VGDtFromTo" OnClick="btnShow_Click" /> 
                
                                                    </td>
                                                </tr>
                                                <tr style="background-color: white">
                                                    <td align="left" colspan="4" style="width: 100%">
                                                    </td>
                                                </tr>
               
                    </table>
      <br/>
    <br />
    <table align="center" cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="center" colspan="3" style="vertical-align: top; text-align: left">
           
                       <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
<rsweb:reportviewer id="ReportViewer1" runat="server" height="800px" processingmode="Remote"
                            width="6500px">
                        </rsweb:reportviewer>
               
            </td>
        </tr>
    </table>
   </ContentTemplate>
    </asp:UpdatePanel>
    
</asp:Content> 