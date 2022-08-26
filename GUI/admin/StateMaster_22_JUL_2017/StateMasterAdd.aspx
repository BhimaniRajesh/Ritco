<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="StateMasterAdd.aspx.cs" Inherits="GUI_admin_StateMaster_StateMasterAdd" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
 
 function ch()
{
// debugger
  
  var grid=document.getElementById("ctl00_MyCPH1_GV_D");
  var rows=grid.rows.length;      // "ctl00$MyCPH1$GV_D"
  var arrstr="";
  var q ="n";
  for(var b=2;b<=rows;b++)
  {
        var c="";
        var c2="";
        var t="";
        var t2="";
        var d="";
        
        if(b<10)
        {
            c="ctl00_MyCPH1_GV_D_ctl0" + b + "_chksrno";
          c2="ctl00_MyCPH1_GV_D_ctl0" + b + "_actch";
            t="ctl00_MyCPH1_GV_D_ctl0" + b + "_txtch";
            
             t2="ctl00_MyCPH1_GV_D_ctl0" + b + "_txtdoc";
            d="ctl00_MyCPH1_GV_D_ctl0" + b + "_ddBound1";
            
        }
        else
        {
            c="ctl00_MyCPH1_GV_D_ctl" + b + "_chksrno";
            c2="ctl00_MyCPH1_GV_D_ctl" + b + "_actch";
            t="ctl00_MyCPH1_GV_D_ctl" + b + "_txtch";
            
             t2="ctl00_MyCPH1_GV_D_ctl" + b + "_txtdoc";
            d="ctl00_MyCPH1_GV_D_ctl" + b + "_ddBound1";
            
        }
        
 
        var tb1=document.getElementById(c);
        var tb2=document.getElementById(c2);
        var tb3=document.getElementById(t);
        
        var tb4=document.getElementById(t2);
        var tb5=document.getElementById(d);
        
 
  
      if(tb1.checked == true)
        {
            q="y"
           
            if(tb4.value=="")
            {
                alert("Document Name Can not ne Blanck....")
                tb4.focus();
                return false;
            }
 
            if(tb5.value=="N")
            {
                alert("Please Select I/O Bound")
                tb5.focus();
                return false;
                
            }
            
              
            
            //return true;
        }
         
        

   } // END OF for

       if(q == "n")
        {
            alert("Please Select Atleast One....")
            return false;
        }
   
     return true;
 
}
 
 function validateData()
 {
//    if(document.getElementById("ctl00_MyCPH1_txtStateName"))
//        {
             if(document.getElementById("ctl00_MyCPH1_txtStateName").value == "")
            {
                alert("Enter State");
                document.getElementById("ctl00_MyCPH1_txtStateName").focus();
                return false;
            }
            
            if(ch() == false)
            {
            return false;
            }
//             else if(document.getElementById("ctl00_MyCPH1_lblErrorState"))
//            {
//                if(document.getElementById("ctl00_MyCPH1_lblErrorState").style.display == '')
//                {
//                    alert("Invalid 'State'");
//                    document.getElementById("ctl00_MyCPH1_txtStateName").focus();
//                    return false;
//                }
//            } 
      //  }
 }
 
 
 
 var City_str="<%=City_str%>"
var Stateid="<%=Stateid%>"
function Citycheck(obj)
{
   // alert(loccodeval)
   //alert(cityid)
       if (obj.value!="")
        {
            if(obj.value.length<3)
  			    {
  				    alert("Invalid State Name Length")
  				    obj.focus();
				    return false;
  			    }
  			    if(Stateid=="")
  			    {
                    if(City_str.indexOf(obj.value)!=-1 )
  			        {
  				        alert("State Name Already Exist")
  				        obj.focus();
				        return false;
  			        }
  			     }
  			     else
  			     {
  			        if(Stateid!=obj.value)
  			        {
  			             if(City_str.indexOf(obj.value)!=-1 )
  			                {
  				                alert("State Name Already Exist")
  				                obj.focus();
				                return false;
  			                }
  			        }
  			     }
  	    }
}

 function IsNumericWoDot(obj)
    {
 
       var ValidChars = "0123456789";
       var IsNumber=true;
       var Char;
       var sText=obj.value;

       for (i = 0; i < sText.length && IsNumber == true; i++) 
       { 
          Char = sText.charAt(i); 
          
          if (ValidChars.indexOf(Char) == -1) 
          {
          alert("Only Numbers are allowed....")
          obj.focus();
           return  false;
          }
       }
       
       return true;
    }
    
</script>  


<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<tr> 
			<td>&nbsp;</td>
		</tr>

		<tr> 
			<td> 
				<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
					<tr> 
						<td height="30"><font class="blackfnt"><strong>Masters
              Module</strong></font>
              <font class="bluefnt"><strong> &gt;State Master</strong> </font></td>
					</tr>
				        
					<tr> 
						<td class="horzblue"></td>
					</tr>
					

					<tr> 
						<td align="right">
							<a href="javascript:window.history.go(-1)" title="back"></a>
						</td>
					</tr>

					<tr> 
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr> 
									<td width="39%" valign="top" align="center">
										<table border="0" cellspacing="0" cellpadding="0" style="width: 76%">
										<tr> 
											<td valign="top" style="width: 659px">
											<!--START-->
												<br />
												<center>
                                                    <table border="0" class="boxbg" cellspacing="1" cellpadding="1" width="100%">
                                                        <tr class="bgbluegrey" >
                                                        <td align="center" colspan="4"><font class="blackfnt"><b>State Master Header</b></font></td>
                                                        </tr>

                                                        <tr bgcolor="#ffffff">
                                                        <td align="center">
                                                        <font class="blackfnt">State Code :</font>
                                                        </td>

                                                        <td align="center"><font class="blackfnt" color="#FF0000">
                                                        System Generated...
                                                        </font>
                                                        
                                                        </td>

                                                        <td align="center">
                                                        <font class="blackfnt">State Name :</font>
                                                        </td>


                                                        <td align="center">
                                                        <asp:UpdatePanel ID="upState" runat="server">
                                                            <ContentTemplate>
                                                                <asp:TextBox ID="txtStateName" runat="server" CssClass="input" AutoPostBack="true" ></asp:TextBox>
                                                                <ajaxToolkit:AutoCompleteExtender ID="Extender1" runat="server" Enabled="True" MinimumPrefixLength="1" ServiceMethod="GetStateList" ServicePath="../../../GUI/services/WebService.asmx" TargetControlID="txtStateName" ></ajaxToolkit:AutoCompleteExtender>

                                                                <label class="blackfnt" id="lblErrorState" runat="server" style="color: Red;" visible="false">Invalid State!!!
                                                                </label>
                                                            </ContentTemplate>
                                                            <Triggers>
                                                                <asp:AsyncPostBackTrigger ControlID="txtStateName" EventName="TextChanged" />
                                                            </Triggers>
                                                        </asp:UpdatePanel>           
                                                        </td>
                                                        </tr>
                                                        </table>
                                                        
                                                        <br />
                                                        
                                                        <table border="0" class="boxbg" cellspacing="1" cellpadding="1" width="100%">
                                                        <tr class="bgbluegrey" >
                                                        <td align="center" ><font class="blackfnt"><b>State Master Detail</b></font></td>
                                                        </tr>

                                                        <tr align="center" bgcolor="#FFFFFF" >
                                                        <td align="center" >
                                                         <asp:UpdatePanel ID="DataGrid2_Update" runat="server"  UpdateMode="Always" RenderMode="Inline">
                 <ContentTemplate>
    &nbsp;<br />
                    <center>
                         <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="40%"  align="center">
           
            <tr align="center" bgcolor="white">
               <td align="center" style="width: 296px" ><font class="blackfnt">
                   Enter Row No *</font></td><td style="width: 121px" >
                   <asp:TextBox ID="roww" runat="server" Width="40px"  MaxLength="2" BorderStyle="Groove" AutoPostBack="True" OnTextChanged="roww_TextChanged" TabIndex="25" ></asp:TextBox></td>
             </tr>
         </table>
         <br /> 
                        </center>
                    
                     <center>
                                             
                         
                         <asp:GridView ID="GV_D" runat="server" align="center" HeaderStyle-CssClass="bgbluegrey" 
                                                         PagerStyle-HorizontalAlign="center" 
                                                       
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
                                                                 <asp:CheckBox ID="chksrno" runat="server"  />
                                                                 </ItemTemplate>
                                                                 </asp:TemplateField>
                                                                                                 
                                                                 
                                                                  <asp:TemplateField HeaderText="Document Name" >
                                                                                <HeaderStyle HorizontalAlign="Center" Wrap="True"  Width="100px" CssClass="blackfnt" />
                                                                                <ItemStyle CssClass="blackfnt" Width="150px" />
                                                                                <ItemTemplate>
                                                                                     <asp:TextBox ID="txtDoc" runat="server" BorderStyle="Groove" ></asp:TextBox>
                                                                                             
                                                                                </ItemTemplate>
                                                                   </asp:TemplateField>
                                                            
                                                            
                                                                  <asp:TemplateField HeaderText="InBound/OutBound.">
                                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                       <ItemStyle CssClass="blackfnt" />
                                                                           <ItemTemplate>
                                                                                <asp:DropDownList ID="ddBound1" runat="server" Height="22px" Width="84px">
                                                                                     
                                                                                     <asp:ListItem Value="N">--Select--</asp:ListItem>
                                                                                    <asp:ListItem Value="I">InBound</asp:ListItem>
                                                                                    <asp:ListItem Value="O">OutBound</asp:ListItem>
                                                                                </asp:DropDownList>
                                                                           </ItemTemplate>
                                                                  </asp:TemplateField>
                                                                                    
                                                                                    
                                                                 <asp:TemplateField HeaderText="Active">
                                                                   <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                     <ItemStyle CssClass="blackfnt" />
                                                                        <ItemTemplate>
                                                                          <asp:CheckBox ID="chk11"   runat="server" OnCheckedChanged="chk11_CheckedChanged" AutoPostBack="True" />
                                                                          <asp:TextBox ID="txtActive" runat="server" Width="22px">N</asp:TextBox>
                                                                        </ItemTemplate>
                                                                 </asp:TemplateField>
                                                                                    
                            </Columns>
                                                                                    
                             <FooterStyle CssClass="bgbluegrey"   />
                             <HeaderStyle CssClass="bgbluegrey" />
                   </asp:GridView>
                                                                                   
                                                                                    
                                                                                    
                                                                 
                                                                          




				        
				     
				      
                         </center>
              </ContentTemplate>   
              <Triggers>
                <asp:AsyncPostBackTrigger ControlID="roww" EventName="TextChanged" />
              </Triggers>
        
               
            </asp:UpdatePanel>
            </td>
                                                        </tr>
                                                        
                                                        </table>
												</center>
											<!--END-->
											</td>
										</tr>

										<tr> 
											<td style="width: 659px">&nbsp;<br /><asp:Button ID="txtUpdtState" runat="server" Text="Add To State Master" OnClick="txtUpdtState_Click" /></td>
										</tr>
										
										<tr>
											<td style="width: 659px"></td>
										</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
			</table>
	</td>
	</tr>
	</table>		

</asp:Content>

