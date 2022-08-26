<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DataPopUp.aspx.cs" Inherits="GUI_Operation_Singlescreen_docketentry_DataPopUp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>
       
    </title>
    <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />

<script language="javascript" type="text/javascript">

  function selectItem(poptp,code1,code2)
  {
        if(poptp=="csgn")
        {
            window.opener.document.getElementById("ctl00_MyCPH1_txtcsgncd").value=code1;
            window.opener.document.getElementById("ctl00_MyCPH1_txtcsgnnm").value=code2;
            window.close();
        }
        else if(poptp=="editsearchparty")
        {
            window.opener.document.getElementById("ctl00_MyCPH1_txtpartycode").value=code1;
            window.opener.document.getElementById("ctl00_MyCPH1_txtpartyname").value=code2;
            window.close();
        }
        else if(poptp=="csge")
        {
            window.opener.document.getElementById("ctl00_MyCPH1_txtcsgecd").value=code1;
            window.opener.document.getElementById("ctl00_MyCPH1_txtcsgenm").value=code2;
            window.close();
        }
        else if(poptp=="party")
        {
            window.opener.document.getElementById("ctl00_MyCPH1_txtpartycode").value=code1;
            window.opener.document.getElementById("ctl00_MyCPH1_txtpartyname").value=code2;
            window.close();
        }
        else if(poptp=="receiver")
        {
            window.opener.document.getElementById("ctl00_MyCPH1_txtreceivercode").value=code1;
            window.opener.document.getElementById("ctl00_MyCPH1_txtreceivername").value=code2;
            window.close();
        }
        else if(poptp=="delloc")
        {
            window.opener.document.getElementById("ctl00_MyCPH1_txtdelloc").value=code1;
            window.close();
        }
        else if(poptp=="billloc")
        {
            window.opener.document.getElementById("ctl00_MyCPH1_txtbilledat").value=code1;
            window.close();
        }
        else if(poptp=="fromcity")
        {
            window.opener.document.getElementById("ctl00_MyCPH1_txtfrom").value=code1;
            window.close();  
        }
        else if(poptp=="tocity")
        {
            window.opener.document.getElementById("ctl00_MyCPH1_txtto").value=code1;
            window.close();  
        }
        else if(poptp=="csgncity")
        {
            window.opener.document.getElementById("ctl00_MyCPH1_txtcsgncity").value=code1;
            window.close();  
        }
        else if(poptp=="csgecity")
        {
            window.opener.document.getElementById("ctl00_MyCPH1_txtcsgecity").value=code1;
            window.close();  
        }
        else if(poptp=="partyedit")
        {
            window.opener.document.getElementById("ctl00_MyCPH1_txtpartycode").value=code1;
            window.opener.document.getElementById("ctl00_MyCPH1_txtpartyname").value=code2;
            window.close();
        }
        else if(poptp=="billedatedit")
        {
            window.opener.document.getElementById("ctl00_MyCPH1_txtbilledat").value=code1;
            window.close();
        }
  }
</script>

</head>
<body>
<asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true">
        </asp:ScriptManager>
    <form id="form1" runat="server"><br /><br />
        <asp:Table CellSpacing="1" ID="tblsel" runat="server" CssClass="boxbg" style="width:470px">
            <asp:TableRow BackColor="White">
                <asp:TableCell Width="100px" CssClass="blackfnt" ID="tdlblsel1" runat="server"></asp:TableCell>
                <asp:TableCell Width="370px" ID="tdsel1" CssClass="blackfnt" runat="server">
                <asp:TextBox ID="txt1" MaxLength="10" CssClass="blackfnt" BorderStyle="Groove" runat="server"></asp:TextBox>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="White" ID="trsel2" runat="server">
                <asp:TableCell CssClass="blackfnt" ID="tdlblsel2"  runat="server"></asp:TableCell>
                <asp:TableCell ID="tdsel2" CssClass="blackfnt" runat="server">
                    <asp:TextBox ID="txt2" MaxLength="10" CssClass="blackfnt" BorderStyle="Groove" runat="server"></asp:TextBox>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="Center" ID="tdsubmit" ColumnSpan="2" CssClass="blackfnt" runat="server">
                    <asp:Button ID="btnsubmit" runat="server" Text="Submit" OnClick="btnsubmit_Click" CssClass="blackfnt" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    <br />
     <div id="divupgstep3" runat="server" style="left: 400px; position: absolute; elevation: higher;
                background-color: White">
                <asp:UpdateProgress ID="upgstep3" runat="server">
                    <ProgressTemplate>
                        <div id="progressArea">
                            <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                            <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </div>
    <br /><br />
        <asp:Table CellSpacing="1" ID="tblmain" runat="server" CssClass="boxbg" style="width:470px">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell ID="td1" CssClass="blackfnt" Font-Bold="true" runat="server">Select</asp:TableCell>
                <asp:TableCell ID="td2" CssClass="blackfnt" Font-Bold="true" runat="server"></asp:TableCell>
                <asp:TableCell ID="td3" CssClass="blackfnt" Font-Bold="true" runat="server"></asp:TableCell>
            </asp:TableRow>        
        </asp:Table>
    </form>

</body>
</html>
