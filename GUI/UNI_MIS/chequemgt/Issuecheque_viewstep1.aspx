<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Issuecheque_viewstep1.aspx.cs" Inherits="GUI_UNI_MIS_chequemgt_Issuecheque_viewstep1" %>

<%@ Reference Control="~/GUI/DateSelector.ascx" %>
<%@ Reference Control="~/GUI/DateSelectorTo.ascx" %>
<%@ Register TagPrefix="SControls" TagName="DateSelector" Src="~/GUI/DateSelector.ascx" %>
<%@ Register TagPrefix="SControlsTo" TagName="DateSelectorTo" Src="~/GUI/DateSelectorTo.ascx" %>
<asp:Content ContentPlaceHolderID="MyCPH1" ID="Issuecheque_received" runat="server">

    <script type="text/javascript" language="javascript" src="../../cal/popcalendar.js"></script>

    <script type="text/javascript">
var redToday;
var redFromTo;
var redSevenDay;
var FrmChild;
      function Error()
      {
        if(document.getElementById('ctl00$MyCPH1$txtChequeNo').value == "")
        {
            if(document.getElementById('ctl00$MyCPH1$DropDownList1').value == "0")
                {
                    alert("Please Select Cheque Type");
                    return false;
                }
            else if (document.getElementById('ctl00$MyCPH1$chk').value == "1")
            {
            if (document.getElementById('ctl00$MyCPH1$txtDateFrom$txt_Date').value == "" || document.getElementById('ctl00$MyCPH1$txtDateTo$txt_Date').value == "")
                {
                    alert("Please Select Date Range");
                    return false;
                }
            else if(document.getElementById('ctl00$MyCPH1$txtVenderCode').value == "")
                {
//                    alert("Please Enter Customer Code");
//                    return false;
                }
           
            else
                {
                    return true;
                }
            }
            else
            {
//                if(document.getElementById('ctl00$MyCPH1$txtVenderCode').value == "")
//                {
//                    alert("Please Enter Customer Code");
//                    return false;
//                }
//            else
//                {
//                    return true;
//                }
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
        else if(document.getElementById('ctl00$MyCPH1$TextBox2').value == "")
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
            if(document.getElementById('ctl00$MyCPH1$TextBox2').value == "")
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
        else if(document.getElementById('ctl00$MyCPH1$TextBox3').value == "")
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
            if(document.getElementById('ctl00$MyCPH1$TextBox3').value == "")
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
           
            if(document.getElementById('ctl00$MyCPH1$cust_vend').value == "1")
            {
                //alert("A");
                var FrmChild = window.open('../../webadmin/popup-branch.aspx' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
                 
	            if(FrmChild != null)
	            {
            	  
	            }
	            else
	            {
		            return false;
	            }
            }
            else if(document.getElementById('ctl00$MyCPH1$cust_vend').value == "2")
            {
                //alert("B");
                 
                var FrmChild = window.open('../../webadmin/popup-branch.aspx' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
                 
	            if(FrmChild != null)
	            {
            	  
	            }
	            else
	            {
		            return false;
	            }
            }
         
        }
        function vendor()
        {
            if(document.getElementById('ctl00$MyCPH1$cust_vend').value == "2")
            {
                //alert("B");
                var FrmChild = window.open('../../webadmin/popup-vendor1.aspx' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
                 
	            if(FrmChild != null)
	            {
            	  
	            }
	            else
	            {
		            return false;
	            }
            }
            else if(document.getElementById('ctl00$MyCPH1$cust_vend').value == "1")
            {
                //alert("B");
                var FrmChild = window.open('../../webadmin/popup-cust1.aspx' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
                 
	            if(FrmChild != null)
	            {
            	  
	            }
	            else
	            {
		            return false;
	            }
            }
        }

        /////////////////////////////////////////////////
        function chequeChange()
        {
            //alert(document.getElementById('ctl00$MyCPH1$DropDownList1').value)
            if(document.getElementById('ctl00$MyCPH1$DropDownList1').value == "0")
            {
                document.getElementById('ctl00$MyCPH1$cust_vend').value = 0;
                document.getElementById('ctl00$MyCPH1$txtVenderCode').value = "";
            }
            else if(document.getElementById('ctl00$MyCPH1$DropDownList1').value == "1")
            {
                
                document.getElementById('ctl00$MyCPH1$cust_vend').value = 2;
                document.getElementById('ctl00$MyCPH1$txtVenderCode').value = "";
                
            }
            else if(document.getElementById('ctl00$MyCPH1$DropDownList1').value == "2")
            {
                document.getElementById('ctl00$MyCPH1$cust_vend').value = 1;
                document.getElementById('ctl00$MyCPH1$txtVenderCode').value = "";
            }
        }
        function chequeChangeA()
        {
            //alert("ok")
            if(document.getElementById('ctl00$MyCPH1$cust_vend').value == "0")
            {
                document.getElementById('ctl00$MyCPH1$DropDownList1').value = 0;
                document.getElementById('ctl00$MyCPH1$txtVenderCode').value = "";
            }
            else if(document.getElementById('ctl00$MyCPH1$cust_vend').value == "1")
            {
                document.getElementById('ctl00$MyCPH1$DropDownList1').value = 2;
                document.getElementById('ctl00$MyCPH1$txtVenderCode').value = "";
            }
            else if(document.getElementById('ctl00$MyCPH1$cust_vend').value == "2")
            {
                document.getElementById('ctl00$MyCPH1$DropDownList1').value = 1;
                document.getElementById('ctl00$MyCPH1$txtVenderCode').value = "";
            }
        }
        function amount(obj,amtFrom)
        {
            
            if (obj.value == "")
            {
                alert("Value can't be blank")
                obj.value == "0";
            }
            else if(isNaN(obj.value))
            {
                alert("Enter Valid Number !!")
                obj.value == "0";
            }
            
        }
        function amount1(obj,amtTo)
        {
        var amountFrom =document.getElementById('ctl00$MyCPH1$txtAmountFrom').value
        if (amtTo.value == "")
            {
                alert("Value can't be blank")
                obj.value == "0";
            }
         else if(isNaN(obj.value))
            {
                alert("Enter Valid Number !!")
                obj.value == "0";
            }
         else if (eval(amtTo.value) < eval(amountFrom))
         {
            alert ("Sorry Not a Valid Entry !!");
            document.getElementById('ctl00$MyCPH1$txtAmountFrom').value = "0"
            amtTo.value = "0"
         }
        }
    </script>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td width="10%"> 
                &nbsp;</td>
        </tr>
        <tr>
            <td align="center" width="90%">
                <table width="700" border="0" align="center" cellpadding="0" cellspacing="0">
                    
                    <tr>
                        <td align="left">
                            <table  border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td  valign="top">
                                        <table border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td height="300" valign="top" align="left">
                                                    <!--START-->
                                                    <br>
                                                    <table border="0" cellpadding="3" cols="1"  bgcolor="#808080" cellspacing="1"
                                                        class="boxbg">
                                                        <tr class="bgbluegrey">
                                                            <td align="center" colspan="2">
                                                                <font class="blackfnt"><b>Select Cheque&nbsp; Date </b></font>
                                                            </td>
                                                        </tr>
                                                        <tr bgcolor="#ffffff">
                                                            <td align="left" valign="top" style="width: 183px">
                                                            <font class="blackfnt">
                                                                Enter cheque number</font></td>
                                                            <td align="left" valign="top">
                                                                &nbsp;<asp:TextBox ID="txtChequeNo" runat="server" Width="82px" BorderStyle="Groove"></asp:TextBox></td>
                                                        </tr>
                                                        <tr bgcolor="#ffffff">
                                                            <td align="left" colspan="2" valign="top">
                                                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                                <asp:Button ID="btnCNSubmit" runat="server" OnClick="btnCNSubmit_Click" Text="Submit" /></td>
                                                        </tr>
                                                        <tr bgcolor="#ffffff">
                                                            <td align="center" colspan="2" valign="top">
                                                            <font class="blackfnt">
                                                                <strong>OR</strong></font></td>
                                                        </tr>
                                                        <tr bgcolor="#ffffff">
                                                            <td valign="top" align="left" style="width: 183px">
                                                                <font class="blackfnt">Cheque Type</font></td>
                                                            <td valign="top" align="left">
                                                                &nbsp;
                                                                <asp:UpdatePanel ID="up2"       UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:DropDownList ID="DropDownList1" runat="server" onchange="chequeChange()" AutoPostBack="true"
                                                                            OnSelectedIndexChanged="change_panel">
                                                                            <asp:ListItem Selected="True" Value="0">Select</asp:ListItem>
                                                                            <asp:ListItem Value="1">Issued Cheque Statement</asp:ListItem>
                                                                            <asp:ListItem Value="2">Received Cheque Statement</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
                                                                &nbsp;
                                                                <asp:UpdatePanel ID="UpdatePanel2"      UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:DropDownList ID="cust_vend" runat="server" onchange="chequeChangeA()" AutoPostBack="true"
                                                                            OnSelectedIndexChanged="change_Pan1">
                                                                            <asp:ListItem Selected="True" Value="0">Select</asp:ListItem>
                                                                            <asp:ListItem Value="1">Customer</asp:ListItem>
                                                                            <asp:ListItem Value="2">Vendor</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
                                                            </td>
                                                        </tr>
                                                        <tr bgcolor="#FFFFFF">
                                                            <!--<TD valign=top ><FONT class=blackfnt>Date Selection</FONT></TD>-->
                                                            <td valign="top" align="left" style="width: 183px">
                                                                <font class="blackfnt">Cheque Issue Date </font>
                                                            </td>
                                                            <td valign="top" align="left">
                                                                <table>
                                                                    <tr>
                                                                        <td valign="middle">
                                                                            <asp:RadioButton ID="redFromTo" runat="server" GroupName="red" /></td>
                                                                        <td valign="middle">
                                                                            <font class="blackfnt">&nbsp;<SControls:DateSelector ID="txtDateFrom" runat="server">
                                                                            </SControls:DateSelector>
                                                                            </font>
                                                                        </td>
                                                                        <td valign="middle">
                                                                            <font class="blackfnt">&nbsp;<SControlsTo:DateSelectorTo ID="txtDateTo" runat="server" />
                                                                            </font>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="left" valign="middle">
                                                                            <asp:RadioButton ID="redToday" runat="server" GroupName="red" /></td>
                                                                        <td colspan="2" valign="middle">
                                                                            <font class="blackfnt">&nbsp;Todays</font></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="height: 22px" valign="middle">
                                                                            <asp:RadioButton ID="redSevenDay" runat="server" Checked="True" GroupName="red" /></td>
                                                                        <td style="height: 22px" align="left" valign="middle">
                                                                            <font class="blackfnt">Last 7 days<!--Last 7 days--></font></td>
                                                                        <td style="height: 22px" valign="middle">
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr bgcolor="#ffffff">
                                                            <td align="left" style="width: 183px">
                                                            <font class="blackfnt">
                                                                Amount Range</font></td>
                                                            <td align="left">
                                                                &nbsp;<asp:TextBox ID="txtAmountFrom" runat="server" Width="80px" style="direction: rtl" BorderStyle="Groove">0</asp:TextBox>
                                                                <font class="blackfnt">To</font>
                                                                <asp:TextBox ID="txtAmountTo" runat="server" Width="80px" style="direction: rtl" BorderStyle="Groove">0</asp:TextBox></td>
                                                        </tr>
                                                        <tr bgcolor="#FFFFFF">
                                                            <td align="left" style="width: 183px">
                                                                <font class="blackfnt">Enter Cheque Entry / Issue Location</font></td>
                                                            <td align="left">
                                                                &nbsp;<asp:TextBox ID="txtLocation" runat="server" Width="82px" BorderStyle="Groove"></asp:TextBox>
                                                                <input onclick="test();" size="20" style="width: 18px; height: 21px" type="button"
                                                                    value="..." />
                                                        </tr>
                                                        <tr bgcolor="#ffffff">
                                                            <td align="left" style="width: 183px">
                                                            <font class="blackfnt">
                                                                Enter Customer / Vendor Code</font></td>
                                                            <td align="left">
                                                                &nbsp;<asp:TextBox ID="txtVenderCode" runat="server" Width="82px" BorderStyle="Groove"></asp:TextBox>
                                                                <input onclick="vendor();" size="20" style="width: 18px; height: 21px" type="button"
                                                                                value="..." /></td>
                                                        </tr>
                                                    </table>
                                                    <br />
                                                    <asp:UpdatePanel ID="up3"     UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                        <ContentTemplate>
                                                            <asp:Panel ID="panV" runat="server">
                                                                <table border="0" cellpadding="3" cols="1" width="65%" bgcolor="#808080" cellspacing="1"
                                                                    class="boxbg">
                                                                    <tr bgcolor="#FFFFFF">
                                                                        <td colspan="2" align="center">
                                                                            <font class="blackfnt"><b>Vendor Selection</b></font></td>
                                                                    </tr>
                                                                    <tr bgcolor="#FFFFFF">
                                                                        <td align="left" width="36%">
                                                                            <font class="blackfnt">Select Vendor type </font>
                                                                        </td>
                                                                        <td align="left" width="64%">
                                                                            &nbsp;
                                                                            <asp:UpdatePanel ID="up1"    UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                                                <ContentTemplate>
                                                                                    <asp:DropDownList ID="dlstVenderType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="type_Change">
                                                                                      
                                                                                    </asp:DropDownList>
                                                                                </ContentTemplate>
                                                                            </asp:UpdatePanel>
                                                                        </td>
                                                                    </tr>
                                                                    <tr bgcolor="#FFFFFF" width="36%">
                                                                        <td align="left">
                                                                            <font class="blackfnt">Select Vendor </font>
                                                                        </td>
                                                                        <td align="left" width="64%">
                                                                            &nbsp;
                                                                            <asp:UpdatePanel ID="UpdatePanel1"   UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                                                <ContentTemplate>
                                                                                    <asp:DropDownList ID="dlstVendorCode" runat="server">
                                                                                    </asp:DropDownList>
                                                                                </ContentTemplate>
                                                                                <Triggers>
                                                                                    <asp:AsyncPostBackTrigger ControlID="dlstVenderType" EventName="SelectedIndexChanged" />
                                                                                </Triggers>
                                                                            </asp:UpdatePanel>
                                                                        </td>
                                                                    </tr>
                                                                    <tr bgcolor="#ffffff">
                                                                        <td align="left">
                                                                            </td>
                                                                        <td align="left">
                                                                            &nbsp;</td>
                                                                    </tr>
                                                            </asp:Panel>
                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <asp:AsyncPostBackTrigger ControlID="DropDownList1" EventName="SelectedIndexChanged" />
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                        </table>
                                        <br />
                                        <asp:UpdatePanel ID="UpdatePanel3"  UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                            <ContentTemplate>
                                                                                    <asp:Panel ID="panC" runat="server">
                                            <table border="0" cellpadding="3" cols="1" width="65%" bgcolor="#808080" cellspacing="1"
                                                class="boxbg">
                                                <tr bgcolor="#ffffff">
                                                    <td align="center" colspan="2">
                                                        <font class="blackfnt"><strong>Customer Selection</strong></font></td>
                                                </tr>
                                                <tr>
                                                    <td align="left" bgcolor="white" width="36%">
                                                        <font class="blackfnt">Search By</font></td>
                                                    <td align="left" bgcolor="white" width="64%">
                                                        &nbsp;&nbsp;<asp:DropDownList ID="dlstSearchType" runat="server" >
                                                        <asp:ListItem Selected="true" Value="Entrydt">Cheque Entry Date</asp:ListItem>
                                                        <asp:ListItem Value="chqdt">Cheque Date</asp:ListItem>
                                                        <asp:ListItem Value="transdate">Cheque Accounted Date</asp:ListItem>
                                                        </asp:DropDownList></td>
                                                </tr>
                                                <tr>
                                                    <td align="left" bgcolor="white" width="36%">
                                                        <font class="blackfnt">Cheque status</font></td>
                                                    <td align="left" bgcolor="white" width="64%">
                                                        &nbsp;&nbsp;<asp:DropDownList ID="dlstCS" runat="server" >
                                                            <asp:ListItem Selected="True" Value="All">All</asp:ListItem>
                                                            <asp:ListItem Value="B">Bounced</asp:ListItem>
                                                            <asp:ListItem Value="D">Deposited</asp:ListItem>
                                                            <asp:ListItem Value="ND">Not-Deposited</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" bgcolor="white" width="36%">
                                                        <font class="blackfnt">Cheque amount status</font>
                                                    </td>
                                                    <td align="left" bgcolor="white" width="64%">
                                                        &nbsp;
                                                        <asp:DropDownList ID="dlstCAS" runat="server">
                                                            <asp:ListItem Selected="True" Value="All">All</asp:ListItem>
                                                            <asp:ListItem Value="C">Completed</asp:ListItem>
                                                            <asp:ListItem Value="UA">Unaccounted</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                        </asp:Panel>
                            </table>

                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="DropDownList1" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                        &nbsp;<br />
                            &nbsp;<br>
                            <table border="0" style="width: 299px">
                                <tr>
                                    <td align="center">
                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                        &nbsp; &nbsp; &nbsp;&nbsp;
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClientClick="return Error(this);"
                                            OnClick="btnSubmit_Click" />
                                    </td>
                                </tr>
                            </table>
                            <br>
                                        <br />
                                        <br />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td style="height: 20px">
                            <asp:TextBox ID="chk" runat="server" BackColor="White" BorderColor="White" BorderStyle="None"
                                ForeColor="White" Width="1px">0</asp:TextBox></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </table>
</asp:Content>
