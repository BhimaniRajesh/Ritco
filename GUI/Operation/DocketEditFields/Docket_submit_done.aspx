<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Docket_submit_done.aspx.cs" Inherits="GUI_Operation_Singlescreen_docketentry_Docket_submit_done" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script src="../../images/commonJs.js" type="text/javascript" language="javascript"></script>

    <script type="text/javascript" src="../../images/dropdowncontent.js"></script>

    <script language="javascript" type="text/javascript">
 
 function popupmenu2()
 { 
  var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
  var hdndockno=document.getElementById("ctl00_MyCPH1_hdndockno");
  confirmWin=window.open('../DocketEntry/DocketPrint/DocketView_xls.aspx?dockno=' + hdndockno.value + '&docksf=.',"",winOpts);
 }  
    </script>

    <br />
    <div align="left" style="width: 10in;">
        <table style="width: 9.5in;" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    <img src="../../images/clear.gif" width="15" height="10"></td>
            </tr>
            <tr>
                <td>
                    <img src="../../images/clear.gif" width="15" height="10"></td>
            </tr>
            <tr>
                <td>
                    <table border="0" cellspacing="1" class="boxbg">
                        <tr class="bgbluegrey" style="height: 25px">
                            <td align="left" colspan="3" style="height: 25px">
                                <font class="blackfnt"><b>Following document has been successfully Generated</b></font></td>
                        </tr>
                        <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman; height: 25px">
                            <td align="left" nowrap>
                                <font class="blackfnt">&nbsp;&nbsp;&nbsp;&nbsp;Document Name&nbsp;&nbsp;&nbsp;&nbsp;</font>
                            </td>
                            <td style="width: 398px" align="center">
                                <font class="blackfnt">Document Number</font>
                            </td>
                            <td style="width: 339px">
                            </td>
                        </tr>
                        <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman; height: 25px">
                            <td align="center">
                                <font class="blackfnt">
                                    <%=dkt_call %>
                                </font>
                            </td>
                            <td style="width: 398px" align="center">
                                <asp:Label ID="lbldockno" runat="server" CssClass="blackfnt" Width="313px"></asp:Label></td>
                            <td style="width: 339px" align="center">
                                <a href="javascript:popupmenu2()" runat="server" id="ankone"><u>View</u></a>
                            </td>
                        </tr>
                        <tr bgcolor="#FFFFFF" id="tredit" runat="server">
                            <td bgcolor="#FFFFFF"  align="center" style="width: 9185px; height: 25px">
                                <table border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td align="center" class="bullet">
                                            <img src="../../../images/clear.gif" width="4" height="4" /></td>
                                    </tr>
                                </table>
                            </td>
                            <td width="100%" align="left" bgcolor="#FFFFFF" colspan="2" style="height: 25px">
                                <font class="blackfnt"><u><a href="DocketEdit_Step1.aspx"><font class="blklnkund">Click
                                    here to Edit
                                    <%=dkt_call %></a></u></font>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdndockno" runat="server" />
    </div>
</asp:Content>
