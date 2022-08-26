<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="IndentViewQuery.aspx.cs" Inherits="GUI_Operations_Indent_ViewPrint_IndentViewQuery" %>

<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagPrefix="PgBar" TagName="ProgressBar" %>
<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LOC_HRCHY.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="JavaScript"  type="text/javascript" src="../../../Images/CalendarPopup.js"></script>
<script language="javascript"  type="text/javascript" src="../../../images/commonJs.js"></script>

<script language="javascript" type="text/javascript">
    function ViewPrint(IndNo) {
        window.open("IndentView.aspx?IndentNo=" + IndNo, "es", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=1000,height=290,status=no,left=60,top=125");
    }
</script>
<script type="text/javascript" language="JavaScript">
    var cal = new CalendarPopup("testdiv1");
    cal.setCssPrefix("TEST");
    cal.showNavigationDropdowns();
</script>

<table cellspacing="1" style="width: 50%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server" Text="Indent View"></asp:Label>
            </td>
        </tr>
    </table>
    <br/><br/>
    <div>
    <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="50%">
        <tr class="bgbluegrey">
            <td align="center" colspan="2">
                <asp:Label ID="lblHeader" runat="server"  Font-Bold="true" Text="Indent View" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        <tr class="bgwhite">
            <td align="left">
                Select Location
            </td>
            <td>
                <Location:LH ID="Fromlc" runat="server"  />
            </td>
        </tr>
        <tr class="bgwhite">
            <td align="left">
                Select Date
            </td>
            <td>
                <Date:DT ID="DT" runat="server" />
            </td>
        </tr>
        <tr class="bgwhite blackboldfnt">
            <td align="center" colspan="2">
                OR
            </td>
        </tr>
        <tr class="bgwhite">
             <td align="left">
                <asp:Label runat="server" ID="lblIndentNo" Text="Select IndentNumber" ></asp:Label>
            </td>
             <td align="left">
                <asp:TextBox runat="server" ID="txtIndentNo"  Width="300px"></asp:TextBox>
            </td>
        </tr>
        <tr class="bgbluegrey">
            <td align="center" colspan="2">
                <asp:Button runat="server" ID="btnSubmit" Text="Submit" Width="100px" OnClick="btnSubmit_Click" />
            </td>
        </tr>
         
        <tr  bgcolor="white" >
            <td ID="trrepeter" runat="server" class="blackfnt" colspan="3" style="display:none">
                <table class="boxbg" border="0" cellpadding="3" cellspacing="1" style="width: 100% ;">
                            <tr align="center" class="bgbluegrey blackboldfnt">
                                <td>Sl.No</td>
                                <td>Indent Number</td>
                                <td></td>
                            </tr>
                            <asp:Repeater ID="rptIndentList" runat="server" >
                                <ItemTemplate>
                                    <tr class="bgwhite">
                                        <td align="center">
                                            <%#Container.ItemIndex+1 %> 
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"IndentNumber")%>'></asp:Label> 
                                        </td>
                                        <td align="center">
                                            <a href="Javascript:ViewPrint('<%# DataBinder.Eval(Container.DataItem,"IndentNumber")%>',0)"><b>View</b></a>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                 </table>
            </td>
        </tr>
    </table>
  </div>
<pgbar:progressbar runat="server" id="ProgressBar" />
<div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;layer-background-color: white; z-index: 99;"></div>
</asp:Content>
