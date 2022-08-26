<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="vendorContract_longhaulroad_trip_City.aspx.cs" Inherits="GUI_admin_Vendor_contract_vendorContract_longhaulroad_trip_City" %>

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
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
    	<tr> 
          <td height="30"><font class="blklnkund"><strong> Module</strong></font>
          
		<strong> &gt; </strong><font class="blklnkund"><strong>Administrator </strong></font>

<strong> &gt; </strong> <font class="blklnkund"><strong>Finance & Accounts</strong></font>

<strong> &gt; </strong> <font class="blklnkund"><strong>Vendor Contract Master </strong></font>

<font class="bluefnt"><strong> &gt; </strong>
		  <strong>Charge Matrices : Long haul-road- Per Trip(City Wise Route Matrix) basis  </strong> </font></td>
        </tr>
        <tr> 
          <td class="horzblue"></td>
        </tr>
        <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>

   
        
        <tr> 
          <td align="right"><img src="../../images/back.gif" border="0" ></td>
        </tr>
                    <tr> 
                      <td  valign="top">
				

<table align="center" border="0" cellpadding="7" cellspacing="1" width="95%" class="boxbg">
 
<tr class="bgbluegrey">
<td colspan="3" align="center"><font class="blackfnt"><b>VENDOR CONTRACT MASTER </b></font></td>
</tr>
<tr>
<td bgcolor="#FFFFFF">
<table  border="0"align="center" cellspacing="1" cellpadding=6 WIDTH="100%" class="boxbg">
<tr >
<td colspan=4 class="bgbluegrey"><font class=blackfnt><strong><U>Step : 3</U>&nbsp;&nbsp;&nbsp;&nbsp<b>Charge Matrices : Long haul-road- Per Trip(City Wise Route Matrix) basis </b> </strong></font></td>
</tr><tr >
<td colspan=4 bgcolor="#ffffff">
<table  border="0" align="center" cellspacing="1" cellpadding=6 WIDTH="100%" class="boxbg">
<tr bgcolor="#ffffff">
<td width="25%" nowrap><font class="blackfnt">Additional weight charges Rs. /Kg.</font></td>
<td width="25%"><font class="blackfnt" >
    <asp:TextBox ID="txtaddwtchrg" runat="server" Width="48px"></asp:TextBox></font></td>
</tr>  
</table>

<br />
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
                     <table  border=0 align=center cellSpacing=1 cellpadding=6 WIDTH="50%" class="boxbg">
<tr class="bgbluegrey">
<td colspan=4><font class=blackfnt><strong><U></U>&nbsp;&nbsp;&nbsp;&nbsp<b>Select Charge Matrices</b> </strong></font></td>
</tr><tr bgcolor="#ffffff">
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
                                                                                      
                                                                                        <asp:TemplateField HeaderText="">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <HeaderTemplate > <asp:DropDownList  ID="ddVehtype" runat="server" ></asp:DropDownList>
                                                   
                                                                                    </HeaderTemplate>
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtchrg" Width="60" MaxLength="10" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                    <%-- <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                                Width="15px"></asp:Label>--%>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    <asp:TemplateField HeaderText="">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <HeaderTemplate > <asp:DropDownList  ID="ddVehtype1" runat="server" ></asp:DropDownList>
                                                   
                                                                                    </HeaderTemplate>
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtchrg1" Width="60" MaxLength="10" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                    <%-- <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                                Width="15px"></asp:Label>--%>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    <asp:TemplateField HeaderText="">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <HeaderTemplate > <asp:DropDownList  ID="ddVehtype2" runat="server" ></asp:DropDownList>
                                                   
                                                                                    </HeaderTemplate>
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtchrg2" Width="60" MaxLength="10" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                    <%-- <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                                Width="15px"></asp:Label>--%>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    <asp:TemplateField HeaderText="">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <HeaderTemplate > <asp:DropDownList  ID="ddVehtype3" runat="server" ></asp:DropDownList>
                                                   
                                                                                    </HeaderTemplate>
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtchrg3" Width="60" MaxLength="10" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
                                                                                    <%-- <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Height="1px" Text='<a href="javascript:nwOpen(1)">...</a>'
                                                                Width="15px"></asp:Label>--%>
                                    
                                                                                    </ItemTemplate>
                                    
                                                                                    </asp:TemplateField>
                                                                                    
                                                                                    <asp:TemplateField HeaderText="">
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                                <HeaderTemplate > <asp:DropDownList  ID="ddVehtype4" runat="server" ></asp:DropDownList>
                                                   
                                                                                    </HeaderTemplate>
                                                                                <ItemStyle CssClass="blackfnt" />
                                                                                <ItemTemplate>
                                    
                                                                                      <asp:TextBox ID="txtchrg4" Width="60" MaxLength="10" runat="server" BorderStyle="Groove" Columns="8"   ></asp:TextBox>
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
            
              <br />
                 
                  <center>
           </center>

</td>
</tr>
</table>
<br />
                 
<div id="divlonghaulroad_km_variable1"  align="center" >  <asp:Button  ID="Submit"  OnClick="Submit_Click"   runat="server" Text="Submit" TabIndex="9"  /></div>

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
