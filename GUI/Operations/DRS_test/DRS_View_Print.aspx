<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DRS_View_Print.aspx.cs" Inherits="GUI_Tracking_DRS_View_Print" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View/Print DRS</title>
    <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">div.break {page-break-before:always}</style>

    <script language="javascript" type="text/javascript">
    function OpenWindowMR(mrsno,type,printyn)
        {
               printyn="0";
               window.open(" ../../operation/singlescreen_docketentry/docketprint/paidmr/MR_Summ_Popup.aspx?mrsno="+mrsno+","+printyn,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70");
        }
    function OpenWindowDocket(strDocketNo,docsf)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../Operation/Singlescreen_docketentry/DocketPrint/DocketView_xls.aspx?dockno=" + strDocketNo + "&docksf=" + docsf  
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <% string strDRSNo = Request.QueryString.Get("DRSNo");
           string[] Split = strDRSNo.Split(new Char[] { ',' });
           string DRSNo = Convert.ToString(Split[0]);
           string print_yn = Convert.ToString(Split[1]);
           string boxbg = "boxbg";
           string bgbluegrey = "bgbluegrey";
           string strborder = "0";
           string strspace = "1";
           if (print_yn == "1")
           {
               boxbg = "";
               bgbluegrey = "bgwhite";
               strborder = "1";
               strspace = "1";
           }

        %>
        <div>
            <table border='<%=strborder %>' cellspacing='<%=strspace %>' cellpadding="0" class='<%=boxbg %>'
                style="width: 7.0in">
                <tr bgcolor="white">
                    <td width="60%" valign="top">
                        <%--<img src="../../images/webxpress_logo.gif" alt="" />--%>
                        <asp:Image Height="50" ID="imgLogo" runat="server" />
                    </td>
                    <td>
                        <table cellspacing="0" cellpadding="1" class='<%=boxbg %>' width="100%">
                            <tr bgcolor="#FFFFFF">
                                <td width="50%">
                                    <font class="blackfnt">DRS No.</font>
                                </td>
                                <td width="50%">
                                    <font class="blackfnt"><b>
                                        <asp:Label ID="lblDrsNo" runat="server" CssClass="blackfnt"></asp:Label></b></font></td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td width="50%">
                                    <font class="blackfnt">DRS Date.</font>
                                </td>
                                <td width="50%">
                                    <font class="blackfnt"><b>
                                        <asp:Label ID="lblDrsDate" runat="server" CssClass="blackfnt"></asp:Label></b></font></td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td width="50%">
                                    <font class="blackfnt">Manual DRS No.</font>
                                </td>
                                <td width="50%">
                                    <font class="blackfnt"><b></b></font><font class="blackfnt"><b>
                                        <asp:Label ID="lblManualDrsNo" runat="server" CssClass="blackfnt"></asp:Label></b></font></td>
                            </tr>
                            <tr bgcolor="#FFFFFF">
                                <td width="50%">
                                    <font class="blackfnt">DRS Location</font>
                                </td>
                                <td width="50%">
                                    <font class="blackfnt"><b></b></font><font class="blackfnt"><b>
                                        <asp:Label ID="lblDRSlocation" runat="server" CssClass="blackfnt"></asp:Label></b></font></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td colspan="2">
                        <font class="blackfnt">&nbsp; </font>
                    </td>
                </tr>
                <tr bgcolor="#FFFFFF">
                    <td colspan="2" align="left" valign="top">
                        <font class="blackfnt" size="4"><b>Delivery Run Sheet </b></font>
                    </td>
                </tr>
            </table>
            <br />
            <table border='<%=strborder %>' cellspacing='<%=strspace %>' cellpadding="0" class='<%=boxbg %>'
                style="width: 7.0in">
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Vehicle number</font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lblVhclNo" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Driver</font></td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lblDriverNm" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">Starting Km</font></td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lblStartingKM" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">DRS made by</font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lblBaVendor" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">BA/ Vendor name</font></td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lblVendor" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt">End Km</font></td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lblEndingKM" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Delivery charges </font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lbldelyverycharge" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                    <td align="left">
                        <font class="blackfnt"></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt"></font>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Distance</font></td>
                    <td align="left">
                        <font class="blackfnt">
                            <asp:Label ID="lblDistance" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                </tr>
            </table>
            <br />
            <asp:GridView ID="Dockdata" Style="width: 7.0in" ShowFooter="true" FooterStyle-CssClass='<%=boxbg %>'
                EmptyDataText="No Records Found....." AutoGenerateColumns="False" HeaderStyle-CssClass='<%=boxbg %>'
                BackColor="White" runat="server" CellSpacing="1" SelectedIndex="1" OnRowDataBound="Dockdata_RowDataBound">
                <%--BorderColor="#8ba0e5"--%>
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:HiddenField ID="hidCODDOD" Value='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"COD_DOD")) %>'
                                runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Sr.No.">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Font-Bold="true" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center"/>
                        <ItemTemplate>
                            <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            Docket No<br />
                            Pay Basis<br />
                            BKG date<br />
                            EDD<br />
                        </HeaderTemplate>
                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Font-Bold="true" />
                        <ItemStyle Wrap="false" VerticalAlign="Bottom"/>
                        <ItemTemplate>
                           <%-- <asp:Label ID="lbldocketno" CssClass="blackfnt" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"docketno")) %>'
                                runat="server"></asp:Label><br />--%>
                                <a class="bluefnt" href="JavaScript:OpenWindowDocket('<%#DataBinder.Eval(Container.DataItem, "docketno") %>','.')">
                                <%#DataBinder.Eval(Container.DataItem, "docketno")%>
                            </a><br />
                            <asp:Label ID="Label1" CssClass="blackfnt" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"paybasis")) %>'
                                runat="server"></asp:Label><br />
                            <asp:Label ID="Label2" CssClass="blackfnt" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"dockdt")) %>'
                                runat="server"></asp:Label><br />
                            <asp:Label ID="Label3" CssClass="blackfnt" Text='<%# Convert.ToString(DataBinder.Eval(Container.DataItem,"EDD")) %>'
                                runat="server"></asp:Label><br />
                            <asp:Label ID="lblCODDODAmount" CssClass="blackfnt" Text="COD/DOD amount" Font-Bold="true" Visible="false" runat="server"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            Origin-Del Loc<br />
                            From - To
                        </HeaderTemplate>
                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Font-Bold="true" />
                        <ItemStyle VerticalAlign="Bottom" />
                        <ItemTemplate>
                            <asp:Label ID="lblorigin" CssClass="blackfnt" Text='<%# Convert.ToString(DataBinder.Eval( Container.DataItem,"origin"))%>'
                                runat="server"></asp:Label><br />
                            <asp:Label ID="Label4" CssClass="blackfnt" Text='<%# Convert.ToString(DataBinder.Eval( Container.DataItem,"location"))%>'
                                runat="server"></asp:Label><br />
                                 <asp:Label ID="CODDODamount" CssClass="blackfnt" Visible="false" Text='<%# Convert.ToString(DataBinder.Eval( Container.DataItem,"codamount"))%>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            Consignee<br />
                            Consignor
                        </HeaderTemplate>
                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Font-Bold="true" />
                        <ItemStyle VerticalAlign="Bottom" />
                        <ItemTemplate>
                            <asp:Label ID="lblconsignee" CssClass="blackfnt" Text='<%# Convert.ToString(DataBinder.Eval( Container.DataItem,"consignee"))%>'
                                runat="server"></asp:Label><br />
                            <asp:Label ID="lblconsignor" CssClass="blackfnt" Text='<%# Convert.ToString(DataBinder.Eval( Container.DataItem,"consignor"))%>'
                                runat="server"></asp:Label><br />
                                <asp:Label ID="lblCODDODCharge" CssClass="blackfnt" Text="CODDODCharge" Font-Bold="true" Visible="false" runat="server"></asp:Label>
                                
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                        <FooterTemplate>
                            <asp:Label ID="lblGrandTotal" CssClass="blackfnt" Text="Grand Total : " runat="server"
                                Font-Bold="true"></asp:Label>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            PKG<br />
                            WT<br />
                            Mode
                        </HeaderTemplate>
                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Font-Bold="true" />
                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Bottom"/>
                        <ItemTemplate>
                            <asp:Label ID="lblpkgs" CssClass="blackfnt" Text='<%# Convert.ToString(DataBinder.Eval( Container.DataItem,"pkgsno"))%>'
                                runat="server"></asp:Label><br />
                            <asp:Label ID="lblactualweight" CssClass="blackfnt" Text='<%# Convert.ToString(DataBinder.Eval( Container.DataItem,"actualweight"))%>'
                                runat="server"></asp:Label><br />
                            <asp:Label ID="lblTransmode" CssClass="blackfnt" Text='<%# Convert.ToString(DataBinder.Eval( Container.DataItem,"TransMode"))%>'
                                runat="server"></asp:Label><br />
                               
                                 <asp:Label ID="CODDODCharge" CssClass="blackfnt" Visible="false" Text='<%# Convert.ToString(DataBinder.Eval( Container.DataItem,"CODCharges"))%>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                        <FooterTemplate>
                            <asp:Label ID="lbltotpkgs" CssClass="blackfnt" runat="server" Font-Bold="true"></asp:Label><br />
                            <asp:Label ID="lbltotweight" CssClass="blackfnt" runat="server" Font-Bold="true"></asp:Label>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            FRT to be<br />
                            collected Rs.<br />
                            MR Number
                        </HeaderTemplate>
                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Font-Bold="true" />
                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Bottom"/>
                        <ItemTemplate>
                            <asp:Label ID="lblfreight" CssClass="blackfnt" Text='<%# Convert.ToString(DataBinder.Eval( Container.DataItem,"FrieghtAmount"))%>'
                                runat="server"></asp:Label><br />
                            <a class="bluefnt" href="JavaScript:OpenWindowMR('<%#DataBinder.Eval(Container.DataItem, "MR_Number") %>','<%#DataBinder.Eval(Container.DataItem, "MRTYPE") %>',0)">
                                <%#DataBinder.Eval(Container.DataItem, "MR_Number")%>
                            </a><br />
                             <asp:Label ID="lblCODDODCollected" CssClass="blackfnt" Font-Bold="true" Text="CODDODcollected" Visible="false" runat="server"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Bottom" Height="80"/>
                        <FooterTemplate>
                            <asp:Label ID="lbltotfreight" CssClass="blackfnt" runat="server" Font-Bold="true"></asp:Label><br />
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            Time<br />
                            Sign & Stamp
                        </HeaderTemplate>
                        <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Font-Bold="true" />
                        <ItemStyle HorizontalAlign="Right" VerticalAlign="Bottom" Height="80" Width="100" />
                        <ItemTemplate>
                            <asp:Label ID="lbltime" CssClass="blackfnt" runat="server"></asp:Label><br />
                             <asp:Label ID="CODDODCollected" CssClass="blackfnt" Visible="false" Text='<%# Convert.ToString(DataBinder.Eval( Container.DataItem,"CODCollected"))%>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:TemplateField>
                </Columns>
                <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                <HeaderStyle CssClass="white" Font-Bold="true" />
                <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                <FooterStyle CssClass="white" HorizontalAlign="right" Height="80"/>
            </asp:GridView>
            </div>
            <br />
            <table border='<%=strborder %>' cellspacing='<%=strspace %>' cellpadding="0" class='<%=boxbg %>'
                style="width: 7.0in">
                <tr bgcolor="white">
                    <td width="25%" align="left">
                        <font class="blackfnt">&nbsp; </font>
                    </td>
                    <td width="25%" align="left">
                        <font class="blackfnt">&nbsp; </font>
                    </td>
                    <td width="20%" align="center">
                        <font class="blackfnt">
                            <asp:Label ID="lblPreparedBy1" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                    <td width="10%" align="center">
                        <font class="blackfnt">
                            <asp:Label ID="lblAt" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                    <td width="20%" align="center">
                        <font class="blackfnt">
                            <asp:Label ID="lblDateTime" runat="server" CssClass="blackfnt"></asp:Label></font></td>
                </tr>
                <tr bgcolor="white">
                    <td width="25%" align="center">
                        <font class="blackfnt">Staff Name </font>
                    </td>
                    <td width="25%" align="center">
                        <font class="blackfnt">Sign </font>
                    </td>
                    <td width="20%" align="center">
                        <font class="blackfnt">Prepared By </font>
                    </td>
                    <td width="10%" align="center">
                        <font class="blackfnt">At </font>
                    </td>
                    <td width="20%" align="center">
                        <font class="blackfnt">Date &amp; Time </font>
                    </td>
                </tr>
            </table>
            <%
                if (print_yn == "1")
                {
         
            %>

            <script language="javascript" type="text/javascript">
       
        function loadme()
        {
            window.print();
        }
       window.load =loadme()
            </script>

            <%} %>
        </div>
    </form>
</body>
</html>
