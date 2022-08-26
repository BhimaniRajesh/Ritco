<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="TyreCostReport.aspx.cs" Inherits="Reports_TyreCostReport" %>

  <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
    <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Tyre Cost Per Km > Query</asp:Label>
              <%--  <hr align="center" size="1" color="#8ba0e5"> --%>
            </td> 
            
             <td align="right">
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/images/indicator.gif" />
                    <font class="blackfnt" color="red"><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  
         
          </td>      
        </tr>
    </table>
    
    <hr align="center" size="1" color="#8ba0e5">
      <br> 
      <table cellspacing="1" style="width: 100%">
            <tr align="center">
                <td>  
       <table cellspacing="1" cellpadding="2" style="width: 70%" class="boxbg">
                        <tr class="bgbluegrey" >
                            <td colspan="3" align="center">
                                <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                            </td>
                        </tr>
                                                                                       
                                          
                 
                         <tr style="background-color: white" align="center">
                            
                            
                             <td align="left" colspan="1">
                                 <asp:Label ID="lblTyreType" runat="server" Text="Tyre Type"  CssClass="blackfnt"  Font-Bold="True"></asp:Label>
                              
                                </td>
                            <td align="left" colspan="2">
                                &nbsp;<asp:DropDownList ID="ddlTyreType" runat="server">
                                    
                             </asp:DropDownList>
                                </td>
                             
                        </tr>
                        	          <tr style="background-color: white" align="center">
                            
                            
                             <td align="left" colspan="1">
                                 <asp:Label ID="Label1" runat="server" Text="Manufacturer"  CssClass="blackfnt"  Font-Bold="True"></asp:Label>
                              
                                </td>
                            <td align="left" colspan="2">
                                &nbsp;<asp:DropDownList ID="ddlMFG" runat="server">
                                  
                             </asp:DropDownList>
                                </td>
                             
                        </tr>
                               <tr style="background-color: white" align="center">
                            
                            
                             <td align="left" colspan="1">
                                 <asp:Label ID="Label2" runat="server" Text="Tyre Size"  CssClass="blackfnt"  Font-Bold="True"></asp:Label>
                              
                                </td>
                            <td align="left" colspan="2">
                                &nbsp;<asp:DropDownList ID="ddlSize" runat="server">
                                  
                             </asp:DropDownList>
                                </td>
                             
                        </tr>
                             <%--  <tr style="background-color: white" align="center">
                            
                            
                             <td align="left" colspan="1">
                                 <asp:Label ID="Label4" runat="server" Text="Warranty Expires within next"  CssClass="blackfnt"  Font-Bold="True"></asp:Label>
                              
                                </td>
                            <td align="left" colspan="2">
                                &nbsp;<asp:TextBox ID="txtExpiry" runat="server" CssClass="input">
                                
                             </asp:TextBox>
                                </td>
                             
                        </tr>--%>
                        
                        
                                    <tr style="background-color: white" align="center">
                            
                            
                             <td align="left" colspan="1">
                                 <asp:Label ID="Label9" runat="server" Text="Select Vendor"  CssClass="blackfnt"  Font-Bold="True"></asp:Label>
                              
                                </td>
                            <td align="left" colspan="2">
                                &nbsp;<asp:DropDownList ID="ddlVendor" runat="server" CssClass="input">
                                
                             </asp:DropDownList>
                                </td>
                             
                        </tr>
                        
                        
                        
                        
                        
                        <%--
                                                       <tr style="background-color: white" align="center">
                            
                            
                             <td align="left" colspan="1">
                                 <asp:Label ID="Label5" runat="server" Text="Select Tyre No."  CssClass="blackfnt"  Font-Bold="True"></asp:Label>
                              
                                </td>
                            <td align="left" colspan="2">
                                &nbsp;<asp:DropDownList ID="ddlTyreNo" runat="server" CssClass="input">
                                
                             </asp:DropDownList>
                                </td>
                             
                        </tr>--%>
                        
                   
                                                           <tr class="bgbluegrey"  align="center">
                            
                            
                             <td align="center" colspan="3">
                                 <asp:Label ID="Label6" runat="server" Text="OR"  CssClass="blackfnt"  Font-Bold="True"></asp:Label>
                              
                                </td>
                          
                             
                        </tr>
                   
                        <tr style="background-color: white" align="center">
                                                <td align="left" colspan="1">
                                 <asp:Label ID="Label7" runat="server" Text="Enter Tyre No."  CssClass="blackfnt"  Font-Bold="True"></asp:Label>
                              
                                </td>
                            <td align="left" colspan="2">
                                &nbsp;<asp:TextBox ID="txtTyreNo" runat="server" CssClass="input">
                                
                             </asp:TextBox>
                                </td>
                             
                        </tr>
                   
                                                          <tr class="bgbluegrey"  align="center">
                            
                            
                             <td align="center" colspan="3">
                                 <asp:Label ID="Label8" runat="server" Text="Select Document Type"  CssClass="blackfnt"  Font-Bold="True"></asp:Label>
                              
                                </td>
                          
                             
                        </tr>




           <tr style="background-color: white" align="center">
                                                <td align="left" colspan="1">
                                
                               <asp:RadioButton ID="rbMFG" Text="Manufacturer-wise"  GroupName="A"   Font-Bold="true" CssClass="blackfnt" runat="server" />
                                </td>
                            <td align="left" colspan="1">
                             
                                <asp:RadioButton ID="rbType"  Text="Tire Type-wise"  GroupName="A"  Font-Bold="true" CssClass="blackfnt"  runat="server" />
                         
                                </td>
                               
                            <td align="left" colspan="1">
                             
                                 <asp:RadioButton ID="rbSize"  Text="Size wise"  GroupName="A"  Font-Bold="true" CssClass="blackfnt" runat="server" />
                             
                                </td>
                               
                         
                             
                        </tr>





                        
                        <tr style="background-color: white">
                            <td colspan="3" align="right">
                                <asp:UpdatePanel ID="UpdatePanel8" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btnShow" runat="server" Text="Submit"  OnClick="btnShow_Click" /> 
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        
                    </table>
                          </td>
            </tr>
        </table>

<br />
 <table cellspacing="1" style="width: 100%">
        <tr align="center">
            <td align="center">
                &nbsp;<asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:GridView ID="GridView1" runat="server" AllowPaging="True"  
                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                            PageSize="50"  OnPageIndexChanging="pgChange" >
                            <Columns>
                            <asp:BoundField   DataField="TYRE_NO" HeaderText="Tyre No"   />
                             <asp:BoundField DataField="TYPE_NAME" HeaderText="Tyre Type">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField> 
                                  <asp:BoundField DataField="MFG_NAME" HeaderText="Manufacturer">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="SIZE_NAME" HeaderText="Size">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Loc_Veh" HeaderText="Location/VehicleNo">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="TYRE_STATUS" HeaderText="Status">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="TYRE_TOTKM_RUN" HeaderText="Total Kms">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Total_Cost" HeaderText="Total Cost"  />
                                <asp:BoundField DataField="Cost" HeaderText="Cost/Km"   />

   
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
              
            </td>
        </tr>
    </table>
 <%--<P align="center">
  <table >
  <tr style="background-color: white">
  <td align="center" style="height: 21px">
    <asp:LinkButton ID="LinkButton1"  Visible="false" Font-Bold="true" runat="server" OnClick="LinkButton1_Click">Transform To XLS</asp:LinkButton>
  </td>
      
  </tr>
  </table>
  </p> --%>
  </ContentTemplate>
                    <Triggers>
                        <atlas:ControlEventTrigger ControlID="btnShow" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
</asp:Content> 