<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Query.aspx.cs" Inherits="Octroi_Agent_Voucher_Query" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
function getdata()
{
    if(document.getElementById("ctl00_MyCPH1_txtDateFrom").value == "")
    {
        alert("Please Enter the From Date")
        return false
    }
    if(document.getElementById("ctl00_MyCPH1_txtDateTo").value == "")
    {
        alert("Please Enter the To Date")
        return false
    }
   
}
function checkdata(rbtAgent,rbtAgeBill,rbtBillEntry,cboAgent,txtAgeBill,txtBillEntry,btnShowBill)
{
    if (rbtAgent.checked==true)
      {        
        if(cboAgent.value=="")
		     {
		      alert("Please Select Octroi Agent!!!")
		      cboAgent.focus();
		      return false;
		     }
	    }	
      else if (rbtAgeBill.checked==true)
      {
        if(txtAgeBill.value=="")
		     {
		      alert("Please enter the Agent Bill No!!!")
		      txtAgeBill.focus();
		      return false;
		     }
          }	
      else if (rbtBillEntry.checked==true)
      {
      	     if(txtBillEntry.value=="")
		     {
		      alert("Please enter the Bill Entry Number!!!")
		      txtBillEntry.focus();
		      return false;
		     }    		 
      }	
      
      if((rbtAgent.checked==false)&&(rbtAgeBill.checked==false)&&(rbtBillEntry.checked==false)) 
      {
		      alert("Please select Bill For!!!")
		      rbtAgent.focus();
		      return false;
      }       
}

    </script>

    <center>
        &nbsp;</center>
    <center>
        &nbsp;</center>
    <center>
        <asp:UpdatePanel ID="UpdatePanel6" runat="server"    UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <table cellspacing="1" class="boxbg" style="width: 70%">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="3">
                            <asp:Label ID="lblQry" runat="server" CssClass="blackfnt" Font-Bold="True">Select Agent Bill Date</asp:Label></td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" style="width: 146px">
                            &nbsp;<asp:Label ID="lblDateRange1" runat="server" CssClass="blackfnt" Font-Bold="False"
                                Width="144px">Select Date</asp:Label>
                            &nbsp; &nbsp; &nbsp;
                        </td>
                        <td align="left" valign="top">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server"   UpdateMode="Conditional" RenderMode="Inline">
                                <ContentTemplate>
                                    <asp:RadioButtonList ID="radDate" runat="server" AutoPostBack="true" CssClass="blackfnt"
                                        OnSelectedIndexChanged="radDate_OnSelectedIndexChange" ValidationGroup="VGDtFromTo"
                                        Width="210px">
                                        <asp:ListItem Selected="True" Text=" Date Range [dd/mm/yyyy]" Value="0"></asp:ListItem>
                                        <asp:ListItem Text=" Last Week (Including Today)" Value="1"></asp:ListItem>
                                        <asp:ListItem Text=" Today:" Value="2"></asp:ListItem>
                                        <asp:ListItem Text=" Till Date:" Value="3"></asp:ListItem>
                                        <%--<asp:ListItem Text=" Till Date:" Value="3"></asp:ListItem>          --%>
                                    </asp:RadioButtonList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                        <td align="left" valign="top">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
                                <ContentTemplate>
                                    <asp:Label ID="lblFrom" runat="server" CssClass="blackfnt" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                    <asp:Label ID="lblTo" runat="server" CssClass="blackfnt" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                    <br />
                                    <%--<asp:RequiredFieldValidator ID="RFVFromDate" runat="server" ControlToValidate="txtDateFrom"
                            CssClass="blackfnt" ErrorMessage="Date From cannot be blank :(" ValidationGroup="VGDtFromTo"></asp:RequiredFieldValidator>
                        <br />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtDateFrom"
                            ErrorMessage="Invalid Date From  :(" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                            ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator>
                        <br />
                        <asp:RequiredFieldValidator ID="RFVToDate" runat="server" ControlToValidate="txtDateTo"
                            CssClass="blackfnt" ErrorMessage="Date To cannot be blank :(" ValidationGroup="VGDtFromTo"></asp:RequiredFieldValidator>
                        <br />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtDateTo"
                            ErrorMessage="Invalid Date To  :(" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                            ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator><br />
                        <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="To date can not be smaller than from date "
                            OnServerValidate="ToDate"></asp:CustomValidator>--%>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" colspan="3">
                            &nbsp;<asp:Label ID="lblQuery" runat="server" CssClass="blackfnt" Font-Bold="True"
                                Text="Select Bill For"></asp:Label></td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" style="width: 146px">
                            &nbsp;<asp:Label ID="lblSelAgent" runat="server" CssClass="blackfnt" Font-Bold="False"
                                Text="Select Agent"></asp:Label></td>
                        <td align="left" colspan="2">
                            &nbsp;<asp:RadioButton ID="rbtAgent" runat="server" Checked="true" AutoPostBack="true"
                                OnCheckedChanged="rbtAgent_CheckedChanged" /><asp:DropDownList ID="cboAgent" runat="server"
                                    ValidationGroup="VGDtFromTo">
                                </asp:DropDownList>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" style="width: 146px">
                            &nbsp;<asp:Label ID="lblSelAgeBill" runat="server" CssClass="blackfnt" Font-Bold="False"
                                Text="Enter Agent Bill No"></asp:Label>
                        </td>
                        <td align="left" colspan="2">
                            &nbsp;<asp:RadioButton ID="rbtAgeBill" runat="server" AutoPostBack="true" OnCheckedChanged="rbtAgeBill_CheckedChanged" /><asp:TextBox
                                ID="txtAgeBill" runat="server" Width="93px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" style="width: 146px">
                            &nbsp;<asp:Label ID="lblBillEntry" runat="server" CssClass="blackfnt" Font-Bold="False"
                                Text="Enter Bill Entry No" Width="120px"></asp:Label>
                        </td>
                        <td align="left" colspan="2">
                            &nbsp;<asp:RadioButton ID="rbtBillEntry" runat="server" AutoPostBack="true" OnCheckedChanged="rbtBillEntry_CheckedChanged" /><asp:TextBox
                                ID="txtBillEntry" runat="server" Width="93px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="center" colspan="3">
                            <asp:Button ID="btnShowBill" runat="server" OnClientClick="return getdata()" Text="Show Bill (s) >>"
                                OnClick="btnShowBill_Click" /></td>
                        <%--OnClick="btnShowBill_OnClick"--%>
                        <%--OnClientClick='javascript:return checkdata(" + rbtAgent.ClientID + "," + rbtAgeBill.ClientID + "," + rbtBillEntry.ClientID + "," + cboAgent.ClientID + "," + txtAgeBill.ClientID + "," + txtBillEntry.ClientID + "," + radDate.ClientID + "," + txtDateFrom.ClientID + "," + txtDateFrom.ClientID + "," + btnShowBill.ClientID + ")'--%>
                        <%--<asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
                ShowSummary="False" />--%>
                    </tr>
                </table>
                &nbsp;
            </ContentTemplate>
        </asp:UpdatePanel>
        &nbsp;</center>
    <center>
        &nbsp;</center>
</asp:Content>
