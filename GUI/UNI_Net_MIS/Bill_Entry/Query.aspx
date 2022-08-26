<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="GUI_UNI_MIS_Bill_Entry_Query" %>


<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="JavaScript" SRC="./../../Images/CalendarPopup.js"></script> 
<script language="javascript" src="./../../images/commonJs.js"></script>
<script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	
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
                        class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong><font
                            class="blklnkund"><strong>Finance </strong></font><font class="bluefnt"><strong>&gt;
                            </strong><strong>Accounts Payable Register</strong></font>
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
        <table cellspacing="1" style="width: 9.0in" class="boxbg" align="left">
            <tr class="bgbluegrey">
                <td colspan="4" align="center" style="height: 21px">
                    <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Bill Criteria </asp:Label>
                </td>
            </tr>
            <tr style="background-color: white">
                            <td align="left" colspan="4">
                                <Location:LH ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                 <tr style="background-color: white">
                <td colspan="2" align="left">
                    <font class="blackfnt" >Enter Vendor</font>
                </td>
                <td colspan="2" align="left"><asp:TextBox  Enabled="false" ID="txtcustcd" runat="server" ></asp:TextBox></td>
               
                </tr>
                <tr style="background-color: white">
                <td colspan="2" align="left">
                    <font class="blackfnt" >Select Bill Type</font>
                </td>
                <td colspan="2" align="left"> <asp:DropDownList ID="DLLBILLTYP" runat="server">
                        <asp:ListItem Selected="True" Text="All" Value="All"></asp:ListItem>
                        <asp:ListItem Text="Expense" Value="Expense"></asp:ListItem>
                        <asp:ListItem Text="THC" Value="THC"></asp:ListItem>
                        <asp:ListItem Text="BA Payment" Value="BA Payment"></asp:ListItem></asp:DropDownList></td>
               
                </tr>
                <tr style="background-color: white">
                <td  align="left">
                    <asp:Label ID="Label2" CssClass="blackfnt" Text="Select " runat="server"
                        ></asp:Label>
                        <asp:DropDownList ID="seldate" runat="server">
                        <asp:ListItem Text="Document Date" Value="billdt"></asp:ListItem>
                        <asp:ListItem Text="Entry Date" Value="ENtrydt"></asp:ListItem></asp:DropDownList>
                </td>
                <td align="left" colspan="3">
                                <Date:DT ID="DT" runat="server" />
                            </td>
               
                </tr>
                <%--<td align="left" valign="top">
                    <asp:UpdatePanel ID="updatepanel9" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="cboRO_Lo_TO" runat="server"  Mode="Conditional"
                                RenderMode="Inline" Width="102px">
                                <%-- <asp:ListItem Text="All" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="cboRO_TO" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>--%>
            </tr>
            <%--<tr align="center" bgcolor="white">
                <td  colspan="7">
                <asp:RadioButtonList onClick="javascript:Chk(this);"  ID="rpttyp" RepeatDirection="horizontal"   CssClass="blackfnt"  runat="server">
                <asp:ListItem  Selected="True" Text="Location Wise " Value="1"></asp:ListItem>
                <asp:ListItem    Text="Employee Wise" Value="2"></asp:ListItem>
                 
                 
                </asp:RadioButtonList>
                 </td>
            </tr>--%>
            <tr bgcolor="white"> <td  colspan="7"></td></tr>
            <tr align="center" bgcolor="white">
                <td  colspan="7">
                <asp:Button  ID="btnShow" OnClick="btnShow_Click" OnClientClick="Javascript:return OnSub_DATACHECK();s"  runat="server" Text="Show" Width="75px" />
                 </td>
            </tr>
        </table>
        
    </div>
     <DIV ID="testdiv1" STYLE="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></DIV>
</asp:Content><%--OnClick="btnShow_Click"--%>
