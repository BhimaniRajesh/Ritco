<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_Voucher_register_Query" %>
<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" type="text/javascript" src="./../../Images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="./../../images/commonJs.js"></script>
    <script language="JavaScript" type="text/javascript">
        function cust(ID)
            {
                ///var FrmChild = window.open('../PopUp_Cust.aspx?ID="+ID' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
                var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
                var strPopupURL = "../PopUp_Cust.aspx?ID="+ID
                winNew = window.open(strPopupURL, "_blank", strWinFeature)
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
<asp:UpdatePanel ID="up1" runat="server">
    <ContentTemplate>
    <div align="left">
        <br />
        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
            <ProgressTemplate>
                <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                    <tr>
                        <td align="right"><img src="../../images/loading.gif" alt="" /></td>
                        <td><font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
                    </tr>
                </table>
                <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF;
                    width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                    runat="server">
                    <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                        left: 50%;" ID="Panel2" runat="server">
                    </asp:Panel>
                </asp:Panel>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <br />
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong><font
                            class="blklnkund"><strong>Accounts </strong></font><font class="bluefnt"><strong>&gt;
                            </strong><strong>Voucher Register</strong></font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                    <%--<div align="center">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>--%>
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
                                <font class="blackfnt"><b>Select Voucher Criteria</b></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="4">
                                <Location:LH ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select Voucher Date</font>
                            </td>
                            <td align="left" colspan="3">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                          
                            <tr align="center" bgcolor="white">
                            <td align="left">
                                <asp:Label ID="Label3" CssClass="blackfnt" Text="Select Voucher Type" runat="server"></asp:Label>
                            </td>
                            <td  colspan="3" align="Left">
                                
                                <asp:DropDownList CssClass="blackfnt" ID="DLLVRtyp" runat="server">
                                </asp:DropDownList>
                            </td>
                           
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td align="left">
                                <asp:Label ID="Label4" CssClass="blackfnt" Text="Select Voucher Transaction Type" runat="server"></asp:Label>
                            </td>
                            <td  colspan="3" align="Left">
                                <asp:DropDownList CssClass="blackfnt" ID="DLLTRtyp" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ViewRefno">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white" runat="server" id="trstatus" visible="false">
                            <td align="left">
                                <asp:Label ID="Label6" CssClass="blackfnt" Text="Select Voucher Status" runat="server"></asp:Label>
                            </td>
                            <td  colspan="3" align="Left">
                                <asp:DropDownList CssClass="blackfnt" ID="DLLVRSTATUS" runat="server" Width="100px">
                                    <asp:ListItem Value="N" Text="Generated" Selected="True"></asp:ListItem>
                                    <asp:ListItem Value="Y" Text="Cancelled"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="4"  align="center">
                                <font class="blackboldfnt">OR</font>
                            </td>
                            </tr>
                         <tr align="center" bgcolor="white">
                            <td align="left">
                                <asp:Label ID="Label1" CssClass="blackfnt" Text="Enter Voucher No. " runat="server"></asp:Label>
                            </td>
                            <td  colspan="3" align="Left">
                                
                                <asp:TextBox ID="txtVRnolist" Enabled="true" runat="server" Width="234"></asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                           
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td align="left">
                                <asp:Label ID="Label2" CssClass="blackfnt" Text="Enter Document No. " runat="server"></asp:Label>
                            </td>
                            <td  colspan="3" align="Left">
                                <asp:TextBox ID="txtDocno" Enabled="true" runat="server" Width="234"></asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white" runat="server" id="trrefno" visible="false">
                            <td align="left">
                                <asp:Label ID="Label5" CssClass="blackfnt" Text="Enter Referance No. " runat="server"></asp:Label>
                            </td>
                            <td  colspan="3" align="Left">
                                <asp:TextBox ID="txtRefno" Enabled="true" runat="server" Width="234"></asp:TextBox>
                            </td>
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
                                <asp:Button ID="btnShow" OnClientClick="Javascript:return OnSub_DATACHECK();" OnClick="btnShow_Click"
                                    runat="server" Text="Show" Width="75px" />
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
    </ContentTemplate>
</asp:UpdatePanel>
</asp:Content>
