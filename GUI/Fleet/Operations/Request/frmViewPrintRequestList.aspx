<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="frmViewPrintRequestList.aspx.cs" Inherits="Request_frmViewPrintRequestList" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Vehicle Requests >> View & Print >> List</asp:Label>
          
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
      
      
      
      <table border="0" cellpadding="0" cellspacing="0" class="boxbg" width="100%">
            <tr bgcolor="white">
                <td style="height:19px">
                     <asp:datagrid id="DataGrid1" runat="server" PageSize="1000"  AutoGenerateColumns="False" CellPadding="2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="2" Width="100%" Height="1px" OnItemDataBound="DataGrid1_ItemDataBound" >
                        <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                        <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
		                            <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                        <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                        <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                        <Columns>
	                     
	                      
	                      <asp:BoundColumn DataField="Request_Id" HeaderText="Req.ID">
                                            <HeaderStyle Width="90px" />
                                        </asp:BoundColumn>
	                      
	                       <asp:BoundColumn DataField="Request_By" HeaderText="Req. By">
                                            <HeaderStyle Width="150px" />
                                        </asp:BoundColumn>
	                      
	                      <asp:BoundColumn DataField="Request_Dt" HeaderText="Req. Date">
                                            <HeaderStyle Width="90px" />
                                        </asp:BoundColumn>
	                      
	                      
	                        <asp:BoundColumn DataField="Orgn_City" HeaderText="Orign City">
                                            <HeaderStyle Width="90px" />
                                        </asp:BoundColumn>
	                      
	                        <asp:BoundColumn DataField="Destn_City" HeaderText="Destn. City">
                                            <HeaderStyle Width="90px" />
                                        </asp:BoundColumn>
	                      
	                       <asp:BoundColumn DataField="Start_date_time" HeaderText="Start date">
                                            <HeaderStyle Width="90px" />
                                        </asp:BoundColumn>
	                      
	                      <asp:BoundColumn DataField="End_dt_tm" HeaderText="End date">
                                            <HeaderStyle Width="90px" />
                                        </asp:BoundColumn>
	                      
	                       
	                      <%--<asp:BoundColumn DataField="No_Passenger" HeaderText="Passengers">
                                            <HeaderStyle Width="50px" />
                                        </asp:BoundColumn>--%>
	                      
	                      <asp:BoundColumn DataField="Vehtype" HeaderText="Vehicle Type">
                                            <HeaderStyle Width="120px" />
                                        </asp:BoundColumn>
	                      
	                      
	                       <asp:BoundColumn DataField="RequestStatus" HeaderText="Status">
                                            <HeaderStyle Width="90px" />
                                        </asp:BoundColumn>
	                      
	                      <asp:HyperLinkColumn DataNavigateUrlField="Request_Id" Target=_blank  DataNavigateUrlFormatString="frmRequestPrint.aspx?id={0}&PrintMode=0" Text="View" HeaderText="View">
                                           <ItemStyle CssClass="bluefnt" />
                                           <HeaderStyle Width="50px" />
                                       </asp:HyperLinkColumn>
                                       
                            <asp:HyperLinkColumn Target=_blank DataNavigateUrlField="Request_Id" DataNavigateUrlFormatString="frmRequestPrint.aspx?id={0}&PrintMode=1" Text="Print" HeaderText="Print">
                                           <ItemStyle CssClass="bluefnt" />
                                           <HeaderStyle Width="50px" />
                                       </asp:HyperLinkColumn>                                       
	             
	                    </Columns>
	                </asp:datagrid>&nbsp;
	                <asp:Label ID="lblError" runat=server ForeColor=red CssClass="blackfnt"></asp:Label>
		       </td>
            </tr>
        </table>
                  
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Export To Excel" /><br />


</asp:Content> 
