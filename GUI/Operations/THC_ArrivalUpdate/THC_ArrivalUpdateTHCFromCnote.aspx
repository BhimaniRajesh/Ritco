<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="THC_ArrivalUpdateTHCFromCnote.aspx.cs" Inherits="GUI_Operations_THC_ArrivalUpdate_THC_ArrivalUpdateTHCFromCnote" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register TagName="PRB" TagPrefix="PRBAR" Src="~/GUI/Common_UserControls/ProgressBar.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script src="../../images/commonJs.js" language="javascript" type="text/javascript"></script>

    <script src="../../images/CalendarPopup.js" language="javascript" type="text/javascript"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>

    <asp:UpdatePanel ID="upTHCCreate"   UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <br />
            <table cellspacing="1" style="width: 100%">
                <tr style="background-color: white">
                    <td align="left" width="75%">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Text="" Font-Bold="true" runat="server"></asp:Label>
                        <hr align="center" size="1" color="#8ba0e5">
                        <asp:HiddenField ID="hBrCd" runat="server" />
                        <asp:HiddenField runat="server" ID="HiddenField1" />
                        <asp:HiddenField ID="RSDOCTYP" runat="server" />
                        <asp:HiddenField ID="hdnajaxstate" runat="server" Value="0" />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <a href="javascript:window.history.go(-1)" title="back">
                            <img alt="Back" src="./../../images/back.gif" style="border: 0;">
                        </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<PRBAR:PRB ID="PB" runat="server" />
                    </td>
                </tr>
            </table>
            <table cellpadding="2" cellspacing="1" border="0" class="boxbg" id="tblMain" runat="server"
                style="width: 7.5in">
                <tr class="bgbluegrey">
                    <td align="center" colspan="2">
                        <asp:Label ID="lbltblHDR" CssClass="blackfnt" Text="Select Criteria For Arrival/Update"
                            Font-Bold="true" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <asp:Label ID="lbldt" CssClass="blackfnt" runat="server"></asp:Label>
                    </td>
                    <td align="Left">
                        <Date:DT ID="DT" runat="server" />
                    </td>
                </tr>
               <tr bgcolor="white">
                    <td align="center" colspan="2">
                       <asp:RadioButtonList RepeatDirection="Horizontal" ID="RDBLIST" runat="server" CssClass="blackfnt" >
                       <asp:ListItem Text="With Manifest" Value="1" Selected="True" > </asp:ListItem>
                       <asp:ListItem Text="W/O Manifest" Value="2" > </asp:ListItem></asp:RadioButtonList>  </td>
                </tr>
                <tr class="bgbluegrey">
                    <td align="center" colspan="2">
                        <asp:Label ID="Label1" CssClass="blackfnt" Text="OR" Font-Bold="true" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <asp:Label ID="lbkThcno" CssClass="blackfnt" runat="server"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox runat="server" Text="" ID="txtThcnos" Width="250"> </asp:TextBox>
                        <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <asp:Label ID="lbkdktno" CssClass="blackfnt" runat="server"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox runat="server" Text="" ID="txtDKTnos" Width="250"> </asp:TextBox>
                        <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <asp:Label ID="lblVEHNO" CssClass="blackfnt" runat="server"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox runat="server" Text="" ID="txtVEHnos" Width="250"> </asp:TextBox>
                        <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <asp:Label ID="lbllastlog" CssClass="blackfnt" runat="server"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox runat="server" Text="" ID="txtLSTLOCnos" Width="250"> </asp:TextBox>
                        <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                    </td>
                </tr>
                <%--OnClientClick="Javascript: return DateCheck();" OnClick="btnShow_Click"--%>
                <tr bgcolor="white">
                    <td align="center" colspan="2">
                        <asp:Button ID="btnShow" OnClick="btnShow_Click" runat="server" Width="150px" />
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 100;">
    </div>
</asp:Content>
