<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="frmViewPrintVehicleIssueSlipQuery.aspx.cs" Inherits="Issue_frmViewPrintVehicleIssueSlipQuery" %>

<%@ Reference Control="~/LED/DateSelector.ascx" %>
<%@ Reference Control="~/LED/DateSelectorTo.ascx" %>
<%@Register TagPrefix="SControls" TagName="DateSelector" src="~/LED/DateSelector.ascx" %>
<%@Register TagPrefix="SControlsTo" TagName="DateSelectorTo" src="~/LED/DateSelectorTo.ascx" %> 

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_DateTillDateSelected.ascx" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

<script type="text/javascript" language="javascript" src="../../../../cal/popcalendar.js"></script>
<script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>
<script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>

 <script language="javascript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
cal.setCssPrefix("TEST");
cal.showNavigationDropdowns();

    function nwOpen1(mNo)
    {
        window.open("../../../../GUI/popups/Popup-Vehicle.aspx?mNo=" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
    }
    function nwOpen3(mNo)
    {
        window.open("../../../../GUI/popups/Popup-Driver1.aspx?mNo=" + mNo + "&id=D1","pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
    }
</script>
      <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>

 <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                 <ProgressTemplate>
        <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
            -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
            <tr>
                <td align="right">
                    <img src="../../../../gui/images/loading.gif" alt="" />
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
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">View/Print Trip Sheet >> Query</asp:Label>
             
            </td>
            
             <td align=right>
               
         
          </td>    
           
        </tr>
    </table>
<hr align="center" size="1" color="#8ba0e5">
 <br> 

 
 
 
 <table cellspacing="1" style="width: 100%">
            <tr align="left">
                <td>  
       <table cellspacing="1" cellpadding="2" style="width: 700px" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center">
                                <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" style="width: 25%">
                             <%--   <asp:Label ID="Label4" CssClass="blackfnt" runat="server" Font-Bold="True">Enter Trip Sheet No.:</asp:Label>--%>
                        
                                  <asp:DropDownList ID="ddlTripsheet" runat="server">
                                        <asp:ListItem Value="M" Text="Enter Manual TripSheet No.:" Selected="true"></asp:ListItem>
                                        <asp:ListItem Value="T" Text="Enter Trip Sheet No.:"></asp:ListItem>
                                   </asp:DropDownList>
                        
                        
                            </td>
                            <td align="left" style="width: 75%">
                                <asp:UpdatePanel ID="UpdatePanel4" RenderMode="Inline" UpdateMode="Always" runat="server">
                                    <ContentTemplate>
                                        <asp:TextBox CssClass="input" ID="txtVIssueID" runat="Server" ValidationGroup="VGRequestID" BorderStyle="Groove"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtVIssueID"
                                            ErrorMessage="*" ValidationGroup="VGRequestID" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        
                        
                        
                        <tr style="background-color: white">
                            <td colspan="2" align="right" style="width: 100%">
                                <asp:UpdatePanel ID="UpdatePanel5" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btnShowSingleRequest" runat="server" Text="Submit" ValidationGroup="VGRequestID" OnClick="btnShowSingleRequest_Click" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center" colspan="2">
                                <asp:Label ID="Label5" CssClass="blackfnt" runat="server" Font-Bold="true">
                                OR
                                </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left"  width="400px"  valign=top style="width: 20%; height: 89px;">
                                <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True">Trip Sheet Date Range:</asp:Label>
                            </td>
                            <td align="left"  width="200px" style="width: 40%; height: 89px;">
                                <Date:DT ID="DT" EnableTillDate="true" runat="server" />
                            </td>
                        </tr>
           <tr style="background-color: white">
               <td align="left" style="width: 20%">
                   <asp:Label ID="Label8" runat="server" CssClass="blackfnt" Font-Bold="true">
                                        Select Branch   

                                    </asp:Label></td>
               <td align="left" style="width: 80%">
               <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Always" RenderMode="Inline" runat="server">
                   <ContentTemplate>
                   <asp:DropDownList ID="ddlro" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlro_SelectedIndexChanged">
                   </asp:DropDownList>
                   </ContentTemplate>
               </asp:UpdatePanel>
               </td>
           </tr>
                    
                    <tr style="background-color: white">
                            <td align="left" style="width: 20%; height: 26px;">
                                <asp:Label ID="Label1" CssClass="blackfnt" runat="server" Font-Bold="True">Select Trip Sheet Status:</asp:Label>
                            </td>
                            <td align="left" style="width: 80%; height: 26px;">
                               <asp:DropDownList ID="cboIssueSlipStatus" runat=server>
                                <asp:ListItem Value="B" Text="Both"></asp:ListItem>
                                <asp:ListItem Value="P" Text="Pending"></asp:ListItem>
                                <asp:ListItem Value="C" Text="Completed"></asp:ListItem>
                               </asp:DropDownList>
                          </td>
                        </tr>                        
           <tr style="background-color: white">
               <td align="left" style="width: 20%">
                   <asp:Label ID="Label4" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Driverwise"></asp:Label></td>
               <td align="left" style="width: 80%">
                   <asp:TextBox ID="txtDriver1" runat="server"  CssClass="input" ></asp:TextBox>
                   <asp:Label ID="Label9" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen3(1)">...</a>'
                       Width="14px"></asp:Label></td>
           </tr>
           <tr style="background-color: white">
               <td align="left" style="width: 20%">
                   <asp:Label ID="lblVehWise" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Vehiclewise"></asp:Label></td>
               <td align="left"  style="width: 80%">
                   <asp:TextBox ID="txtVehNo" runat="server" CssClass="input"></asp:TextBox><asp:Label
                       ID="Label10" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen1(1)">...</a>'
                       Width="14px"></asp:Label></td>
           </tr>
                 
                 


                        
                        <tr style="background-color: white">
                            <td colspan="2" align="right">
                                <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btnShowMultipleRequest" runat="server" Text="Submit"  ValidationGroup="VGDtFromTo" OnClick="btnShowMultipleRequest_Click" /> 
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        
                    </table>
                          </td>
            </tr>
        </table>      
       
       

<br />
 <table cellspacing="1" style="width: 85%" align="left">
        <tr align="left">
            <td align="right">
                <asp:UpdatePanel ID="u1" UpdateMode="Always" runat="server">
                    <ContentTemplate>
                        <asp:datagrid id="DataGrid1" runat="server" PageSize="1000"  AutoGenerateColumns="False" CellPadding="2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="1" Width="100%" Height="1px" ItemStyle-HorizontalAlign=Left  ><%--OnItemDataBound="DataGrid1_ItemDataBound"--%>
                                <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                                <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
		                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                                <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                                <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"/>
                                <Columns >
                                
                                
                                    <asp:BoundColumn DataField="Manual_TripsheetNo" HeaderText="Manual Trip Sheet No">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                
                                
                                <asp:BoundColumn DataField="VSlipNo" HeaderText="Trip Sheet No">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                 <asp:BoundColumn DataField="VSlipDt" HeaderText="Trip Sheet Start date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>

                                 <asp:BoundColumn DataField="End_dt_tm" HeaderText="Trip Sheet Close date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                
                                
                                <asp:BoundColumn DataField="VehicleNo" HeaderText="Vehicle No.">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                <asp:BoundColumn DataField="DriverName" HeaderText="Driver">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                <asp:BoundColumn DataField="IssueStatus" HeaderText="Status">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                 <%--<asp:BoundColumn DataField="Billed_Yn" HeaderText="Tripsheet Billed/Not Billed">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                 <asp:BoundColumn DataField="BillNo" HeaderText="Bill No.">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>--%>
                                    <asp:BoundColumn DataField="EXTERNALTHCCOUNT" HeaderText="Total No. of THC Attached">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                   <asp:HyperLinkColumn DataNavigateUrlField="VSlipNo" Target=_blank  DataNavigateUrlFormatString="frmViewPrintVehicleIssueSlip.aspx?VSlipNo={0}&PrintMode=0" Text="View" HeaderText="View" HeaderStyle-HorizontalAlign=Left>
                                           <ItemStyle CssClass="bluefnt" />
                                           <HeaderStyle Width="50px" />
                                     </asp:HyperLinkColumn>
                                <asp:HyperLinkColumn Target=_blank DataNavigateUrlField="VSlipNo" DataNavigateUrlFormatString="frmViewPrintVehicleIssueSlip.aspx?VSlipNo={0}&PrintMode=1" Text="Print" HeaderText="Print" HeaderStyle-HorizontalAlign=Left>
                                           <ItemStyle CssClass="bluefnt" />
                                           <HeaderStyle Width="50px" />
                                       </asp:HyperLinkColumn> 

                                    <asp:HyperLinkColumn DataNavigateUrlField="VSlipNo" Target=_blank  DataNavigateUrlFormatString="./New_TripSheet_Validation/TripsheetViewPrint.aspx?VSlipNo={0}&PrintMode=0" Text="View" HeaderText="Fuel Accounting View" HeaderStyle-HorizontalAlign=Left>
                                           <ItemStyle CssClass="bluefnt" />
                                           <HeaderStyle Width="50px" />
                                     </asp:HyperLinkColumn>
                                <asp:HyperLinkColumn Target=_blank DataNavigateUrlField="VSlipNo" DataNavigateUrlFormatString="./New_TripSheet_Validation/TripsheetViewPrint.aspx?VSlipNo={0}&PrintMode=1" Text="Print" HeaderText="Fuel Accounting Print" HeaderStyle-HorizontalAlign=Left>
                                           <ItemStyle CssClass="bluefnt" />
                                           <HeaderStyle Width="50px" />
                                       </asp:HyperLinkColumn> 

	                            </Columns>
	                        </asp:datagrid>
                     
                     </ContentTemplate>
                </asp:UpdatePanel>
                    
              </td>
         </tr>
    </table>    





</asp:Content> 