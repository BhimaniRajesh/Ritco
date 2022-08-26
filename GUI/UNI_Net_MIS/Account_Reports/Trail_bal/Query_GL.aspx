<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query_GL.aspx.cs" Inherits="GUI_UNI_MIS_Account_Reports_Trail_bal_Query_GL" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="../../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../../../images/commonJs.js"></script>

    <script type="text/javascript" language="JavaScript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	function cust(ID)
        {
         ///var FrmChild = window.open('../PopUp_Cust.aspx?ID="+ID' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
         var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
            var strPopupURL = "../../PopUp_Cust.aspx?ID="+ID
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
		
	
	
	function ChkCust(val)
	{
	    DL_CUST=document.getElementById("ctl00_MyCPH1_txtCustomer"); 
	    DL_Vend=document.getElementById("ctl00_MyCPH1_txtVendor"); 
	    DL_Emp=document.getElementById("ctl00_MyCPH1_txtEmployee"); 
	    DL_DRI=document.getElementById("ctl00_MyCPH1_txtDriver"); 
	  	    
	    
	    if(document.getElementById("ctl00_MyCPH1_rpttyp_0").checked==true)
	    {
	         document.getElementById('ctl00_MyCPH1_tr_cust').style.display = "none";
	         document.getElementById('ctl00_MyCPH1_tr_vend').style.display = "none";
	         document.getElementById('ctl00_MyCPH1_tr_emp').style.display = "none";
	         document.getElementById('ctl00_MyCPH1_tr_dri').style.display = "none";
	       
	    }
	    else if(document.getElementById("ctl00_MyCPH1_rpttyp_1").checked==true)
	    {
	        document.getElementById('ctl00_MyCPH1_tr_cust').style.display = "block";
	        document.getElementById('ctl00_MyCPH1_tr_vend').style.display = "none";
	         document.getElementById('ctl00_MyCPH1_tr_emp').style.display = "none";
	         document.getElementById('ctl00_MyCPH1_tr_dri').style.display = "none";
	       
	    }
	    else if(document.getElementById("ctl00_MyCPH1_rpttyp_2").checked==true)
	    {
	        document.getElementById('ctl00_MyCPH1_tr_cust').style.display = "none";
	           document.getElementById('ctl00_MyCPH1_tr_vend').style.display = "block";
	         document.getElementById('ctl00_MyCPH1_tr_emp').style.display = "none";
	         document.getElementById('ctl00_MyCPH1_tr_dri').style.display = "none";
	     
	    }
	    else if(document.getElementById("ctl00_MyCPH1_rpttyp_3").checked==true)
	    {
	        document.getElementById('ctl00_MyCPH1_tr_cust').style.display = "none";
	           document.getElementById('ctl00_MyCPH1_tr_vend').style.display = "none";
	         document.getElementById('ctl00_MyCPH1_tr_emp').style.display = "block";
	         document.getElementById('ctl00_MyCPH1_tr_dri').style.display = "none";
	       
	    }
	    else if(document.getElementById("ctl00_MyCPH1_rpttyp_4").checked==true)
	    {
	        document.getElementById('ctl00_MyCPH1_tr_cust').style.display = "none";
	           document.getElementById('ctl00_MyCPH1_tr_vend').style.display = "none";
	         document.getElementById('ctl00_MyCPH1_tr_emp').style.display = "none";
	         document.getElementById('ctl00_MyCPH1_tr_dri').style.display = "block";
	       
	    }
	
	}
	
function OnSub_DATACHECK()
     {
         if(document.getElementById("ctl00_MyCPH1_rpttyp_0").checked==true)
	     {
	      txtAccount=document.getElementById("ctl00_MyCPH1_txtAccount"); 
            if(txtAccount.value=="")
		     {
		      alert("Please Select Account")
		      txtAccount.focus();
		      return false;
		     }    
        }
     
     //alert("HIii")
        if(!DateCheck())
            return false;
      //  alert("HIii")
        if(!FinDateCheck())
            return false;             
     }
     
     
	
    </script>
 <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong><font
                            class="blklnkund"><strong>Finance </strong></font><font class="bluefnt"><strong>&gt;
                            </strong><strong>General Ledger  </strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                    <div align="center">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="../../../images/back.gif" border="0" />
                    </a>
                </td>
            </tr>
            <tr>
                <td valign="top">
    <table id="Table1" runat="server" cellpadding="3" cellspacing="1" style="width: 8.5in;">
        <tr>
            <td>
                <center>
                    <asp:UpdatePanel ID="UpdatePanel5"    UpdateMode="Conditional" runat="server">
                        <ContentTemplate>
                            <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                                <ProgressTemplate>
                                    <div id="progressArea">
                                        <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                        <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </center>
            </td>
        </tr>
        <tr>
            <td>
                <table cellspacing="1" style="width: 10.0in" class="boxbg" border="0">
                    <tr class="bgbluegrey">
                        <td colspan="4" align="center" style="height: 21px">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                        Select Branch / Profit Center 

                            </asp:Label>
                        </td>
                    </tr>
                    <tr bgcolor="white">
                        <td colspan="2" align="center">
                            <asp:Label ID="Label4" CssClass="blackfnt" Font-Bold="true" runat="server">
                                        Select Branch / Profit Center :

                            </asp:Label></td>
                        <td colspan="2">
                            <asp:UpdatePanel ID="up3" runat="server">
                                <ContentTemplate>
                                    <asp:DropDownList ID="ddlro" runat="server" AutoPostBack="True">
                                    </asp:DropDownList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr id="trradflow" runat="server" style="font-size: 12pt; font-family: Times New Roman;
                        background-color: white">
                        <td align="center" colspan="4" valign="top">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <asp:RadioButtonList ID="radFlow" runat="server" CssClass="blackfnt" OnSelectedIndexChanged="rdiochanges"
                                        AutoPostBack="true" RepeatDirection="Horizontal">
                                        <asp:ListItem Selected="True" Text="Individual" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Cumulative (Transaction includes all branches)" Value="1"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr id="tr_cust" runat="server" style="background-color: white; display: none;">
                        <td align="center">
                            <asp:Label ID="Label3" CssClass="blackfnt" Text="Select Customer" runat="server"></asp:Label>
                        </td>
                        <td align="Left" colspan="3">
                            <asp:TextBox ID="txtCustomer" Enabled="true" runat="server" Width="234"></asp:TextBox><input
                                type="button" onclick="cust('C');" value="..." style="width: 18px; height: 21px"
                                size="" />
                            <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                        </td>
                    </tr>
                    <tr id="tr_vend" runat="server" style="background-color: white; display: none;">
                        <td align="center">
                            <asp:Label ID="Label5" CssClass="blackfnt" Text="Select Vendor" runat="server"></asp:Label>
                        </td>
                        <td align="Left" colspan="3">
                            <asp:TextBox ID="txtVendor" Enabled="true" runat="server" Width="234"></asp:TextBox><input
                                type="button" onclick="cust('V');" value="..." style="width: 18px; height: 21px"
                                size="" />
                            <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                        </td>
                    </tr>
                    <tr id="tr_emp" runat="server" style="background-color: white; display: none;">
                        <td align="center">
                            <asp:Label ID="Label6" CssClass="blackfnt" Text="Select Employee" runat="server"></asp:Label>
                        </td>
                        <td align="Left" colspan="3">
                            <asp:TextBox ID="txtEmployee" Enabled="true" runat="server" Width="234"></asp:TextBox><input
                                type="button" onclick="cust('E');" value="..." style="width: 18px; height: 21px"
                                size="" />
                            <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                        </td>
                    </tr>
                    <tr id="tr_dri" runat="server" style="background-color: white; display: none;">
                        <td align="center">
                            <asp:Label ID="Label7" CssClass="blackfnt" Text="Select Driver" runat="server"></asp:Label>
                        </td>
                        <td align="Left" colspan="3">
                            <asp:TextBox ID="txtDriver" Enabled="true" runat="server" Width="234"></asp:TextBox><input
                                type="button" onclick="cust('D');" value="..." style="width: 18px; height: 21px"
                                size="" />
                            <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                        </td>
                    </tr>
                    <tr id="tr_acc" runat="server" style="background-color: white; display: block;">
                        <td align="center">
                            <asp:Label ID="Label8" CssClass="blackfnt" Text="Select Accounts" runat="server"></asp:Label>
                        </td>
                        <td align="Left" colspan="3">
                            <asp:TextBox ID="txtAccount" Enabled="true" runat="server" Width="234"></asp:TextBox><input
                                type="button" onclick="cust('A');" value="..." style="width: 18px; height: 21px"
                                size="" />
                            <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td colspan="6" align="center" style="height: 21px">
                            <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server">
                                       Select Voucher Date Range 

                            </asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="center">
                            <font class="blackfnt">Select Voucher Date </font>
                        </td>
                        <td align="left" colspan="3">
                            <Date:DT ID="DT" runat="server" />
                        </td>
                    </tr>
                    <tr align="center" bgcolor="white">
                        <td colspan="6">
                            <asp:RadioButtonList onClick="javascript:ChkCust(this);" ID="rpttyp" RepeatDirection="horizontal"
                                CssClass="blackfnt" runat="server">
                                <asp:ListItem Selected="True" Text="Ledger Wise" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Customer Wise" Value="2"></asp:ListItem>
                                <asp:ListItem Text="Vendor Wise" Value="3"></asp:ListItem>
                                <asp:ListItem Text="Employee Wise" Value="4"></asp:ListItem>
                                <asp:ListItem Text="Driver Wise" Value="5"></asp:ListItem>
                                <%--<asp:ListItem   Text="Account Wise" Value="5"></asp:ListItem>--%>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr align="center" bgcolor="white">
                        <td colspan="6">
                            <asp:RadioButtonList ID="rptfrt" RepeatDirection="horizontal" CssClass="blackfnt"
                                runat="server">
                                <asp:ListItem Selected="True" Text="HTML Format" Value="1"></asp:ListItem>
                                <asp:ListItem Text="XLS Format" Value="2"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr align="center" bgcolor="white">
                        <td colspan="6">
                            <asp:Button ID="btnShow" OnClientClick="Javascript:return OnSub_DATACHECK();" OnClick="btnShow_Click"
                                runat="server" Text="Show" Width="75px" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table> </td></tr></table></div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
