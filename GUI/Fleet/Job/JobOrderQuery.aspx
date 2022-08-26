<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="JobOrderQuery.aspx.cs" Inherits="Job_JobOrderQuery" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

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

 <script language="javascript">
 
    function ViewPrint(mOrderNo,tPrintMode)
    {
        var strurl="ViewPrintPrepareJob.aspx?ONo=" + mOrderNo + "&PrintMode=" + tPrintMode  
        popup = window.open(strurl,"pbr","menubar=no,toolbar=no,resizable=yes,scrollbars=yes");
    }


</script>


    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">View/Print Job Order >> Query</asp:Label>
             
            </td>
            
             <td align=right>
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

 
 
<%-- 
 <table cellspacing="1" style="width: 100%">
            <tr align="center">
                <td>  --%>
                
                <div align="left">
       <table cellspacing="1" width="800px"  class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center" style="height: 21px;width:30%">
                                <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" Text="Search Criteria" runat="server"></asp:Label>
                            </td>
                        </tr>
                         <tr bgcolor="white">
                         <td width="30%">
                                  <asp:Label ID="Label4" CssClass="blackfnt" runat="server"  Text="Enter Job Order No.:" Font-Bold="True"></asp:Label>
                            </td>
                            <td width="70%">
                                <asp:TextBox CssClass="input" ID="txtVIssueID" runat="Server" ValidationGroup="VGRequestID" BorderStyle="Groove" ></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtVIssueID"
                                ErrorMessage="*" ValidationGroup="VGRequestID" />
                            </td>
                            
                             
                        </tr>
                        
                                       <tr align="center" bgcolor="white">
                            <td colspan="2">
                                 <asp:UpdatePanel ID="UpdatePanel5" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btnShowSingleRequest" runat="server" Text="Submit" ValidationGroup="VGRequestID" OnClick="btnShowMultipleRequest_Click"/>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="center" colspan="2">
                                <asp:Label ID="Label2" CssClass="blackfnt" runat="server" Text="OR" Font-Bold="true"></asp:Label>
                            </td>
                        </tr>
                        
                      
                        
                        
                        <tr bgcolor="white">
                            <td width="30%">
                                <asp:Label ID="Label6" CssClass="blackfnt" runat="server" Font-Bold="True" Text="Job Order Date Range:"></asp:Label>
                            </td>
                            <td  width="70%">
                                <Date:DT ID="DT" EnableTillDate="true" runat="server" />
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td width="30%">
                            <asp:Label ID="Label1" CssClass="blackfnt" Text="Select Job Order Status:"  runat="server" Font-Bold="True"></asp:Label>
                            </td>
                            <td  width="70%">
                             <asp:DropDownList ID="cboIssueSlipStatus" runat=server>
                                    <asp:ListItem Value="B" Text="Both"></asp:ListItem>
                                    <asp:ListItem Value="P" Text="Open"></asp:ListItem>
                                    <asp:ListItem Value="C" Text="Closed"></asp:ListItem>
                               </asp:DropDownList>
                            </td>
                        </tr>
                        
                        
                        
                       
                          
                        <tr align="center" bgcolor="white">
                            <td colspan="2">
                                <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btnShowMultipleRequest" runat="server" Text="Submit"  ValidationGroup="VGDtFromTo" OnClick="btnShowMultipleRequest_Click" /> 
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                         <tr align="center" bgcolor="white">
                            <td colspan="2">
                                 <asp:UpdatePanel ID="u1" UpdateMode="Conditional" runat="server">
                    <ContentTemplate>
                     
                     
                     <asp:DataGrid ID="DataGrid1" runat="server" PageSize="1000"  AutoGenerateColumns="False" CellPadding="2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="1" Width="100%" Height="1px" ItemStyle-HorizontalAlign=Left  ><%--OnItemDataBound="DataGrid1_ItemDataBound"--%>
                                <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                                <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
		                                    <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                                <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                                <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False"/>
                                <Columns >
                                
                                <asp:BoundColumn DataField="JOB_ORDER_NO" HeaderText="Job Order No">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                 <asp:BoundColumn DataField="JOB_ORDER_DT" HeaderText="Job Order date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>

                                 <asp:BoundColumn DataField="JOB_ORDER_CLOSEDT" HeaderText="Job Order Close date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                
                                
                                <asp:BoundColumn DataField="VEHNO" HeaderText="Vehicle No.">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                <asp:BoundColumn DataField="ORDER_TYPE" HeaderText="Job Card Type">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                <asp:BoundColumn DataField="SERVICE_CENTER_TYPE" HeaderText="Service Type">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                
                                 <asp:BoundColumn DataField="ORDER_STATUS" HeaderText="Job Order Status">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                <%--ViewPrintPrepareJob--%>
                            <asp:HyperLinkColumn DataNavigateUrlField="JOB_ORDER_NO" Target=_blank  DataNavigateUrlFormatString="JobOrderView.aspx?ONo={0}&PrintMode=0" Text="View" HeaderText="View" HeaderStyle-HorizontalAlign=Left>
                             <ItemStyle CssClass="bluefnt" />
                            <HeaderStyle Width="50px" />
                            </asp:HyperLinkColumn>

                            <asp:HyperLinkColumn Target=_blank DataNavigateUrlField="JOB_ORDER_NO" DataNavigateUrlFormatString="JobOrderView.aspx?ONo={0}&PrintMode=1" Text="Print" HeaderText="Print" HeaderStyle-HorizontalAlign=Left>
                                <ItemStyle CssClass="bluefnt" />
                                <HeaderStyle Width="50px" />
                            </asp:HyperLinkColumn>   

	                            </Columns>
	                        </asp:datagrid>
                     
                     </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnShowMultipleRequest" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnShowSingleRequest" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
                            </td>
                        </tr>
                        
                    </table>
    </div>
   


</asp:Content> 
