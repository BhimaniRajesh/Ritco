<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master"   AutoEventWireup="true" CodeFile="genbilldone2.aspx.cs" Inherits="Finance_Billing_Billgeneration_genbilldone2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/jscript">
    function OpenPopupWindow(strbillno)
    {
        var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
        var strPopupURL = "../BillViewPrint/FrmAreaBillView.aspx?billno=" + strbillno
        winNew = window.open(strPopupURL, "_blank", strWinFeature)
    }
     function OpenPopup(Bill_Number) 
        { 
            window.open("../BillViewPrint/BillNo_Popup_RITCO.aspx?Bill_No=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
     function OpenPopupPRRL(Bill_Number) 
        { 
            window.open("../BillViewPrint/BillNo_Popup_RITCO.aspx?Bill_No=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
    function OpenPopupEXL(Bill_Number) 
        { 
            window.open("../BillViewPrint/BillNo_Popup_RITCO.aspx?Bill_No=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
    function OpenPopupRCI(Bill_Number) 
        { 
            window.open("../BillViewPrint/BillNo_Popup_RITCO.aspx?Bill_No=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }    
    function OpenPopupUFL(Bill_Number) 
        { 
            window.open("../BillViewPrint/BillNo_Popup_RITCO.aspx?Bill_No=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
</script>
    
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
     <link href="../../../images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>--%>
   <%-- <form id="form1" runat="server">--%>
    <div>
    <table  style="width:10in" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr><td><font class="blackfnt"><b><a href="../../../welcome.aspx"><font class="blklnkund"><strong>Module</strong></font></a><strong> &gt; </strong></font>
   <a href="#"><font class="blklnkund"><strong>Finance</strong></font>    </a> 
   <strong> &gt; </strong><a href="../Billing.aspx"=><font class="blklnkund"><strong>Billing</strong> </font></a>
   &gt; <font class="bluefnt"><strong>  
		  Bill Generation
		   
		  </strong> </font>
   </td></tr>
     <tr> 
          <td><img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>

        <tr><td>
    
     <table   border="0" cellpadding="1" cellspacing="1" class="boxbg"  style="width:10in"  align="center">
       <tr bgcolor="white" style="height:25px">
            <td colspan="2" align="center" style="height: 25px"><font class="blackfnt"><b> Bill Generated Successfully !!!</b></font></td>
            
       </tr>
       <tr bgcolor="white" style="height:25px" >
       <td colspan="2" align="center" style="height: 25px">
        <asp:GridView align="center" ID="dockdata" runat="server" BorderWidth="1" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"
CssClass="boxbg" BackColor="white" FooterStyle-CssClass="boxbg"
PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" 

EmptyDataText="No Records Found..." OnRowDataBound="dockdata_RowDataBound"   >

<%--OnPageIndexChanging="pgChange"--%>
<Columns >


<%--<asp:BoundField DataField="billno" HeaderText="Bill No" >

<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>--%>
<asp:TemplateField HeaderText="Bill Number">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "billno") %>')">
                            <font cssclass="Blackfnt"></font>
                                <%#DataBinder.Eval(Container.DataItem, "billno")%></a>
                    </ItemTemplate>
</asp:TemplateField>
                
<asp:BoundField DataField="Billbranch" HeaderText="Billin Branch" ItemStyle-Wrap="false">
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>

<asp:BoundField DataField="Partynm" HeaderText="Party Name"  HeaderStyle-Wrap="false"  ItemStyle-Wrap="false">
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt"  Width="200" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>


<asp:BoundField DataField="paybas" HeaderText="Bill Type" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>

<asp:BoundField DataField="Billamt" HeaderText="Bill Amt." >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>
<asp:BoundField DataField="bgndt" HeaderText="Generation Date" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>
<asp:BoundField DataField="bsbdt" HeaderText="Submission Date" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>
<asp:BoundField DataField="bduedt" HeaderText="Due Date"   ItemStyle-Wrap="false">
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>


<asp:BoundField DataField="bcldt" HeaderText="Collection Date" >
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>
<asp:BoundField DataField="Billstatus" HeaderText="Billstatus" ItemStyle-Wrap="false">
<HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
<ItemStyle CssClass="blackfnt" />
</asp:BoundField>
 <asp:TemplateField HeaderText="Covering Letter">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopup('<%#DataBinder.Eval(Container.DataItem, "billno") %>')">
                            <font cssclass="Blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "billno")%></a>
                    </ItemTemplate>
 </asp:TemplateField>
 <asp:TemplateField HeaderText="Covering Letter(PRRL)">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <%--<asp:LinkButton ID="lnkletter" CssClass="blackfnt" Font-Underline="true" Text='<%# DataBinder.Eval( Container.DataItem,"billno") %>' runat="server"></asp:LinkButton> --%>
                        <a href="JavaScript:OpenPopupPRRL('<%#DataBinder.Eval(Container.DataItem, "billno") %>')">
                            <font cssclass="Blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "billno")%></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Covering Letter(EXL)">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <%--<asp:LinkButton ID="lnkletter" CssClass="blackfnt" Font-Underline="true" Text='<%# DataBinder.Eval( Container.DataItem,"billno") %>' runat="server"></asp:LinkButton> --%>
                        <a href="JavaScript:OpenPopupEXL('<%#DataBinder.Eval(Container.DataItem, "billno") %>')">
                            <font cssclass="Blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "billno")%></a>
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField HeaderText="Covering Letter(RCI)">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupRCI('<%#DataBinder.Eval(Container.DataItem, "billno") %>')">
                            <font class="Blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "billno")%></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Covering Letter(UFL)">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupUFL('<%#DataBinder.Eval(Container.DataItem, "billno") %>')">
                            <font class="Blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "billno")%></a>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Bill Details">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkbilldtl" CssClass="blackfnt" Font-Underline="true" Text='<%# DataBinder.Eval( Container.DataItem,"billno") %>'
                            runat="server" OnClick="xls1"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Portrait">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkportrait" CssClass="blackfnt" Font-Underline="true" Text='<%# DataBinder.Eval( Container.DataItem,"billno") %>'
                            runat="server" OnClick="xls2"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="W/O Invoice">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkbillwoinv" CssClass="blackfnt" Font-Underline="true" Text='<%# DataBinder.Eval( Container.DataItem,"billno") %>'
                            runat="server" OnClick="xls3"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

</Columns>
<RowStyle />
<PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
<HeaderStyle CssClass="bgbluegrey" />
<PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast"
/>
<FooterStyle CssClass="boxbg" />
</asp:GridView>
  </td>
</tr>
<tr ><td colspan="2" align="left" style="height: 25px" class="bgbluegrey" ><font class="blackfnt" ><b>Your Next Step:</b></font></td></tr>
<tr  bgcolor="#FFFFFF"> 
                              <td width="2%" height="25" bgcolor="#FFFFFF"> <table border="0" cellspacing="0" cellpadding="0">
                                  <tr> 
                                    <td class="bullet"><img src="../../../images/clear.gif" width="4" height="4"></td>
                                  </tr>
                                </table></td>
                              <td width="100%" align="left" bgcolor="#FFFFFF" height="18" colspan="3"><font class="blackfnt"><u><a href="start.aspx"><font class="blklnkund">Click 
                                here to generate more bills</a></u></font></td>
                                
</tr>
<tr  bgcolor="#FFFFFF"> 
                              <td width="2%" height="25" bgcolor="#FFFFFF"> <table border="0" cellspacing="0" cellpadding="0">
                                  <tr> 
                                    <td class="bullet"><img src="../../../images/clear.gif" width="4" height="4"></td>
                                  </tr>
                                </table></td>
                              <td width="100%" align="left" bgcolor="#FFFFFF" height="18" colspan="3"><font class="blackfnt"><u><a href="../Billsubmission/start.aspx"><font class="blklnkund">Click 
                                here to Submit  bills</a></u></font></td>
                                
</tr>
 <tr  bgcolor="#FFFFFF"> 
                              <td width="2%" height="25" bgcolor="#FFFFFF"> <table border="0" cellspacing="0" cellpadding="0">
                                  <tr> 
                                    <td class=bullet><img src="../../../images/clear.gif" width="4" height="4" /></td>
                                  </tr>
                                </table></td>
                              <td width="100%" align="left" bgcolor="#FFFFFF" height="18" colspan="3"><font class="blackfnt"><u><a href="javascript:flist()"><font class="blklnkund"> 
                                View & Print bills</a></u></font></td>
                                
</tr>

       </table>
       
       <table border="1" id="tblxls1" visible="false" runat="server">
            <tr>
                <td align="left" class="blackfnt">
                    <%--<img ID="imgLogo" src="../../../images/webxpress_logo.gif" runat="server" />--%>
                </td>
            </tr>
            <tr>
            </tr>
            <tr align="left">
                <td colspan="3" class="blackfnt">
                    <font class="blackfnt">Service Tax No:DLI/ST/CH/27/2002/Centralised Registration</font></td>
            </tr>
            <tr>
                <td class="blackfnt" align="left" colspan="3" style="height: 21px">
                    <font class="blackfnt">PAN : AAACR6342M</font></td>
            </tr>
            <tr align="left">
            </tr>
            <tr align="left">
                <td class="blackfnt" style="width: 1874px; height: 21px;">
                    <asp:Label ID="lblpartyname" runat="server" Text="" Width="296px"></asp:Label>
                    <asp:Label ID="lbldash" runat="server" Text=" : " Width="1px"></asp:Label>
                    <asp:Label ID="lblpbillno" runat="server" Text="" Width="302px"></asp:Label>
                </td>
            </tr>
            <tr>
            </tr>
            <tr>
            </tr>
            <tr>
                <td class="blackfnt" style="width: 1874px">
                    <asp:GridView ID="GrdXLS1" OnRowDataBound="GrdXLS1_RowDataBound" PagerStyle-Mode="NumericPages"
                        CssClass="boxbg" PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"
                        BackColor="white" runat="server" SelectedIndex="1" EmptyDataText="No Records Found For Docket Details ....!!">
                        <Columns>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblsrno" CssClass="blackfnt" Text="<%# Container.DataItemIndex+1 %>"
                                        runat="server"></asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Date">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldate" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dockdt") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Docket No">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldockno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dockno") %>'></asp:Label>
                                    <asp:Label ID="lbldocksf" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"docksf") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Consignee">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblconsignee" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"csgenm") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mode Of Trans">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblmode" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"trn_mod") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="From">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblfrom" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"orgncd") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="To">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblto" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"reassign_destcd") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Pcs.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblpcs" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"pkgsno") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Charge Wt.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblchargewt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"chrgwt") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Invoice No.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblinvoiceno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"dockno") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Rate">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblrate" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"frt_rate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Freight">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblfreight" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"freight") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="D.C.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldc" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dktchg") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="FOV">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblfov" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"fov") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Other Charge">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblotchg" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"otchg") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Door Collection Charges">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldccharge" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dccharge") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Door Delivery Charges">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblddcharge" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"ddcharge") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Handling Charges">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblhldchrg" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"hld_chrg") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Critical State Charges">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblstatechrg" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"state_chrg") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Sunday/Holiday Delivery Charge">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblhlddlychrg" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"hld_dlychrg") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="N-Form Clearance Charge">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblnformchrg" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"nform_chrg") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="To Pay Collection Charge">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblfodcharge" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"fodcharge") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Diesel Charge">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldieselcharge" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"diesel_chrg") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="COD/DOD">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblcoddod" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"codchg") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="S.Tax">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblsvctax" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"svctax") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Cess">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblcess" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"cess") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Total">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldkttot" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dkttot") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="remark">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblremark" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"spl_svc_req") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
        <br />
        <table visible="false" runat="server" id="tblxls2" width="500" border="1" cellspacing="0"
            cellpadding="0">
            <tr>
                <td colspan="2" rowspan="2">
                    <%--<img src="../../../images/webxpress_logo.gif" width="80" height="20" border="0">--%>
                </td>
                <td height="26" nowrap>
                    &nbsp;</td>
                <td height="26" colspan="3" nowrap>
                    <div align="left">
                        <font class="blackfnt"><strong>Attachment
                            <br>
                            of Bill No.</strong></font><font class="blackfnt"> :-&nbsp;</font><font class="blackfnt"><asp:Label
                                ID="lblABillNo" runat="server"></asp:Label>
                            </font>
                    </div>
                </td>
                <td colspan="5" align="center" valign="middle" nowrap>
                    <div align="center">
                        <font class="blackfnt"><strong></strong></font>
                    </div>
                </td>
                <td>
                    &nbsp;</td>
                <td colspan="2">
                    <font class="blackfnt">Page No </font>
                </td>
                <td width="56">
                    &nbsp;</td>
            </tr>
            <tr>
                <td width="25">
                    &nbsp;</td>
                <td width="23">
                    &nbsp;</td>
                <td width="26">
                    &nbsp;</td>
                <td width="22">
                    &nbsp;</td>
                <td width="23">
                    &nbsp;</td>
                <td width="29">
                    &nbsp;</td>
                <td width="26">
                    &nbsp;</td>
                <td width="22">
                    &nbsp;</td>
                <td width="28">
                    &nbsp;</td>
                <td width="28">
                    &nbsp;</td>
                <td width="28">
                    &nbsp;</td>
                <td width="38">
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <%--<td width="44" nowrap> <div align="center"><font class=blackfnt><strong>Dkt 
          No.</strong></font></div></td>
      <td nowrap style="width: 50px"> 
        <div align="center"><font class=blackfnt><strong>Dkt Date</strong></font></div></td>
      <td width="25" nowrap> <div align="center"><font class=blackfnt><strong>From</strong></font></div></td>
      <td width="23" nowrap> <div align="center"><font class=blackfnt><strong>To 
          </strong></font></div></td>
      <td width="26" nowrap> <div align="center"><font class=blackfnt><strong>Md</strong></font></div></td>
      <td width="22" nowrap> <div align="center"><font class=blackfnt><strong>Pcs.</strong></font></div></td>
      <td width="23" nowrap> <div align="center"><font class=blackfnt><strong>Wt.</strong></font></div></td>
      <td width="29" nowrap> <div align="center"><font class=blackfnt><strong>Rate</strong></font></div></td>
      <td width="26" nowrap> <div align="center"><font class=blackfnt><strong>Frt</strong></font></div></td>
      <td width="22" nowrap> <div align="center"><font class=blackfnt><strong>D.C.</strong></font></div></td>
      <td width="28" nowrap> <div align="center"><font class=blackfnt><strong>Coll.<br>
          Chrg.</strong></font></div></td>
      <td width="28" nowrap> <div align="center"><font class=blackfnt><strong>DD. 
          <br>
          Chrg.</strong></font></div></td>
      <td width="28" nowrap> <div align="center"><font class=blackfnt><strong>FOV</strong></font></div></td>
      <td width="38" nowrap> <div align="center"><font class=blackfnt><strong>Other</strong></font></div></td>
      <td width="56" nowrap> <div align="center"><font class=blackfnt><strong>Amount</strong></font></div></td>
      --%>
                <td colspan="15" style="height: 268px">
                    <asp:GridView ID="GrdXLS2" OnRowDataBound="GrdXLS2_RowDataBound" PagerStyle-Mode="NumericPages"
                        CssClass="boxbg" PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey"
                        BackColor="white" runat="server" SelectedIndex="1" EmptyDataText="No Records Found For Docket Details ....!!">
                        <Columns>
                            <%-- <asp:TemplateField HeaderText="SR.NO.">
                    <HeaderStyle CssClass = "blackfnt" />
                        <ItemTemplate>
                        <asp:Label ID="lblsrno" CssClass="blackfnt" text ="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                        </ItemTemplate>
                        <ItemStyle CssClass="blackfnt" />
                  </asp:TemplateField> --%>
                            <asp:TemplateField>
                                <HeaderStyle CssClass="blackfnt" />
                                <HeaderTemplate>
                                    <asp:Label ID="lblheader" runat="server" CssClass="blackfnt" Text="Inv No."></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblinvoiceno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"dockno") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Docket No">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldockno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dockno") %>'></asp:Label>
                                    <asp:Label ID="lbldocksf" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"docksf") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Date">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldate" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dockdt") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="From">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblfrom" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"orgncd") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="To">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblto" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"reassign_destcd") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Md">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblmode" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"trn_mod") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Pcs.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblpcs" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"pkgsno") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Wt.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblchargewt" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"chrgwt") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Rate">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblrate" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"frt_rate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Frt">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblfreight" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"freight") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="D.C.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldc" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dktchg") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Coll. Chrg">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbldccharge" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dccharge") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DD. Chrg.">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblddcharge" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"ddcharge") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="FOV">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblfov" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"fov") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Other">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lblotchg" runat="server" CssClass="blackfnt" Text=""></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Amount">
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:Label ID="lbltotamt" runat="server" CssClass="blackfnt" Text=""></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Handling Charges">
                      <HeaderStyle CssClass = "blackfnt" />
                      <ItemTemplate>
                          <asp:Label ID="lblhldchrg" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"hld_chrg") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Critical State Charges">
                      <HeaderStyle CssClass = "blackfnt" />
                      <ItemTemplate>
                          <asp:Label ID="lblstatechrg" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"state_chrg") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Sunday/Holiday Delivery Charge">
                      <HeaderStyle CssClass = "blackfnt" />
                      <ItemTemplate>
                          <asp:Label ID="lblhlddlychrg" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"hld_dlychrg") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="N-Form Clearance Charge">
                      <HeaderStyle CssClass = "blackfnt" />
                      <ItemTemplate>
                           <asp:Label ID="lblnformchrg" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"nform_chrg") %>'></asp:Label>                          
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="To Pay Collection Charge">
                      <HeaderStyle CssClass = "blackfnt" />
                      <ItemTemplate>
                          <asp:Label ID="lblfodcharge" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"fodcharge") %>'></asp:Label>
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Diesel Charge">
                      <HeaderStyle CssClass = "blackfnt" />
                      <ItemTemplate>
                        <asp:Label ID="lbldieselcharge" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"diesel_chrg") %>'></asp:Label>                          
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="COD/DOD">
                      <HeaderStyle CssClass = "blackfnt" />
                      <ItemTemplate>
                        <asp:Label ID="lblcoddod" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"codchg") %>'></asp:Label>                                                    
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="S.Tax">
                      <HeaderStyle CssClass = "blackfnt" />
                      <ItemTemplate>
                        <asp:Label ID="lblsvctax" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"svctax") %>'></asp:Label>                                                    
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Cess">
                      <HeaderStyle CssClass = "blackfnt" />
                      <ItemTemplate>
                        <asp:Label ID="lblcess" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"cess") %>'></asp:Label>                                                    
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Total">
                      <HeaderStyle CssClass = "blackfnt" />
                      <ItemTemplate>
                        <asp:Label ID="lbldkttot" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"dkttot") %>'></asp:Label>                                                    
                      </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="remark">
                      <HeaderStyle CssClass = "blackfnt" />
                      <ItemTemplate>
                        <asp:Label ID="lblremark" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"spl_svc_req") %>'></asp:Label>                                                    
                      </ItemTemplate>
                  </asp:TemplateField>--%>
                        </Columns>
                        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td class="blackfnt" align="right" colspan="14" style="height: 31px">
                    <strong>Subtotal</strong></td>
                <td class="blackfnt" style="height: 31px">
                    <asp:Label ID="lblsubtotal" runat="server" Font-Bold="True"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="14" style="height: 31px">
                    <div align="right">
                        <font class="blackfnt"><strong>Service Tax @12%&nbsp;&nbsp;</strong></font></div>
                </td>
                <td style="height: 31px">
                    <div align="center">
                        &nbsp;<font class="blackfnt"><b><asp:Label ID="lblservicetax" runat="server"></asp:Label></b></font></div>
                </td>
            </tr>
            <tr>
                <td colspan="14">
                    <div align="right">
                        <font class="blackfnt"><strong>Cess @2% on service tax&nbsp;&nbsp;</strong></font></div>
                </td>
                <td>
                    <div align="center">
                        &nbsp;<font class="blackfnt"><b><asp:Label ID="lblcessontax" runat="server"></asp:Label></b></font></div>
                </td>
            </tr>
            <tr>
                <td colspan="14">
                    <div align="right">
                        <font class="blackfnt"><strong>Total&nbsp;&nbsp;</strong></font></div>
                </td>
                <td nowrap>
                    <div align="center">
                        &nbsp;<font class="blackfnt"><b><asp:Label ID="lbltotal" runat="server"></asp:Label></b></font></div>
                </td>
            </tr>
            <tr>
                <td colspan="14">
                    <div align="center">
                        <font class="blackfnt"><strong>Total&nbsp;
                            <asp:Label ID="lbltotalinword" runat="server"></asp:Label>
                        </strong></font>
                    </div>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="3">
                    <font class="blackfnt">Other Charges</font>
                </td>
                <td colspan="11">
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="4">
                    <div align="left">
                        <font class="blackfnt">Cod/Dod&nbsp;&nbsp;</font></div>
                </td>
                <td colspan="3">
                    <font class="blackfnt">
                        <asp:Label ID="lblcoddod" runat="server"></asp:Label></font></td>
                <td colspan="7">
                    &nbsp;</td>
                <td>
                    <div align="center">
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <div align="left">
                        <font class="blackfnt">Handl. Charges&nbsp;&nbsp;</font></div>
                </td>
                <td colspan="3">
                    <font class="blackfnt">
                        <asp:Label ID="lblhandlecharge" runat="server"></asp:Label></font></td>
                <td colspan="7">
                    &nbsp;</td>
                <td>
                    <div align="center">
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="4" style="height: 21px">
                    <div align="left">
                        <font class="blackfnt">Crit. St. Chrges&nbsp;&nbsp;</font></div>
                </td>
                <td colspan="3" style="height: 21px">
                    <font class="blackfnt">
                        <asp:Label ID="lblstatechrg" runat="server"></asp:Label></font></td>
                <td colspan="7" style="height: 21px">
                    &nbsp;</td>
                <td style="height: 21px">
                    <div align="center">
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <div align="left">
                        <font class="blackfnt">Sunday/Holi. Chg&nbsp;&nbsp;</font></div>
                </td>
                <td colspan="3">
                    <font class="blackfnt">
                        <asp:Label ID="lblholidaychrg" runat="server"></asp:Label></font></td>
                <td colspan="7">
                    &nbsp;</td>
                <td>
                    <div align="center">
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <div align="left">
                        <font class="blackfnt">'N' Form chrgs&nbsp;&nbsp;</font></div>
                </td>
                <td colspan="3">
                    <font class="blackfnt">
                        <asp:Label ID="lblnformcharge" runat="server"></asp:Label></font></td>
                <td colspan="7">
                    &nbsp;</td>
                <td>
                    <div align="center">
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <div align="left">
                        <font class="blackfnt">To pay Coll.&nbsp;&nbsp;</font></div>
                </td>
                <td colspan="3">
                    <font class="blackfnt">
                        <asp:Label ID="lblfodcharge" runat="server"></asp:Label></font></td>
                <td colspan="7">
                    &nbsp;</td>
                <td>
                    <div align="center">
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <div align="left">
                        <font class="blackfnt">Other&nbsp;&nbsp;</font></div>
                </td>
                <td colspan="3">
                    <font class="blackfnt">
                        <asp:Label ID="lblothercharge" runat="server"></asp:Label></font></td>
                <td colspan="7">
                    &nbsp;</td>
                <td>
                    <div align="center">
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="15">
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="15">
                    <font class="blackfnt">* T = Train , A = Air , R = Road Transport , E = Express </font>
                </td>
            </tr>
        </table>
      </td>
        </tr>
       </table>
    </div>
   <%-- </form>--%></asp:Content>
<%--</body>
</html>--%>
