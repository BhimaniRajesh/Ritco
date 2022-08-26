<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_MIS_OUT_STD_Query" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" type="text/javascript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
    
    window.onload=function()
	{
	 document.getElementById("ctl00_MyCPH1_rpttyp_SUB_0").disabled=true
	 
	}
    
    function cust(ID)
        {
         ///var FrmChild = window.open('../PopUp_Cust.aspx?ID="+ID' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
         var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
            var strPopupURL = "../PopUp_Cust.aspx?ID="+ID
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
    function ChkCust(val)
	{
	    
	    if(document.getElementById("ctl00_MyCPH1_rpttyp_0").checked==true || document.getElementById("ctl00_MyCPH1_rpttyp_1").checked==true)
	    {
	        document.getElementById("ctl00_MyCPH1_rpttyp_SUB_1").disabled=false
	        document.getElementById("ctl00_MyCPH1_rpttyp_SUB_0").disabled=true
	    }
	    else
	    {
	        document.getElementById("ctl00_MyCPH1_rpttyp_SUB_1").disabled=true
	        document.getElementById("ctl00_MyCPH1_rpttyp_SUB_0").disabled=false
	    }
	    
	    if(document.getElementById("ctl00_MyCPH1_rpttyp_3").checked==true )
	    {
	        document.getElementById("ctl00_MyCPH1_txtasondt_to").disabled=false
	          document.getElementById("ctl00_MyCPH1_RPT_DATE_0").disabled=true
	        document.getElementById("ctl00_MyCPH1_RPT_DATE_1").disabled=true
	        document.getElementById("ctl00_MyCPH1_RPT_DATE_2").disabled=true
	        document.getElementById("ctl00_MyCPH1_DT_radDate_0").disabled=true
	        document.getElementById("ctl00_MyCPH1_DT_radDate_1").disabled=true
	        document.getElementById("ctl00_MyCPH1_DT_radDate_2").disabled=true
	        
	        document.getElementById("ctl00_MyCPH1_DT_txtDateFrom").disabled=true
	        document.getElementById("ctl00_MyCPH1_DT_txtDateTo").disabled=true
	       
	    }
	    else 
	    {
	        document.getElementById("ctl00_MyCPH1_txtasondt_to").disabled=true
	         document.getElementById("ctl00_MyCPH1_RPT_DATE_0").disabled=false
	        document.getElementById("ctl00_MyCPH1_RPT_DATE_1").disabled=false
	        document.getElementById("ctl00_MyCPH1_RPT_DATE_2").disabled=false
	        document.getElementById("ctl00_MyCPH1_DT_radDate_0").disabled=false
	        document.getElementById("ctl00_MyCPH1_DT_radDate_1").disabled=false
	        document.getElementById("ctl00_MyCPH1_DT_radDate_2").disabled=false	
	        
	           document.getElementById("ctl00_MyCPH1_DT_txtDateFrom").disabled=false
	        document.getElementById("ctl00_MyCPH1_DT_txtDateTo").disabled=false      
	    }
	}
	function OnSub_DATACHECK()
     {
        
     
     //alert("HIii")
        if(!DateCheck())
            return false;
      //  alert("HIii")
        if(!FinDateCheck())
            return false;             
     }
     
    </script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();

    </script>

    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong><font
                            class="blklnkund"><strong>Finance </strong></font><font class="bluefnt"><strong>&gt;
                            </strong><strong>Account Receivable  </strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                    <div align="center">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="./../../images/back.gif" border="0" />
                    </a>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <table cellspacing="1" style="width: 8.0in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="4">
                                <font class="blackfnt"><b>Select Bill Criteria</b></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="4">
                                <Location:LH ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" width="200">
                                <font class="blackfnt">Select Bill Type</font>
                            </td>
                            <td align="left" colspan="3">
                                <asp:DropDownList ID="Bill_Type" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select Bill Date</font>
                            </td>
                            <td align="left" colspan="3">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr id="Tr1" visible="false" runat="server" style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label12" CssClass="blackfnt" Text="Select Account" runat="server"></asp:Label></td>
                            <td align="left" colspan="3" valign="top">
                                <asp:DropDownList ID="DLLAcc" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        
                        <tr  align="center" bgcolor="white"><td align="left" width="100">
                                <font class="blackfnt">As On Date</font>
                            </td>
                            <td colspan="3" align="left" width="300">
                                <asp:TextBox ID="txtasondt" Width="60" MaxLength="10" runat="server"></asp:TextBox>
                                <a href="#" onclick="cal.select(ctl00$MyCPH1$txtasondt,'anchor3','dd/MM/yyyy'); return false;"
                                    name="anchor3" id="a3">
                                    <img src="./../../images/calendar.jpg" id="i1" runat="server" border="0" />
                                </a>
                                <asp:Label ID="Label3" CssClass="blackfnt" runat="server" Text=" To"></asp:Label>
                                <asp:TextBox ID="txtasondt_to" Width="60" Enabled="false" MaxLength="10" runat="server"></asp:TextBox>
                                <a href="#" onclick="cal.select(ctl00$MyCPH1$txtasondt_to,'anchor45','dd/MM/yyyy'); return false;"
                                    name="anchor45" id="a45">
                                    <img src="./../../images/calendar.jpg" id="i2" runat="server" border="0" />
                                </a>
                            </td></tr> <tr align="center" bgcolor="white">
                            <td align="left">
                                <asp:Label ID="Label2" CssClass="blackfnt" Text="Select Date Type " runat="server"></asp:Label>
                            </td>
                            <td colspan="3" align="left">
                                <asp:RadioButtonList  ID="RPT_DATE" RepeatDirection="horizontal" CssClass="blackfnt"
                                    runat="server">
                                    <asp:ListItem  Text="Generation Date" Selected="true" Value="bgndt"></asp:ListItem>
                                    <asp:ListItem Text="Submission Date" Value="bsbdt"></asp:ListItem>
                                    <asp:ListItem Text="Collection Date" Value="bcldt"></asp:ListItem>
                                </asp:RadioButtonList></td>
                                 
                        </tr>
                          <tr align="center" bgcolor="white">
                            <td align="left">
                                <asp:Label ID="Label1" CssClass="blackfnt" Text="Select Customer" runat="server"></asp:Label>
                            </td>
                            <td  colspan="3" align="Left">
                                <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <asp:ListBox ID="LT_CUST_VEND" Width="250" Height="100" SelectionMode="multiple"
                                            runat="server" CssClass="blackfnt"></asp:ListBox>
                                    </ContentTemplate>
                                </asp:UpdatePanel>--%>
                                <%--<asp:ListItem Text="All" Value="All" Selected="True">
                                </asp:ListItem>--%>
                                <asp:TextBox ID="txtCustomer" Enabled="true" runat="server" Width="234"></asp:TextBox><input
                                    type="button" onclick="cust('C');" value="..." style="width: 18px; height: 21px"
                                    size="" />
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                           
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="4">
                                <asp:RadioButtonList ID="rpttyp" RepeatDirection="horizontal" CssClass="blackfnt"
                                    runat="server" onClick="javascript:ChkCust(this);">
                                    <asp:ListItem Text="Location Wise" Selected="True" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Location Wise Age Wise" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Customer Wise Age Wise" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="Customer Wise " Value="4"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="4">
                                <asp:RadioButtonList ID="rpttyp_SUB" RepeatDirection="horizontal" CssClass="blackfnt"
                                    runat="server">
                                    <asp:ListItem Text="Location Wise" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Customer Wise" Value="2"></asp:ListItem>
                                </asp:RadioButtonList></td>
                        </tr>
                       
                      
                        <tr align="center" bgcolor="white">
                            <td colspan="4">
                                <asp:RadioButtonList ID="rptmd" RepeatDirection="horizontal" CssClass="blackfnt"
                                    runat="server">
                                    <asp:ListItem Text="HTML Format" Selected="true" Value="N"></asp:ListItem>
                                    <asp:ListItem Text="XLS Download" Value="Y"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="4">
                                <asp:Button ID="btnShow" OnClientClick="Javascript:return OnSub_DATACHECK();" OnClick="btnShow_Click" runat="server" Text="Show" Width="75px" />
                                <%--OnClientClick="Javascript: return DateCheck();"--%>
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
