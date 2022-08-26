<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Goods_RCPT_2.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<div align="left" style="width:9.5in;">
<table style="width: 1100px">
    <tr>
    <td  align="left">  
        <a><font class="blklnkund"><b>Module</b></font></a>
							<b> &gt; </b>
							<a><font class="blklnkund"><b>Reports</b></font></a>
							<b> &gt; </b>
							<a href="../rpt_Finance.aspx"><font class="blklnkund"><b>Finance</b></font></a>
							<b> &gt; </b>
							<font class="bluefnt"><b>Goods Receipt</b></font>
	</td>
	 
    </tr>
    </table>
                                 
                                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td >
                                                           
                                                           
                                                             <br />
                                                            
                                                            <p align="center">
                                                                <label class="blackfnt">
                                                                    <b>
                                                                        You Selected
                                                                        <asp:Label ID="Label1" runat="server" Text="Label" Visible="false"></asp:Label></b></label></p>
                                                  
                                  <table border="0" cellpadding="3" width="565" style="background-color: #808080;" cellspacing="1" align="center" class="boxbg">
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
                                                                               Vendor :</label></td>
                                                                        
                                                                        <td style="width: 343">
                                                                            &nbsp;
                                                                            <asp:Label ID="lblloc" Text="All"  runat="server" CssClass="blackfnt"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <tr style="background-color: #FFFFFF">
                                                                        <td style="width: 205; height: 6px;">
                                                                            <label class="blackfnt">
                                                                                Purchase Order Code :</label></td>
                                                                        
                                                                        <td style="width: 343; height: 6px;">
                                                                            &nbsp;
                                                                            <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                                                                            </td>
                                                                    </tr>
                                                                </table>
                                                                
                                                                <br />
                                                                <br />
                                                                </td>
                                                             
                                                                </tr>
                                                                
                                                                <%--<tr>  
                                                                
                                                                
                                                                
                                                                   
                                                                   <%--<asp:UpdatePanel ID="UP1" runat="Server">
                                                                    <ContentTemplate>--%>
                                                                    <asp:GridView ID="GV_Booking" runat="server" align="center" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey" 
                                                         PagerStyle-HorizontalAlign="left" 
                                                             CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"  
                                                             AllowPaging="true" PageSize="25"
                                                               OnPageIndexChanging="pgChange" AllowSorting="False" 
                                                            AutoGenerateColumns="false"
                                                            ShowFooter="false"
                                                               PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." >
                                                                <PagerStyle VerticalAlign="Bottom"/>
                                                                <Columns>
                                                                 
                                                                 <asp:BoundField  DataField="pocode"  ItemStyle-Wrap="true"    HeaderText="PO Code" HeaderStyle-Font-Bold="true"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                             
                                                                             
                                                                              <asp:BoundField  DataField="podt"  ItemStyle-Wrap="true"   HeaderText="PO Date" HeaderStyle-Font-Bold="true"   > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                             
                                                                      <asp:BoundField  DataField="vendorcd"   ItemStyle-Wrap="true"  HeaderText="Vendor" HeaderStyle-Font-Bold="true"  > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="150"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>
                                                                             
                                                                             
                                                                              <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderText="Assign" HeaderStyle-Font-Bold="true">
                                                                <HeaderStyle HorizontalAlign="left" Wrap="False" CssClass="blackfnt" />
                                                                <ItemStyle CssClass="blackfnt" />
                                                                <ItemTemplate >
                                                                    <label class="blackfnt">
                                                                        <asp:HyperLink Font-Underline="True" runat="server" NavigateUrl='<%#"Goods_RCPT_3.aspx?para1=2&pcd="+DataBinder.Eval(Container.DataItem, "pocode")%>'
                                                                             Text='Assign' ID="Hyperlink3" />
                                                                    </label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                                             
                                                                             
                                                                                                                                  
                                                               </Columns>
                                                                
                                                                
                                                                
                                                                
                                                                
                                                                
                                              

                                                                </asp:GridView>
                                                                
                                                          <%--      OnRowDataBound="CustomersGridView_RowDataBound"
                                                                --%>
                                                               <%-- </ContentTemplate>
                                                                </asp:UpdatePanel>--%>
                                                              
                                                                
                                                                <tr>
                                                                
                                                                
                                                                
                                                                        <asp:Label ID="lblnull" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Medium"
                                                                            ForeColor="Red" Text="Label" Visible="False"></asp:Label></tr>
                                                                <tr align="center">
                                                                
                                                                </tr>
                                                                </table>
                                                               <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="Server">
                                                                    <ContentTemplate>--%>
                                                                <br />
                                                                
                                                                <table border="0" cellpadding="0" width="565"   bgcolor="white" cellspacing="0" align="center" >
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
                                                                 <tr align="center" >
			                                                   </tr>
			                                                                                    </table>
                                                               
                                                                
                                                            
                                                            
                                                       
                                      
    
    
</div>
</asp:Content>
