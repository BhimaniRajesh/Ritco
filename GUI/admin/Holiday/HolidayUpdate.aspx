<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="HolidayUpdate.aspx.cs" Inherits="GUI_admin_Holiday_HolidayUpdate" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript">
        function ValidateData()
            {
                if(document.getElementById("ctl00_MyCPH1_ddRg"))
                {
                    if(document.getElementById("ctl00_MyCPH1_ddRg").value == "-1")
                    {
                        alert("Select Region");
                        document.getElementById("ctl00_MyCPH1_ddRg").focus();
                        return false;
                    }
                }
                if(document.getElementById("ctl00_MyCPH1_txtDescription"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtDescription").value == "")
                    {
                        alert("Enter Holiday Description");
                        document.getElementById("ctl00_MyCPH1_txtDescription").focus();
                        return false;
                    }
                }
                if(document.getElementById("ctl00_MyCPH1_txtDate"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtDate").value == "")
                    {
                        alert("Enter Holiday Date");
                        document.getElementById("ctl00_MyCPH1_txtDate").focus();
                        return false;
                    }
                    else if(document.getElementById("ctl00_MyCPH1_RegularExpressionValidator7"))
                    {
                        if(document.getElementById("ctl00_MyCPH1_RegularExpressionValidator7").title == "Invalid Date") 
                        {
                            alert("Invalid Date");
                            document.getElementById("ctl00_MyCPH1_txtDate").focus();
                            return false;
                        }
                    }
                }                
                if(document.getElementById("ctl00_MyCPH1_txtActFlag"))
                {
                    if(document.getElementById("ctl00_MyCPH1_txtActFlag").value == "")
                    {
                        alert("Enter Active Flag");
                        document.getElementById("ctl00_MyCPH1_txtActFlag").focus();
                        return false;
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
          <td height="30"><a href=""><font class="blklnkund"><strong>Module</strong></font></a>
	        &gt; <a href=""><font class="blklnkund"><strong>Administrator </strong></font></a>
            &gt; <a href=""><font class="blklnkund"><strong>Others</strong></font></a>
		  <font class="bluefnt"><strong> &gt; 
		  Holiday Master</strong> </font></td>
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
                            <table align="center" border="0" cellpadding="5" cellspacing="1" width="100%" class="boxbg" style="height: 166px">
                            <tr class="bgbluegrey">
                            <td align="center"><font class="blackfnt"><b>HOLIDAY MASTER SCREEN</b></font></td>
                            </tr>
                            <tr>
                            <td bgcolor="#FFFFFF">    
                            <table border="0" cellspacing="0" width="100%" cellpadding="3">

                            <tr>
                            <td><font class="blackfnt">Holiday Region</font></td>
                            <td><font class="blackfnt">: 
                                <asp:DropDownList ID="ddRg" runat="server" CssClass="input">
                                </asp:DropDownList></font></td>

                            <td><font class="blackfnt">Holiday Date</font></td>
                            <td><font class="blackfnt">: 
                                <asp:TextBox ID="txtDate" runat="server" Width="124px"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="txtDate"
                                    ErrorMessage="Invalid Date" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                    ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator></font></td>

                            </tr>

                            <tr>
                            <td align="left" valign="top"><font class="blackfnt">Holiday Description</font></td>
                            <td align="left" valign="top"><font class="blackfnt">: 
                                <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox></font></td>
                            <td align="left" valign="top"><font class="blackfnt">Active Flag</font></td>
                            <td align="left" valign="top"><font class="blackfnt">: 
                                <asp:UpdatePanel ID="upChkActFlag" runat="server">
                                    <ContentTemplate>
                                        <asp:CheckBox ID="chk" runat="server" AutoPostBack="true" OnCheckedChanged="chk_CheckedChanged" Checked="True" />
                                        <asp:TextBox ID="txtActFlag" runat="server" ReadOnly="True" Width="17px">Y</asp:TextBox>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="chk" EventName="CheckedChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </font>
                            </td>
                            </tr>
                            </table>

                            </td>
                            </tr>
                            </table>
                            <br />

                            <table border="0" cellspacing="2" cellpadding="4" width="50%" align="center">
                            <tr>
                            <%--<br />--%>
                            <td align="right">
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClientClick="return ValidateData()" OnClick="btnSubmit_Click" /></td>
                            <td>
                                &nbsp;<asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" /></td>
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

