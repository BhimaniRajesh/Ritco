<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="vendorContract_pickup.aspx.cs" Inherits="GUI_Admin_Vendor_contract_vendorContract_pickup" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
function  Check_num(obj,arg){
		if (isNaN(obj.value))
    	{
     	 alert("Please enter in numeric")
      		obj.focus();
      		obj.value="0.00";
      	return false;
    	}
	}
</script>
<table width="80%" border="0" align="left" cellpadding="0" cellspacing="0">
    	<tr> 
          <td height="30"><font class="blklnkund"><strong> Module</strong></font>
          
		<strong> &gt; </strong><font class="blklnkund"><strong>Administrator </strong></font>

<strong> &gt; </strong> <font class="blklnkund"><strong>Finance & Accounts</strong></font>

<strong> &gt; </strong> <font class="blklnkund"><strong>Vendor Contract Master </strong></font>

<font class="bluefnt"><strong> &gt; </strong>
		  <strong>Charge Matrices :  Booking Charges matrix   </strong> </font></td>
        </tr>
        <tr> 
          <td class="horzblue"></td>
        </tr>
        <tr> 
          <td></td>
        </tr>

   
        
        <tr> 
          <td align="right"></td>
        </tr>
                   <tr> 
                      <td  valign="top">
				
<br />
<br />
<table align="center" border="0" cellpadding="7" cellspacing="1" style="width: 9.0in;"class="boxbg">
 
<tr class="bgbluegrey">
<td colspan="3" align="center"><font class="blackfnt"><b>VENDOR CONTRACT MASTER </b></font></td>
</tr>
<tr>
<td bgcolor="#FFFFFF">
<table  border="0"align="center" cellspacing="1" cellpadding="6" style="width: 9.0in;" class="boxbg">
<tr >
<td colspan="4" class="bgbluegrey"><font class="blackfnt"><strong><U>Step : 3</U>&nbsp;&nbsp;&nbsp;&nbsp<b>Charge  Matrices : Booking Charges matrix  </b> </strong></font></td>
</tr>




<tr >

<td colspan="4" bgcolor="#ffffff">
<br />
<font class="blackfnt"><b>Fixed Charges </b></font>
<br />
<table  border="0" align="center" cellspacing="1" cellpadding="6" width="50%" class="boxbg">
<tr bgcolor="#ffffff">
<td width="25%" ><font class="blackfnt">Fixed charges Rs. - Minimum</font></td>
<td width="25%"><font class="blackfnt" >
 <asp:TextBox ID="txtminchrg" width="60" MaxLength="10" class="input" runat="server" borderStyle="Groove" Columns="8"   ></asp:TextBox>
</font></td>
</tr> 
<tr bgcolor="#ffffff">
<td width="25%" ><font class="blackfnt">Fixed charges Rs. - Maximum</font></td>
<td width="25%"><font class="blackfnt" >
<asp:TextBox ID="txtmaxchrg" width="60" MaxLength="10" class="input" runat="server" borderStyle="Groove" Columns="8"   ></asp:TextBox>
</font></td>
</tr> 
<tr bgcolor="#ffffff">
<td width="25%" ><font class="blackfnt">Charge basis</font></td>
<td width="25%"><font class="blackfnt" >
<asp:HiddenField ID="cbochrgbasis" Value="Per Cnote" runat="server" />
Per Cnote

</font>
</td>
</tr>
<tr bgcolor="#ffffff">
<td width="25%" ><font class="blackfnt">Slab basis</font></td>
<td width="25%"><font class="blackfnt" >
Rs. of freight
<asp:HiddenField ID="txtslabbasis" Value="Rs. of freight" runat="server" />
</font></td>
</tr>
</table>

<br />

<p align ="left" ><font class="blackfnt"><b>Variable Charges</b></font></p>
<p align ="center" ><font class="bluefnt"><b>Rate as % of freight for given freight slab (in Rs.)


</b>
</font></p>


<asp:UpdatePanel ID="DataGrid2_Update" runat="server"  UpdateMode="Always" RenderMode="Inline">
                 <ContentTemplate>
    
                    <center>
                         <table border="0" cellpadding="1" cellspacing="1" class="boxbg"  align="center">
           
            <tr id="ROW_ID" bgcolor="white"   runat="server" >
               <td align="left" style="width: 91px; height: 20px;" ><font class="blackfnt">
                   Enter Row No *</font></td><td style="height: 20px" >
                   <asp:TextBox ID="roww" runat="server" width="40px" borderStyle="Groove" AutoPostBack="True" OnTextChanged="roww_TextChanged" TabIndex="25" ></asp:TextBox></td>
             </tr>
         </table>
         <br /> 
         
         
                        </center>
                     <center>
                        </center>
                     <center>
                     <%--<table  border="0" align=center cellspacing="1" cellpadding="6" width="100%" class="boxbg">
<tr class="bgbluegrey">
<td colspan="4"><font class="blackfnt"><strong>&nbsp;&nbsp;&nbsp;&nbsp<b>Select Charge Matrices</b> </strong></font></td>
</tr><tr bgcolor="#ffffff">
<td colspan="4">--%>
                         <%--<asp:GridView id="DataGrid1" runat="server" AllowPaging="false" PageSize="1000" AutoGenerateColumns="False" CellPadding="1" BackColor="White" borderColor="#3366CC" borderStyle="None" borderwidth="1px" CssClass="Styles.css" cellspacing="1" width="90%">
                        <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                        <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
			            <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                        <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                        <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" />--%>
             <p align ="left"  ><font class="blackfnt"><b  runat="server" id="rd" >Variable Charges- Road/Normal</b></font></p>          
                         
                         <asp:GridView ID="GV_D" runat="server" align="center" HeaderStyle-CssClass="bgbluegrey" 
                                                         PagerStyle-HorizontalAlign="left" 
                                                         ShowFooter="True"
                                                       BackColor="white" 
                                                             CssClass="boxbg" FooterStyle-CssClass="boxbg" 
                                                            AutoGenerateColumns="False" SelectedIndex="1"  >
                                                             
                                                                 <Columns>
                                                                 
                                                                 <asp:TemplateField HeaderText="SR.NO." >
                                  <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle CssClass="blackfnt" />
                                 <ItemTemplate>
                                 <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>
                                 <asp:HiddenField ID="SRNO" runat="server" />
                                 </ItemTemplate>
                                 </asp:TemplateField>
                                                                 
                                                                                                                                            
                                                                                    
                                                                                    
                                                                                     
                                                                                    
                                                                                     <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="From">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                <asp:TextBox ID="txtfromvalroad" width="60" MaxLength="10" runat="server" borderStyle="Groove" Columns="8"   ></asp:TextBox>
                                     </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                     <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="To">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                 <asp:TextBox ID="txttovalroad" width="60" MaxLength="10" runat="server" borderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                     </ItemTemplate></asp:TemplateField>
                                                                                      
                                                                                       <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="Rate-TBB">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                 <asp:TextBox ID="txtchrgroad0" width="60" MaxLength="10" runat="server" borderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                     </ItemTemplate></asp:TemplateField>
                                                                                     
                                                                                      <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="Rate-Topay">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                 <asp:TextBox ID="txtchrgroad1" width="60" MaxLength="10" runat="server" borderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                     </ItemTemplate></asp:TemplateField>
                                                                                     
                                                                                     
                                                                                     <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="Rate-Paid">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                 <asp:TextBox ID="txtchrgroad2" width="60" MaxLength="10" runat="server" borderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                     </ItemTemplate></asp:TemplateField>
                                                                                       
                                                                                    
                                                                                    </Columns>
                                                                                    
                             <FooterStyle CssClass="bgbluegrey"   />
                             <HeaderStyle  BackColor="white" />
                                                                                            </asp:GridView>  
                                                                                            
                                                                                            <br />
                                                                                            
                                                                                            <p align ="left" ><font class="blackfnt"><b>Variable Charges- Train</b></font></p>  
                                                                                            <asp:GridView ID="GV_D1" runat="server" align="center" HeaderStyle-CssClass="bgbluegrey" 
                                                         PagerStyle-HorizontalAlign="left" 
                                                         ShowFooter="True"
                                                       BackColor="white" 
                                                             CssClass="boxbg" FooterStyle-CssClass="boxbg" 
                                                            AutoGenerateColumns="False" SelectedIndex="1"  >
                                                             
                                                                 <Columns>
                                                                 
                                                                 <asp:TemplateField HeaderText="SR.NO." >
                                  <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle CssClass="blackfnt" />
                                 <ItemTemplate>
                                 <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>
                                 <asp:HiddenField ID="SRNO" runat="server" />
                                 </ItemTemplate>
                                 </asp:TemplateField>
                                                                 
                                                                                                                                            
                                                                                    
                                                                                    
                                                                                     
                                                                                    
                                                                                     <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="From">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                <asp:TextBox ID="txtfromvalrail" width="60" MaxLength="10" runat="server" borderStyle="Groove" Columns="8"   ></asp:TextBox>
                                     </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                     <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="To">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                 <asp:TextBox ID="txttovalrail" width="60" MaxLength="10" runat="server" borderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                     </ItemTemplate></asp:TemplateField>
                                                                                      
                                                                                       <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="Rate-TBB">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                 <asp:TextBox ID="txtchrgrail0" width="60" MaxLength="10" runat="server" borderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                     </ItemTemplate></asp:TemplateField>
                                                                                     
                                                                                      <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="Rate-Topay">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                 <asp:TextBox ID="txtchrgrail1" width="60" MaxLength="10" runat="server" borderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                     </ItemTemplate></asp:TemplateField>
                                                                                     
                                                                                     
                                                                                     <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="Rate-Paid">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                 <asp:TextBox ID="txtchrgrail2" width="60" MaxLength="10" runat="server" borderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                     </ItemTemplate></asp:TemplateField>
                                                                                       
                                                                                    
                                                                                    </Columns>
                                                                                    
                             <FooterStyle CssClass="bgbluegrey"   />
                             <HeaderStyle  BackColor="white" />
                                                                                            </asp:GridView> 
                                                                                              <br />
                                                                                            
                                                                                            <p align ="left" ><font class="blackfnt"><b>Variable Charges- Air</b></font></p>
                                                                                            <asp:GridView ID="GV_D2" runat="server" align="center" HeaderStyle-CssClass="bgbluegrey" 
                                                         PagerStyle-HorizontalAlign="left" 
                                                         ShowFooter="True"
                                                       BackColor="white" 
                                                             CssClass="boxbg" FooterStyle-CssClass="boxbg" 
                                                            AutoGenerateColumns="False" SelectedIndex="1"  >
                                                             
                                                                 <Columns>
                                                                 
                                                                 <asp:TemplateField HeaderText="SR.NO." >
                                  <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle CssClass="blackfnt" />
                                 <ItemTemplate>
                                 <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>
                                 <asp:HiddenField ID="SRNO" runat="server" />
                                 </ItemTemplate>
                                 </asp:TemplateField>
                                                                 
                                                                                                                                            
                                                                                    
                                                                                    
                                                                                     
                                                                                    
                                                                                     <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="From">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                <asp:TextBox ID="txtfromvalair" width="60" MaxLength="10" runat="server" borderStyle="Groove" Columns="8"   ></asp:TextBox>
                                     </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                     <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="To">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                 <asp:TextBox ID="txttovalair" width="60" MaxLength="10" runat="server" borderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                     </ItemTemplate></asp:TemplateField>
                                                                                      
                                                                                       <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="Rate-TBB">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                 <asp:TextBox ID="txtchrgair0" width="60" MaxLength="10" runat="server" borderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                     </ItemTemplate></asp:TemplateField>
                                                                                     
                                                                                      <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="Rate-Topay">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                 <asp:TextBox ID="txtchrgair1" width="60" MaxLength="10" runat="server" borderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                     </ItemTemplate></asp:TemplateField>
                                                                                     
                                                                                     
                                                                                     <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="Rate-Paid">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                 <asp:TextBox ID="txtchrgair2" width="60" MaxLength="10" runat="server" borderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                     </ItemTemplate></asp:TemplateField>
                                                                                       
                                                                                    
                                                                                    </Columns>
                                                                                    
                             <FooterStyle CssClass="bgbluegrey"   />
                             <HeaderStyle  BackColor="white" />
                                                                                            </asp:GridView>  
                                                                                            
                                                                                              <br />
                                                                                            
                                                                                            <p align ="left" ><font class="blackfnt"><b>Variable Charges- Express</b></font></p> 
                                                                                            <asp:GridView ID="GV_D3" runat="server" align="center" HeaderStyle-CssClass="bgbluegrey" 
                                                         PagerStyle-HorizontalAlign="left" 
                                                         ShowFooter="True"
                                                       BackColor="white" 
                                                             CssClass="boxbg" FooterStyle-CssClass="boxbg" 
                                                            AutoGenerateColumns="False" SelectedIndex="1"  >
                                                             
                                                                 <Columns>
                                                                 
                                                                 <asp:TemplateField HeaderText="SR.NO." >
                                  <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle CssClass="blackfnt" />
                                 <ItemTemplate>
                                 <asp:Label ID="lblsrnocomplainlist" text ="<%# Container.DataItemIndex+1 %>" runat="server">
                                 </asp:Label>
                                 <asp:HiddenField ID="SRNO" runat="server" />
                                 </ItemTemplate>
                                 </asp:TemplateField>
                                                                 
                                                                                                                                            
                                                                                    
                                                                                    
                                                                                     
                                                                                    
                                                                                     <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="From">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                <asp:TextBox ID="txtfromvalexp" width="60" MaxLength="10" runat="server" borderStyle="Groove" Columns="8"   ></asp:TextBox>
                                     </ItemTemplate>
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                     <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="To">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                 <asp:TextBox ID="txttovalexp" width="60" MaxLength="10" runat="server" borderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                     </ItemTemplate></asp:TemplateField>
                                                                                      
                                                                                       <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="Rate-TBB">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                 <asp:TextBox ID="txtchrgexp0" width="60" MaxLength="10" runat="server" borderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                     </ItemTemplate></asp:TemplateField>
                                                                                     
                                                                                      <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="Rate-Topay">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                 <asp:TextBox ID="txtchrgexp1" width="60" MaxLength="10" runat="server" borderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                     </ItemTemplate></asp:TemplateField>
                                                                                     
                                                                                     
                                                                                     <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="Rate-Paid">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                 <asp:TextBox ID="txtchrgexp2" width="60" MaxLength="10" runat="server" borderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                     </ItemTemplate></asp:TemplateField>
                                                                                       
                                                                                    
                                                                                    </Columns>
                                                                                    
                             <FooterStyle CssClass="bgbluegrey"   />
                             <HeaderStyle  BackColor="white" />
                                                                                            </asp:GridView>   
                                                                                            </td>  </tr></table>
                                                                                            
                                                                                             <center>
                                                </center>
              </ContentTemplate>   
              <Triggers>
                <asp:AsyncPostBackTrigger ControlID="roww" EventName="TextChanged" />
              </Triggers>
        
               
            </asp:UpdatePanel>
            
             
                 
                  <center>
                  
             
 <br />
<asp:Button ID="Submit"  OnClick="Submit_Click"  runat="server" Text="Submit" TabIndex="9"  /></center>
<%--</td>
</tr>
</table>--%>
<br />
                 
<div id="divlonghaulroad_km_variable1"> </div>

</td>
</tr>
</table>


 
  					 
					 </td>
                    </tr>
                  <tr>
                      <td></td>
                    </tr>
                  </table>
</asp:Content>

