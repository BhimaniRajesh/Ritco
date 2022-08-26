<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="AddNewContract.aspx.cs" Inherits="GUI_admin_CustomerContractMaster_AddNewContract" %>

<asp:Content runat="server" ContentPlaceHolderID="MyCPH1" ID="cntone">
  <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
<script type="text/javascript" language="javascript">
  var cal = new CalendarPopup("divDate");
  cal.setCssPrefix("TEST");
  cal.showNavigationDropdowns();

    function submitClick()
    {
        var txtstartdate=document.getElementById("ctl00_MyCPH1_txtstartdate");
        var txtenddate=document.getElementById("ctl00_MyCPH1_txtenddate");
        var cmbpaybas=document.getElementById("ctl00_MyCPH1_cmbpaybas");
        
        if(cmbpaybas.value=="" || cmbpaybas.value=="0")
        {
            alert("Plese Select Payment Basis....");
            cmbpaybas.focus();
            return false;
        }
        
        if(txtstartdate.value=="")
        {
            alert("Plese Ener Start Date....");
            txtstartdate.focus();
            return false;
        }
        
        if(txtenddate.value=="")
        {
            alert("Plese Ener End Date....");
            txtenddate.focus();
            return false;
        }
        
        return true;
    }
       
//// this function assignment in keypress doesn't allow any character other than number.
//function validInt(obj)
//{
//    if(!obj)
//    {
//        if(event.keyCode==13)
//            {
//                return true;
//            }
//        if(event.keyCode<48 || event.keyCode>57)
//        {
//            event.keyCode=0;return false;
//        }
//    }
//    else
//    {
//         var charCode = obj ? obj.which : event.keyCode;
//         if(charCode==8 || charCode==0 || charCode==13)
//            return true;
//            
//         if(charCode<48 || charCode>57)
//         {
//            return false;
//         }
//    }
//}
// 
// this function assignment in keypress doesn't allow any character other than number.
function validDate(obj)
{
    if(!obj)
    {
        if(event.keyCode==13 || event.keyCode==47)
            {
                return true;
            }
        if(event.keyCode<48 || event.keyCode>57)
        {
            event.keyCode=0;return false;
        }
    }
    else
    {
         var charCode = obj ? obj.which : event.keyCode;
         if(charCode==8 || charCode==0 || charCode==13 || charCode==47)
            return true;
            
         if(charCode<48 || charCode>57)
         {
            return false;
         }
    }
}
 

// onkeypress="javascript:return validInt.apply(this,arguments)"       

</script>
<asp:UpdatePanel ID="updone" runat="server">
<ContentTemplate>
<br /><br /><br />
    <asp:Panel Width="10in" runat="server" HorizontalAlign="Center" style="text-align:center">
        <asp:Table runat="server" Width="70%" CssClass="boxbg" CellPadding="1" CellSpacing="1" BorderWidth="0">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell ColumnSpan="4" CssClass="blackfnt" Font-Bold="true" HorizontalAlign="Center">Add New Contract</asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="White">
                <asp:TableCell HorizontalAlign="Left">Customer Code & Name</asp:TableCell>
                <asp:TableCell ColumnSpan="3" HorizontalAlign="Left">
                   <asp:Label ID="lblcustcodename" Font-Bold="true" CssClass="blackfnt" runat="server"></asp:Label>
                   <asp:HiddenField ID="hdncustcode" runat="server" />
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="White">
                <asp:TableCell HorizontalAlign="Left">Select Payment Basis</asp:TableCell>
                <asp:TableCell HorizontalAlign="Left" ColumnSpan="3">
                    <asp:DropDownList ID="cmbpaybas" runat="server" CssClass="blackfnt" BackColor="White">
                        <asp:ListItem Selected="True" Text="Select" Value="0"></asp:ListItem>
                        <asp:ListItem Text="Paid" Value="P01"></asp:ListItem>
                        <asp:ListItem Text="TBB" Value="P02"></asp:ListItem>
                        <asp:ListItem Text="ToPay" Value="P03"></asp:ListItem>
                    </asp:DropDownList>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="White">
                <asp:TableCell HorizontalAlign="Left">Start Date</asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                
                    <asp:TextBox ID="txtstartdate" Style="border-style: groove;" runat="server" CssClass="blackfnt"
                      onkeypress="javascript:return validDate.apply(this,arguments);"  Width="70px" MaxLength="10"></asp:TextBox>
                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtstartdate, 'lnkstartdate', 'dd/MM/yyyy'); return false;"
                        name="alnkvaliduntil" id="lnkstartdate">
                        <img src="../../images/calendar.jpg" alt="" border="0" />
                    </a>&nbsp;(dd/mm/yyyy)&nbsp;
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">End Date</asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                <asp:TextBox ID="txtenddate" Style="border-style: groove;" runat="server" CssClass="blackfnt"
                       onkeypress="javascript:return validDate(this,arguments);" Width="70px" MaxLength="10"></asp:TextBox>
                    <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtenddate, 'lnkenddate', 'dd/MM/yyyy'); return false;"
                        name="alnkvaliduntil" id="lnkenddate">
                        <img src="../../images/calendar.jpg" alt="" border="0" />
                    </a>&nbsp;(dd/mm/yyyy)&nbsp;
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell ColumnSpan="4" HorizontalAlign="Center">
                    <asp:Button ID="btnsubmit" CssClass="blackfnt" OnClientClick="javascript:return submitClick()" OnClick="btnsubmit_Click" runat="server" Text="Submit" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
           <asp:UpdateProgress ID="uppMain" runat="server">
                <ProgressTemplate>
                    <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%;
                            left: 40%;" width="190px" cellpadding="0"
                        bgcolor="white">
                        <tr>
                            <td align="right">
                                <img src="../../images/loading.gif" alt="" />
                            </td>
                            <td>
                                <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                            </td>
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
        <br /><br />
        <asp:Label ID="lblerror" style="display:none;" runat="server" CssClass="redfnt" Font-Bold="true"></asp:Label>
         <div id="divDate" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
    </asp:Panel>
    </ContentTemplate>
</asp:UpdatePanel>
</asp:Content>
