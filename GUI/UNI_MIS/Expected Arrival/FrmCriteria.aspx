<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="FrmCriteria.aspx.cs" Inherits="FrmCriteria" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
 <script language ="javascript" type ="text/javascript">
    
    function BranchPopup(strPopupURL)
            {
                var strWinFeature = "height=280,width=350,resizable=yes,scrollbars=yes,left=420,top=5"
                winNew = window.open(strPopupURL, "_blank", strWinFeature)
                return false
            }
    </script>
   <%-- <script type="text/javascript" language="javascript" src="../../../CAL/datetimepicker.js"></script>
<link href="../../../CAL/popcalendar.css" type="text/css" rel="stylesheet" />
<script language="javascript" type="text/javascript" src="../../../CAL/popcalendar.js"></script>--%>
    
  <%--  <script language ="javascript" type ="text/javascript" src= "CalendarControl.js" >--%>
 <%-- <LINK rel="stylesheet" type="text/css" href="../../../GUI/UNI_MIS/TOPay_Followup/CalendarControl.css" />
   </script>
--%>
        &nbsp;
        <br />
        <div align="left" >
    <table style="width: 1000px">
    <tr>
    <td  align="left">  
        <a><font class="blklnkund"><b>Module</b></font></a>
							<b> &gt; </b>
							<a><font class="blklnkund"><b>Reports</b></font></a>
							<b> &gt; </b>
							<a href="../rpt_Operation.aspx"><font class="blklnkund"><b>Operations</b></font></a>
							<b> &gt; </b>
							<font class="bluefnt"><b>Expected Arrival Report</b></font>
	</td>
	<td align="right">
	    <a href="javascript:window.history.go(-1)"  title="back"><img src="../../images/back.gif" border="0" alt="" /></a>
	</td>
    </tr>
    </table>
    <br />
    <table border="0" cellpadding="0" cellspacing="1" class="boxbg" style="width: 398px;
        height: 19px">
        <tr class="bgbluegrey">
            <td align="center" class="blackfnt" colspan="3" style="height: 23px">
                Select Criteria
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" class="blackfnt"  style="width: 43px; height: 23px">
                Location</td>
            <td style="width: 136px; height: 23px">
                <div align="left">
                    <asp:TextBox ID="TextBox1" runat="server" Width="55px"></asp:TextBox>&nbsp;
                    <asp:Button CausesValidation="false" ID="BtnCustCode" runat="server" OnClientClick = 'return BranchPopup("FrmCCodePopUp.aspx")' Width="39px"/>&nbsp;</div>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="left" class="blackfnt" style="width: 43px; height: 20px">
                Status&nbsp;</td>
            <td style="width: 136px; height: 20px">
                <div align="left">
                <asp:UpdatePanel ID="UpdatePanel3"  UpdateMode="Conditional" RenderMode="Inline" runat="server">
                <ContentTemplate>
                                
                    <asp:DropDownList ID="CmbRptType" runat="server">
                        <asp:ListItem>All</asp:ListItem>
                        <asp:ListItem>Yet to Arrive</asp:ListItem>
                        <asp:ListItem>Departed</asp:ListItem>
                        <asp:ListItem>Completed</asp:ListItem>
                    </asp:DropDownList>&nbsp;</div>
                    </ContentTemplate> 
                    </asp:UpdatePanel> </div> 
            </td>
        </tr>
    </table>
    </div> 
    <div align="center" style="width:398px">
        <br />
        <asp:Button ID="CmdSubmit" runat="server" Text="Submit" OnClick="CmdSubmit_Click" /><br />
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
            ShowSummary="False" />
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
                        ErrorMessage="Location Can Not Be Blank" ForeColor="White"></asp:RequiredFieldValidator>
                        
        &nbsp;</div> 
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
    &nbsp;<br />
        &nbsp;
    </asp:Content>
