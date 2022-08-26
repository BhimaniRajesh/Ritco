<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_AccessRightReport_Query" %>
<%@ Register tagPrefix="ajaxToolkit" namespace="AjaxControlToolkit" assembly="AjaxControlToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
       
	    function onOk()
        {
            var checkBoxList = document.getElementById("<%=chklstUsers.ClientID %>");
            if(checkBoxList !=null)
            {
                var options = checkBoxList.getElementsByTagName('input');
                var arrayOfCheckBoxLabels= checkBoxList.getElementsByTagName("label");
                document.getElementById("<%=txtUsers.ClientID %>").value="";
                for(i=0;i<options.length;i++)
                {
                    var opt = options[i];
                    if(opt.checked)
                    {
                        document.getElementById("<%=txtUsers.ClientID %>").value = document.getElementById("<%=txtUsers.ClientID %>").value+arrayOfCheckBoxLabels[i].innerText+",";
                    }
                } 
                var str=document.getElementById("<%=txtUsers.ClientID %>").value;
                var len=str.length;
                str=str.substring(0,len-1);
                document.getElementById("<%=txtUsers.ClientID %>").value = str;
            }
            return;
        }
        function onCancel()
        {
            document.getElementById("<%=txtUsers.ClientID %>").value="";
            var checkBoxList = document.getElementById("<%=chklstUsers.ClientID %>");
            if(checkBoxList !=null)
            {
                var options = checkBoxList.getElementsByTagName('input');
                var arrayOfCheckBoxLabels= checkBoxList.getElementsByTagName("label");
                for(i=0;i<options.length;i++)
                {
                    var opt = options[i];
                    opt.checked = false;
                } 
            }
            return;
        }
    </script>
       <input type="hidden" id="hdnRptId" runat="server" /> <%-- added by Manisha 23/5/2014 --%>

<table width="80%" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong>
                <font  class="blklnkund"><strong>Reports </strong></font><strong>&gt; </strong>
                <font class="blklnkund"><strong>Operation </strong></font><strong>&gt; </strong>
                <font class="bluefnt"><strong>Access Rights Report</strong></font>&nbsp;</td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="../../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr>
            <td>
                <img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>        
        <tr>
            <td valign="top">
                <br />
                <br />
                <div align="left">
                    <table cellspacing="1" style="width: 9.0in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Sales Criteria </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td  align="left">
                                <asp:Label ID="Label1" CssClass="blackfnt" runat="server">Select Users :</asp:Label>
                            </td>
                            <td align="left">
                                <asp:UpdatePanel ID="UpdatePanel4" runat="server"   UpdateMode="Conditional">
                                    <ContentTemplate>
                                        <asp:TextBox ID="txtUsers" runat="server" CssClass="input" Width="386px" Style="font-size: 8pt;
                                            font-family: Verdana"></asp:TextBox>                                        
                                        <asp:Button ID="lnkbtnSelect" runat="server" Text="..." ToolTip="Select Users" />
                                        <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender1" runat="server" EnableViewState="False" 
                                                TargetControlID="lnkbtnSelect" PopupControlID="Panel1"
                                                BackgroundCssClass="modalBackground" DropShadow="True" OkControlID="btnSubmit"
                                                OnCancelScript="onCancel()" OnOkScript="onOk()" CancelControlID="btnCancle"
                                              >
                                        </ajaxToolkit:ModalPopupExtender>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <asp:Panel ID="Panel2" runat="server" Height="1px" Width="1px">
                                    <asp:Panel ID="Panel1" runat="server" BackColor="White" >
                                        <table cellspacing="0" cellpadding="3" style="margin:10px 10px 10px 10px;">
                                            <tbody>
                                                <tr>
                                                    <td style="vertical-align: top; text-align: left; ">
                                                        <asp:Panel Style="vertical-align: top; text-align: left" ID="pnlModal" runat="server"
                                                            Font-Size="10pt" BackColor="White" Font-Names="Verdana" Height="300" Width="400"
                                                            ScrollBars="Vertical">
                                                            <asp:UpdatePanel ID="UpdatePanel6" runat="server"  UpdateMode="Conditional">
                                                                <ContentTemplate>
                                                                    <asp:CheckBoxList ID="chklstUsers" runat="server" Font-Size="8pt" Font-Names="Verdana"
                                                                        RepeatDirection="Horizontal" RepeatColumns="5" CellSpacing="0"
                                                                        CellPadding="3">
                                                                    </asp:CheckBoxList>
                                                                    <br />
                                                                </ContentTemplate>
                                                            </asp:UpdatePanel>
                                                        </asp:Panel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100%; height: 24px; text-align: center">
                                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit"></asp:Button>
                                                        <asp:Button ID="btnCancle" runat="server" Text="Cancle"></asp:Button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </asp:Panel>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label2" CssClass="blackfnt" runat="server">Access Rights For :</asp:Label>
                            </td>
                            <td align="left">
                                <asp:RadioButtonList ID="redFor" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Text="Menu" Value="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Reports" Value="2" ></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr class="bgbluegrey">
                            <td align="center" colspan="2" style="height: 21px">
                                <asp:Button runat="server" ID="btnView" Text="View Report" OnClick="btnView_OnClick" />
                            </td>
                        </tr>
                   </table>
                </div>
            </td>
        </tr>
</table>        
</asp:Content>

