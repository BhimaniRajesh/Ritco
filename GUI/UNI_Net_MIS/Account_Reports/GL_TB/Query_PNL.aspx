<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Query_PNL.aspx.cs" Inherits="GUI_UNI_Net_MIS_Account_Reports_GL_TB_Query_PNL" %>

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
	function ChkPgsize(val)
	{	
	     //pgSize=document.getElementById("ctl00_MyCPH1_pgSize"); 
	     if(document.getElementById("ctl00_MyCPH1_rptfrt_0").checked==true)
	    {
	     document.getElementById('ctl00_MyCPH1_TRPG').style.display = "block";
	    }
	    else 
	    {
	    document.getElementById('ctl00_MyCPH1_TRPG').style.display = "none";
	    }
	
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
         
        
         if(document.getElementById("ctl00_MyCPH1_rpttyp_1").checked==true)
	     {
	      txtAccount=document.getElementById("ctl00_MyCPH1_txtCustomer"); 
            if(txtAccount.value=="")
		     {
		      alert("Please Enter CustomerCode")
		      txtAccount.focus();
		      return false;
		     }    
        }
        
        if(document.getElementById("ctl00_MyCPH1_rpttyp_2").checked==true)
	     {
	      txtAccount=document.getElementById("ctl00_MyCPH1_txtVendor"); 
            if(txtAccount.value=="")
		     {
		      alert("Please Enter VendorCode")
		      txtAccount.focus();
		      return false;
		     }    
        }
        
        if(document.getElementById("ctl00_MyCPH1_rpttyp_3").checked==true)
	     {
	      txtAccount=document.getElementById("ctl00_MyCPH1_txtEmployee"); 
            if(txtAccount.value=="")
		     {
		      alert("Please Enter EmployeeCode")
		      txtAccount.focus();
		      return false;
		     }    
        }
        
        if(document.getElementById("ctl00_MyCPH1_rpttyp_4").checked==true)
	     {
	      txtAccount=document.getElementById("ctl00_MyCPH1_txtDriver"); 
            if(txtAccount.value=="")
		     {
		      alert("Please Enter DriverCode")
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
                 <font class="bluefnt"><strong><u>&gt;&gt;&gt; Balance Sheet</u> </strong></font>

                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                    <div align="center">
                        <asp:UpdateProgress ID="uppMain" runat="server">
                            <ProgressTemplate>
                                <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                                    -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                                    <tr>
                                        <td align="right">
                                            <img src="../../../images/loading.gif" alt="" />
                                        </td>
                                        <td>
                                            <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                                        </td>
                                    </tr>
                                </table>
                                <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                                    background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                                    opacity: .50; -moz-opacity: .50;" runat="server">
                                    <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                                        left: 50%;" ID="Panel2" runat="server">
                                    </asp:Panel>
                                </asp:Panel>
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
                    <table id="Table1" runat="server" cellpadding="3" cellspacing="1" style="width: 7.5in;">
                        <tr>
                            <td>
                                <table cellspacing="1" style="width: 9.5in" class="boxbg" border="0">
                                    <tr class="bgbluegrey">
                                        <td colspan="4" align="center" style="height: 21px">
                                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                        Select Branch / Profit Center 

                                            </asp:Label>
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
                                                        <asp:ListItem Text="Individual (Month Wise)" Value="4"></asp:ListItem>
                                                        <asp:ListItem Text="Cumulative (Transaction includes all branches)" Value="1"></asp:ListItem>
                                                         <asp:ListItem Text="Cumulative (Branch Wise)" Value="2"></asp:ListItem>
                                                         <asp:ListItem Text="Cumulative (Month Wise)" Value="3"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
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
                                    <tr align="center" bgcolor="white">
                                    <td colspan="2">
                                        <asp:CheckBox  ID="RPTSUBCHK" runat="server" CssClass="blackfnt" Text="Group Wise"/>
                                        </td>
                                        <td colspan="2">
                                            <asp:RadioButtonList onClick="javascript:ChkCust(this);" ID="rpttyp" RepeatDirection="horizontal"
                                                CssClass="blackfnt" runat="server">
                                                <asp:ListItem Selected="True" Text="Ledger Wise" Value="1"></asp:ListItem>
                                               <asp:ListItem Text="Customer Wise"  Enabled="false" Value="2"></asp:ListItem>
                                                <asp:ListItem Text="Vendor Wise" Enabled="false"  Value="3"></asp:ListItem>
                                                <asp:ListItem Text="Employee Wise" Enabled="false"  Value="4"></asp:ListItem>
                                                <asp:ListItem Text="Driver Wise" Enabled="false"  Value="5"></asp:ListItem>
                                                <%--<asp:ListItem   Text="Account Wise" Value="5"></asp:ListItem>--%>
                                            </asp:RadioButtonList>
                                            
                                        </td>
                                          
                                    </tr>
                                     <%--<tr align="center" bgcolor="white">
                                        <td colspan="6">
                                        <asp:CheckBox  ID="RPTSUBCHK" runat="server" CssClass="blackfnt" Text="Group Wise"/>
                                        </td>
                                    </tr>--%>
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
                                    <tr id="tr_acc" runat="server" style="background-color: white; display: none;">
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
                                            <asp:RadioButtonList ID="rptfrt"  RepeatDirection="horizontal"
                                                CssClass="blackfnt" runat="server">
                                                <asp:ListItem Selected="True" Text="HTML Format" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="XLS Format" Value="2"></asp:ListItem>
                                                <asp:ListItem Text="CSV Format" Enabled="false" Value="3"></asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr align="center" id="TRPG" runat="Server" bgcolor="white" style="display: none;">
                                        <td colspan="6">
                                            <font class="blackfnt">Select Page Size </font>
                                            <asp:DropDownList ID="pgSize" CssClass="blackfnt" runat="server">
                                                <asp:ListItem Text="25" Value="25"></asp:ListItem>
                                                <asp:ListItem Text="50" Value="50"></asp:ListItem>
                                                <asp:ListItem Text="100" Value="100"></asp:ListItem>
                                                <asp:ListItem Text="200" Value="200"></asp:ListItem>
                                            </asp:DropDownList>
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
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
