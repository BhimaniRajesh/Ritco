<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="CityEdSelect.aspx.cs" Inherits="GUI_admin_CityMaster_CityEdSelect" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
       
        function nwOpenCity(mNo)
        {
            window.open("popupCity.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
    </script>

    
        <div>
 <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height: 50px">
		<tr> 
			<td> 
				<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
					<tr> 
						<td height="30">
							<a href=""><font class="blklnkund"><b>Module</b></font></a>
							<b> &gt; </b>
							<a href=""><font class="blklnkund"><b>Administrator</b></font></a>
							<b> &gt; </b>
							<a href=""><font class="blklnkund"><b>Company Structure</b></font></a>
							<b> &gt; </b>
							<font class="bluefnt"><b>City Master</b></font>
						</td>
					</tr>
				        
					<tr> 
						<td class="horzblue"><img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
					</tr>
					
					<tr> 
						<td><img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
					</tr>

					<tr> 
						<td align="right" style="height: 33px">
							<a href="javascript:window.history.go(-1)"  title="back"><img src="../../images/back.gif" border="0" alt="" /></a>
						</td>
					</tr>
			   </table>
	      </td>      
	   </tr> 
 </table>
 
     <center>
         <table border="0" cellpadding="3" bgcolor="#808080" cellspacing="1" class="boxbg" style="width: 403px">   
               <tr class="bgbluegrey"> 
                    <td  align="center" colspan="2"> 
                        <p align="center"><font class="blackfnt"><b>Select City for Edit</b></font></p>
                    </td>
                </tr>
               
               <tr bgcolor="#FFFFFF">
		            <td align="right" valign="top" style="width: 109px; height: 19px"><font class="blackfnt">Enter City:</font></td>
		            <td align="left" style="width: 107px; height: 19px" valign="top">
                        <asp:TextBox ID="TextBox6" runat="server" TabIndex="8" Width="94px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox><asp:Label ID="Label5" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpenCity(1)">...</a>'
                            Width="14px"></asp:Label></td>
               </tr>
              
               <tr bgcolor="#FFFFFF" > 
                    <td bgcolor="#FFFFFF" align="center" colspan="2" valign="middle" style="height: 7px">
                        <table style="width: 179px">
                            <tr>
                                <td>
                                <%--<asp:UpdatePanel ID="upBtns1" runat="server">
   	                                <ContentTemplate>--%>
                                        <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click" />
                                    <%--</ContentTemplate>
                                    <Triggers>
	                                    <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />    
	                                </Triggers> 
                                </asp:UpdatePanel> --%>
                                </td>
                                <td>
                                <%--<asp:UpdatePanel ID="upBtns2" runat="server">
   	                                <ContentTemplate> --%>   
                                        <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click" />
                                    <%--</ContentTemplate>
                                    <Triggers>
	                                    <asp:AsyncPostBackTrigger ControlID="btnEdit" EventName="Click" />    
	                                </Triggers>
                                </asp:UpdatePanel> --%> 
                                </td>
                                
                              </tr>
                        </table>
		                                   
                   </td>   
	               
	           </tr>
	          
	      </table>
	   </center>   
	      
	   </div> 
</asp:Content>

