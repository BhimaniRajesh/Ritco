<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Agent_Bill_Entry_Done.aspx.cs" Inherits="GUI_Octroi_Ver1_Octroi_Bill_Agent_Bill_Entry_Done" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">

    function ViewPrint(arg1,arg2)
    {
        if(arg2=="0")
        {
            window.open("./Agent_Bill_Entry_ViewPrint.aspx?billno=" + arg1 + "&printyn=" + arg2 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
        else
        {    
            window.open("./Agent_Bill_Entry_ViewPrint1.aspx?billno=" + arg1 + "&printyn=" + arg2 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
    }

    </script>    
    <br />
    <br />
    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 60%"
        align="left">
        <tr class="bgbluegrey">
            <td colspan="3" align="center" style="height: 21px">
                <asp:Label ID="lblQry" CssClass="bluefnt" Font-Bold="True" runat="server">Following Document has Successfully Generated</asp:Label>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 420px">
                <font class="blackfnt">Document Name</font></td>
            <td style="width: 188px">
                <font class="blackfnt">
                    <p align="left">
                        <font class="blackfnt">Document No.</font></p>
                </font>
            </td>
            <td>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 420px">
                <font class="blackfnt"><strong>Bill Entry</strong></font></td>
            <td>
                <asp:Label ID="lblBillNo" runat="server" CssClass="blackfnt" Font-Bold="true">
                       
                </asp:Label></td>
            <td align="center" style ="width:150px">
                <label class="blackfnt">                   
                    <a href="Javascript:ViewPrint('<%=BillNo%>',0)">View </a>| <a href="Javascript:ViewPrint('<%=BillNo%>',1)">
                        Print </a>
                </label>
            </td>
        </tr>
    </table>    
</asp:Content>
