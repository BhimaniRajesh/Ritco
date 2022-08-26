<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Show_Summary_Location_Stock.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

                                 <table style="width: 1100px">
    <tr>
    <td  align="left">  
        <a><font class="blklnkund"><b>Module</b></font></a>
							<b> &gt; </b>
							<a><font class="blklnkund"><b>Reports</b></font></a>
							<b> &gt; </b>
							<a href="../rpt_Operation.aspx"><font class="blklnkund"><b>Operations</b></font></a>
							<b> &gt; </b>
							<font class="bluefnt"><b> Location Stock Report </b></font>
	</td>
	<td align="right">
	    <a href="javascript:window.history.go(-1)"  title="back"><img src="../../images/back.gif" border="0" alt="" /></a>
	</td>
    </tr>
    </table>
    <br /> 
<div align="left" style="width:9.5in;">

                                 <table border="0"  cellpadding="3" style="width: 5.5in;" align="left"  cellspacing="1" >
                                                     <tr>
                                                        <td >
                                                           
                                                            
                                                            <p align="center">
                                                                <label class="blackfnt">
                                                                    <b>
                                                                        You Selected
                                                                        <asp:Label ID="Label1" runat="server" Text="Label" Visible="false"></asp:Label></b></label></p>
                                                                     </td>
                                                          
                                                             
                                                                </tr>
                                                                </table>    
                                                                        
                                                  
                                                    <br /><br />
                                                  
                                  <table border="0" cellpadding="3" width="565" style="background-color: #808080;" cellspacing="1"  align="left"class="boxbg">
                                                                <tr style="background-color: #ffffff">
                                                                    <td style="height: 10px">
                                                                    <label class="blackfnt">
                                                                    
                                                                        Date :
                                                                        </label>
                                                                        </td>
                                                                    <td style="height: 10px">
                                                                        <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
                                                                </tr>
                                                                    
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
                                                                        <td style="width: 205; height: 6px;">
                                                                            <label class="blackfnt">
                                                                                Ro :</label></td>
                                                                        
                                                                        <td style="width: 343; height: 6px;">
                                                                            &nbsp;
                                                                            <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                                                                            </td>
                                                                    </tr>
                                                                </table>
                                                                
                                                               
                                                                <br /><br /><br /><br /><br /><br /> 
                                                                
                                                                  <table width="565"  align="center" >
                                                                 
                                                                <tr>   
                                                                   
                                                                   <%--<asp:UpdatePanel ID="UP1" runat="Server">
                                                                    <ContentTemplate>--%>
                                                                    <asp:GridView ID="GV_Summ" runat="server" align="center" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey" 
                                                         PagerStyle-HorizontalAlign="left" 
                                                             CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"  
                                                             AllowPaging="true" PageSize="25"
                                                       
                                                            OnPageIndexChanging="pgChange" AllowSorting="False" 
                                                            AutoGenerateColumns="false"
                                                              
                                                            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." >
                                                                <PagerStyle VerticalAlign="Bottom"/>
                                                               
                                                               
                                                                <Columns>
                                                                 
                                                                  <%--<asp:BoundField  DataField="Sno"   ItemStyle-Wrap="true"     > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="20"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>--%>
                                                                             
                                                                 <asp:BoundField  DataField="doc_curloc_nm"   ItemStyle-Wrap="true"  HeaderText="Current Location"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                             
                                                                             
                                                                             <asp:BoundField  DataField="reassign_destcd_nm"   ItemStyle-Wrap="true"  HeaderText="Delivery Location"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                             
                                                                               <asp:TemplateField  HeaderText="Total No. of Docket">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    <center>
                                                                                    <label class="blackfnt"> 
                                                                                    
                                                                                    <asp:HyperLink  Font-Underline="True"  Runat="server"  NavigateUrl='<%#"Show_Detail_Location_stock.aspx?Cur_loc=" +DataBinder.Eval(Container.DataItem, "doc_curloc")+"&dly_loc=" +DataBinder.Eval(Container.DataItem, "reassign_destcd")+"&reppara="+"drill"%>' Text= '<%#DataBinder.Eval(Container.DataItem, "TOT_DKT")%>' ID="Hyperlink3"/>
                                                                                        
                                                                                    </label>
                                    </center>
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                             <%--<asp:BoundField  DataField="TOT_DKT"   ItemStyle-Wrap="true"  HeaderText="Total No. of Docket"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>--%>
                                                                             
                                                                             <asp:BoundField  DataField="TOT_DETAIN_DKT"   ItemStyle-Wrap="true"  HeaderText="Total No. of Detain Docket"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                             
                                                                             <asp:BoundField  DataField="TOT_ACTUWT"   ItemStyle-Wrap="true"  HeaderText="Total Act. Wt."   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                             <asp:BoundField  DataField="TOT_TOPAYFRT"   ItemStyle-Wrap="true"  HeaderText="To Pay"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                             
                                                                             <asp:BoundField  DataField="TOT_FRT"   ItemStyle-Wrap="true"  HeaderText="Freight value"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                             
                                                                             <asp:BoundField  DataField="TOT_PACKS"   ItemStyle-Wrap="true"  HeaderText="Packs"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                             
                                                                            


                                        
                                                                              
                                                                

                                 
                                                                       
                                                                                         
                                                                 
                                                                 </Columns>
                                                                 
                                                                
                                              

                                                                </asp:GridView>
                                                               <%-- </ContentTemplate>
                                                                </asp:UpdatePanel>--%>
                                                                
                                                                </tr>
                                                                
                                                                <tr>
                                                                
                                                                
                                                                
                                                                        <asp:Label ID="lblnull" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Medium"
                                                                            ForeColor="Red" Text="Label" Visible="False"></asp:Label></tr>
                                                                <tr align="center">
                                                                
                                                                </tr>
                                                                </table>
                                                               <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="Server">
                                                                    <ContentTemplate>--%>
                                                                
                                                                <table border="0" cellpadding="0" width="565" style="background-color: #808080;" cellspacing="0" align="center" class="boxbg">
                                                                <tr align="center">   
                                                                <td style="background-color: #ffffff">
                                                                
                                                                <asp:LinkButton ID="LinkButton1" OnClick="fst" runat="server" Text="First" >
                                                                </asp:LinkButton>
                                                                </td>                                                             
                                                                <td style="background-color: #ffffff">
                                                                
                                                                <asp:LinkButton ID="LinkButton2" OnClick="lst" runat="server" Text="Last">
                                                                </asp:LinkButton>
                                                                </td>
                                                                </tr>
                                                                    <tr align="center">
                                                                        <td colspan="2" style="background-color: #ffffff">
                                                                        <br />
                                                                            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="DownLoad XLS" Width="139px" /></td>
                                                                    </tr>
                                                                </table>
                                                               
                                                                
                                                            
                                                            
                                                       
                                      
    
    
</div>
</asp:Content>
