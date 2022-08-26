<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Acct_Groups.ascx.cs" Inherits="Acct_Groups" %>
<script language="javascript" type="text/javascript">
Form_name="ctl00$MyCPH1$"
function Edit_code()
{
              
                var Groupcode= document.getElementById(Form_name+"TxtGroupcode").value;
				if(Groupcode=="")
				{
							alert("Please enter Group Code!!!");
							document.getElementById(Form_name+"TxtGroupcode").focus();
							return false;
				}			
				
			//alert("hi..")
               return  true; 
}
function Edit_code_2()
{
              
                var lastlevel= document.getElementById(Form_name+"lastlevel").value;
				//alert(lastlevel)
				var level_list_value=document.getElementById(Form_name+"Cmd_groupcode_"+lastlevel).value;
				if(level_list_value=="")
				{
				            alert("Please Select Level "+lastlevel+" Group Code !!!");
							document.getElementById(Form_name+"Cmd_groupcode_"+lastlevel).focus();
							return false;
				}
				
				
//							alert("Please enter Group Code!!!");
//							document.getElementById(Form_name+"TxtGroupcode").focus();
//							return false;
//						
//				
//alert("hi..")
//return false;
//               return  true; 
}

</script>
<div>
     <table border="0" cellpadding="0" cellspacing="0" align="left">
    <%-- <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>--%>

        <%--<tr> 
          <td align=right><a href="javascript:window.history.go(-1)" Title="back"><img src="../../images/back.gif" border=0></a></td>
        </tr>--%>
        <tr> 
          <td><img src="../../../images/clear.gif" width="15" height="10" /></td>
        </tr>
    
                   
        <tr>
        <td style="width: 435px">
          <atlas:UpdatePanel ID="state_docdetail" runat="server">
                <ContentTemplate>
        <table  border="0" cellpadding="1" cellspacing="1" class="boxbg"  align="Center" width="600" >
       
       <tr  bgcolor="#ffffff">
       <td align="Right" class="blackfnt" style="width: 626px" >Select Group Level 1 : &nbsp;&nbsp; </td>
        <td align="Left" class="blackfnt" valign="middle" style="width: 533px"  >  &nbsp;<asp:DropDownList ID="Cmd_groupcode_1" runat="server"  Width="3in"></asp:DropDownList>&nbsp;&nbsp; <asp:Button ID="malist_1" Text="Filter....." CssClass="blackfnt" Width="1in" runat="server" OnClick="Level1_Click" /> </td>
       </tr>
       
       <tr  bgcolor="#ffffff" id="level2" visible="false" runat="server">
       <td align="Right" class="blackfnt" style="width: 626px" >Select Group Level 2 : &nbsp;&nbsp; </td>
        <td align="Left" class="blackfnt" valign="middle" style="width: 533px"  >  &nbsp;<asp:DropDownList ID="Cmd_groupcode_2" runat="server"  Width="3in"></asp:DropDownList>&nbsp;&nbsp; <asp:Button ID="malist_2" Text="Filter....." CssClass="blackfnt" Width="1in" runat="server" OnClick="Level2_Click" /> </td>
       </tr>
       <tr  bgcolor="#ffffff" id="level3" visible="false" runat="server">
       <td align="Right" class="blackfnt" style="width: 626px" >Select Group Level 3 : &nbsp;&nbsp; </td>
        <td align="Left" class="blackfnt" valign="middle" style="width: 533px"  >  &nbsp;<asp:DropDownList ID="Cmd_groupcode_3" runat="server"  Width="3in"></asp:DropDownList>&nbsp;&nbsp; <asp:Button ID="malist_3" Text="Filter....." CssClass="blackfnt" Width="1in" runat="server" OnClick="Level3_Click" /> </td>
       </tr>
       <tr  bgcolor="#ffffff" id="level4" visible="false" runat="server">
       <td align="Right" class="blackfnt" style="width: 626px" >Select Group Level 4 : &nbsp;&nbsp; </td>
        <td align="Left" class="blackfnt" valign="middle" style="width: 533px"  >  &nbsp;<asp:DropDownList ID="Cmd_groupcode_4" runat="server"  Width="3in"></asp:DropDownList>&nbsp;&nbsp; </td>
       </tr>
       <tr bgcolor="#ffffff" > 
          <td colspan="2"><img src="../../../images/clear.gif" width="15" height="10" /></td>
        </tr>
     
       </table>
        </ContentTemplate>
                    <Triggers>
                             <atlas:ControlEventTrigger ControlID="malist_1"  EventName="Click"  />
                               <atlas:ControlEventTrigger ControlID="malist_2"  EventName="Click"  />
                                 <atlas:ControlEventTrigger ControlID="malist_2"  EventName="Click"  />
                   </Triggers>
              </atlas:UpdatePanel>
       </td>
        </tr>
        </table>
        </div>