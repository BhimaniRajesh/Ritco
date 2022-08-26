<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master" CodeFile="prestart_rep.aspx.cs" Inherits="GUI_UNI_MIS_accounts_mis_ledger_prestart" %>
<%@ Reference Control="~/GUI/DateSelector.ascx" %>
<%@Register TagPrefix="SControls" TagName="DateSelector" src="~/GUI/DateSelector.ascx" %>
<%@ Reference Control="~/GUI/DateSelectorTo.ascx" %>
<%@Register TagPrefix="SControlsTo" TagName="DateSelectorTo" src="~/GUI/DateSelectorTo.ascx" %>


<asp:Content ContentPlaceHolderID="MyCPH1" ID="restart" runat="server">
<script type="text/javascript" language="javascript" src="../../../cal/popcalendar.js"></script>
<script type="text/javascript">
var redToday;
var redFromTo;
var redSevenDay;
      function Error()
      {
        if (document.getElementById('ctl00$MyCPH1$dlstSalesAmount').value == "")
        {
            alert("Please Select Account");
            return false;
        }
        else if (document.getElementById('ctl00$MyCPH1$chk').value == "1")
        {
        if (document.getElementById('ctl00$MyCPH1$txtDateFrom$txt_Date').value == "" || document.getElementById('ctl00$MyCPH1$txtDateTo$txt_Date').value == "")
            {
                alert("Please Select Date Range");
                return false;
            }
            else
            {
                return true;
            }
        }
                
      }
      function CHK1(ClientId)
      {
        var idid = ClientId.value;
        document.getElementById('ctl00$MyCPH1$chk').value = ""
        if (idid == "redFromTo")
        {
            document.getElementById('ctl00$MyCPH1$chk').value = "1";
        }
        else
        {
            document.getElementById('ctl00$MyCPH1$chk').value = "0";
        }
        
      }
  </script>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td> 
      <table width="95%" border="0" align="left" cellpadding="0" cellspacing="0">
       
        
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                
              <tr>
                <td width="10%">&nbsp;</td> 
                <td width="50%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="300" valign="top">
					  <!--START-->
			
		<br>
		<table border="0" cellpadding="3" width="60%" bgcolor="#808080" cellspacing="1" align="left" cols="3" class=boxbg>
		 <tr class="bgbluegrey"> 
      <td  align="center" colspan="4"> 
        <p align="center"><font class=blackfnt>Select Branch / Profit Center </font></p>
      </td>
    </tr>
		<tr bgcolor="#FFFFFF"> 
        <td  align="center" colspan="2"> 
          <div align="right"><font class=blackfnt>Select Branch / Profit Center</font> 
            : </div>
        </td>
        <td bgcolor="#FFFFFF" align="center" colspan="2" style="width: 428px"> 
          <div align="left"><font class=blackfnt>
          
          <asp:UpdatePanel ID="up1"   UpdateMode="Conditional" RenderMode="Inline" runat="server">
            <ContentTemplate>
            <asp:DropDownList ID="dlstBranch" runat="server" Width="250px" AutoPostBack="true" OnSelectedIndexChanged="change_Account">
              </asp:DropDownList><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="dlstBranch"
                  ErrorMessage="*"></asp:RequiredFieldValidator>
            </ContentTemplate>
          </asp:UpdatePanel> 
          </font>&nbsp;</div>
          
        </td>
      </tr> 
            <tr bgcolor="#ffffff">
                <td align="center" bgcolor="#ffffff" colspan="4">
                    <asp:RadioButtonList ID="dlstTranType" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Selected="True" Value="Y">&lt;font class=blackfnt&gt;&lt;b&gt;Individual&lt;/b&gt;&lt;/font&gt;</asp:ListItem>
                        <asp:ListItem Value="N">&lt;font class=blackfnt&gt;&lt;b&gt;Cumulative (Transaction includes all branches)&lt;/b&gt;&lt;/font&gt;</asp:ListItem>
                    </asp:RadioButtonList></td>
            </tr>
      
				<tr class="bgbluegrey"> 
      <td  align="center" colspan="4"> 
        <p align="center"><font class=blackfnt>Select Voucher Generation 
          Date Range</font> 
      </td>
    </tr>
    <tr bgcolor="#FFFFFF">
				<TD width=10% align=center>
                    <asp:RadioButton ID="redFromTo" runat="server" GroupName="red"/></TD>
			     <TD><SControls:DateSelector ID="txtDateFrom" runat="server" />   
			        </TD>
			    <TD>
			    <SControlsTo:DateSelectorTo ID="txtDateTo" runat="server" />
			    
				</TD>
			</TR>
    <center>
    <tr> 
        <td bgcolor="#FFFFFF" align="center" colspan="1" WIDTH=10%> 
            <asp:RadioButton ID="redToday" runat="server" GroupName="red" />&nbsp;</td>
        <td bgcolor="#FFFFFF" align="center" colspan="3"> 
          <div align="left"><font class=blackfnt>&nbsp;&nbsp;Today</font> 
          </div>
        </td>
      </tr>
    <center>
      <tr> 
        <td bgcolor="#FFFFFF" align="center" colspan="1" WIDTH=10%> 
            <asp:RadioButton ID="redSevenDay" runat="server" GroupName="red" Checked="True"/>&nbsp;</td>
        <td bgcolor="#FFFFFF" align="center" colspan="3"> 
          <div align="left"><font class=blackfnt>&nbsp;&nbsp;Last 7 Days</font> 
          </div>
        </td>
      </tr>
     
    </center>
				 <tr class="bgbluegrey"> 
					<td align="center" colspan="4"><b><font class=blackfnt >Select Account</font></b></td>
			      </tr>
				  <tr bgcolor="#FFFFFF"> 
					
					<td align="center"  height="22" colspan="4">
                        &nbsp;
                        
                        <asp:UpdatePanel ID="up2"  UpdateMode="Conditional" RenderMode="Inline" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="dlstSalesAmount" runat="server" Width="482px">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="dlstSalesAmount"
                            ErrorMessage="*"></asp:RequiredFieldValidator>    
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="dlstBranch" EventName="SelectedIndexChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
                        </td>
				  </tr>
				<center>
					<tr>
						<td bgcolor="#FFFFFF" align="center" colspan="4" height="22">
                            <asp:Button ID="Button1" runat="server" Text="Submit" BorderStyle="None" style="text-decoration: underline" CssClass="blackfnt" Font-Size="10pt" Height="23px" OnClick="Button1_Click" Width="83px" OnClientClick="return Error(this);" />
						</td>
						
					</tr>
				</center>
			</table>
			<br>
			
					  <!--END-->
					  </td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td>

</td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<asp:TextBox ID="chk" runat="server" BackColor="White" BorderColor="White" BorderStyle="None" ForeColor="White" Width="1px">0</asp:TextBox>
</asp:Content>
