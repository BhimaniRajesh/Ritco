<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="STax_Query.aspx.cs" Inherits="GUI_UNI_MIS_STax_Register_STax_Query"
    Title="Untitled Page" %>


<%@ Register TagName="HR" TagPrefix="Location" Src="~/GUI/Common_UserControls/LOC_HRCHY.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="../../images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1"); 
	    cal.setCssPrefix("TEST");
	    cal.showNavigationDropdowns();
    </script>

    <script language="JavaScript" type="text/javascript">
    	function cust(ID)
        {
         ///var FrmChild = window.open('../PopUp_Cust.aspx?ID="+ID' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
         var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
            var strPopupURL = "./../PopUp_Cust.aspx?ID="+ID
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
    
     function SelectPartyCode()
     {
        var ddl = document.getElementById('ctl00_MyCPH1_ddlSelType');
        if(ddl.value == "0")
        {
           document.getElementById('ctl00_MyCPH1_tr_cust').style.display = "none";
	         document.getElementById('ctl00_MyCPH1_tr_vend').style.display = "none";
        }
        else if (ddl.value == "P")
        {
            document.getElementById('ctl00_MyCPH1_tr_cust').style.display = "block";
	         document.getElementById('ctl00_MyCPH1_tr_vend').style.display = "none";
        }
        else if (ddl.value == "R")
        {
             document.getElementById('ctl00_MyCPH1_tr_cust').style.display = "none";
	         document.getElementById('ctl00_MyCPH1_tr_vend').style.display = "block";
        }
        return false;
     }
     
     function ValidateData()
     {
        if(document.getElementById("ctl00_MyCPH1_ddlSelType"))
         {
           if(document.getElementById("ctl00_MyCPH1_ddlSelType").value == "0")
            {
                alert("Please Select Type");
                document.getElementById("ctl00_MyCPH1_ddlSelType").focus();
                return false;
            }
         }
         
         var Selection=document.getElementById("ctl00_MyCPH1_DT_radDate_0");
         var txtDateFrom=document.getElementById("ctl00_MyCPH1_DT_txtDateFrom");
         var txtDateTo=document.getElementById("ctl00_MyCPH1_DT_txtDateTo");
         
         if(Selection.checked==true)
         {
            if(txtDateFrom.value=="")
		    {
		        alert("Please Enter the From Date")
		        txtDateFrom.focus();
		        return false;
		    }
		    if(txtDateFrom.value!="")
			{
			    if (ValidateForm(txtDateFrom)==false)
				{
					 return false;
				}
			}
		    if(txtDateTo.value=="")
		    {
		        alert("Please Enter the To Date")
		        txtDateTo.focus();
		        return false;
		    }
		    if(txtDateTo.value!="")
			{
				if (ValidateForm(txtDateTo)==false)
				{
					 return false;
				}
			}
     
        }
       
     }
    </script>

 
   <input type="hidden" id="hdnRptId" runat="server" /> <%-- added by Manisha 22/5/2014 --%>
   <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>Service Tax Register �
</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../../images/clear.gif" width="2" height="1"></td>
            </tr>
            <tr>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="./../../images/back.gif" border="0">
                    </a>
                    <div align="Left">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                                <br />
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                </td>
            </tr>
            <tr>
                <td height="300" valign="top">
                    <table id="tblCriteria" runat="server" align="Left" border="0" cellpadding="0"
                        cellspacing="1" class="boxbg" width="700">
                        <tr class="bgbluegrey">
                            <td colspan="2" style="text-align: center; height: 25px;">
                                <strong>Search Criteria</strong></td>
                        </tr>
                        <tr style="background-color: white">
                         <td align="left">
                                <font class="blackfnt">Select
                                   Booking
                                    Location</font>
                            </td>
                            <td align="left">
                                <Location:HR ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                        <td class="blackfnt" style="height: 25px; text-align: left;">
                                &nbsp;Select Date</td>
                            <td style="height: 78px">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td class="blackfnt" style="height: 25px; text-align: left;">
                                &nbsp;Select Type</td>
                            <td style="height: 25px; text-align: left;">
                                &nbsp;<asp:DropDownList ID="ddlSelType" runat="server" CssClass="blackfnt" onchange="javascript: return SelectPartyCode();">
                                    <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Receivable" Value="R"></asp:ListItem>
                                    <asp:ListItem Text="Payable" Value="P"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                          <tr id="tr_cust" runat="server" style="background-color: white; display: none;">
                                        <td align="center">
                                            <asp:Label ID="Label3" CssClass="blackfnt" Text="Select Customer" runat="server"></asp:Label>
                                        </td>
                                        <td align="Left">
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
                                        <td align="Left" >
                                            <asp:TextBox ID="txtVendor" Enabled="true" runat="server" Width="234"></asp:TextBox><input
                                                type="button" onclick="cust('V');" value="..." style="width: 18px; height: 21px"
                                                size="" />
                                            <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                                        </td>
                                        </tr>
                        <tr style="background-color: white">
                            <td class="blackfnt" colspan="2" style="text-align: center">
                                <asp:RadioButtonList ID="rdCType" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Value="C" Selected="True">Collected</asp:ListItem>
                                    <asp:ListItem Value="NC">Not Collected</asp:ListItem>
                                    <asp:ListItem>All</asp:ListItem>
                                </asp:RadioButtonList></td>
                        </tr>
                        <%--<tr style="background-color: white">
                            <td class="blackfnt" colspan="2" style="text-align: center">
                                <asp:RadioButtonList ID="rdXls" runat="server" AutoPostBack="false" CssClass="blackfnt"
                                    RepeatColumns="5" ValidationGroup="VGDtFromTo">
                                    <asp:ListItem Selected="True" Text="HTML Page" Value="N"></asp:ListItem>
                                    <asp:ListItem Text="XLS Download" Value="Y"></asp:ListItem>
                                    <asp:ListItem Value="All">XLS Download For All Voucher Row</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>--%>
                        <tr class="bgbluegrey" style="text-align: center; height: 25px;">
                            <td class="blackfnt" colspan="2" style="text-align: center">
                                <asp:Button ID="btnShowSTax" runat="server" BorderStyle="Solid" Font-Bold="true"
                                    BorderWidth="1px" Text="SUBMIT" Width="90px" OnClick="btnShowSTax_Click" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
        </table>
        <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
            z-index: 99;">
        </div>
</asp:Content>
