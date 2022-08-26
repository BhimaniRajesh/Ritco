<%@ Page Language="C#" AutoEventWireup="true" CodeFile="prestart.aspx.cs" MasterPageFile="~/GUI/MasterPage.master" Inherits="GUI_UNI_MIS_accounts_mis_subsidiary_ledger_prestart" %>
<%@ Reference Control="~/GUI/DateSelector.ascx" %>
<%@ Reference Control="~/GUI/DateSelectorTo.ascx" %>
<%@Register TagPrefix="SControls" TagName="DateSelector" src="~/GUI/DateSelector.ascx" %>
<%@Register TagPrefix="SControlsTo" TagName="DateSelectorTo" src="~/GUI/DateSelectorTo.ascx" %>
<asp:Content ContentPlaceHolderID="MyCPH1" ID="prestartsub" runat="server">
<script type="text/javascript" language="javascript" src="../../../cal/popcalendar.js"></script>
<script type="text/javascript">
var redToday;
var redFromTo;
var redSevenDay;
var FrmChild;
      function Error()
      {
        
        if (document.getElementById('ctl00$MyCPH1$chk').value == "1")
        {
        if (document.getElementById('ctl00$MyCPH1$txtDateFrom$txt_Date').value == "" || document.getElementById('ctl00$MyCPH1$txtDateTo$txt_Date').value == "")
            {
                alert("Please Select Date Range");
                return false;
            }
        else if(document.getElementById('ctl00$MyCPH1$txtCustomer').value == "")
            {
                alert("Please Enter Customer Code");
                return false;
            }
        else
            {
                return true;
            }
        }
        else
        {
            if(document.getElementById('ctl00$MyCPH1$txtCustomer').value == "")
            {
                alert("Please Enter Customer Code");
                return false;
            }
        else
            {
                return true;
            }
        }
      }
      ///////////////////////////////////////////////
      function Error_vendor()
      {
        
        if (document.getElementById('ctl00$MyCPH1$chk').value == "1")
        {
        if (document.getElementById('ctl00$MyCPH1$txtDateFrom$txt_Date').value == "" || document.getElementById('ctl00$MyCPH1$txtDateTo$txt_Date').value == "")
            {
                alert("Please Select Date Range");
                return false;
            }
        else if(document.getElementById('ctl00$MyCPH1$txtVendor').value == "")
            {
                alert("Please Enter Vendor Code");
                return false;
            }
        else
            {
                return true;
            }
        }
        else
        {
            if(document.getElementById('ctl00$MyCPH1$txtVendor').value == "")
            {
                alert("Please Enter Vendor Code");
                return false;
            }
        else
            {
                return true;
            }
        }
                
      }
      ///////////////////////////////////////////////
      function Error_Employee()
      {
        
        if (document.getElementById('ctl00$MyCPH1$chk').value == "1")
        {
        if (document.getElementById('ctl00$MyCPH1$txtDateFrom$txt_Date').value == "" || document.getElementById('ctl00$MyCPH1$txtDateTo$txt_Date').value == "")
            {
                alert("Please Select Date Range");
                return false;
            }
        else if(document.getElementById('ctl00_MyCPH1_txtEmployee').value == "")
            {
                alert("Please Enter Employee Code");
                return false;
            }
        else
            {
                return true;
            }
        }
        else
        {
            if(document.getElementById('ctl00_MyCPH1_txtEmployee').value == "")
            {
                alert("Please Enter Employee Code");
                return false;
            }
        else
            {
                return true;
            }
        }
                
      }
      //////////////////////////////////////////////
      
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
      function test()
        {
         var FrmChild = window.open('../../../webadmin/popup-cust.aspx' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
             
	        if(FrmChild != null)
	        {
        	  
	        }
	        else
	        {
		        return false;
	        }
        }
        function test_Vendor()
        {
         var FrmChild = window.open('../../../webadmin/popup-radvendor.aspx' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
             
	        if(FrmChild != null)
	        {
        	  
	        }
	        else
	        {
		        return false;
	        }
        }
        function test_Employee()
        {
         var FrmChild = window.open('../../../webadmin/popup-emp.aspx' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
             
	        if(FrmChild != null)
	        {
        	  
	        }
	        else
	        {
		        return false;
	        }
        }
//    function branchpopup3()
//        {
//          winNew=window.open('../../../webadmin/popup-cust.aspx',null,"height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15")
//        }
  </script>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td> 
      <table width="95%" border="0" align="left" cellpadding="0" cellspacing="0">
       
        <tr> 
          <td height="30"><a href="#"></a>
			
			</td>
        </tr>
        
        <tr> 
          <td ><img src="../../../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr> 
          <td><img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>

        <!--<tr> 
          <td align=right><a href="javascript:window.history.go(-1)" Title="back"><img src="../../../images/back.gif" border=0></a></td>
        </tr>-->
        
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
                
              <tr>
                <td style="width: 10%">&nbsp;</td> 
                <td width="50%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="300" valign="top">
					  <!--START-->
			
		<br>
		<table border="0" cellpadding="3" width="55%" bgcolor="#808080" cellspacing="1" align="left" cols="3" class=boxbg>
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
        <td bgcolor="#FFFFFF" align="center" colspan="2"> 
          <div align="left"><font class=blackfnt>&nbsp;<asp:DropDownList ID="dlstBranch" runat="server" Width="250px">
              </asp:DropDownList>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="dlstBranch"
                  ErrorMessage="*"></asp:RequiredFieldValidator></font></div>
          
        </td>
      </tr> 
        
       <tr bgcolor="#FFFFFF">
    	<td bgcolor="#FFFFFF" align="center" colspan="4"> 
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
			    <TD style="width: 95px">
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
     
				 <tr bgcolor="#FFFFFF"> 
					<td   height="22" colspan="2"><b><font class=blackfnt >Enter Customer</font></b></td>
			    
					<td   height="22" colspan="2">
                        <asp:TextBox ID="txtCustomer" runat="server" Width="94px"></asp:TextBox><input type="button" onclick="test();" Value="..." style="width: 18px; height: 21px" size="" />
                        <asp:Button ID="btn_Customer" runat="server" Text="Submit" BorderStyle="None" style="text-decoration: underline" CssClass="blackfnt" Font-Size="10pt" Height="23px" OnClick="btn_Customer_Click" Width="83px" OnClientClick="return Error(this);" Font-Bold="False" /></td>
                        <%--<input type=button onClick='targetitem = document.forms[0].maparea;  dataitem = window.open("../../../webadmin/popup-cust.aspx", "dataitem", "toolbar=no,menubar=no,scrollbars=yes"); dataitem.targetitem = targetitem'>--%>
				  </tr>
				   <tr bgcolor="#FFFFFF" > 
					<td   height="22" colspan="4" align=center><b><font class=blackfnt ><b>OR</b></font></b></td>
			      </tr>
				   
				  <tr bgcolor="#FFFFFF"> 
					<td   height="22" colspan="2"><b><font class=blackfnt >Enter Vendor</font></b></td>
			 
					<td  height="22" colspan="2">
                        <asp:TextBox ID="txtVendor" runat="server" Width="94px"></asp:TextBox><input type="button" onclick="test_Vendor();" Value="..." style="width: 18px; height: 21px" size="20" />
                        <asp:Button ID="btnVendor" runat="server" Text="Submit" BorderStyle="None" style="text-decoration: underline" CssClass="blackfnt" Font-Size="10pt" Height="23px" OnClick="btnVendor_Click" Width="83px" OnClientClick="return Error_vendor(this);" Font-Bold="False" /></td>
				  </tr>
				    <tr bgcolor="#FFFFFF" > 
					<td   height="22" colspan="4" align=center><b><font class=blackfnt ><b>OR</b></font></b></td>
			      </tr>
				   
				  <tr bgcolor="#FFFFFF"> 
					<td   height="22" colspan="2"><b><font class=blackfnt >Enter Employee</font></b></td>
			 
					<td  height="22" colspan="2">
                        <asp:TextBox ID="txtEmployee" runat="server" Width="94px"></asp:TextBox><input type="button" onclick="test_Employee();" Value="..." style="width: 18px; height: 21px" size="20" />
                        <asp:Button ID="btnEmployee" runat="server" Text="Submit" BorderStyle="None" style="text-decoration: underline" CssClass="blackfnt" Font-Size="10pt" Height="23px" OnClick="btnEmployee_Click" Width="83px" OnClientClick="return Error_Employee(this);" Font-Bold="False" /></td>
				  </tr> 
				 
				  
				
				 
				 
				 
				 
				 
				 
				 
				<center>
					<tr>
						<td bgcolor="#FFFFFF" align="center" colspan="4" height="22">
                            &nbsp;</td>
						
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
