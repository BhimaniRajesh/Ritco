<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Result_vehicle_print.aspx.cs" Inherits="Reports_Result_vehicle_print" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Vehicle Register</title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
    <Script language ="javascript">
      function PrintMe()
      {
      window.print();
      }
    
    </script>
    
</head>
<body onload="PrintMe()">
    <form id="form1" runat="server">
    <div>
    
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
                                                                             
                                                                             
                                                                                <%--<center>
                                                    <table width="25%" border="0" cellspacing="1" cellpadding="3" 
                                                        align="center" id="tblButtons" runat="server">
			                                            <tr style="background-color: #ffffff">
			                                                <td>
			                                                    <input type="button" class="btncolor" value="  Print    " runat="server" id="btnPrint"   visible="false"  onclick="faction(1)" />
			                                                </td>
    			                                            
			                                                <td>
			                                                    <input type="button" class="btncolor" value="  XLS  " runat="server" id="btnXML"  visible="false"  onserverclick="btnXML_ServerClick"/>
			                                                </td>
    			                                            
			                                                <td>
			                                                    <input type="button" class="btncolor" value="  Email " runat="server" id="btnEmail"  visible="false"   onclick="faction(3)" />
			                                                </td>
			                                            </tr>
		                                            </table>
		                                        </center>--%>
    
    </div>
    </form>
</body>
</html>
