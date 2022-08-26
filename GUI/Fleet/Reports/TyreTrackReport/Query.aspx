<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_Fleet_Reports_TyreTrackReport_Query" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" type="text/javascript">
        function CheckOnSubmit() {
            // debugger;
            var txtActTyreNo = document.getElementById("MyCPH1_txtActTyreNo");
            var txtManTyreNo = document.getElementById("MyCPH1_txtManTyreNo");

            if (txtActTyreNo.value == "" && txtManTyreNo.value == "") {
                alert("Please Enter Tyre No.");
                return false;
            }

        }
    </script>

    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <iframe frameborder="0" src="about:blank" style="border: 0px; position: absolute;
                z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth);
                height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);">
            </iframe>
            <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);
                top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                <img src="../../../images/loading.gif" /><font face="verdana" color="blue" size="4">&nbsp;<b>Please
                    Wait...</b></font>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <asp:Label ID="Label1" runat="server" Font-Bold="true" Text="Tyre Track Register"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <hr align="left" size="1" color="#8ba0e5">
            </td>
        </tr>
        <tr>
            <td>
                <br />
                <table width="50%" border="1" align="left" cellpadding="0" cellspacing="0" class="boxbg">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="2">
                            <asp:Label ID="Label5" runat="server" Font-Bold="true" Text="Search Criteria"></asp:Label>
                        </td>
                    </tr>
             <%--       <tr class="bgwhite">
                        <td>
                            <asp:Label ID="Label3" runat="server" Text="Enter Actual Tyre Number" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtActTyreNo" runat="server" Text="" Width="250"></asp:TextBox>
                            <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                        </td>
                    </tr>--%>
                    <tr>
                        <td align="center" colspan="2" class="bgwhite">
                            <asp:Label ID="Label4" runat="server" Text="OR" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                    <tr class="bgwhite">
                        <td>
                            <asp:Label ID="Label2" runat="server" Text="Enter Manual Tyre Number" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtManTyreNo" runat="server" Text="" Width="250"></asp:TextBox>
                            <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td colspan="2" align="center">
                            <%--OnClientClick="javascript:return CheckOnSubmit()"--%>
                            <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="Button1_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
