<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DocketView_xls.aspx.cs" Inherits="GUI_Operation_Singlescreen_DocketPrint_DocketView_xls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<link href="../../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>
        <%=sdkt_call %>
        View</title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Panel runat="server" HorizontalAlign="Center" Style="width: 10in;">
            <%--***************************************************************************************************************
                                        PHASE ONE - DOCKET SUMMRY
***************************************************************************************************************--%>
            <br />
            <br />
            <asp:Table runat="server" CellSpacing="1" CssClass="boxbg" Style="width: 100%;">
                <asp:TableRow CssClass="bgbluegrey">
                    <asp:TableCell ColumnSpan="6" CssClass="blackfnt" Font-Bold="true" HorizontalAlign="Center"><%=sdkt_call %> Details</asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" Width="16%" HorizontalAlign="Left"><%=sdkt_call %> Number </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" Width="30%" HorizontalAlign="Left">
                        <asp:Label ID="lbldockno" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" Width="16%" HorizontalAlign="Left">Payment Type </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" Width="17%" HorizontalAlign="Left">
                        <asp:Label ID="lblpaybas" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" Width="11%" HorizontalAlign="Left">Origin </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" Width="10%" HorizontalAlign="Left">
                        <asp:Label ID="lblorgnloc" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left"><%=sdkt_call %> Date </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lbldocketdate" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Transport Mode</asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lbltransmode" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Destination </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lbldelloc" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Barcode </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left" ColumnSpan="2">
                        &nbsp;
                    <asp:Image ID="imgBC" runat="server" />
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left" ColumnSpan="2">Reassigned Delivery Location </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblreassigndelloc" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Volumetric </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblvolumetric" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Service Type </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblservicetype" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">FTL Type </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblftltype" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Pick/Up Delivery </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblpickupdel" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left"><%=sdkt_call %> Entry Date </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lbldocketentrydate" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">From </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblfromcity" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Local <%=sdkt_call %> </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lbllocaldocket" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">EDD </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lbledd" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">To </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lbltocity" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Billing Party </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblbillingparty" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left"> </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lbloadfasf" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left"> </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lbldcrperson" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Entry By </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblentryby" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Entry Date </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblentrydate" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left"> </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                       
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <br />
            <br />
            <%--***************************************************************************************************************
                                        PHASE TWO - PARTY DETAILS
***************************************************************************************************************--%>
            <asp:Table CellSpacing="1" runat="server" CssClass="boxbg" Style="width: 100%;">
                <asp:TableRow CssClass="bgbluegrey">
                    <asp:TableCell ColumnSpan="4" CssClass="blackfnt" Font-Bold="true" HorizontalAlign="Center">Party Details</asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" Width="15%" HorizontalAlign="Center"><strong>Consignor</strong></asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" Width="35%" HorizontalAlign="Left">&nbsp;</asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" Width="15%" HorizontalAlign="Center"><strong>Consignee</strong></asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" Width="35%" HorizontalAlign="Left">&nbsp;</asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Name </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblnorname" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Name </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblneename" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Address </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblnoradd" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Address </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblneeadd" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">City - Pincode</asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblnorpincode" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">City - Pincode</asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblneepincode" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Telephone </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblnortel" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Telephone </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblneetel" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Email </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblnoremail" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Email </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblneeemail" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell HorizontalAlign="Left">Mobile No </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Left">
                        <asp:Label ID="lblnormob" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Left">Mobile No </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Left">
                        <asp:Label ID="lblneemob" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <%--***************************************************************************************************************
                                        PHASE THREE - DOCUMENTATION DETAILS
***************************************************************************************************************--%>
            <br />
            <asp:Table runat="server" CssClass="boxbg" CellSpacing="1" Style="width: 100%;">
                <asp:TableRow CssClass="bgbluegrey">
                    <asp:TableCell ColumnSpan="6" CssClass="blackfnt" Font-Bold="true" HorizontalAlign="Center">Document Details</asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Risk Type </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblrisktype" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Policy Number </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblpolicyno" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Policy Date </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblpolicydate" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Modvat Enclosed </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblmodvatenclosed" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Modvat Covers </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblmodvatcovers" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Internal Covers </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblinternalcovers" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Customer Reference Number </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblcustomerreferenceno" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Private Mark </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblprivatemark" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">TP Number </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lbltpno" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <br />
            <%--***************************************************************************************************************
                                        PHASE FOUR - DOCUMENTATION DETAILS
***************************************************************************************************************--%>
            <br />
            <asp:GridView HorizontalAlign="Center" ID="grvdoc" runat="server" BorderWidth="0"
                CellSpacing="1" CellPadding="2" AllowSorting="true" AllowPaging="true" PageSize="10"
                PagerStyle-HorizontalAlign="left" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey"
                FooterStyle-CssClass="<%=boxbg%>" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..."
                OnPageIndexChanging="pgChange" OnSelectedIndexChanged="grvdoc_SelectedIndexChanged"
                Style="width: 100%;">
                <Columns>
                    <asp:BoundField DataField="stform" HeaderText="Name">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="stcstreq" HeaderStyle-CssClass="bgbluegrey" HeaderText="Required">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="stnm" HeaderText="Applicable in State">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="documentno" HeaderText="Enclosed Document Number">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                    </asp:BoundField>
                </Columns>
            </asp:GridView>
            <asp:Table ID="tbldocgrid" runat="server" CellSpacing="1" Style="width: 100%; display: none;">
                <asp:TableRow CssClass="bgbluegrey">
                    <asp:TableCell CssClass="blackfnt">Name</asp:TableCell>
                    <asp:TableCell CssClass="blackfnt">Required</asp:TableCell>
                    <asp:TableCell CssClass="blackfnt">Applicable in State</asp:TableCell>
                    <asp:TableCell CssClass="blackfnt">Enclosed Document Number</asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Style="height: 24px;" BackColor="white">
                    <asp:TableCell ColumnSpan="4" HorizontalAlign="Center" CssClass="redfnt">No Records Found......</asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <br />
            <br />
            <%--***************************************************************************************************************
                                        PHASE FIVE - PERMIT TRACKER
***************************************************************************************************************--%>
            <asp:Table CssClass="boxbg" runat="server" CellSpacing="1" Style="width: 100%;">
                <asp:TableRow CssClass="bgbluegrey">
                    <asp:TableCell ColumnSpan="6" CssClass="blackfnt" Font-Bold="true" HorizontalAlign="Center">Permit Tracker</asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Permit Applicable </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblpermitapplicable" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Permit Recieved At </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblpermitrecievedat" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Permit No. </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblpermitno" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Permit Date </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblpermitdate" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Permit Validity Date </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblpermitvaliditydate" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Permit Recieved Date </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblpermitrecieveddate" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <br />
            <br />
            <%--***************************************************************************************************************
                                        PHASE SIX - ((((((((((((((((( GRID ))))))))))))))))))
***************************************************************************************************************--%>
            <asp:Table CellSpacing="1" runat="server" CssClass="boxbg" Style="width: 100%;">
                <asp:TableRow CssClass="bgbluegrey">
                    <asp:TableCell CssClass="blackfnt" Font-Bold="true" HorizontalAlign="Center">Invoice Details</asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <asp:GridView HorizontalAlign="Center" ID="gvdocketdrill" BorderWidth="0" runat="server"
                CellSpacing="1" AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"
                CssClass="boxbg" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange" OnSelectedIndexChanged="gvdocketdrill_SelectedIndexChanged"
                Style="width: 100%;">
                <Columns>
                    <asp:TemplateField HeaderText="Sr.No.">
                        <HeaderStyle HorizontalAlign="Center" BackColor="white" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Right" />
                        <ItemTemplate>
                            <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="invno" HeaderText="Invoice Number">
                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="declval" HeaderText="Declared Value(Rs)">
                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="pkgsno" HeaderText="No. of Packages">
                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="actuwt" HeaderText="Actual Weight (Kg.)">
                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                    </asp:BoundField>
                </Columns>
            </asp:GridView>
            <asp:GridView HorizontalAlign="Center" ID="gvdocketdrill_cft" BorderWidth="0" runat="server"
                CellSpacing="1" AllowSorting="true" AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left"
                CssClass="=boxbg" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange" OnSelectedIndexChanged="gvdocketdrill_SelectedIndexChanged"
                Style="width: 100%;">
                <Columns>
                    <asp:TemplateField HeaderText="Sr.No.">
                        <HeaderStyle HorizontalAlign="Center" BackColor="white" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Right" />
                        <ItemTemplate>
                            <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="invno" HeaderText="Invoice Number">
                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="declval" HeaderText="Declared Value(Rs)">
                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="pkgsno" HeaderText="No. of Packages">
                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="actuwt" HeaderText="Actual Weight (Kg.)">
                        <HeaderStyle HorizontalAlign="Center" BackColor="White" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" BackColor="White" HorizontalAlign="Center" />
                    </asp:BoundField>
                </Columns>
            </asp:GridView>
            <asp:Table ID="tblinvoice" runat="server" CellSpacing="1" CssClass="boxbg" Style="width: 100%; display: none;">
                <asp:TableRow CssClass="bgbluegrey">
                    <asp:TableCell CssClass="blackfnt">Sr. No.</asp:TableCell>
                    <asp:TableCell CssClass="blackfnt">Invoice Number</asp:TableCell>
                    <asp:TableCell CssClass="blackfnt">Declared Value(Rs)</asp:TableCell>
                    <asp:TableCell CssClass="blackfnt">No. of Packages</asp:TableCell>
                    <asp:TableCell CssClass="blackfnt">Actual Weight (Kg)</asp:TableCell>
                </asp:TableRow>
                <asp:TableRow Style="height: 24px;" BackColor="white">
                    <asp:TableCell ColumnSpan="5" HorizontalAlign="Center" CssClass="redfnt">No Records Found......</asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <br />
            <br />
            <%--***************************************************************************************************************
                                        PHASE SEVEN - Consignment Details
***************************************************************************************************************--%>
            <asp:Table runat="server" CssClass="boxbg" CellSpacing="1" Style="width: 100%;">
                <asp:TableRow CssClass="bgbluegrey">
                    <asp:TableCell CssClass="blackfnt" ColumnSpan="4" Font-Bold="true" HorizontalAlign="Center">Consignment Details</asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Total No Packages </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lbltotalnoofpack" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Packaging Type </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblpackagingtype" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Total Actual Weight (Kg.) </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lbltotalactualweight" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Say to Contain (Product) </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblsaytocontain" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Charged Weight (Kg.) </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lblchargedweight" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Special Instructions </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblspecialinstruactions" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <br />
            <br />
            <%--***************************************************************************************************************
                                        PHASE EIGHT - PAYMENT DETAILS
***************************************************************************************************************--%>
            <asp:Table CssClass="boxbg" runat="server" CellSpacing="1" Style="width: 100%;">
                <asp:TableRow CssClass="bgbluegrey">
                    <asp:TableCell CssClass="blackfnt" ColumnSpan="6" Font-Bold="true" HorizontalAlign="Center">Payment Details</asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left" ColumnSpan="2">Service TAX Paid By </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left" Style="width: 15%">
                        <asp:Label ID="lblservicetaxpaidby" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left" ColumnSpan="2">Service Tax Reg. By </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left" Style="width: 15%">
                        <asp:Label ID="lblservicetaxregby" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <%--freight not known by or charges--%>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left" ColumnSpan="2">Freight Charges </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lblfreightcharge" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left" ColumnSpan="2">Freight Rate </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lblfreightrate" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left" ColumnSpan="2">Freight Rate Type</asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lblfreightratetype" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left" ColumnSpan="2">Billed At </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="lblbilledat" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow ID="trfov" runat="server" CssClass="bgwhite">
                    <asp:TableCell ColumnSpan="2" CssClass="blackfnt" HorizontalAlign="Left">FOV Charged</asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Right">
                        <asp:Label ID="lblfovcharged" CssClass="blackfnt" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell ColumnSpan="3"></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left" ColumnSpan="2">Discount </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lblDiscount" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left" ColumnSpan="2">Discount Type </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lblDisType" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow ID="trcoddod" runat="server" CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">COD/DOD Charged</asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Right">
                        <asp:Label ID="lblcoddodcharged" CssClass="blackfnt" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell ColumnSpan="2" CssClass="blackfnt" HorizontalAlign="Left">COD/DOD Amount to be collected</asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Right">
                        <asp:Label ID="lblcoddodamt" CssClass="blackfnt" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow ID="trdacc" runat="server" CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">DACC Charged</asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Right">
                        <asp:Label ID="lbldacccharged" CssClass="blackfnt" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell ColumnSpan="4"></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell ColumnSpan="6">
                        <%--***************************************************************************************************************
                                        PHASE NINE - NO LABEL
***************************************************************************************************************--%>
                        <asp:Table runat="server" ID="tblcharges" CssClass="boxbg" Visible="false" Style="width: 100%"
                            CellPadding="2" CellSpacing="1">
                        </asp:Table>
                        <asp:GridView HorizontalAlign="left" CellPadding="1" ID="grvcharges" runat="server"
                            BorderWidth="0" CellSpacing="1" AllowSorting="true" PagerStyle-HorizontalAlign="left"
                            ShowHeader="false" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey" FooterStyle-CssClass="<%=boxbg%>"
                            PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                            PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." OnRowDataBound="grvcharges_RowDataBound"
                            Style="width: 70%;">
                            <Columns>
                                <asp:TemplateField HeaderText="Required" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                    <ItemStyle BackColor="white" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:Label CssClass="blackfnt" ID="txtchargename1" Text='<%# DataBinder.Eval(Container.DataItem,"chargename1") %>'
                                            runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Applicable in State" HeaderStyle-CssClass="blackfnt"
                                    HeaderStyle-HorizontalAlign="Center">
                                    <ItemStyle BackColor="white" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblcharge1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"chargevalue1") %>'
                                            CssClass="blackfnt"></asp:Label>
                                        <asp:Label ID="lbloperator1" runat="server" CssClass="bluefnt" Font-Bold="true"></asp:Label>
                                        <asp:HiddenField ID="hdnchargecode1" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"chargecode1") %>' />
                                        <asp:HiddenField ID="hdnactiveflag1" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"activeflag1") %>' />
                                        <asp:HiddenField ID="hdnchargevalue1" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"chargevalue1") %>' />
                                        <asp:HiddenField ID="hdnoperator1" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"operator1") %>' />
                                        <asp:HiddenField ID="hdnoperator2" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"operator2") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Required" HeaderStyle-CssClass="blackfnt" HeaderStyle-HorizontalAlign="Center">
                                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Left" />
                                    <ItemTemplate>
                                        <asp:Label CssClass="blackfnt" ID="txtchargename2" Text='<%# DataBinder.Eval(Container.DataItem,"chargename2") %>'
                                            runat="server"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Applicable in State" HeaderStyle-CssClass="blackfnt"
                                    HeaderStyle-HorizontalAlign="Center">
                                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblcharge2" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval(Container.DataItem,"chargevalue2") %>'></asp:Label>
                                        <asp:Label ID="lbloperator2" runat="server" CssClass="bluefnt" Font-Bold="true"></asp:Label>
                                        <asp:HiddenField ID="hdnchargecode2" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"chargecode2") %>' />
                                        <asp:HiddenField ID="hdnactiveflag2" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"activeflag2") %>' />
                                        <asp:HiddenField ID="hdnchargevalue2" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"chargevalue2") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </asp:TableCell>
                </asp:TableRow>
                <%--PARENT TALBE--%>
                <%--GST Detail--%>
                <asp:TableRow CssClass="nrow" ID="gstpayment" runat="server">
                    <asp:TableCell>GST Payment State </asp:TableCell>
                    <asp:TableCell>
                        <asp:Label ID="gststate" CssClass="nfnt" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>Product</asp:TableCell>
                    <asp:TableCell>
                        <asp:Label ID="gstproduct" CssClass="nfnt" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>GSTIN </asp:TableCell>
                    <asp:TableCell>
                        <asp:Label ID="gstin" CssClass="nfnt" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="nrow" ID="gstcategory" runat="server">
                    <asp:TableCell>SAC Category </asp:TableCell>
                    <asp:TableCell ColumnSpan="5">
                        <asp:Label ID="saccategory" CssClass="nfnt" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="nrow" ID="gstservicetype" runat="server">
                    <asp:TableCell>Service Type </asp:TableCell>
                    <asp:TableCell ColumnSpan="5">
                        <asp:Label ID="servicetype" CssClass="nfnt" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <%--GST Detail End--%>

                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left"> </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="Label79" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left"> </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">
                        <asp:Label ID="Label80" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left"><strong>SUB TOTAL</strong></asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lblsubtotal" Font-Bold="true" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite" ID="servicetax" runat="server">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Service Tax Rate (%) </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lblservicetaxrate" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Service Tax on Sub Total </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lblservicetaxonsubtotal" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Service Tax Collected </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lblservicetax" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite" ID="educationtax" runat="server">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Education Cess (%) </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lbleducessrate" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Education Cess on Service Tax </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lbleducessonsubtotal" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Education Cess - Collected </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lbleducess" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite" ID="highereducationtax" runat="server">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Higher Education Cess(%) </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lblheducessrate" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Higher Education Cess on Service Tax </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lblheducessonsubtotal" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">Higher Education Cess - Collected </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lblheducess" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite" ID="cesstax" runat="server">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">SB Cess(%) </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lblSbcRate" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">SB Cess on Sub Total </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lblsbcessonsubtotal" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">SB Cess - Collected </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lblSBCess" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite" ID="kkcesstax" runat="server">
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">KK Cess(%) </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lblKKRate" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">KK Cess on Sub Total </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lblkkcessonsubtotal" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="Left">KK Cess - Collected </asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" HorizontalAlign="right">
                        <asp:Label ID="lblKKCess" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>

                <%--GST Rate--%>
                <asp:TableRow CssClass="nrow" ID="gstcharges" runat="server">
                    <asp:TableCell>GST Rate</asp:TableCell>
                    <asp:TableCell HorizontalAlign="right">
                        <asp:Label ID="gstrate" CssClass="nfnt" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>GST Calculated Amount</asp:TableCell>
                    <asp:TableCell HorizontalAlign="right">
                        <asp:Label ID="gstamount" CssClass="nfnt" runat="server"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell>GST Charged </asp:TableCell>
                    <asp:TableCell HorizontalAlign="right">
                        <asp:Label ID="gstcharge" CssClass="nfnt" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>

                <%--GST RATE END--%>
                <asp:TableRow CssClass="nrow">
                    <asp:TableCell></asp:TableCell>
                    <asp:TableCell HorizontalAlign="right">
                        
                    </asp:TableCell>
                    <asp:TableCell ColumnSpan="2">
                       
                    </asp:TableCell>
                    <asp:TableCell><strong><%=sdkt_call %> TOTAL</strong></asp:TableCell>
                    <asp:TableCell HorizontalAlign="right">
                        <asp:Label ID="lbldockettotal" CssClass="nfnt" Font-Bold="true" runat="server"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <asp:HiddenField ID="hdnTransMode" runat="server" />
        </asp:Panel>
    </form>
</body>
</html>
