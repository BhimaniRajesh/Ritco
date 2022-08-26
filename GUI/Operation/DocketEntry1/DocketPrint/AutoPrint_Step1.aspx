<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="AutoPrint_Step1.aspx.cs" Inherits="GUI_Operation_DocketEntry_DocketPrint_AutoPrint_Step1" %>


<asp:Content runat="server" ID="cntone" ContentPlaceHolderID="MyCPH1">
<script type="text/javascript" language="javascript" src="../../../images/commonJs.js"></script>
<script type="text/javascript" language="javascript">
    function submitClick()
    {
        var optnumber=document.getElementById("ctl00_MyCPH1_optnumber");
        var optrange = document.getElementById("ctl00_MyCPH1_optrange");
        var hdnReprint = document.getElementById("ctl00_MyCPH1_hdnReprint");
        
        if(optnumber.checked==true)
        {
            var txtdockno=document.getElementById("ctl00_MyCPH1_txtdockno");
            if(txtdockno.value=="")
            {
                alert("Please Enter <%=strdockname %> Number");
                txtdockno.focus();
                return false;
            }
            
           var fileURL = new String(document.location)
           var cnt = fileURL.indexOf("/GUI/", 0);
        
           var hdn_psp_url = document.getElementById("ctl00_MyCPH1_hdn_psp_url");
           window.open(fileURL.substring(0, cnt) + hdn_psp_url.value.substring(1, hdn_psp_url.value.length) + '?reprint=' + hdnReprint.value + '&tp=0&docknos=' +  txtdockno.value, "", null);
        }
        
        if(optrange.checked==true)
        {
            var txtstart=document.getElementById("ctl00_MyCPH1_txtstart");
            var txtend = document.getElementById("ctl00_MyCPH1_txtend");
            
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
            
           var fileURL = new String(document.location)
           var cnt = fileURL.indexOf("/GUI/", 0);
              
           var hdn_psp_url = document.getElementById("ctl00_MyCPH1_hdn_psp_url");
           window.open(fileURL.substring(0, cnt) + hdn_psp_url.value.substring(1, hdn_psp_url.value.length) + '?reprint=' + hdnReprint.value + '&tp=1&start=' + txtstart.value + "&end=" + txtend.value, "", null);
          
        } 
        return false;
    }

</script>
<br /><br />
    <asp:HiddenField ID="hdnReprint" runat="server" />
    <asp:Table runat="server" ID="tblone" CssClass="boxbg" CellSpacing="1">
        <asp:TableRow CssClass="bgbluegrey">
            <asp:TableCell ColumnSpan="2" HorizontalAlign="Center" Font-Bold="true">Computerised <%=strdockname %></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell>
            <asp:RadioButton ID="optnumber" Checked="true" runat="server" GroupName="grpauto" CssClass="blackfnt" />
            </asp:TableCell>
            <asp:TableCell><asp:TextBox ID="txtdockno" Width="300px"  runat="server" CssClass="blackfnt" BorderStyle="Groove"></asp:TextBox></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgwhite">
            <asp:TableCell>
               <asp:RadioButton   ID="optrange" runat="server" GroupName="grpauto" CssClass="blackfnt" />
            </asp:TableCell>
            <asp:TableCell>
                <asp:TextBox ID="txtstart" runat="server" MaxLength="20"  CssClass="blackfnt" BorderStyle="Groove"></asp:TextBox>-
                <asp:TextBox ID="txtend" runat="server" MaxLength="20"  CssClass="blackfnt" BorderStyle="Groove"></asp:TextBox>
            </asp:TableCell>
        </asp:TableRow>
        <asp:TableRow CssClass="bgbluegrey">
            <asp:TableCell HorizontalAlign="Center" ColumnSpan="2">
                <asp:Button ID="btnsubmit" runat="server" OnClientClick="javascript:return submitClick()" CssClass="blackfnt" Text="Submit" />
            </asp:TableCell>
        </asp:TableRow>
    </asp:Table>
    <asp:HiddenField ID="hdn_psp_url" runat="server" />
</asp:Content>
