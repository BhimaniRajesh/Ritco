<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DataPopUp.aspx.cs" Inherits="GUI_Operation_Singlescreen_docketentry_DataPopUp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript">

        function selectItem(poptp, code1, code2, txtid) {
            if (poptp == "loccode") {
                window.opener.document.getElementById(txtid).value = code1;
                window.close();
            }
        }

        function btncloseClick() {

            var i = 0;
            var locs = "";
            do {
                var chk = document.getElementById("chk" + i.toString());
                var tc1 = document.getElementById("tc1" + i.toString());
                if (chk && chk.checked) {
                    locs = locs + tc1.innerText + ",";
                }
                i++;
            } while (chk);

            locs = locs.substring(0, parseInt(locs.length) - 1);
            if (window.opener.document.getElementById("ctl00_MyCPH1_txtCustCode").value.length > 0) {
                window.opener.document.getElementById("ctl00_MyCPH1_txtCustCode").value += "," + locs;
            }
            else {
                window.opener.document.getElementById("ctl00_MyCPH1_txtCustCode").value = locs;
            }
            window.close();
            return false;

        }

        function checkAll() {

            var chkall = document.getElementById("chkall");
            var i = 0;

            do {
                var chk = document.getElementById("chk" + i.toString());
                if (chk)
                    chk.checked = chkall.checked;

                i++;
            } while (chk);
        }  
  
    </script>

</head>
<body>
    <form id="form1" runat="server">
   
    <asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true">
    </asp:ScriptManager>
    <br />
    <div id="divupgstep3" runat="server" style="left: 400px; position: absolute; elevation: higher;
        background-color: White">
    </div>
  
    <asp:Table CellSpacing="1" ID="tblmain" runat="server" CssClass="boxbg" Style="width: 470px">
        <asp:TableRow CssClass="bgbluegrey">
            <asp:TableCell ID="td1" CssClass="blackfnt" Font-Bold="true" runat="server">
                <asp:CheckBox ID="chkall" runat="server" onclick="javascript:return checkAll();" /></asp:TableCell>
            <asp:TableCell ID="td2" CssClass="blackfnt" Font-Bold="true" runat="server"></asp:TableCell>
            <asp:TableCell ID="td3" CssClass="blackfnt" Font-Bold="true" runat="server"></asp:TableCell>
        </asp:TableRow>
    </asp:Table>
    <asp:Button ID="btnclose" runat="server" Text="Save & Close" Style="position: fixed;
        top: 0px;" Width="100px" CssClass="nbtn" OnClientClick="javascript:return btncloseClick()" />
    </form>
</body>
</html>
