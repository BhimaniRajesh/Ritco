<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="FrmDocketDetail.aspx.cs" Inherits="FrmDocketDetail" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script language="javascript" type="text/javascript" >
function columnhide()
{
    //debugger
    var ipb = "<%=inactpaybas%>"
    var arr = ipb.split(",")
    var rows = document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows.length;
    for(p=0;p<=arr.length-1;p++)
    {
         if (arr[p] == "P04")
         {
            document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[0].deleteCell(9)//1st Row
            for(i=1;i<rows;i++)
            {
                if (document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].cells.length > 1)
                {
                    if(document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].cells[0].innerText != "Total")//datarow without total
                    {
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(24)
                    }
                    else//datarow begin with total
                    {
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(22)
                    }   
                }
            }
         }
         else if (arr[p] == "P09")
         {
            document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[0].deleteCell(7)//1st Row
            for(i=1;i<rows;i++)
            {
                if (document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].cells.length > 1)
                {
                    if(document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].cells[0].innerText != "Total")//datarow without total
                    {
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(19)
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(19)
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(19)
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(19)
                    }
                    else//datarow begin with total
                    {
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(17)
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(17)
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(17)
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(17)
                    }   
                }
            }
         }
        else if(arr[p] == "P08")
        {
            document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[0].deleteCell(6)//1st Row
            for(i=1;i<rows;i++)
            {
                if (document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].cells.length > 1)
                {
                    if(document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].cells[0].innerText != "Total")
                    {
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(15)//datarow without total
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(15)
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(15)
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(15)
                    }
                    else
                    {
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(13)//datarow begin with total
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(13)
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(13)
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(13)
                    }   
                }
            }
         }
         else if(arr[p] == "P03")
         {
            document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[0].deleteCell(5)//1st Row
            for(i=1;i<rows;i++)
            {
                if (document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].cells.length > 1)
                {
                    if(document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].cells[0].innerText != "Total")
                    {
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(11)//datarow without total
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(11)
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(11)
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(11)
                    }
                    else
                    {
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(9)//datarow begin with total
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(9)
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(9)
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(9)
                    }   
                }
            }
         }
         else if(arr[p] == "P02")
         {
            document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[0].deleteCell(4)//1st Row
            for(i=1;i<rows;i++)
            {
                if (document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].cells.length > 1)
                {
                    if(document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].cells[0].innerText != "Total")
                    {
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(7)//datarow without total
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(7)
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(7)
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(7)
                    }
                    else
                    {
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(5)//datarow begin with total
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(5)
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(5)
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(5)
                    }   
                }
            }
         }
         else if(arr[p] == "P01")
         {
            document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[0].deleteCell(3)//1st Row
            for(i=1;i<rows;i++)
            {
                if (document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].cells.length > 1)
                {
                    if(document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].cells[0].innerText != "Total")
                    {
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(3)//datarow without total
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(3)
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(3)
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(3)
                    }
                    else
                    {
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(1)//datarow begin with total
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(1)
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(1)
                        document.getElementById("ctl00_MyCPH1_GrdToPayFollow").rows[i].deleteCell(1)
                    }   
                }
            }
         }   
    }
}
</script> 
    <div align="left">
        <br />
        <table style="width: 1000px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Operation.aspx"><font class="blklnkund">
                            <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Sales Summary Report</b></font>
                </td>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img src="../../images/back.gif" border="0" alt="" /></a>
                </td>
            </tr>
        </table>
        <br />
        <table border="0" cellspacing="1" cellpadding="3" cols="2" width="50%" class="boxbg">
            <tr bgcolor="#FFFFFF">
                <td align="left" width="28%">
                    <font class="blackfnt"><b>Date :</b></font>
                </td>
                <td colspan="3" align="left">
                    <font class="blackfnt">
                        <asp:Label ID="lblDateRange" runat="server" Width="350px"></asp:Label></font>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td colspan="4" align="left">
                    <div align="center">
                        <font class="blackfnt"><b>Location :</b></font>
                    </div>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td colspan="2" align="left">
                    <div align="center">
                        <font class="blackfnt"><b>From</b></font>
                    </div>
                </td>
                <td colspan="2" align="left">
                    <div align="center">
                        <font class="blackfnt"><b>To</b></font>
                    </div>
                </td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="left" width="28%">
                    <font class="blackfnt"><b>RO :</b></font>
                </td>
                <td align="left" colspan="3">
                    <font class="blackfnt">
                        <asp:Label ID="lblRO" runat="server" Width="350px"></asp:Label></font></td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="left" width="28%">
                    <font class="blackfnt"><b>Location :</b></font>
                </td>
                <td align="left" colspan="3">
                    <font class="blackfnt">
                        <asp:Label ID="lbllocation" runat="server" Width="350px"></asp:Label></font></td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td colspan="4" align="left">
                    &nbsp;</td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="left">
                    <font class="blackfnt"><b>Customer Code:</b></font>
                </td>
                <td colspan="3" align="left">
                    <font class="blackfnt">
                        <asp:Label ID="lblccode" runat="server" Width="350px"></asp:Label></font></td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="left">
                    <font class="blackfnt"><b>Pay Basis</b></font>
                </td>
                <td colspan="3" align="left">
                    <font class="blackfnt">
                        <asp:Label ID="lblpaybas" runat="server" Width="350px"></asp:Label></font></td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="left">
                    <font class="blackfnt"><b>Mode</b></font>
                </td>
                <td colspan="3" align="left">
                    <font class="blackfnt">
                        <asp:Label ID="lblmode" runat="server" Width="350px"></asp:Label></font></td>
            </tr>
            <tr bgcolor="#FFFFFF">
                <td align="left">
                    <font class="blackfnt"><b>Report Type:</b></font>
                </td>
                <td colspan="3" align="left">
                    <font class="blackfnt">
                        <asp:Label ID="lblrpttype" runat="server" Width="350px"></asp:Label></font></td>
            </tr>
        </table>
        <asp:TextBox ID="TxtTDt" runat="server" Visible="false"></asp:TextBox>
        <asp:TextBox ID="TxtFDt" runat="server" Visible="false"></asp:TextBox><br />
        <br />
        <table>
            <tr>
                <td>
                    <asp:GridView ID="GrdToPayFollow" CssClass="boxbg" OnPageIndexChanging="PageIndexChanged_Click"
                        PagerStyle-Mode="NumericPages" PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"
                        BorderWidth="0" runat="server" Width="762px" OnRowCreated="GrdToPayFollow_RowCreated"
                        OnRowDataBound="GrdToPayFollow_RowDataBound1" EmptyDataRowStyle-CssClass="blackfnt" EmptyDataText="No Records Found !!!" CellPadding="5" CellSpacing="1">
                        <HeaderStyle CssClass="bgbluegrey" />
                        <Columns>
                            <asp:TemplateField HeaderText="Sr.No" HeaderStyle-CssClass="blackfnt" ItemStyle-CssClass="blackfnt">
                            <ItemStyle BackColor="white" HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <asp:Label ID="LblSrNo" CssClass="blackfnt" runat="server" Text="Sr.No"></asp:Label></ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Center" BackColor="white"/>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <br />
                    <asp:Button ID="cmdexcel" OnClick="cmdexcel_Click" runat="server" Text="Excel" BackColor="White"
                        Width="54px"></asp:Button>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
