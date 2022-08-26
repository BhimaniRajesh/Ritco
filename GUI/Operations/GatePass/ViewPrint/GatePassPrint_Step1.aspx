<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="GatePassPrint_Step1.aspx.cs" Inherits="GUI_Operation_DocketEntry_DocketPrint_AutoPrint_Step1" %>


<asp:Content runat="server" ID="cntone" ContentPlaceHolderID="MyCPH1">
<script type="text/javascript" language="javascript" src="../../../images/commonJs.js"></script>
<script type="text/javascript" language="javascript">
    function submitClick()
    {
        var optnumber=document.getElementById("ctl00_MyCPH1_optnumber");
        var optrange=document.getElementById("ctl00_MyCPH1_optrange");
        
        if(optnumber.checked==true)
        {
            var txtdockno=document.getElementById("ctl00_MyCPH1_txtdockno");
            if(txtdockno.value=="")
            {
                alert("Please Enter GatePass Number");
                txtdockno.focus();
                return false;
            }
        }
        
        if(optrange.checked==true)
        {
            var txtstart=document.getElementById("ctl00_MyCPH1_txtstart");
            var txtend=document.getElementById("ctl00_MyCPH1_txtend");
            if(txtstart.value=="")
            {
                alert("Please Enter Start Range");
                txtstart.focus();
                return false;
            }
            
            if(txtend.value=="")
            {
                alert("Please Enter End Range");
                txtend.focus();
                return false;
            }
            
            if(parseInt(txtstart.value)>parseInt(txtend.value))
            {
                alert("Invalid Range.....");
                txtstart.focus();
                txtstart.select();
                return false;
            }
        }
        return true;
    }

</script>
<br /><br />

    <asp:Table runat="server" ID="tblone" CssClass="boxbg" CellSpacing="1">
        <asp:TableRow CssClass="bgbluegrey">
            <asp:TableCell ColumnSpan="2" HorizontalAlign="Center" Font-Bold="true">GatePass Selection</asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell>
            <asp:RadioButton ID="optnumber" Checked="true" runat="server" GroupName="grpauto" CssClass="blackfnt" />
            </asp:TableCell>
            <asp:TableCell><asp:TextBox ID="txtdockno" Width="300px" runat="server" CssClass="blackfnt" BorderStyle="Groove"></asp:TextBox></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell>
               <asp:RadioButton   ID="optrange" runat="server" GroupName="grpauto" CssClass="blackfnt" />
            </asp:TableCell>
            <asp:TableCell>
                <asp:TextBox ID="txtstart" runat="server" MaxLength="20" CssClass="blackfnt" BorderStyle="Groove"></asp:TextBox>-
                <asp:TextBox ID="txtend" runat="server" MaxLength="20"  CssClass="blackfnt" BorderStyle="Groove"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgbluegrey">
            <asp:TableCell HorizontalAlign="Center" ColumnSpan="2">
                <asp:Button ID="btnsubmit" runat="server" OnClick="btnsubmit_Click" OnClientClick="javascript:return submitClick()" CssClass="blackfnt" Text="Submit" />
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>

</asp:Content>
