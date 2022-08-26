<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_LocalCost_Query" %>

<%@ Register TagName="HR" TagPrefix="Location" Src="~/GUI/Common_UserControls/LOC_HRCHY.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	function cust(ID)
        {
         ///var FrmChild = window.open('../PopUp_Cust.aspx?ID="+ID' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
         var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
            var strPopupURL = "./../PopUp_Cust.aspx?ID="+ID
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
	
	function ChkPgsize1(val)
	{	
	     //pgSize=document.getElementById("ctl00_MyCPH1_pgSize"); 
	     if(document.getElementById("ctl00_MyCPH1_DLLRPTTYP_0").checked==true)
	    {
	     document.getElementById('ctl00_MyCPH1_TRPG').style.display = "block";
	     document.getElementById('ctl00_MyCPH1_TRPG1').style.display = "block";
	     document.getElementById('ctl00_MyCPH1_TR2').style.display = "block";
	    }
	    else 
	    {
	    document.getElementById('ctl00_MyCPH1_TRPG').style.display = "none";
	    document.getElementById('ctl00_MyCPH1_TRPG1').style.display = "none";
	    document.getElementById('ctl00_MyCPH1_TR2').style.display = "none";
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

    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>Local Cost Report</strong> </font>
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
                    <table cellspacing="1" cellpadding="3" style="width: 8.5in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Documnets Criteria </asp:Label>
                            </td>
                        </tr>
                        <tr id="Tr1" runat="server" style="background-color: white; display: block;">
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
                            <td align="Left">
                                <font class="blackfnt">Select Booking Date</font> </font>
                            </td>
                            <td align="left">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr id="tr_vend" runat="server" style="background-color: white; display: block;">
                                        <td align="Left">
                                            <asp:Label ID="Label5" CssClass="blackfnt" Text="Select Vendor" runat="server"></asp:Label>
                                        </td>
                                        <td align="Left" >
                                            <asp:TextBox ID="txtVendor" Enabled="true" runat="server" Width="234"></asp:TextBox><input
                                                type="button" onclick="cust('V');" value="..." style="width: 18px; height: 21px"
                                                size="" />
                                            <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                                        </td>
                                    </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="2">
                                <asp:RadioButtonList ID="DLLRPTTYP" onClick="javascript:ChkPgsize1(this);" RepeatDirection="horizontal"
                                    CssClass="blackfnt" runat="server">
                                    <asp:ListItem Selected="True" Text="Register" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Summary" Value="2"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                         <tr align="Left" id="TR2" runat="Server" bgcolor="white" style="display: block;">
                            <td align="left" >
                                <font class="blackfnt">Select PRS/DRS </font></td>
                                 <td >
                                <asp:DropDownList ID="strdoctyp" CssClass="blackfnt" runat="server">
                                    <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="PRS" Value="P"></asp:ListItem>
                                    <asp:ListItem Text="DRS" Value="D"></asp:ListItem>
                                   
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="Left" id="TRPG" runat="Server" bgcolor="white" style="display: block;">
                            <td align="left" >
                                <font class="blackfnt">Select Status </font></td>
                                 <td >
                                <asp:DropDownList ID="pgSize" CssClass="blackfnt" runat="server">
                                    <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="Operationally Closed" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Operationally Not Closed" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Financially Closed" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="Financially Not Closed" Value="4"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="TRPG1" runat="server" style="background-color: white; display: block;">
                            <td align="left">
                                <asp:Label ID="Labesys" CssClass="blackfnt" runat="server" Text=" Document No(s). (System Generated No.) :� "></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox runat="server" Text="" ID="txtsysno" Width="250"> </asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="7">
                                <asp:Button ID="btnShow" OnClick="btnShow_Click" OnClientClick="Javascript: return OnSub_DATACHECK();"
                                    runat="server" Text="Submit" Width="75px" />
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
