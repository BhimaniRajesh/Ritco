<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="Result_vehicle.aspx.cs" Inherits="GUI_MIS_Vehicle_Register_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
  <script language="javascript">
  function nwOpen()
{
//alert("hi");
//window.open("Result_vehicle_print.aspx","pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
window.open("Result_vehicle_print.aspx","pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=850,height=650,status=no,left=220,top=70")
}


</script>


  
  <br />  <br /> <table border="0" cellpadding="3" width="565" style="background-color: #808080;" cellspacing="1" align="center" class="boxbg">
                                                                
                                                                  
                                                                    
                                                                    <tr style="background-color: #FFFFFF">
                                                                        <td style="width: 205">
                                                                            <label class="blackfnt">
                                                                                Location :</label></td>
                                                                        
                                                                        <td style="width: 343">
                                                                            &nbsp;
                                                                            <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                      <tr style="background-color: #FFFFFF">
                                                                        <td style="width: 205; height: 15px;">
                                                                            <label class="blackfnt">
                                                                               Vehicle No.</label></td>
                                                                        
                                                                        <td style="width: 343; height: 15px;">
                                                                            &nbsp;
                                                                            <asp:Label ID="lbVehnolist" runat="server" CssClass="blackfnt"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    
                                                                   
                                                                
                                                               
                                                                </table>
                                                                  <br />
                                                                    <br />
 <asp:GridView ID="GV_Veh" runat="server" align="center" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey" 
                                                         PagerStyle-HorizontalAlign="left" 
                                                             CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"  
                                                             
                                                      OnRowDataBound="CustomersGridView_RowDataBound" AutoGenerateColumns="false"
                                                            EmptyDataText="No Records Found..." >
                                                                <PagerStyle VerticalAlign="Bottom"/>
                                                               
                                                               
                                                                <Columns>
                                                                 
                                                              <asp:BoundField  DataField="sno"   ItemStyle-Wrap="true"     > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="20"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                             
                                                                 <asp:BoundField  DataField="Vehno"   ItemStyle-Wrap="true"     > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                             
                                                                            <asp:BoundField  DataField="vehicle_type"   ItemStyle-Wrap="true"     > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                             
                                                                        <asp:BoundField  DataField="Vehicle_Size"   ItemStyle-Wrap="true"     > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                             
                                                                             <asp:BoundField  DataField="Capacity"   ItemStyle-Wrap="true"     > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                             
                                                                             
                                                                             
                                                                             <asp:BoundField  DataField="Manufacturer"   ItemStyle-Wrap="true"     > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                             
                                                                             <asp:BoundField  DataField="Model"   ItemStyle-Wrap="true"     > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                                                                                                
                                                                             
                                                                              <asp:BoundField  DataField="Total_Kms"  ControlStyle-Width="100"  ItemStyle-Wrap="true"     > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                            
                                                                             <asp:BoundField  DataField="vd01c001"    ItemStyle-Wrap="true"     > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                              <asp:BoundField  DataField="vd01c002"   ItemStyle-Wrap="true"     > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                              <asp:BoundField  DataField="vd01c003"   ItemStyle-Wrap="true"     > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                             
                                                                              <asp:BoundField  DataField="vd02c001"   ItemStyle-Wrap="true"     > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                              <asp:BoundField  DataField="vd02c002"   ItemStyle-Wrap="true"     > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                              <asp:BoundField  DataField="vd02c003"   ItemStyle-Wrap="true"     > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                             
                                                                             
                                                                              <asp:BoundField  DataField="vd03c001"   ItemStyle-Wrap="true"     > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                              <asp:BoundField  DataField="vd03c002"   ItemStyle-Wrap="true"     > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                              <asp:BoundField  DataField="vd03c003"   ItemStyle-Wrap="true"     > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                               <asp:BoundField  DataField="vd03c004"   ItemStyle-Wrap="true"     > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                             </Columns></asp:GridView>
                                                                             
                                                                             <br /><br />
                                                                             
                                                                             
                                                                                <center>
                                                    <table width="25%" border="0" cellspacing="1" cellpadding="3" 
                                                        align="center" id="tblButtons" runat="server">
			                                            <tr style="background-color: #ffffff">
			                                                <td>
			                                                    <input type="button" class="btncolor" value="  Print    " runat="server" id="btnPrint"   visible="false"  onclick="javascript:nwOpen();"></>
			                                                </td>
    			                                            
			                                                <td>
			                                                    <input type="button" class="btncolor" value="  XLS  " runat="server" id="btnXML"  visible="false"  onserverclick="btnXML_ServerClick"/>
			                                                </td>
    			                                            
			                                                <td>
			                                                    <input type="button" class="btncolor" value="  Email " runat="server" id="btnEmail"  visible="false"   onclick="faction(3)" />
			                                                </td>
			                                            </tr>
		                                            </table>
		                                        </center>


</asp:Content>