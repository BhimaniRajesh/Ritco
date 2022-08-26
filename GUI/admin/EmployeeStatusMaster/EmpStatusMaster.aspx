<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="EmpStatusMaster.aspx.cs" Inherits="GUI_admin_EmployeeStatusMaster_EmpStatusMaster" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript">

 function checklocation(obj)
        {
        debugger
        var a;
        a=1;
        obj.value = obj.value.toUpperCase()
       for(i=0;i<str.length;i++)
       {

            if(obj.value==str[i])
            {
                a=2
                alert("Status Name Already Exist...")
          obj.focus();
            return false;
                break;
               
            }
            else
            {
                continue
            }
       }
//       if (a!=2)
//       {
//          alert("Status Name Already Exist...")
//          obj.focus();
//       }


}
        function IsText(sText)
         {
            var ValidChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ";
            var IsText=true;
            var Char;

            for (i = 0; i < sText.length && IsText == true; i++) 
            { 
            Char = sText.charAt(i); 

            if (ValidChars.indexOf(Char) == -1) 
            {
            IsText = false;
            }
            }

            return IsText;
         }
        function valCheck()
        {
            if(document.getElementById("ctl00_MyCPH1_txtEmpStatus"))
             {
                if(document.getElementById("ctl00_MyCPH1_txtEmpStatus").value == "")
                {
                    alert("Enter Employee Status Name");
                    document.getElementById("ctl00_MyCPH1_txtEmpStatus").focus();
                    return false;
                }
//                else if(IsText(document.getElementById("ctl00_MyCPH1_txtEmpStatus").value) == false)
//                {
//                    alert("Enter Employee Status Name in text format");
//                    document.getElementById("ctl00_MyCPH1_txtEmpStatus").focus();
//                    return false;
//                }
                else if(document.getElementById("ctl00_MyCPH1_lblErrorEmpStNm"))
                {
                    if(document.getElementById("ctl00_MyCPH1_lblErrorEmpStNm").style.display == '')
                    {
                        alert("Invalid 'Employee Status Name'");
                        document.getElementById("ctl00_MyCPH1_txtEmpStatus").focus();
                        return false;
                    }
                }
             }
             if(document.getElementById("ctl00_MyCPH1_ddRptLoc"))
                {
                    if(document.getElementById("ctl00_MyCPH1_ddRptLoc").value == "--Select--")
                    {
                        alert("Enter Reporting Location");
                        document.getElementById("ctl00_MyCPH1_ddRptLoc").focus();
                        return false;
                    }
                }
         }
</script>  

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
							<font class="bluefnt"><b>Employee Status Master</b></font>
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

<table border="0" cellpadding="3" bgcolor="#808080" cellspacing="1" align="center" class="boxbg" style="width: 67%">
    <tr class="bgbluegrey"> 
      <td  align="center" colspan="4"> 
        <p align="center"><font class="blackfnt"><b>Employee Status Master Screen</b></font></p>
      </td>
    </tr>

   <tr bgcolor="#FFFFFF"> 
      <td align="left" valign="top" style="width: 294px; height: 57px;"> <font class="blackfnt"> Employee Status Name :</td>
      <td align="left" valign="top">
          <asp:UpdatePanel ID="upLocationCode" runat="server">
                   <ContentTemplate>
                   
                    <%--OnTextChanged="txtEmpStatus_TextChanged" AutoPostBack="true"--%>
                        <asp:TextBox ID="txtEmpStatus" runat="server" onblur="return checklocation(this)" ></asp:TextBox>
                        <label class="blackfnt" id="lblErrorEmpStNm" runat="server" style="color: Red;" visible="false">
                                        &nbsp;<br />
                            Invalid Employee Status Name!!!
                        </label> 
                   </ContentTemplate>
                      <Triggers>
                          <asp:AsyncPostBackTrigger ControlID="txtEmpStatus"  EventName="TextChanged" />
                      </Triggers>
          </asp:UpdatePanel> 
       </td>          
        
       <td align="left" style="width: 259px; height: 57px" valign="top"> <font class="blackfnt">
           Active Flag :</td>
           <td align="left" style="width: 354px; height: 57px" valign="top">
            <asp:UpdatePanel ID="upChkActFlag" runat="server">
   	            <ContentTemplate> 
   		            <asp:CheckBox ID="chk1" runat="server" AutoPostBack="True" OnCheckedChanged="chk1_CheckedChanged"
                        Width="63px" Checked="True" />
                    <asp:TextBox ID="txtActFlag" runat="server" Width="40px">Y</asp:TextBox>&nbsp;
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="chk1" EventName="CheckedChanged" />
                </Triggers>
            </asp:UpdatePanel> 
       </td>
    </tr>
        
	<tr bgcolor="#FFFFFF"> 
		<td bgcolor="#FFFFFF" align="center" colspan="4" height="22">
		    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClientClick="return valCheck()" OnClick="btnSubmit_Click" />
            <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" />
        </td>
	</tr>
  </table>

 
</asp:Content>

