<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="Driver.aspx.cs" Inherits="admin_Driver" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
 <link type="text/css" rel="stylesheet" href="../../../../GUI/cal/popcalendar.css">
<script type="text/javascript" language="javascript" src="../../../images/commonJs.js"></script>
 
<script type="text/javascript" language="javascript" src="../../../images/CalendarPopup.js"></script>

  <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>
      <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
    
    
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Driver Master</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
        </tr>
    </table>
 <table cellspacing="1" style="width: 100%">
     <tr align="left">
            <td>
                <table cellspacing="1" style="width: 70%">
                    <tr style="background-color: white">
                        <td align="left">
                            <asp:Label ID="lblNew" runat="server" CssClass="blackfnt" Font-Bold="true" Text="New ?? "></asp:Label>
                            <asp:LinkButton ID="lnkCreateDriver" runat="server" Text="Create Driver" CssClass="bluefnt" Font-Bold="true" PostBackUrl="~/GUI/Fleet/Webadmin/Driver/DriverDet.aspx"  ValidationGroup="VGCreate"></asp:LinkButton>    
                            
                        </td>
                        <td align="right">
                        <asp:LinkButton ID="lnkbtnXLS" runat="server" OnClick="lnkbtnXLS_Click" CssClass="bluefnt" Font-Bold="True">XLS</asp:LinkButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr align="left">
            <td>
                <table cellspacing="1" style="width: 800px" class="boxbg">
                    <tr class="bgbluegrey">
                        <td colspan="3" align="center">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="right">
                            <asp:Label ID="lblDateRange1" CssClass="blackfnt" runat="server" Font-Bold="true">
                                Driver Created in Date Range:
                            </asp:Label>
                        </td>
                        <td align="left">
                         <Date:DT ID="DT" EnableTillDate="true" runat="server" />
                         
                        </td>
                  
                    </tr>
                    
                     <tr style="background-color: white">
                        <td align="right" style="height: 27px">
                            <asp:Label ID="Label1" Text="Manual Driver code:" Font-Bold="true" CssClass="blackfnt"
                                runat="server" />
                        </td>
                        <td colspan="2" align="left" style="height: 27px">
                            <asp:TextBox ID="txtManualDriverCode" runat="server"  >
                             
                            </asp:TextBox>
                           
                          
                        </td>
                    </tr>
                    
                    <tr style="background-color: white">
                        <td align="right" style="height: 27px">
                            <asp:Label ID="lbldriverName" Text="Driver Name:" Font-Bold="true" CssClass="blackfnt"
                                runat="server" />
                        </td>
                        <td colspan="2" align="left" style="height: 27px">
                            <asp:TextBox ID="txtDriverName" runat="server"  >
                             
                            </asp:TextBox>
                           
                          
                        </td>
                    </tr>


  


                    <tr style="background-color: white">
                        <td colspan="3" align="right">
                            <asp:UpdatePanel ID="UPShowDriver" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btnShowDriver" runat="server" Text="Show Drivers(s) >>" ValidationGroup="VGDtFromTo" 
                                        OnClick="btnShowDriver_OnClick" />
                                    <asp:UpdateProgress runat="server" ID="Prog1">
                                        <ProgressTemplate>
                                            <asp:Image ID="imgWait" ImageUrl="~/GUI/images/indicator.gif" runat="server" BorderStyle="none" />
                                            <%--                                            <asp:Label ID="lblProgress" CssClass="blackfnt" Text="Wait.." runat="server" ForeColor="Red"></asp:Label>
--%>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                <%--    <asp:Button ID="btnPrint" runat="server" CssClass="blackfnt" OnClick="btnPrint_Click"
                                        Text="View / Print >>" />--%>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
       
    </table>
   <br />
   <p align="left">
   <table cellspacing="1" style="width: 100%">
        <tr align="left">
            <td align="left">
                <asp:UpdatePanel ID="u1" UpdateMode="Conditional" runat="server">
                    <ContentTemplate>
                   <%-- DataSourceID="ObjectDataSource1" EnableViewState="False"--%>
                        <asp:GridView ID="dgDriver" runat="server" BorderWidth="1px" CellSpacing="1" CellPadding="5" HeaderStyle-CssClass="dgHeaderStyle" 
                             AllowPaging="True" PageSize="50" PagerStyle-HorizontalAlign="left"               
                            PagerSettings-Mode="Numeric" AutoGenerateColumns="False"
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8BA0E5" OnPageIndexChanging="pgChange" OnRowCommand="dg_RowCommand" DataKeyNames="Driver_Id">
                            <Columns>
                                <asp:HyperLinkField DataTextFormatString="--Select--" DataTextField="Driver_Id" DataNavigateUrlFields="Driver_Id"
                                    DataNavigateUrlFormatString="~/GUI/Fleet/Webadmin/Driver//DriverDet.aspx?id={0}" >
                                    <ItemStyle CssClass="bluelink" ForeColor="Blue" />
                                </asp:HyperLinkField>
                                
                               <asp:BoundField DataField="Manual_Driver_Code" HeaderText="Manual Driver code" >
                                    <ItemStyle HorizontalAlign="Left" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                               <asp:BoundField DataField="Driver_Name" HeaderText="DriverName" >
                                    <ItemStyle HorizontalAlign="Left" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                               
                                <asp:BoundField DataField="License_No" HeaderText="Liscense No."> 
                                    <ItemStyle HorizontalAlign="Left" />    
                                      <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                

                                <asp:BoundField DataField="ValdityDt" HeaderText="Validity Date">
                                    <ItemStyle HorizontalAlign="Left" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:BoundField DataField="Issue_By_RTO" HeaderText="Issued By RTO">
                                    <ItemStyle HorizontalAlign="Left" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                           <%--  <asp:BoundField DataField="Driver_Status" HeaderText="Driver Status" >
                                    <ItemStyle HorizontalAlign="Right" />
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>    --%>                                             
                               <asp:BoundField DataField="ADDRESS_PRROF" HeaderText="Address Proof Document Type & No">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>     
                                 <asp:BoundField DataField="ID_PRROF" HeaderText="ID Proof Document Type & No">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>  
                                <asp:BoundField DataField="CreatedOn" HeaderText="Created On" >
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                             
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                        <%--<asp:ObjectDataSource ID="ObjectDataSource1" runat="server"
            SelectMethod="GetBrandData" TypeName="BrandBLL" >
            
        </asp:ObjectDataSource>--%>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnShowDriver" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
                </td>
        </tr>
    </table>
   </p>
 
 </asp:Content>
