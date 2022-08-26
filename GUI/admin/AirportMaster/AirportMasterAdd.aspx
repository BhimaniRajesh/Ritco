<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="AirportMasterAdd.aspx.cs" Inherits="GUI_admin_AirportMaster_AirportMasterAdd" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
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
    
    function abc(val)
    {
       //debugger
       val.value = val.value.toUpperCase()
       for(i=0;i<str.length;i++)
       {
            if(val.value==str[i])
            {
                alert("Name already exists !!!")
                val.focus()
                break;
            }

       }
     
    }

    
    function ValidateData()
    {
               if(document.getElementById("ctl00_MyCPH1_txtAirportCity"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAirportCity").value == "")
                    {
                        alert("Enter Airport City");
                        document.getElementById("ctl00_MyCPH1_txtAirportCity").focus();
                        return false;
                    }
//                    else if(IsText(document.getElementById("ctl00_MyCPH1_txtAirportCity").value) == false)
//                    {
//                        alert("Enter Airport City in text format");
//                        document.getElementById("ctl00_MyCPH1_txtAirportCity").focus();
//                        return false;
//                    }
                    else if(document.getElementById("ctl00_MyCPH1_lblErrorLocation"))
                    {
                        if(document.getElementById("ctl00_MyCPH1_lblErrorLocation").style.display == '')
                        {
                            alert("Duplicate 'Airport City'");
                            document.getElementById("ctl00_MyCPH1_txtAirportCity").focus();
                            return false;
                        }
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
      <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
    	<tr> 
          <td height="30"><a ><font class="blklnkund"><strong>Module</strong></font></a>
	        &gt; <a><font class="blklnkund"><strong>Administrator </strong></font></a>
            &gt; <a href="../company_structure.aspx"><font class="blklnkund"><strong>Company Structure</strong></font></a>
		    <font class="bluefnt"><strong> &gt; Add Airport Master</strong> </font></td>
        </tr>
        <tr> 
          <td class="horzblue"><img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
        </tr>
        <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
        </tr>

        <tr> 
          <td align="right"><a href="javascript:window.history.go(-1)" title="back"><img src="../../images/back.gif" border="0" alt="" /></a></td>
        </tr>
        
        <tr> 
          <td><br /><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="39%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="300" valign="top">
					  <!--START--> 
                      <table width="95%" border="0" cellspacing="1" cellpadding="3" align="center" class="boxbg">
                        <tr class="bgbluegrey"> 
                          <td colspan="2"> 
                            <div align="center"><font class="blackfnt"><b>Add Airport Master</b></font></div>
                          </td>
                        </tr>
                        <tr>
                          <td colspan="2" bgcolor="#FFFFFF">
                     <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
                        <tr> 
                          <td width="116" nowrap> 
                            <div align="left"><b><font class="blackfnt">Airport Code</font></b></div>
                          </td>
                          <td width="440"><font class="blackfnt">
                              <asp:Label ID="lblCode" runat="server"></asp:Label></font></td>
                        </tr>
                        <tr> 
                          <td width="116" nowrap><div align="left"><b><font class="blackfnt">Airport City</font></b></div>
                          </td>
                          <td width="440"> 
                            <div align="left">
                                <asp:UpdatePanel ID="upLocationCode" runat="server">
                                    <ContentTemplate>
                                        <asp:TextBox ID="txtAirportCity" runat="server" onblur="abc(this)" Width="289px"></asp:TextBox>
                                        <%--OnTextChanged="txtAirportCity_TextChanged" AutoPostBack="true"--%>
                                      
                                        <label class="blackfnt" id="lblErrorLocation" runat="server" style="color: Red;" visible="false">
                                               Invalid City! </label>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="txtAirportCity" EventName="TextChanged" />
                                        </Triggers>
                                </asp:UpdatePanel>                
                            </div>
                          </td>
                        </tr>
                        <tr> 
                          <td colspan="2" height="22"> 
                            <div align="right">
                                <asp:Button ID="btnListing" runat="server" Text="Go to for Listing" OnClick="btnListing_Click" />
                                <asp:Button ID="btnSave" runat="server" OnClientClick="return ValidateData()" OnClick="btnSave_Click" Text="Save" /></div>
                          </td>
                        </tr>
                     </table>
	                </td>
                    </tr>
                 </table>
  					  <!--END-->
					  </td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table>
    </td>
  </tr>
</table>    
</asp:Content>

