<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewPrintPrepareJob.aspx.cs" Inherits="GUI_Fleet_Job_ViewPrintPrepareJob" %>


<head id="Head1" runat="server">
    <title>JOB</title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
    
  
 <script language="javascript">
     function printme()
     {
     <%
    string PrintMode =Request.QueryString["PrintMode"].Trim();
   %>  
   var mPrintMode="<%=PrintMode%>"
   
  
   
   
       if(mPrintMode=="1")
       {
           window.print();
        }                      
      }
    
    
 

    
    </script>
</head>

<html>

<br/>

<body >
    <form id="form1" runat="server">
    <div>
    
    
    
    
     
     
       <table  align="center" width="95%" border=0>
    
                               <tr style="background-color:White">
                        <td >
     
      <p align="center">
     
    <table  align="center" width="100%"  cellspacing="2" cellpadding="3"  border="1">
    
       
       
       
                           
                               <tr >
                        <td colspan="4" align="center">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Job Order</asp:Label>
                        </td>
                    </tr>
                           
                                          
                        <tr style="background-color: white">
               
                <td align="left" >
                    <asp:Label ID="Label4" runat="server" CssClass="blackfnt"   Text="Vehicle No."></asp:Label>
                                         
                </td>
                <td align="left" >&nbsp;
                <asp:Label ID="lblVehicleNo" runat="server" CssClass="blackfnt"    ></asp:Label>
 
            
                    
                </td>
            
                                                       
                             <td align="left" >
                                 <asp:Label ID="Label1" runat="server" Text="Vehicle Category" CssClass="blackfnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td  align="left">
                                &nbsp;<asp:Label ID="lblCategory" runat="server" CssClass="blackfnt">
                                 
                             </asp:Label>
                                </td>
                             
                        </tr>
                        
                        
                          <tr style="background-color: white" align="center">
                                                      
                             <td align="left"  >
                                 <asp:Label ID="Label2" runat="server" Text="Manufacturer" CssClass="blackfnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:Label ID="lblMfg" runat="server" CssClass="blackfnt">
                                 
                             </asp:Label>
                                </td>
                             
                       
                                      <td align="left" >
                                 <asp:Label ID="Label3" runat="server" Text="Model" CssClass="blackfnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:Label ID="lblModel" runat="server" CssClass="blackfnt">
                                 
                             </asp:Label>
                                </td>
                             
                        </tr>
                        
                        
                        
                        <tr style="background-color: white" align="center">
                                                    
                             <td align="left"  >
                                 <asp:Label ID="Label5" runat="server" Text="Job Order No" CssClass="blackfnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                           &nbsp;<asp:Label ID="lblOrderNo" runat="server" CssClass="blackfnt" ></asp:Label>
                                 
                             
                                </td>
                                                   
                                      <td align="left" >
                                 <asp:Label ID="Label7" runat="server" Text="Job Order Date" CssClass="blackfnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:Label ID="lblDate" runat="server" CssClass="blackfnt">
                                 
                             </asp:Label>
                                </td>
                             
                        </tr>
                        
                          <tr style="background-color: white" align="center">
                                                    
                             <td align="left"  >
                                 <asp:Label ID="Label9" runat="server" Text="Job Card Type" CssClass="blackfnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                
                                   &nbsp;<asp:Label ID="lblOrderType" runat="server"   CssClass="blackfnt"  ></asp:Label>
 
                                </td>
                                                   
                                      <td align="left" >
                                 <asp:Label ID="Label11" runat="server" Text="Order Status" CssClass="blackfnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                                &nbsp;<asp:Label ID="lblOrderStatus" runat="server" CssClass="blackfnt">
                                 
                             </asp:Label>
                                </td>
                             
                        </tr>
                        
                        
                          <tr style="background-color: white" align="center">
                                                    
                             <td align="left"  >
                                 <asp:Label ID="Label13" runat="server" Text="Service Centre Type " CssClass="blackfnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
 
                               &nbsp;<asp:Label ID="lblSCType" runat="server"   CssClass="blackfnt"  ></asp:Label>    
                            
                                </td>
                                                   
                                      <td align="left" >
                                 <asp:Label ID="lblVendor" runat="server" Text="Vendor Name" CssClass="blackfnt" Visible="false"  ></asp:Label>
                              
                                <asp:Label ID="lblWLoc" runat="server" Text="Workshop Location" CssClass="blackfnt" Visible="false"  ></asp:Label>
                                </td>
                            <td align="left" >
                               
                            &nbsp;<asp:Label ID="lblBoth" runat="server"   CssClass="blackfnt"  ></asp:Label>
                                                              
                                                              
                                </td>
                             
                        </tr>
                        
                        
                        <tr style="background-color: white" align="center">
                                                    
                             <td align="left"  >
                                 <asp:Label ID="Label6" runat="server" Text="Send date to WorkShop " CssClass="blackfnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" >
                            &nbsp;<asp:Label ID="LblSendDt" runat="server"  CssClass="blackfnt" ></asp:Label>
                                
                            </td>
                            
                             <td align="left"  >
                                 <asp:Label ID="Label14" runat="server" Text="Estimated return date " CssClass="blackfnt"  ></asp:Label>
                                </td>
                            <td align="left" >&nbsp;
                             <asp:Label ID="LblReturnDt" runat="server"  CssClass="blackfnt" ></asp:Label>
  
                            </td>
                        </tr>
                        
                        
                        <tr style="background-color: white" align="center">
                                                    
                             <td align="left"  >
                                 <asp:Label ID="Label15" runat="server" Text="Actual Date of return " CssClass="blackfnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="left" colspan=3>
                          &nbsp;<asp:Label ID="LblActReturnDt" runat="server"  CssClass="blackfnt" ></asp:Label>
                            </td>
                            
                           
                        </tr>
                        
                        
                        <tr style="background-color: white" align="center">
                                                    
                             <td align="left" >
                                 <asp:Label ID="Label18" runat="server" Text="Start KM Reading"       CssClass="blackfnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="right" >
                                &nbsp;<asp:Label ID="lblKMReading" runat="server"      CssClass="blackfnt">
                             </asp:Label>
                                </td>
                                  <td align="left" >
                                 <asp:Label ID="Label10" runat="server" Text="Close KM Reading"       CssClass="blackfnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="right" >
                                &nbsp;<asp:Label ID="LblCloseKM" runat="server"      CssClass="blackfnt">
                             </asp:Label>
                                </td>
                                
                                
                       </tr>
                       
                        <tr style="background-color: white" align="center">
                                                    
                             <td align="left"  >
                                 <asp:Label ID="Label20" runat="server" Text="Total Estimated Labour Hrs"  CssClass="blackfnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="right" >
                                &nbsp;<asp:Label ID="lblEstHrs" runat="server"  CssClass="blackfnt" >
                                                              </asp:Label>
                                                              
                                                             
                                                              
                                                              
                                </td>
                                                   
                                      <td align="left" >
                                 <asp:Label ID="Label22" runat="server" Text="Total Estimated Labour Cost"  CssClass="blackfnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="right" >  
                                &nbsp;<asp:Label ID="lblEstCost" runat="server" CssClass="blackfnt"     >
                                 
                             </asp:Label>
                             
                               
                                                              
                             
                                </td>
                             
                        </tr>
                        
                        
                        
                        
                        
                        
                        <tr style="background-color: white" align="center">
                                                    
                             <td align="left"  >
                                 <asp:Label ID="Label8" runat="server" Text="Total Actual Labour Hrs"  CssClass="blackfnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="right" >
                                &nbsp;<asp:Label ID="LblActLabourHrs" runat="server"  CssClass="blackfnt" >
                                                              </asp:Label>
                                </td>
                                                   
                                      <td align="left" >
                                 <asp:Label ID="Label12" runat="server" Text="Total Actual Labour Cost"  CssClass="blackfnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="right" >  
                                &nbsp;<asp:Label ID="LblActLabourCost" runat="server" CssClass="blackfnt"     >
                                 
                             </asp:Label>
                             
                                </td>
                             
                        </tr>
                        
                        
                        
                        <tr style="background-color: white" align="center">
                                                    
                             <td align="left"  >
                                 <asp:Label ID="Label16" runat="server" Text="Total Actual Part Cost"  CssClass="blackfnt"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="right" >
                                &nbsp;<asp:Label ID="LblTotActPartCost" runat="server"  CssClass="blackfnt" >
                                                              </asp:Label>
                                </td>
                                                   
                                      <td align="left" >
                                 <asp:Label ID="Label19" runat="server" Text="Total Job Cost"  CssClass="blackfnt" Font-Bold="true"  ></asp:Label>
                              &nbsp;
                                </td>
                            <td align="right" >  
                                &nbsp;<asp:Label ID="LblJobCost" runat="server" CssClass="blackfnt"  Font-Bold="true"    >
                                 
                             </asp:Label>
                             
                                </td>
                             
                        </tr>
                             
                     
              </table>
                     </p>
                     <br/>
                 
 <p align="center">   
      <table cellspacing="2"  width="100%" align="center" border=0>
       <tr ><td align=center><font class="blackfnt" ><b>Task Details</b></font></td></tr>
        <tr align="center">
            <td align="center">
 
                        <asp:GridView ID="DataGrid1" runat="server"    
                            AutoGenerateColumns="False" BorderColor="Black" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" 
                            HeaderStyle-CssClass="dgHeaderStyle"  PagerStyle-HorizontalAlign="left" 
                             >
                      
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" BackColor="White" />
                            <Columns>

                                <asp:BoundField HeaderText="Work Group" DataField="WorkGroup"  >
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Task Description" DataField="taskdesc">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Task Type" DataField="TaskType">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                              
                              <%--  <asp:BoundField HeaderText="Action Taken"  DataField="TASK_ACTIONDESC">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Completion Date(dd/mm/yyyy)"  DataField="Task_Copmletion_dt1">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>--%>
                                <asp:BoundField HeaderText="Est. Labour Hours"  DataField="W_EST_LABOUR_HRS">
                                    <ItemStyle HorizontalAlign="Right" />
                                    <HeaderStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Est. Labour Costs"  DataField="W_EST_LABOUR_COST">
                                    <ItemStyle HorizontalAlign="Right" />
                                    <HeaderStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                              <asp:BoundField HeaderText="Act. Labour Hours"  DataField="W_ACT_LABOUR_HRS">
                                     <ItemStyle HorizontalAlign="Right" />
                                     <HeaderStyle HorizontalAlign="Right" />
                                 </asp:BoundField>
                                <asp:BoundField HeaderText="Act. Labour Costs"  DataField="W_ACT_LABOUR_COST">
                                    <ItemStyle HorizontalAlign="Right" />
                                    <HeaderStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                
                                  <asp:BoundField HeaderText="Remark" DataField="T_Remarks">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
       
       
       
       
       </td>
       </tr>
</table>       
       </p>





<p align="center">   
      <table cellspacing="2"  width="100%" align="center" border=0>
       <tr ><td align=center><font class="blackfnt" ><b>Spare Part Details</b></font></td></tr>
        <tr align="center">
            <td align="center">
 
                        <asp:GridView ID="DataGrid2" runat="server"    
                            AutoGenerateColumns="False" BorderColor="Black" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" 
                            HeaderStyle-CssClass="dgHeaderStyle"  PagerStyle-HorizontalAlign="left" 
                             width="100%">
                      
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle HorizontalAlign="Left" BackColor="White"/>
                            <Columns>
                            
                                <asp:BoundField HeaderText="Work Group" DataField="W_GRPDESC"  >
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Part Name" DataField="PART_DESC">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Quantity" DataField="PART_QTY">
                                    <ItemStyle HorizontalAlign="Right" />
                                    <HeaderStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Rate/Unit" DataField="COST_UNIT" >
                                    <ItemStyle HorizontalAlign="Right" />
                                    <HeaderStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Cost"  DataField="COST">
                                    <ItemStyle HorizontalAlign="Right" />
                                    <HeaderStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                                <asp:BoundField HeaderText="Remark"  DataField="S_Remarks"/>
                            </Columns>
                        </asp:GridView>
       
       </td>
       </tr>
</table>       
              </p>

    
    </td>
    </tr>
    </table>
    
    
    </div>
    </form>
</body>
</html>
