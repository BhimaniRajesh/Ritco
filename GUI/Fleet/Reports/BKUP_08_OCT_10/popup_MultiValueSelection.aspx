<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popup_MultiValueSelection.aspx.cs" Inherits="popup_MultiValueSelection" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Vehicle</title>
<script type="text/javascript" language="javascript" src="../../Js/querystring.js" ></script>  
  <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
    <script type="text/javascript" language="javascript">
        function SelectAll(chk,chklist)
        {
            if(chk!=null && chklist!=null)
            {
                var checkBoxList = chklist;
                if(chk.checked == true)
                {
                    if(checkBoxList !=null)
                    {
                        var options = checkBoxList.getElementsByTagName('input');
                        var arrayOfCheckBoxLabels= checkBoxList.getElementsByTagName("label");
                        for(i=0;i<options.length;i++)
                        {
                            var opt = options[i];
                            opt.checked = true;
                        } 
                    }
                }
                else
                {
                    if(checkBoxList !=null)
                    {
                        var options = checkBoxList.getElementsByTagName('input');
                        var arrayOfCheckBoxLabels= checkBoxList.getElementsByTagName("label");
                        for(i=0;i<options.length;i++)
                        {
                            var opt = options[i];
                            opt.checked = false;
                        } 
                    }
                }
            }
        }
        function selectItems() 
        {
            var qs = new Querystring();
            var ctlClientId = window.opener.document.getElementById(qs.get("OpenerCtl"));
            var chkLst=document.getElementById("chkLst");
            if(chkLst!=null)
            {
                var options = chkLst.getElementsByTagName('input');
                var arrayOfCheckBoxLabels= chkLst.getElementsByTagName("label");
                ctlClientId.value = "";
                for(i=0;i<options.length;i++)
                {
                    var opt = options[i];
                    if(opt.checked)
                    {
                        ctlClientId.value = ctlClientId.value+arrayOfCheckBoxLabels[i].innerText+",";
                    }
                } 
                var len=ctlClientId.value.length;
                ctlClientId.value=ctlClientId.value.substring(0,len-1);
            }
            window.close();
        }
    </script>
    <style type="text/css">
        .style1
        {
            width: 100%;
            height: 28px;
        }
    </style>
</head>
<body>

    <form id="form1" runat="server">
   <div>
 <%--<asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>--%>
        <table style="width: 73%" cellpadding="0" cellspacing="1"  class="boxbg">
            <tr  style="background-color: white">
                <td >
                    <asp:Label ID="lbl_Like_Header_Text" runat="server" Text=""></asp:Label>
                </td>
                 <td  >
                     <asp:TextBox ID="tb_TextBoxs"  CssClass="input" runat="server" AutoPostBack="true"
                         ontextchanged="textBox_TextChanged"></asp:TextBox>
                </td>
                 <td  >
                     <asp:CheckBox ID="chk_Select_All" Text="Select All" runat="server" />

                </td>
                <td align="right" >
                    <asp:Button ID="btnSubmit"  runat="server" Text="Submit" OnClientClick="selectItems()" />

                </td>
            </tr>
            <tr  style="background-color: white">
                <td  colspan="4"  width="100%">
                    <asp:Panel ID="pnlLst" height="245px" ScrollBars="Vertical"  runat="server" 
                        Width="936px">
                    <asp:CheckBoxList ID="chkLst" runat="server" Font-Names="Verdana" 
                        Font-Size="8pt" RepeatColumns="4" Width="95%" RepeatDirection="Horizontal" />
                    </asp:Panel>
                        
                </td>
            </tr>
        
        </table>
<%--</ContentTemplate>
    </asp:UpdatePanel>--%>
                  </div>            
     
    </form>
</body>
</html>
