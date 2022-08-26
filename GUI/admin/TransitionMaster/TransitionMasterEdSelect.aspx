<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="TransitionMasterEdSelect.aspx.cs" Inherits="GUI_admin_TransitionMaster_TransitionMasterEdSelect" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript">
    function nwOpen(mNo) {
			
            window.open("popupbranch.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
   function IsText(sText)
    {
       var ValidChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
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
        
    
//            if(document.getElementById("ctl00_MyCPH1_txtTransLocCod").value == "" && document.getElementById("ctl00_MyCPH1_txtOrgnBranch").value == "")
//            {
//               if(document.getElementById("ctl00_MyCPH1_txtTransLocCod").value == "")
//               { 
//                alert("Enter Transition Location Code");
//                document.getElementById("ctl00_MyCPH1_txtTransLocCod").focus();
//                return false;
//                }            
//                else if(IsText(document.getElementById("ctl00_MyCPH1_txtTransLocCod").value) == false)
//                {
//                alert("Enter Location Code in text format");
//                document.getElementById("ctl00_MyCPH1_txtTransLocCod").focus();
//                return false;
//                }
//             }
//            else if(document.getElementById("ctl00_MyCPH1_txtTransLocCod").value == "" && document.getElementById("ctl00_MyCPH1_txtOrgnBranch").value != "")
//            {
//                  if(IsText(document.getElementById("ctl00_MyCPH1_txtOrgnBranch").value) == false) 
//                  { 
//                    alert("Enter Origin Branch in text format");
//                    document.getElementById("ctl00_MyCPH1_txtOrgnBranch").focus();
//                    return false;
//                  }
//                  
//                  if(document.getElementById("ctl00_MyCPH1_txtDestBranch").value == "")
//                  {
//                    alert("Enter Destination Branch Code");
//                    document.getElementById("ctl00_MyCPH1_txtDestBranch").focus();
//                    return false;
//                  }
//                  else if(if(IsText(document.getElementById("ctl00_MyCPH1_txtDestBranch").value) == false)   
//                  {
//                    alert("Enter Destination Branch in text format");
//                    document.getElementById("ctl00_MyCPH1_txtDestBranch").focus();
//                    return false;
//                  }
//            }
//    }

function chkVal()
 {

        if(document.getElementById("ctl00_MyCPH1_txtTransLocCod").value == "" && document.getElementById("ctl00_MyCPH1_txtOrgnBranch").value == "" && document.getElementById("ctl00_MyCPH1_txtDestBranch").value == "")
        {
             if(document.getElementById("ctl00_MyCPH1_txtTransLocCod"))
              {   
                    if(document.getElementById("ctl00_MyCPH1_txtTransLocCod").value == "")
                    {  
                        alert("Please fill Location Code OR Origin Branch");
                        document.getElementById("ctl00_MyCPH1_txtTransLocCod").focus();
                        return false;
                    }
                    else if(IsText(document.getElementById("ctl00_MyCPH1_txtTransLocCod").value) == false)
                    {
                        alert("Enter Location Code in text format");
                        document.getElementById("ctl00_MyCPH1_txtTransLocCod").focus();
                        return false;
                    }
              } 
        }
        else if(document.getElementById("ctl00_MyCPH1_txtTransLocCod").value == "" && document.getElementById("ctl00_MyCPH1_txtOrgnBranch").value != "" && document.getElementById("ctl00_MyCPH1_txtDestBranch").value == "")
        {
              if(document.getElementById("ctl00_MyCPH1_txtOrgnBranch"))
               {
                   if(IsText(document.getElementById("ctl00_MyCPH1_txtOrgnBranch").value) == false)
                    {              
                      alert("Enter Origin Branch in text format");
                      document.getElementById("ctl00_MyCPH1_txtOrgnBranch").focus();
                      return false;
                    }
                } 
              if(document.getElementById("ctl00_MyCPH1_txtDestBranch"))
                {   
                   if(document.getElementById("ctl00_MyCPH1_txtDestBranch").value == "")
                    {
                      alert("Please fill Destination Branch");
                      document.getElementById("ctl00_MyCPH1_txtDestBranch").focus();
                      return false;
                    }
                   else if(IsText(document.getElementById("ctl00_MyCPH1_txtDestBranch").value) == false)
                    {
                        alert("Enter Destination Branch in text format");
                        document.getElementById("ctl00_MyCPH1_txtDestBranch").focus();
                        return false;
                    } 
                }
        }
        else if(document.getElementById("ctl00_MyCPH1_txtTransLocCod").value == "" && document.getElementById("ctl00_MyCPH1_txtOrgnBranch").value == "" && document.getElementById("ctl00_MyCPH1_txtDestBranch").value != "")
        {
        
              if(document.getElementById("ctl00_MyCPH1_txtDestBranch"))
                   {
                       if(IsText(document.getElementById("ctl00_MyCPH1_txtDestBranch").value) == false)
                        {              
                          alert("Enter Destination Branch in text format");
                          document.getElementById("ctl00_MyCPH1_txtDestBranch").focus();
                          return false;
                        }
                    } 
              if(document.getElementById("ctl00_MyCPH1_txtOrgnBranch"))
                    {   
                       if(document.getElementById("ctl00_MyCPH1_txtOrgnBranch").value == "")
                        {
                          alert("Please fill Origin Branch");
                          document.getElementById("ctl00_MyCPH1_txtOrgnBranch").focus();
                          return false;
                        }
                       else if(IsText(document.getElementById("ctl00_MyCPH1_txtOrgnBranch").value) == false)
                        {
                            alert("Enter Destination Branch in text format");
                            document.getElementById("ctl00_MyCPH1_txtOrgnBranch").focus();
                            return false;
                        } 
                    }

         }
        else
        {
            return true;
        }
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
						<td height="30" align="left">
							<a href=""><font class="blklnkund"><b>Module</b></font></a>
							<b> &gt; </b>
							<a href=""><font class="blklnkund"><b>Administrator</b></font></a>
							<b> &gt; </b>
							<a href=""><font class="blklnkund"><b>Operations</b></font></a>
							<b> &gt; </b>
							<font class="bluefnt"><b>Transition Master</b></font>
						</td>
					</tr>
				        
					<tr> 
						<td class="horzblue"><img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
					</tr>
					
					<tr> 
						<td style="height: 13px"><img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
					</tr>

					<tr> 
						<td align="right">
							<a href="javascript:window.history.go(-1)" title="back"><img src="../../images/back.gif" border="0" alt="" /></a>
						</td>
					</tr>
					
					<tr>
					    <td>
					    
					        <center>
					        <table border="0" class="boxbg" cellspacing="1" cellpadding="2" width="70%">
		                        <tr class="bgbluegrey">
			                        <td align="center" colspan="2">
				                        <font class="blackfnt"><b>Query Transition Master for Edit</b></font>
			                        </td>
		                        </tr>
                        	
		                        <tr bgcolor="#FFFFFF">
			                        <td align="left" style="width: 36%">
				                        <font class="blackfnt">Location Code in the Transition:</font>
			                        </td>

			                        <td align="left">
                                        <asp:TextBox ID="txtTransLocCod" runat="server" Width="73px"></asp:TextBox>
                                        <asp:Label ID="Label1" runat="server" BorderStyle="Groove" Height="1px"  Width="15px"><a href="javascript:nwOpen('ctl00_MyCPH1_txtTransLocCod')">...</a>
                                           </asp:Label></td>
		                        </tr>

		                        <tr bgcolor="#FFFFFF">
			                        <td align="center" colspan="2">
				                        <font class="blackfnt"><b>OR</b></font>
			                        </td>
		                        </tr>

		                        <tr bgcolor="#FFFFFF">
			                        <td align="left" style="width: 36%">
				                        <font class="blackfnt">Origin Branch:</font>
			                        </td>

			                        <td align="left">
                                        <asp:TextBox ID="txtOrgnBranch" runat="server" Width="73px"></asp:TextBox>
                                        <asp:Label ID="Label2" runat="server" BorderStyle="Groove" Height="1px"  Width="15px"><a href="javascript:nwOpen('ctl00_MyCPH1_txtOrgnBranch')">...</a>
                                           </asp:Label></td>
		                        </tr>

		                        <tr bgcolor="#FFFFFF">
			                        <td align="left" style="width: 36%">
				                        <font class="blackfnt">Destination Branch:</font>
			                        </td>

			                        <td align="left">
                                        <asp:TextBox ID="txtDestBranch" runat="server" Width="73px"></asp:TextBox>
                                        <asp:Label ID="Label3" runat="server" BorderStyle="Groove" Height="1px"  Width="15px"> <a href="javascript:nwOpen('ctl00_MyCPH1_txtDestBranch')">..</a>
                                          </asp:Label></td>
		                        </tr>

		                        <%--</tr>--%>

		                        <tr bgcolor="#FFFFFF">
			                        <td align="center" colspan="2">
                                        <asp:Button ID="btnSubmit" runat="server" OnClientClick="return chkVal()"   OnClick="btnSubmit_Click" Text="Submit" /></td>
		                        </tr>
	                        </table>
	                        </center>

					    </td>
					</tr>
					
				</table> 
				
			</td> 
			
		</tr> 
		
	</table> 				

</asp:Content>
