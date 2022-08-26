<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="vendorContract_rail.aspx.cs" Inherits="GUI_Admin_Vendor_contract_vendorContract_rail" Title="Untitled Page" %>
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
<table width="80%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td> 
      <table width="80%" border="0" align="center" cellpadding="0" cellspacing="0">
    	<tr> 
          <td height="30"><font class="blklnkund"><strong></strong></font>
          
		<strong> &gt; </strong><strong>Administrator </strong>

<strong> &gt; </strong> <strong>Finance & Accounts</strong>

<strong> &gt; </strong><font class="blklnkund"><strong>Vendor Contract Master </strong></font>

<font class="bluefnt"><strong> &gt; </strong>
		  <strong>Charge Matrices : Train Route  </strong> </font></td>
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
                      <td height="300" valign="top">
					  <!--START--> 


<table align="center" border="0" cellpadding="7" cellspacing="1" style="width: 9.0in;"class="boxbg">
 
<tr class="bgbluegrey">
<td colspan="3" align="center"><font class="blackfnt"><b>VENDOR CONtrACT MASTER </b></font></td>
</tr>
<tr>
<td bgcolor="#FFFFFF">
<table  border="0" align="center" cellspacing="1" cellpadding="6 "style="width: 9.0in;" class="boxbg">
<tr >
<td colspan="4" class="bgbluegrey"><font class="blackfnt"><strong><U>Step : 3</U>&nbsp;&nbsp;&nbsp;&nbsp<b>Charge Matrices : Train Route   </b> </strong></font></td>
</tr><tr >
<td colspan="4" bgcolor="#ffffff"><p align ="left" ><font class="blackfnt"><b>Fixed Charges</b></font></p>
<table  border="0" align="center" cellspacing="1" cellpadding="6" style="width: 9.0in;" class="boxbg">
<tr bgcolor="#ffffff">
<td width="25%" ><font class="blackfnt">Fixed charges Rs. - Minimum</font></td>
<td width="25%"><font class="blackfnt" >
<asp:TextBox ID="txtminchrg" CssClass="input"  MaxLength="10"  runat="server" width="56px"></asp:TextBox>
</font></td>
</tr> 
<tr bgcolor="#ffffff">
<td width="25%" ><font class="blackfnt">Fixed charges Rs. - Maximum</font></td>
<td width="25%"><font class="blackfnt" >
<asp:TextBox ID="txtmaxchrg" CssClass="input"  MaxLength="10"  runat="server" width="56px"></asp:TextBox>

</font></td>
</tr> 
<tr bgcolor="#ffffff">
<td width="25%" ><font class="blackfnt">Charge basis</font></td>
<td width="25%"><font class="blackfnt" ><asp:Label  ID="lbcharge" runat="server"> </asp:Label>
<asp:HiddenField id="txtchrgbasis"   runat="server"/>

</font></td>
</tr>
<tr bgcolor="#ffffff">
<td width="25%" ><font class="blackfnt">Slab basis</font></td>
<td width="25%"><font class="blackfnt" ><asp:Label  ID="lbslab" runat="server"> </asp:Label>
<asp:HiddenField id="txtslabbasis"   runat="server"/>

</font></td>
</tr>




</table>

<br />
<p align ="left" ><font class="blackfnt"><b>Variable Charges</b></font></p>
<p align ="center" ><font class="bluefnt"><b>Define Slab of KG.</b></font></p>

<table  border="0" align="center" cellspacing="1" cellpadding="6" style="width: 9.0in;" class="boxbg">
<tr bgcolor="#ffffff">

	<td align="center" width="5%" colspan="2"><font class="blackfnt"><b>Slab 1</b></font></td>
	<td align="center" width="5%" colspan="2"><font class="blackfnt"><b>Slab 2</b></font></td>
	<td align="center" width="5%" colspan="2"><font class="blackfnt"><b>Slab 3</b></font></td>
	<td align="center" width="5%" colspan="2"><font class="blackfnt"><b>Slab 4</b></font></td>
	<td align="center" width="5%" colspan="2"><font class="blackfnt"><b>Slab 5</b></font></td>
	<td align="center" width="5%" colspan="2"><font class="blackfnt"><b>Slab 6</b></font></td>
<tr bgcolor="#ffffff">

	<td align="center" width="5%" ><font class="blackfnt"><b>From</b></font></td>
	<td align="center" width="5%" ><font class="blackfnt"><b>To</b></font></td>
	<td align="center" width="5%" ><font class="blackfnt"><b>From</b></font></td>
	<td align="center" width="5%" ><font class="blackfnt"><b>To</b></font></td>
	<td align="center" width="5%" ><font class="blackfnt"><b>From</b></font></td>
	<td align="center" width="5%" ><font class="blackfnt"><b>To</b></font></td>
	<td align="center" width="5%" ><font class="blackfnt"><b>From</b></font></td>
	<td align="center" width="5%" ><font class="blackfnt"><b>To</b></font></td>
	<td align="center" width="5%" ><font class="blackfnt"><b>From</b></font></td>
	<td align="center" width="5%" ><font class="blackfnt"><b>To</b></font></td>
	<td align="center" width="5%" ><font class="blackfnt"><b>From</b></font></td>
	<td align="center" width="5%" ><font class="blackfnt"><b>To</b></font></td>

</tr>
<tr bgcolor="#ffffff">

	<td align="center" width="5%" ><font class="blackfnt"><b>	<asp:TextBox id="txtslabvalfrom1" Width="40" CssClass="input" MaxLength="10" runat="server"></asp:TextBox>		</b></font></td>
	<td align="center" width="5%" ><font class="blackfnt"><b>	<asp:TextBox id="txtslabvalto1" Width="40" CssClass="input" MaxLength="10" runat="server"></asp:TextBox>		</b></font></td>
	<td align="center" width="5%" ><font class="blackfnt"><b>	<asp:TextBox id="txtslabvalfrom2" Width="40"  CssClass="input"  MaxLength="10" runat="server"></asp:TextBox>		</b></font></td>
	<td align="center" width="5%" ><font class="blackfnt"><b>	<asp:TextBox id="txtslabvalto2" Width="40"  CssClass="input"  MaxLength="10" runat="server"></asp:TextBox>		</b></font></td>
<td align="center" width="5%" ><font class="blackfnt"><b>	<asp:TextBox id="txtslabvalfrom3" Width="40"  CssClass="input"  MaxLength="10" runat="server"></asp:TextBox>		</b></font></td>
	<td align="center" width="5%" ><font class="blackfnt"><b>	<asp:TextBox id="txtslabvalto3" Width="40" CssClass="input"  MaxLength="10" runat="server"></asp:TextBox>		</b></font></td>
<td align="center" width="5%" ><font class="blackfnt"><b>	<asp:TextBox id="txtslabvalfrom4" Width="40" CssClass="input"  MaxLength="10" runat="server"></asp:TextBox>		</b></font></td>
	<td align="center" width="5%" ><font class="blackfnt"><b>	<asp:TextBox id="txtslabvalto4" Width="40" CssClass="input"  MaxLength="10" runat="server"></asp:TextBox>		</b></font></td>
<td align="center" width="5%" ><font class="blackfnt"><b>	<asp:TextBox id="txtslabvalfrom5" Width="40" CssClass="input"  MaxLength="10" runat="server"></asp:TextBox>		</b></font></td>
	<td align="center" width="5%" ><font class="blackfnt"><b>	<asp:TextBox id="txtslabvalto5" Width="40" CssClass="input"  MaxLength="10" runat="server"></asp:TextBox>		</b></font></td>
<td align="center" width="5%" ><font class="blackfnt"><b>	<asp:TextBox id="txtslabvalfrom6" Width="40" CssClass="input"  MaxLength="10" runat="server"></asp:TextBox>		</b></font></td>
	<td align="center" width="5%" ><font class="blackfnt"><b>	<asp:TextBox id="txtslabvalto6" Width="40" CssClass="input"  MaxLength="10" runat="server"></asp:TextBox>		</b></font></td>


</tr>
</table>
<p align ="center" ><font class="bluefnt"><b>Per Kg. charges in Rs/KG.</b></font></p>
<asp:UpdatePanel ID="DataGrid2_Update" runat="server"  UpdateMode="Always" RenderMode="Inline">
                 <ContentTemplate>
    
                    <center>
                         <table border="0" cellpadding="1" cellspacing="1" class="boxbg"  align="center">
           
            <tr id="ROW_ID" bgcolor="white"   runat="server" >
               <td align="left" style="width: 91px; height: 20px;" ><font class="blackfnt">
                   Enter Row No *</font></td><td style="height: 20px" >
                   <asp:TextBox ID="roww" runat="server" Width="40px" BorderStyle="Groove" AutoPostBack="True" OnTextChanged="roww_TextChanged" TabIndex="25" ></asp:TextBox></td>
             </tr>
         </table>
         <br /> 
         
         
                        </center>
                     <center>
                        </center>
                     <center>
                     <table  border="0" align="center" cellspacing="1" cellpadding="6" WIDTH="50%" class="boxbg">
<tr bgcolor="#ffffff">
<td colspan=4>
                         <%--<asp:GridView id="DataGrid1" runat="server" AllowPaging="false" PageSize="1000" AutoGenerateColumns="False" CellPadding="1" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="1" Width="90%">
                        <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                        <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
			            <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                        <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                        <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" />--%>
                        
                         
                         <asp:GridView ID="GV_D" runat="server" align="center" HeaderStyle-CssClass="bgbluegrey" 
                                                         PagerStyle-HorizontalAlign="left" 
                                                         ShowFooter="True"
                                                       BackColor="white" 
                                                             CssClass="boxbg" FooterStyle-CssClass="boxbg" 
                                                            AutoGenerateColumns="False" SelectedIndex="1" >
                                                             
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
                                                                 
                                                                                                                                            
                                                                                    
                                                                                    
                                                                                     
                                                                                    
                                                                                     <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="Route/Tonnage->">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                                                                <asp:DropDownList  ID="ddRoute" runat="server" ></asp:DropDownList>
                                                   
                                                                                     </ItemTemplate>
                                    
                                                                           
                                    
                                                                                    </asp:TemplateField>
                                                                                      
                                                                                      <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="Min.">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                              
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtminchrgvar" Width="60" MaxLength="10" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                    <%-- <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                                Width="15px"></asp:Label>--%>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="Max.">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                              
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtmaxchrgvar" Width="60" MaxLength="10" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                    <%-- <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                                Width="15px"></asp:Label>--%>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                        
                                                                                    
                                                                                    <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="Slab 1 Rate">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                              
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtchrg1" Width="60" MaxLength="10" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                    <%-- <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                                Width="15px"></asp:Label>--%>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                     <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="Slab 2 Rate">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                              
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtchrg2" Width="60" MaxLength="10" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                    <%-- <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                                Width="15px"></asp:Label>--%>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                     <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="Slab 3 Rate">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                              
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtchrg3" Width="60" MaxLength="10" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                    <%-- <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                                Width="15px"></asp:Label>--%>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                     <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="Slab 4 Rate">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                              
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtchrg4" Width="60" MaxLength="10" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                    <%-- <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                                Width="15px"></asp:Label>--%>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    
                                                                                     <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="Slab 5 Rate">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                              
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtchrg5" Width="60" MaxLength="10" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                    <%-- <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                                Width="15px"></asp:Label>--%>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                     <asp:TemplateField HeaderStyle-Font-Bold="true"  HeaderText="Slab 6 Rate">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                              
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtchrg6" Width="60" MaxLength="10" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                    <%-- <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                                Width="15px"></asp:Label>--%>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                   
                                                                                    
                                                                                  <%--  <asp:TemplateField>
            <ItemTemplate>
                                    <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" 
                                        Text="X" OnClientClick="return confirm('Are you certain that you want to delete this record?');">
                                    </asp:LinkButton>
                                 </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" Wrap="False" />
            </asp:TemplateField>--%>
                                                                                   
                                                                                    
                                                                                   
                                                                                    
                                                                                    
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
            
</td>
</tr>

<tr bgcolor="#ffffff">

<td  align="center" colspan="4"><asp:Button ID="Submit" OnClick="Submit_Click"    runat="server" Text="Submit" TabIndex="9"  /></td>
</tr>

</table>
<!--END-->
					  </td>
                    </tr>
                   
                   
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table>
</asp:Content>

