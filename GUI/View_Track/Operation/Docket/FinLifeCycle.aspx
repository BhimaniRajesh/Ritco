<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FinLifeCycle.aspx.cs" Inherits="GUI_Tracking_ver1_Docket_FinLifeCycle" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Finance Life Cycle</title>
    <link rel="stylesheet" type="text/css" href="../../../images/style.css"/>
    <script language="javascript" type="text/jscript">
    function OpenPopupDoc(strDoc,type,doctype)
        {
        if(type=='MR')
            {
                if(doctype=='TBB')
                {
                    var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
                    var strURL = "../../../Finance/MoneyRecipt/MR_Summ_Popup.aspx?mrno=" + strDoc
                    
                    winNew = window.open(strURL,"_blank",strWinFeature)
                }
                else if(doctype=='Octroi')
                {
                    var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
                    var strURL = "../../../Octroi/Octroi_MR/MR_Summ_Popup2.aspx?mrsno=" + strDoc
                    winNew = window.open(strURL,"_blank",strWinFeature)
                }
                else if(doctype=='Misc. MR')
                {
                    var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
                    var strURL = "../../../Finance/MoneyRecipt/MiscMR_Print.aspx?mrsno=" + strDoc
                    winNew = window.open(strURL,"_blank",strWinFeature)
                }
                else
                {
                    var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
                    var strURL = "../../../Operation/DocketEntry/DocketPrint/PaidMR/MR_Summ_Popup.aspx?mrsno=" + strDoc +",0"
                    winNew = window.open(strURL,"_blank",strWinFeature)
                }
            }
//         else if(type=='BILL')
//            {
//                if(doctype=='Misc. BILL')
//                {
//                var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
//                var strURL = "../../../Finance/Billing/Misc/viewPrintpopup.aspx?billno=" + strTHC +",0"
//                winNew = window.open(strURL,"_blank",strWinFeature)
//                }
//                else if (doctype=='Octroi')
//                {
//                var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
//                var strURL = "../../../Octroi/octroi_bill/octroibill_viewprint.aspx?billno=" + strTHC +",0"
//                winNew = window.open(strURL,"_blank",strWinFeature)
//                }
//                else
//                {
//                var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
//                var strURL = "../../../Finance/Billing/BillViewPrint/NewTHCView.aspx?tcno=" + strTHC +",0"
//                winNew = window.open(strURL,"_blank",strWinFeature)
//                }
//            }
//        else if(type=='Vendor Bill Entry')
//            {
//                var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
//                var strURL = "../../../Operations/THC/ViewPrint/NewTHCView.aspx?tcno=" + strTHC +",0"
//                winNew = window.open(strURL,"_blank",strWinFeature)
//            }
                
        }
    
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table style="width: 8.0in" border="0" cellpadding="3" cellspacing="1" class="boxbg">
                <tr class="bgbluegrey">
                    <td colspan="8" nowrap align="center">
                        <font class="blackboldfnt">
                            <%=call_dkt%>
                            Finance Life Cycle</font></td>
                </tr>
                <tr bgcolor="white">
                    <td nowrap align="center">
                        
                                    <asp:GridView Visible="false" align="left" ID="dgDocket" runat="server" BorderWidth="0"
                                        CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                                        AllowPaging="false"  CssClass="boxbg"  style="width: 8.0in"
                                        AutoGenerateColumns="false"  EmptyDataText="No Records Found..."    >
                                        <Columns>
                                            <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                                <ItemTemplate>
                                                    <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                                        runat="server">
                                                    </asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                <HeaderStyle CssClass="blackfnt" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="DOCTYP_str" HeaderText="Doc. Type">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Doc. No.">
                                                <HeaderStyle CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" />
                                                <ItemTemplate>
                                                    <a href="JavaScript:OpenPopupDoc('<%#DataBinder.Eval(Container.DataItem, "DOCNo") %>','<%#DataBinder.Eval(Container.DataItem, "DOCTYP_str") %>','<%#DataBinder.Eval(Container.DataItem, "DOCTYP") %>')">
                                                        <font class="Blackfnt">
                                                            <%#DataBinder.Eval(Container.DataItem, "DOCNo")%></a>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                           <%-- <asp:BoundField DataField="DOCNo" HeaderText="Doc. No.">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>--%>
                                            <asp:BoundField DataField="docdt" HeaderText="Date">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="DOCCLDT" HeaderText="Collection Date">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="DOCLOC" HeaderText="Location">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                            
                                            <asp:BoundField DataField="DOCTYP" HeaderText="Doc. Trans Type">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="DOCST" HeaderText="Doc. Status">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="DOC_CUM" HeaderText="Doc. Cumulative">
                                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                            </asp:BoundField>
                                           
                                            
                                        </Columns>
                                        <RowStyle />
                                        
                                        <HeaderStyle CssClass="bgbluegrey" />
                                       
                                        <FooterStyle CssClass="boxbg" />
                                    </asp:GridView>
                               
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
