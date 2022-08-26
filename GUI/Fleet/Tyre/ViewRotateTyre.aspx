<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="ViewRotateTyre.aspx.cs" Title="Rotate Tire"  Inherits="TYRE_ViewRotateTyre" %>

 

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
 
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Rotate/Move Tyre</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
            
               <td align="center">
<asp:UpdateProgress ID="uppMain" runat="server">

<ProgressTemplate>

    <iframe frameborder="0" src="about:blank"

        style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>

        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
            <img src="../../../GUI/images/loading.gif" /><font face=verdana color=blue size=4>&nbsp;<b>Please Wait...</b></font></div>

</ProgressTemplate>

</asp:UpdateProgress>
         
          </td>      
            
            
        </tr>
    </table>
    <p align="left">
 <table cellspacing="1" width="80%">
    
        <tr align="center">
            <td style="width: 550px">
                <table cellspacing="1"  class="boxbg"  width="100%">
                    <tr class="bgbluegrey">
                        <td colspan="2" align="center">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                        </td>
                    </tr>

                    
                    <tr style="background-color: white" align="center">
                        <td align="left" >
                            <asp:Label ID="lblTyreTYPE" Text="Tyre Type" Font-Bold="true" CssClass="blackfnt"
                                runat="server" />
                        </td>
                        <td  align="left" >
                            <asp:DropDownList ID="ddlTyreType" runat="server"  CssClass="blackfnt" Width="123px" >
                             
                            </asp:DropDownList>
                           
                          
                        </td>
                    </tr>

                      <tr style="background-color: white" align="center">
                        <td align="left" >
                            <asp:Label ID="Label1" Text="Manufacturer" Font-Bold="true" CssClass="blackfnt"
                                runat="server" />
                        </td>
                        <td  align="left">
                            <asp:DropDownList ID="ddlMFG" runat="server"  CssClass="blackfnt" Width="122px" ></asp:DropDownList>
                           
                          
                        </td>
                    </tr>
                       <tr style="background-color: white" align="center">
                        <td align="left" >
                            <asp:Label ID="Label2" Text="Size" Font-Bold="true" CssClass="blackfnt"
                                runat="server" />
                        </td>
                        <td  align="left" >
                            <asp:DropDownList ID="ddlSize" runat="server" CssClass="blackfnt" Width="122px" ></asp:DropDownList>
                           
                          
                        </td>
                    </tr>
                       <tr style="background-color: white" align="center">
                        <td align="left" >
                            <asp:Label ID="Label3" Text="Status" Font-Bold="true" CssClass="blackfnt"
                                runat="server" />
                        </td>
                        <td  align="left" >
                          <asp:Label ID="lblStatus" Text="Mounted"  CssClass="blackfnt"
                                runat="server" />
                          
                        </td>
                    </tr>
  


                    <tr style="background-color: white">
                        <td colspan="2" align="right">
                            <asp:UpdatePanel ID="UPShowTyre" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btnShow" runat="server" Text="Submit" ValidationGroup="VGDtFromTo" 
                                        OnClick="btnShow_OnClick" />
                               
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
       
    </table>
    </p>
   <br />
   <p align="left">
   <table cellspacing="1" style="width: 100%">
        <tr align="left">
            <td align="left">
                <asp:UpdatePanel ID="u1" UpdateMode="Conditional" runat="server">
                    <ContentTemplate>
                 
                      <asp:GridView ID="GridView1" runat="server" BorderWidth="1px" CellSpacing="1" CellPadding="5" HeaderStyle-CssClass="dgHeaderStyle" 
                             AllowPaging="True" PageSize="20" PagerStyle-HorizontalAlign="left"               
                            PagerSettings-Mode="Numeric" AutoGenerateColumns="False"  
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8BA0E5"   DataKeyNames="TYRE_ID"  >
                            <Columns>
                               
                                     <asp:HyperLinkField DataTextFormatString="--Select--" DataTextField="TYRE_ID" DataNavigateUrlFields="TYRE_ID"
                                    DataNavigateUrlFormatString="Rotate_Move.aspx?id={0}" >
                                    <ItemStyle CssClass="bluelink" ForeColor="Blue" />
                                </asp:HyperLinkField>
                               <asp:BoundField DataField="TYRE_NO" HeaderText="Tyre NO" >
                                    <ItemStyle HorizontalAlign="Left" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Type_Name" HeaderText="Type" >
                                    <ItemStyle HorizontalAlign="Left" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                               
                                <asp:BoundField DataField="MFG_Name" HeaderText="Manufacturer"> 
                                    <ItemStyle HorizontalAlign="Left" />    
                                      <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                

                                <asp:BoundField DataField="SIZE_NAME" HeaderText="Size">
                                    <ItemStyle HorizontalAlign="Left" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:BoundField DataField="TYRE_STATUS" HeaderText="Status">
                                    <ItemStyle HorizontalAlign="Left" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                                                             
                               <asp:BoundField DataField="TYRE_VEHNO" HeaderText="VehicleNo" >
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>     
                                 <asp:BoundField DataField="LOC_NAME" HeaderText="Location">
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>  
                                <asp:BoundField DataField="PDate" HeaderText="Purchase Date" >
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="TYRE_TREAD_DEPTH_32NDS" HeaderText="Tread Depth" >
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField> 
                              
                          
        	                
                                 
                             
                                                     
                            
                                
                                
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>       
                        
                        

                    
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnShow" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
                </td>
        </tr>
         </table>
         <br/>
         <table cellspacing="1" style="width: 100%">
           <tr style="background-color: white">
                        <td colspan="3" align="center">
                            &nbsp;</td>
                    </tr>
        
        
    </table>
   </p>
 
 
 </asp:Content>
