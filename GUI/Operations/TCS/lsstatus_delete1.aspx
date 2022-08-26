<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="lsstatus_delete1.aspx.cs" Inherits="GUI_Operations_TCS_lsstatus_delete1" %>

<%@ OutputCache Location="None" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

     <script language="javascript" type="text/javascript">
     
     
     </script>
<br />
     <asp:Panel ID="p1" runat="server" Visible="false">
     <table border="1" cellspacing="0" cellpadding="2" width="85%" align="center" class="bglightblue">
   					       <tr><td align="center" class="bgbluegrey"><font class="blackfnt" color="red"><b>ERROR !!!</b></font>
   					       
   					       </td></tr>
						  <tr><td><br />
						   <p align="center"><font class="blackfnt" color="red"><%=errMsg%></font>
						   <br /><font class="blackfnt"><a href="javascript:window.history.go(-1)"><u>Click here for return to previous screen</u></a></p>
						   </td>
						  </tr>
						 </table>
     </asp:Panel>
     
     <asp:Panel ID="p2" runat="server" Visible="false">
     
     <p align="center"><font class="bluefnt"><b>Loading Sheet No. : <%=lsno%> has been deleted successfully .</b></font>
					     <br /><br /><a href="./lsstatus_delete.aspx"><font class="blackfnt"><b><u>Click here to delete more Loading Sheet(s)</u></b></font></a>
					     <p>
     
     </asp:Panel>
     </asp:Content>
