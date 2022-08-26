<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PopUpContractID.aspx.cs"
    Inherits="GUI_admin_CustomerContractMaster_PopUpContractID" Title="Untitled Page" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
    <title>Select Contract </title>
</head>

<script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
<script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
<script type="text/javascript" language="javascript">
    
    function selectContractID(id)
    {
         window.opener.document.getElementById("ctl00_MyCPH1_txtcontractid").value=id;
         window.opener.document.getElementById("ctl00_MyCPH1_imgtick").style.display="block";
         window.close();
         return false;
    }
    
    function optClick(obj)
    {
    
        window.opener.document.getElementById("ctl00_MyCPH1_txtcontractid").value=obj.innerText;
        window.opener.document.getElementById("ctl00_MyCPH1_imgtick").style.display="block";
        window.close();
        return false;
    }
    
    function step1Click()
    {
        var cmbpaybas=document.getElementById("cmbpaybas");
        var cmbcustcode=document.getElementById("cmbcustcode");
        
        if(cmbcustcode.value=="" || cmbcustcode.value=="0")
        {
            alert("Plese Select Customer....");
            cmbcustcode.focus();
            return false;
        }
        
         if(cmbpaybas.value=="" || cmbpaybas.value=="0")
        {
            alert("Plese Select Payment Basis....");
            cmbpaybas.focus();
            return false;
        }
        
        return true;
    }
    
</script>

<body>
    <form id="frmone" runat="server">
        <atlas:ScriptManager ID="scrone" runat="server">
        </atlas:ScriptManager>
        <asp:UpdatePanel ID="updone" runat="server">
            <ContentTemplate>
                <asp:Panel ID="divpopup" runat="server" Width="5in" Style="left: 200; top: 100; position: absolute;"
                     HorizontalAlign="Left">
                    <asp:Table ID="tblcontractcri" runat="server" Width="100%" CssClass="boxbg" CellPadding="1"
                        CellSpacing="1" BorderWidth="0">
                        <asp:TableRow CssClass="bgbluegrey">
                            <asp:TableCell CssClass="blackfnt" ColumnSpan="2" Font-Bold="true" HorizontalAlign="Center">
                                <asp:Table runat="server" Width="100%">
                                    <asp:TableRow>
                                        <asp:TableCell ColumnSpan="2">Select Contract</asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow BackColor="White" ID="trcustomer" runat="server">
                            <asp:TableCell HorizontalAlign="Left">Select Customer</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:DropDownList ID="cmbcustcode" DataTextField="custname" DataValueField="custcode"
                                    Width="300px" runat="server" CssClass="blackfnt" BackColor="White">
                                </asp:DropDownList>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow BackColor="White" ID="trpaybas" runat="server">
                            <asp:TableCell HorizontalAlign="Left">Select Payment Basis</asp:TableCell>
                            <asp:TableCell HorizontalAlign="Left">
                                <asp:DropDownList ID="cmbpaybas" DataTextField="custnm" DataValueField="custcd" runat="server"
                                    CssClass="blackfnt" BackColor="White">
                                    <asp:ListItem Selected="True" Text="Select" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Paid" Value="P01"></asp:ListItem>
                                    <asp:ListItem Text="TBB" Value="P02"></asp:ListItem>
                                    <asp:ListItem Text="ToPay" Value="P03"></asp:ListItem>
                                </asp:DropDownList>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgbluegrey" ID="trstep1" runat="server">
                            <asp:TableCell ColumnSpan="2" HorizontalAlign="Right">
                                <asp:Button ID="btnstep1" CssClass="blackfnt" OnClientClick="javascript:return step1Click()"
                                    OnClick="btnstep1_Click" runat="server" Text="Step 1" />
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    <asp:Table ID="tblcontractid" runat="server" style="margin:2px 0px 0px 0px;" Width="5in" CssClass="boxbg" CellSpacing="1">
                    </asp:Table>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
