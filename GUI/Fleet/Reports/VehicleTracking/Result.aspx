<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
     CodeFile="Result.aspx.cs"
     Inherits="Vehicle_Tracking_Report_Result"  %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=14.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<style type="text/css">

</style>
<script language="javascript" type="text/javascript">
    var controlIdPrefix = "ctl00_MyCPH1_";
    
    function nwOpenViewWindow() {
        if (document.getElementById(controlIdPrefix + "tb_Vehicle_No").value == "")
            alert("Please Enter Vehicle Number");
        else
        window.open("VehicleTrackingView.aspx?VehicleNo="+ document.getElementById(controlIdPrefix + "tb_Vehicle_No").value,"myWindow","height=500,width=950,left=25,top=100,resizable=yes,scrollbars=yes");
    }
    
//     var oldgridSelectedColor;

//    function setMouseOverColor(element)
//    {
//        oldgridSelectedColor = element.style.backgroundColor;
//        element.style.backgroundColor='yellow';
//        element.style.cursor='hand';
//        element.style.textDecoration='underline';
//    }

//    function setMouseOutColor(element)
//    {
//        element.style.backgroundColor=oldgridSelectedColor;
//        element.style.textDecoration='none';
//    }




</script>


 <asp:UpdateProgress ID="uppMain" runat="server">
            <ProgressTemplate>
                <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                    -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                    <tr>
                        <td align="right">
                            <img src="../../../images/loading.gif" alt="" />
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
        
    <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Fleet</strong></font> <strong>&gt; </strong>
                <font class="blklnkund"><strong>Reports </strong></font><strong>&gt; </strong>
                <font class="bluefnt"><strong>Vehicle Tracking Report</strong></font>&nbsp;</td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="../../../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr>
            <td>
                <img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>
    </table>   
    <br />
    <br />
    <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    
        <table width="100%">
    <tr>
    <td>
    
    <asp:Table ID="Table2" runat="server" HorizontalAlign="left" CssClass="boxbg"
            CellSpacing="1" BorderWidth="0" Width="500px" BorderStyle="Groove">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="center" ColumnSpan="6" CssClass="blackfnt" Style="height: 20px;">
                    <b>Criteria</b>
                </asp:TableCell>
            </asp:TableRow>

            <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                <asp:TableCell Width="30%"  HorizontalAlign="left">
                    Enter Vehicle Number 
                </asp:TableCell> 
                <asp:TableCell Width="70%"  HorizontalAlign="left">
                 
                    <asp:TextBox ID="tb_Vehicle_No" AutoPostBack="true"  
                        ontextchanged="tb_Vehicle_No_TextChanged" CssClass="input" runat="server"></asp:TextBox>
                        
                    <td class="blackfnt" style="text-align: center">
                        <a href="javascript:nwOpenViewWindow()" class="blackfnt">View</a>
                    </td>

                </asp:TableCell>
            </asp:TableRow>
                        
    </asp:Table> 

    </td>
    </tr>
    
    <tr>
    <td>
  
     <ajaxToolkit:TabContainer runat="server" ID="tabVehicleStatus" Height="800px" ActiveTabIndex="0"  CssClass="ajax__tab_yuitabview-theme"  Width="100%">
            <ajaxToolkit:TabPanel runat="server" ID="Panel1" HeaderText="Vehicle Status">
                <ContentTemplate>
                
             
                    <asp:Table ID="tblMain" runat="server" HorizontalAlign="left" CellPadding="5"  CssClass="boxbg"
                        CellSpacing="1" BorderWidth="0" Width="700px" BorderStyle="Groove">
                      <%--  <asp:TableRow CssClass="bgbluegrey">
                            <asp:TableCell HorizontalAlign="center" ColumnSpan="6" CssClass="blackfnt" Style="height: 20px;">
                                <b>VEHICLE STATUS</b>
                            </asp:TableCell>
                        </asp:TableRow>--%>

                        <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell Width="30%"  HorizontalAlign="left">
                                Vehicle Number
                            </asp:TableCell> 
                            <asp:TableCell Width="70%"  HorizontalAlign="left">
                                <asp:Label ID="lblVehNo" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        
                        <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell HorizontalAlign="left">
                                Vehicle Status 
                            </asp:TableCell> 
                            <asp:TableCell  HorizontalAlign="left">
                                <asp:Label ID="lblVehicleStatus" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        
                        <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell HorizontalAlign="left">
                                Total KM travelled 
                            </asp:TableCell> 
                            <asp:TableCell  HorizontalAlign="left">
                                <asp:Label ID="lblTotalKM" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        
                        
                        <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell HorizontalAlign="left">
                                Total Fuel Filled 
                            </asp:TableCell> 
                            <asp:TableCell  HorizontalAlign="left">
                                <asp:Label ID="lblTotalFuel" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        
                        <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell HorizontalAlign="left">
                                Lifetime KMPL 
                            </asp:TableCell> 
                            <asp:TableCell  HorizontalAlign="left">
                                <asp:Label ID="lblKMPL" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        
                        
                        <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell HorizontalAlign="left">
                                Vehicle Total Expense (in Lacs) 
                            </asp:TableCell> 
                            <asp:TableCell  HorizontalAlign="left">
                                <asp:Label ID="lblVehTotalExp" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
            
                        <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell HorizontalAlign="left">
                                Vehicle Cost/km 
                            </asp:TableCell> 
                            <asp:TableCell  HorizontalAlign="left">
                                <asp:Label ID="lblVehCost" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        
                         <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell HorizontalAlign="left">
                                Total Trip Count 
                            </asp:TableCell> 
                            <asp:TableCell  HorizontalAlign="left">
                                <asp:Label ID="lblTotalTrip" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        
                        
                         <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell HorizontalAlign="left">
                                Average Vehicle KM per trip 
                            </asp:TableCell> 
                            <asp:TableCell  HorizontalAlign="left">
                                <asp:Label ID="lblAvgVehKMTrip" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        
                         <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell HorizontalAlign="left">
                                Average Trip completion days 
                            </asp:TableCell> 
                            <asp:TableCell  HorizontalAlign="left">
                                <asp:Label ID="lblAvgTripCompletionDay" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                      </asp:Table>
                      
                        </ContentTemplate>
   
            </ajaxToolkit:TabPanel>
            
            <ajaxToolkit:TabPanel runat="server" ID="tabVehicleInfo" HeaderText="Vehicle Information" >
                <ContentTemplate>
                     <asp:Table ID="Table1" runat="server"  CellPadding="5" HorizontalAlign="left" CssClass="boxbg"
                        CellSpacing="1" BorderWidth="0" Width="600px" BorderStyle="Groove">
                       <%-- <asp:TableRow CssClass="bgbluegrey">
                            <asp:TableCell HorizontalAlign="center" ColumnSpan="2" CssClass="blackfnt" Style="height: 20px;">
                                <b>VEHICLE INFORMATION</b>
                            </asp:TableCell>
                        </asp:TableRow>--%>

                        <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell Width="30%"  HorizontalAlign="left">
                                Vehicle Number 
                            </asp:TableCell> 
                            <asp:TableCell Width="70%"   HorizontalAlign="left">
                                <asp:Label ID="lblVehicleNo" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        
                        <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell HorizontalAlign="left">
                                Controlling Branch 
                            </asp:TableCell> 
                            <asp:TableCell  HorizontalAlign="left">
                                <asp:Label ID="lblControllingBranch" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        
                        
                        <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell HorizontalAlign="left">
                                Vehicle Type 
                            </asp:TableCell> 
                            <asp:TableCell  HorizontalAlign="left">
                                <asp:Label ID="lblVehicleType" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        
                        <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell HorizontalAlign="left">
                                Made By 
                            </asp:TableCell> 
                            <asp:TableCell  HorizontalAlign="left">
                                <asp:Label ID="lblMadyBy" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        
                        <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell HorizontalAlign="left">
                                GPS Enabled 
                            </asp:TableCell> 
                            <asp:TableCell  HorizontalAlign="left">
                                <asp:Label ID="lblGPSEnabaled" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        
                        
                         <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell  ColumnSpan="2" HorizontalAlign="left">
                             <b>   Other Information </b>
                            </asp:TableCell> 
                          
                        </asp:TableRow>
                        
                         <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell HorizontalAlign="left">
                                Engine No. 
                            </asp:TableCell> 
                            <asp:TableCell  HorizontalAlign="left">
                                <asp:Label ID="lblEngineNo" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        
                         <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell HorizontalAlign="left">
                                Chasis No. 
                            </asp:TableCell> 
                            <asp:TableCell  HorizontalAlign="left">
                                <asp:Label ID="lblChasisNo" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        
                         <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell HorizontalAlign="left">
                                Date of Commencement 
                            </asp:TableCell> 
                            <asp:TableCell  HorizontalAlign="left">
                                <asp:Label ID="lblDtComm" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        
                         <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell  ColumnSpan="2" HorizontalAlign="left">
                             <b>   Inner Dimension in ft </b>
                            </asp:TableCell> 
                          
                        </asp:TableRow>
                        
                        
                         <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell HorizontalAlign="left">
                                Length 
                            </asp:TableCell> 
                            <asp:TableCell  HorizontalAlign="left">
                                <asp:Label ID="lblLength" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        
                        <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell HorizontalAlign="left">
                                Height 
                            </asp:TableCell> 
                            <asp:TableCell  HorizontalAlign="left">
                                <asp:Label ID="lblHeight" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell HorizontalAlign="left">
                                Width 
                            </asp:TableCell> 
                            <asp:TableCell  HorizontalAlign="left">
                                <asp:Label ID="lblWidth" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        
                        
                        <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell  ColumnSpan="2" HorizontalAlign="left">
                                <b> Payload Capacity as per RC in Ton  </b>
                            </asp:TableCell> 
                          
                        </asp:TableRow>
                        
                        
                         <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell HorizontalAlign="left">
                                GVW 
                            </asp:TableCell> 
                            <asp:TableCell  HorizontalAlign="left">
                                <asp:Label ID="lblGVW" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        
                        <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell HorizontalAlign="left">
                                Unladen 
                            </asp:TableCell> 
                            <asp:TableCell  HorizontalAlign="left">
                                <asp:Label ID="lblUnladen" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle">
                            <asp:TableCell HorizontalAlign="left">
                                Capacity 
                            </asp:TableCell> 
                            <asp:TableCell  HorizontalAlign="left">
                                <asp:Label ID="lblCapacity" runat="server" CssClass="blackfnt"></asp:Label>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </ContentTemplate>
            </ajaxToolkit:TabPanel>
            
            <ajaxToolkit:TabPanel runat="server" ID="tabDocumentDetails" HeaderText="Document Details" >
                <ContentTemplate>
                          
                        <asp:GridView ID="gvDocument" BorderWidth="0" CellSpacing="1" CellPadding="5" 
                                EmptyDataRowStyle-CssClass="bgbluegrey" EmptyDataText="No Reocord Found"  
                                runat="server" Width="100%" CssClass="boxbg" AutoGenerateColumns="false" 
                                HeaderStyle-CssClass="bgbluegrey"
                                FooterStyle-CssClass="bgwhite"
                                PagerSettings-Mode="NumericFirstLast" SelectedIndex="1">
                                <Columns>
                                     <asp:TemplateField HeaderText="Document Number" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true"  />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DOCUMENT_NO") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Document Type" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DOCUTYPE") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Document Description" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DOCUDESC") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Start Date" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle Width="100px" /> 
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"STDT") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Expiry Date" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle Width="100px" /> 
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"EXDT") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Renewal Authority" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"RENEWAUTU") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Renewal Authority Name" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"RENEWAL_AUTU_NAME") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Applicable State" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"APPLICABLE_STATE") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Document Cost" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DOCU_COST") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Scan Document" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                             <asp:HyperLink ID="hyperView" Text="view" runat="server" 
                                        Target="_blank"  NavigateUrl='<%# DataBinder.Eval(Container.DataItem,"SCANDOCUMENT","~/GUI/Fleet/Document/DownloadFile1.aspx?FileName={0}" ) %>' ToolTip='<%# Eval("SCANDOCUMENT") %>' ></asp:HyperLink>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                      <asp:TemplateField HeaderText="Expires in days" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Will_ExpiredInDays") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    
                                    
                                    <asp:TemplateField HeaderText="Fleet Centre" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"LOCATION") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    
                                    
                                    
                                    
                                </Columns>
                            </asp:GridView>   
                                      
                </ContentTemplate>
            </ajaxToolkit:TabPanel>
        
        
          <ajaxToolkit:TabPanel runat="server" ID="tabTripDetails" HeaderText="Tripsheet Details" >
                <ContentTemplate>
                          
                        <asp:GridView  EmptyDataRowStyle-CssClass="bgbluegrey" EmptyDataText="No Reocord Found" ID="gvTripsheet" BorderWidth="0" 
                                CellSpacing="1" CellPadding="5" 
                                runat="server" Width="100%" CssClass="boxbg" AutoGenerateColumns="false" 
                                HeaderStyle-CssClass="bgbluegrey"
                                FooterStyle-CssClass="bgwhite"
                                PagerSettings-Mode="NumericFirstLast" SelectedIndex="1">
                                <Columns>
                                     <asp:TemplateField HeaderText="Tripsheet Number" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true"  />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"VSlipNo") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Tripsheet Date" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"VSlipDt") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Manual Trip No." ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Manual_tripsheetno") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Driver Name 1" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle Width="100px" /> 
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Driver_Name1") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Driver Name 2" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle Width="100px" /> 
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Driver_Name2") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                     <asp:TemplateField HeaderText="Trip Start Location" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Tripsheet_startLocName") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Start KM Run" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle Width="100px" /> 
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"f_issue_startKM") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Trip Close Location" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Tripsheet_EndLocName") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="End KM Run" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"f_closure_CloseKM") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Diesel filled (in Ltrs)" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TotDiesel") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Actual KMPL" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Actual_KMPL") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                     <asp:TemplateField HeaderText="Approved KMPL" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Approved_KMPL") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Total Cost" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                         <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TotExpense") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                      <asp:TemplateField HeaderText="Advance Paid" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"AmtPaidToDriver") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Balance paid" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"AmtPaidToDriver") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                     <asp:TemplateField HeaderText="Trip Category" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle Width="100px" />  
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"category") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Trip Status" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Status") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>   
                                      
                </ContentTemplate>
            </ajaxToolkit:TabPanel>
            
          <ajaxToolkit:TabPanel runat="server" ID="tabFuelFillHistory" HeaderText="Fuel Fill History" >
                <ContentTemplate>
                          
                        <asp:GridView  EmptyDataText="No Reocord Found" ID="gvFuelFillHistory" BorderWidth="0" CellSpacing="1" CellPadding="5"
                                runat="server" Width="800px" CssClass="boxbg" AutoGenerateColumns="false" EmptyDataRowStyle-CssClass="bgbluegrey" 
                                HeaderStyle-CssClass="bgbluegrey"
                                FooterStyle-CssClass="bgwhite"
                                PagerSettings-Mode="NumericFirstLast" SelectedIndex="1">
                                <Columns>
                                     <asp:TemplateField HeaderText="Tripsheet Number" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true"  />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"VSlipNo") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Date of filling" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"BILLFROMDT") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Referece Document No." ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"BILLNO") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Fuel filled in Ltrs." ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle Width="100px" /> 
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DIESEL_LTR") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Diesel Rate" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle Width="100px" /> 
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Diesel_Rate") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                     <asp:TemplateField HeaderText="Fuel cost" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"EXE_AMT") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Odometer reading" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle Width="100px" /> 
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"KM_READING") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Payment method" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Card_Cash") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                  
                                </Columns>
                            </asp:GridView>   
                                      
                </ContentTemplate>
            </ajaxToolkit:TabPanel>
        
        
        
        
        <ajaxToolkit:TabPanel runat="server" ID="tabOdometerHistory" HeaderText="Odometer History" >
                <ContentTemplate>
                          
                        <asp:GridView EmptyDataRowStyle-CssClass="bgbluegrey"  EmptyDataText="No Reocord Found" ID="gvOdometerHistory" 
                                BorderWidth="0" CellSpacing="1" CellPadding="5" 
                                runat="server" Width="800px" CssClass="boxbg" AutoGenerateColumns="false" 
                                HeaderStyle-CssClass="bgbluegrey"
                                FooterStyle-CssClass="bgwhite"
                                PagerSettings-Mode="NumericFirstLast" SelectedIndex="1">
                                <Columns>
                                     <asp:TemplateField HeaderText="Odometer Reading date" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true"  />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Odometer_Reading_Dt") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    
                                    <asp:TemplateField HeaderText="Odometer reading" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Odometer_Reading") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Last Km Reading" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Last_Km_Reading") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Odometer change reason" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle Width="300px" />                                         
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Odometer_Reason") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                </Columns>
                            </asp:GridView>   
                                      
                </ContentTemplate>
            </ajaxToolkit:TabPanel>
        
                                    
        <ajaxToolkit:TabPanel runat="server" ID="tabTyreDetails" HeaderText="Tyre Details" >
                <ContentTemplate>
                          
                        <asp:GridView  EmptyDataText="No Reocord Found"  EmptyDataRowStyle-CssClass="bgbluegrey"  ID="gvTyreDetails" BorderWidth="0" CellSpacing="1"
                                runat="server" Width="100%" CssClass="boxbg" AutoGenerateColumns="false"  CellPadding="5" 
                                HeaderStyle-CssClass="bgbluegrey"
                                FooterStyle-CssClass="bgwhite"
                                PagerSettings-Mode="NumericFirstLast" SelectedIndex="1">
                                <Columns>
                                     <asp:TemplateField HeaderText="Tyre Number" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true"  />
                                        <ItemStyle Width="125px" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TYRE_NO") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    
                                    <asp:TemplateField HeaderText="Tyre Category" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TYRE_CATEGORY") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    <asp:TemplateField HeaderText="Manufacturer" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle Width="175px" />                                         
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"MFG") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Model" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle Width="100px" />                                         
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"MODEL") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Tyre Size" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle Width="200px" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TYRESIZE") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                     <asp:TemplateField HeaderText="Pattern" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"PATTERN") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Tyre Type" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle Width="100px" /> 
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TYRETYPE") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Purchase Date" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle Width="75px" />                                                                                
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TYRE_PURDT") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Purchase As" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle Width="150px" /> 
                                        
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"PURCHASED_AS") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                       <asp:TemplateField HeaderText="Purchase Km." ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TYRE_PUR_KMS") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                       <asp:TemplateField HeaderText="Purchase Cost" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TYRE_COST") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                       <asp:TemplateField HeaderText="Status" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TYRE_STATUS") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                     <asp:TemplateField HeaderText="Position Category" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"POS_CATEGORY") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Position Code" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TYREPOS_CODE") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Position" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle Width="100px" />                                         
                                        
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TYREPOS_DESC") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Total Km. Run" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TYRE_TOTKM_RUN") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Total Cost" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TOTALCOST") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Cost/km" ItemStyle-CssClass="bgwhite">
                                        <HeaderStyle CssClass="blackfnt" Font-Bold="true" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"COSTKM") %>' ></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    
                                    
                                </Columns>
                            </asp:GridView>   
                                      
                </ContentTemplate>
            </ajaxToolkit:TabPanel>
        
   
            
        </ajaxToolkit:TabContainer>
        
        </td>
    </tr>
    </table>
    </ContentTemplate>
    </asp:UpdatePanel>

               
</asp:Content>